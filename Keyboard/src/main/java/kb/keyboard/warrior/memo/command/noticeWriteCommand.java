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
		//모델에 지금 리퀘스트,userno,deptno들어있잖아. 아래 두줄은 모델에서 리퀘스트 꺼내는거야.
		Map<String, Object> map = model.asMap(); //모델에 담겨져 있는 애들을 맵형태로 치환 스트링은 리퀘스트
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //키를 호출하면 밸류값을 가져옴.
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
		System.out.println("공지 등록한 부점의 사용자 수  : "+members.size());
		
		AlertDTO dto = new AlertDTO();
		// 공지 등록한 사람 이름 찾아서 이름 등록
		String writerName = ldao.isRightUserno(userno).getUsername(); 
		dto.setMessage(writerName + "님이 부점 공지를 등록하였습니다.");	
		dto.setCategory("notice");
		if(members.size()!=0) {
			System.out.println("공지사항 alert 추가 시작 !");
			for(String userno1 : members) {
				if(userno1.equals(userno)) 
					continue;
				
				dto.setUserno(userno1);
				System.out.println(userno1 + "님에게  alert 추가.");
				adao.addNoticeAlert(dto);
			}
		}
		
	}

}
