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
		
		//ȯ�������� ó��
	    CurrencyRateCrawler crawler = new CurrencyRateCrawler();
	    List<ExchangeRate> rates = crawler.fetchExchangeRates();
	    if (!rates.isEmpty()) {
	    	//���� ���� ���ã�� �� 3���� �����͸� rates �� �ؼ� �Ѱ������.
	    	//List<ExchangeRate> ratesFavorite = new List<ExchangeRate>;
	    	//ratesFavorite(0) = rate(i)
	    	//ratesFavorite(0) = rate(j)
	    	//ratesFavorite(0) = rate(k)
	    	//���� ������ i j k ������ �����;���.
	    	//model.addAttribute("ratesFavorite", ratesFavorite);
	        model.addAttribute("ratesFavorite", rates);   
	    } else {
	        System.out.println("No rates found.");
	    }
	    
	    
	    //���õ����� ó��
	    
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
