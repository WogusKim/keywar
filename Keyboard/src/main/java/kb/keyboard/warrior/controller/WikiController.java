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
		
        // 메뉴를 세션에서 가져오거나 없으면 새로 조회합니다.
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
		
        // 사용자 번호
        String userno = (String) session.getAttribute("userno");
		
        // 선택된 메뉴
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
        // 추가할 메뉴
		String menuType = request.getParameter("menuType");
		String title = request.getParameter("title");
		String sharedTitle = request.getParameter("sharedTitle");
		
//		System.out.println("선택한 id: " + selectedId);
//		System.out.println("선택한 type: " + selectedType);
//		System.out.println("선택한 depth: " + selectedDepth);
//		
//		System.out.println("추가할 Type: " + menuType);
//		System.out.println("추가할 Title: " + title);
//		System.out.println("추가할 공유title: " + sharedTitle);
		
        // 현재 날짜시간을 'yyyyMMdd_HHmmss' 형식으로 포맷
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String formattedDateTime = now.format(formatter);
        
        String link = "";
        
        // 메뉴 타입이 항목일 경우 고유한 링크 생성
        if (menuType.equals("item")) {
        	link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
        // 선택된 메뉴의 최대 menu_order 값
		int max_order;
		
		if (selectedType.equals("root")) {
			
			max_order = dao.getMaxOrderOfnoParents();
			max_order++;
			
            // 루트에 추가되는 경우
			if (menuType.equals("item")) {
                // 루트에 항목 추가
                System.out.println("루트 항목을 추가합니다.");
				dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno);
			} else {
                // 루트에 폴더 추가 (부모는 null 로 설정)
                System.out.println("루트 폴더를 추가합니다.");
				dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno);
			}
			
		} else {

            // 부모가 존재하는 경우
			if (selectedType.equals("item")) {
				
				int selectedIdParent = dao.getParentid(selectedId);
                // integer 를 문자열로 변환
				String parentId =  String.valueOf(selectedIdParent); 
				max_order = dao.getMaxOrderOfFather(parentId);
				max_order++;
				
				System.out.println("기존 항목(폴더)에 추가합니다. - 부모설정 추가");
				//dao.insertMenuHaveParentsItem(#메뉴아이디, #메뉴명, #상위메뉴명, #설명, #사용여부, #정렬순서)
				dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno);
			} else {
				// 폴더추가
                // 부모가 존재하는데, depth가 4이상이면 추가가 안됨. (0이 최상위, 총 5단계까지만 가능)
				int selectedDepthInt = Integer.parseInt(selectedDepth); 
				if (selectedDepthInt >= 4 ) {
					
					session.setAttribute("errorMessage", "폴더 더 이상 항목을 추가할 수 없습니다. 최대 깊이에 도달했습니다.");
		        
		        return "redirect:menuSetting";
					
				}
				
				// 정상적인 경우에 추가.
                max_order = dao.getMaxOrderOfFather(selectedId);
                max_order++;
                
                System.out.println("기존 항목(폴더)에 추가합니다. - 설정 추가");
				dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno);
			}
		}
		

		return "redirect:menuSetting";
	}
	

	//삭제처리
	@RequestMapping("/deleteMenu")
	public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
		
		//사용자 번호
        String userno = (String) session.getAttribute("userno");
		
		
		//선택된 메뉴
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		System.out.println("삭제대상  id: " + selectedId);
		System.out.println("삭제대상  type: " + selectedType);
		System.out.println("삭제대상  depth: " + selectedDepth);
		
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
        // 삭제하려는 대상이 항목인 경우
		if (selectedType.equals("item")) {
			dao.deleteItem(selectedId, userno);
		} else {
			
            // 삭제하려는 대상이 폴더인 경우
			
			Set<Integer> allIdsToDelete = new HashSet<Integer>();
	        collectAllIdsToDelete(Integer.parseInt(selectedId), allIdsToDelete, dao);			
			
	        // 실제로는 삭제할 메뉴 아이디를 모두 수집한 후,
            // FK 제약조건을 고려하여 삭제하려면 depth 를 고려하여 삭제처리해야 합니다.
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
	            System.out.println("삭제대상 )) 筌롫뗀�뤀id : " + id + " depth : " + depth);
	        }
	        
	        // depth 기준 내림차순 정렬한 아이디를 depth 선택한 열거로 정렬하여 역순으로 삭제합니다.
            // depthMap을 값에 따라 내림차순 정렬
	        List<Map.Entry<Integer, Integer>> list = new ArrayList<Map.Entry<Integer, Integer>>(depthMap.entrySet());

            // Comparator를 사용하여 정렬
	        Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
	            public int compare(Map.Entry<Integer, Integer> o1, Map.Entry<Integer, Integer> o2) {
	                return o2.getValue().compareTo(o1.getValue());
	            }
	        });
	        
	     // 정렬된 목록
	        for (Map.Entry<Integer, Integer> entry : list) {
	            // 메뉴 ID를 기준으로 정렬된 목록을 처리
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
	            String jsonResult = mapper.writeValueAsString(dto); // 데이터를 JSON 형식으로 변환
	            
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
		
		System.out.println("======== 수정 전의 데이터 출력 ========");
		System.out.println(id);
		System.out.println(title);
		System.out.println(titleShare);
		System.out.println("======== 수정 전의 데이터 출력 ========");

		WikiDao dao = sqlSession.getMapper(WikiDao.class);

		if (titleShare.length() == 0) {
		    System.out.println("상위메뉴 설정이 없음. null 로 처리합니다.");
		    dao.changeMenuNoShare(title, id);
		} else {
		    System.out.println("상위메뉴 설정 존재함.");
		    dao.changeMenuYesShare(title, titleShare, id);
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
	    // 메뉴 ID와 메뉴 데이터를 매핑하기 위해 Map을 생성
	    Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
	    for (MenuDTO menu : menus) {
	        menuMap.put(menu.getId(), menu);
	    }

	    // 각 메뉴 항목의 깊이를 계산
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

        // 嚥≪뮄�돪占쎌뱽 �빊遺쏙옙占쎈릭占쎈연 揶쏉옙 筌ㅼ뮇湲쏙옙�맄 筌롫뗀�뤀占쏙옙 占쎈퉸占쎈뼣 占쎈릭占쎌맄 筌롫뗀�뤀占쎈굶占쎌뱽 �빊�뮆�젾
//        for (MenuDTO menu : topLevelMenus) {
//            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
//            printChildren(menu, "  ");  // 占쎌삺域뱄옙占쎌읅占쎌몵嚥∽옙 占쎈릭占쎌맄 筌롫뗀�뤀占쎈굶占쎌뱽 �빊�뮆�젾
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
        return "./wiki/editor"; // src/main/webapp/WEB-INF/views/editor.jsp 파일을 반환
    }

    @RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
    public ResponseEntity<String> saveEditorData(@RequestBody Map<String, Object> editorData) {
        // editorData를 서버에서 받았음을 확인합니다.
        System.out.println("Received data: " + editorData);
        // 데이터를 데이터베이스에 저장하는 로직을 여기에 추가합니다.

        return new ResponseEntity<String>("Data saved successfully", HttpStatus.OK);
    }

    
    
}
