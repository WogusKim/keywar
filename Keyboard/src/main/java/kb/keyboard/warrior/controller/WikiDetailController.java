package kb.keyboard.warrior.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.apache.commons.text.StringEscapeUtils;

@Controller
public class WikiDetailController {
    @Autowired
    public SqlSession sqlSession;
    
    @RequestMapping("/editorTest")
    public String editorTest(Model model) {

    	
    	//--------------------------- �׽�Ʈ�� ���� �ӽ����̴� ---------------------------//
        Map<String, Object> contentData = new HashMap<String, Object>();
        contentData.put("time", System.currentTimeMillis());
//        contentData.put("blocks", new String[] {
//            "{\"type\": \"header\", \"data\": {\"text\": \"�����Ϳ� ���� ���� ȯ���մϴ�\", \"level\": 2}}"
//        });
        contentData.put("blocks", new String[] {
                "{'type': 'header', 'data': {'text' : '�����Ϳ� ���� ���� ȯ���մϴ�', 'level': 2}}"
            });    
        contentData.put("version", "2.26.5");

        ObjectMapper mapper = new ObjectMapper();
        try {
            String jsonData = mapper.writeValueAsString(contentData);
            String safeJsonData = StringEscapeUtils.escapeEcmaScript(jsonData);
            model.addAttribute("editorData", safeJsonData);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //--------------------------- �׽�Ʈ�� ���� �ӽ����̴� ---------------------------//
  	
    	
    	return "wiki/editorTest";
    }
}
