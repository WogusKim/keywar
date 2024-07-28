package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {

	@Autowired
	public SqlSession sqlSession;
	
	
	
	@RequestMapping("/hotNote")
	public String login(HttpServletRequest request, Model model) {		
		System.out.println("hotNoteâ ����");
		return "board/list";
	}
	@RequestMapping("/detailNote")
	public String detailNote(HttpServletRequest request, Model model) {		
		System.out.println("hotNoteâ ����");
		return "board/detailNote";
	}
}
