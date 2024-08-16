package kb.keyboard.warrior.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kb.keyboard.warrior.CoffixRateCrawler;
import kb.keyboard.warrior.CurrencyRateCrawler;
import kb.keyboard.warrior.MorRateCrawler;
import kb.keyboard.warrior.StockCrawler;
import kb.keyboard.warrior.dao.AlertDao;
import kb.keyboard.warrior.dao.DisplayDao;
import kb.keyboard.warrior.dao.ExchangeRateDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.MemoDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.BoardDTO;
import kb.keyboard.warrior.dto.DeptMemoDTO;
import kb.keyboard.warrior.dto.ExchangeFavoriteDTO;
import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MenuDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.MyMemoDTO;
import kb.keyboard.warrior.dto.NoticeDTO;
import kb.keyboard.warrior.dto.OrderDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO2;
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
	public String test(Model model, HttpSession session) {
		return "redirect:main";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		long startTime = System.currentTimeMillis(); // �떆�옉 �떆媛� 湲곕줉

		// 濡쒓렇�씤 �뿬遺� 泥댄겕
		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		// �씠�썑 濡쒓렇�씤 �뿬遺� 泥댄겕 �븘�슂
		// �꽭�뀡�뿉�꽌 硫붾돱 �뜲�씠�꽣瑜� �솗�씤 (�솗�씤�썑 �뾾�쑝硫� �꽭�뀡 �꽕�젙)!!!

		List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");

		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);

		menus = loginDao.getMenus(userno);
		setMenuDepth(menus);
		List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);

		session.setAttribute("menus", topLevelMenus); // �꽭�뀡�뿉 硫붾돱 �뜲�씠�꽣 ���옣

		model.addAttribute("menus", topLevelMenus);

		// 환占쏙옙 占쏙옙占시ｏ옙占� 확占쏙옙
		List<ExchangeFavoriteDTO> favorites = loginDao.getFavoriteCurrency(userno);

		String favoriteCurrency1 = "0"; // �뵒�뤃�듃 媛�: USD
		String favoriteCurrency2 = "0"; // �뵒�뤃�듃 媛�: JPY
		String favoriteCurrency3 = "0"; // �뵒�뤃�듃 媛�: EUR

		switch (favorites.size()) {
		case 0:
			// 利먭꺼李얘린 �뾾�쑝硫� 湲곕낯�쑝濡� �굹�삤�뒗 3媛�
			favoriteCurrency1 = "USD";
			favoriteCurrency2 = "JPY";
			favoriteCurrency3 = "EUR";
			break;
		case 1:

			// 利먭꺼李얘린 1媛�
			favoriteCurrency1 = favorites.get(0).getCurrency();
			break;
		case 2:
			// 利먭꺼李얘린 2媛�
			favoriteCurrency1 = favorites.get(0).getCurrency();
			favoriteCurrency2 = favorites.get(1).getCurrency();
			break;
		case 3:
			// 利먭꺼李얘린 3媛�
			favoriteCurrency1 = favorites.get(0).getCurrency();
			favoriteCurrency2 = favorites.get(1).getCurrency();
			favoriteCurrency3 = favorites.get(2).getCurrency();
			break;
		}

		// Currency Favorite Data
