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

        //寃쎈줈 �젣紐⑹쓣 �쐞�븳 遺�紐� id 寃��깋
        
        List<String> menuDirection = new ArrayList<String>();
        menuDirection.add(dao.getMenuDetail(id).getTitle()); //�궗�슜�옄�뿉寃� 諛쏆� �젣紐⑹쑝濡� �떆�옉
        Integer parentId = dao.getParentid(String.valueOf(id));
        
        while (parentId != null) {
            menuDirection.add(dao.getMenuDetail(parentId).getTitle());
            parentId = dao.getParentid(String.valueOf(parentId));
        }
        
        Collections.reverse(menuDirection); // �닚�꽌��濡� �젙�젹
        for (String item : menuDirection) {
            System.out.println(item);
        }
        model.addAttribute("direction", menuDirection);
        
        String wikiData = dao.getData(id);
        session.setAttribute("WikiId", id);
        
        if (wikiData == null) {
            System.out.println("珥덇린媛믪쓣 �꽕�젙�빀�땲�떎.");
            wikiData = "{\"time\":1721959855696,\"blocks\":[{\"id\":\"h6xL_peWS8\",\"type\":\"header\",\"data\":{\"text\":\"업무노트 개설을 축하합니다.\",\"level\":2}},{\"id\":\"ufod1niYAb\",\"type\":\"paragraph\",\"data\":{\"text\":\"열심히 노트를 작성하여 업무 효율을 높혀보세요!\"}}],\"version\":\"2.30.2\"}";
        }
        model.addAttribute("editorData", wikiData);
        
        
        
        //�씠誘몄��궗�씠利덉쿂由�
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
    	
        
        
        // editorContent �뜲�씠�꽣 異붿텧
        JSONObject json = new JSONObject(jsonData);
        JSONObject editorContent = json.getJSONObject("editorContent");
        
        // images �뜲�씠�꽣 異붿텧 諛� 泥섎━
        JSONArray imagesArray = json.getJSONArray("images");
        Map<String, String> imageDetails = new HashMap<String, String>();    
        
        for (int i = 0; i < imagesArray.length(); i++) {
            JSONObject image = imagesArray.getJSONObject(i);
            String url = image.getString("url");
            String width = image.getString("width");

            // URL�뿉�꽌 �븘�슂�븳 遺�遺꾨쭔 異붿텧
            String[] parts = url.split("/");
            if (parts.length > 1) {
                String filename = parts[parts.length - 1];
                // �씠�젣 �씠 shortUrl�쓣 �궗�슜�븯�뿬 留듭뿉 ���옣
                imageDetails.put(filename, width);
            }
        }
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        for (Map.Entry<String, String> entry : imageDetails.entrySet()) {
            String url = entry.getKey();
            String width = entry.getValue();

            // 媛� �씠誘몄� �젙蹂대�� 異쒕젰
            System.out.println("Wiki ID: " + wikiId + ", Image URL: " + url + ", Image Width: " + width);

            // 湲곗〈�뿉 �젙蹂닿� �엳�뒗吏� 泥댄겕
            String beforeSize = dao.getSize(wikiId, url);
            if (beforeSize != null) {
            	//湲곗〈 �젙蹂닿� �엳�뒗寃쎌슦 �뾽�뜲�씠�듃
            	dao.updateSize(wikiId, url, width);
            } else {
            	//湲곗〈 �젙蹂닿� �뾾�뒗 寃쎌슦 �씤�꽌�듃
            	dao.insertSize(wikiId, url, width);
            }
            
        }

        
        System.out.println("wikiId");
        System.out.println("Received data: " + editorContent);
        
        String wikiData = dao.getData(wikiId);
        
        if (wikiData == null) {
            // DB�뿉 �깉濡쒖슫 �뜲�씠�꽣濡� �궫�엯
            dao.insertWiki(wikiId, editorContent.toString());
        } else {
            // DB �뜲�씠�꽣 �뾽�뜲�씠�듃
            dao.updateWiki(wikiId, editorContent.toString());
        }
        
    
        // Return a response with HTTP 200 OK
        return new ResponseEntity<String>("Data received successfully", HttpStatus.OK);
    }
    
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpSession session) {
        
        Integer wikiId = (Integer) session.getAttribute("WikiId");
        System.out.println("�뙆�씪�뾽濡쒕뱶 �뀒�뒪�듃");
        
        if (!file.isEmpty()) {
            try {

                String basePath = request.getSession().getServletContext().getRealPath("/resources/upload") + "/" + wikiId;
                System.out.println("�뾽濡쒕뱶 寃쎈줈: " + basePath);
                
                File dir = new File(basePath);
                if (!dir.exists()) {
                    dir.mkdirs(); // �뤃�뜑媛� �뾾�쑝硫� �깮�꽦
                }

                String originalFilename = file.getOriginalFilename();
                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = UUID.randomUUID().toString() + fileExtension;


                File dest = new File(basePath, newFilename); // �뙆�씪 ���옣 寃쎈줈�뿉 �뙆�씪紐낆쓣 �룷�븿�븯�뿬 �깮�꽦
                //file.transferTo(dest); // �뙆�씪�쓣 �쐞�뿉�꽌 吏��젙�븳 寃쎈줈�� �뙆�씪紐낆쑝濡� ���옣
                Thumbnails.of(file.getInputStream())
                .width(500)  // 理쒕� �겕湲곕쭔 吏��젙
                .keepAspectRatio(true)  // 鍮꾩쑉 �쑀吏�
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
