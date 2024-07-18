package kb.keyboard.warrior;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import kb.keyboard.warrior.dto.StockDTO;

public class StockInterCrawler {
	
	public static void main(String[] args) {
        StockInterCrawler crawler = new StockInterCrawler();
        List<StockDTO> stocks = crawler.fetchIndexData();
        for (StockDTO stock : stocks) {
            System.out.println(stock);
        }
    }
//	
//    public static void main(String[] args) {
//        StockInterCrawler crawler = new StockInterCrawler();
//        List<String> urls = new ArrayList<String>();
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=DJI@DJI");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=NII@NI225");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=LNS@FTSE100");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=NAS@IXIC");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=SHS@000001");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=PAS@CAC40");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=SPI@SPX");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=HSI@HSI");
//        urls.add("https://finance.naver.com/world/sise.naver?symbol=XTR@DAX30");
//        crawler.fetchIndexData(urls);
//    }

	public List<StockDTO> fetchIndexData() {
        List<StockDTO> stockList = new ArrayList<StockDTO>();
        String[] urls = {
            "https://finance.naver.com/world/sise.naver?symbol=SPI@SPX",
            "https://finance.naver.com/world/sise.naver?symbol=NAS@IXIC"
        };

        for (String url : urls) {
            try {
                Document doc = Jsoup.connect(url).get();

                // Index name 가져오기
                Element indexNameElement = doc.selectFirst(".h_area h2");
                String indexName = indexNameElement != null ? indexNameElement.text() : "Unknown Index";

                // 현재 지수 가져오기
                Element todayElement = doc.selectFirst(".no_today");
                String currentPrice = extractNumberFromElement(todayElement);

                // 변동폭 및 변동률 가져오기
                Element exdayElement = doc.selectFirst(".no_exday");
                String priceChange = "";
                String changePercentage = "";
                if (exdayElement != null) {
                    Element changeValueElement = exdayElement.selectFirst(".no_down, .no_up");
                    priceChange = extractNumberFromElement(changeValueElement);

                    List<Element> changeRateElements = exdayElement.select("em.no_down, em.no_up");
                    if (changeRateElements.size() > 1) {
                        Element changeRateElement = changeRateElements.get(1);
                        changePercentage = extractNumberFromElement(changeRateElement)
                                .replace("+", "").replace("%", "").replace("(", "").replace(")", "").trim();
                    }
                }

                // 기본값 설정 및 값이 비어 있을 경우 검증
                double currentPriceValue = currentPrice.isEmpty() ? 0.0 : Double.parseDouble(currentPrice.replace(",", ""));
                double priceChangeValue = priceChange.isEmpty() ? 0.0 : Double.parseDouble(priceChange.replace(",", ""));
                double changePercentageValue = changePercentage.isEmpty() ? 0.0 : Double.parseDouble(changePercentage);

                // changePercentage가 음수인 경우 priceChange도 음수로 설정
                if (changePercentageValue < 0) {
                    priceChangeValue = -Math.abs(priceChangeValue);
                }

                // DTO에 값 설정
                StockDTO stockDTO = new StockDTO();
                stockDTO.setIndexName(indexName);
                stockDTO.setCurrentPrice(currentPriceValue);
                stockDTO.setPriceChange(priceChangeValue);
                stockDTO.setChangePercentage(changePercentageValue);

                stockList.add(stockDTO);

            } catch (IOException e) {
                e.printStackTrace();
            } catch (NumberFormatException e) {
                System.err.println("Number format exception occurred for URL: " + url);
                e.printStackTrace();
            }
        }
        return stockList;
    }

    private String extractNumberFromElement(Element element) {
        StringBuilder number = new StringBuilder();
        if (element != null) {
            for (Element span : element.select("span")) {
                number.append(span.text());
            }
        }
        return number.toString();
    }
}