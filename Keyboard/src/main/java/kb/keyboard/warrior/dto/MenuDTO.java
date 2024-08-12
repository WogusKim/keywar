package kb.keyboard.warrior.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class MenuDTO implements Serializable {
	
    private static final long serialVersionUID = 1L;

    private int id;
    private Integer parent_id;
    private String title;
    private String titleShare;
	private String link;
    private String menuType; // �޴� ����
    private int menu_order;
    private String userno;
    private int depth;
    private List<MenuDTO> children = new ArrayList<MenuDTO>(); // �ڽ� �޴� ��� �߰�
    private int isOpen;


	// �⺻ ������
    public MenuDTO() {}

    // �Ű����� �ִ� ������
    public MenuDTO(int id, Integer parent_id, String title, String titleShare, String link, String menuType, int menu_order, String userno, int depth) {
        this.id = id;
        this.parent_id = parent_id;
        this.title = title;
        this.titleShare = titleShare;
        this.link = link;
        this.menuType = menuType;
        this.menu_order = menu_order;
        this.userno = userno;
        this.depth = depth;
    }

    // getter �� setter �޼ҵ�
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parent_id;
    }

    public void setParentId(Integer parent_id) {
        this.parent_id = parent_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getTitleShare() {
		return titleShare;
	}

	public void setTitleShare(String titleShare) {
		this.titleShare = titleShare;
	}   

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }

    public int getMenuOrder() {
        return menu_order;
    }

    public void setMenuOrder(int menu_order) {
        this.menu_order = menu_order;
    }

    public String getUserno() {
        return userno;
    }

    public void setUserno(String userno) {
        this.userno = userno;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }
    
    public List<MenuDTO> getChildren() {
        return children;
    }

    public void setChildren(List<MenuDTO> children) {
        this.children = children;
    }
    
	public int getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(int isOpen) {
		this.isOpen = isOpen;
	}
}
