package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.SettingDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.AlertDTO;
import kb.keyboard.warrior.dto.TodoListDTO;

@Controller
public class SettingController {

    @Autowired
    public SqlSession sqlSession;
    
    @RequestMapping("/setting")
    public String settingPage(Model model, HttpSession session) {
    	SettingDao dao = sqlSession.getMapper(SettingDao.class);
    	String userno = (String)session.getAttribute("userno");
    	AlertDTO dto = dao.getAlertStauts(userno);
    	
    	model.addAttribute("alert", dto);
    	
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
    
    // 알림 설정 비동기 처리
    @RequestMapping(value = "/changeAlertStatus", produces = "application/json", consumes = "application/json", method = RequestMethod.POST)
    public @ResponseBody String findPw(@RequestBody AlertDTO dto) throws Exception {

    	System.out.println(dto.getCategory());
    	System.out.println(dto.getUserno());
    	System.out.println(dto.getCheckStatus());
    	SettingDao dao = sqlSession.getMapper(SettingDao.class);
    	dao.changeAlertStatus(dto);


//        ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
//
//        if (isDone.equals("1")) {
//            // check yn
//            todoDao.checkTodo(todoId);
//        } else {
//            todoDao.unCheckTodo(todoId);
//        }

        return "{\"status\":\"success\"}";
    }
    
}
