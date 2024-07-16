package kb.keyboard.warrior.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	@RequestMapping("/resetPassword")
	public String resetPW(HttpServletRequest request, Model model) {
		System.out.println("��й�ȣ �缳�� ȭ�� ����");
		return "login/resetPassword";
	}
	@RequestMapping("/resetPasswordAction")
	public String resetPWAction(HttpServletRequest request, Model model, UserDTO dto) {
		System.out.println("./resetPasswordAction");
		System.out.println("��й�ȣ �ٲ� ������ ������ȣ : "+dto.getUserno());
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		dao.UpdatePw(dto.getUserno(), dto.getUserpw());
		System.out.println("��й�ȣ ����Ϸ� ~~");
		return "redirect:login";
	}
	
	
	
	@RequestMapping("/loginAction")
	public String loginAction(HttpServletRequest request, Model model, UserDTO dto, RedirectAttributes attributes) {
		
		System.out.println("�Է��� ������ȣ : "+ dto.getUserno());
		System.out.println("�Է��� ��й�ȣ : "+ dto.getUserpw());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO list = dao.login(dto.getUserno(), dto.getUserpw());
		if(list!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("userno", list.getUserno()); // ���ǿ� �� �ֱ�
			session.setAttribute("deptno", list.getDeptno()); // ���ǿ� �� �ֱ�
			System.out.println("�α��� ����!  ��� : " +list.getUserno());
			System.out.println("��й�ȣ : " +list.getUserpw());
			System.out.println("���� �̸� : " +list.getUsername());
			if(list.getUserpw().equals(list.getUserno())) {
				System.out.println("��й�ȣ �ʱ���� ! ��й�ȣ ������ �ʿ��մϴ�.");
				attributes.addFlashAttribute("userno", list.getUserno());
				return "redirect:/resetPassword";
			}
			
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
