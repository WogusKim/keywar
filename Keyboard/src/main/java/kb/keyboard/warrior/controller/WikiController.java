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
		//�޴����������� �̵�
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
		
		System.out.println("���� id: " + selectedId);
		System.out.println("���� type: " + selectedType);
		System.out.println("���� depth: " + selectedDepth);
		
		System.out.println("�߰��� Type: " + menuType);
		System.out.println("�߰��� Title: " + title);
		System.out.println("�߰��� ����title: " + sharedTitle);
		
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
				
				//�������߰�
				System.out.println("�߰� �������� �߰��մϴ�.");
				//dao.insertMenuHaveParentsItem(#�����θ���id, #Ÿ��Ʋ, #����Ÿ��Ʋ, #��ũ, #�޴�Ÿ��, #�����ѹ�)
				dao.insertMenuHaveParentsItem(parentId, title, sharedTitle, link, menuType, max_order, userno);
			} else {
				//�����߰�
				
				max_order = dao.getMaxOrderOfFather(selectedId);
				max_order++;
				
				System.out.println("�߰� ������ �߰��մϴ�.");
				dao.insertMenuHaveParentsFolder(selectedId, title, sharedTitle, menuType, max_order, userno);
			}
		}
		
        // �޴������͸� ���ǰ� �𵨿� ���� �����.
        List<MenuDTO> menus = (List<MenuDTO>) session.getAttribute("menus");
        LoginDao loginDao = sqlSession.getMapper(LoginDao.class);

        menus = loginDao.getMenus(userno);
        setMenuDepth(menus);
        List<MenuDTO> topLevelMenus = organizeMenuHierarchy(menus);
        session.setAttribute("menus", topLevelMenus);
        model.addAttribute("menus", topLevelMenus);

		return "redirect:menuSetting";
	}
	

	//����ó��
	@RequestMapping("/deleteMenu")
	public String deleteMenu(Model model, HttpServletRequest request, HttpSession session) {
		
		//���ص�����
		String selectedId = request.getParameter("id");
		String selectedType = request.getParameter("type");
		String selectedDepth = request.getParameter("depth");
		
		System.out.println("���� id: " + selectedId);
		System.out.println("���� type: " + selectedType);
		System.out.println("���� depth: " + selectedDepth);
		
		//�����Ϸ��� ����� �������� ���
		
		//�����Ϸ��� ����� ������ ���
		
		
		
		
		return "redirect:menuSetting";
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
        for (MenuDTO menu : topLevelMenus) {
            System.out.println("Menu: " + menu.getTitle() + " (ID: " + menu.getId() + ")");
            printChildren(menu, "  ");  // ��������� ���� �޴����� ���
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
        return "./wiki/editor"; // src/main/webapp/WEB-INF/views/editor.jsp ������ ��ȯ
    }

    @RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
    public ResponseEntity<String> saveEditorData(@RequestBody Map<String, Object> editorData) {
        // editorData�� ó���ϰ� �����մϴ�.
        System.out.println("Received data: " + editorData);
        // �����ͺ��̽��� �����ϴ� ������ �߰��մϴ�.

        return new ResponseEntity<>("Data saved successfully", HttpStatus.OK);
    }
    
    
}
