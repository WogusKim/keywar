package kb.keyboard.warrior;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import kb.keyboard.warrior.dto.MorCoffixDTO;

public class CoffixRateCrawler {
    private static final String URL = "https://obank.kbstar.com/quics?page=C019206"; // 예시 URL

    public List<MorCoffixDTO> fetchMorRates() {
        List<MorCoffixDTO> rates = new ArrayList<MorCoffixDTO>();
        try {
            Document doc = Jsoup.connect(URL).get();
            Elements rows = doc.select(".tType01 tbody tr"); // 테이블 데이터 선택

            for (Element row : rows) {
                String rateType = row.select("th").text();
                String previousWeekRate = row.select("td").get(0).text();
                String currentWeekRate = row.select("td").get(1).text();
                String change = row.select("td").get(2).text();

                MorCoffixDTO morDTO = new MorCoffixDTO(rateType, previousWeekRate, currentWeekRate, change);
                rates.add(morDTO);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rates;
    }
}
