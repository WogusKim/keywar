package kb.keyboard.warrior.dto;


//AlertDTO.java
public class AlertDTO {
 private String alertid;   // �˸� id
 private String userno;    // ��� (������)
 private String message;   // �޽���
 private String senddate;    // �߼���
 private String isread;    // ���� ����
 private String category;    // �з�
 private String detail;    // ��

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