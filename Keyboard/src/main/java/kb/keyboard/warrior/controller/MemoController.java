package kb.keyboard.warrior.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
//	
//
//	@RequestMapping(value = "/calendarsave", method = RequestMethod.POST)
//	@ResponseBody
//	public String saveEvent(HttpServletRequest request, Model model, ScheduleDTO dto) {
//
//		HttpSession session = request.getSession();
//		String userno = (String) session.getAttribute("userno");
//
//		dto.setUserno(userno);
//		ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
//		dao.scheduleNew(dto);
//
//		return "redirect:/memo/calendar";
//	}

    @RequestMapping(value = "/calendaredit", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> editEvent(@RequestBody ScheduleDTO dto) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        try {
            int result = dao.scheduleEdit(dto);
            // dao.scheduleEdit(dto);
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
		//í…ŒìŠ¤íŠ¸
		System.out.println(todoId);
		System.out.println(isDone);
		
		ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
		
		if (isDone.equals("1")) {
			//ì™„ë£Œì²˜ë¦¬
			todoDao.checkTodo(todoId);
		} else {
			todoDao.unCheckTodo(todoId);
		}

		return "{\"status\":\"success\"}";
	}

	

	@RequestMapping("/memo") // memo view ìž¬ìš±ì˜¤ë¹ ëž‘ ë°”ê¾¼ê±°
	public String memoView(HttpSession session, Model model) {
		System.out.println("memoView()");

		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		System.out.println("ë¡œê·¸ì¸ ëœ ì‚¬ëžŒ ëˆ„êµ¬ì•¼? " + userno);
		System.out.println("ë¶€ì ì½”ë“œ ëˆ„êµ¬ì•¼? " + deptno);
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
		System.out.println("ë¡œê·¸ì¸ ëœ ì‚¬ëžŒ ëˆ„êµ¬ì•¼? " + userno);
		System.out.println("ë¶€ì ì½”ë“œ ëˆ„êµ¬ì•¼? " + deptno);
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
		System.out.println("ê³µì§€ì‚¬í•­ ì•¡ì…˜ ë¡œê·¸ì¸ ëœ ì‚¬ëžŒ ëˆ„êµ¬ì•¼? " + userno);
		System.out.println("ê³µì§€ì‚¬í•­ ì•¡ì…˜ ë¶€ì ì½”ë“œ ëˆ„êµ¬ì•¼? " + deptno);
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

		String userno = (String) session.getAttribute("userno"); //ì„¸ì…˜ì—ì„œ êº¼ë‚´ì™€.
		System.out.println("ê³µì§€ì‚¬í•­ ì‚­ì œ ë¡œê·¸ì¸ ëœ ì‚¬ëžŒ ëˆ„êµ¬ì•¼? " + userno); //ì„¸ì…˜í™•ì¸
		model.addAttribute("request", request); //ë¦¬í€˜ìŠ¤íŠ¸ë¡œ ë‹´ì•„ì˜¨ ì¸ë±ìŠ¤ë„˜ë²„ëž‘ ìœ ì € ëª¨ë¸ì— ë„£ì–´.
		System.out.println("ë¦¬í€˜ìŠ¤íŠ¸ ì•ˆì— ë­ìžˆì–´? " + model);

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
		System.out.println("³ªÀÇ¸Þ¸ð ¾×¼Ç ·Î±×ÀÎ µÈ »ç¶÷ ´©±¸¾ß? " + userno);
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
		System.out.println("ºÎÁ¡¸Þ¸ð ¾×¼Ç ·Î±×ÀÎ µÈ »ç¶÷ ´©±¸¾ß? " + userno);
		System.out.println("ºÎÁ¡¸Þ¸ð ¾×¼Ç ºÎÁ¡Àº ¾îµð¾ß? " + deptno);
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

		String userno = (String) session.getAttribute("userno"); //¼¼¼Ç¿¡¼­ ²¨³»¿Í.
		System.out.println("³ªÀÇ ¸Þ¸ð »èÁ¦ ·Î±×ÀÎ µÈ »ç¶÷ ´©±¸¾ß? " + userno); //¼¼¼ÇÈ®ÀÎ
		model.addAttribute("request", request); //¸®Äù½ºÆ®·Î ´ã¾Æ¿Â ÀÎµ¦½º³Ñ¹ö¶û À¯Àú ¸ðµ¨¿¡ ³Ö¾î.

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

		String deptno = (String) session.getAttribute("deptno"); //¼¼¼Ç¿¡¼­ ²¨³»¿Í.
		System.out.println("ºÎÁ¡ ¸Þ¸ð »èÁ¦ ¾îµðºÎÁ¡ÀÌ¾ß? " + deptno); //¼¼¼ÇÈ®ÀÎ
		model.addAttribute("request", request); //¸®Äù½ºÆ®·Î ´ã¾Æ¿Â ÀÎµ¦½º³Ñ¹ö¶û ºÎ¼­¹øÈ£ ¸ðµ¨¿¡ ³Ö¾î.

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
		System.out.println("todo ¾×¼Ç ·Î±×ÀÎ µÈ »ç¶÷ ´©±¸¾ß? " + userno);
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
		System.out.println("todo »óÅÂº¯°æ ·Î±×ÀÎ µÈ »ç¶÷ ´©±¸¾ß? " + userno);
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
		System.out.println("ÀÌµ¿ÀÌµ¿");
		System.out.println(noticeDTO.getPositionX());
		System.out.println(noticeDTO.getPositionY());
		System.out.println(noticeDTO.getNoticeid());
        // MemoDao ÀÎÅÍÆäÀÌ½º¸¦ ÅëÇØ SQL ¼¼¼ÇÀ» ¾òÀ½
        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
        
        // °øÁö»çÇ×ÀÇ À§Ä¡¸¦ ¾÷µ¥ÀÌÆ®ÇÏ´Â ¸Þ¼­µå È£Ãâ
        memoDao.updateNoticePosition(noticeDTO);

        // JSON Çü½ÄÀÇ ÀÀ´äÀ» ¹ÝÈ¯
        return "{\"status\":\"success\"}";
    }
	
}



