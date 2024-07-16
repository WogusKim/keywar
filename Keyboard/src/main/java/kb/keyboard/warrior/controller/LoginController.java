package kb.keyboard.warrior.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kb.keyboard.warrior.dao.*;
import kb.keyboard.warrior.dto.*;



@Controller
public class LoginController {
	
	@Autowired
	public SqlSession sqlSession;
	/* RCommand command = null; */

	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {		
		System.out.println("로그인 창 진입");
		return "login/login";
	}
	@RequestMapping("/findPassword")
	public String findPW(HttpServletRequest request, Model model) {
		
		return "login/findPassword";
	}
	
	@RequestMapping("/loginAction")
	public String loginAction(HttpServletRequest request, Model model, UserDTO dto) {
		System.out.println("일단 로그인 실행");
		
		System.out.println("입력한 직원번호 : "+dto.getUserno());
		System.out.println("입력한 비밀번호 : "+dto.getUserpw());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO list = dao.login(dto.getUserno(), dto.getUserpw());
		if(list!=null) {
			System.out.println("로그인 성공!  사번 : " +list.getUserno());
			System.out.println("비밀번호 : " +list.getUserpw());
			System.out.println("비밀번호 : " +list.getUsername());
			 
			return "redirect:/";
		}else {
			
			if(dao.isRightUserno(dto.getUserno())!=null) {
				System.out.println("비밀번호가 잘못되었습니다.");
				return "redirect:login";
			}else {
				System.out.println("잘못된 직원번호입니다.");
				return "redirect:login";
			}
		}
	}
	

}
