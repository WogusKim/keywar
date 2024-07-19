package kb.keyboard.warrior.dao;

public interface DisplayDao {
	
	//add Favorite Currency
	void favoriteCurrency(String userno, String currencyCode);
	//delete  Favorite Currency
	void unFavoriteCurrency(String userno, String currencyCode);

}
