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

import kb.keyboard.warrior.dao.CommentDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.CommentDTO;
import kb.keyboard.warrior.dto.ResultDTO;

@Controller
public class BoardController {

	@Autowired
	public SqlSession sqlSession;

	@RequestMapping("/hotNote")
	public String wikiDetail(Model model, @RequestParam("id") int id, HttpSession session) {
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		String wikiData = dao.getData(id);
		System.out.println("��Ű���������� : " + id);
		session.setAttribute("WikiId", id);

		if (wikiData == null) {
			System.out.println("�ʱⰪ�� �����մϴ�.");
			wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"������Ʈ ������ �����մϴ�.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"������ ��Ʈ�� �ۼ��Ͽ� ���� ȿ���� ����������!\"}}],\"version\":\"2.30.2\"}";
		}
		model.addAttribute("editorData", wikiData);

		return "wiki/editorDetail";
	}

	public String login(HttpServletRequest request, Model model) {
		System.out.println("hotNoteâ ����");
		return "board/list";
	}

	@RequestMapping("/detailNote")
	public String Detail(Model model, @RequestParam("id") int id, HttpSession session) {
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		String wikiData = dao.getData(id);
		System.out.println("��Ű���������� : " + id);
		session.setAttribute("WikiId", id);

		if (wikiData == null) {
			System.out.println("�ʱⰪ�� �����մϴ�.");
			wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"������Ʈ ������ �����մϴ�.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"������ ��Ʈ�� �ۼ��Ͽ� ���� ȿ���� ����������!\"}}],\"version\":\"2.30.2\"}";
		}
		model.addAttribute("editorData", wikiData);

		CommentDao cdao = sqlSession.getMapper(CommentDao.class); 
		List<CommentDTO> comments = cdao.getComment(id+"");
		if(comments!=null) {
			System.out.println("��� �ҷ����� �Ϸ�");
			model.addAttribute("comments", comments);
		}
		
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
		}else {
			rdto.setResult("fail - ��� ��� �� ������ �߻��Ͽ����ϴ�.");
		}
		
//		System.out.println(dto.getContent());
//		System.out.println(dto.getUserno());
//		System.out.println(dto.getTargetid());
		
	
	
		String json = mapper.writeValueAsString(rdto);
		
		return json;
	}
}
