package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.CommentDTO;
import kb.keyboard.warrior.dto.LikeDTO;

public interface CommentDao {
	public void addComment(CommentDTO dto) ;
	public void addLike(LikeDTO dto) ;
	public List<CommentDTO> getComment(String targerno);
	public LikeDTO checkLike(LikeDTO dto);
	public void commentDelete(String commentid);
	public String findWhoWrote(String commentid);
}
