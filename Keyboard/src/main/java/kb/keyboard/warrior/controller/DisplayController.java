package kb.keyboard.warrior.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kb.keyboard.warrior.CoffixRateCrawler;
import kb.keyboard.warrior.CurrencyRateCrawler;
import kb.keyboard.warrior.MorRateCrawler;
import kb.keyboard.warrior.SoosinRateCrawler;
import kb.keyboard.warrior.SoosinRateCrawler2;
import kb.keyboard.warrior.StockCrawler;
import kb.keyboard.warrior.dao.DisplayDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.display.command.DisplayCommand;
import kb.keyboard.warrior.dto.ExchangeFavoriteDTO;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO2;
import kb.keyboard.warrior.dto.StockDTO;
import kb.keyboard.warrior.dto.StockFavoriteDTO;

@Controller
public class DisplayController {
	
	@Autowired
	public SqlSession sqlSession;
	
	@Autowired
	private StockCrawler stockCrawler;
	
	@RequestMapping("/currency")
	public String currency(Model model, HttpSession session) {	
		
		String userno = (String) session.getAttribute("userno");
		
		//환율즐겨찾기 확인
		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
		List<ExchangeFavoriteDTO> favorites = loginDao.getFavoriteCurrency(userno);
		String favoriteCurrency1 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteCurrency2 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteCurrency3 = "0"; // 기본값: 즐겨찾기가 없음

		switch (favorites.size()) {
		    case 0:
		        // 즐겨찾기가 전혀 없는 경우, 디폴트 통화를 설정
		        //favoriteCurrency1 = "KOR";
		        //favoriteCurrency2 = "JPY";
		        //favoriteCurrency3 = "EUR";
		        break;
		    case 1:
		        // 즐겨찾기가 하나인 경우
		        favoriteCurrency1 = favorites.get(0).getCurrency();
		        break;
		    case 2:
		        // 즐겨찾기가 두 개인 경우
		        favoriteCurrency1 = favorites.get(0).getCurrency();
		        favoriteCurrency2 = favorites.get(1).getCurrency();
		        break;
		    case 3:
		        // 즐겨찾기가 세 개인 경우
		        favoriteCurrency1 = favorites.get(0).getCurrency();
		        favoriteCurrency2 = favorites.get(1).getCurrency();
		        favoriteCurrency3 = favorites.get(2).getCurrency();
		        break;
		}
		
	    CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
	    List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeRates(favoriteCurrency1, favoriteCurrency2, favoriteCurrency3);
	    if (!currencyRates.isEmpty()) {
	        model.addAttribute("rates", currencyRates);   
	    } else {
	        System.out.println("No rates found.");
	    }
		
		
		return "display/currency";
	}
	
	@RequestMapping("/stock")
	public String stock(Model model, HttpSession session) {	
		
		System.out.println("컨트롤러 진입");
	    DisplayCommand displayCommand = new DisplayCommand();

		String userno = (String) session.getAttribute("userno");
		
		//증시즐겨찾기 확인
		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
		List<StockFavoriteDTO> favorites = loginDao.getFavoriteStock(userno);
		String favoriteStock1 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteStock2 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteStock3 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteStock4 = "0"; // 기본값: 즐겨찾기가 없음
		
		switch (favorites.size()) {
		    case 1:
		        // 즐겨찾기가 하나인 경우
		    	favoriteStock1 = favorites.get(0).getIndexname();
		        break;
		    case 2:
		        // 즐겨찾기가 두 개인 경우
		    	favoriteStock1 = favorites.get(0).getIndexname();
		    	favoriteStock2 = favorites.get(1).getIndexname();
		        break;
		    case 3:
		        // 즐겨찾기가 세 개인 경우
		    	favoriteStock1 = favorites.get(0).getIndexname();
		    	favoriteStock2 = favorites.get(1).getIndexname();
		    	favoriteStock3 = favorites.get(2).getIndexname();
		        break;
		    case 4:
		        // 즐겨찾기가 세 개인 경우
		    	favoriteStock1 = favorites.get(0).getIndexname();
		    	favoriteStock2 = favorites.get(1).getIndexname();
		    	favoriteStock3 = favorites.get(2).getIndexname();
		    	favoriteStock4 = favorites.get(3).getIndexname();
		        break;
		}		

        List<StockDTO> allStocks = stockCrawler.fetchAllStocks(favoriteStock1, favoriteStock2, favoriteStock3, favoriteStock4);
//        List<StockDTO> favoriteStocks = stockCrawler.fetchFavoriteStocks(favoriteStock1, favoriteStock2, favoriteStock3, favoriteStock4);

        model.addAttribute("allStocks", allStocks);
//        model.addAttribute("favoriteStocks", favoriteStocks);
        
        System.out.println("모델에 값 추가");
		
		return "display/stock";
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
	
	@RequestMapping(value = "/favoriteCurrency",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST )
	public @ResponseBody String findPw(@RequestBody ExchangeRateDTO exchangeDto, HttpSession session) throws Exception {
		
		String userno = (String) session.getAttribute("userno");
		String currencyCode = exchangeDto.getCurrencyCode();
		String isFavorite = exchangeDto.getIsFavorite();

		System.out.println(currencyCode);
		System.out.println(isFavorite);
		System.out.println(userno);
		
		DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
		
		
		if (isFavorite.equals("1")) {
			//즐겨찾기 추가로직
			displayDao.favoriteCurrency(userno, currencyCode);
			
		} else {
			//즐겨찾기 해제로직
			displayDao.unFavoriteCurrency(userno, currencyCode);
		}

		return "{\"status\":\"success\"}";
	}

	@RequestMapping(value = "/favoriteStock",  produces = "application/json", consumes = "application/json", method = RequestMethod.POST )
	@ResponseBody
	public String favoriteStock(@RequestBody StockDTO stockDto, HttpSession session) throws Exception {
		
		String userno = (String) session.getAttribute("userno");
		String indexname = stockDto.getIndexName();
		String isFavorite = stockDto.getisFavorite();

		System.out.println(indexname);
		System.out.println(isFavorite);
		System.out.println(userno);
		
		DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
		
		
		if (isFavorite.equals("1")) {
			//즐겨찾기 추가로직
			displayDao.favoriteStock(userno, indexname);
			
		} else {
			//즐겨찾기 해제로직
			displayDao.unFavoriteStock(userno, indexname);
		}

		return "{\"status\":\"success\"}";
	}
}
