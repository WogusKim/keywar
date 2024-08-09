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
        
        // 세션체크
        String userno = (String) session.getAttribute("userno");
        
        // 선택된 정보들
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        // 추가할 정보들
        String menuType = request.getParameter("menuType");
        String title = request.getParameter("title");
        String sharedTitle = request.getParameter("sharedTitle");
        String isOpen = request.getParameter("public");
        
        System.out.println("받은 id: " + selectedId);
        System.out.println("받은 type: " + selectedType);
        System.out.println("받은 depth: " + selectedDepth);
      
        System.out.println("추가할 Type: " + menuType);
        System.out.println("추가할 Title: " + title);
        System.out.println("추가할 공유title: " + sharedTitle);
        System.out.println("공유여부: " + isOpen);

        
        // 현재 날짜와 시간을 'yyyyMMdd_HHmmss' 형식으로 포맷
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String formattedDateTime = now.format(formatter);
        
        String link = "";
        
        // 타입이 아이템일 경우 현재 날짜 시간 링크 생성
        if (menuType.equals("item")) {
            link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //선택된 정보의 최대 menu_order 찾기
        int max_order;
        int isOpenInt;
        
        if (isOpen.equals("no")) {
            isOpenInt = 0;
        } else {
            isOpenInt = 1;
        }
        
        if (selectedType.equals("root")) {
            
            max_order = dao.getMaxOrderOfnoParents();
            max_order++;
            
            // 부모가 없는 경우 추가//
            if (menuType.equals("item")) {
                //루트에 아이템 추가
                System.out.println("루트 아이템을 추가합니다.");
                dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno, isOpenInt);
            } else {
                //루트에 폴더 추가 (링크는 null 으로 설정)
                System.out.println("루트 폴더를 추가합니다.");
                dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno, isOpenInt);
            }
            
        } else {

            //부모가 있는 경우//
            if (selectedType.equals("item")) {
                
                int selectedIdParent = dao.getParentid(selectedId);
                //integer 를 문자열로 변환
                String parentId =  String.valueOf(selectedIdParent); 
                max_order = dao.getMaxOrderOfFather(parentId);
                max_order++;
                
                System.out.println("아이템을 추가합니다. - 아이템 부모 조회");
                //dao.insertMenuHaveParentsItem(#부모아이디, #타이틀, #공유타이틀, #링크, #메뉴타입, #최대순번, #유저번호)
                dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno, isOpenInt);
            } else {
                //폴더추가
                
                //부모가 있는데, depth가 4이상이면 추가할 수 없다. (0이 루트, 따라서 5이상이면 추가 불가)
                int selectedDepthInt = Integer.parseInt(selectedDepth); 
                if (selectedDepthInt >= 4 ) {
                    
                session.setAttribute("errorMessage", "더 이상 하위폴더를 추가할 수 없습니다. 최대 깊이입니다.");
                
                return "redirect:menuSetting";
                    
                }
                
                //부모의 최대 순번을 찾아야 한다.
                max_order = dao.getMaxOrderOfFather(selectedId);
                max_order++;
                
                if(sharedTitle==null||sharedTitle=="")
                    sharedTitle = title;
                
                System.out.println("폴더를 추가합니다. - 폴더 부모 조회");
                dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno, isOpenInt);
            }
        }


        return "redirect:menuSetting";
    }
    
    @RequestMapping("/deleteMenu")
    public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
        
        // 세션체크
        String userno = (String) session.getAttribute("userno");
        
        // 선택된 정보들
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        System.out.println("삭제할 id: " + selectedId);
        System.out.println("삭제할 type: " + selectedType);
        System.out.println("삭제할 depth: " + selectedDepth);
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //삭제하려는 아이템만 삭제하는 경우
        if (selectedType.equals("item")) {
            dao.deleteItem(selectedId, userno);
        } else {
            
            //삭제하려는 폴더와 그 자식들도 삭제
            
            Set<Integer> allIdsToDelete = new HashSet<Integer>();
            collectAllIdsToDelete(Integer.parseInt(selectedId), allIdsToDelete, dao);            
            
            //최상위 폴더부터 삭제해야 하므로,
            //FK 오류를 피하기 위해 삭제하려는 depth 를 확인해야 한다.
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
                System.out.println("삭제할)) 메뉴id : " + id + " depth : " + depth);
            }
            
            //depth 순으로 정렬된 자식들을 depth 순서대로 삭제한다.
            // depthMap의 데이터를 순서대로 정렬
            List<Map.Entry<Integer, Integer>> list = new ArrayList<Map.Entry<Integer, Integer>>(depthMap.entrySet());

            // Comparator를 사용한 정렬
            Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
                public int compare(Map.Entry<Integer, Integer> o1, Map.Entry<Integer, Integer> o2) {
                    return o2.getValue().compareTo(o1.getValue());
                }
            });
            
            //삭제처리
            for (Map.Entry<Integer, Integer> entry : list) {
                // 해당 ID를 데이터베이스에서 삭제
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
                String jsonResult = mapper.writeValueAsString(dto); // 객체를 JSON 문자열로 변환
                
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
        String isOpen = request.getParameter("isOpen");
        
        System.out.println("======== 수정 입력 ========");
        System.out.println(id);
        System.out.println(title);
        System.out.println(titleShare);
        System.out.println("공유여부 : " + isOpen);
        System.out.println("======== 수정 입력 ========");
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //공유처리
        if (titleShare.length() == 0) {
            System.out.println("공유할 제목이 없음. null 로 처리합니다.");
            dao.changeMenuNoShare(title, id);
        } else {
            System.out.println("공유할 제목 있음.");
            dao.changeMenuYesShare(title,titleShare, id);
        }
        
        //공유여부 상태처리
        dao.changeIsOpen(isOpen, id);

        
        return "redirect:menuSetting";
    }
    
    //빠른메뉴추가
    @RequestMapping("/fastAddItem")
    public String fastAddItem(HttpServletRequest request, HttpSession session, Model model) {
    	
    	String userno = (String) session.getAttribute("userno");
    	
        // 선택된 정보들
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        // 추가할 정보들
        String title = request.getParameter("title");
        String sharedTitle = request.getParameter("sharedTitle");
        String isOpen = request.getParameter("public");
        
        int isOpenInt = 0;
        
        if (isOpen.equals("no")) {
            isOpenInt = 0;
        } else {
            isOpenInt = 1;
        }
        
        
        //이따 삭제하세요~
        System.out.println("==================빠른메뉴추가 테스트중==================");
        System.out.println("선택한 폴더 id: " + selectedId);
        System.out.println("폴더타입 재확인: " + selectedType);
        System.out.println("depth 재확인: " + selectedDepth);
        
        System.out.println("타이틀: " + title);
        System.out.println("sharedTitle: " + sharedTitle);
        System.out.println("공개여부 " + isOpen);
        System.out.println("==================빠른메뉴추가 테스트중==================");
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);

   	 	//부모의 최대 순번을 찾아야 한다.
        int max_order = dao.getMaxOrderOfFather(selectedId);
        max_order++;
       
        if(sharedTitle==null||sharedTitle=="") {
        	sharedTitle = title;
        }
       
	    System.out.println("폴더를 추가합니다. - 폴더 부모 조회");
	    dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, "item", max_order, userno, isOpenInt);
	    
	    int newId = dao.getNewCopyId(userno); //방금추가한 메뉴 ID
        
		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
		
		//메뉴데이터가 변경되므로 세션에 다시 담기
		List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
		menus = loginDao.getMenus(userno);
		setMenuDepth(menus);
		List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);

		session.setAttribute("menus", topLevelMenus); // �꽭�뀡�뿉 硫붾돱 �뜲�씠�꽣 ���옣

		model.addAttribute("menus", topLevelMenus);
    	
    	return "redirect:wikiDetail?id="+newId;
    }
    
    
    //메뉴 훔쳐오기
    @RequestMapping("/copyNote")
    public String copyMenu(HttpServletRequest request, HttpSession session, Model model, @RequestParam("copyId") int copyId) {
    	//로그인한 id
    	String userno = (String) session.getAttribute("userno");
    	
        // 복사대상
    	System.out.println("복사대상 id : " + copyId);
        
        // 추가할 정보들
        String title = request.getParameter("title");
        String sharedTitle = request.getParameter("sharedTitle");
        System.out.println("새로 붙여줄 이름1 : " + title);
        System.out.println("새로 붙여줄 이름2 : " + sharedTitle);
        
        // 추가할 부모 폴더
        String selectedId = request.getParameter("id");
        System.out.println("복사할 위치 (부모폴더) : " + selectedId);
        
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        int max_order = dao.getMaxOrderOfFather(selectedId);
        max_order++;
        
        //dao.insertMenuHaveParentsItem(#부모아이디, #타이틀, #공유타이틀, #링크, #메뉴타입, #최대순번, #유저번호)
        dao.insertMenuHaveParentsItem(selectedId, title, sharedTitle, "", "item", max_order, userno, 1);
        
        int newId = dao.getNewCopyId(userno); //방금추가한 메뉴 ID
        
        String wikiData = dao.getData(copyId); //카피대상 데이터
        dao.insertWiki(newId, wikiData); //새 메뉴에 카피데이터 넣어주기
        
		LoginDao loginDao = sqlSession.getMapper(LoginDao.class);
		
		//메뉴데이터가 변경되므로 세션에 다시 담기
		List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
		menus = loginDao.getMenus(userno);
		setMenuDepth(menus);
		List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);

		session.setAttribute("menus", topLevelMenus); // �꽭�뀡�뿉 硫붾돱 �뜲�씠�꽣 ���옣

		model.addAttribute("menus", topLevelMenus);
        
    	
    	return "redirect:wikiDetail?id="+newId;
    }
    
    private void collectAllIdsToDelete(Integer parentId, Set<Integer> allIdsToDelete, WikiDao dao) {
        List<Integer> childIds = dao.getChildIds(parentId);
        for (Integer childId : childIds) {
            allIdsToDelete.add(childId);
            collectAllIdsToDelete(childId, allIdsToDelete, dao);
        }
    }    
    
    public void setMenuDepth(List<MenuDTO> menus) {
        // 메뉴 ID와 메뉴 객체를 매핑하는 Map을 생성
        Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
        for (MenuDTO menu : menus) {
            menuMap.put(menu.getId(), menu);
        }

        // 각 메뉴 항목의 depth 계산
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

        // 최상위 메뉴와 하위 메뉴를 출력하여 확인
//        for (MenuDTO menu : topLevelMenus) {
//            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
//            printChildren(menu, "  ");  // 하위 메뉴들을 출력하여 확인
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
    
}
