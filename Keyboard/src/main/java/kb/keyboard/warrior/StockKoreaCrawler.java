package kb.keyboard.warrior;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import kb.keyboard.warrior.dto.StockDTO;

public class StockKoreaCrawler {
//    public static void main(String[] args) {
//    	StockKoreaCrawler crawler = new StockKoreaCrawler();
//    	List<StockDTO> stocks = crawler.fetchIndexData();
//    	for (StockDTO stock : stocks) {
//            System.out.println(stock);
//        }        
//    }

    public List<StockDTO> fetchIndexData() {
        List<StockDTO> stockList = new ArrayList<StockDTO>();
        String[] urls = {
                "https://finance.naver.com/sise/sise_index.naver?code=KOSPI",
                "https://finance.naver.com/sise/sise_index.naver?code=KOSDAQ"
        };
        
        for (String url : urls) {
            try {
                Document doc = Jsoup.connect(url).get();

                String indexName = doc.selectFirst(".sub_tlt").text();
                Element kospiIndex = doc.selectFirst("#now_value");
                String kospiValue = kospiIndex.text();
                String changeValue = "";
                String changeRate = "";

                Element kospiIndexChange = doc.selectFirst("#change_value_and_rate");
                
                Element weekHighElement = doc.select(".table_kos_index tr:contains(52주최고) td.td").first();
                Element weekLowElement = doc.select(".table_kos_index tr:contains(52주최저) td.td2").first();
                
                String weekHighValue = weekHighElement.text();
                String weekLowValue = weekLowElement.text();

                if (kospiIndexChange != null) {
                    changeValue = kospiIndexChange.select("span").first().text().split(" ")[0];
                    changeRate = kospiIndexChange.ownText().trim();
                }

                double currentPriceValue = Double.parseDouble(kospiValue.replace(",", ""));
                double priceChangeValue = Double.parseDouble(changeValue.replace(",", ""));
                double changePercentageValue = Double.parseDouble(changeRate.replace("%", "").trim());
                double weekHigh52 = Double.parseDouble(weekHighValue.replace(",", ""));
                double weekLow52 = Double.parseDouble(weekLowValue.replace(",", ""));

                StockDTO stockDTO = new StockDTO();
                stockDTO.setCountry("한국");
                stockDTO.setIndexName(indexName);
                stockDTO.setCurrentPrice(currentPriceValue);
                stockDTO.setPriceChange(priceChangeValue);
                stockDTO.setChangePercentage(changePercentageValue);
                stockDTO.setWeekHigh52(weekHigh52);
                stockDTO.setWeekLow52(weekLow52);

                stockList.add(stockDTO);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return stockList;
    }
}
