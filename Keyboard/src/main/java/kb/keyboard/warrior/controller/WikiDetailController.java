package kb.keyboard.warrior.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.fasterxml.jackson.databind.ObjectMapper;


import kb.keyboard.warrior.dto.WikiTestDTO;


import org.apache.commons.text.StringEscapeUtils;
@Controller
public class WikiDetailController {
    @Autowired
    public SqlSession sqlSession;
    @RequestMapping("/editorTest")
    public String editorTest(Model model) {
    	
    	//--------------------------- 테스트를 위한 임시테이더 ---------------------------//
        Map<String, Object> contentData = new HashMap<String, Object>();
        contentData.put("time", System.currentTimeMillis());
        contentData.put("version", "2.26.5");
        Map<String, Object> headerData = new HashMap<String, Object>();
        headerData.put("text", "서버에서 보내는 데이터");
        headerData.put("level", 2);
        Map<String, Object> headerBlock = new HashMap<String, Object>();
        headerBlock.put("type", "header");
        headerBlock.put("data", headerData);
        Map<String, Object> listData = new HashMap<String, Object>();
        listData.put("style", "ordered");
        List<String> items = new ArrayList<String>();
        items.add("서버리스트1");
        items.add("서버리스트2");
        items.add("서버리스트3");
        items.add("서버리스트4");
        listData.put("items", items);
        Map<String, Object> listBlock = new HashMap<String, Object>();
        listBlock.put("type", "list");
        listBlock.put("data", listData);
        List<Map<String, Object>> blocks = new ArrayList<Map<String, Object>>();
        blocks.add(headerBlock);
        blocks.add(listBlock);
        contentData.put("blocks", blocks);
        ObjectMapper mapper = new ObjectMapper();
        try {
            String jsonData = mapper.writeValueAsString(contentData);
            model.addAttribute("editorData", jsonData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //--------------------------- 테스트를 위한 임시테이더 ---------------------------//
  	
    	
    	return "wiki/editorTest";
    }
	@RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
	public ResponseEntity<String> saveEditorData(@RequestBody String editorData) {
	    // Process the data, save to database, etc.
	    System.out.println("Received data: " + editorData);
	
	    // Return a response with HTTP 200 OK
	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
	}

	
	@RequestMapping(value = "/saveEditorData2", method = RequestMethod.POST)
	public ResponseEntity<String> saveEditorData2(@RequestBody WikiTestDTO wikiTestDTO) {
		
	    // Process the data, save to database, etc.
	    //System.out.println("Received data: " + editorData);
	
	    // Return a response with HTTP 200 OK
	    return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
	}


}