//        CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
//        List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeFavoriteRates(favoriteCurrency1, favoriteCurrency2, favoriteCurrency3);
		// WebCrawling -> get data from DB
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

		// 利앹떆利먯갼

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

		// Stock Favorite Data
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
		ExchangeRateDao dao = sqlSession.getMapper(ExchangeRateDao.class);
		List<MorCoffixDTO> morRates = dao.getAllMor();
		if (!morRates.isEmpty()) {
			model.addAttribute("mor", morRates);
		}

		// COFIX
		List<MorCoffixDTO> coffixRates = dao.getAllCofix();
		if (!coffixRates.isEmpty()) {
			model.addAttribute("cofix", coffixRates);
		}
		//국민수퍼정기예금
		List<SoosinRateDTO> superRates = dao.getAllInterestRate();
	    if (!superRates.isEmpty()) {
	    	model.addAttribute("superRates", superRates);
	    }
	    //KBSTAR정기예금
	    List<SoosinRateDTO2> kbStarRates = dao.getAllInterestRate2();
	    if (!kbStarRates.isEmpty()) {
	    	model.addAttribute("kbStarRates", kbStarRates);
	    } 

	    
		// To Do List
		ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
		List<TodoListDTO> todoList = todoDao.getTodayTasks(userno);
		model.addAttribute("todoList", todoList);

		// Memo Data
		MemoDao mdao = sqlSession.getMapper(MemoDao.class);
        ArrayList<MyMemoDTO> listMyMemo = mdao.memoView1(userno);
        ArrayList<DeptMemoDTO> listDeptMemo = mdao.memoView2(deptno);
        model.addAttribute("memo1", listMyMemo);
        model.addAttribute("memo2", listDeptMemo);
		
		// Notice Data
		List<NoticeDTO> noticeList = mdao.noticeView(deptno);
		model.addAttribute("noticeList", noticeList);

		long endTime = System.currentTimeMillis(); // 
		long duration = endTime - startTime; // 
		System.out.println("mainpage loading time: " + duration + "milisecond");
		
		//comment & Like
		AlertDao alertdao = sqlSession.getMapper(AlertDao.class);
		model.addAttribute("comment", alertdao.getRecentlyAlert(userno));
		
		
		//순서배열을 위한 임시 데이터
		DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
		
		String display1 = displayDao.getOrderDisplay1(userno);
		String display2 = displayDao.getOrderDisplay2(userno);
		String display3 = displayDao.getOrderDisplay3(userno);
		
		//기본 세팅
		List<String> displayOrder = Arrays.asList("currency", "stock", "interests");
		
		//순서 정보가 있는 경우 update
		if (display1 != null && display2 != null && display3 != null) {
			displayOrder = Arrays.asList(display1, display2, display3);
		} 
        
        ObjectMapper mapper = new ObjectMapper();
        try {
            String displayOrderJson = mapper.writeValueAsString(displayOrder); // 리스트를 JSON 문자열로 변환
            model.addAttribute("displayOrderJson", displayOrderJson);
        } catch (Exception e) {
            e.printStackTrace(); // JSON 변환 중 오류 처리
        }
        
        //전광판을 제외한 나머지 순서
        OrderDTO orderAll = displayDao.getOrderDisplayAll(userno);
        model.addAttribute("orderAll", orderAll);

        WikiDao wdao = sqlSession.getMapper(WikiDao.class);
        List<BoardDTO> bestPost = wdao.getBestPost();
        if(bestPost!=null)
			model.addAttribute("bestPost", bestPost);
        List<BoardDTO> bestWriter = wdao.getBestWriter();
        if(bestPost!=null)
        	model.addAttribute("bestWriter", bestWriter);
        
		return "main";
	}

	@RequestMapping("/noticeForm")
	public String noticeForm() {
		return "noticeForm";
	}
	
    @RequestMapping(value = "/updateDisplayOrder", method = RequestMethod.POST)
    @ResponseBody
    public String updateDisplayOrder(@RequestBody String newOrderJson, HttpSession session) {
    	
    	String userno = (String) session.getAttribute("userno");
    	
        // JSON 문자열 파싱
        JSONObject json = new JSONObject(newOrderJson);
        String order = json.getString("order");  // "currency,stock,interests"
        
        // 순서 정보 파싱
        String[] displays = order.split(",");
        if (displays.length == 3) {
            System.out.println("Display 1: " + displays[0]);
            System.out.println("Display 2: " + displays[1]);
            System.out.println("Display 3: " + displays[2]);
            
            DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
            String checkOrder = displayDao.getOrderDisplay1(userno);
            if(checkOrder != null) {
            	//업데이트
            	displayDao.updateDisplayOrder(userno, displays[0], displays[1], displays[2]);
            } else {
            	//인서트
            	displayDao.insertDisplayOrder(userno, displays[0], displays[1], displays[2]);
            }
            
        } else {
            System.out.println("Invalid display order received.");
        }
        
        return "{\"status\":\"success\"}";
    }
	
    @RequestMapping(value = "/updateDisplayOrder2", method = RequestMethod.POST)
    @ResponseBody
    public String updateDisplayOrder2(@RequestBody String newOrderJson, HttpSession session) {
    	
    	// TODO <---> 전광판
    	
    	String userno = (String) session.getAttribute("userno");
    	
        // JSON 문자열 파싱
        JSONObject json = new JSONObject(newOrderJson);
        String order = json.getString("order");  // "currency,stock,interests"
        
        // 순서 정보 파싱
        String[] displays = order.split(",");
        if (displays.length == 2) {
            System.out.println("Display 1: " + displays[0]);
            System.out.println("Display 2: " + displays[1]);
            
            DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
            OrderDTO orderDto = displayDao.getOrderDisplayAll(userno);
            
            if(orderDto != null) {
            	//업데이트
            	if (displays[0].equals("todo")) {
            		displayDao.updateDisplayOrderTodoDisplay(userno, 0);
            	} else {
            		displayDao.updateDisplayOrderTodoDisplay(userno, 1);
            	}
            	
            } else {
            	//업데이트
            	if (displays[0].equals("todo")) {
            		displayDao.insertDisplayOrderTodoDisplay(userno, 0);
            	} else {
            		displayDao.insertDisplayOrderTodoDisplay(userno, 1);
            	}
            }
            
        } else {
            System.out.println("Invalid display order received.");
        }
        
        return "{\"status\":\"success\"}";
    }

    @RequestMapping(value = "/updateDisplayOrder3", method = RequestMethod.POST)
    @ResponseBody
    public String updateDisplayOrder3(@RequestBody String newOrderJson, HttpSession session) {
    	
    	// 위 <------> 아래
    	String userno = (String) session.getAttribute("userno");
    	
        // JSON 문자열 파싱
        JSONObject json = new JSONObject(newOrderJson);
        String order = json.getString("order");  // "currency,stock,interests"
        
        // 순서 정보 파싱
        String[] displays = order.split(",");
        if (displays.length == 2) {
            System.out.println("위아래 순서 Display 1: " + displays[0]);
            System.out.println("위아래 순서 Display 2: " + displays[1]);
            
            DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
            OrderDTO orderDto = displayDao.getOrderDisplayAll(userno);
            
            if(orderDto != null) {
            	//업데이트
            	if (displays[0].equals("defaultTop")) {
            		displayDao.updateDisplayOrderTopBottom(userno, 0);
            	} else {
            		displayDao.updateDisplayOrderTopBottom(userno, 1);
            	}
            	
            } else {
            	//인서트
            	if (displays[0].equals("defaultTop")) {
            		displayDao.insertDisplayOrderTopBottom(userno, 0);
            	} else {
            		displayDao.insertDisplayOrderTopBottom(userno, 1);
            	}
            }
            
        } else {
            System.out.println("Invalid display order received.");
        }
        
        return "{\"status\":\"success\"}";
    }
    
    
    
    //아래 두 친구의 순서를 바꿔주는애
    @RequestMapping(value = "/updateDisplayOrder4", method = RequestMethod.POST)
    @ResponseBody
    public String updateDisplayOrder4(@RequestBody String newOrderJson, HttpSession session) {
    	
    	String userno = (String) session.getAttribute("userno");
    	
        // JSON 문자열 파싱
        JSONObject json = new JSONObject(newOrderJson);
        String order = json.getString("order");  // "currency,stock,interests"
        
        // 순서 정보 파싱
        String[] displays = order.split(",");
        if (displays.length == 2) {
            System.out.println("아래 두친구 순서 Display 1: " + displays[0]);
            System.out.println("아래 두친구 순서 Display 2: " + displays[1]);
            
            DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
            OrderDTO orderDto = displayDao.getOrderDisplayAll(userno);
            
            if(orderDto != null) {
            	//업데이트
            	if (displays[0].equals("bottom1")) {
            		displayDao.updateDisplayOrderTwoBottom(userno, 0);
            	} else {
            		displayDao.updateDisplayOrderTwoBottom(userno, 1);
            	}
            	
            } else {
            	//인서트
            	if (displays[0].equals("bottom1")) {
            		displayDao.insertDisplayOrderTwoBottom(userno, 0);
            	} else {
            		displayDao.insertDisplayOrderTwoBottom(userno, 1);
            	}
            }
            
        } else {
            System.out.println("Invalid display order received.");
        }
        
        return "{\"status\":\"success\"}";
    }
    
    //메모 - 노티스
    @RequestMapping(value = "/updateDisplayOrder5", method = RequestMethod.POST)
    @ResponseBody
    public String updateDisplayOrder5(@RequestBody String newOrderJson, HttpSession session) {
    	
    	String userno = (String) session.getAttribute("userno");
    	
        // JSON 문자열 파싱
        JSONObject json = new JSONObject(newOrderJson);
        String order = json.getString("order");  // "currency,stock,interests"
        
        // 순서 정보 파싱
        String[] displays = order.split(",");
        if (displays.length == 2) {
            System.out.println("아래 두친구 순서 Display 1: " + displays[0]);
            System.out.println("아래 두친구 순서 Display 2: " + displays[1]);
            
            DisplayDao displayDao = sqlSession.getMapper(DisplayDao.class);
            OrderDTO orderDto = displayDao.getOrderDisplayAll(userno);
            
            if(orderDto != null) {
            	//업데이트
            	if (displays[0].equals("memo")) {
            		displayDao.updateDisplayOrderMemoNotice(userno, 0);
            	} else {
            		displayDao.updateDisplayOrderMemoNotice(userno, 1);
            	}
            	
            } else {
            	//인서트
            	if (displays[0].equals("bottom1")) {
            		displayDao.insertDisplayOrderMemoNotice(userno, 0);
            	} else {
            		displayDao.insertDisplayOrderMemoNotice(userno, 1);
            	}
            }
            
        } else {
            System.out.println("Invalid display order received.");
        }
        
        return "{\"status\":\"success\"}";
    }
    
    
	public void setMenuDepth(List<MenuDTO> menus) {

		// // 메뉴 ID와 메뉴 객체를 매핑하는 Map을 생성
		Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for (MenuDTO menu : menus) {
			menuMap.put(menu.getId(), menu);
		}

		// 		// 각 메뉴 항목의 depth 계산
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
