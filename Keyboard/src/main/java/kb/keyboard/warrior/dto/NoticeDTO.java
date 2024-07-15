package kb.keyboard.warrior.dto;



//NoticeDTO.java
public class NoticeDTO {
 private String noticeid;      // ���� id
 private String title;         // ����
 private String content;       // ����
 private String author;        // �ۼ��� ��� (userno)
 private String createdate;      // �ۼ���
 private String noticestatus;  // ���� ���� (0: ������, 1: Ȱ��)

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