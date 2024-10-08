package kb.keyboard.warrior.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kb.keyboard.warrior.dao.AlertDao;
import kb.keyboard.warrior.dao.CommentDao;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.fasterxml.jackson.databind.SerializationFeature;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.*;
import kb.keyboard.warrior.util.PasswordEncoderUtil;

@Controller
public class LoginController {
	
	@Autowired
	public SqlSession sqlSession;
	
	// Regarding login
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model, HttpSession session) {		
		System.out.println("로그인 창 입장");
		if(session.getAttribute("userno")!=null) {
			//이미 로그인 상태라면 메인으로 이동!
			return "redirect:main";
		}
		return "login/login";
	}
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, Model model) {		
		HttpSession session = request.getSession();
		session.invalidate(); // 세션 정보 삭제! 
		System.out.println("로그아웃 실행");
		return "redirect:login";
	}
	
//	@RequestMapping("/loginAction")
	@RequestMapping(value ="/getLogin" , method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String loginAction(HttpServletRequest request, Model model,@RequestBody UserDTO dto, RedirectAttributes attributes, HttpSession session) {
		System.out.println("로그인메소드 진입");
		System.out.println("입력한 직원번호 : "+ dto.getUserno());
		System.out.println("입력한 비밀번호 : "+ dto.getUserpw());
		
		UserDTO fromDbDto = new UserDTO();
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		fromDbDto = dao.isRightUserno(dto.getUserno());
		if(fromDbDto == null) {
			System.out.println("잘못된 직원번호입니다.");
			return "{\"status\":\"usernoIncorrect\"}";
		}else if(dto.getUserno().equals(fromDbDto.getUserpw())) {
			System.out.println("비밀번호 초기 설정 상태 ! 비밀번호 변경이 필요합니다.");
			attributes.addFlashAttribute("userno", fromDbDto);
			return "{\"status\":\"firstLogin\"}";
//			return "redirect:/resetPassword";
		}else if(PasswordEncoderUtil.matches(dto.getUserpw(), fromDbDto.getUserpw())) {
			System.out.println("로그인 성공");
			session.setAttribute("userno", fromDbDto.getUserno()); // 세션에 정보 저장
			session.setAttribute("deptno", fromDbDto.getDeptno()); // 세션에 정보 저장
      
			//배경색상 처리
			String bgcolor = dao.getColor(fromDbDto.getUserno());
			if (bgcolor == null) {
				bgcolor = "green";
			}
			session.setAttribute("bgcolor", bgcolor);

			return "{\"status\":\"success\", \"username\":\""+fromDbDto.getUsername()+"\"}";
		}else {
			System.out.println("직원번호는 맞는데 비밀번호 오류");
			return "{\"status\":\"userpwIncorrect\"}";
		}
	
	}
	
	// Regarding password reset 
	@RequestMapping("/testPage")
	public String testPage(HttpServletRequest request, Model model) {
		
		return "login/testPage";
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
			LoginDao dao = sqlSession.getMapper(LoginDao.class);
			userdto = dao.isRightUserno(userdto.getUserno());
			System.out.println(userdto.getDeptno());  // 잘 옮겨왔는지 확인 비밀번호 재설정으로 한 사람의 DB에 있는 지 확인
			
			model.addAttribute("pagedto", pagedto);
			model.addAttribute("userdto", userdto);
			return "login/setPw";
		}
		System.out.println("잘못된 접근, 메인 화면으로 돌아갑니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/resetPassword")
	public String resetPW(HttpServletRequest request, Model model, UserDTO userdto) {
		System.out.println("비밀번호 재설정 화면 입장");
		System.out.println(userdto.getUserno());
		
		
		model.addAttribute("userdto", userdto);
		return "login/resetPassword";
	}
	@RequestMapping("/resetPasswordAction")
	public String resetPWAction(HttpServletRequest request, Model model, UserDTO dto) {
		System.out.println("./resetPasswordAction");
		System.out.println("비밀번호 재설정할 직원의 직원번호 : "+dto.getUserno());
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		String encodedPassword  = PasswordEncoderUtil.encodePassword(dto.getUserpw());
		
		dao.UpdatePw(dto.getUserno(), encodedPassword);
		dao.defaultAlert(dto.getUserno());
		System.out.println("비밀번호 변경 완료 ~~");
		return "redirect:login";
	}
	// Regarding Asynchronous
	@RequestMapping(value = "/findPw",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST ) // , method=RequestMethod.POST // consumes = "application/json"	/*	*/
	public @ResponseBody String findPw(@RequestBody  UserDTO userdto) throws Exception {
		System.out.println("findPw 실행");
		System.out.println("입력한 직원번호 확인 : " + userdto.getUserno());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.findPw(userdto);

		if (dto != null) {
				System.out.println("모두 일치하는 직원정보 발견 ! 부서번호  : " +dto.getDeptno());
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
		
		//내가 작성한 댓글 가져오기
		CommentDao cdao = sqlSession.getMapper(CommentDao.class);
		List<CommentDTO> list = cdao.getMyComment(userno);
		if(list!=null)
			model.addAttribute("comment", list);
		WikiDao wdao = sqlSession.getMapper(WikiDao.class);
		AlertDao ldao = sqlSession.getMapper(AlertDao.class);
		List<BoardDTO> mypost = wdao.getMyPost(userno);
		List<BoardDTO> likedpost = wdao.getLikedPost(userno);
		List<UserDTO> myFollowing = ldao.checkMyFollowing(userno);
		List<UserDTO> myFollower = ldao.checkMyFollower(userno);
		
		int myLikeCount = 0;
		myLikeCount = wdao.myTotalLike(userno);
		
		int myFollowCount = 0;
		myFollowCount = ldao.checkMyFollowers(userno);
		if(mypost!=null)
			model.addAttribute("mypost", mypost);
		if(likedpost!=null)
			model.addAttribute("likedpost", likedpost);
		if(myFollowing!=null)
			model.addAttribute("myFollowing", myFollowing);
		if(myFollower!=null)
			model.addAttribute("myFollower", myFollower);
		
		model.addAttribute("myLikeCount", myLikeCount);
		model.addAttribute("myFollowCount", myFollowCount);
		
		return "login/mypage";
	}
	
	// Regarding mypage
	@RequestMapping("/editProfile")
	public String editProfile(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String userno = (String) session.getAttribute("userno");	
		System.out.println("세션에 있는 userno : "+ userno);
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UserDTO dto = dao.isRightUserno(userno);
		model.addAttribute("dto", dto);
		
		return "login/editProfile";
	}
	
	// Regarding Asynchronous  -- 비동기 처리함수 미사용으로 변경
	@RequestMapping(value = "/changeNickname",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST ) // , method=RequestMethod.POST // consumes = "application/json"	/*	*/
	public @ResponseBody String changeNickname(@RequestBody  UserDTO userdto) throws Exception {
		System.out.println("changeNickname 실행");
		System.out.println("변경할 닉네임 확인 : " + userdto.getNickname());
		System.out.println("userno 확인 : " + userdto.getUserno());
		
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		dao.changeNickname(userdto.getUserno(),  userdto.getNickname());
		UserDTO dto = dao.isRightUserno(userdto.getUserno());
		
		if (dto != null) {
				System.out.println("모두 일치하는 직원정보 발견 ! 부서번호  : " +dto.getDeptno());
		} else {
			System.out.println("DB조회 결과 없음");
			dto = new UserDTO();
		}

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(dto);
		
		return json;
	}
	
	@RequestMapping(value = "/uploadProfilePicture", method = RequestMethod.POST)
    public String uploadProfilePicture(HttpServletRequest request, @RequestParam("picture") MultipartFile file, RedirectAttributes attributes) {
        HttpSession session = request.getSession();
        String userno = (String) session.getAttribute("userno");

        if (file.isEmpty()) {
            attributes.addFlashAttribute("message", "파일이 업로드되지 않았습니다.");
            return "redirect:/editProfile";
        }

        try {
            InputStream inputStream = file.getInputStream();
            LoginDao dao = sqlSession.getMapper(LoginDao.class);
            dao.updateUserProfilePicture(userno, inputStream);
            attributes.addFlashAttribute("message", "프로필 사진이 성공적으로 업로드되었습니다.");
        } catch (IOException e) {
            e.printStackTrace();
            attributes.addFlashAttribute("message", "파일 업로드 중 오류가 발생했습니다.");
        }

        return "redirect:/editProfile";
    }

    @RequestMapping("/getUserProfilePicture")
    public void getUserProfilePicture(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String userno = (String) session.getAttribute("userno");

        LoginDao dao = sqlSession.getMapper(LoginDao.class);
        UserDTO user = dao.getUserProfile(userno);

        if (user != null && user.getPicture() != null) {
            response.setContentType("image/jpeg");
            try {
                response.getOutputStream().write(user.getPicture());
                response.getOutputStream().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    @RequestMapping("/getUserProfilePicture2")
    public void getUserProfilePicture2(@RequestParam("userno") String userno, HttpServletRequest request, HttpServletResponse response) {
    	
    	LoginDao dao = sqlSession.getMapper(LoginDao.class);
    	UserDTO user = dao.getUserProfile(userno);
    	
    	if (user != null && user.getPicture() != null) {
    		response.setContentType("image/jpeg");
    		try {
    			response.getOutputStream().write(user.getPicture());
    			response.getOutputStream().flush();
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	}
    }

}
