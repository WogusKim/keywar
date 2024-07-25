package kb.keyboard.warrior.dto;

import java.sql.Timestamp;

public class EditorDTO {
    private int id;                // �⺻ Ű
    private String title;          // ������ ������ ����
    private String contentJson;    // �����Ϳ��� ������ JSON ������ ������
    private Timestamp createdAt;   // ������ �ð�

    // �⺻ ������
    public EditorDTO() {
    }

    // ��� �ʵ带 �����ϴ� ������
    public EditorDTO(int id, String title, String contentJson, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.contentJson = contentJson;
        this.createdAt = createdAt;
    }

    // getter�� setter �޼ҵ�
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContentJson() {
        return contentJson;
    }

    public void setContentJson(String contentJson) {
        this.contentJson = contentJson;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
}
