package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.fasterxml.jackson.databind.SerializationFeature;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dto.*;



@Controller
public class LoginController {
	
	@Autowired
	public SqlSession sqlSession;
	

	// Regarding login
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {		
		System.out.println("�α��� â ����");
		return "login/login";
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
			if(list.getUserpw().equals(list.getUserno())) {
				System.out.println("��й�ȣ �ʱ���� ! ��й�ȣ ������ �ʿ��մϴ�.");
				attributes.addFlashAttribute("userno", list);
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
	
	
	
	
	
	
	// Regarding password reset 
	@RequestMapping("/findPassword")
	public String findPW(HttpServletRequest request, Model model) {
		
		return "login/findPassword";
	}
	
	@RequestMapping("/setNewPassword")
	public String setNewPassword(HttpServletRequest request, Model model,  PageDTO pagedto, UserDTO userdto) {//
		System.out.println("/setNewPassword enter  -->");
		if(pagedto.getKey()!=null&&pagedto.getKey().equals("itiscorrect")) {
			System.out.println(pagedto.getKey());
			LoginDao dao = sqlSession.getMapper(LoginDao.class);
			userdto = dao.isRightUserno(userdto.getUserno());
			
			System.out.println(userdto.getDeptno());  // �� �� �����Դ��� Ȯ��
			
			model.addAttribute("pagedto", pagedto);
			model.addAttribute("userdto", userdto);
			return "login/setPw";
		}
		System.out.println("�߸��� ����, ���� ȭ������ ���ư��ϴ�.");
		return "redirect:/";
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
	// Regarding Asynchronous
	@RequestMapping(value = "/findPw",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST ) // , method=RequestMethod.POST // consumes = "application/json"	/*	*/
	public @ResponseBody String findPw(@RequestBody  UserDTO userdto) throws Exception {
		System.out.println("findPw ����");
		System.out.println("�Ѱܹ��� �� �ִ��� Ȯ�� : " + userdto.getUserno());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.findPw(userdto);

		if (dto != null) {
				System.out.println("��� ��ġ�ϴ� �������� ã�Ҵ� ! �μ���ȣ  : " +dto.getDeptno());
		} else {
			System.out.println("DB��ȸ ��� ����");
			dto = new UserDTO();
		}

		ObjectMapper mapper = new ObjectMapper();

		String json = mapper.writeValueAsString(dto);
		return json;
	}

	// Regarding mypage
	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String userno = (String) session.getAttribute("userno");	
		System.out.println("���ǿ� �ִ� userno : "+ userno);
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.isRightUserno(userno);
		model.addAttribute("dto", dto);
		
		return "login/mypage";
	}
	
	// Regarding mypage
	@RequestMapping("/editProfile")
	public String editProfile(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String userno = (String) session.getAttribute("userno");	
		System.out.println("���ǿ� �ִ� userno : "+ userno);
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.isRightUserno(userno);
		model.addAttribute("dto", dto);
		
		return "login/editProfile";
	}
	
	// Regarding Asynchronous  -- ���� �г��� �÷��� ��� ������ ����.
	@RequestMapping(value = "/changeNickname",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST ) // , method=RequestMethod.POST // consumes = "application/json"	/*	*/
	public @ResponseBody String changeNickname(@RequestBody  UserDTO userdto) throws Exception {
		System.out.println("changeNickname ����");
		System.out.println("�Ѱܹ��� �� �ִ��� Ȯ�� : " + userdto.getNickname());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.isRightUserno(userdto.getUserno());

		if (dto != null) {
				System.out.println("��� ��ġ�ϴ� �������� ã�Ҵ� ! �μ���ȣ  : " +dto.getDeptno());
		} else {
			System.out.println("DB��ȸ ��� ����");
			dto = new UserDTO();
		}

		ObjectMapper mapper = new ObjectMapper();

		String json = mapper.writeValueAsString(dto);
		return json;
	}
	
	
	
	
	

}
