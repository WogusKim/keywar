package kb.keyboard.warrior.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WikiController {

	@Autowired
	public SqlSession sqlSession;
	
	@RequestMapping("/menuSetting")
	public String menuSetting(Model model) {
		
		return "wiki/menuSetting";
	}
}
