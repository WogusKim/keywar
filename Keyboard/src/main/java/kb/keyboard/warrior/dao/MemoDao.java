package kb.keyboard.warrior.dao;

import java.util.ArrayList;

import kb.keyboard.warrior.dto.TodoListDTO;



public interface MemoDao {
	public ArrayList<TodoListDTO> todoView(String userno);


}
