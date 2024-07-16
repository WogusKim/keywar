package kb.keyboard.warrior;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
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
