package kb.keyboard.warrior.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.ImageSizeDTO;




@Controller
public class WikiDetailController {
    
    
    @Autowired
    public SqlSession sqlSession;
    
    
    @RequestMapping("/wikiDetail")
    public String wikiDetail(Model model, @RequestParam("id") int id, HttpSession session) {
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);

        //경로 제목을 위한 부모 id 검색
        
        List<String> menuDirection = new ArrayList<String>();
        menuDirection.add(dao.getMenuDetail(id).getTitle()); //사용자에게 받은 제목으로 시작
        Integer parentId = dao.getParentid(String.valueOf(id));
        
        while (parentId != null) {
            menuDirection.add(dao.getMenuDetail(parentId).getTitle());
            parentId = dao.getParentid(String.valueOf(parentId));
        }
        
        Collections.reverse(menuDirection); // 순서대로 정렬
        for (String item : menuDirection) {
            System.out.println(item);
        }
        model.addAttribute("direction", menuDirection);
        
        String wikiData = dao.getData(id);
        session.setAttribute("WikiId", id);
        
        if (wikiData == null) {
            System.out.println("초기값을 설정합니다.");
            wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"업무노트 개설을 축하합니다.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"열심히 노트를 작성하여 업무 효율을 높혀보세요!\"}}],\"version\":\"2.30.2\"}";
        }
        model.addAttribute("editorData", wikiData);
        
        
        
        //이미지사이즈처리
        List<ImageSizeDTO> imageSizeList = dao.getAllSizeOfImg(id);
        ObjectMapper mapper = new ObjectMapper();
        String imageSizeJson;
		try {
			imageSizeJson = mapper.writeValueAsString(imageSizeList);
			model.addAttribute("imageSizeList", imageSizeJson);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        

        return "wiki/editorDetail";
    }

    
//    private String toString(int id) {
//        // TODO Auto-generated method stub
//        return null;
//    }


    @RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
    public ResponseEntity<String> saveEditorData(@RequestBody String jsonData, HttpSession session) {
    	
        Integer wikiId = (Integer) session.getAttribute("WikiId");
    	
        
        
        // editorContent 데이터 추출
        JSONObject json = new JSONObject(jsonData);
        JSONObject editorContent = json.getJSONObject("editorContent");
        
        // images 데이터 추출 및 처리
        JSONArray imagesArray = json.getJSONArray("images");
        Map<String, String> imageDetails = new HashMap<String, String>();    
        
        for (int i = 0; i < imagesArray.length(); i++) {
            JSONObject image = imagesArray.getJSONObject(i);
            String url = image.getString("url");
            String width = image.getString("width");

            // URL에서 필요한 부분만 추출
            String[] parts = url.split("/");
            if (parts.length > 1) {
                String filename = parts[parts.length - 1];
                // 이제 이 shortUrl을 사용하여 맵에 저장
                imageDetails.put(filename, width);
            }
        }
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        for (Map.Entry<String, String> entry : imageDetails.entrySet()) {
            String url = entry.getKey();
            String width = entry.getValue();

            // 각 이미지 정보를 출력
            System.out.println("Wiki ID: " + wikiId + ", Image URL: " + url + ", Image Width: " + width);

            // 기존에 정보가 있는지 체크
            String beforeSize = dao.getSize(wikiId, url);
            if (beforeSize != null) {
            	//기존 정보가 있는경우 업데이트
            	dao.updateSize(wikiId, url, width);
            } else {
            	//기존 정보가 없는 경우 인서트
            	dao.insertSize(wikiId, url, width);
            }
            
        }

        
        System.out.println("wikiId");
        System.out.println("Received data: " + editorContent);
        
        String wikiData = dao.getData(wikiId);
        
        if (wikiData == null) {
            // DB에 새로운 데이터로 삽입
            dao.insertWiki(wikiId, editorContent.toString());
        } else {
            // DB 데이터 업데이트
            dao.updateWiki(wikiId, editorContent.toString());
        }
        
    
        // Return a response with HTTP 200 OK
        return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
    }
    
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpSession session) {
        
        Integer wikiId = (Integer) session.getAttribute("WikiId");
        System.out.println("파일업로드 테스트");
        
        if (!file.isEmpty()) {
            try {

                String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
                System.out.println("업로드 경로: " + basePath);
                
                File dir = new File(basePath);
                if (!dir.exists()) {
                    dir.mkdirs(); // 폴더가 없으면 생성
                }

                String originalFilename = file.getOriginalFilename();
                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = UUID.randomUUID().toString() + fileExtension;


                File dest = new File(basePath, newFilename); // 파일 저장 경로에 파일명을 포함하여 생성
                //file.transferTo(dest); // 파일을 위에서 지정한 경로와 파일명으로 저장
                Thumbnails.of(file.getInputStream())
                .width(500)  // 최대 크기만 지정
                .keepAspectRatio(true)  // 비율 유지
                .toFile(dest);
               

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
