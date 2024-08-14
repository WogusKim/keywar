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
import kb.keyboard.warrior.dto.FollowDTO;
import kb.keyboard.warrior.dto.LikeDTO;
import kb.keyboard.warrior.dto.MenuDTO;
import kb.keyboard.warrior.dto.ResultDTO;
import kb.keyboard.warrior.dto.UserDTO;

@Controller
public class BoardController {

	@Autowired
	public SqlSession sqlSession;

	@RequestMapping("/hotNote")
	public String wikiDetail(@RequestParam(value = "category", required = false) String category, Model model, HttpSession session) {

		System.out.println("hotNoteâ ����");
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		List<BoardDTO> list;
		
		
	    if (category != null && !category.isEmpty()) {
	        list = dao.getFilteredPost(category);
	    } else {
	        list = dao.getAllPost();
	    }
		
		if(list !=null) {
			model.addAttribute("list", list);
		}
		
	    model.addAttribute("selectedCategory", category);
		System.out.println("����ī�װ�: "+category);


		return "board/list";
	}
	
	@RequestMapping("/profile")
	public String profile(Model model, HttpSession session, @RequestParam("userno") String userno) {
		System.out.println(userno+"�� profileâ ����");
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		LoginDao ldao = sqlSession.getMapper(LoginDao.class);
		List<BoardDTO> list = dao.getMyPost(userno);
		UserDTO ldto = ldao.isRightUserno(userno);
		BoardDTO redord = dao.getOnesRecord(userno);
		AlertDao adao = sqlSession.getMapper(AlertDao.class);
		//�α��� �� ������ ������ȣ 
		String loginUserno = (String)session.getAttribute("userno");
		FollowDTO fdto = new FollowDTO(loginUserno, userno);
		
		if(list !=null) {
			model.addAttribute("list", list);
		}
		
		if(ldto!=null)
			if(adao.checkFollow(fdto)!=null && adao.checkFollow(fdto).getStatus().equals("1")) {
				ldto.setIsFollow("1");
			}else {
				ldto.setIsFollow("0");
			}
			model.addAttribute("writer", ldto);
			
		if(redord!=null)
			model.addAttribute("redord", redord);
		
		return "board/list2";
	}


	@RequestMapping("/detailNote")
	public String Detail(Model model, @RequestParam("id") int id, HttpSession session) {
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		LoginDao ldao = sqlSession.getMapper(LoginDao.class);
		System.out.println("��Ű���������� : " + id);
		Integer isopen = 0;
		isopen = dao.checkItIsopen(id+"");
		if(isopen==null||isopen==0) {
			System.out.println("�߸��� �����Դϴ�.");
			return "redirect:hotNote";
		}
		String wikiData = dao.getData(id);
		session.setAttribute("WikiId", id);

		if (wikiData == null) {
			System.out.println("�ʱⰪ�� �����մϴ�.");
			wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"������Ʈ ������ �����մϴ�.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"������ ��Ʈ�� �ۼ��Ͽ� ���� ȿ���� ����������!\"}}],\"version\":\"2.30.2\"}";
		}
		model.addAttribute("editorData", wikiData); //��Ű�����
		
		MenuDTO menuDto = dao.getMenuDetail(id);
		model.addAttribute("menuDto", menuDto); //�޴���
		
		//�ۼ��� ���� ã��
		UserDTO dto = ldao.isRightUserno(menuDto.getUserno());
		model.addAttribute("writer", dto);
//		String writerName = dao.getWriterNickName(menuDto.getUserno()); //�ۼ��� �̸�ã�ƾ���.
//		model.addAttribute("writerNickName", writerName);

		CommentDao cdao = sqlSession.getMapper(CommentDao.class); 
		List<CommentDTO> comments = cdao.getComment(id+"");
		if(comments!=null) {
			System.out.println("��� �ҷ����� �Ϸ�");
			model.addAttribute("comments", comments);
		}
		
		int like = cdao.checkLikeByContent(id+"");
		model.addAttribute("like", like);
		
		
	    //��ȸ�� ó��
	    Long lastViewTime = (Long) session.getAttribute("lastViewTime_" + id); //���ǿ��� ������ ��ȸ��������Ʈ �ð� ��ȸ
	    long currentTime = System.currentTimeMillis();//����ð�
	    
	    if (lastViewTime == null || (currentTime - lastViewTime) > 10 * 60 * 1000) { // 10�� �̻� �����ٸ�
	        Integer hits = dao.getHitsById(id); // ���� ��ȸ�� üũ
	        if (hits != null) {
	            // ��ȸ�� update
	            dao.updateHits(id);
	            hits++;
	        } else {
	            // ��ȸ�� insert
	            dao.insertHits(id);
	            hits = 1;
	        }
	        session.setAttribute("lastViewTime_" + id, currentTime); // ������ ��ȸ �ð� ������Ʈ
	    }
	    model.addAttribute("hits", dao.getHitsById(id)); // �ֽ� ��ȸ�� ��������
		
		return "board/detailNote";
	}

