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

import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.ScheduleDTO;
import net.coobird.thumbnailator.Thumbnails;

@Controller
public class WikiDetailController {

	@Autowired
	public SqlSession sqlSession;

	// 핸들러 메소드: wiki 상세 페이지를 불러오는 메소드
	@RequestMapping("/wikiDetail")
	public String wikiDetail(Model model, @RequestParam("id") int id, HttpSession session) {

		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		System.out.println("선택한 메뉴트리 작성자 유저넘버"+dao.getMenuDetail(id).getUserno());
		String userno = (String)session.getAttribute("userno");
		if(!dao.getMenuDetail(id).getUserno().equals(userno)) {
			System.out.println("작성자가 아닌 잘못된 접근입니다.");
			return "redirect:main";
		}
		
		// 경로 제공을 위한 부모 id 탐색
		List<String> menuDirection = new ArrayList<String>();
		menuDirection.add(dao.getMenuDetail(id).getTitle()); // 자기자신 타이틀 넣고 시작
		Integer parentId = dao.getParentid(String.valueOf(id));

		while (parentId != null) {
			menuDirection.add(dao.getMenuDetail(parentId).getTitle());
			parentId = dao.getParentid(String.valueOf(parentId));
		}

		Collections.reverse(menuDirection); // 역순으로 정렬
		for (String item : menuDirection) {
			System.out.println(item);
		}
		model.addAttribute("direction", menuDirection);

		String wikiData = dao.getData(id);
		session.setAttribute("WikiId", id);

		if (wikiData == null) {
			System.out.println("초기값을 제공합니다.");
			wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"업무노트 개설을 축하합니다.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"열심히 노트를 작성하여 업무 효율을 높혀보세요!\"}}],\"version\":\"2.30.2\"}";
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
	    try {
	        if (dao.getData(wikiId) == null) {
	            dao.insertWiki(wikiId, editorData);
	        } else {
	            dao.updateWiki(wikiId, editorData);
	        }
	     // 데이터 저장 성공 시
	        return new ResponseEntity("{\"message\":\"Data received successfully\"}", HttpStatus.OK);


	    } catch (Exception e) {
	    	// 서버 내부 에러 발생 시
	    	return new ResponseEntity("{\"error\":\"" + e.getMessage() + "\"}", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}



	
	// 핸들러 메소드: 파일을 서버에 업로드
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public ResponseEntity<HashMap<String, Object>> uploadFile(
	    @RequestParam("file") MultipartFile file,
	    @RequestParam(value = "width", required = false) Integer width,
	    @RequestParam(value = "height", required = false) Integer height,
	    @RequestParam(value = "align", required = false) String align, // 정렬 상태 파라미터 추가
	    HttpServletRequest request,
	    HttpSession session) {

	    Integer wikiId = (Integer) session.getAttribute("WikiId");
	    if (!file.isEmpty()) {
	        try {
	            String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
	            File dir = new File(basePath);
	            if (!dir.exists()) dir.mkdirs(); // 폴더가 없다면 생성

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
	
	
	//파일업로드용
	@RequestMapping(value = "/uploadFile2", method = RequestMethod.POST)
	public ResponseEntity<HashMap<String, Object>> uploadFile2(
	    @RequestParam("file") MultipartFile file,
	    HttpServletRequest request,
	    HttpSession session) {
		
		System.out.println("서버 테스트");

	    Integer wikiId = (Integer) session.getAttribute("WikiId"); // 이 부분은 위키 ID에 따라 변경 가능
	    
	    if (!file.isEmpty()) {
	        try {
	            String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
	            File dir = new File(basePath);
	            if (!dir.exists()) dir.mkdirs(); // 폴더가 없다면 생성

	            String originalFilename = file.getOriginalFilename();
	            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String newFilename = UUID.randomUUID().toString() + fileExtension;

	            File dest = new File(basePath, newFilename);
	            file.transferTo(dest); // 파일 저장

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