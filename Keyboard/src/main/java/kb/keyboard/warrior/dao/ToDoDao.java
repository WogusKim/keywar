package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.TodoListDTO;

public interface ToDoDao {

	List<TodoListDTO> getToDoList(String userno);

	//���� ToDoList ����
	void checkTodo(String todoId);
	void unCheckTodo(String todoId);
	
}
