package kb.keyboard.warrior.wiki.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import kb.keyboard.warrior.Command;


@Component
public class WikiSampleCommand implements Command {

    

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

//		HttpSession session = request.getSession();
		
	  
	}
	
	

	
}
