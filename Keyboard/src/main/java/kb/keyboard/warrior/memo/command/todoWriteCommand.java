package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;

public class todoWriteCommand{

	public void execute(Model model, String userno) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap(); //모델에 담겨져 있는 애들을 맵형태로 치환 스트링은 리퀘스트
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //키를 호출하면 밸류값을 가져옴.
		
		String task = request.getParameter("task");
		
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		dao.todoWrite(userno,task);


	}

}
