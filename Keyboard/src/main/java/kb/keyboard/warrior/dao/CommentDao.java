package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.CommentDTO;

public interface CommentDao {
	public void addComment(CommentDTO dto) ;
	public List<CommentDTO> getComment(String targerno);
}
