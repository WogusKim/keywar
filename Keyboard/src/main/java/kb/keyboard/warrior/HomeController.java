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
		
		//�α��ο��� üũ
		String userno = (String) session.getAttribute("userno");
		String deptno = (String) session.getAttribute("deptno");
		
		//���� �α��� ���� üũ �ʿ�
		
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
	    
	    //�ݸ������� ó��
	    
	    //To Do List ó��
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
