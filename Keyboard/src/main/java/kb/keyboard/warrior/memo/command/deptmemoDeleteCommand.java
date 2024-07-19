package kb.keyboard.warrior.memo.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.util.Constant;

public class deptmemoDeleteCommand {
	public void execute(Model model, String deptno) { //모델에 인덱스넘버랑 유저 들어가있음.
		// TODO Auto-generated method stub
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request"); //모델에서 리퀘스트 빼.
		String deptno1 = request.getParameter("deptno");  //리퀘스트에서 부서번호 빼.
		String memoid = request.getParameter("memoid"); //리퀘스트에서 인덱스 넘버 빼.
		System.out.println("리퀘스트로 불러온 애(부서번호). " + deptno1); //리퀘스트-부서번호 출력
		System.out.println("리퀘스트로 불러온 애(인덱스넘버). " + memoid); //리퀘스트-인덱스넘버 출력
		System.out.println("세션으로 온애 " + deptno);// 세션 부서번호 출력
		
		if(deptno1.equals(deptno)) {
		SqlSession sqlSession = Constant.sqlSession;
		MemoDao dao = sqlSession.getMapper(MemoDao.class);
		dao.deptmemoDelete(memoid);
		}
	}

}
