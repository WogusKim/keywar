package kb.keyboard.warrior.dto;



//NoticeDTO.java
public class NoticeDTO {
 private String noticeid;      // 공지 id
 private String title;         // 제목
 private String content;       // 내용
 private String userno;        // 작성자 사번 (userno)
 private String deptno;
 private String createdate;      // 작성일
 private String noticestatus;  // 공지 상태 (0: 삭제됨, 1: 활성)
 
 // 새로운 필드 추가
 private int positionX;        // 공지 위치 x좌표
 private int positionY;        // 공지 위치 y좌표

 public NoticeDTO() {
 }

public NoticeDTO(String noticeid, String title, String content, String userno, String deptno, String createdate,
		String noticestatus, int positionX, int positionY) {
	super();
	this.noticeid = noticeid;
	this.title = title;
	this.content = content;
	this.userno = userno;
	this.deptno = deptno;
	this.createdate = createdate;
	this.noticestatus = noticestatus;
	this.positionX = positionX;
	this.positionY = positionY;
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

 public String getUserno() {
	return userno;
}

public void setUserno(String userno) {
	this.userno = userno;
}

public String getDeptno() {
	return deptno;
}

public void setDeptno(String deptno) {
	this.deptno = deptno;
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

public int getPositionX() {
	return positionX;
}

public void setPositionX(int positionX) {
	this.positionX = positionX;
}

public int getPositionY() {
	return positionY;
}

public void setPositionY(int positionY) {
	this.positionY = positionY;
}
 
 
}