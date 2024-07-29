package kb.keyboard.warrior.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    private static final Logger logger = LoggerFactory.getLogger(MemoController.class);

    @RequestMapping(value = "/calendarData", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Map<String, Object>> calendarData(HttpSession session) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String userno = (String) session.getAttribute("userno");
        List<ScheduleDTO> scheduleList = dao.scheduleLoad(userno);

        List<Map<String, Object>> events = new ArrayList<Map<String, Object>>();
        for (ScheduleDTO schedule : scheduleList) {
            Map<String, Object> event = new HashMap<String, Object>();
            event.put("id", schedule.getScheduleid());
            event.put("title", schedule.getTitle());
            event.put("start", schedule.getStartDate().toString());
            event.put("end", schedule.getEndDate().toString());

            Map<String, Object> extendedProps = new HashMap<String, Object>();
            extendedProps.put("content", schedule.getContent());
            extendedProps.put("shareto", schedule.getShareto());
            extendedProps.put("sharecolor", schedule.getSharecolor());
            event.put("extendedProps", extendedProps);

            events.add(event);
        }

        return events;
    }

    @RequestMapping("/calendar")
    public String showCalendar(HttpSession session, Model model) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String userno = (String) session.getAttribute("userno");
        List<ScheduleDTO> scheduleList = dao.scheduleLoad(userno);
        model.addAttribute("scheduleList", scheduleList);

        return "memo/calendar";
    }

    @RequestMapping(value = "/calendarsave", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> saveEvent(HttpServletRequest request, @RequestBody ScheduleDTO dto) {
        HttpSession session = request.getSession();
        String userno = (String) session.getAttribute("userno");
        if (userno == null) {
            return new ResponseEntity<String>("User not logged in", HttpStatus.UNAUTHORIZED);
        }
        dto.setUserno(userno);
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        try {
            dao.scheduleNew(dto);
            return new ResponseEntity<String>("Event saved successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<String>("Error saving event", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/calendaredit", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> editEvent(@RequestBody ScheduleDTO dto) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        try {
            int result = dao.scheduleEdit(dto);
            if (result > 0) {
                return new ResponseEntity<String>("Event edited successfully", HttpStatus.OK);
            } else {
                return new ResponseEntity<String>("No events were updated", HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            logger.error("Error editing event", e);
            return new ResponseEntity<String>("Error editing event", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/calendardelete", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> deleteEvent(@RequestParam String scheduleid) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        try {
            dao.scheduleDelete(scheduleid);
            return new ResponseEntity<String>("Event deleted successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<String>("Error deleting event", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping("/todo")
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

    @RequestMapping(value = "/todolistCheck", produces = "application/json", consumes = "application/json", method = RequestMethod.POST)
    public @ResponseBody String findPw(@RequestBody TodoListDTO todoListDto) throws Exception {

        String todoId = todoListDto.getTodoid();
        String isDone = todoListDto.getIsdone();
        // 泥댄겕諛뺤뒪 �긽�깭異쒕젰
        System.out.println(todoId);
        System.out.println(isDone);

        ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);

        if (isDone.equals("1")) {
            // �븷�씪 �셿猷뚯쿂由�
            todoDao.checkTodo(todoId);
        } else {
            todoDao.unCheckTodo(todoId);
        }

        return "{\"status\":\"success\"}";
    }

    @RequestMapping("/memo")
    public String memoView(HttpSession session, Model model) {
        System.out.println("memoView()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("硫붾え酉�: �쑀�� 踰덊샇: " + userno);
        System.out.println("硫붾え酉�: 遺��꽌 踰덊샇: " + deptno);
        if (userno != null && deptno != null) {
            MemoViewCommand command = new MemoViewCommand();
            command.execute(model, userno, deptno);
        } else {
            System.out.println("User number or dept number not found in session.");
        }

        return "memo";
    }

    @RequestMapping("/notice")
    public String noticeView(HttpSession session, Model model) {
        System.out.println("noticeView()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("怨듭��궗�빆 酉�: �쑀�� 踰덊샇: " + userno);
        System.out.println("怨듭��궗�빆 酉�: 遺��꽌 踰덊샇: " + deptno);
        if (userno != null && deptno != null) {
            command = new noticeViewCommand(userno, deptno);
            command.execute(model);
        } else {
            System.out.println("User number or dept number not found in session.");
        }

        return "notice";
    }

    @RequestMapping("/noticeform")
    public String noticeForm() {
        return "noticeForm";
    }

    @RequestMapping("/noticeWrite")
    public String noticeWrite(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("noticeWrite()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("怨듭��궗�빆 �옉�꽦: �쑀�� 踰덊샇: " + userno);
        System.out.println("怨듭��궗�빆 �옉�꽦: 遺��꽌 踰덊샇: " + deptno);
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

        String userno = (String) session.getAttribute("userno");
        System.out.println("怨듭��궗�빆 �궘�젣: �쑀�� 踰덊샇: " + userno);
        model.addAttribute("request", request);
        if (userno != null) {
            noticeDeleteCommand command = new noticeDeleteCommand();
            command.execute(model, userno);
        } else {
            System.out.println("User number not found in session.");
        }
        return "redirect:notice";
    }

    @RequestMapping("/mymemoWrite")
    public String mymemoWrite(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("mymemoWrite()");

        String userno = (String) session.getAttribute("userno");
        System.out.println("留덉씠硫붾え �옉�꽦: " + userno);
        model.addAttribute("request", request);
        model.addAttribute("userno", userno);
        if (userno != null) {
            command = new mymemoWriteCommand();
            command.execute(model);
        } else {
            System.out.println("User number not found in session.");
        }
        return "redirect:memo";
    }

    @RequestMapping("/deptmemoWrite")
    public String deptmemoWrite(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("deptmemoWrite()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("遺��꽌硫붾え �옉�꽦: �쑀�� 踰덊샇: " + userno);
        System.out.println("遺��꽌硫붾え �옉�꽦: 遺��꽌 踰덊샇: " + deptno);
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

        String userno = (String) session.getAttribute("userno");
        System.out.println("留덉씠硫붾え �궘�젣: �쑀�� 踰덊샇: " + userno);
        model.addAttribute("request", request);

        if (userno != null) {
            mymemoDeleteCommand command = new mymemoDeleteCommand();
            command.execute(model, userno);
        } else {
            System.out.println("User number not found in session.");
        }
        return "redirect:memo";
    }

    @RequestMapping("/deptmemoDelete")
    public String deptmemoDelete(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("deptmemoDelete()");

        String deptno = (String) session.getAttribute("deptno");
        System.out.println("遺��꽌硫붾え �궘�젣: 遺��꽌 踰덊샇: " + deptno);
        model.addAttribute("request", request);

        if (deptno != null) {
            deptmemoDeleteCommand command = new deptmemoDeleteCommand();
            command.execute(model, deptno);
        } else {
            System.out.println("Dept number not found in session.");
        }
        return "redirect:memo";
    }

    @RequestMapping("/todoWrite")
    public String todoWrite(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("todoWrite()");

        String userno = (String) session.getAttribute("userno");
        System.out.println("todo �옉�꽦: �쑀�� 踰덊샇: " + userno);
        model.addAttribute("request", request);
        if (userno != null) {
        	todoWriteCommand command = new todoWriteCommand();
            command.execute(model,userno);
        } else {
            System.out.println("User number not found in session.");
        }
        return "redirect:/todo";
    }

    @RequestMapping("/todoStatus")
    public String todoStatus(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("todoStatus()");

        String userno = (String) session.getAttribute("userno");
        System.out.println("todo �긽�깭: �쑀�� 踰덊샇: " + userno);
        model.addAttribute("request", request);

        if (userno != null) {
            todoStatusCommand command = new todoStatusCommand();
            command.execute(model, userno);
        } else {
            System.out.println("User number not found in session.");
        }
        return "redirect:todo";
    }

    @RequestMapping(value = "/updateNoticePosition", method = RequestMethod.POST)
    @ResponseBody
    public String updateNoticePosition(@RequestBody NoticeDTO noticeDTO) {
        System.out.println("怨듭� �쐞移� �뾽�뜲�씠�듃");
        System.out.println(noticeDTO.getPositionX());
        System.out.println(noticeDTO.getPositionY());
        System.out.println(noticeDTO.getNoticeid());
        System.out.println(noticeDTO.getZindex());
        // MemoDao瑜� �넻�빐 SQL �떎�뻾
        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);

        // 怨듭� �쐞移� �뾽�뜲�씠�듃
        memoDao.updateNoticePosition(noticeDTO);

        // JSON �삎�깭濡� �쓳�떟 諛섑솚
        return "{\"status\":\"success\"}";
    }
    
    
    @RequestMapping(value = "/getMaxZindex", method = RequestMethod.GET)
    public void getMaxZindex(HttpServletResponse response) {
        try {
            int maxZindex = sqlSession.getMapper(MemoDao.class).getMaxZindex();
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(String.valueOf(maxZindex));
        } catch (Exception e) {
            logger.error("Error retrieving max z-index", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
