package kb.keyboard.warrior.dto;



//NoticeDTO.java
public class NoticeDTO {
 private String noticeid;      // 공지 id
 private String title;         // 제목
 private String content;       // 내용
 private String author;        // 작성자 사번 (userno)
 private String createdate;      // 작성일
 private String noticestatus;  // 공지 상태 (0: 삭제됨, 1: 활성)

 public NoticeDTO() {
 }

 public NoticeDTO(String noticeid, String title, String content, String author, String createdate, String noticestatus) {
     this.noticeid = noticeid;
     this.title = title;
     this.content = content;
     this.author = author;
     this.createdate = createdate;
     this.noticestatus = noticestatus;
 }

 // Getters and Setters
 public String getNoticeid() {
     return noticeid;
 }

 public void setNoticeid(String noticeid) {
     this.noticeid = noticeid;
 }

 public String getTitle() {
     return title;
 }

 public void setTitle(String title) {
     this.title = title;
 }

 public String getContent() {
     return content;
 }

 public void setContent(String content) {
     this.content = content;
 }

 public String getAuthor() {
     return author;
 }

 public void setAuthor(String author) {
     this.author = author;
 }

 public String getCreatedate() {
     return createdate;
 }

 public void setCreatedate(String createdate) {
     this.createdate = createdate;
 }

 public String getNoticestatus() {
     return noticestatus;
 }

 public void setNoticestatus(String noticestatus) {
     this.noticestatus = noticestatus;
 }
}