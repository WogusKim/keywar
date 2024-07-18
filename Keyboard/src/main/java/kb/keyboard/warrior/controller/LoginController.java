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
		System.out.println("로그인 창 진입");
		return "login/login";
	}
	@RequestMapping("/loginAction")
	public String loginAction(HttpServletRequest request, Model model, UserDTO dto, RedirectAttributes attributes) {
		
		System.out.println("입력한 직원번호 : "+ dto.getUserno());
		System.out.println("입력한 비밀번호 : "+ dto.getUserpw());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO list = dao.login(dto.getUserno(), dto.getUserpw());
		if(list!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("userno", list.getUserno()); // 세션에 값 넣기
			session.setAttribute("deptno", list.getDeptno()); // 세션에 값 넣기
			System.out.println("로그인 성공!  사번 : " +list.getUserno());
			if(list.getUserpw().equals(list.getUserno())) {
				System.out.println("비밀번호 초기상태 ! 비밀번호 변경이 필요합니다.");
				attributes.addFlashAttribute("userno", list);
				return "redirect:/resetPassword";
			}
			
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
			
			System.out.println(userdto.getDeptno());  // 값 잘 가져왔는지 확인
			
			model.addAttribute("pagedto", pagedto);
			model.addAttribute("userdto", userdto);
			return "login/setPw";
		}
		System.out.println("잘못된 접근, 메인 화면으로 돌아갑니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/resetPassword")
	public String resetPW(HttpServletRequest request, Model model) {
		System.out.println("비밀번호 재설정 화면 진입");
		return "login/resetPassword";
	}
	@RequestMapping("/resetPasswordAction")
	public String resetPWAction(HttpServletRequest request, Model model, UserDTO dto) {
		System.out.println("./resetPasswordAction");
		System.out.println("비밀번호 바꿀 직원의 직원번호 : "+dto.getUserno());
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		dao.UpdatePw(dto.getUserno(), dto.getUserpw());
		System.out.println("비밀번호 변경완료 ~~");
		return "redirect:login";
	}
	// Regarding Asynchronous
	@RequestMapping(value = "/findPw",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST ) // , method=RequestMethod.POST // consumes = "application/json"	/*	*/
	public @ResponseBody String findPw(@RequestBody  UserDTO userdto) throws Exception {
		System.out.println("findPw 실행");
		System.out.println("넘겨받은 값 있는지 확인 : " + userdto.getUserno());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.findPw(userdto);

		if (dto != null) {
				System.out.println("모두 일치하는 직원정보 찾았다 ! 부서번호  : " +dto.getDeptno());
		} else {
			System.out.println("DB조회 결과 없음");
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
		System.out.println("세션에 있는 userno : "+ userno);
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.isRightUserno(userno);
		model.addAttribute("dto", dto);
		
		return "login/mypage";
	}
	
	
	
	
	
	
	

}
