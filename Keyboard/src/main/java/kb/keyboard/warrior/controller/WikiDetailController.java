package kb.keyboard.warrior.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import kb.keyboard.warrior.dao.WikiDao;




@Controller
public class WikiDetailController {
	
	
    @Autowired
    public SqlSession sqlSession;
    
    
    @RequestMapping("/wikiDetail")
    public String wikiDetail(Model model, @RequestParam("id") int id, HttpSession session) {
    	
    	WikiDao dao = sqlSession.getMapper(WikiDao.class);

    	//��� ������ ���� �θ� id Ž��
    	
    	List<String> menuDirection = new ArrayList<String>();
    	menuDirection.add(dao.getMenuDetail(id).getTitle()); //�ڱ��ڽ� Ÿ��Ʋ �ְ� ����
    	Integer parentId = dao.getParentid(String.valueOf(id));
    	
        while (parentId != null) {
            menuDirection.add(dao.getMenuDetail(parentId).getTitle());
            parentId = dao.getParentid(String.valueOf(parentId));
        }
        
    	Collections.reverse(menuDirection); // �������� ����
    	for (String item : menuDirection) {
    		System.out.println(item);
    	}
    	model.addAttribute("direction", menuDirection);
    	
    	String wikiData = dao.getData(id);
    	session.setAttribute("WikiId", id);
    	
    	if (wikiData == null) {
    		System.out.println("�ʱⰪ�� �����մϴ�.");
    		wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"������Ʈ ������ �����մϴ�.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"������ ��Ʈ�� �ۼ��Ͽ� ���� ȿ���� ����������!\"}}],\"version\":\"2.30.2\"}";
    	}
    	model.addAttribute("editorData", wikiData);
    	
    	return "wiki/editorDetail";
    }

    
	private String toString(int id) {
		// TODO Auto-generated method stub
		return null;
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
	
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpSession session) {
		
		Integer wikiId = (Integer) session.getAttribute("WikiId");
		System.out.println("���Ͼ��ε� �׽�Ʈ");
		
	    if (!file.isEmpty()) {
	        try {

	        	String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
	        	System.out.println("���ε� ���: " + basePath);
	        	
	        	File dir = new File(basePath);
	        	if (!dir.exists()) {
	        	    dir.mkdirs(); // ������ ���ٸ� ����
	        	}

	        	String originalFilename = file.getOriginalFilename();
	        	String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	        	String newFilename = UUID.randomUUID().toString() + fileExtension;

	        	File dest = new File(basePath, newFilename); // ���� ���� ��ο� ���ϸ��� �����Ͽ� ����
	        	file.transferTo(dest); // ������ ������ ������ ��ο� ���ϸ����� ����

	        	HashMap response = new HashMap();
	        	response.put("success", 1);
	        	HashMap fileDetails = new HashMap();
	        	fileDetails.put("url", request.getContextPath() + "/resources/upload/" + wikiId + "/" + newFilename);
	        	response.put("file", fileDetails);

	            return new ResponseEntity<HashMap>(response, HttpStatus.OK);
	        } catch (Exception e) {
	            HashMap error = new HashMap();
	            error.put("success", 0);
	            error.put("message", "File upload failed");
	            return new ResponseEntity<HashMap>(error, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    } else {
	        HashMap error = new HashMap();
	        error.put("success", 0);
	        error.put("message", "No file uploaded");
	        return new ResponseEntity<HashMap>(error, HttpStatus.BAD_REQUEST);
	    }
	}
	
	
	
}





