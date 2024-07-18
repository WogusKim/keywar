package kb.keyboard.warrior.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kb.keyboard.warrior.CoffixRateCrawler;
import kb.keyboard.warrior.CurrencyRateCrawler;
import kb.keyboard.warrior.MorRateCrawler;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.TodoListDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	public SqlSession sqlSession;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		//�α��ο��� üũ
		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		
		//���� �α��� ���� üũ �ʿ�
		
		//ȯ�������� ó��
	    CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
	    List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeRates();
	    if (!currencyRates.isEmpty()) {
	    	//���� ���� ���ã�� �� 3���� �����͸� rates �� �ؼ� �Ѱ������.
	    	//List<ExchangeRate> ratesFavorite = new List<ExchangeRate>;
	    	//ratesFavorite(0) = rate(i)
	    	//ratesFavorite(0) = rate(j)
	    	//ratesFavorite(0) = rate(k)
	    	//���� ������ i j k ������ �����;���.
	    	//model.addAttribute("ratesFavorite", ratesFavorite);
	        model.addAttribute("ratesFavorite", currencyRates);   
	    } else {
	        System.out.println("No rates found.");
	    }
	    
	    
	    //���õ����� ó��
	    
	    
	    
	    
	    //�ݸ������� ó��
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
	    
	    //To Do List ó��
	    ToDoDao dao = sqlSession.getMapper(ToDoDao.class);
	    List<TodoListDTO> todoList = dao.getToDoList(userno);
	    model.addAttribute("todoList", todoList);
	    
	    //Memo Data
	    
	    	    
	    return "main";
	}

	@RequestMapping("/noticeForm")
	public String noticeForm() {		
		return "noticeForm";
	}

}
