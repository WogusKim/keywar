package kb.keyboard.warrior;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import kb.keyboard.warrior.dto.StockDTO;

public class StockInterCrawler {
	
//	public static void main(String[] args) {
//        StockInterCrawler crawler = new StockInterCrawler();
//        List<StockDTO> stocks = crawler.fetchIndexData();
//        for (StockDTO stock : stocks) {
//            System.out.println(stock);
//        }
//    }
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
        		"https://finance.naver.com/world/sise.naver?symbol=DJI@DJI",
        		"https://finance.naver.com/world/sise.naver?symbol=DJI@DJT",
        		"https://finance.naver.com/world/sise.naver?symbol=NAS@IXIC",
        		"https://finance.naver.com/world/sise.naver?symbol=NAS@NDX",
        		"https://finance.naver.com/world/sise.naver?symbol=SPI@SPX",
        		"https://finance.naver.com/world/sise.naver?symbol=NAS@SOX",
        		"https://finance.naver.com/world/sise.naver?symbol=BRI@BVSP",
        		"https://finance.naver.com/world/sise.naver?symbol=SHS@000001",
        		"https://finance.naver.com/world/sise.naver?symbol=SHS@000002",
        		"https://finance.naver.com/world/sise.naver?symbol=SHS@000003",
        		"https://finance.naver.com/world/sise.naver?symbol=NII@NI225",
        		"https://finance.naver.com/world/sise.naver?symbol=HSI@HSI",
        		"https://finance.naver.com/world/sise.naver?symbol=HSI@HSCE",
        		"https://finance.naver.com/world/sise.naver?symbol=HSI@HSCC",
        		"https://finance.naver.com/world/sise.naver?symbol=TWS@TI01",
        		"https://finance.naver.com/world/sise.naver?symbol=INI@BSE30",
        		"https://finance.naver.com/world/sise.naver?symbol=MYI@KLSE",
        		"https://finance.naver.com/world/sise.naver?symbol=IDI@JKSE",
        		"https://finance.naver.com/world/sise.naver?symbol=LNS@FTSE100",
        		"https://finance.naver.com/world/sise.naver?symbol=PAS@CAC40",
        		"https://finance.naver.com/world/sise.naver?symbol=XTR@DAX30",
        		"https://finance.naver.com/world/sise.naver?symbol=STX@SX5E",
        		"https://finance.naver.com/world/sise.naver?symbol=RUI@RTSI",
        		"https://finance.naver.com/world/sise.naver?symbol=ITI@FTSEMIB"
        };

        for (String url : urls) {
            try {
                Document doc = Jsoup.connect(url).get();

                // Index name 가져오기
                Element countryElement = doc.selectFirst(".h_area .state");
                String country = countryElement != null ? countryElement.text() : "Unknown Index";
                
                Element indexNameElement = doc.selectFirst(".h_area h2");
                String indexName = indexNameElement != null ? indexNameElement.text() : "Unknown Index";

                // 현재 지수 가져오기
                Element todayElement = doc.selectFirst(".no_today");
                String currentPrice = extractNumberFromElement(todayElement);

                // 변동폭 및 변동률 가져오기
                Element exdayElement = doc.selectFirst(".no_exday");
                String priceChange = "";
                String changePercentage = "";
                
                // 52주 최고/최저 가격
                Element weekHighElement = doc.selectFirst(".no_info td:contains(52주 최고) em");
                Element weekLowElement = doc.selectFirst(".no_info td:contains(52주 최저) em");

                String weekHigh52 = extractNumberFromElement(weekHighElement);
                String weekLow52 = extractNumberFromElement(weekLowElement);
                
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
                double weekHigh52Value = weekHigh52.isEmpty() ? 0.0 : Double.parseDouble(weekHigh52.replace(",", ""));
                double weekLow52Value = weekLow52.isEmpty() ? 0.0 : Double.parseDouble(weekLow52.replace(",", ""));

                // changePercentage가 음수인 경우 priceChange도 음수로 설정
                if (changePercentageValue < 0) {
                    priceChangeValue = -Math.abs(priceChangeValue);
                }

                // DTO에 값 설정
                StockDTO stockDTO = new StockDTO();
                stockDTO.setCountry(country);
                stockDTO.setIndexName(indexName);
                stockDTO.setCurrentPrice(currentPriceValue);
                stockDTO.setPriceChange(priceChangeValue);
                stockDTO.setChangePercentage(changePercentageValue);
                stockDTO.setWeekHigh52(weekHigh52Value);
                stockDTO.setWeekLow52(weekLow52Value);

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