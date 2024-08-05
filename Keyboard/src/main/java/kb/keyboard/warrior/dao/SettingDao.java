package kb.keyboard.warrior.dao;

public interface SettingDao {
	
	//BG 컬러 세팅
	void updateColor(String newColor, String userno);
	void insertColor(String newColor, String userno);

	
}
