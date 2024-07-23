package kb.keyboard.warrior.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.NoticeDTO;
import kb.keyboard.warrior.dto.ScheduleDTO;
import kb.keyboard.warrior.dto.TodoListDTO;
import kb.keyboard.warrior.memo.command.MemoCommand;
import kb.keyboard.warrior.memo.command.MemoViewCommand;
import kb.keyboard.warrior.memo.command.TodoViewCommand;
import kb.keyboard.warrior.memo.command.deptmemoDeleteCommand;
import kb.keyboard.warrior.memo.command.deptmemoWriteCommand;
import kb.keyboard.warrior.memo.command.mymemoDeleteCommand;
import kb.keyboard.warrior.memo.command.mymemoWriteCommand;
import kb.keyboard.warrior.memo.command.noticeDeleteCommand;
import kb.keyboard.warrior.memo.command.noticeViewCommand;
import kb.keyboard.warrior.memo.command.noticeWriteCommand;
import kb.keyboard.warrior.memo.command.todoStatusCommand;
import kb.keyboard.warrior.memo.command.todoWriteCommand;
import kb.keyboard.warrior.util.Constant;

@Controller
public class MemoController {

	MemoCommand command = null;
	private SqlSession sqlSession;

	@Autowired
	public MemoController(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		Constant.sqlSession = this.sqlSession;
	}

	@RequestMapping("/calendar")
	public String calendar(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String userno = (String) session.getAttribute("userno");

		ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
		List<ScheduleDTO> scheduleList = dao.scheduleLoad(userno);

		model.addAttribute("scheduleList", scheduleList);

		return "memo/calendar";
	}

	@RequestMapping(value = "/calendarsave", method = RequestMethod.POST)
	@ResponseBody
	public String saveEvent(HttpServletRequest request, Model model, ScheduleDTO dto) {

		HttpSession session = request.getSession();
		String userno = (String) session.getAttribute("userno");

		dto.setUserno(userno);
		dto.setStatus("1");

		ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);

		dao.scheduleNew(dto);

