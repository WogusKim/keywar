package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.*;

public interface AlertDao {
	public List<AlertDTO> getAlert(String userno);
	public void updateIsread(String alertno);
	public void addNoticeAlert(AlertDTO dto);
	public void addWikiAlert(AlertDTO dto);
	public void addCommentAlert(AlertDTO dto);
	public void addLikeAlert(AlertDTO dto);
	public List<AlertDTO> getRecentlyAlert(String userno);
}
