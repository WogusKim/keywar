package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;

public class deptmemoDeleteCommand {
	public void execute(Model model, String deptno) { //�𵨿� �ε����ѹ��� ���� ������.
		// TODO Auto-generated method stub
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //�𵨿��� ������Ʈ ��.
		String deptno1 = request.getParameter("deptno");  //������Ʈ���� �μ���ȣ ��.
		String memoid = request.getParameter("memoid"); //������Ʈ���� �ε��� �ѹ� ��.
		System.out.println("������Ʈ�� �ҷ��� ��(�μ���ȣ). " + deptno1); //������Ʈ-�μ���ȣ ���
		System.out.println("������Ʈ�� �ҷ��� ��(�ε����ѹ�). " + memoid); //������Ʈ-�ε����ѹ� ���
		System.out.println("�������� �¾� " + deptno);// ���� �μ���ȣ ���
		
		if(deptno1.equals(deptno)) {
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		dao.deptmemoDelete(memoid);
		}
	}

}
