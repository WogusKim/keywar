package kb.keyboard.warrior.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kb.keyboard.warrior.dao.AlertDao;
import kb.keyboard.warrior.dao.CommentDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.AlertDTO;
import kb.keyboard.warrior.dto.BoardDTO;
import kb.keyboard.warrior.dto.CommentDTO;
import kb.keyboard.warrior.dto.LikeDTO;
import kb.keyboard.warrior.dto.MenuDTO;
import kb.keyboard.warrior.dto.ResultDTO;

@Controller
public class BoardController {

	@Autowired
	public SqlSession sqlSession;

	@RequestMapping("/hotNote")
	public String wikiDetail(Model model, HttpSession session) {
		System.out.println("hotNote창 진입");
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		List<BoardDTO> list = dao.getAllPost();
		
		if(list !=null) {
			model.addAttribute("list", list);
		}
		
		return "board/list";
	}



	@RequestMapping("/detailNote")
	public String Detail(Model model, @RequestParam("id") int id, HttpSession session) {
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		System.out.println("위키디테일진입 : " + id);
		Integer isopen = 0;
		isopen = dao.checkItIsopen(id+"");
		if(isopen==null||isopen==0) {
			System.out.println("잘못된 접근입니다.");
			return "redirect:hotNote";
		}
		String wikiData = dao.getData(id);
		session.setAttribute("WikiId", id);

		if (wikiData == null) {
			System.out.println("초기값을 제공합니다.");
			wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"업무노트 개설을 축하합니다.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"열심히 노트를 작성하여 업무 효율을 높혀보세요!\"}}],\"version\":\"2.30.2\"}";
		}
		model.addAttribute("editorData", wikiData); //위키내용상세
		
		MenuDTO menuDto = dao.getMenuDetail(id);
		model.addAttribute("menuDto", menuDto); //메뉴상세
		
		String writerName = dao.getWriterNickName(menuDto.getUserno()); //작성자 이름찾아야함.
		model.addAttribute("writerNickName", writerName);

		CommentDao cdao = sqlSession.getMapper(CommentDao.class); 
		List<CommentDTO> comments = cdao.getComment(id+"");
		if(comments!=null) {
			System.out.println("댓글 불러오기 완료");
			model.addAttribute("comments", comments);
		}
		
		int like = cdao.checkLikeByContent(id+"");
		model.addAttribute("like", like);
		
		
	    //조회수 처리
	    Long lastViewTime = (Long) session.getAttribute("lastViewTime_" + id); //세션에서 마지막 조회수업데이트 시간 조회
	    long currentTime = System.currentTimeMillis();//현재시간
	    
	    if (lastViewTime == null || (currentTime - lastViewTime) > 10 * 60 * 1000) { // 10분 이상 지났다면
	        Integer hits = dao.getHitsById(id); // 기존 조회수 체크
	        if (hits != null) {
	            // 조회수 update
	            dao.updateHits(id);
	            hits++;
	        } else {
	            // 조회수 insert
	            dao.insertHits(id);
	            hits = 1;
	        }
	        session.setAttribute("lastViewTime_" + id, currentTime); // 마지막 조회 시간 업데이트
	    }
	    model.addAttribute("hits", dao.getHitsById(id)); // 최신 조회수 가져오기
		
		return "board/detailNote";
	}

	@RequestMapping(value ="/addConmment" , method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addConmment(Model model, @RequestBody CommentDTO dto, HttpSession session) throws Exception {
		System.out.println("addConmment 진입");
		CommentDao dao = sqlSession.getMapper(CommentDao.class); 
		ResultDTO rdto = new ResultDTO();
		ObjectMapper mapper = new ObjectMapper();
		
		if(session.getAttribute("userno")==null) {
			rdto.setResult("fail - You are not logged in.");
			
			return   mapper.writeValueAsString(rdto);
		}
		
		if(dto.getUserno()!=null){
			dao.addComment(dto);
			rdto.setResult("success");
			WikiDao wdao = sqlSession.getMapper(WikiDao.class); 
			LoginDao ldao = sqlSession.getMapper(LoginDao.class); 
			// 이 사람한테 알림이 가야함. (작성글 번호로 게시글 작성자 직원번호 찾기 !)
			BoardDTO bdto = wdao.findWriterName(dto.getTargetid());
			// 작성자와 글 작성자가 같다면 알람 X
			if(bdto.getUserno().equals(dto.getUserno())) {
				return mapper.writeValueAsString(rdto);
			};
			
			// 이 사람이 댓글 쓴 사람.
			String commentWriter = ldao.isRightUserno(dto.getUserno()).getUsername();
			
			AlertDTO adto = new AlertDTO();
			adto.setMessage(commentWriter+"님이 회원님의 게시글에 댓글을 남겼습니다.");	
			adto.setUserno(bdto.getUserno());
			adto.setDetail(dto.getTargetid());
			
	        AlertDao adao = sqlSession.getMapper(AlertDao.class);
	        System.out.println(bdto.getUsername() + "님에게  alert 추가.");
			adao.addCommentAlert(adto);

			
		}else {
			rdto.setResult("fail - 댓글 등록 중 오류가 발생하였습니다.");
		}
	
		String json = mapper.writeValueAsString(rdto);
		
		return json;
	}
	
	@RequestMapping("/deleteComment")
	public String commentDelete(Model model, @RequestParam("id") int id, @RequestParam("commentid") int commentid, HttpSession session) {
		
		CommentDao dao = sqlSession.getMapper(CommentDao.class); 
		String writer = dao.findWhoWrote(commentid+"");
		if(session.getAttribute("userno").equals(writer)) {
			dao.commentDelete(commentid+"");
		}else {
			System.out.println("잘못된 접근임.");
		}
		return "redirect:detailNote?id="+id;
	}
	
	@RequestMapping(value ="/likeUp" , method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String likeUp(Model model, HttpSession session, @RequestBody LikeDTO dto) {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		System.out.println("넘겨 받은 userno : " +dto.getUserno());
		System.out.println("넘겨 받은 targetId : " +dto.getTargetid());
		
		int result = 0;
		result = dao.checkLike(dto);
		if(result == 0) {
			System.out.println("좋아요 등록된 거 없지롱 ~");
			dao.addLike(dto);
			
			// 알림기능 추가
			WikiDao wdao = sqlSession.getMapper(WikiDao.class); 
			LoginDao ldao = sqlSession.getMapper(LoginDao.class); 
			// 이 사람한테 알림이 가야함. (작성글 번호로 게시글 작성자 직원번호 찾기 !)
			BoardDTO bdto = wdao.findWriterName(dto.getTargetid());
			// 작성자와 글 작성자가 같다면 알람 X
			if(bdto.getUserno().equals(dto.getUserno())) {
				 return "{\"status\":\"success\"}";
			};
			
			// 이 사람이 좋아요 누른 사람 사람.
			String commentWriter = ldao.isRightUserno(dto.getUserno()).getUsername();
			
			AlertDTO adto = new AlertDTO();
			adto.setMessage(commentWriter+"님이 회원님의 게시글을 좋아합니다.");	
			adto.setUserno(bdto.getUserno());
			adto.setDetail(dto.getTargetid());
			
	        AlertDao adao = sqlSession.getMapper(AlertDao.class);
	        System.out.println(bdto.getUsername() + "님에게  alert 추가.");
			adao.addLikeAlert(adto);
			
		}else {
			return "{\"status\":\"duplicate\"}";
		}
		 return "{\"status\":\"success\"}";
	}
	
	
}
