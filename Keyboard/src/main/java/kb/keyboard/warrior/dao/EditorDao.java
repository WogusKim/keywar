package kb.keyboard.warrior.dao;

import kb.keyboard.warrior.dto.EditorDTO;

public interface EditorDao {
	void insertEditor(EditorDTO editor);
	EditorDTO selectEditorById(int id);

}
