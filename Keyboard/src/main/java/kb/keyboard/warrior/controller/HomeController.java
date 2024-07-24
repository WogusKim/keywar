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

        // �α��� ���� üũ
        String userno = (String) session.getAttribute("userno");
        String deptno = (String) session.getAttribute("deptno");

        // ���� �α��� ���� üũ �ʿ�


        // ���ǿ��� �޴� �����͸� Ȯ�� (Ȯ���� ������ ���� �ֱ�)!!!
        List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
        LoginDao loginDao = sqlSession.getMapper(LoginDao.class);

        if (menus == null) {
            menus = loginDao.getMenus(userno);
            setMenuDepth(menus);
            List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);
            session.setAttribute("menus", topLevelMenus);  // ���ǿ� �޴� ������ ����
            model.addAttribute("menus", topLevelMenus);
        } else {
            model.addAttribute("menus", menus);  // �̹� ���ǿ� ����� ������ ���
        }

        // ȯ�� ���ã�� Ȯ��
        List<ExchangeFavoriteDTO> favorites = loginDao.getFavoriteCurrency(userno);

        String favoriteCurrency1 = "0"; // ����Ʈ ��: USD
        String favoriteCurrency2 = "0"; // ����Ʈ ��: JPY
        String favoriteCurrency3 = "0"; // ����Ʈ ��: EUR

        switch (favorites.size()) {
            case 0:
                // ���ã�Ⱑ ���� ���� ���, ����Ʈ ȯ�� ����
                favoriteCurrency1 = "USD";
                favoriteCurrency2 = "JPY";
                favoriteCurrency3 = "EUR";
                break;
            case 1:
                // ���ã�Ⱑ �ϳ��� ���
                favoriteCurrency1 = favorites.get(0).getCurrency();
                break;
            case 2:
                // ���ã�Ⱑ �� ���� ���
                favoriteCurrency1 = favorites.get(0).getCurrency();
                favoriteCurrency2 = favorites.get(1).getCurrency();
                break;
            case 3:
                // ���ã�Ⱑ �� ���� ���
                favoriteCurrency1 = favorites.get(0).getCurrency();
                favoriteCurrency2 = favorites.get(1).getCurrency();
                favoriteCurrency3 = favorites.get(2).getCurrency();
                break;
        }
        

        // 
        CurrencyRateCrawler currencyCrawler = new CurrencyRateCrawler();
        List<ExchangeRateDTO> currencyRates = currencyCrawler.fetchExchangeFavoriteRates(favoriteCurrency1, favoriteCurrency2, favoriteCurrency3);
        if (!currencyRates.isEmpty()) {
            model.addAttribute("ratesFavorite", currencyRates);   
        } else {
            System.out.println("No rates found.");
        }
        
        // ȯ�� ���ã�� Ȯ��
        List<StockFavoriteDTO> stock = loginDao.getFavoriteStock(userno);

        String favoriteStock1 = "0"; // 
        String favoriteStock2 = "0"; // 
        String favoriteStock3 = "0"; //
        String favoriteStock4 = "0"; // 

        switch (favorites.size()) {
            case 0:
                // 아무것도 즐겨찾기 안했을 경우 기본
                favoriteStock1 = "KOSPI";
                favoriteStock2 = "KOSDAQ";
                favoriteStock3 = "SPI@SPX";
                favoriteStock4 = "NAS@IXIC";
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
        

        
        

        // MOR ������ ó��
        MorRateCrawler morCrawler = new MorRateCrawler();
        List<MorCoffixDTO> morRates = morCrawler.fetchMorRates();
        if (!morRates.isEmpty()) {
            model.addAttribute("mor", morRates);
        }

        // COFFIX ������ ó��
        CoffixRateCrawler coffixCrawler = new CoffixRateCrawler();
        List<MorCoffixDTO> coffixRates = coffixCrawler.fetchMorRates();
        if (!coffixRates.isEmpty()) {
            model.addAttribute("cofix", coffixRates);
        }

        // To Do List ó��
        ToDoDao todoDao = sqlSession.getMapper(ToDoDao.class);
        List<TodoListDTO> todoList = todoDao.getToDoList(userno);
        model.addAttribute("todoList", todoList);

        // Memo Data ó��
        MemoDao memoDao = sqlSession.getMapper(MemoDao.class);
        List<MyMemoDTO> memoList = memoDao.memoView1(userno);
        model.addAttribute("memoList", memoList);

        // Notice Data ó��
        List<NoticeDTO> noticeList = memoDao.noticeView(deptno);
        model.addAttribute("noticeList", noticeList);

        return "main";
    }

    @RequestMapping("/noticeForm")
    public String noticeForm() {		
        return "noticeForm";
    }

    public void setMenuDepth(List<MenuDTO> menus) {
        // �޴� ID�� �޴� ��ü�� �����ϴ� Map�� ����
        Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
        for (MenuDTO menu : menus) {
            menuMap.put(menu.getId(), menu);
        }

        // �� �޴� �׸��� depth ���
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

        // �α��� �߰��Ͽ� �� �ֻ��� �޴��� �ش� ���� �޴����� ���
        for (MenuDTO menu : topLevelMenus) {
            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
            printChildren(menu, "  ");  // ��������� ���� �޴����� ���
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
