package kb.keyboard.warrior;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kb.keyboard.warrior.dto.ExchangeRate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class CurrencyRateCrawler {
    public List<ExchangeRate> fetchExchangeRates() {
        List<ExchangeRate> rates = new ArrayList<ExchangeRate>();
        try {
            Document doc = Jsoup.connect("https://obank.kbstar.com/quics?page=C101423#CP").get();
            Elements rows = doc.select("table.tType01 tbody tr");
            for (Element row : rows) {
                ExchangeRate rate = new ExchangeRate();
                rate.setCurrencyCode(row.select("td:eq(0) a").text());
                rate.setCurrencyName(row.select("td:eq(1)").text());
                rate.setStandardRate(parseDouble(row.select("td:eq(2)").text()));
                rate.setTransferSend(parseDouble(row.select("td:eq(3)").text()));
                rate.setTransferReceive(parseDouble(row.select("td:eq(4)").text()));
                rate.setCashBuy(parseDouble(row.select("td:eq(5)").text()));
                rate.setCashSell(parseDouble(row.select("td:eq(6)").text()));
                rate.setUsdRate(parseDouble(row.select("td:eq(7)").text()));
                rate.setRateChangeLink(row.select("td:eq(8) a").attr("href"));
                rates.add(rate);
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