	@RequestMapping(value ="/addConmment" , method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addConmment(Model model, @RequestBody CommentDTO dto, HttpSession session) throws Exception {
		System.out.println("addConmment ����");
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
			// �� ������� �˸��� ������. (�ۼ��� ��ȣ�� �Խñ� �ۼ��� ������ȣ ã�� !)
			BoardDTO bdto = wdao.findWriterName(dto.getTargetid());
			// �ۼ��ڿ� �� �ۼ��ڰ� ���ٸ� �˶� X
			if(bdto.getUserno().equals(dto.getUserno())) {
				return mapper.writeValueAsString(rdto);
			};
			
			// �� ����� ��� �� ���.
			String commentWriter = ldao.isRightUserno(dto.getUserno()).getUsername();
			
			AlertDTO adto = new AlertDTO();
			adto.setMessage(commentWriter+"���� ȸ������ �Խñۿ� ����� ������ϴ�.");	
			adto.setUserno(bdto.getUserno());
			adto.setDetail(dto.getTargetid());
			
	        AlertDao adao = sqlSession.getMapper(AlertDao.class);
	        System.out.println(bdto.getUsername() + "�Կ���  alert �߰�.");
			adao.addCommentAlert(adto);

			
		}else {
			rdto.setResult("fail - ��� ��� �� ������ �߻��Ͽ����ϴ�.");
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
			System.out.println("�߸��� ������.");
		}
		return "redirect:detailNote?id="+id;
	}
	
	@RequestMapping(value ="/likeUp" , method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String likeUp(Model model, HttpSession session, @RequestBody LikeDTO dto) {
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		System.out.println("�Ѱ� ���� userno : " +dto.getUserno());
		System.out.println("�Ѱ� ���� targetId : " +dto.getTargetid());
		
		int result = 0;
		result = dao.checkLike(dto);
		if(result == 0) {
			System.out.println("���ƿ� ��ϵ� �� ������ ~");
			dao.addLike(dto);
			
			// �˸���� �߰�
			WikiDao wdao = sqlSession.getMapper(WikiDao.class); 
			LoginDao ldao = sqlSession.getMapper(LoginDao.class); 
			// �� ������� �˸��� ������. (�ۼ��� ��ȣ�� �Խñ� �ۼ��� ������ȣ ã�� !)
			BoardDTO bdto = wdao.findWriterName(dto.getTargetid());
			// �ۼ��ڿ� �� �ۼ��ڰ� ���ٸ� �˶� X
			if(bdto.getUserno().equals(dto.getUserno())) {
				 return "{\"status\":\"success\"}";
			};
			
			// �� ����� ���ƿ� ���� ��� ���.
			String commentWriter = ldao.isRightUserno(dto.getUserno()).getUsername();
			
			AlertDTO adto = new AlertDTO();
			adto.setMessage(commentWriter+"���� ȸ������ �Խñ��� �����մϴ�.");	
			adto.setUserno(bdto.getUserno());
			adto.setDetail(dto.getTargetid());
			
	        AlertDao adao = sqlSession.getMapper(AlertDao.class);
	        System.out.println(bdto.getUsername() + "�Կ���  alert �߰�.");
			adao.addLikeAlert(adto);
			
		}else {
			return "{\"status\":\"duplicate\"}";
		}
		 return "{\"status\":\"success\"}";
	}
	
	
	//�ȷο� ���� �ٲٴ� �޼ҵ�
	@RequestMapping(value ="/followUp" , method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String followUp(Model model, HttpSession session, @RequestBody FollowDTO dto) {
		AlertDao dao = sqlSession.getMapper(AlertDao.class);
		LoginDao ldao = sqlSession.getMapper(LoginDao.class);
		System.out.println("�Ѱ� ���� userno : " +dto.getUserno());
		System.out.println("�Ѱ� ���� getTargetUserno : " +dto.getTargetUserno());
		System.out.println("�Ѱ� ���� status : " +dto.getStatus());
		
		FollowDTO dbDTO = dao.checkFollow(dto);
		if(dbDTO == null) {
			dao.addFollow(dto);
			
			String message = ldao.isRightUserno(dto.getUserno()).getNickname() + "���� ȸ������ �����Ͽ����ϴ�.";
			System.out.println("�˸� ��ϵ� �޼��� : " + message);
			AlertDTO adto = new AlertDTO(dto.getTargetUserno(), message);
			dao.addFollowAlert(adto);
			
			return "{\"status\":\"success\"}";
		}else {
			if(dbDTO.getStatus().equals("1")) {
				dbDTO.setStatus("0");
				System.out.println("���ȷο���.");
				dao.changeFollowStatus(dbDTO);
				 return "{\"status\":\"unFollow\"}";
			}else {
				dbDTO.setStatus("1");
				System.out.println("�ȷο���.");
				dao.changeFollowStatus(dbDTO);
				//�ȷο� �ϸ� �˸��� ������.
				String message = ldao.isRightUserno(dto.getUserno()).getNickname() + "���� ȸ������ �����Ͽ����ϴ�.";
				System.out.println("�˸� ��ϵ� �޼��� : " + message);
				AlertDTO adto = new AlertDTO(dto.getTargetUserno(), message);
				dao.addFollowAlert(adto);
				
				 return "{\"status\":\"success\"}";
			}
		}

	}
	
}
