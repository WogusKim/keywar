package kb.keyboard.warrior.dto;


//MyMemoDTO.java
public class MyMemoDTO {
 private String memoid;    // �޸� id
 private String userno;    // ���
 private String content;   // ����
 private String createdate;  // ������
 private String color;  

 public MyMemoDTO() {
 }

 public MyMemoDTO(String memoid, String userno, String content, String createdate, String color) {
	super();
	this.memoid = memoid;
	this.userno = userno;
	this.content = content;
	this.createdate = createdate;
	this.color = color;
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

public String getColor() {
	return color;
}

public void setColor(String color) {
	this.color = color;
}

 
}
