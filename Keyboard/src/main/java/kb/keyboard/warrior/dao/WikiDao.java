package kb.keyboard.warrior.dao;

public interface WikiDao {
	
	//�θ� id ã��
	int getParentid(String selectedId);
	
	//order ����ϱ�
	int getMaxOrderOfFather(String selectedId);
	int getMaxOrderOfnoParents();
	
	//�ֻ��� ������ �߰�
	void insertMenuNoParentsItem(String title, String sharedTitle, String link, String menuType, int max_order, String userno);
	//�ֻ��� ���� �߰�
	void insertMenuNoParentsFolder(String title, String sharedTitle, String menuType, int max_order, String userno);
	//�߰� ������ �߰�
	void insertMenuHaveParentsItem(String selectedId, String title, String sharedTitle, String link, String menuType, int max_order, String userno);
	//�߰� ���� �߰�
	void insertMenuHaveParentsFolder(String selectedId, String title, String sharedTitle, String menuType, int max_order, String userno);
	
	
	
	

}
