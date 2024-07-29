package kb.keyboard.warrior.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
import kb.keyboard.warrior.StockCrawler;
import kb.keyboard.warrior.dao.ExchangeRateDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.ExchangeFavoriteDTO;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MenuDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.MyMemoDTO;
import kb.keyboard.warrior.dto.NoticeDTO;

import kb.keyboard.warrior.dto.StockDTO;

import kb.keyboard.warrior.dto.StockFavoriteDTO;
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
		long startTime = System.currentTimeMillis(); // 시작 시간 기록

		// 로그인 여부 체크
		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		// 이후 로그인 여부 체크 필요
		// 세션에서 메뉴 데이터를 확인 (확인후 없으면 세션 설정)!!!

		List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");

		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);

		menus = loginDao.getMenus(userno);
		setMenuDepth(menus);
		List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);

		session.setAttribute("menus", topLevelMenus); // 세션에 메뉴 데이터 저장

		model.addAttribute("menus", topLevelMenus);

		// ȯ�� ���ã�� Ȯ��
		List<ExchangeFavoriteDTO> favorites = loginDao.getFavoriteCurrency(userno);

		String favoriteCurrency1 = "0"; // 디폴트 값: USD
		String favoriteCurrency2 = "0"; // 디폴트 값: JPY
		String favoriteCurrency3 = "0"; // 디폴트 값: EUR

		switch (favorites.size()) {
		case 0:
			// 즐겨찾기 없으면 기본으로 나오는 3개
			favoriteCurrency1 = "USD";
			favoriteCurrency2 = "JPY";
			favoriteCurrency3 = "EUR";
			break;
		case 1:

			// 즐겨찾기 1개
			favoriteCurrency1 = favorites.get(0).getCurrency();
			break;
		case 2:
			// 즐겨찾기 2개
			favoriteCurrency1 = favorites.get(0).getCurrency();
			favoriteCurrency2 = favorites.get(1).getCurrency();
			break;
		case 3:
			// 즐겨찾기 3개
			favoriteCurrency1 = favorites.get(0).getCurrency();
			favoriteCurrency2 = favorites.get(1).getCurrency();
			favoriteCurrency3 = favorites.get(2).getCurrency();
			break;
		}

		// 환율 즐겨찾기 데이터 처리
//        CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
//        List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeFavoriteRates(favoriteCurrency1, favoriteCurrency2, favoriteCurrency3);
		// 크롤링을 DB에서 가져오는 것으로 바꾸는 구문.
		ExchangeRateDao exchangedao = sqlSession.getMapper(ExchangeRateDao.class);
		List<ExchangeRateDTO> currencyRates = exchangedao.getAllExchangeRate();

		List<ExchangeRateDTO> favoritecurrencyRates = new ArrayList<ExchangeRateDTO>();
		for (ExchangeRateDTO dto : currencyRates) {
			if (dto.getCurrencyCode().equals(favoriteCurrency1) || dto.getCurrencyCode().equals(favoriteCurrency2)
					|| dto.getCurrencyCode().equals(favoriteCurrency3)) {
				favoritecurrencyRates.add(dto);
			}
		}

		if (!favoritecurrencyRates.isEmpty()) {
			model.addAttribute("ratesFavorite", favoritecurrencyRates);
		} else {
			System.out.println("No rates found.");
		}

		// 증시즐찾

		List<StockFavoriteDTO> stock = loginDao.getFavoriteStock(userno);

		String favoriteStock1 = "0"; //
		String favoriteStock2 = "0"; //
		String favoriteStock3 = "0"; //
		String favoriteStock4 = "0"; //

		switch (stock.size()) {
		case 0:
			favoriteStock1 = "코스피";
			favoriteStock2 = "코스닥";
			favoriteStock3 = "S&P 500";
			favoriteStock4 = "나스닥 종합";

			break;
		case 1:
			favoriteStock1 = stock.get(0).getIndexname();
			break;
		case 2:
			favoriteStock1 = stock.get(0).getIndexname();
			favoriteStock2 = stock.get(1).getIndexname();
			break;
		case 3:
			favoriteStock1 = stock.get(0).getIndexname();
			favoriteStock2 = stock.get(1).getIndexname();
			favoriteStock3 = stock.get(2).getIndexname();
			break;
		case 4:
			favoriteStock1 = stock.get(0).getIndexname();
			favoriteStock2 = stock.get(1).getIndexname();
			favoriteStock3 = stock.get(2).getIndexname();
			favoriteStock4 = stock.get(3).getIndexname();
			break;

		}

		// 증시 즐겨찾기 데이터 처리
