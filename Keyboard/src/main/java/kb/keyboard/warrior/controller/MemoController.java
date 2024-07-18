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

import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dto.ScheduleDTO;
import kb.keyboard.warrior.memo.command.MemoCommand;
import kb.keyboard.warrior.memo.command.MemoViewCommand;
import kb.keyboard.warrior.memo.command.TodoViewCommand;
import kb.keyboard.warrior.memo.command.deptmemoWriteCommand;
import kb.keyboard.warrior.memo.command.mymemoWriteCommand;
import kb.keyboard.warrior.memo.command.noticeDeleteCommand;
import kb.keyboard.warrior.memo.command.noticeViewCommand;
import kb.keyboard.warrior.memo.command.noticeWriteCommand;
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

	@RequestMapping("/memo") // memo view �������� �ٲ۰�
	public String memoView(HttpSession session, Model model) {
		System.out.println("memoView()");

		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		System.out.println("�α��� �� ��� ������? " + userno);
		System.out.println("�����ڵ� ������? " + deptno);
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
		System.out.println("�α��� �� ��� ������? " + userno);
		System.out.println("�����ڵ� ������? " + deptno);
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
		System.out.println("�������� �׼� �α��� �� ��� ������? " + userno);
		System.out.println("�������� �׼� �����ڵ� ������? " + deptno);
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

		String userno = (String) session.getAttribute("userno"); //���ǿ��� ������.
		System.out.println("�������� ���� �α��� �� ��� ������? " + userno); //����Ȯ��
		model.addAttribute("request", request); //������Ʈ�� ��ƿ� �ε����ѹ��� ���� �𵨿� �־�.
		System.out.println("������Ʈ �ȿ� ���־�? " + model);

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
		System.out.println("���Ǹ޸� �׼� �α��� �� ��� ������? " + userno);
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
		System.out.println("�����޸� �׼� �α��� �� ��� ������? " + userno);
		System.out.println("�����޸� �׼� ������ ����? " + deptno);
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
}
