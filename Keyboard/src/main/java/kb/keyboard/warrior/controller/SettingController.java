package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.SettingDao;

@Controller
public class SettingController {

    @Autowired
    public SqlSession sqlSession;
    
    @RequestMapping("/setting")
    public String settingPage(Model model, HttpSession session) {
    	
    	return "settingPage";
    }
    
    @RequestMapping("/submitColor")
    public String changeColor(HttpServletRequest request, HttpSession session) {
    	
    	//id 체크
    	String userno = (String) session.getAttribute("userno");
    	
    	//request 에서 새로 선택한 컬러
    	String newColor = request.getParameter("setting_color");
    	System.out.println("새로 선택한 컬러 : "+newColor);
    	
    	
    	LoginDao dao = sqlSession.getMapper(LoginDao.class);
    	SettingDao settingDao = sqlSession.getMapper(SettingDao.class);
    	
    	String beforeColor = dao.getColor(userno); //기존 세팅값 존재여부 체크
    	if (beforeColor != null) {
    		//update
    		settingDao.updateColor(newColor, userno);
    	} else {
    		//insert
    		settingDao.insertColor(newColor, userno);
    	}
    	
    	session.setAttribute("bgcolor", newColor);
    	
    	return "redirect:setting";
    }
}
