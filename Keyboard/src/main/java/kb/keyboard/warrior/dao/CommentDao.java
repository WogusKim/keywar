package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.CommentDTO;
import kb.keyboard.warrior.dto.LikeDTO;

public interface CommentDao {
	public void addComment(CommentDTO dto) ;
	public void addLike(LikeDTO dto) ;
	public List<CommentDTO> getComment(String targerno);
	public List<CommentDTO> getCommentReverse(String targerno);
	public int checkLike(LikeDTO dto);
	public void commentDelete(String commentid);
	public String findWhoWrote(String commentid);
	//���������� ���� �ۼ��� ��� �ҷ�����
	public List<CommentDTO> getMyComment(String userno);
	//���ƿ� ���� Ȯ��(�Խù� ��)
	public int checkLikeByContent(String targetid);
}
