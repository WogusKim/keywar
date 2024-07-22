package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kb.keyboard.warrior.dao.*;

@Controller
public class AjaxNotificationController {

	@Autowired
	public SqlSession sqlSession;

    @RequestMapping(value = "/ajaxNotification", method = RequestMethod.GET)
    @ResponseBody
    public String getNotifications(@RequestParam(value = "userno", required = false) String userno) {
        // HttpSession을 가져옵니다.
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpSession session = attrs.getRequest().getSession(false);
        if (session != null) {
            userno = (String) session.getAttribute("userno");
        }
        
        // 알림 데이터 처리
        String data = getData(userno);
        
        return "{\"message\": \"" + (data != null ? data : "No new notifications") + "\"}";
    }

    private String getData(String userno) {
    	AlertDao dao = sqlSession.getMapper(AlertDao.class);
    	
    	
    	
        return "New notification !"; // 또는 null
    }
}