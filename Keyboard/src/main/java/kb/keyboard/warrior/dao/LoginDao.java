package kb.keyboard.warrior.dao;

import java.util.*;

import kb.keyboard.warrior.dto.*;

public interface LoginDao {

	public UserDTO login(String id, String pw);
	public UserDTO findPw(UserDTO dto);
	public UserDTO isRightUserno(String userno);
	public void UpdatePw(String id, String pw);
}
