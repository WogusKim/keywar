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
	
	
	@Scheduled(fixedRate = 3600000) // �ϴ��� 1�ð��� �� ���� ���ư�. 
	public void autoCrawler() { 
		// �ڵ����� ���ư��� �� �� ����ٰ� ������ ��.
		System.out.println("�ȳ� �ȳ�~~");
	}
	
	@Scheduled(fixedRate = 600000) //1�п� �� ��
	 public void fetchExchangeRates() {
		 ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		 	System.out.println("ȯ�� �ڵ� ũ�Ѹ� ������ ���� ");
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
	            System.out.println("ȯ�� �ڵ� ũ�Ѹ� ������ ���� �Ϸ�");
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	 
	 
	    private Double parseDouble(String value) {
	        try {
	            return Double.parseDouble(value.replace(",", ""));
	        } catch (NumberFormatException e) {
	            return 0.0; // �⺻�� ���� �Ǵ� �ٸ� �������� ���� ����
	        }
	    }
}

