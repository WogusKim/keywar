package kb.keyboard.warrior.dao;

public interface WikiDao {
	
	//부모 id 찾기
	int getParentid(String selectedId);
	
	//order 계산하기
	int getMaxOrderOfFather(String selectedId);
	int getMaxOrderOfnoParents();
	
	//최상위 아이템 추가
	void insertMenuNoParentsItem(String title, String sharedTitle, String link, String menuType, int max_order, String userno);
	//최상위 폴더 추가
	void insertMenuNoParentsFolder(String title, String sharedTitle, String menuType, int max_order, String userno);
	//중간 아이템 추가
	void insertMenuHaveParentsItem(String selectedId, String title, String sharedTitle, String link, String menuType, int max_order, String userno);
	//중간 폴더 추가
	void insertMenuHaveParentsFolder(String selectedId, String title, String sharedTitle, String menuType, int max_order, String userno);
	
	
	
	

}
