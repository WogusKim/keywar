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
	public void addSubscribeAlert(AlertDTO dto);
	public void addFollowAlert(AlertDTO dto);
	public List<AlertDTO> getRecentlyAlert(String userno);
	
	
	
	
	// �ȷο� ����� ���� �߰� !
	public FollowDTO checkFollow(FollowDTO dto);
	public void addFollow(FollowDTO dto);
	public void changeFollowStatus(FollowDTO dto);
	public int checkMyFollowers(String userno);
	public List<UserDTO> checkMyFollowing(String userno);
	public List<UserDTO> checkMyFollower(String userno);
	// �˸� ���� ������ (���� �ȷο�) ��������
	public List<String> sortMyFollower(String userno);
	
}

