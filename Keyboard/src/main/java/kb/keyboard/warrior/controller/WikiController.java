package kb.keyboard.warrior.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.MenuDTO;
import kb.keyboard.warrior.dto.ScheduleDTO;

@Controller
public class WikiController {

	@Autowired
	public SqlSession sqlSession;
	
	@RequestMapping("/menuSetting")
	public String menuSetting(Model model, HttpSession session) {
		
		String userno = (String) session.getAttribute("userno");
		
        // 硫붾돱�뜲�씠�꽣瑜� �꽭�뀡怨� 紐⑤뜽�뿉 �쟾遺� �떞�븘以�.
        List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
        LoginDao loginDao = sqlSession.getMapper(LoginDao.class);

        menus = loginDao.getMenus(userno);
        setMenuDepth(menus);
        List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);
        session.setAttribute("menus", topLevelMenus);
        model.addAttribute("menus", topLevelMenus);
		
		return "wiki/menuSetting";
	}
	
	@RequestMapping("/addMenu")
	public String menuAdd(Model model, HttpServletRequest request, HttpSession session) {
		
		//�꽭�뀡泥댄겕
        String userno = (String) session.getAttribute("userno");
		
		//湲곗��뜲�씠�꽣
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		//�떊洹쒖궫�엯�뜲�씠�꽣
		String menuType = request.getParameter("menuType");
		String title = request.getParameter("title");
		String sharedTitle = request.getParameter("sharedTitle");
		
//		System.out.println("湲곗� id: " + selectedId);
//		System.out.println("湲곗� type: " + selectedType);
//		System.out.println("湲곗� depth: " + selectedDepth);
//		
//		System.out.println("異붽��븷 Type: " + menuType);
//		System.out.println("異붽��븷 Title: " + title);
//		System.out.println("異붽��븷 怨듭쑀title: " + sharedTitle);
		
        // �쁽�옱 �궇吏쒖� �떆媛꾩쓣 'yyyyMMdd_HHmmss' �삎�떇�쑝濡� �룷留�
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String formattedDateTime = now.format(formatter);
        
        String link = "";
        
        // �궗�슜�옄 踰덊샇�� �쁽�옱 �궇吏� 諛� �떆媛꾩쓣 寃고빀�븯�뿬 留곹겕 �깮�꽦
        if (menuType.equals("item")) {
        	link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		//湲곗��씠 �릺�뒗 硫붾돱�쓽 理쒕� menu_order 李얘린
		int max_order;
		
		if (selectedType.equals("root")) {
			
			max_order = dao.getMaxOrderOfnoParents();
			max_order++;
			
			//遺�紐⑥븘�씠�뀥�씠 �뾾�뒗 理쒖긽�쐞 寃쎌슦//
			if (menuType.equals("item")) {
				//理쒖긽�쐞�뿉 �븘�씠�뀥 異붽��떆
				System.out.println("理쒖긽�쐞 �븘�씠�뀥�쓣 異붽��빀�땲�떎.");
				dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//理쒖긽�쐞�뿉 �뤃�뜑 異붽��떆 (留곹겕瑜� null 濡� �꽔�쓣 �삁�젙�엫)
				System.out.println("理쒖긽�쐞 �뤃�뜑瑜� 異붽��빀�땲�떎.");
				dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno);
			}
			
		} else {

			//遺�紐④� 議댁옱�븯�뒗 寃쎌슦//
			if (selectedType.equals("item")) {
				
				int selectedIdParent = dao.getParentid(selectedId);
				//integer 瑜� �뒪�듃留곸쑝濡� 蹂��솚
				String parentId =  String.valueOf(selectedIdParent); 
				max_order = dao.getMaxOrderOfFather(parentId);
				max_order++;
				
				System.out.println("以묎컙 �븘�씠�뀥(�뤃�뜑)�쓣 異붽��빀�땲�떎. - 異붽��럞�뒪 誘몄깮�꽦");
				//dao.insertMenuHaveParentsItem(#湲곗〈遺�紐⑥쓽id, #���씠��, #怨듭쑀���씠��, #留곹겕, #硫붾돱���엯, #�쑀���꽆踰�)
				dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//�뤃�뜑異붽�
				
				//遺�紐④� 議댁옱�븯�뒗�뜲, depth媛� 4�씤寃쎌슦 由ъ젥�씠 �븘�슂. (0�씠 泥ル쾲�옱�엫, 利� 5�럞�뒪源뚯� 蹂댁뿬以� �닔 �엳�쓬)
				int selectedDepthInt = Integer.parseInt(selectedDepth); 
				if (selectedDepthInt >= 4 ) {
					
		        session.setAttribute("errorMessage", "�뤃�뜑 諛� �븘�씠�뀥�쓣 異붽��븷 �닔 �뾾�뒿�땲�떎. 理쒕� �뿀�슜 �럞�뒪瑜� 珥덇낵�븯���뒿�땲�떎.");
		        
		        return "redirect:menuSetting";
					
				}
				
				//�삎�젣�쓽 �닚�꽌瑜� �븣�븘�빞�븿.
				max_order = dao.getMaxOrderOfFather(selectedId);
				max_order++;
				
				System.out.println("以묎컙 �븘�씠�뀥(�뤃�뜑)瑜� 異붽��빀�땲�떎. - 異붽��럞�뒪 �깮�꽦");
				dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno);
			}
		}
		

		return "redirect:menuSetting";
	}
	

	//�궘�젣泥섎━
	@RequestMapping("/deleteMenu")
	public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
		
		//�꽭�뀡泥댄겕
        String userno = (String) session.getAttribute("userno");
		
		
		//湲곗��뜲�씠�꽣
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		System.out.println("�궘�젣���긽 id: " + selectedId);
		System.out.println("�궘�젣���긽 type: " + selectedType);
		System.out.println("�궘�젣���긽 depth: " + selectedDepth);
		
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		//�궘�젣�븯�젮�뒗 ���긽�씠 �븘�씠�뀥�씤 寃쎌슦
		if (selectedType.equals("item")) {
			dao.deleteItem(selectedId, userno);
		} else {
			
			//�궘�젣�븯�젮�뒗 ���긽�씠 �뤃�뜑�씤 寃쎌슦
			
			Set<Integer> allIdsToDelete = new HashSet<Integer>();
	        collectAllIdsToDelete(Integer.parseInt(selectedId), allIdsToDelete, dao);			
			
	        //�쁽�옱源뚯��뒗 �궘�젣�븷 紐⑤뱺 �뜲�씠�꽣瑜� �옒 媛��졇�삤吏�留�,
	        //FK 議곌굔�쓣 留뚯”�븯硫� �궘�젣�븯�젮硫� depth 瑜� 遺꾧린�븯�뿬 �궘�젣泥섎━吏꾪뻾�빐�빞�븿.
	        Map<Integer, Integer> depthMap = new HashMap<Integer, Integer>();
	        for (Integer id : allIdsToDelete) {
	        	
	            int depth = 0;
	            Integer parentId = dao.getParentid(String.valueOf(id));
	            
	            while (parentId != null) {
	                Integer parentIdNext = dao.getParentid(String.valueOf(parentId));
	                if (parentIdNext == null) break;
	                depth++;
	                parentId = parentIdNext;
	            }
	            depthMap.put(id, depth);
	            System.out.println("�궘�젣���긽)) 硫붾돱id : " + id + " depth : " + depth);
	        }
	        
	        //depth 蹂꾨줈 遺꾨쪟�븳 �뜲�씠�꽣瑜� depth 湲곗� �뿭�닚�쑝濡� �젙�젹�븯�뿬 �닚李⑥쟻�쑝濡� �궘�젣泥섎━�븿.
	        // depthMap�쓣 媛믪뿉 �뵲�씪 �궡由쇱감�닚 �젙�젹
	        List<Map.Entry<Integer, Integer>> list = new ArrayList<Map.Entry<Integer, Integer>>(depthMap.entrySet());

	        // Comparator瑜� �궗�슜�븳 �젙�젹
	        Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
	            public int compare(Map.Entry<Integer, Integer> o1, Map.Entry<Integer, Integer> o2) {
	                return o2.getValue().compareTo(o1.getValue());
	            }
	        });
	        
	        //�궘�젣泥섎━
	        for (Map.Entry<Integer, Integer> entry : list) {
	            // �빐�떦 ID瑜� �뜲�씠�꽣踰좎씠�뒪�뿉�꽌 �궘�젣
	            dao.deleteItem(entry.getKey().toString(), userno);
	            System.out.println("Deleted ID: " + entry.getKey() + " with depth: " + entry.getValue());
	        }
	        
	        dao.deleteItem(selectedId, userno);
			
		}
		
		
		return "redirect:menuSetting";
	}
	
	
	@RequestMapping(value = "/editBoardDetails", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> editModalMake(@RequestParam("id") int id) {

	    try {
	        WikiDao dao = sqlSession.getMapper(WikiDao.class);
	        MenuDTO dto = dao.getMenuDetail(id);
	        
	        if (dto.getTitleShare() == null) {
	        	dto.setTitleShare("");
	        }
	        
	        System.out.println("id: " + dto.getId());
	        System.out.println("title: " + dto.getTitle());
	        System.out.println("titleShare: " + dto.getTitleShare());
	        System.out.println("type: " + dto.getMenuType());

	        if (dto.getTitleShare() == null) {
	        	dto.setTitleShare("");
	        }
	        
	        if (dto != null) {
	            ObjectMapper mapper = new ObjectMapper();
	            String jsonResult = mapper.writeValueAsString(dto); // 媛앹껜瑜� JSON 臾몄옄�뿴濡� 蹂��솚
	            
	            return new ResponseEntity<String>(jsonResult, HttpStatus.OK);
	        } else {	
	        	
	            return new ResponseEntity<String>("{}", HttpStatus.NOT_FOUND);
	            
	        }
	    } catch (Exception e) {
	        return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@RequestMapping("/editAction")
	public String editAction(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String titleShare = request.getParameter("titleShare");
		
		System.out.println("======== �닔�젙 �븸�뀡 而⑦듃濡ㅻ윭 吏꾩엯 ========");
		System.out.println(id);
		System.out.println(title);
		System.out.println(titleShare);
		System.out.println("======== �닔�젙 �븸�뀡 而⑦듃濡ㅻ윭 吏꾩엯 ========");
		
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		if (titleShare.length() == 0) {
			System.out.println("怨듭쑀�슜 �젣紐⑹� �뾾�쓬. null 濡� 泥섎━�빀�땲�떎.");
			dao.changeMenuNoShare(title, id);
		} else {
			System.out.println("怨듭쑀�슜 �젣紐� 議댁옱�븿.");
			dao.changeMenuYesShare(title,titleShare, id);
		}
		
		return "redirect:menuSetting";
	}


	
	private void collectAllIdsToDelete(Integer parentId, Set<Integer> allIdsToDelete, WikiDao dao) {
	    List<Integer> childIds = dao.getChildIds(parentId);
	    for (Integer childId : childIds) {
	        allIdsToDelete.add(childId);
	        collectAllIdsToDelete(childId, allIdsToDelete, dao);
	    }
	}	
	
    public void setMenuDepth(List<MenuDTO> menus) {
        // 硫붾돱 ID�� 硫붾돱 媛앹껜瑜� 留ㅽ븨�븯�뒗 Map�쓣 �깮�꽦
        Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
        for (MenuDTO menu : menus) {
            menuMap.put(menu.getId(), menu);
        }

        // 媛� 硫붾돱 �빆紐⑹쓽 depth 怨꾩궛
        for (MenuDTO menu : menus) {
            int depth = 0;
            Integer parentId = menu.getParentId();
            while (parentId != null) {
                MenuDTO parent = menuMap.get(parentId);
                if (parent == null) break;
                depth++;
                parentId = parent.getParentId();
            }
            menu.setDepth(depth);
        }
    }

    public List<MenuDTO> organizeMenuHierarchy(List<MenuDTO> menus) {
        Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
        for (MenuDTO menu : menus) {
            menuMap.put(menu.getId(), menu);
            menu.setChildren(new ArrayList<MenuDTO>());
        }

        for (MenuDTO menu : menus) {
            if (menu.getParentId() != null) {
                MenuDTO parent = menuMap.get(menu.getParentId());
                if (parent != null) {
                    parent.getChildren().add(menu);
                }
            }
        }

        List<MenuDTO> topLevelMenus = new ArrayList<MenuDTO>();
        for (MenuDTO menu : menus) {
            if (menu.getParentId() == null) {
                topLevelMenus.add(menu);
            }
        }

        // 濡쒓퉭�쓣 異붽��븯�뿬 媛� 理쒖긽�쐞 硫붾돱�� �빐�떦 �븯�쐞 硫붾돱�뱾�쓣 異쒕젰
//        for (MenuDTO menu : topLevelMenus) {
//            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
//            printChildren(menu, "  ");  // �옱洹��쟻�쑝濡� �븯�쐞 硫붾돱�뱾�쓣 異쒕젰
//        }

        return topLevelMenus;
    }

    private void printChildren(MenuDTO menu, String indent) {
        for (MenuDTO child : menu.getChildren()) {
            System.out.println(indent + "Child Menu: " + child.getTitle() + " (ID: " + child.getId() + ")");
            if (!child.getChildren().isEmpty()) {
                printChildren(child, indent + "  ");
            }
        }
    }
    
    
    
    
    @RequestMapping(value = "/editor", method = RequestMethod.GET)
    public String getEditorPage() {
        return "./wiki/editor"; // src/main/webapp/WEB-INF/views/editor.jsp �뙆�씪�쓣 諛섑솚
    }

    @RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
    public ResponseEntity<String> saveEditorData(@RequestBody Map<String, Object> editorData) {
        // editorData瑜� 泥섎━�븯怨� ���옣�빀�땲�떎.
        System.out.println("Received data: " + editorData);
        // �뜲�씠�꽣踰좎씠�뒪�뿉 ���옣�븯�뒗 濡쒖쭅�쓣 異붽��빀�땲�떎.

        return new ResponseEntity<String>("Data saved successfully", HttpStatus.OK);
    }
    
    
}
