package kb.keyboard.warrior;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kb.keyboard.warrior.dto.SoosinRateDTO;

//국민수퍼정기예금
public class SoosinRateCrawler {
    private static final String URL = "https://obank.kbstar.com/quics?page=C030266&cc=b028364:b049008&%EB%B8%8C%EB%9E%9C%EB%93%9C%EC%83%81%ED%92%88%EC%BD%94%EB%93%9C=DP01000029&%EB%85%B8%EB%93%9C%EC%BD%94%EB%93%9C=00007&%ED%8C%90%EB%A7%A4%EC%97%AC%EB%B6%80=1&QSL=F#none";

    public List<SoosinRateDTO> fetchMorRates() {
        List<SoosinRateDTO> rates = new ArrayList<SoosinRateDTO>();
        try {
            Document doc = Jsoup.connect(URL).get();
            Elements rows = doc.select("table.tablestyle-01.mgt2 tr");

            for (Element row : rows) {
                if (row.select("td").size() > 0) {
                    String period = row.select("td").get(0).text();
                    String fixedRate = row.select("td").get(1).text();
                    String monthlyInterestRate = row.select("td").get(2).text();
                    String compoundMonthlyRate = row.select("td").get(3).text();
                    SoosinRateDTO data = new SoosinRateDTO(period, fixedRate, monthlyInterestRate, compoundMonthlyRate);
                    rates.add(data);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rates;
    }
}
