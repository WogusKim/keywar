package kb.keyboard.warrior.dto;


//ScheduleShareDTO.java
public class ScheduleShareDTO {
 private String userno;    // 사번
 private String shareto;   // 공유대상(개인, 팀, 부서 등) 개인 1, 팀 2, 부서 3
 private String sharecolor;// 캘린더에 기록하는 색상

 public ScheduleShareDTO() {
 }

 public ScheduleShareDTO(String userno, String shareto, String sharecolor) {
     this.userno = userno;
     this.shareto = shareto;
     this.sharecolor = sharecolor;
 }

 // Getters and Setters
 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getShareto() {
     return shareto;
 }

 public void setShareto(String shareto) {
     this.shareto = shareto;
 }

 public String getSharecolor() {
     return sharecolor;
 }

 public void setSharecolor(String sharecolor) {
     this.sharecolor = sharecolor;
 }
}
