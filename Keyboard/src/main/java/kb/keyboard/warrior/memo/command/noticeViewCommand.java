package kb.keyboard.warrior.memo.command;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;

public class noticeViewCommand implements MemoCommand {

	private String userno;
	private String deptno;

	public noticeViewCommand(String userno, String deptno) {
		this.userno = userno;
		this.deptno = deptno;
	}

	@Override
	public void execute(Model model) {
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		System.out.println("11 " + deptno);
		model.addAttribute("notice", dao.noticeView(deptno));
	}
}
