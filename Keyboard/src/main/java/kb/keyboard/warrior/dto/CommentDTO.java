package kb.keyboard.warrior.dto;



//CommentDTO.java
public class CommentDTO {
 private String commentid;      // ��� id
 private String targetid;       // ��� ���� id (wiki, document ��)
 private String userno;         // �ۼ��� ���
 private String content;        // ��� ����
 private String createdate;       // �ۼ���
 private String commentstatus;  // ��� ���� (0: ������, 1: Ȱ��)

 public CommentDTO() {
 }

 public CommentDTO(String commentid, String targetid, String userno, String content, String createdate, String commentstatus) {
     this.commentid = commentid;
     this.targetid = targetid;
     this.userno = userno;
     this.content = content;
     this.createdate = createdate;
     this.commentstatus = commentstatus;
 }

 // Getters and Setters
 public String getCommentid() {
     return commentid;
 }

 public void setCommentid(String commentid) {
     this.commentid = commentid;
 }

 public String getTargetid() {
     return targetid;
 }

 public void setTargetid(String targetid) {
     this.targetid = targetid;
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

 public String getCommentstatus() {
     return commentstatus;
 }

 public void setCommentstatus(String commentstatus) {
     this.commentstatus = commentstatus;
 }
}
