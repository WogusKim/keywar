package kb.keyboard.warrior.dao;

import java.util.ArrayList;

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
	
	public void mymemoWrite(String userno, String mymemocontent);
	public void deptmemoWrite(String deptno, String userno, String deptmemocontent);
	
	public void mymemoDelete(String memoid);
	public void deptmemoDelete(String memoid);
	
	public void todoWrite(String userno, String task);
	public void todoStatus(String todoid);
	
	public void updateNoticePosition(NoticeDTO noticeDTO);
	public void updateNoticeSize(NoticeDTO noticeDTO);
	
	// 최대 z-index 값을 조회
	public int getMaxZindex();






}
