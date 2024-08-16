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
	
	
	//오더테이블 확인 2
	OrderDTO getOrderDisplayAll(String userno);
	
	//TODO - 전광판 변경 메서드 
	void updateDisplayOrderTodoDisplay(String userno, int i); //업데이트
	void insertDisplayOrderTodoDisplay(String userno, int i); //인서트
	
	//위아래 변경 메서드
	void updateDisplayOrderTopBottom(String userno, int i); //업데이트
	void insertDisplayOrderTopBottom(String userno, int i); //인서트
	
	//아래 두친구 순서 바꾸기 메서드
	void updateDisplayOrderTwoBottom(String userno, int i);
	void insertDisplayOrderTwoBottom(String userno, int i);
	
	
	
	void updateDisplayOrderMemoNotice(String userno, int i);
	void insertDisplayOrderMemoNotice(String userno, int i);

}
