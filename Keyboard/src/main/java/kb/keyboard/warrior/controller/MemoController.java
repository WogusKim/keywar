package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kb.keyboard.warrior.memo.command.MemoCommand;
import kb.keyboard.warrior.memo.command.TodoViewCommand;
import kb.keyboard.warrior.util.Constant;




@Controller
public class MemoController {
	
	MemoCommand command = null;
	private SqlSession sqlSession;
	
	@Autowired
	public MemoController(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		Constant.sqlSession = this.sqlSession;
	}

	
	
	@RequestMapping("/calendar")
	public String calendar(HttpServletRequest request, Model model) {		
		System.out.println("달력창 진입");
		
		return "memo/calendar";
	}
	
	@RequestMapping("/todo") // todolist view
	public String todoView(Model model) {
		System.out.println("todoView()");
		command = new TodoViewCommand();
		command.execute(model);
		return "todo";
	}
	
//	@RequestMapping("/memo")
//	public String memo(HttpServletRequest request, Model model) {
//		System.out.println("메모창 진입");
//		
//		return "memo/memo";
//	}
	
//	@RequestMapping("/notice")
//	public String notice(HttpServletRequest request, Model model) {
//		System.out.println("공지 진입");
//		
//		return "memo/notice";
//	}
//	

}
