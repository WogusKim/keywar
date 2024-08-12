package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;

public class deptmemoWriteCommand implements MemoCommand {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap(); //�𵨿� ����� �ִ� �ֵ��� �����·� ġȯ ��Ʈ���� ������Ʈ
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //Ű�� ȣ���ϸ� ������� ������.
		String deptmemocontent = request.getParameter("deptmemocontent");
		String color = request.getParameter("memocolor"); // ���� ���� ��������
		
		String userno = (String) map.get("userno");
		String deptno = (String) map.get("deptno");
		
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		dao.deptmemoWrite(deptno, userno, deptmemocontent,color);

	}

}
