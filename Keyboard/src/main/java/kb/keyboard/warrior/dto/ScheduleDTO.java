package kb.keyboard.warrior.dto;


//ScheduleDTO.java
public class ScheduleDTO {
 private String scheduleid;   // 
 private String userno;       // 
 private String title;        // 
 private String content;      // 
 private String startDate;      // 
 private String endDate;        // 
 private String shareto;      // share to who(personal, team, branch/dept)
 private String status;       // 

 public ScheduleDTO() {
 }

 public ScheduleDTO(String scheduleid, String userno, String title, String content, String startDate, String endDate, String shareto, String status) {
     this.scheduleid = scheduleid;
     this.userno = userno;
     this.title = title;
     this.content = content;
     this.startDate = startDate;
     this.endDate = endDate;
     this.shareto = shareto;
     this.status = status;
 }

 // Getters and Setters
 public String getScheduleid() {
     return scheduleid;
 }

 public void setScheduleid(String scheduleid) {
     this.scheduleid = scheduleid;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
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

 public String getStartDate() {
     return startDate;
 }

 public void setStartDate(String startDate) {
     this.startDate = startDate;
 }

 public String getEndDate() {
     return endDate;
 }

 public void setEndDate(String endDate) {
     this.endDate = endDate;
 }

 public String getShareto() {
     return shareto;
 }

 public void setShareto(String shareto) {
     this.shareto = shareto;
 }

 public String getStatus() {
     return status;
 }

 public void setStatus(String status) {
     this.status = status;
 }
}