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
			

}
