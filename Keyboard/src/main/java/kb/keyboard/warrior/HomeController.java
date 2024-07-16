package kb.keyboard.warrior;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kb.keyboard.warrior.dto.ExchangeRate;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		//환율데이터 처리
	    CurrencyRateCrawler crawler = new CurrencyRateCrawler();
	    List<ExchangeRate> rates = crawler.fetchExchangeRates();
	    if (!rates.isEmpty()) {
	    	//추후 내가 즐겨찾기 한 3개의 데이터만 rates 로 해서 넘겨줘야함.
	    	//List<ExchangeRate> ratesFavorite = new List<ExchangeRate>;
	    	//ratesFavorite(0) = rate(i)
	    	//ratesFavorite(0) = rate(j)
	    	//ratesFavorite(0) = rate(k)
	    	//내가 설정한 i j k 세개를 가져와야함.
	    	//model.addAttribute("ratesFavorite", ratesFavorite);
	        model.addAttribute("ratesFavorite", rates);   
	    } else {
	        System.out.println("No rates found.");
	    }
	    
	    
	    //증시데이터 처리
	    
	    return "main";
	}

	
	@RequestMapping("/todo")
	public String todo() {		
		return "todo";
	}
	@RequestMapping("/memo")
	public String memo() {		
		return "memo";
	}
	@RequestMapping("/notice")
	public String notice() {		
		return "notice";
	}
	@RequestMapping("/noticeForm")
	public String noticeForm() {		
		return "noticeForm";
	}

}
