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
	public void noticeWrite(String title, String content);






}
