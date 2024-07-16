package kb.keyboard.warrior.dao;

import java.util.*;

import kb.keyboard.warrior.dto.*;

public interface LoginDao {

	public List<UserDTO> login(String id, String pw);
	public void findPw(UserDTO dto);
	public UserDTO isRightUserno(String userno);
}
