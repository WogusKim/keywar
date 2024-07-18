package kb.keyboard.warrior.memo.command;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dto.MyMemoDTO;
import kb.keyboard.warrior.dto.DeptMemoDTO;
import kb.keyboard.warrior.util.Constant;


public class MemoViewCommand {

    public void execute(Model model, String userno, String deptno) {
        SqlSession sqlSession = Constant.sqlSession;
        MemoDao dao = sqlSession.getMapper(MemoDao.class);
        
        ArrayList<MyMemoDTO> listMyMemo = dao.memoView1(userno);
        ArrayList<DeptMemoDTO> listDeptMemo = dao.memoView2(deptno);
        model.addAttribute("memo1", listMyMemo);
        model.addAttribute("memo2", listDeptMemo);
    }
    
}