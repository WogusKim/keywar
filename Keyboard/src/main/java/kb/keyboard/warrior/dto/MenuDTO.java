package kb.keyboard.warrior.dto;

public class MenuDTO {
    private int id;
    private Integer parent_id; // �θ� �޴� ID (null ����)
    private String title;
    private String link; // �޴��� ��ũ�ϴ� URL (null ����)
    private String menu_type; // 'folder' �Ǵ� 'item'
    private int menu_order; // �޴� ���� ����
    private String userno; // ����� ��ȣ
    private int depth; // �޴� ����

    // �⺻ ������
    public MenuDTO() {}

    // �Ű����� �ִ� ������
    public MenuDTO(int id, Integer parent_id, String title, String link, String menu_type, int menu_order, String userno, int depth) {
        this.id = id;
        this.parent_id = parent_id;
        this.title = title;
        this.link = link;
        this.menu_type = menu_type;
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

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getMenuType() {
        return menu_type;
    }

    public void setMenuType(String menu_type) {
        this.menu_type = menu_type;
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
}
