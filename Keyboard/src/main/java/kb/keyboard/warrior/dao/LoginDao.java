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
	
	// 새로 추가된 메소드
    void updateUserProfilePicture(@Param("userno") String userno, @Param("picture") InputStream picture);
    UserDTO getUserProfile(@Param("userno") String userno);
    
    //색상찾기
	public String getColor(String userno);
	
	//부서별 직원 찾기
	public List<String> getAllDeptMember(String deptno);
	

}
