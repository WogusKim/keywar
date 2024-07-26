package kb.keyboard.warrior.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kb.keyboard.warrior.dao.WikiDao;




@Controller
public class WikiDetailController {
	
	
    @Autowired
    public SqlSession sqlSession;
    
    
    @RequestMapping("/wikiDetail")
    public String wikiDetail(Model model, @RequestParam("id") int id, HttpSession session) {
    	WikiDao dao = sqlSession.getMapper(WikiDao.class);
    	String wikiData = dao.getData(id);
    	System.out.println("위키디테일진입 : " + id);
    	session.setAttribute("WikiId", id);
    	
    	if (wikiData == null) {
    		System.out.println("초기값을 제공합니다.");
    		wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"업무노트 개설을 축하합니다.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"열심히 노트를 작성하여 업무 효율을 높혀보세요!\"}}],\"version\":\"2.30.2\"}";
    	}
    	model.addAttribute("editorData", wikiData);
    	
    	return "wiki/editorDetail";
    }

    
	@RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
	public ResponseEntity<String> saveEditorData(@RequestBody String editorData, HttpSession session) {

		Integer wikiId = (Integer) session.getAttribute("WikiId");
	    
	    System.out.println("wikiId");
	    System.out.println("Received data: " + editorData);
	    
	    WikiDao dao = sqlSession.getMapper(WikiDao.class);
	    String wikiData = dao.getData(wikiId);
	    
	    if (wikiData == null) {
	    	//insert 실행
	    	dao.insertWiki(wikiId, editorData);
	    } else {
	    	//update 실행
	    	dao.updateWiki(wikiId, editorData);
	    }
	    
	
	    // Return a response with HTTP 200 OK
	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
	}

}





