package kb.keyboard.warrior.util;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import kb.keyboard.warrior.dto.ExchangeRateDTO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dao.ExchangeRateDao;

@Component
public class ScheduledThread {
	
	String exchangeRateUpdateTime;
	
	@Autowired
	public SqlSession sqlSession;
	
	
	@Scheduled(fixedRate = 3600000) // 일단은 1시간에 한 번씩 돌아감. 
	public void autoCrawler() { 
		// 자동으로 돌아가게 할 거 여기다가 넣으면 됨.
		System.out.println("안녕 안녕~~");
	}
	
	@Scheduled(fixedRate = 600000) //1분에 한 번
	 public void fetchExchangeRates() {
		 ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		 	System.out.println("환율 자동 크롤링 스레드 동작 ");
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
	           
	                dao.updateExchangeRate(rate);
	            
	                rates.add(rate);
	            }
	            System.out.println("환율 자동 크롤링 스레드 동작 완료");
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	 
	 
	    private Double parseDouble(String value) {
	        try {
	            return Double.parseDouble(value.replace(",", ""));
	        } catch (NumberFormatException e) {
	            return 0.0; // 기본값 설정 또는 다른 로직으로 변경 가능
	        }
	    }
}