		return "redirect:/memo/calendar";
	}

	@RequestMapping(value = "/calendaredit", method = RequestMethod.POST)
	@ResponseBody
	public String editEvent(@RequestBody ScheduleDTO dto) {
		ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
		dao.scheduleEdit(dto);
		return "redirect:/memo/calendar";
	}

	@RequestMapping(value = "/calendardelete", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvent(@RequestParam String scheduleid) {
		ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
		dao.scheduleDelete(scheduleid);
		return "redirect:/memo/calendar";
	}

	@RequestMapping("/todo") // todolist view
	public String todoView(HttpSession session, Model model) {
		System.out.println("todoView()");

		String userno = (String) session.getAttribute("userno");
		if (userno != null) {
			command = new TodoViewCommand(userno);
			command.execute(model);
		} else {
			System.out.println("User number not found in session.");
		}

		return "todo";
	}
	
	//home todolist check
	@RequestMapping(value = "/todolistCheck",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST ) // , method=RequestMethod.POST // consumes = "application/json"	/*	*/
	public @ResponseBody String findPw(@RequestBody TodoListDTO todoListDto) throws Exception {
		
		String todoId = todoListDto.getTodoid();
		String isDone = todoListDto.getIsdone();
		//테스트
		System.out.println(todoId);
		System.out.println(isDone);
		
		ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
		
		if (isDone.equals("1")) {
			//완료처리
			todoDao.checkTodo(todoId);
		} else {
			todoDao.unCheckTodo(todoId);
		}

		return "{\"status\":\"success\"}";
	}

	

	@RequestMapping("/memo") // memo view 재욱오빠랑 바꾼거
	public String memoView(HttpSession session, Model model) {
		System.out.println("memoView()");

		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		System.out.println("로그인 된 사람 누구야? " + userno);
		System.out.println("부점코드 누구야? " + deptno);
		if (userno != null && deptno != null) {
			MemoViewCommand command = new MemoViewCommand();
			command.execute(model, userno, deptno);
		} else {
			System.out.println("User number or dept number not found in session.");
		}

		return "memo";
	}

	@RequestMapping("/notice") // notice view
	public String noticeView(HttpSession session, Model model) {
		System.out.println("noticeView()");

		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		System.out.println("로그인 된 사람 누구야? " + userno);
		System.out.println("부점코드 누구야? " + deptno);
		if (userno != null && deptno != null) {
			command = new noticeViewCommand(userno, deptno);
			command.execute(model);
		} else {
			System.out.println("User number or dept number not found in session.");
		}

		return "notice";
	}

	@RequestMapping("/noticeform") // notice form
	public String noticeForm() {
		return "noticeForm";
	}

	@RequestMapping("/noticeWrite") // notice write action
	public String noticeWrite(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("noticeWrite()");

		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		System.out.println("공지사항 액션 로그인 된 사람 누구야? " + userno);
		System.out.println("공지사항 액션 부점코드 누구야? " + deptno);
		model.addAttribute("request", request);
		model.addAttribute("userno", userno);
		model.addAttribute("deptno", deptno);
		if (userno != null && deptno != null) {
			command = new noticeWriteCommand();
			command.execute(model);
		} else {
			System.out.println("User number or dept number not found in session.");
		}
		return "redirect:notice";
	}

	@RequestMapping("/noticeDelete")
	public String noticeDelete(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("noticeDelete()");

		String userno = (String) session.getAttribute("userno"); //세션에서 꺼내와.
		System.out.println("공지사항 삭제 로그인 된 사람 누구야? " + userno); //세션확인
		model.addAttribute("request", request); //리퀘스트로 담아온 인덱스넘버랑 유저 모델에 넣어.
		System.out.println("리퀘스트 안에 뭐있어? " + model);

		if (userno != null) {
			noticeDeleteCommand command = new noticeDeleteCommand();
			command.execute(model,userno);
		} else {
			System.out.println("User number number not found in session.");
		}
		return "redirect:notice";
	}
	
	@RequestMapping("/mymemoWrite") // mymemo write action
	public String mymemoWrite(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("mymemoWrite()");

		String userno = (String) session.getAttribute("userno");
		System.out.println("나의메모 액션 로그인 된 사람 누구야? " + userno);
		model.addAttribute("request", request);
		model.addAttribute("userno", userno);
		if (userno != null) {
			command = new mymemoWriteCommand();
			command.execute(model);
		} else {
			System.out.println("User number number not found in session.");
		}
		return "redirect:memo";
	}
	
	@RequestMapping("/deptmemoWrite") // deptmemo write action
	public String deptmemoWrite(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("deptmemoWrite()");

		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		System.out.println("부점메모 액션 로그인 된 사람 누구야? " + userno);
		System.out.println("부점메모 액션 부점은 어디야? " + deptno);
		model.addAttribute("request", request);
		model.addAttribute("userno", userno);
		model.addAttribute("deptno", deptno);
		if (userno != null && deptno != null) {
			command = new deptmemoWriteCommand();
			command.execute(model);
		} else {
			System.out.println("User number or dept number not found in session.");
		}
		return "redirect:memo";
	}
	
	@RequestMapping("/mymemoDelete")
	public String mymemoDelete(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("mymemoDelete()");

		String userno = (String) session.getAttribute("userno"); //세션에서 꺼내와.
		System.out.println("나의 메모 삭제 로그인 된 사람 누구야? " + userno); //세션확인
		model.addAttribute("request", request); //리퀘스트로 담아온 인덱스넘버랑 유저 모델에 넣어.

		if (userno != null) {
			mymemoDeleteCommand command = new mymemoDeleteCommand();
			command.execute(model,userno);
		} else {
			System.out.println("User number not found in session.");
		}
		return "redirect:memo";
	}
	
	@RequestMapping("/deptmemoDelete")
	public String deptmemoDelete(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("deptmemoDelete()");

		String deptno = (String) session.getAttribute("deptno"); //세션에서 꺼내와.
		System.out.println("부점 메모 삭제 어디부점이야? " + deptno); //세션확인
		model.addAttribute("request", request); //리퀘스트로 담아온 인덱스넘버랑 부서번호 모델에 넣어.

		if (deptno != null) {
			deptmemoDeleteCommand command = new deptmemoDeleteCommand();
			command.execute(model,deptno);
		} else {
			System.out.println("Dept number not found in session.");
		}
		return "redirect:memo";
	}
	
	@RequestMapping("/todoWrite") // todo write action
	public String todoWrite(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("todoWrite()");

		String userno = (String) session.getAttribute("userno");
		System.out.println("todo 액션 로그인 된 사람 누구야? " + userno);
		model.addAttribute("request", request);
		model.addAttribute("userno", userno);
		if (userno != null) {
			command = new todoWriteCommand();
			command.execute(model);
		} else {
			System.out.println("User number number not found in session.");
		}
		return "redirect:todo";
	}
	
	@RequestMapping("/todoStatus") // todo status
	public String todoStatus(HttpSession session, HttpServletRequest request, Model model) {
		System.out.println("todoStatus()");

		String userno = (String) session.getAttribute("userno");
		System.out.println("todo 상태변경 로그인 된 사람 누구야? " + userno);
		model.addAttribute("request", request);
		
		if (userno != null) {
			todoStatusCommand command = new todoStatusCommand();
			command.execute(model,userno);
		} else {
			System.out.println("User number not found in session.");
		}
		return "redirect:todo";
	}
	
	@RequestMapping(value = "/updateNoticePosition", method = RequestMethod.POST)
    @ResponseBody
    public String updateNoticePosition(@RequestBody NoticeDTO noticeDTO) {
		System.out.println("이동이동");
		System.out.println(noticeDTO.getPositionX());
		System.out.println(noticeDTO.getPositionY());
		System.out.println(noticeDTO.getNoticeid());
        // MemoDao 인터페이스를 통해 SQL 세션을 얻음
        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
        
        // 공지사항의 위치를 업데이트하는 메서드 호출
        memoDao.updateNoticePosition(noticeDTO);

        // JSON 형식의 응답을 반환
        return "{\"status\":\"success\"}";
    }
	
}
