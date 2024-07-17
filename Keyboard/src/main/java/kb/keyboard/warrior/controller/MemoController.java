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
import kb.keyboard.warrior.memo.command.TodoViewCommand;
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
        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        String userno = (String) session.getAttribute("userno");

        // eventData에 사용자 정보 추가
        dto.setUserno(userno);
        dto.setStatus("1");

        // dao 부르기 위해 getMapper 넣음 
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        
        // 일정 저장
        dao.scheduleNew(dto);

        return "일정이 성공적으로 저장되었습니다.";
    }
	
    @RequestMapping(value = "/calendaredit", method = RequestMethod.POST) 
    @ResponseBody
    public String editEvent(@RequestBody ScheduleDTO dto) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        dao.scheduleEdit(dto);
        return "일정이 성공적으로 수정되었습니다.";
    }
    
    @RequestMapping(value = "/calendardelete", method = RequestMethod.POST) 
    @ResponseBody
    public String deleteEvent(@RequestParam String scheduleid) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        dao.scheduleDelete(scheduleid);
        return "일정이 성공적으로 삭제되었습니다.";
    }
	
	@RequestMapping("/todo") // todolist view
	public String todoView(Model model) {
		System.out.println("todoView()");
		command = new TodoViewCommand();
		command.execute(model);
		return "todo";
	}
	
//	@RequestMapping("/memo")
//	public String memo(HttpServletRequest request, Model model) {
//		System.out.println("�޸�â ����");
//		
//		return "memo/memo";
//	}
	
//	@RequestMapping("/notice")
//	public String notice(HttpServletRequest request, Model model) {
//		System.out.println("���� ����");
//		
//		return "memo/notice";
//	}
//	

}
