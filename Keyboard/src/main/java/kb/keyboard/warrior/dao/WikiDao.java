package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.BoardDTO;
import kb.keyboard.warrior.dto.ImageSizeDTO;
import kb.keyboard.warrior.dto.MenuDTO;

public interface WikiDao {
	
	//-------------------------------�޴�����--------------------------------//
	
	//�θ� id ã��
	Integer getParentid(String selectedId);
	
	//order ����ϱ�
	int getMaxOrderOfFather(String selectedId);
	int getMaxOrderOfnoParents();
	
	//�ֻ��� ������ �߰�
	void insertMenuNoParentsItem(String title, String sharedTitle, String link, String menuType, int max_order, String userno, int isOpenInt);
	//�ֻ��� ���� �߰�
	void insertMenuNoParentsFolder(String title, String sharedTitle, String menuType, int max_order, String userno, int isOpenInt);
	//�߰� ������ �߰�
	void insertMenuHaveParentsItem(String selectedId, String title, String sharedTitle, String link, String menuType, int max_order, String userno, int isOpenInt);
	//�߰� ���� �߰�
	void insertMenuHaveParentsFolder(String selectedId, String title, String sharedTitle, String menuType, int max_order, String userno, int isOpenInt);
	
	//���� - item
	void deleteItem(String selectedId, String userno);
	
	//���� - folder
    List<Integer> getChildIds(Integer parentId);
    void deleteFolder(String folderId, String userno);
    
    //�޴������ͻ�
	MenuDTO getMenuDetail(int id);

	//����Ÿ��Ʋ ������ ���� �б��Ͽ� update
	void changeMenuNoShare(String title, String id);
	void changeMenuYesShare(String title, String titleShare, String id);
	
	//�������� ���� �޼���
	void changeIsOpen(String isOpen, String id);
	
	//��� �߰��� �޴� id ã��
	int getNewCopyId(String userno);
	public Integer checkItIsopen(String idMenu);

	//--------------------------------�޴�����--------------------------------//
	
	
	
	
	//--------------------------------��Ű�󼼰���--------------------------------//
	
	//��ȸ�ϱ�
	String getData(int id);

	//�����ϱ� (�ű� / ������Ʈ)
	void insertWiki(int wikiId, String editorData);
	void updateWiki(int wikiId, String editorData);
	
	//���� ���������� Ȯ��
	String getSize(Integer wikiId, String url);
	
	//�̹��� ������ ����
	void updateSize(Integer wikiId, String url, String width);
	void insertSize(Integer wikiId, String url, String width);
	void updateImageAlign(Integer wikiId, int imageId, String align);
	
	//id �������� ��� �̹��� ���� �ҷ�����
	List<ImageSizeDTO> getAllSizeOfImg(int id);
	
	

	
	//--------------------------------��Ű�󼼰���--------------------------------//
	
	
	//-------- ��ŷ ���� //
	
	public List<BoardDTO> getAllPost(); //��ü ������ �Ǿ��ִ� �Խù� �� ��ȸ 
	public List<BoardDTO> getMyPost(String userno); //�������������� ��ȸ�� ���� �Խù� ��ȸ
	public int myTotalLike(String userno);  // ���� �ۼ��� �Խù����� ���ƿ� ���� ��ȸ
	public List<BoardDTO> getLikedPost(String userno); //���� �����ϴ� �Խù� ��������
	public List<BoardDTO> getBestPost(); // ���ƿ� ���� �� �Խù� 5�� �������� ! 
	public List<BoardDTO> getBestWriter(); // ���ƿ� ���� �� �Խù� 5�� �������� ! 
	public BoardDTO getOnesRecord(String userno); // ���ƿ� ���� �� �Խù� 5�� �������� ! 
	
	//�г�����ȸ
	String getWriterNickName(String userno);
	public BoardDTO findWriterName(String targetid);
	
	//��Ű ��ȸ�� ã��
	Integer getHitsById(int id);
	//��ȸ�� ó��
	void updateHits(int id);
	void insertHits(int id);




}
