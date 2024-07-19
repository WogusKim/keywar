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

import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.ScheduleDTO;
import kb.keyboard.warrior.dto.TodoListDTO;
import kb.keyboard.warrior.memo.command.MemoCommand;
import kb.keyboard.warrior.memo.command.MemoViewCommand;
import kb.keyboard.warrior.memo.command.TodoViewCommand;
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
 * String showCalendar(Model model, HttpSession session) { // 여기서 필요한 로직을 추가하여
 * 세션에서 사용자 정보를 가져오고, 필요한 데이터를 모델에 추가할 수 있습니다. ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); String userno = (String)
 * session.getAttribute("userno"); List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); model.addAttribute("scheduleList", scheduleList);
 * // 모델에 일정 리스트를 추가하여 JSP에서 사용할 수 있도록 함 System.out.println(userno);
 * System.out.println(scheduleList); return "memo/calendar"; // calendar.jsp 파일을
 * 보여줌 }
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
 * showCalendarPage(Model model, HttpSession session) { // // 여기서 필요한 로직을 추가하여
 * 세션에서 사용자 정보를 가져오고, 필요한 데이터를 모델에 추가할 수 있습니다. // ScheduleDao dao =
 * sqlSession.getMapper(ScheduleDao.class); // String userno = (String)
 * session.getAttribute("userno"); // List<ScheduleDTO> scheduleList =
 * dao.scheduleLoad(userno); // // JSONObject jsonObj = new JSONObject(); //
 * JSONArray jsonArr = new JSONArray(); // // HashMap<String, Object> hash = new
 * HashMap<String, Object>(); // // // ScheduleDTO에서 CalendarEvent로 변환 //
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
 * dao.scheduleLoad(userno); // // // ScheduleDTO에서 CalendarEvent로 변환 //
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
 * todoListDto.getIsdone(); // 프린트 System.out.println(todoId);
 * System.out.println(isDone);
 * 
 * ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
 * 
 * if (isDone.equals("1")) { // 완료 처리 todoDao.checkTodo(todoId); } else {
 * todoDao.unCheckTodo(todoId); }
 * 
 * return "{\"status\":\"success\"}"; }
 * 
 * @RequestMapping("/memo") // memo view 메모 페이지 public String
 * memoView(HttpSession session, Model model) {
 * System.out.println("memoView()");
 * 
 * String userno = (String) session.getAttribute("userno"); String deptno =
 * (String) session.getAttribute("deptno"); System.out.println("사용자 번호 확인: " +
 * userno); System.out.println("부서 번호 확인: " + deptno); if (userno != null &&
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
 * (String) session.getAttribute("deptno"); System.out.println("사용자 번호 확인: " +
 * userno); System.out.println("부서 번호 확인: " + deptno); if (userno != null &&
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
 * (String) session.getAttribute("deptno"); System.out.println("사용자 번호 확인: " +
 * userno); System.out.println("부서 번호 확인: " + deptno);
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
 * String userno = (String) session.getAttribute("userno"); // 사용자 번호 확인
 * System.out.println("사용자 번호 확인: " + userno); // 확인
 * model.addAttribute("request", request); // 요청을 모델에 추가
 * System.out.println("모델에 추가된 요청: " + model);
 * 
 * if (userno != null) { noticeDeleteCommand command = new
 * noticeDeleteCommand(); command.execute(model, userno); } else {
 * System.out.println("User number not found in session."); } return
 * "redirect:notice"; } }
 */