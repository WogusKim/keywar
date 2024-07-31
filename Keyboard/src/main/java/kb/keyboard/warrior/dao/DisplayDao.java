package kb.keyboard.warrior.dao;

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
	
			

}
