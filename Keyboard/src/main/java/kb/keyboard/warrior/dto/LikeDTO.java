package kb.keyboard.warrior.dto;


//LikeDTO.java
public class LikeDTO {
 private String likeid;    // ���ƿ� id
 private String targetid;  // ��� ���� id (wiki, document ��)
 private String userno;    // ���

 public LikeDTO() {
 }

 public LikeDTO(String likeid, String targetid, String userno) {
     this.likeid = likeid;
     this.targetid = targetid;
     this.userno = userno;
 }

 // Getters and Setters
 public String getLikeid() {
     return likeid;
 }

 public void setLikeid(String likeid) {
     this.likeid = likeid;
 }

 public String getTargetid() {
     return targetid;
 }

 public void setTargetid(String targetid) {
     this.targetid = targetid;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }
}
