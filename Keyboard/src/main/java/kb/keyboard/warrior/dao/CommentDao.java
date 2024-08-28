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
	//마이페이지 내가 작성한 댓글 불러오기
	public List<CommentDTO> getMyComment(String userno);
	//좋아요 개수 확인(게시물 별)
	public int checkLikeByContent(String targetid);
}
