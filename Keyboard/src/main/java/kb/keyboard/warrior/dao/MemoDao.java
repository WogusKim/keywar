package kb.keyboard.warrior.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import kb.keyboard.warrior.dto.DeptMemoDTO;
import kb.keyboard.warrior.dto.MyMemoDTO;
import kb.keyboard.warrior.dto.NoticeDTO;
import kb.keyboard.warrior.dto.TodoListDTO;



public interface MemoDao {
	public ArrayList<TodoListDTO> todoView(String userno);
	public ArrayList<MyMemoDTO> memoView1(String userno);
	public ArrayList<DeptMemoDTO> memoView2(String deptno);
	public ArrayList<NoticeDTO> noticeView(String deptno);
	
	public void noticeWrite(String title, String content, String color, String userno, String deptno);
	public void noticeDelete(String noticeid);
	
	public void mymemoWrite(String userno, String mymemocontent, String memocolor);
	public void deptmemoWrite(String deptno, String userno, String deptmemocontent, String memocolor);
	
	public void mymemoDelete(String memoid);
	public void deptmemoDelete(String memoid);
	
	public void todoWrite(String userno, String task);
	public void todoStatus(String todoid);
	
	public void updateNoticePosition(NoticeDTO noticeDTO);
	public void updateNoticeSize(NoticeDTO noticeDTO);
	
	// 최대 z-index 값을 조회
	public int getMaxZindex();
	
	public List<MyMemoDTO> searchMyMemo(@Param("userno") String userno, @Param("keyword") String keyword);
	public List<DeptMemoDTO> searchDeptMemo(@Param("deptno") String deptno, @Param("keyword") String keyword);









}
