package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;

public class mymemoDeleteCommand {
	
	public void execute(Model model, String userno) { //�𵨿� �ε����ѹ��� ���� ������.
		// TODO Auto-generated method stub
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //�𵨿��� ������Ʈ ��.
		String userno1 = request.getParameter("userno");  //������Ʈ���� ���� ��.
		String memoid = request.getParameter("memoid"); //������Ʈ���� �ε��� �ѹ� ��.
		System.out.println("������Ʈ�� �ҷ��� ��(����). " + userno1); //������Ʈ-���� ���
		System.out.println("������Ʈ�� �ҷ��� ��(�ε����ѹ�). " + memoid); //������Ʈ-�ε����ѹ� ���
		System.out.println("�������� �¾� " + userno);// ���� ���� ���
		
		if(userno1.equals(userno)) {
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		dao.mymemoDelete(memoid);
		}
	}

}
