package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.MenuDTO;

public interface WikiDao {
	
	//-------------------------------메뉴관련--------------------------------//
	
	//부모 id 찾기
	Integer getParentid(String selectedId);
	
	//order 계산하기
	int getMaxOrderOfFather(String selectedId);
	int getMaxOrderOfnoParents();
	
	//최상위 아이템 추가
	void insertMenuNoParentsItem(String title, String sharedTitle, String link, String menuType, int max_order, String userno, int isOpenInt);
	//최상위 폴더 추가
	void insertMenuNoParentsFolder(String title, String sharedTitle, String menuType, int max_order, String userno, int isOpenInt);
	//중간 아이템 추가
	void insertMenuHaveParentsItem(String selectedId, String title, String sharedTitle, String link, String menuType, int max_order, String userno, int isOpenInt);
	//중간 폴더 추가
	void insertMenuHaveParentsFolder(String selectedId, String title, String sharedTitle, String menuType, int max_order, String userno, int isOpenInt);
	
	//삭제 - item
	void deleteItem(String selectedId, String userno);
	
	//삭제 - folder
    List<Integer> getChildIds(Integer parentId);
    void deleteFolder(String folderId, String userno);
    
    //메뉴데이터상세
	MenuDTO getMenuDetail(int id);

	//쉐어타이틀 유무에 따라 분기하여 update
	void changeMenuNoShare(String title, String id);
	void changeMenuYesShare(String title, String titleShare, String id);

	//--------------------------------메뉴관련--------------------------------//
	
	
	
	
	//--------------------------------위키상세관련--------------------------------//
	
	//조회하기
	String getData(int id);

	//저장하기 (신규 / 업데이트)
	void insertWiki(int wikiId, String editorData);
	void updateWiki(int wikiId, String editorData);
	

	
	//--------------------------------위키상세관련--------------------------------//
	
	
	
	

}
