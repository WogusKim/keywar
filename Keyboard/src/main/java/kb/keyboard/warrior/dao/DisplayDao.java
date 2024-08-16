package kb.keyboard.warrior.dao;

import kb.keyboard.warrior.dto.OrderDTO;

public interface DisplayDao {
	
	//add Favorite Currency
	void favoriteCurrency(String userno, String currencyCode);
	//delete  Favorite Currency
	void unFavoriteCurrency(String userno, String currencyCode);
	
	//add Favorite stock
	void favoriteStock(String userno, String currencyCode);
	//delete  Favorite Currency
	void unFavoriteStock(String userno, String currencyCode);
	//get order of display
	String getOrderDisplay1(String userno);
	String getOrderDisplay2(String userno);
	String getOrderDisplay3(String userno);
	
	//check whether user has a order
	Integer checkOrderExists(String userno);
	
	//update or insert order of user
	void updateDisplayOrder(String userno, String string, String string2, String string3);
	void insertDisplayOrder(String userno, String string, String string2, String string3);
	
	
	//�������̺� Ȯ�� 2
	OrderDTO getOrderDisplayAll(String userno);
	
	//TODO - ������ ���� �޼��� 
	void updateDisplayOrderTodoDisplay(String userno, int i); //������Ʈ
	void insertDisplayOrderTodoDisplay(String userno, int i); //�μ�Ʈ
	
	//���Ʒ� ���� �޼���
	void updateDisplayOrderTopBottom(String userno, int i); //������Ʈ
	void insertDisplayOrderTopBottom(String userno, int i); //�μ�Ʈ
	
	//�Ʒ� ��ģ�� ���� �ٲٱ� �޼���
	void updateDisplayOrderTwoBottom(String userno, int i);
	void insertDisplayOrderTwoBottom(String userno, int i);
	
	
	
	void updateDisplayOrderMemoNotice(String userno, int i);
	void insertDisplayOrderMemoNotice(String userno, int i);

}
