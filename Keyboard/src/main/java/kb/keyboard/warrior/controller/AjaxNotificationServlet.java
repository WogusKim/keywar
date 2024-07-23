package kb.keyboard.warrior.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import kb.keyboard.warrior.dao.LoginDao;

/**
 * Servlet implementation class AjaxNotificationServlet
 */

public class AjaxNotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	@Autowired
    private LoginDao loginDao; 
	
	
	
    public AjaxNotificationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        String userno = (String) session.getAttribute("userno");
        System.out.println(userno);
		 // 데이터 처리 로직
        String data = getData(userno);

        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"" + (data != null ? data : "No new notifications") + "\"}");
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	private String getData(String userno) {
        // 알림 데이터 생성 로직
		
		loginDao.isRightUserno(userno);
		
		
        return "New notification !"; // 또는 null
    }
}
