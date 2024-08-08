package kb.keyboard.warrior.memo.command;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.AlertDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dto.AlertDTO;
import kb.keyboard.warrior.util.Constant;

public class noticeWriteCommand implements MemoCommand {
	
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		//�𵨿� ���� ������Ʈ,userno,deptno������ݾ�. �Ʒ� ������ �𵨿��� ������Ʈ �����°ž�.
		Map<String, Object> map = model.asMap(); //�𵨿� ����� �ִ� �ֵ��� �����·� ġȯ ��Ʈ���� ������Ʈ
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //Ű�� ȣ���ϸ� ������� ������.
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String color = request.getParameter("color");
		
		String userno = (String) map.get("userno");
		String deptno = (String) map.get("deptno");
		
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		dao.noticeWrite(title,content,color,userno,deptno);
		
		
		AlertDao adao = sqlSession.getMapper(AlertDao.class);
		LoginDao ldao = sqlSession.getMapper(LoginDao.class);
		
		List<String> members = (ldao.getAllDeptMember(deptno));
		System.out.println("���� ����� ������ ����� ��  : "+members.size());
		
		AlertDTO dto = new AlertDTO();
		// ���� ����� ��� �̸� ã�Ƽ� �̸� ���
		String writerName = ldao.isRightUserno(userno).getUsername(); 
		dto.setMessage(writerName + "���� ���� ������ ����Ͽ����ϴ�.");	
		dto.setCategory("notice");
		if(members.size()!=0) {
			System.out.println("�������� alert �߰� ���� !");
			for(String userno1 : members) {
				if(userno1.equals(userno)) 
					continue;
				
				dto.setUserno(userno1);
				System.out.println(userno1 + "�Կ���  alert �߰�.");
				adao.addNoticeAlert(dto);
			}
		}
		
	}

}
