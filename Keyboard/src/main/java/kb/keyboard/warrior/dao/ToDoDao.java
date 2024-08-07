package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.TodoListDTO;

public interface ToDoDao {

	List<TodoListDTO> getToDoList(String userno);

	//메인 ToDoList 변경
	void checkTodo(String todoId);
	void unCheckTodo(String todoId);
	
	
	//TO DO List 개선 후 추가
	public void editTodo(TodoListDTO dto);
	public void addTodo(TodoListDTO dto);
	public void deleteTodo(String todoid);
	public void getTodayTasks(String userno);
}
