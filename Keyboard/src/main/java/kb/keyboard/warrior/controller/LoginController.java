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
		System.out.println("�α��� â ����");
		return "login/login";
	}
	@RequestMapping("/findPassword")
	public String findPW(HttpServletRequest request, Model model) {
		
		return "login/findPassword";
	}
	
	@RequestMapping("/loginAction")
	public String loginAction(HttpServletRequest request, Model model, UserDTO dto) {
		System.out.println("�ϴ� �α��� ����");
		
		System.out.println("�Է��� ������ȣ : "+dto.getUserno());
		System.out.println("�Է��� ��й�ȣ : "+dto.getUserpw());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO list = dao.login(dto.getUserno(), dto.getUserpw());
		if(list!=null) {
			System.out.println("�α��� ����!  ��� : " +list.getUserno());
			System.out.println("��й�ȣ : " +list.getUserpw());
			System.out.println("��й�ȣ : " +list.getUsername());
			 
			return "redirect:/";
		}else {
			
			if(dao.isRightUserno(dto.getUserno())!=null) {
				System.out.println("��й�ȣ�� �߸��Ǿ����ϴ�.");
				return "redirect:login";
			}else {
				System.out.println("�߸��� ������ȣ�Դϴ�.");
				return "redirect:login";
			}
		}
	}
	

}
