package kb.keyboard.warrior.memo.command;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.AlertDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dto.AlertDTO;
import kb.keyboard.warrior.dto.NoticeDTO;
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
		ArrayList<NoticeDTO> notice = dao.noticeView(deptno);


		model.addAttribute("notice", notice);
	}
}
