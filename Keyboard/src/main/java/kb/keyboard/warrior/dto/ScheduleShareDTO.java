package kb.keyboard.warrior.dto;


//ScheduleShareDTO.java
public class ScheduleShareDTO {
 private String userno;    // 
	private String sharedepth1; //
	private String sharedepth2; //
	private String sharedepth3; //
	private String customname; // share to who(personal, team, branch/dept)
 private String sharecolor;// color on calendar

 public ScheduleShareDTO() {
 }

 public ScheduleShareDTO(String userno, String sharedepth1, String sharedepth2, String sharedepth3, String customname, String sharecolor) {
     this.userno = userno;
     this.sharedepth1 = sharedepth1;
     this.sharedepth2 = sharedepth2;
     this.sharedepth3 = sharedepth3;
     this.customname = customname;
     this.sharecolor = sharecolor;
 }

 // Getters and Setters
 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 
 public String getSharedepth1() {
	return sharedepth1;
}

public void setSharedepth1(String sharedepth1) {
	this.sharedepth1 = sharedepth1;
}

public String getSharedepth2() {
	return sharedepth2;
}

public void setSharedepth2(String sharedepth2) {
	this.sharedepth2 = sharedepth2;
}

public String getSharedepth3() {
	return sharedepth3;
}

public void setSharedepth3(String sharedepth3) {
	this.sharedepth3 = sharedepth3;
}

public String getCustomname() {
	return customname;
}

public void setCustomname(String customname) {
	this.customname = customname;
}

public String getSharecolor() {
     return sharecolor;
 }

 public void setSharecolor(String sharecolor) {
     this.sharecolor = sharecolor;
 }
}
