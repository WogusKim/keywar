package kb.keyboard.warrior.dto;


//ScheduleShareDTO.java
public class ScheduleShareDTO {
 private String userno;    // ���
 private String shareto;   // �������(����, ��, �μ� ��) ���� 1, �� 2, �μ� 3
 private String sharecolor;// Ķ������ ����ϴ� ����

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
