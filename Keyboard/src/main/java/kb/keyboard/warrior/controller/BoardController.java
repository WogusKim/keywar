package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kb.keyboard.warrior.dao.WikiDao;

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

		return "board/detailNote";
	}
}
