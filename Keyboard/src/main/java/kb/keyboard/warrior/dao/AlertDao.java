package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.*;

public interface AlertDao {
	public List<AlertDTO> getAlert(String userno);
}
