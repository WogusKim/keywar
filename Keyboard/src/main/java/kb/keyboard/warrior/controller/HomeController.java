package kb.keyboard.warrior.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import kb.keyboard.warrior.dto.ExchangeFavoriteDTO;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MenuDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.MyMemoDTO;
import kb.keyboard.warrior.dto.NoticeDTO;
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
		
	    // 세션에서 메뉴 데이터를 먼저 확인
	    List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
	    LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
	    
	    if (menus == null) {
	        menus = loginDao.getMenus(userno);
	        setMenuDepth(menus);
	        List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);
	        session.setAttribute("menus", topLevelMenus);  // 세션에 메뉴 데이터 저장
	        model.addAttribute("menus", topLevelMenus);
	    } else {
	        model.addAttribute("menus", menus);  // 이미 세션에 저장된 데이터 사용
	    }
	    
		

		//환율즐겨찾기 확인
		List<ExchangeFavoriteDTO> favorites = loginDao.getFavoriteCurrency(userno);
		
		String favoriteCurrency1 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteCurrency2 = "0"; // 기본값: 즐겨찾기가 없음
		String favoriteCurrency3 = "0"; // 기본값: 즐겨찾기가 없음

		switch (favorites.size()) {
		    case 0:
		        // 즐겨찾기가 전혀 없는 경우, 디폴트 통화를 설정
		        favoriteCurrency1 = "USD";
		        favoriteCurrency2 = "JPY";
		        favoriteCurrency3 = "EUR";
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
		
		
		//환율 즐겨찾기 데이터 처리		
	    CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
	    List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeFavoriteRates(favoriteCurrency1, favoriteCurrency2, favoriteCurrency3);
	    if (!currencyRates.isEmpty()) {
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
	    
	    //Notice Data
	    List<NoticeDTO> noticeList = memoDao.noticeView(deptno);
	    model.addAttribute("noticeList", noticeList);
	    	    
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
	            if (parent == null) break;
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

	    // 로깅을 추가하여 각 최상위 메뉴와 해당 자식 메뉴들을 출력
	    for (MenuDTO menu : topLevelMenus) {
	        System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
	        printChildren(menu, "  ");  // 재귀적으로 자식 메뉴들을 출력
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
