package kb.keyboard.warrior.dto;


//AlertDTO.java
public class AlertDTO {
 private String alertid;   // 알림 id
 private String userno;    // 사번 (수신자)
 private String message;   // 메시지
 private String senddate;    // 발송일
 private String isread;    // 읽음 여부
 private String category;    // 분류
 private String detail;    // 상세
 private String like;    // 알림 수신 여부
 private String comment;    // 알림 수신 여부
 private String notice;    // 알림 수신 여부
 private String calendar;    // 알림 수신 여부
 private String checkStatus;    //동의 여부
 private String subscribe;    //동의 여부
 
 
 
 
 

 public AlertDTO() {
 }

 public AlertDTO(String alertid, String userno, String message, String senddate, String isread) {
     this.alertid = alertid;
     this.userno = userno;
     this.message = message;
     this.senddate = senddate;
     this.isread = isread;
 }

 // Getters and Setters
 public String getAlertid() {
     return alertid;
 }

 public void setAlertid(String alertid) {
     this.alertid = alertid;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getMessage() {
     return message;
 }

 public void setMessage(String message) {
     this.message = message;
 }

 public String getSenddate() {
     return senddate;
 }

 public void setSenddate(String senddate) {
     this.senddate = senddate;
 }

 public String getIsread() {
     return isread;
 }

 public void setIsread(String isread) {
     this.isread = isread;
 }

public String getCategory() {
	return category;
}

public void setCategory(String category) {
	this.category = category;
}

public String getDetail() {
	return detail;
}

public void setDetail(String detail) {
	this.detail = detail;
}

public String getLike() {
	return like;
}

public void setLike(String like) {
	this.like = like;
}

public String getComment() {
	return comment;
}

public void setComment(String comment) {
	this.comment = comment;
}

public String getNotice() {
	return notice;
}

public void setNotice(String notice) {
	this.notice = notice;
}

public String getCalendar() {
	return calendar;
}

public void setCalendar(String calendar) {
	this.calendar = calendar;
}

public String getCheckStatus() {
	return checkStatus;
}

public void setCheckStatus(String checkStatus) {
	this.checkStatus = checkStatus;
}

public String getSubscribe() {
	return subscribe;
}

public void setSubscribe(String subscribe) {
	this.subscribe = subscribe;
}
 
}