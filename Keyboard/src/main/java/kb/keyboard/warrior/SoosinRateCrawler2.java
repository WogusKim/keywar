package kb.keyboard.warrior;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kb.keyboard.warrior.dto.SoosinRateDTO2;

//KB Star 정기예금
public class SoosinRateCrawler2 {
    private static final String URL = "https://obank.kbstar.com/quics?page=C030266&cc=b028364:b049008&%EB%B8%8C%EB%9E%9C%EB%93%9C%EC%83%81%ED%92%88%EC%BD%94%EB%93%9C=DP01000938&%EB%85%B8%EB%93%9C%EC%BD%94%EB%93%9C=00007&%ED%8C%90%EB%A7%A4%EC%97%AC%EB%B6%80=1&QSL=F#none";

    public List<SoosinRateDTO2> fetchMorRates() {
        List<SoosinRateDTO2> rates = new ArrayList<SoosinRateDTO2>();
        try {
            Document doc = Jsoup.connect(URL).get();
            System.out.println("Document: " + doc.title());  // 문서 제목 로깅
            Elements rows = doc.select("#ptabMenu2 .n_ptType1 tbody tr");
            System.out.println("Number of rows: " + rows.size());  // 행의 수 로깅

            for (Element row : rows) {
                Elements cols = row.select("td");
                if (!cols.isEmpty()) {
                    String period = cols.get(0).text();
                    double basicRate = parseDouble(cols.get(1).text());
                    double customerRate = parseDouble(cols.get(2).text());

                    rates.add(new SoosinRateDTO2(period, basicRate, customerRate));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rates;
    }
    
    private double parseDouble(String text) {
        try {
            return Double.parseDouble(text);
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
}
