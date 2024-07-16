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
public class MemoController {
	
	@Autowired
	public SqlSession sqlSession;
	/* RCommand command = null; */

	
	@RequestMapping("/calendar")
	public String calendar(HttpServletRequest request, Model model) {		
		System.out.println("달력창 진입");
		
		return "memo/calendar";
	}
	@RequestMapping("/memo")
	public String memo(HttpServletRequest request, Model model) {
		System.out.println("메모창 진입");
		
		return "memo/memo";
	}
	
	@RequestMapping("/notice")
	public String notice(HttpServletRequest request, Model model) {
		System.out.println("공지 진입");
		
		return "memo/notice";
	}
	

}
