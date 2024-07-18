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
	

    @RequestMapping("/memo") //memo view
    public String memoView(HttpSession session, Model model) {
        System.out.println("memoView()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("�α��� �� ��� ������? " + userno);
        System.out.println("�����ڵ� ������? " + deptno);
        if (userno != null && deptno != null) {
            command = new MemoViewCommand(userno, deptno);
            command.execute(model);
        } else {
            System.out.println("User number or dept number not found in session.");
        }

        return "memo";
    }
	
    @RequestMapping("/notice") //notice view
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
    
	@RequestMapping("/noticeform") //notice form
	public String noticeForm() {
		return "noticeForm";
	}
	
	@RequestMapping("/noticeWrite") // notice write action
	public String noticeWrite(HttpServletRequest request, Model model) {
		System.out.println("noticeWrite()");
		model.addAttribute("request", request);
		command = new noticeWriteCommand();
		command.execute(model);
		return "redirect:notice";
	}
}
