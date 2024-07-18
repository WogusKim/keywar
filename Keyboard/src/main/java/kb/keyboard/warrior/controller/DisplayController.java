package kb.keyboard.warrior.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kb.keyboard.warrior.CoffixRateCrawler;
import kb.keyboard.warrior.CurrencyRateCrawler;
import kb.keyboard.warrior.MorRateCrawler;
import kb.keyboard.warrior.SoosinRateCrawler;
import kb.keyboard.warrior.SoosinRateCrawler2;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO2;

@Controller
public class DisplayController {
	
	@Autowired
	public SqlSession sqlSession;
	
	@RequestMapping("/currency")
	public String currency(Model model) {	
		
	    CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
	    List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeRates();
	    if (!currencyRates.isEmpty()) {
	        model.addAttribute("rates", currencyRates);   
	    } else {
	        System.out.println("No rates found.");
	    }
		
		
		return "display/currency";
	}
	
	@RequestMapping("/interestRate")
	public String  interestRate(Model model) {
		
	    //금리데이터 처리
	    //MOR
	    MorRateCrawler morCrawler = new MorRateCrawler();
	    List<MorCoffixDTO> morRates = morCrawler.fetchMorRates();
	    if (!morRates.isEmpty()) {
	    	model.addAttribute("mor", morRates);
	    }
	    //COFFIX
	    CoffixRateCrawler coffixCrawler = new CoffixRateCrawler();
	    List<MorCoffixDTO> coffixRates = coffixCrawler.fetchMorRates();
	    if (!coffixRates.isEmpty()) {
	    	model.addAttribute("cofix", coffixRates);
	    }
	    //국민수퍼정기예금
	    SoosinRateCrawler superCrawler = new SoosinRateCrawler();
	    List<SoosinRateDTO> superRates = superCrawler.fetchMorRates();
	    if (!superRates.isEmpty()) {
	    	model.addAttribute("superRates", superRates);
	    }
	    //KB Star 정기예금
	    SoosinRateCrawler2 kbStarCrawler = new SoosinRateCrawler2();
	    List<SoosinRateDTO2> kbStarRates = kbStarCrawler.fetchMorRates();
	    if (!kbStarRates.isEmpty()) {
	    	System.out.println("데이터추출");
	    	model.addAttribute("kbStarRates", kbStarRates);
	    } else {
	    	System.out.println("빈값입니다.");
	    }
	    
	    
		return "display/interestRate";
	}
	
}
