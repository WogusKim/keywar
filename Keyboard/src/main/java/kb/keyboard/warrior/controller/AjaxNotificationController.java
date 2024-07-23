package kb.keyboard.warrior.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;



import kb.keyboard.warrior.dao.*;
import kb.keyboard.warrior.dto.AlertDTO;

@Controller
public class AjaxNotificationController {

	@Autowired
	public SqlSession sqlSession;


//    @Autowired
//    private ObjectMapper objectMapper; // 주입된 ObjectMapper 사용
	
	
	@RequestMapping(value = "/ajaxNotification", method = RequestMethod.GET)
    @ResponseBody
    public void getNotifications(HttpServletResponse response) throws Exception {
        // HttpSession을 가져옵니다.
    	
    	String userno ="";
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpSession session = attrs.getRequest().getSession(false);
        if (session != null) {
            userno = (String) session.getAttribute("userno");
        }
        
        // 알림 데이터 처리
        String data = getData(userno);
        
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(data);
    }

    private String getData(String userno) throws  Exception {
    	AlertDao dao = sqlSession.getMapper(AlertDao.class);
    	List<AlertDTO> list = dao.getAlert(userno);
    	
    	if(list==null) {
    		 return "{\"message\": \"No new notifications\"}";
    	}
    	
    	
    	
    	// ObjectMapper를 사용하여 JSON 직렬화
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(list);
    	
        return json;
    }
    
    
    @RequestMapping(value = "/testUrl", method = RequestMethod.GET)
    public String readCheck(HttpServletResponse response, @RequestParam("alertid") String alertid) throws Exception {
    	System.out.println("alertno : "+alertid);
    	
    	AlertDao dao = sqlSession.getMapper(AlertDao.class);
    	dao.updateIsread(alertid);
    	
    	return "redirect:testPage";
    }
    
    
    
    
}