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
    	System.out.println("��Ű���������� : " + id);
    	session.setAttribute("WikiId", id);
    	
    	if (wikiData == null) {
    		System.out.println("�ʱⰪ�� �����մϴ�.");
    		wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"������Ʈ ������ �����մϴ�.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"������ ��Ʈ�� �ۼ��Ͽ� ���� ȿ���� ����������!\"}}],\"version\":\"2.30.2\"}";
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
	    	//insert ����
	    	dao.insertWiki(wikiId, editorData);
	    } else {
	    	//update ����
	    	dao.updateWiki(wikiId, editorData);
	    }
	    
	
	    // Return a response with HTTP 200 OK
	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
	}

	
    @RequestMapping("/editorTest")
    public String editorTest(Model model) {
    	
    	//--------------------------- �׽�Ʈ�� ���� �ӽ����̴� ---------------------------//
//        Map<String, Object> contentData = new HashMap<String, Object>();
//        contentData.put("time", System.currentTimeMillis());
//        contentData.put("version", "2.26.5");
//        Map<String, Object> headerData = new HashMap<String, Object>();
//        headerData.put("text", "�������� ������ ������");
//        headerData.put("level", 2);
//        Map<String, Object> headerBlock = new HashMap<String, Object>();
//        headerBlock.put("type", "header");
//        headerBlock.put("data", headerData);
//        Map<String, Object> listData = new HashMap<String, Object>();
//        listData.put("style", "ordered");
//        List<String> items = new ArrayList<String>();
//        items.add("��������Ʈ1");
//        items.add("��������Ʈ2");
//        items.add("��������Ʈ3");
//        items.add("��������Ʈ4");
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
	        String jsonData = "{\"time\":1721958509857,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"�������� ������ ������\",\"level\":2}},{\"id\":\"jnrrprcLJj\",\"type\":\"list\",\"data\":{\"style\":\"ordered\",\"items\":[\"��������Ʈ1\",\"��������Ʈ2\",\"��������Ʈ3\",\"��������Ʈ4\"]}},{\"id\":\"WrB8c31ErV\",\"type\":\"paragraph\",\"data\":{\"text\":\"������\"}}],\"version\":\"2.30.2\"}";
            model.addAttribute("editorData", jsonData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //--------------------------- �׽�Ʈ�� ���� �ӽ����̴� ---------------------------//
  	
    	
    	return "wiki/editorTest";
    }
	
	
	
    //20240726 �׽�Ʈ��
//	@RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
//	public ResponseEntity<String> saveEditorData(@RequestBody JsonNode jsonData) {
//		
//		
//		
//		System.out.println("��Ʈ�ѷ� ����");
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
	
	
	
	
	
	
	
	
	
	
	//JSON ������ ������ �õ��غ��� �޼�����
	@RequestMapping(value = "/saveEditorData2", method = RequestMethod.POST)
	public ResponseEntity<String> saveEditorData2(@RequestBody WikiTestDTO wikiTestDTO) {
		
		
	    // Process the data, save to database, etc.
	    //System.out.println("Received data: " + editorData);
	
	    // Return a response with HTTP 200 OK
	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
	}

}

