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
		
        // �޴������͸� ���ǰ� �𵨿� ���� �����.
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
		
		//����üũ
        String userno = (String) session.getAttribute("userno");
		
		//���ص�����
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		//�űԻ��Ե�����
		String menuType = request.getParameter("menuType");
		String title = request.getParameter("title");
		String sharedTitle = request.getParameter("sharedTitle");
		
//		System.out.println("���� id: " + selectedId);
//		System.out.println("���� type: " + selectedType);
//		System.out.println("���� depth: " + selectedDepth);
//		
//		System.out.println("�߰��� Type: " + menuType);
//		System.out.println("�߰��� Title: " + title);
//		System.out.println("�߰��� ����title: " + sharedTitle);
		
        // ���� ��¥�� �ð��� 'yyyyMMdd_HHmmss' �������� ����
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String formattedDateTime = now.format(formatter);
        
        String link = "";
        
        // ����� ��ȣ�� ���� ��¥ �� �ð��� �����Ͽ� ��ũ ����
        if (menuType.equals("item")) {
        	link = "/" + userno + "_" + formattedDateTime;
        } 
        System.out.println(link);
        
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		//������ �Ǵ� �޴��� �ִ� menu_order ã��
		int max_order;
		
		if (selectedType.equals("root")) {
			
			max_order = dao.getMaxOrderOfnoParents();
			max_order++;
			
			//�θ�������� ���� �ֻ��� ���//
			if (menuType.equals("item")) {
				//�ֻ����� ������ �߰���
				System.out.println("�ֻ��� �������� �߰��մϴ�.");
				dao.insertMenuNoParentsItem(title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//�ֻ����� ���� �߰��� (��ũ�� null �� ���� ������)
				System.out.println("�ֻ��� ������ �߰��մϴ�.");
				dao.insertMenuNoParentsFolder(title, sharedTitle, menuType, max_order, userno);
			}
			
		} else {

			//�θ� �����ϴ� ���//
			if (selectedType.equals("item")) {
				
				int selectedIdParent = dao.getParentid(selectedId);
				//integer �� ��Ʈ������ ��ȯ
				String parentId =  String.valueOf(selectedIdParent); 
				max_order = dao.getMaxOrderOfFather(parentId);
				max_order++;
				
				System.out.println("�߰� ������(����)�� �߰��մϴ�. - �߰����� �̻���");
				//dao.insertMenuHaveParentsItem(#�����θ���id, #Ÿ��Ʋ, #����Ÿ��Ʋ, #��ũ, #�޴�Ÿ��, #�����ѹ�)
				dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//�����߰�
				
				//�θ� �����ϴµ�, depth�� 4�ΰ�� ������ �ʿ�. (0�� ù������, �� 5�������� ������ �� ����)
				int selectedDepthInt = Integer.parseInt(selectedDepth); 
				if (selectedDepthInt >= 4 ) {
					
		        session.setAttribute("errorMessage", "���� �� �������� �߰��� �� �����ϴ�. �ִ� ��� ������ �ʰ��Ͽ����ϴ�.");
		        
		        return "redirect:menuSetting";
					
				}
				
				//������ ������ �˾ƾ���.
				max_order = dao.getMaxOrderOfFather(selectedId);
				max_order++;
				
				System.out.println("�߰� ������(����)�� �߰��մϴ�. - �߰����� ����");
				dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno);
			}
		}
		

		return "redirect:menuSetting";
	}
	

	//����ó��
	@RequestMapping("/deleteMenu")
	public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
		
		//����üũ
        String userno = (String) session.getAttribute("userno");
		
		
		//���ص�����
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		System.out.println("������� id: " + selectedId);
		System.out.println("������� type: " + selectedType);
		System.out.println("������� depth: " + selectedDepth);
		
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		//�����Ϸ��� ����� �������� ���
		if (selectedType.equals("item")) {
			dao.deleteItem(selectedId, userno);
		} else {
			
			//�����Ϸ��� ����� ������ ���
			
			Set<Integer> allIdsToDelete = new HashSet<Integer>();
	        collectAllIdsToDelete(Integer.parseInt(selectedId), allIdsToDelete, dao);			
			
	        //��������� ������ ��� �����͸� �� ����������,
	        //FK ������ �����ϸ� �����Ϸ��� depth �� �б��Ͽ� ����ó�������ؾ���.
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
	            System.out.println("�������)) �޴�id : " + id + " depth : " + depth);
	        }
	        
	        //depth ���� �з��� �����͸� depth ���� �������� �����Ͽ� ���������� ����ó����.
	        // depthMap�� ���� ���� �������� ����
	        List<Map.Entry<Integer, Integer>> list = new ArrayList<Map.Entry<Integer, Integer>>(depthMap.entrySet());

	        // Comparator�� ����� ����
	        Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
	            public int compare(Map.Entry<Integer, Integer> o1, Map.Entry<Integer, Integer> o2) {
	                return o2.getValue().compareTo(o1.getValue());
	            }
	        });
	        
	        //����ó��
	        for (Map.Entry<Integer, Integer> entry : list) {
	            // �ش� ID�� �����ͺ��̽����� ����
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
	            String jsonResult = mapper.writeValueAsString(dto); // ��ü�� JSON ���ڿ��� ��ȯ
	            
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
		
		System.out.println("======== ���� �׼� ��Ʈ�ѷ� ���� ========");
		System.out.println(id);
		System.out.println(title);
		System.out.println(titleShare);
		System.out.println("======== ���� �׼� ��Ʈ�ѷ� ���� ========");
		
		WikiDao dao = sqlSession.getMapper(WikiDao.class);
		
		if (titleShare.length() == 0) {
			System.out.println("������ ������ ����. null �� ó���մϴ�.");
			dao.changeMenuNoShare(title, id);
		} else {
			System.out.println("������ ���� ������.");
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
        // �޴� ID�� �޴� ��ü�� �����ϴ� Map�� ����
        Map<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
        for (MenuDTO menu : menus) {
            menuMap.put(menu.getId(), menu);
        }

        // �� �޴� �׸��� depth ���
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

        // �α��� �߰��Ͽ� �� �ֻ��� �޴��� �ش� ���� �޴����� ���
//        for (MenuDTO menu : topLevelMenus) {
//            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
//            printChildren(menu, "  ");  // ��������� ���� �޴����� ���
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
