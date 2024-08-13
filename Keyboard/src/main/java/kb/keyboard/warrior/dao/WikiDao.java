package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.BoardDTO;
import kb.keyboard.warrior.dto.ImageSizeDTO;
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
	
	//공개여부 변경 메서드
	void changeIsOpen(String isOpen, String id);
	
	//방금 추가한 메뉴 id 찾기
	int getNewCopyId(String userno);
	public Integer checkItIsopen(String idMenu);

	//--------------------------------메뉴관련--------------------------------//
	
	
	
	
	//--------------------------------위키상세관련--------------------------------//
	
	//조회하기
	String getData(int id);

	//저장하기 (신규 / 업데이트)
	void insertWiki(int wikiId, String editorData);
	void updateWiki(int wikiId, String editorData);
	
	//기존 사이즈정보 확인
	String getSize(Integer wikiId, String url);
	
	//이미지 상세정보 저장
	void updateSize(Integer wikiId, String url, String width);
	void insertSize(Integer wikiId, String url, String width);
	void updateImageAlign(Integer wikiId, int imageId, String align);
	
	//id 기준으로 모든 이미지 정보 불러오기
	List<ImageSizeDTO> getAllSizeOfImg(int id);
	
	

	
	//--------------------------------위키상세관련--------------------------------//
	
	
	//-------- 랭킹 관련 //
	
	public List<BoardDTO> getAllPost(); //전체 공개로 되어있는 게시물 들 조회 
	public List<BoardDTO> getMyPost(String userno); //마이페이지에서 조회될 나의 게시물 조회
	public int myTotalLike(String userno);  // 내가 작성한 게시물들의 좋아요 개수 조회
	public List<BoardDTO> getLikedPost(String userno); //내가 좋아하는 게시물 가져오기
	public List<BoardDTO> getBestPost(); // 좋아요 많은 순 게시물 5개 가져오기 ! 
	public List<BoardDTO> getBestWriter(); // 좋아요 많은 순 게시물 5개 가져오기 ! 
	public BoardDTO getOnesRecord(String userno); // 좋아요 많은 순 게시물 5개 가져오기 ! 
	
	//닉네임조회
	String getWriterNickName(String userno);
	public BoardDTO findWriterName(String targetid);
	
	//위키 조회수 찾기
	Integer getHitsById(int id);
	//조회수 처리
	void updateHits(int id);
	void insertHits(int id);




}
