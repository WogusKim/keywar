package kb.keyboard.warrior.dao;

import java.io.InputStream;
import java.util.*;

import org.apache.ibatis.annotations.Param;

import kb.keyboard.warrior.dto.*;

public interface LoginDao {

	public UserDTO login(String id, String pw);
	public UserDTO findPw(UserDTO dto);
	public UserDTO isRightUserno(String userno);
	public void UpdatePw(String id, String pw);
	public List<ExchangeFavoriteDTO> getFavoriteCurrency(String userno);
	public List<StockFavoriteDTO> getFavoriteStock(String userno);
	public List<MenuDTO> getMenus(String userno);
	public void changeNickname(String userno, String nickname);
	
	// ���� �߰��� �޼ҵ�
    void updateUserProfilePicture(@Param("userno") String userno, @Param("picture") InputStream picture);
    UserDTO getUserProfile(@Param("userno") String userno);
    
    //����ã��
	public String getColor(String userno);
	
	//�μ��� ���� ã��
	public List<String> getAllDeptMember(String deptno);
	

}
