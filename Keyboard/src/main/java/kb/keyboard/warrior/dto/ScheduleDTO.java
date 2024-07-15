package kb.keyboard.warrior.dto;


//ScheduleDTO.java
public class ScheduleDTO {
 private String scheduleid;   // ���� id
 private String userno;       // ���
 private String title;        // ����
 private String content;      // ����
 private String startdate;      // ������
 private String duedate;        // ������
 private String shareto;      // ���� ���(����, ��, �μ� ��)
 private String status;       // ����

 public ScheduleDTO() {
 }

 public ScheduleDTO(String scheduleid, String userno, String title, String content, String startdate, String duedate, String shareto, String status) {
     this.scheduleid = scheduleid;
     this.userno = userno;
     this.title = title;
     this.content = content;
     this.startdate = startdate;
     this.duedate = duedate;
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

 public String getStartdate() {
     return startdate;
 }

 public void setStartdate(String startdate) {
     this.startdate = startdate;
 }

 public String getDuedate() {
     return duedate;
 }

 public void setDuedate(String duedate) {
     this.duedate = duedate;
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