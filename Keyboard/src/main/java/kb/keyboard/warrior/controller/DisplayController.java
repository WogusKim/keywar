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
import kb.keyboard.warrior.dao.ExchangeRateDao;
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
		
		// ȯ�����ã�� Ȯ��
		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
		List<ExchangeFavoriteDTO> favorites = loginDao.getFavoriteCurrency(userno);
		String favoriteCurrency1 = "0"; // �⺻��: ���ã�Ⱑ ����
		String favoriteCurrency2 = "0"; // �⺻��: ���ã�Ⱑ ����
		String favoriteCurrency3 = "0"; // �⺻��: ���ã�Ⱑ ����

		switch (favorites.size()) {
		    case 0:
		        // ���ã�Ⱑ ���� ���� ���, ����Ʈ ��ȭ�� ����
		        //favoriteCurrency1 = "KOR";
		        //favoriteCurrency2 = "JPY";
		        //favoriteCurrency3 = "EUR";
		        break;
		    case 1:
		        // ���ã�� �ϳ�
		        favoriteCurrency1 = favorites.get(0).getCurrency();
		        break;
		    case 2:
		        // ���ã�� �ΰ�
		        favoriteCurrency1 = favorites.get(0).getCurrency();
		        favoriteCurrency2 = favorites.get(1).getCurrency();
		        break;
		    case 3:
		        // ���ã�� ����
		        favoriteCurrency1 = favorites.get(0).getCurrency();
		        favoriteCurrency2 = favorites.get(1).getCurrency();
		        favoriteCurrency3 = favorites.get(2).getCurrency();
		        break;
		}
		
//	    CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
//	    List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeRates(favoriteCurrency1, favoriteCurrency2, favoriteCurrency3);
		ExchangeRateDao exchangedao = sqlSession.getMapper(ExchangeRateDao.class);
		List<ExchangeRateDTO> currencyRates =  exchangedao.getAllExchangeRate();
	    if (!currencyRates.isEmpty()) {
	        model.addAttribute("rates", currencyRates);   
	    } else {
	        System.out.println("No rates found.");
	    }
		
		
		return "display/currency";
	}
	
	@RequestMapping("/stock")
	public String stock(Model model, HttpSession session) {	
		
		System.out.println("���� ����");
//	    DisplayCommand displayCommand = new DisplayCommand();

		String userno = (String) session.getAttribute("userno");
		
		//�������ã�� Ȯ��
		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
		List<StockFavoriteDTO> favorites = loginDao.getFavoriteStock(userno);
		String favoriteStock1 = "0"; // �⺻��: ���ã�Ⱑ ����
		String favoriteStock2 = "0"; // �⺻��: ���ã�Ⱑ ����
		String favoriteStock3 = "0"; // �⺻��: ���ã�Ⱑ ����
		String favoriteStock4 = "0"; // �⺻��: ���ã�Ⱑ ����
		
		switch (favorites.size()) {
		    case 1:
		        // ���ã�� �ϳ�
		    	favoriteStock1 = favorites.get(0).getIndexname();
		        break;
		    case 2:
		        // ���ã�� �ΰ�
		    	favoriteStock1 = favorites.get(0).getIndexname();
		    	favoriteStock2 = favorites.get(1).getIndexname();
		        break;
		    case 3:
		        // ���ã�� ����
		    	favoriteStock1 = favorites.get(0).getIndexname();
		    	favoriteStock2 = favorites.get(1).getIndexname();
		    	favoriteStock3 = favorites.get(2).getIndexname();
		        break;
		    case 4:
		        // ���ã�� �װ�
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

        System.out.println("�𵨿� �� �߰�");
		
		return "display/stock";
	}
	
	
	@RequestMapping("/interestRate")
	public String  interestRate(Model model) {
		
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
	    //���μ������⿹��
	    SoosinRateCrawler superCrawler = new SoosinRateCrawler();
	    List<SoosinRateDTO> superRates = superCrawler.fetchMorRates();
	    if (!superRates.isEmpty()) {
	    	model.addAttribute("superRates", superRates);
	    }
	    //KB Star ���⿹��
	    SoosinRateCrawler2 kbStarCrawler = new SoosinRateCrawler2();
	    List<SoosinRateDTO2> kbStarRates = kbStarCrawler.fetchMorRates();
	    if (!kbStarRates.isEmpty()) {
	    	System.out.println("����������");
	    	model.addAttribute("kbStarRates", kbStarRates);
	    } else {
	    	System.out.println("���Դϴ�.");
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
			//���ã�� �߰�����
			displayDao.favoriteCurrency(userno, currencyCode);
			
		} else {
			//���ã�� ��������
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
			//���ã�� �߰�����
			displayDao.favoriteStock(userno, indexname);
			
		} else {
			//���ã�� ��������
			displayDao.unFavoriteStock(userno, indexname);

		}

		return "{\"status\":\"success\"}";
	}
}
