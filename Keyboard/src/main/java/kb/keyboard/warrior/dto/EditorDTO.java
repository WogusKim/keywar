package kb.keyboard.warrior.dto;

import java.sql.Timestamp;

public class EditorDTO {
    private int id;                // 기본 키
    private String title;          // 에디터 내용의 제목
    private String contentJson;    // 에디터에서 생성된 JSON 형식의 컨텐츠
    private Timestamp createdAt;   // 생성된 시간

    // 기본 생성자
    public EditorDTO() {
    }

    // 모든 필드를 포함하는 생성자
    public EditorDTO(int id, String title, String contentJson, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.contentJson = contentJson;
        this.createdAt = createdAt;
    }

    // getter와 setter 메소드
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
