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
 
}