package kb.keyboard.warrior.dto;


//MyMemoDTO.java
public class MyMemoDTO {
 private String memoid;    // 메모 id
 private String userno;    // 사번
 private String content;   // 내용
 private String createdate;  // 생성일

 public MyMemoDTO() {
 }

 public MyMemoDTO(String memoid, String userno, String content, String createdate) {
     this.memoid = memoid;
     this.userno = userno;
     this.content = content;
     this.createdate = createdate;
 }

 // Getters and Setters
 public String getMemoid() {
     return memoid;
 }

 public void setMemoid(String memoid) {
     this.memoid = memoid;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getContent() {
     return content;
 }

 public void setContent(String content) {
     this.content = content;
 }

 public String getCreatedate() {
     return createdate;
 }

 public void setCreatedate(String createdate) {
     this.createdate = createdate;
 }
}
