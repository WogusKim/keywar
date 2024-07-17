package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;


public class TodoViewCommand implements MemoCommand{

	 private String userno;

	    public TodoViewCommand(String userno) {
	        this.userno = userno;
	    }

	    @Override
	    public void execute(Model model) {
	        SqlSession sqlSession = Constant.sqlSession;
	        MemoDao dao = sqlSession.getMapper(MemoDao.class);
	        model.addAttribute("list", dao.todoView(userno));
	    }

}
