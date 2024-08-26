package kb.keyboard.warrior.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
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

import kb.keyboard.warrior.dao.AlertDao;
import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.AlertDTO;
import kb.keyboard.warrior.dto.BoardDTO;
import kb.keyboard.warrior.dto.ScheduleDTO;
import kb.keyboard.warrior.dto.UserDTO;
import net.coobird.thumbnailator.Thumbnails;

@Controller
public class WikiDetailController {

	@Autowired
	public SqlSession sqlSession;

    // �޼ҵ�: wiki �� �������� �ҷ����� �޼ҵ�
    @RequestMapping("/wikiDetail")
    public String wikiDetail(Model model, @RequestParam("id") int id, HttpSession session) {

        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        LoginDao ldao = sqlSession.getMapper(LoginDao.class);
        System.out.println("������ �޴�Ʈ�� �ۼ��� ������ȣ: " + dao.getMenuDetail(id).getUserno());
        String userno = (String)session.getAttribute("userno");
        if(!dao.getMenuDetail(id).getUserno().equals(userno)) {
            System.out.println("�ۼ��ڰ� �ƴ� �߸��� �����Դϴ�.");
            return "redirect:main";
        }
		
        // ��� ��� ���� �θ� id �˻�
        List<String> menuDirection = new ArrayList<String>();
        menuDirection.add(dao.getMenuDetail(id).getTitle()); // �ۼ��ں��� ������ �ְ� ����
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

        UserDTO userdto = ldao.isRightUserno(userno);
        String guide = "�ۼ��� : " + userdto.getNickname(); 
        
        if (wikiData == null) {
            System.out.println("�ʱⰪ�� �����ϰڽ��ϴ�.");
            wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\""+dao.getMenuDetail(id).getTitle()+"\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\""+guide+"\"}}],\"version\":\"2.30.2\"}";
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
	    WikiDao dao = sqlSession.getMapper(WikiDao.class);
	    AlertDao adao = sqlSession.getMapper(AlertDao.class);
	    String userno = (String)session.getAttribute("userno");
	    
	    try {
	        if (dao.getData(wikiId) == null) {
                // ���� ���� ��
	            dao.insertWiki(wikiId, editorData);
                // �˸��� ���� �ȷο� ����Ʈ �������� �۾�
	            List<String> followers = adao.sortMyFollower(userno);
                // �˸��� �����ڿ��� �߰�
	            BoardDTO bdto = dao.getPostInfo(wikiId+""); 
                String message = "�ۼ��� : " + bdto.getNickname() + " ���� ���ο� �Խù��� �ۼ��Ͽ����ϴ�. (" + bdto.getTitleShare() + ")";
	            for(String follower : followers) {
	            	AlertDTO adto = new AlertDTO(follower, message, wikiId+"");
	            	adao.addSubscribeAlert(adto);
	            }
	        } else {
	            dao.updateWiki(wikiId, editorData);
                // ���� �ÿ��� ���� �˸� ���� �� ��
	        }
            // ������ ���� ���� ��
	        return new ResponseEntity("{\"message\":\"Data received successfully\"}", HttpStatus.OK);


	    } catch (Exception e) {
            // ���� ������ ���� �߻� ��
	    	return new ResponseEntity("{\"error\":\"" + e.getMessage() + "\"}", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}



	
    // �޼ҵ�: ������ ������ ���ε�
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public ResponseEntity<HashMap<String, Object>> uploadFile(
	    @RequestParam("file") MultipartFile file,
	    @RequestParam(value = "width", required = false) Integer width,
	    @RequestParam(value = "height", required = false) Integer height,
	    @RequestParam(value = "align", required = false) String align, // ���� ���� �Ķ���� �߰�
        HttpServletRequest request,
	    HttpSession session) {

	    Integer wikiId = (Integer) session.getAttribute("WikiId");
	    if (!file.isEmpty()) {
	        try {
	            String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
	            File dir = new File(basePath);
                if (!dir.exists()) dir.mkdirs(); // ������ ������ ����

	            String originalFilename = file.getOriginalFilename();
	            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String newFilename = UUID.randomUUID().toString() + fileExtension;

	            File dest = new File(basePath, newFilename);
	            Thumbnails.of(file.getInputStream()).size(width != null ? width : 200, height != null ? height : 200).toFile(dest);

	            HashMap<String, Object> response = new HashMap<String, Object>();
	            response.put("success", 1);
	            HashMap<String, String> fileDetails = new HashMap<String, String>();
	            fileDetails.put("url", request.getContextPath() + "/resources/upload/" + wikiId + "/" + newFilename);
	            response.put("file", fileDetails);

	            return new ResponseEntity<HashMap<String, Object>>(response, HttpStatus.OK);
	        } catch (Exception e) {
	            HashMap<String, Object> error = new HashMap<String, Object>();
	            error.put("success", 0);
	            error.put("message", "File upload failed: " + e.getMessage());
	            return new ResponseEntity<HashMap<String, Object>>(error, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    } else {
	        HashMap<String, Object> error = new HashMap<String, Object>();
	        error.put("success", 0);
	        error.put("message", "No file uploaded");
	        return new ResponseEntity<HashMap<String, Object>>(error, HttpStatus.BAD_REQUEST);
	    }
	}
	
	
    // ���� ���ε��
	@RequestMapping(value = "/uploadFile2", method = RequestMethod.POST)
	public ResponseEntity<HashMap<String, Object>> uploadFile2(
	    @RequestParam("file") MultipartFile file,
	    HttpServletRequest request,
	    HttpSession session) {
		
        System.out.println("���� �׽�Ʈ");

        Integer wikiId = (Integer) session.getAttribute("WikiId"); // �� �κ��� ��Ű ID�� ���� ���� ó��
	    
	    if (!file.isEmpty()) {
	        try {
	            String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
	            File dir = new File(basePath);
                if (!dir.exists()) dir.mkdirs(); // ������ ������ ����

	            String originalFilename = file.getOriginalFilename();
	            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String newFilename = UUID.randomUUID().toString() + fileExtension;

	            File dest = new File(basePath, newFilename);
                file.transferTo(dest); // ���� ����

	            HashMap<String, Object> response = new HashMap<String, Object>();
	            response.put("success", 1);
	            HashMap<String, String> fileDetails = new HashMap<String, String>();
	            fileDetails.put("url", request.getContextPath() + "/resources/upload/" + wikiId + "/" + newFilename);
	            response.put("file", fileDetails);

	            return new ResponseEntity<HashMap<String, Object>>(response, HttpStatus.OK);
	        } catch (Exception e) {
	            HashMap<String, Object> error = new HashMap<String, Object>();
	            error.put("success", 0);
	            error.put("message", "File upload failed: " + e.getMessage());
	            return new ResponseEntity<HashMap<String, Object>>(error, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    } else {
	        HashMap<String, Object> error = new HashMap<String, Object>();
	        error.put("success", 0);
	        error.put("message", "No file uploaded");
	        return new ResponseEntity<HashMap<String, Object>>(error, HttpStatus.BAD_REQUEST);
	    }
	}
}