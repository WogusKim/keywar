package kb.keyboard.warrior.controller;


import java.util.ArrayList;
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
import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.MyMemoDTO;
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
		
		//로그인여부 체크
		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		
		//추후 로그인 여부 체크 필요
		
		//환율데이터 처리
	    CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
	    List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeRates();
	    if (!currencyRates.isEmpty()) {
	    	//추후 내가 즐겨찾기 한 3개의 데이터만 rates 로 해서 넘겨줘야함.
	    	//List<ExchangeRate> ratesFavorite = new List<ExchangeRate>;
	    	//ratesFavorite(0) = rate(i)
	    	//ratesFavorite(0) = rate(j)
	    	//ratesFavorite(0) = rate(k)
	    	//내가 설정한 i j k 세개를 가져와야함.
	    	//model.addAttribute("ratesFavorite", ratesFavorite);
	        model.addAttribute("ratesFavorite", currencyRates);   
	    } else {
	        System.out.println("No rates found.");
	    }
	    
	    
	    //증시데이터 처리
	    
	    
	    
	    
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
	    
	    //To Do List 처리
	    ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
	    List<TodoListDTO> todoList = todoDao.getToDoList(userno);
	    model.addAttribute("todoList", todoList);
	    
	    //Memo Data
	    MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
	    List<MyMemoDTO> memoList = memoDao.memoView1(userno);
	    model.addAttribute("memoList", memoList);
	    	    
	    return "main";
	}

	@RequestMapping("/noticeForm")
	public String noticeForm() {		
		return "noticeForm";
	}

}
