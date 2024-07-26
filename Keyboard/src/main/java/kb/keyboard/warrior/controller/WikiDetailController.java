package kb.keyboard.warrior.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.EditorContentDTO;
import kb.keyboard.warrior.dto.WikiTestDTO;


import org.apache.commons.text.StringEscapeUtils;
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

	
    @RequestMapping("/editorTest")
    public String editorTest(Model model) {
    	
    	//--------------------------- 테스트를 위한 임시테이더 ---------------------------//
//        Map<String, Object> contentData = new HashMap<String, Object>();
//        contentData.put("time", System.currentTimeMillis());
//        contentData.put("version", "2.26.5");
//        Map<String, Object> headerData = new HashMap<String, Object>();
//        headerData.put("text", "서버에서 보내는 데이터");
//        headerData.put("level", 2);
//        Map<String, Object> headerBlock = new HashMap<String, Object>();
//        headerBlock.put("type", "header");
//        headerBlock.put("data", headerData);
//        Map<String, Object> listData = new HashMap<String, Object>();
//        listData.put("style", "ordered");
//        List<String> items = new ArrayList<String>();
//        items.add("서버리스트1");
//        items.add("서버리스트2");
//        items.add("서버리스트3");
//        items.add("서버리스트4");
//        listData.put("items", items);
//        Map<String, Object> listBlock = new HashMap<String, Object>();
//        listBlock.put("type", "list");
//        listBlock.put("data", listData);
//        List<Map<String, Object>> blocks = new ArrayList<Map<String, Object>>();
//        blocks.add(headerBlock);
//        blocks.add(listBlock);
//        contentData.put("blocks", blocks);
//        ObjectMapper mapper = new ObjectMapper();
        try {
//          String jsonData = mapper.writeValueAsString(contentData);
	        String jsonData = "{\"time\":1721958509857,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"서버에서 보내는 데이터\",\"level\":2}},{\"id\":\"jnrrprcLJj\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"서버리스트1\",\"서버리스트2\",\"서버리스트3\",\"서버리스트4\"]}},{\"id\":\"WrB8c31ErV\",\"type\":\"paragraph\",\"data\":{\"text\":\"ㅇㅇㅇ\"}}],\"version\":\"2.30.2\"}";
            model.addAttribute("editorData", jsonData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //--------------------------- 테스트를 위한 임시테이더 ---------------------------//
  	
    	
    	return "wiki/editorTest";
    }
	
	
	
    //20240726 테스트중
//	@RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
//	public ResponseEntity<String> saveEditorData(@RequestBody JsonNode jsonData) {
//		
//		
//		
//		System.out.println("컨트롤러 진입");
//		System.out.println("Received JSON data: " + jsonData.toString());
//		
//        EditorContentDTO content = new EditorContentDTO();
//        content.setId(40);
//        content.setJsonData(jsonData);
//        
//        WikiDao dao = sqlSession.getMapper(WikiDao.class);
//        dao.insertEditorContent(content.getId(), content.getJsonData());
//
//	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
//	}
	
	
	
	
	
	
	
	
	
	
	//JSON 데이터 저장을 시도해보는 메서드임
	@RequestMapping(value = "/saveEditorData2", method = RequestMethod.POST)
	public ResponseEntity<String> saveEditorData2(@RequestBody WikiTestDTO wikiTestDTO) {
		
		
	    // Process the data, save to database, etc.
	    //System.out.println("Received data: " + editorData);
	
	    // Return a response with HTTP 200 OK
	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
	}

}

