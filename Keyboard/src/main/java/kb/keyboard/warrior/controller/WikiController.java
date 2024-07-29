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
        
        // 받은 데이터
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        // 추가할 데이터
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
        
        // 사용자 번호와 현재 날짜 및 시간을 기반으로 링크 생성
        if (menuType.equals("item")) {
            link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //받은 데이터 중 최대 menu_order 찾기
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
            
            // 부모노드가 없는 최상위 경우//
            if (menuType.equals("item")) {
                //최상위에 아이템 추가
                System.out.println("최상위 아이템을 추가합니다.");
                dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno, isOpenInt);
            } else {
                //최상위에 폴더 추가 (링크를 null 로 설정할 예정)
                System.out.println("최상위 폴더를 추가합니다.");
                dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno, isOpenInt);
            }
            
        } else {

            //부모가 존재하는 경우//
            if (selectedType.equals("item")) {
                
                int selectedIdParent = dao.getParentid(selectedId);
                //integer 를 문자열로 변환
                String parentId =  String.valueOf(selectedIdParent); 
                max_order = dao.getMaxOrderOfFather(parentId);
                max_order++;
                
                System.out.println("하위 아이템(폴더)을 추가합니다. - 추가정보 생성");
                //dao.insertMenuHaveParentsItem(#부모노드의id, #타이틀, #공유타이틀, #링크, #메뉴타입, #유저번호)
                dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno, isOpenInt);
            } else {
                //폴더추가
                
                //부모가 존재하는데, depth가 4인경우 제한이 필요. (0이 최상위, 이후 5개까지 허용 가능)
                int selectedDepthInt = Integer.parseInt(selectedDepth); 
                if (selectedDepthInt >= 4 ) {
                    
                session.setAttribute("errorMessage", "폴더 및 아이템을 추가할 수 없습니다. 최대 사용 제한입니다.");
                
                return "redirect:menuSetting";
                    
                }
                
                //순서의 시작을 찾아야함.
                max_order = dao.getMaxOrderOfFather(selectedId);
                max_order++;
                
                System.out.println("하위 아이템(폴더)을 추가합니다. - 추가정보 생성");
                dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno, isOpenInt);
            }
        }


        return "redirect:menuSetting";
    }
    


    @RequestMapping("/deleteMenu")
    public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
        
        // 세션체크
        String userno = (String) session.getAttribute("userno");
        
        
        // 받은 데이터
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        System.out.println("삭제대상 id: " + selectedId);
        System.out.println("삭제대상 type: " + selectedType);
        System.out.println("삭제대상 depth: " + selectedDepth);
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //삭제하려는 대상이 아이템인 경우
        if (selectedType.equals("item")) {
            dao.deleteItem(selectedId, userno);
        } else {
            
            //삭제하려는 대상이 폴더인 경우
            
            Set<Integer> allIdsToDelete = new HashSet<Integer>();
            collectAllIdsToDelete(Integer.parseInt(selectedId), allIdsToDelete, dao);            
            
            //현재까지는 삭제할 모든 데이터를 잘 가져오지만,
            //FK 조건을 무시하면 삭제하려면 depth 를 파악하여 삭제진행해야함.
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
                System.out.println("삭제대상)) 메뉴id : " + id + " depth : " + depth);
            }
            
            //depth 별로 정렬된 데이터를 depth 순서 내림차순으로 정렬해준다.
            // depthMap을 값에 따라 내림차순 정렬
            List<Map.Entry<Integer, Integer>> list = new ArrayList<Map.Entry<Integer, Integer>>(depthMap.entrySet());

            // Comparator를 사용한 정렬
            Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
                public int compare(Map.Entry<Integer, Integer> o1, Map.Entry<Integer, Integer> o2) {
                    return o2.getValue().compareTo(o1.getValue());
                }
            });
            
            //삭제진행
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
        
        System.out.println("======== 수정 액션 입력 ========");
        System.out.println(id);
        System.out.println(title);
        System.out.println(titleShare);
        System.out.println("공개여부 : " + isOpen);
        System.out.println("======== 수정 액션 입력 ========");
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //제목처리
        if (titleShare.length() == 0) {
            System.out.println("공유용 제목이 없음. null 로 처리합니다.");
            dao.changeMenuNoShare(title, id);
        } else {
            System.out.println("공유용 제목 존재함.");
            dao.changeMenuYesShare(title,titleShare, id);
        }
        
        //공개여부 변경처리
        dao.changeIsOpen(isOpen, id);

        
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

        // 디버깅을 위해 각 최상위 메뉴와 해당 하위 메뉴들을 출력
//        for (MenuDTO menu : topLevelMenus) {
//            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
//            printChildren(menu, "  ");  // 재귀적으로 하위 메뉴들을 출력
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
