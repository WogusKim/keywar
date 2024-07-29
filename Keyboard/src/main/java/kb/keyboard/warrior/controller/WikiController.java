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
        
        //占쎄쉭占쎈�∽㎗�똾寃�
        String userno = (String) session.getAttribute("userno");
        
        //獄쏆룇占쏙옙�쑓占쎌뵠占쎄숲
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        //占쎌읈占쎈꽊獄쏆룇占쏙옙�쑓占쎌뵠占쎄숲
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

        
        // 占쎌겱占쎌삺 占쎄텊筌욎뮇占� 占쎈뻻揶쏄쑴�뱽 'yyyyMMdd_HHmmss' 占쎌굨占쎄묶嚥∽옙 占쎈７筌랃옙
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String formattedDateTime = now.format(formatter);
        
        String link = "";
        
        // 占쎄텢占쎌뒠占쎌쁽 甕곕뜇�깈占쏙옙 占쎌겱占쎌삺 占쎄텊筌욑옙 獄쏉옙 占쎈뻻揶쏄쑴�뱽 占쎈��댚占� 筌띻낱寃� 占쎄문占쎄쉐
        if (menuType.equals("item")) {
            link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //獄쏆룇占쏙옙�쑓占쎌뵠占쎄숲揶쏉옙 占쎌뿳占쎈뮉 筌롫뗀�뤀占쎌벥 筌ㅼ뮆占� menu_order 占쎌넇占쎌뵥
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
            
            //�겫占쏙쭗�뫀�걗占쎈굡揶쏉옙 占쎈씨占쎈뮉 筌ㅼ뮇湲쏙옙�맄 野껋럩�뒭//
            if (menuType.equals("item")) {
                //筌ㅼ뮇湲쏙옙�맄占쎈퓠 占쎈툡占쎌뵠占쎈�� �빊遺쏙옙占쎈뻻
                System.out.println("筌ㅼ뮇湲쏙옙�맄 占쎈툡占쎌뵠占쎈�ο옙�뱽 �빊遺쏙옙占쎈�占쎈빍占쎈뼄.");
                dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno, isOpenInt);
            } else {
                //筌ㅼ뮇湲쏙옙�맄占쎈퓠 占쎈쨨占쎈쐭 �빊遺쏙옙占쎈뻻 (筌띻낱寃뺟몴占� null 嚥∽옙 占쎄퐫占쎌뱽 占쎌굙占쎌젟)
                System.out.println("筌ㅼ뮇湲쏙옙�맄 占쎈쨨占쎈쐭�몴占� �빊遺쏙옙占쎈�占쎈빍占쎈뼄.");
                dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno, isOpenInt);
            }
            
        } else {

            //�겫占쏙쭗�뫀�걗占쎈굡揶쏉옙 鈺곕똻�삺占쎈릭占쎈뮉 野껋럩�뒭//
            if (selectedType.equals("item")) {
                
                int selectedIdParent = dao.getParentid(selectedId);
                //integer �몴占� 占쎈뮞占쎈뱜筌띻낯�몵嚥∽옙 癰귨옙占쎌넎
                String parentId =  String.valueOf(selectedIdParent); 
                max_order = dao.getMaxOrderOfFather(parentId);
                max_order++;
                
                System.out.println("占쎈릭占쎌맄 占쎈툡占쎌뵠占쎈��(占쎈쨨占쎈쐭)占쎌뱽 �빊遺쏙옙占쎈�占쎈빍占쎈뼄. - �빊遺쏙옙占쎄깻占쎌삋占쎈뮞 占쎄문占쎄쉐");
                //dao.insertMenuHaveParentsItem(#獄쏆룇占썽겫占쏙쭗�뫁�벥id, #占쎌젫筌륅옙, #�⑤벊��占쎌젫筌륅옙, #筌띻낱寃�, #筌롫뗀�뤀占쏙옙占쎌뿯, #占쎄텢占쎌뒠占쎌쁽甕곕뜇�깈)
                dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno, isOpenInt);
            } else {
                //占쎈쨨占쎈쐭�빊遺쏙옙
                
                //�겫占쏙쭗�뫀�걗占쎈굡揶쏉옙 鈺곕똻�삺占쎈릭占쎈뮉占쎈쑓, depth揶쏉옙 4占쎌뵥野껋럩�뒭 筌ㅼ뮇伊뚳옙�뵠占쎈뼄. (0占쎌뵠 筌ｃ꺂苡뀐쭪占�, 筌ㅼ뮄�� 5占쎄깻占쎌삋占쎈뮞繹먮슣占� 癰귣똻肉т빳占� 占쎈땾 占쎌뿳占쎌벉)
                int selectedDepthInt = Integer.parseInt(selectedDepth); 
                if (selectedDepthInt >= 4 ) {
                    
                session.setAttribute("errorMessage", "占쎈쨨占쎈쐭 獄쏉옙 占쎈툡占쎌뵠占쎈�ο옙�뱽 �빊遺쏙옙占쎈막 占쎈땾 占쎈씨占쎈뮸占쎈빍占쎈뼄. 筌ㅼ뮇湲쏙옙�맄 占쎈쨨占쎈쐭�몴占� 占쎄문占쎄쉐占쎈릭占쎄쉭占쎌뒄.");
                
                return "redirect:menuSetting";
                    
                }
                
                //占쎌굨占쎌젫占쎌벥 占쎈떄占쎄퐣�몴占� �걡癒�鍮욑옙釉�.
                max_order = dao.getMaxOrderOfFather(selectedId);
                max_order++;
                
                System.out.println("占쎈릭占쎌맄 占쎈툡占쎌뵠占쎈��(占쎈쨨占쎈쐭)占쎌뱽 �빊遺쏙옙占쎈�占쎈빍占쎈뼄. - �빊遺쏙옙占쎄깻占쎌삋占쎈뮞 占쎄문占쎄쉐");
                dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno, isOpenInt);
            }
        }


        return "redirect:menuSetting";
    }
    


    @RequestMapping("/deleteMenu")
    public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
        
        //占쎄쉭占쎈�∽㎗�똾寃�
        String userno = (String) session.getAttribute("userno");
        
        
        //獄쏆룇占쏙옙�쑓占쎌뵠占쎄숲
        String selectedId = request.getParameter("id");
        String selectedType = request.getParameter("type");
        String selectedDepth = request.getParameter("depth");
        
        System.out.println("占쎄텣占쎌젫占쏙옙占쎄맒 id: " + selectedId);
        System.out.println("占쎄텣占쎌젫占쏙옙占쎄맒 type: " + selectedType);
        System.out.println("占쎄텣占쎌젫占쏙옙占쎄맒 depth: " + selectedDepth);
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        //占쎄텣占쎌젫占쎈릭占쎌젻占쎈뮉 占쏙옙占쎄맒占쎌뵠 占쎈툡占쎌뵠占쎈�ο옙�뵥 野껋럩�뒭
        if (selectedType.equals("item")) {
            dao.deleteItem(selectedId, userno);
        } else {
            
            //占쎄텣占쎌젫占쎈릭占쎌젻占쎈뮉 占쏙옙占쎄맒占쎌뵠 占쎈쨨占쎈쐭占쎌뵥 野껋럩�뒭
            
            Set<Integer> allIdsToDelete = new HashSet<Integer>();
            collectAllIdsToDelete(Integer.parseInt(selectedId), allIdsToDelete, dao);            
            
            //占쎌겱占쎌삺嚥≪뮆�뮉 占쎄텣占쎌젫占쎈막 筌뤴뫀諭� 占쎈쑓占쎌뵠占쎄숲�몴占� 占쎈뼄 揶쏉옙占쎌죬占쎌궎筌욑옙筌랃옙,
            //FK 鈺곌퀗援뷂옙�뱽 筌띿쉸�뀤筌롳옙 占쎄텣占쎌젫占쎈릭占쎌젻筌롳옙 depth �몴占� 占쎌젟占쎌졊占쎈릭占쎈연 占쎄텣占쎌젫筌ｌ꼶�봺筌욊쑵六억옙鍮먲옙鍮욑옙釉�.
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
                System.out.println("占쎄텣占쎌젫占쏙옙占쎄맒)) 筌롫뗀�뤀id : " + id + " depth : " + depth);
            }
            
            //depth 癰귢쑬以� 占쎄돌占쎈떊筌욑옙 占쎈쑓占쎌뵠占쎄숲�몴占� depth 疫꿸퀣占� 占쎄땀�뵳�눘媛먲옙�떄占쎌몵嚥∽옙 占쎌젟占쎌졊占쎈퉸 占쎈떄筌△뫁�읅占쎌몵嚥∽옙 占쎄텣占쎌젫筌ｌ꼶�봺占쎈맙.
            // depthMap占쎌뱽 揶쏅�る퓠 占쎈뎡占쎌뵬 占쎄땀�뵳�눘媛먲옙�떄 占쎌젟占쎌졊
            List<Map.Entry<Integer, Integer>> list = new ArrayList<Map.Entry<Integer, Integer>>(depthMap.entrySet());

            // Comparator�몴占� 占쎄텢占쎌뒠占쎈립 占쎌젟占쎌졊
            Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
                public int compare(Map.Entry<Integer, Integer> o1, Map.Entry<Integer, Integer> o2) {
                    return o2.getValue().compareTo(o1.getValue());
                }
            });
            
            //占쎄텣占쎌젫筌ｌ꼶�봺
            for (Map.Entry<Integer, Integer> entry : list) {
                // 占쎈퉸占쎈뼣 ID�몴占� 占쎈쑓占쎌뵠占쎄숲甕곗쥙�뵠占쎈뮞占쎈퓠占쎄퐣 占쎄텣占쎌젫
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
                String jsonResult = mapper.writeValueAsString(dto); // 揶쏆빘猿쒐몴占� JSON �눧紐꾩쁽占쎈였嚥∽옙 癰귨옙占쎌넎
                
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
        
        System.out.println("======== 占쎈땾占쎌젟 占쎈만占쎈�� �뚢뫂�뱜嚥▲끇�쑎 筌욊쑴�뿯 ========");
        System.out.println(id);
        System.out.println(title);
        System.out.println(titleShare);
        System.out.println("======== 占쎈땾占쎌젟 占쎈만占쎈�� �뚢뫂�뱜嚥▲끇�쑎 筌욊쑴�뿯 ========");
        
        WikiDao dao = sqlSession.getMapper(WikiDao.class);
        
        if (titleShare.length() == 0) {
            System.out.println("�⑤벊��占쎌뒠 占쎌젫筌뤴뫗�뵠 占쎈씨占쎌벉. null 嚥∽옙 筌ｌ꼶�봺占쎈�占쎈빍占쎈뼄.");
            dao.changeMenuNoShare(title, id);
        } else {
            System.out.println("�⑤벊��占쎌뒠 占쎌젫筌륅옙 鈺곕똻�삺占쎈맙.");
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
        // 筌롫뗀�뤀 ID占쏙옙 筌롫뗀�뤀 揶쏆빘猿쒐몴占� 筌띲끋釉⑨옙釉�占쎈뮉 Map占쎌뱽 占쎄문占쎄쉐
        Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
        for (MenuDTO menu : menus) {
            menuMap.put(menu.getId(), menu);
        }

        // 揶쏉옙 筌롫뗀�뤀 占쎈퉮筌뤴뫗�벥 depth �④쑴沅�
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

        // 嚥≪뮄�돪占쎌뱽 �빊遺쏙옙占쎈퉸 揶쏉옙 筌ㅼ뮇湲쏙옙�맄 筌롫뗀�뤀占쏙옙 占쎈퉸占쎈뼣 占쎈릭占쎌맄 筌롫뗀�뤀占쎈굶占쎌뱽 �빊�뮆�젾
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
    
}
