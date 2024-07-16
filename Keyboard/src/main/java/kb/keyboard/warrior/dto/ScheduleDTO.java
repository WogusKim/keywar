package kb.keyboard.warrior.dto;


//ScheduleDTO.java
public class ScheduleDTO {
 private String scheduleid;   // 일정 id
 private String userno;       // 사번
 private String title;        // 제목
 private String content;      // 내용
 private String startDate;      // 시작일
 private String endDate;        // 마감일
 private String shareto;      // 공유 대상(개인, 팀, 부서 등)
 private String status;       // 상태

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

 public String getstartDate() {
     return startDate;
 }

 public void setstartDate(String startDate) {
     this.startDate = startDate;
 }

 public String getendDate() {
     return endDate;
 }

 public void setendDate(String endDate) {
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