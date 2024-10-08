package kb.keyboard.warrior.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.DeptMemoDTO;
import kb.keyboard.warrior.dto.MyMemoDTO;
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
            extendedProps.put("userid", schedule.getUserno());
            extendedProps.put("content", schedule.getContent());
            extendedProps.put("sharedepth1", schedule.getSharedepth1());
            extendedProps.put("sharedepth2", schedule.getSharedepth2());
            extendedProps.put("sharedepth3", schedule.getSharedepth3());
            extendedProps.put("deptname", schedule.getDeptname());
            extendedProps.put("teamname", schedule.getTeamname());
            extendedProps.put("customname", schedule.getCustomname());
            extendedProps.put("sharecolor", schedule.getSharecolor());
            extendedProps.put("category", schedule.getCategory());
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

    @RequestMapping(value = "/checkGroupName", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkGroupName(HttpSession session, @RequestBody Map<String, String> request) {
        String groupName = request.get("groupName");
        Map<String, Object> response = new HashMap<String, Object>();

        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        try {
        	int count = dao.checkGroupName(groupName);
            response.put("exists", count > 0);
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace(); 
            response.put("error", "Error checking group name");
            return new ResponseEntity<Map<String, Object>>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping(value = "/searchUser", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public ResponseEntity<Map<String, List<Map<String, String>>>> searchUser(@RequestBody Map<String, String> request, HttpSession session) {
        String searchUsername = (String) request.get("username");
        String userno = (String) session.getAttribute("userno");
        System.out.println(searchUsername);
        System.out.println(userno);
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        System.out.println("dao load");
        try {
        	System.out.println("try in");
            List<Map<String, String>> searchUserList = dao.searchUser(searchUsername, userno);
            System.out.println("searchUserList: " + searchUserList);
            Map<String, List<Map<String, String>>> response = new HashMap<String, List<Map<String, String>>>();
            response.put("users", searchUserList);
            return new ResponseEntity<Map<String, List<Map<String, String>>>>(response, HttpStatus.OK);
        } catch(Exception e) {
            return new ResponseEntity<Map<String, List<Map<String, String>>>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping("/saveGroup")
    public ResponseEntity<String> saveGroup(@RequestBody List<Map<String, String>> groupData, HttpSession session) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String inviteNo = (String) session.getAttribute("userno");
        try {
        	dao.saveGroup(groupData);
        	dao.saveSelf(inviteNo);
        	for (Map<String, String> userData : groupData) {
                Map<String, Object> params = new HashMap<String, Object>();
                params.put("inviteNo", inviteNo);
                params.put("userno", userData.get("userno"));
                params.put("customname", userData.get("customname"));
                
                dao.alertInsertCalendar(params);
            }
            return new ResponseEntity<String>("Group saved successfully", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("Error saving group", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping(value = "/getUserGroupsForExit", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public List<ScheduleDTO> getUserGroupsForExit(HttpSession session) {
    	String userno = (String) session.getAttribute("userno");
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        System.out.println("exit_userno for userGroups: " + userno);
        return dao.getUserGroups(userno);
    }
    
    @RequestMapping(value = "/getUserGroupsForInvite", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public List<ScheduleDTO> getUserGroupsForInvite(HttpSession session) {
    	String userno = (String) session.getAttribute("userno");
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        System.out.println("invite_userno for userGroups: " + userno);
        return dao.getUserGroups(userno);
    }
    
    @RequestMapping("/leaveGroup")
    public ResponseEntity<String> leaveGroup(@RequestBody Map<String, Object> request, HttpSession session) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String groupId = (String) request.get("groupId");
        String userno = (String) session.getAttribute("userno");
        System.out.println("groupId: " + groupId);
        try {
            dao.leaveGroup(groupId, userno);
            return new ResponseEntity<String>("Users invited to group successfully", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("Error invited users to group ", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping(value = "/searchUsersForInvite", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public ResponseEntity<Map<String, List<Map<String, String>>>> searchUsersForInvite(@RequestBody Map<String, String> request, HttpSession session) {
        String searchUsername = (String) request.get("username");
        String groupNum = (String) request.get("groupNum");
        String userno = (String) session.getAttribute("userno");
        System.out.println(searchUsername);
        System.out.println(userno);
        System.out.println(groupNum);
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        System.out.println("dao load");
        try {
        	System.out.println("try in");
            List<Map<String, String>> searchUserList = dao.searchUsersForInvite(searchUsername, userno, groupNum);
            System.out.println("searchUserList: " + searchUserList);
            Map<String, List<Map<String, String>>> response = new HashMap<String, List<Map<String, String>>>();
            response.put("users", searchUserList);
            return new ResponseEntity<Map<String, List<Map<String, String>>>>(response, HttpStatus.OK);
        } catch(Exception e) {
        	System.out.println("error in searchUsersForInvite");
            e.printStackTrace(); // 이 줄을 추가하세요
            return new ResponseEntity<Map<String, List<Map<String, String>>>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
    @RequestMapping("/inviteUsersToGroup")
    public ResponseEntity<String> inviteUsersToGroup(@RequestBody Map<String, Object> request, HttpSession session) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String groupId = (String) request.get("groupId");
        String groupName = (String) request.get("groupName");
        List<String> userIds = (List<String>) request.get("userIds");
        String inviteNo = (String) session.getAttribute("userno");
        try {
            List<Map<String, Object>> paramsList = new ArrayList<Map<String, Object>>();

        	for (String userId : userIds) {
                Map<String, Object> params = new HashMap<String, Object>();
                params.put("userno", userId);
                params.put("sharedepth3", groupId);
                params.put("customname", groupName);
                params.put("inviteNo", inviteNo);
                paramsList.add(params);
            }
            dao.inviteUsersToGroup(paramsList);
            dao.alertInsertCalendarForInvite(paramsList);

            return new ResponseEntity<String>("Users invited to group successfully", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("Error invited users to group ", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping(value = "/customsharetoload", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public List<Map<String, String>> loadCustomShareto(HttpSession session) {
        String userno = (String) session.getAttribute("userno");
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        List<Map<String, String>> customSharetoList = dao.loadCustomShareto(userno);
        return customSharetoList;
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
        System.out.println("Received DTO: " + dto);  
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        try {
            dao.scheduleNew(dto);
            return new ResponseEntity<String>("Event saved successfully", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace(); 
            return new ResponseEntity<String>("Error saving event", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/calendaredit", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> editEvent(@RequestBody ScheduleDTO dto, HttpSession session) {

        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String userno = (String) session.getAttribute("userno");
        if (userno == null) {
            return new ResponseEntity<String>("User not logged in_Calendar edit", HttpStatus.UNAUTHORIZED);
        }
        dto.setUserno(userno);
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

    @RequestMapping(value = "/countTodoList", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<ScheduleDTO> countTodoList(HttpSession session) {
        ScheduleDao dao = sqlSession.getMapper(ScheduleDao.class);
        String userno = (String) session.getAttribute("userno");
        return dao.countTodoList(userno);
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
        // todolist id check
        System.out.println(todoId);
        System.out.println(isDone);

        ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);

        if (isDone.equals("1")) {
            // check yn
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
        System.out.println("memo userno: " + userno);
        System.out.println("memo deptno: " + deptno);
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
        System.out.println("notice userno: " + userno);
        System.out.println("notice deptno: " + deptno);
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
        System.out.println("noticewrite userno: " + userno);
        System.out.println("noticewrite deptno: " + deptno);
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
    public String noticeDelete(@RequestBody NoticeDTO noticeDTO) {
        System.out.println("noticeDelete()");

        
        String noticeid = noticeDTO.getNoticeid();
        
        MemoDao dao = sqlSession.getMapper(MemoDao.class);
        dao.noticeDelete(noticeid);
                  

        return "{\"status\":\"success\"}";
    }

    @RequestMapping("/mymemoWrite")
    public String mymemoWrite(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("mymemoWrite()");

        String userno = (String) session.getAttribute("userno");
        System.out.println("mymemo userno: " + userno);
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
        System.out.println("deptmemo userno: " + userno);
        System.out.println("deptno deptno: " + deptno);
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

    
	@RequestMapping(value = "/searchMyMemo", method = RequestMethod.GET)
	public void searchMyMemo(HttpSession session, 
	                         @RequestParam(value = "keyword") String keyword, 
	                         HttpServletResponse response) {
	    
	    String userno = (String) session.getAttribute("userno");
	    System.out.println("직원번호누구야? " + userno);
	    System.out.println("검색어는뭐야? " + keyword);
	    
	    try {
	        // URL 인코딩된 키워드를 디코딩
	        keyword = URLDecoder.decode(keyword, "UTF-8").trim();
	        System.out.println("디코딩된 검색어: " + keyword);
	        
	        // SQL 쿼리 로그 출력
	        logger.info("Executing SQL: SELECT * FROM mymemo WHERE userno = " + userno + " AND content LIKE '%" + keyword + "%'");

	        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
	        List<MyMemoDTO> memos = memoDao.searchMyMemo(userno, keyword);
	        
	        // memos 리스트의 각 항목을 출력
	        for (MyMemoDTO memo : memos) {
	            System.out.println("Memo Content: " + memo.getContent());
	            System.out.println("Memo Color: " + memo.getColor());
	            System.out.println("Memo Createdate: " + memo.getCreatedate());
	        }
	        
	        // JSON 응답 작성
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        PrintWriter out = response.getWriter();
	        
	        ObjectMapper mapper = new ObjectMapper();
	        Map<String, Object> responseMap = new HashMap<String, Object>();
	        responseMap.put("memos", memos);
	        
	        // JSON 데이터 출력
	        mapper.writeValue(out, responseMap);
	        
	        out.flush();
	        
	    } catch (Exception e) {
	        logger.error("Error during searchMyMemo", e);
	        try {
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "검색 중 오류가 발생했습니다.");
	        } catch (IOException ioException) {
	            ioException.printStackTrace();
	        }
	    }
	}
	
	
	@RequestMapping(value = "/searchDeptMemo", method = RequestMethod.GET)
	public void searchDeptMemo(HttpSession session, 
	                           @RequestParam(value = "keyword") String keyword, 
	                           HttpServletResponse response) {

	    String deptno = (String) session.getAttribute("deptno");
	    System.out.println("부점번호는 누구야? " + deptno);
	    System.out.println("검색어는 뭐야? " + keyword);

	    try {
	        // URL 인코딩된 키워드를 디코딩
	        keyword = URLDecoder.decode(keyword, "UTF-8").trim();
	        System.out.println("디코딩된 검색어: " + keyword);

	        // SQL 쿼리 로그 출력
	        logger.info("Executing SQL: SELECT * FROM deptmemo WHERE deptno = " + deptno + " AND content LIKE '%" + keyword + "%'");

	        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
	        List<DeptMemoDTO> memos = memoDao.searchDeptMemo(deptno, keyword);
	        
	        // memos 리스트의 각 항목을 출력
	        for (DeptMemoDTO memo : memos) {
	            System.out.println("Memo Content: " + memo.getContent());
	            System.out.println("Memo Color: " + memo.getColor());
	            System.out.println("Memo Createdate: " + memo.getCreatedate());
	        }

	        // JSON 응답 작성
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        PrintWriter out = response.getWriter();

	        ObjectMapper mapper = new ObjectMapper();
	        Map<String, Object> responseMap = new HashMap<String, Object>();
	        responseMap.put("memos", memos);

	        // JSON 데이터 출력
	        mapper.writeValue(out, responseMap);

	        out.flush();

	    } catch (Exception e) {
	        logger.error("Error during searchDeptMemo", e);
	        try {
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "검색 중 오류가 발생했습니다.");
	        } catch (IOException ioException) {
	            ioException.printStackTrace();
	        }
	    }
	}

    @RequestMapping("/mymemoDelete")
    public String mymemoDelete(HttpSession session, HttpServletRequest request, Model model) {
        System.out.println("mymemoDelete()");

        String userno = (String) session.getAttribute("userno");
        System.out.println("mymemo delete userno: " + userno);
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
        System.out.println("deptmemo delete deptno: " + deptno);
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
        System.out.println("todo userno: " + userno);
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
        System.out.println("todo userno: " + userno);
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
        System.out.println("notice update controller");
        System.out.println(noticeDTO.getPositionX());
        System.out.println(noticeDTO.getPositionY());
        System.out.println(noticeDTO.getNoticeid());
        System.out.println(noticeDTO.getZindex());
        // MemoDao call
        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);

        // memodao noticeposition (x, y, z)
        memoDao.updateNoticePosition(noticeDTO);

        // JSON send
        return "{\"status\":\"success\"}";
    }
  
	@RequestMapping(value = "/updateNoticeSize", method = RequestMethod.POST)
	@ResponseBody
	public String updateNoticeSize(@RequestBody NoticeDTO noticeDTO) {
		System.out.println("怨듭� �쐞移� 諛� �겕湲� �뾽�뜲�씠�듃");
		System.out.println(noticeDTO.getWidth());
		System.out.println(noticeDTO.getHeight());

		// MemoDao
		MemoDao memoDao = sqlSession.getMapper(MemoDao.class);

		// update Notice Size
		memoDao.updateNoticeSize(noticeDTO);

		// JSON send
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

//    투두리스트 관련 추가(성은)
	@RequestMapping(value = "/editTodo", method = RequestMethod.POST)
	@ResponseBody
	public String editTodo(@RequestBody TodoListDTO dto) {
		System.out.println("TODOLIST 수정창 진입");

		ToDoDao dao = sqlSession.getMapper(ToDoDao.class);
		dao.editTodo(dto);

		return "{\"status\":\"success\"}";
	}

	@RequestMapping(value = "/addTodo", method = RequestMethod.POST)
	@ResponseBody
	public String addTodo(@RequestBody TodoListDTO dto) {
		System.out.println("TODOLIST 등록창  진입");

		ToDoDao dao = sqlSession.getMapper(ToDoDao.class);
		dao.addTodo(dto);

		return "{\"status\":\"success\"}";
	}

	@RequestMapping(value = "/deleteTodo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteTodo(@RequestBody TodoListDTO dto) {
		System.out.println("TODOLIST 수정창 진입");

		System.out.println("넘겨받은 todo id : " + dto.getTodoid());
		sqlSession.getMapper(ToDoDao.class).deleteTodo(dto.getTodoid());

		return "{\"status\":\"success\"}";
	}

	@RequestMapping(value = "/test")
	public String test(HttpSession session, HttpServletRequest request, Model model) {
		
		return "login/testPage";
	}
	
	
}
