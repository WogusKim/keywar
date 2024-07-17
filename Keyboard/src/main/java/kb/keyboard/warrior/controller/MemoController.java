package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kb.keyboard.warrior.memo.command.MemoCommand;
import kb.keyboard.warrior.memo.command.MemoViewCommand;
import kb.keyboard.warrior.memo.command.TodoViewCommand;
import kb.keyboard.warrior.memo.command.noticeViewCommand;
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
    public String todoView(HttpSession session, Model model) {
        System.out.println("todoView()");

        String userno = (String) session.getAttribute("userno");
        if (userno != null) {
            command = new TodoViewCommand(userno);
            command.execute(model);
        } else {
            System.out.println("User number not found in session.");
        }

        return "todo";
    }
	
    @RequestMapping("/memo") //memo view
    public String memoView(HttpSession session, Model model) {
        System.out.println("memoView()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("로그인 된 사람 누구야? " + userno);
        System.out.println("부점코드 누구야? " + deptno);
        if (userno != null && deptno != null) {
            command = new MemoViewCommand(userno, deptno);
            command.execute(model);
        } else {
            System.out.println("User number or dept number not found in session.");
        }

        return "memo";
    }
	
    @RequestMapping("/notice") //notice view
    public String noticeView(HttpSession session, Model model) {
        System.out.println("noticeView()");

        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");
        System.out.println("로그인 된 사람 누구야? " + userno);
        System.out.println("부점코드 누구야? " + deptno);
        if (userno != null && deptno != null) {
            command = new noticeViewCommand(userno, deptno);
            command.execute(model);
        } else {
            System.out.println("User number or dept number not found in session.");
        }

        return "notice";
    }
}
