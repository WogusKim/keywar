package kb.keyboard.warrior.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kb.keyboard.warrior.dao.LoginDao;
import kb.keyboard.warrior.dao.ScheduleDao;
import kb.keyboard.warrior.dao.WikiDao;
import kb.keyboard.warrior.dto.MenuDTO;

@Controller
public class WikiController {

	@Autowired
	public SqlSession sqlSession;
	
	@RequestMapping("/menuSetting")
	public String menuSetting(Model model) {
		//메뉴설정페이지 이동
		return "wiki/menuSetting";
	}
	
	@RequestMapping("/addMenu")
	public String menuAdd(Model model, HttpServletRequest request, HttpSession session) {
		
		//세션체크
        String userno = (String) session.getAttribute("userno");
		
		//기준데이터
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		//신규삽입데이터
		String menuType = request.getParameter("menuType");
		String title = request.getParameter("title");
		String sharedTitle = request.getParameter("sharedTitle");
		
		System.out.println("기준 id: " + selectedId);
		System.out.println("기준 type: " + selectedType);
		System.out.println("기준 depth: " + selectedDepth);
		
		System.out.println("추가할 Type: " + menuType);
		System.out.println("추가할 Title: " + title);
		System.out.println("추가할 공유title: " + sharedTitle);
		
        // 현재 날짜와 시간을 'yyyyMMdd_HHmmss' 형식으로 포맷
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String formattedDateTime = now.format(formatter);
        
        String link = "";
        
        // 사용자 번호와 현재 날짜 및 시간을 결합하여 링크 생성
        if (menuType.equals("item")) {
        	link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		//기준이 되는 메뉴의 최대 menu_order 찾기
		int max_order;
		
		if (selectedType.equals("root")) {
			
			max_order = dao.getMaxOrderOfnoParents();
			max_order++;
			
			//부모아이템이 없는 최상위 경우//
			if (menuType.equals("item")) {
				//최상위에 아이템 추가시
				System.out.println("최상위 아이템을 추가합니다.");
				dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//최상위에 폴더 추가시 (링크를 null 로 넣을 예정임)
				System.out.println("최상위 폴더를 추가합니다.");
				dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno);
			}
			
		} else {

			//부모가 존재하는 경우//
			if (selectedType.equals("item")) {
				
				int selectedIdParent = dao.getParentid(selectedId);
				//integer 를 스트링으로 변환
				String parentId =  String.valueOf(selectedIdParent); 
				max_order = dao.getMaxOrderOfFather(parentId);
				max_order++;
				
				//아이템추가
				System.out.println("중간 아이템을 추가합니다.");
				//dao.insertMenuHaveParentsItem(#기존부모의id, #타이틀, #공유타이틀, #링크, #메뉴타입, #유저넘버)
				dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//폴더추가
				
				max_order = dao.getMaxOrderOfFather(selectedId);
				max_order++;
				
				System.out.println("중간 폴더를 추가합니다.");
				dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno);
			}
		}
		
        // 메뉴데이터를 세션과 모델에 전부 담아줌.
        List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
        LoginDao loginDao = sqlSession.getMapper(LoginDao.class);

        menus = loginDao.getMenus(userno);
        setMenuDepth(menus);
        List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);
        session.setAttribute("menus", topLevelMenus);
        model.addAttribute("menus", topLevelMenus);

		return "redirect:menuSetting";
	}
	

	//삭제처리
	@RequestMapping("/deleteMenu")
	public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
		
		//기준데이터
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		System.out.println("기준 id: " + selectedId);
		System.out.println("기준 type: " + selectedType);
		System.out.println("기준 depth: " + selectedDepth);
		
		//삭제하려는 대상이 아이템인 경우
		
		//삭제하려는 대상이 폴더인 경우
		
		
		
		
		return "redirect:menuSetting";
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

        // 로깅을 추가하여 각 최상위 메뉴와 해당 하위 메뉴들을 출력
        for (MenuDTO menu : topLevelMenus) {
            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
            printChildren(menu, "  ");  // 재귀적으로 하위 메뉴들을 출력
        }

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
        // editorData를 처리하고 저장합니다.
        System.out.println("Received data: " + editorData);
        // 데이터베이스에 저장하는 로직을 추가합니다.

        return new ResponseEntity<>("Data saved successfully", HttpStatus.OK);
    }
    
    
}
