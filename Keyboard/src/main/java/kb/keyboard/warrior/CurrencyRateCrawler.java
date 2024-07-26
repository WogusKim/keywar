package kb.keyboard.warrior;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kb.keyboard.warrior.dto.ExchangeRateDTO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class CurrencyRateCrawler {
    public List<ExchangeRateDTO> fetchExchangeRates(String favoriteCurrency1, String favoriteCurrency2, String favoriteCurrency3) {
        List<ExchangeRateDTO> rates = new ArrayList<ExchangeRateDTO>();
        try {
            Document doc = Jsoup.connect("https://obank.kbstar.com/quics?page=C101423#CP").get();
            Elements rows = doc.select("table.tType01 tbody tr");
            for (Element row : rows) {
                ExchangeRateDTO rate = new ExchangeRateDTO();
                rate.setCurrencyCode(row.select("td:eq(0) a").text());
                rate.setCurrencyName(row.select("td:eq(1)").text());
                rate.setStandardRate(parseDouble(row.select("td:eq(2)").text()));
                rate.setTransferSend(parseDouble(row.select("td:eq(3)").text()));
                rate.setTransferReceive(parseDouble(row.select("td:eq(4)").text()));
                rate.setCashBuy(parseDouble(row.select("td:eq(5)").text()));
                rate.setCashSell(parseDouble(row.select("td:eq(6)").text()));
                rate.setUsdRate(parseDouble(row.select("td:eq(7)").text()));
                rate.setRateChangeLink(row.select("td:eq(8) a").attr("href"));
                
                if (rate.getCurrencyCode().equals(favoriteCurrency1) ||
                	rate.getCurrencyCode().equals(favoriteCurrency2) ||
                	rate.getCurrencyCode().equals(favoriteCurrency3)) 
                {
                	rate.setIsFavorite("1");
                }
                
                rates.add(rate);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rates;
    }
    
    public List<ExchangeRateDTO> fetchExchangeFavoriteRates(String favoriteCurrency1, String favoriteCurrency2, String favoriteCurrency3) {
        List<ExchangeRateDTO> rates = new ArrayList<ExchangeRateDTO>();
        try {
            Document doc = Jsoup.connect("https://obank.kbstar.com/quics?page=C101423#CP").get();
            Elements rows = doc.select("table.tType01 tbody tr");
            for (Element row : rows) {
                ExchangeRateDTO rate = new ExchangeRateDTO();
                rate.setCurrencyCode(row.select("td:eq(0) a").text());
                rate.setCurrencyName(row.select("td:eq(1)").text());
                rate.setStandardRate(parseDouble(row.select("td:eq(2)").text()));
                rate.setTransferSend(parseDouble(row.select("td:eq(3)").text()));
                rate.setTransferReceive(parseDouble(row.select("td:eq(4)").text()));
                rate.setCashBuy(parseDouble(row.select("td:eq(5)").text()));
                rate.setCashSell(parseDouble(row.select("td:eq(6)").text()));
                rate.setUsdRate(parseDouble(row.select("td:eq(7)").text()));
                rate.setRateChangeLink(row.select("td:eq(8) a").attr("href"));
                
                if (rate.getCurrencyCode().equals(favoriteCurrency1) ||
                	rate.getCurrencyCode().equals(favoriteCurrency2) ||
                	rate.getCurrencyCode().equals(favoriteCurrency3)) 
                {
                	rates.add(rate);
                	System.out.println("즐겨찾기" + rate.getCurrencyCode());
                }         
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rates;
    }

    private Double parseDouble(String value) {
        try {
            return Double.parseDouble(value.replace(",", ""));
        } catch (NumberFormatException e) {
            return 0.0; // 기본값 설정 또는 다른 로직으로 변경 가능
        }
    }
}
