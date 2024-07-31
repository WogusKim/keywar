package kb.keyboard.warrior.dto;



//CommentDTO.java
public class CommentDTO {
private int commentid;      // 댓글 id
private String targetid;       // 대상 문서 id (wiki, document 등)
private String userno;         // 작성자 사번
private String content;        // 댓글 내용
private String createdate;       // 작성일
private String commentstatus;  // 댓글 상태 (0: 삭제됨, 1: 활성)
private byte[] picture;
private String nickname;
 
 byte[] getPicture() {
	return picture;
}

 public void setPicture(byte[] picture) {
	this.picture = picture;
}

 public String getNickname() {
	return nickname;
}

 public void setNickname(String nickname) {
	this.nickname = nickname;
}

public CommentDTO() {
 }

 public CommentDTO(int commentid, String targetid, String userno, String content, String createdate, String commentstatus) {
     this.commentid = commentid;
     this.targetid = targetid;
     this.userno = userno;
     this.content = content;
     this.createdate = createdate;
     this.commentstatus = commentstatus;
 }

 // Getters and Setters
 public int getCommentid() {
     return commentid;
 }

 public void setCommentid(int commentid) {
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
