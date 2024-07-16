package kb.keyboard.warrior.dao;

import java.util.*;

import kb.keyboard.warrior.dto.*;

public interface LoginDao {

	public UserDTO login(String id, String pw);
	public void findPw(UserDTO dto);
	public UserDTO isRightUserno(String userno);
	public void UpdatePw(String id, String pw);
}