//		StockCrawler stockCrawler = new StockCrawler();
//        List<StockDTO> stocks = stockCrawler.fetchFavoriteStocks(favoriteStock1, favoriteStock2, favoriteStock3, favoriteStock4);
		List<StockDTO> stocks = exchangedao.getAllStock();
		List<StockDTO> favoriteStocks = new ArrayList<StockDTO>();

		for (StockDTO stock1 : stocks) {
			if (stock1.getIndexName().equals(favoriteStock1) || 
				stock1.getIndexName().equals(favoriteStock2)|| 
				stock1.getIndexName().equals(favoriteStock3)|| 
				stock1.getIndexName().equals(favoriteStock4)) {
				favoriteStocks.add(stock1);
			}
		}

		if (!stocks.isEmpty()) {
			model.addAttribute("stockFavorite", favoriteStocks);
		} else {
			System.out.println("No rates found.");
		}

		// MOR

//        MorRateCrawler morCrawler = new MorRateCrawler();
//        List<MorCoffixDTO> morRates = morCrawler.fetchMorRates();
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		List<MorCoffixDTO> morRates = dao.getAllMor();
		if (!morRates.isEmpty()) {
			model.addAttribute("mor", morRates);
		}

		// COFIX
//        CoffixRateCrawler coffixCrawler = new CoffixRateCrawler();
//        List<MorCoffixDTO> coffixRates = coffixCrawler.fetchMorRates();
		List<MorCoffixDTO> coffixRates = dao.getAllCofix();
		if (!coffixRates.isEmpty()) {
			model.addAttribute("cofix", coffixRates);
		}

		// To Do List

		ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
		List<TodoListDTO> todoList = todoDao.getToDoList(userno);
		model.addAttribute("todoList", todoList);

		// Memo Data
		MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
		List<MyMemoDTO> memoList = memoDao.memoView1(userno);
		model.addAttribute("memoList", memoList);

		// Notice Data
		List<NoticeDTO> noticeList = memoDao.noticeView(deptno);
		model.addAttribute("noticeList", noticeList);

		long endTime = System.currentTimeMillis(); // 완료 시간 기록
		long duration = endTime - startTime; // 실행 시간 계산
		System.out.println("메인화면 로딩 소요 시간: " + duration + "밀리초");

		return "main";
	}

	@RequestMapping("/noticeForm")
	public String noticeForm() {
		return "noticeForm";
	}

	public void setMenuDepth(List<MenuDTO> menus) {

		// 메뉴 ID와 메뉴 객체를 매핑하는 Map을 생성
		Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for (MenuDTO menu : menus) {
			menuMap.put(menu.getId(), menu);
		}

		// 각 메뉴 항목의 depth 계산
		for (MenuDTO menu : menus) {
			int depth = 0;
			Integer parentId = menu.getParentId();
			while (parentId != null) {
				MenuDTO parent = menuMap.get(parentId);
				if (parent == null)
					break;
				depth++;
				parentId = parent.getParentId();
			}
			menu.setDepth(depth);
		}
	}

	public List<MenuDTO> organizeMenuHierarchy(List<MenuDTO> menus) {
		Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for (MenuDTO menu : menus) {
			menuMap.put(menu.getId(), menu);
			menu.setChildren(new ArrayList<MenuDTO>());
		}

		for (MenuDTO menu : menus) {
			if (menu.getParentId() != null) {
				MenuDTO parent = menuMap.get(menu.getParentId());
				if (parent != null) {
					parent.getChildren().add(menu);
				}
			}
		}

		List<MenuDTO> topLevelMenus = new ArrayList<MenuDTO>();
		for (MenuDTO menu : menus) {
			if (menu.getParentId() == null) {
				topLevelMenus.add(menu);
			}
		}

		// 로깅을 추가하여 각 최상위 메뉴와 해당 하위 메뉴들을 출력
		for (MenuDTO menu : topLevelMenus) {
			System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
			printChildren(menu, "  "); // 재귀적으로 하위 메뉴들을 출력
		}

		return topLevelMenus;
	} 

	private void printChildren(MenuDTO menu, String indent) {
		for (MenuDTO child : menu.getChildren()) {
			System.out.println(indent + "Child Menu: " + child.getTitle() + " (ID: " + child.getId() + ")");
			if (!child.getChildren().isEmpty()) {
				printChildren(child, indent + "  ");
			}
		}
	}
}