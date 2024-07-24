package kb.keyboard.warrior;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import kb.keyboard.warrior.dto.StockDTO;


@Component
public class StockCrawler {
    private StockKoreaCrawler koreaCrawler = new StockKoreaCrawler();
    private StockInterCrawler interCrawler = new StockInterCrawler();
    
    

    public List<StockDTO> fetchAllStocks() {
        List<StockDTO> allStocks = new ArrayList<StockDTO>();
        List<StockDTO> koreaStocks = koreaCrawler.fetchIndexData();
        List<StockDTO> interStocks = interCrawler.fetchIndexData();

        allStocks.addAll(koreaStocks);
        allStocks.addAll(interStocks);

        return allStocks;
    }
    
    public List<StockDTO> fetchFavoriteStocks(String favoriteStock1, String favoriteStock2, String favoriteStock3, String favoriteStock4) {
        List<StockDTO> allStocks = fetchAllStocks();
        List<StockDTO> favoriteStocks = new ArrayList<StockDTO>();

        for (StockDTO stock : allStocks) {
            if (stock.getIndexName().equals(favoriteStock1) ||
                stock.getIndexName().equals(favoriteStock2) ||
                stock.getIndexName().equals(favoriteStock3) ||
                stock.getIndexName().equals(favoriteStock4)) {
                favoriteStocks.add(stock);
            }
        }

        return favoriteStocks;
    }

}