/*
 * package kb.keyboard.warrior.controller;
 * 
 * import java.util.ArrayList; import java.util.HashMap; import java.util.List;
 * import java.util.Map;
 * 
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpSession;
 * 
 * import org.apache.ibatis.session.SqlSession; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.http.HttpStatus; import
 * org.springframework.http.ResponseEntity; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.RequestBody; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.ResponseBody;
 * 
 * import kb.keyboard.warrior.dao.ScheduleDao; import
 * kb.keyboard.warrior.dao.ToDoDao; import kb.keyboard.warrior.dto.ScheduleDTO;
 * import kb.keyboard.warrior.dto.TodoListDTO; import
 * kb.keyboard.warrior.memo.command.MemoCommand; import
 * kb.keyboard.warrior.memo.command.MemoViewCommand; import
 * kb.keyboard.warrior.memo.command.TodoViewCommand; import
 * kb.keyboard.warrior.memo.command.noticeDeleteCommand; import
 * kb.keyboard.warrior.memo.command.noticeViewCommand; import
 * kb.keyboard.warrior.memo.command.noticeWriteCommand; import
 * kb.keyboard.warrior.util.Constant;
 * 
 * @Controller public class MemoController {
 * 
 * MemoCommand command = null; private SqlSession sqlSession;
 * 
 * @Autowired public MemoController(SqlSession sqlSession) { this.sqlSession =
 * sqlSession; Constant.sqlSession = this.sqlSession; }
 * 
 * // // @RequestMapping(value = "/calendarData", method = RequestMethod.GET,
 * produces = "application/json") // @ResponseBody // public List<Map<String,
 * Object>> calendarData(HttpSession session) { // ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); // String userno = (String)
 * session.getAttribute("userno"); // List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); // // List<Map<String, Object>> events = new
 * ArrayList<Map<String, Object>>(); // for (ScheduleDTO schedule :
 * scheduleList) { // Map<String, Object> event = new HashMap<String, Object>();
 * // event.put("id", schedule.getScheduleid()); // event.put("title",
 * schedule.getTitle()); // event.put("start",
 * schedule.getStartDate().toString()); // event.put("end",
 * schedule.getEndDate().toString()); // // Map<String, Object> extendedProps =
 * new HashMap<String, Object>(); // extendedProps.put("content",
 * schedule.getContent()); // extendedProps.put("shareto",
 * schedule.getShareto()); // event.put("extendedProps", extendedProps); // //
 * events.add(event); // } // // return events; // }
 * 
 * @RequestMapping(value = "/calendar", method = RequestMethod.GET) public
 * String showCalendar(Model model, HttpSession session) { // ì—¬ê¸°ì„œ í•„ìš”í•œ ë¡œì§ì„ ì¶”ê°€í•˜ì—¬
 * ì„¸ì…˜ì—ì„œ ì‚¬ìš©ìž ì •ë³´ë¥¼ ê°€ì ¸ì˜¤ê³ , í•„ìš”í•œ ë°ì´í„°ë¥¼ ëª¨ë¸ì— ì¶”ê°€í•  ìˆ˜ ìžˆìŠµë‹ˆë‹¤. ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); String userno = (String)
 * session.getAttribute("userno"); List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); model.addAttribute("scheduleList", scheduleList);
 * // ëª¨ë¸ì— ì¼ì • ë¦¬ìŠ¤íŠ¸ë¥¼ ì¶”ê°€í•˜ì—¬ JSPì—ì„œ ì‚¬ìš©í•  ìˆ˜ ìžˆë„ë¡ í•¨ System.out.println(userno);
 * System.out.println(scheduleList); return "memo/calendar"; // calendar.jsp íŒŒì¼ì„
 * ë³´ì—¬ì¤Œ }
 * 
 * // @RequestMapping(value = "/calendarData", method = RequestMethod.GET,
 * produces = "application/json") // @ResponseBody // public ArrayNode
 * calendarData(Model model, HttpSession session) { // ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); // String userno = (String)
 * session.getAttribute("userno"); // List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); // // ObjectMapper objectMapper = new
 * ObjectMapper(); // ArrayNode jsonArray = objectMapper.createArrayNode(); //
 * // for (ScheduleDTO scheduleDTO : scheduleList) { // ObjectNode eventObject =
 * objectMapper.createObjectNode(); // eventObject.put("scheduleid",
 * scheduleDTO.getScheduleid()); // eventObject.put("title",
 * scheduleDTO.getTitle()); // eventObject.put("content",
 * scheduleDTO.getContent()); // eventObject.put("startDate",
 * scheduleDTO.getStartDate().toString()); // eventObject.put("endDate",
 * scheduleDTO.getEndDate().toString()); // eventObject.put("shareto",
 * scheduleDTO.getShareto()); // jsonArray.add(eventObject); // } // //
 * System.out.println("jsonArray: " + jsonArray.toString()); // return
 * jsonArray; // }
 * 
 * 
 * // @RequestMapping(value = "/calendar", method = RequestMethod.GET, produces
 * = "application/json") // @ResponseBody // public List<Map<String, Object>>
 * showCalendarPage(Model model, HttpSession session) { // // ì—¬ê¸°ì„œ í•„ìš”í•œ ë¡œì§ì„ ì¶”ê°€í•˜ì—¬
 * ì„¸ì…˜ì—ì„œ ì‚¬ìš©ìž ì •ë³´ë¥¼ ê°€ì ¸ì˜¤ê³ , í•„ìš”í•œ ë°ì´í„°ë¥¼ ëª¨ë¸ì— ì¶”ê°€í•  ìˆ˜ ìžˆìŠµë‹ˆë‹¤. // ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); // String userno = (String)
 * session.getAttribute("userno"); // List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); // // JSONObject jsonObj = new JSONObject(); //
 * JSONArray jsonArr = new JSONArray(); // // HashMap<String, Object> hash = new
 * HashMap<String, Object>(); // // // ScheduleDTOì—ì„œ CalendarEventë¡œ ë³€í™˜ //
 * List<ScheduleDTO> events = new ArrayList<ScheduleDTO>(); // for (ScheduleDTO
 * scheduleDTO : scheduleList) { // hash.put("scheduleid",
 * scheduleDTO.getScheduleid()); // hash.put("title", scheduleDTO.getTitle());
 * // hash.put("content", scheduleDTO.getContent()); // hash.put("startDate",
 * scheduleDTO.getStartDate()); // hash.put("endDate",
 * scheduleDTO.getEndDate()); // hash.put("shareto", scheduleDTO.getShareto());
 * // jsonObj = new JSONObject(hash); // jsonArr.put(jsonObj); // } // //
 * log.info("jsonArrCheck: {}", jsonArr); // return jsonArr; // }
 * 
 * 
 * // @RequestMapping(value = "/calendar", method = RequestMethod.GET, produces
 * = "application/json") // @ResponseBody // public
 * ResponseEntity<List<ScheduleDTO>> getCalendar(HttpServletRequest request) {
 * // HttpSession session = request.getSession(); // String userno = (String)
 * session.getAttribute("userno"); // // ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); // List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); // // // ScheduleDTOì—ì„œ CalendarEventë¡œ ë³€í™˜ //
 * List<ScheduleDTO> events = new ArrayList<ScheduleDTO>(); // for (ScheduleDTO
 * scheduleDTO : scheduleList) { // ScheduleDTO event = new ScheduleDTO(); //
 * event.setScheduleid(scheduleDTO.getScheduleid()); //
 * event.setTitle(scheduleDTO.getTitle()); //
 * event.setStartDate(scheduleDTO.getStartDate()); //
 * event.setEndDate(scheduleDTO.getEndDate()); // events.add(event); // } // //
 * return new ResponseEntity<List<ScheduleDTO>>(events, HttpStatus.OK); // }
 * 
 * 
 * // @RequestMapping(value = "/calendar", method = RequestMethod.GET, produces
 * = "application/json") // @ResponseBody // public
 * ResponseEntity<List<ScheduleDTO>> getCalendar(HttpServletRequest request) {
 * // HttpSession session = request.getSession(); // String userno = (String)
 * session.getAttribute("userno"); // // ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); // List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); // // return new
 * ResponseEntity<List<ScheduleDTO>>(scheduleList, HttpStatus.OK); // }
 * 
 * @RequestMapping(value = "/calendarsave", method = RequestMethod.POST)
 * 
 * @ResponseBody public ResponseEntity<String> saveEvent(HttpServletRequest
 * request, @RequestBody ScheduleDTO dto) { HttpSession session =
 * request.getSession(); String userno = (String)
 * session.getAttribute("userno"); if (userno == null) { return new
 * ResponseEntity<String>("User not logged in", HttpStatus.UNAUTHORIZED); }
 * dto.setUserno(userno); ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); try { dao.scheduleNew(dto); return
 * new ResponseEntity<String>("Event saved successfully", HttpStatus.OK); }
 * catch (Exception e) { return new ResponseEntity<String>("Error saving event",
 * HttpStatus.INTERNAL_SERVER_ERROR); } }
 * 
 * @RequestMapping(value = "/calendaredit", method = RequestMethod.POST)
 * 
 * @ResponseBody public String editEvent(@RequestBody ScheduleDTO dto) {
 * ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
 * dao.scheduleEdit(dto); return "redirect:/memo/calendar"; }
 * 
 * @RequestMapping(value = "/calendardelete", method = RequestMethod.POST)
 * 
 * @ResponseBody public String deleteEvent(@RequestParam String scheduleid) {
 * ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
 * dao.scheduleDelete(scheduleid); return "redirect:/memo/calendar"; }
 * 
 * @RequestMapping("/todo") // todolist view public String todoView(HttpSession
 * session, Model model) { System.out.println("todoView()");
 * 
 * String userno = (String) session.getAttribute("userno"); if (userno != null)
 * { command = new TodoViewCommand(userno); command.execute(model); } else {
 * System.out.println("User number not found in session."); }
 * 
 * return "todo"; }
 * 
 * // home todolist check
 * 
 * @RequestMapping(value = "/todolistCheck", produces = "application/json",
 * consumes = "application/json", method = RequestMethod.POST)
 * public @ResponseBody String findPw(@RequestBody TodoListDTO todoListDto)
 * throws Exception {
 * 
 * String todoId = todoListDto.getTodoid(); String isDone =
 * todoListDto.getIsdone(); // í”„ë¦°íŠ¸ System.out.println(todoId);
 * System.out.println(isDone);
 * 
 * ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
 * 
 * if (isDone.equals("1")) { // ì™„ë£Œ ì²˜ë¦¬ todoDao.checkTodo(todoId); } else {
 * todoDao.unCheckTodo(todoId); }
 * 
 * return "{\"status\":\"success\"}"; }
 * 
 * @RequestMapping("/memo") // memo view ë©”ëª¨ íŽ˜ì´ì§€ public String
 * memoView(HttpSession session, Model model) {
 * System.out.println("memoView()");
 * 
 * String userno = (String) session.getAttribute("userno"); String deptno =
 * (String) session.getAttribute("deptno"); System.out.println("ì‚¬ìš©ìž ë²ˆí˜¸ í™•ì¸: " +
 * userno); System.out.println("ë¶€ì„œ ë²ˆí˜¸ í™•ì¸: " + deptno); if (userno != null &&
 * deptno != null) { MemoViewCommand command = new MemoViewCommand();
 * command.execute(model, userno, deptno); } else {
 * System.out.println("User number or dept number not found in session."); }
 * 
 * return "memo"; }
 * 
 * @RequestMapping("/notice") // notice view public String
 * noticeView(HttpSession session, Model model) {
 * System.out.println("noticeView()");
 * 
 * String userno = (String) session.getAttribute("userno"); String deptno =
 * (String) session.getAttribute("deptno"); System.out.println("ì‚¬ìš©ìž ë²ˆí˜¸ í™•ì¸: " +
 * userno); System.out.println("ë¶€ì„œ ë²ˆí˜¸ í™•ì¸: " + deptno); if (userno != null &&
 * deptno != null) { command = new noticeViewCommand(userno, deptno);
 * command.execute(model); } else {
 * System.out.println("User number or dept number not found in session."); }
 * 
 * return "notice"; }
 * 
 * @RequestMapping("/noticeform") // notice form public String noticeForm() {
 * return "noticeForm"; }
 * 
 * @RequestMapping("/noticeWrite") // notice write action public String
 * noticeWrite(HttpSession session, HttpServletRequest request, Model model) {
 * System.out.println("noticeWrite()");
 * 
 * String userno = (String) session.getAttribute("userno"); String deptno =
 * (String) session.getAttribute("deptno"); System.out.println("ì‚¬ìš©ìž ë²ˆí˜¸ í™•ì¸: " +
 * userno); System.out.println("ë¶€ì„œ ë²ˆí˜¸ í™•ì¸: " + deptno);
 * model.addAttribute("request", request); model.addAttribute("userno", userno);
 * model.addAttribute("deptno", deptno); if (userno != null && deptno != null) {
 * command = new noticeWriteCommand(); command.execute(model); } else {
 * System.out.println("User number or dept number not found in session."); }
 * return "redirect:notice"; }
 * 
 * @RequestMapping("/noticeDelete") public String noticeDelete(HttpSession
 * session, HttpServletRequest request, Model model) {
 * System.out.println("noticeDelete()");
 * 
 * String userno = (String) session.getAttribute("userno"); // ì‚¬ìš©ìž ë²ˆí˜¸ í™•ì¸
 * System.out.println("ì‚¬ìš©ìž ë²ˆí˜¸ í™•ì¸: " + userno); // í™•ì¸
 * model.addAttribute("request", request); // ìš”ì²­ì„ ëª¨ë¸ì— ì¶”ê°€
 * System.out.println("ëª¨ë¸ì— ì¶”ê°€ëœ ìš”ì²­: " + model);
 * 
 * if (userno != null) { noticeDeleteCommand command = new
 * noticeDeleteCommand(); command.execute(model, userno); } else {
 * System.out.println("User number not found in session."); } return
 * "redirect:notice"; } }
 */