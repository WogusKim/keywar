package kb.keyboard.warrior;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.ToDoDao;
import kb.keyboard.warrior.dto.ExchangeRate;
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
	    
	    //금리데이터 처리
	    
	    //To Do List 처리
	    ToDoDao dao = sqlSession.getMapper(ToDoDao.class);
	    List<TodoListDTO> todoList = dao.getToDoList(userno);
	    model.addAttribute("todoList", todoList);
	    
	    //Memo Data
	    
	    
	    
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
