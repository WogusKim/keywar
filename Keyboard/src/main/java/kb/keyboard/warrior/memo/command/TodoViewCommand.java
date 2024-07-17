package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;


public class TodoViewCommand implements MemoCommand{
	
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		//model.addAttribute("list", dao.noticeView()); // 데이터 사라지면 안되니까, list라는 이름으로 model에 담아야지. 그래야 컨트롤러 통해서 뷰에 갈 수 있지.
		
	}

}
