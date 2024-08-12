package kb.keyboard.warrior.dao;

import kb.keyboard.warrior.dto.AlertDTO;

public interface SettingDao {
	
	//BG 컬러 세팅
	void updateColor(String newColor, String userno);
	void insertColor(String newColor, String userno);
	public AlertDTO getAlertStauts(String userno);
	public void changeAlertStatus(AlertDTO dto);
	
}
