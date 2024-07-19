package kb.keyboard.warrior.dto;


//UserDTO.java
public class UserDTO {
    private String userno;    // �궗�슜�옄踰덊샇
    private String username;  // �씠由�
    private String userpw;    // 鍮꾨�踰덊샇
    private String deptno;    // 遺��꽌踰덊샇
    private String teamno;    // ��踰덊샇
    private String phoneno;   // �쟾�솕踰덊샇
    private String mail;      // �씠硫붿씪
    private String hiredate;  // �엯�궗�씪
    private String gender;    // �꽦蹂�
    private String birthdate; // �깮�뀈�썡�씪
    private String regdate;   // �벑濡앹씪
    private String nickname;   // �벑濡앹씪
    
 public UserDTO() {
 }

 public UserDTO(String userno, String username, String userpw, String deptno, String teamno, String phoneno, String mail, String hiredate, String gender, String birthdate, String regdate) {
     this.userno = userno;
     this.username = username;
     this.userpw = userpw;
     this.deptno = deptno;
     this.teamno = teamno;
     this.phoneno = phoneno;
     this.mail = mail;
     this.hiredate = hiredate;
     this.gender = gender;
     this.birthdate = birthdate;
     this.regdate = regdate;
 }


// Getters and Setters
 public String getNickname() {
	 return nickname;
 }
 
 public void setNickname(String nickname) {
	 this.nickname = nickname;
 }
 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getUsername() {
     return username;
 }

 public void setUsername(String username) {
     this.username = username;
 }

 public String getUserpw() {
     return userpw;
 }

 public void setUserpw(String userpw) {
     this.userpw = userpw;
 }

 public String getDeptno() {
     return deptno;
 }

 public void setDeptno(String deptno) {
     this.deptno = deptno;
 }
 
 public String getTeamno() {
	return teamno;
 }

 public void setTeamno(String teamno) {
	this.teamno = teamno;
 }

 public String getPhoneno() {
     return phoneno;
 }

 public void setPhoneno(String phoneno) {
     this.phoneno = phoneno;
 }

 public String getMail() {
     return mail;
 }

 public void setMail(String mail) {
     this.mail = mail;
 }

 public String getHiredate() {
     return hiredate;
 }

 public void setHiredate(String hiredate) {
     this.hiredate = hiredate;
 }

 public String getGender() {
     return gender;
 }

 public void setGender(String gender) {
     this.gender = gender;
 }

 public String getBirthdate() {
     return birthdate;
 }

 public void setBirthdate(String birthdate) {
     this.birthdate = birthdate;
 }

 public String getRegdate() {
     return regdate;
 }

 public void setRegdate(String regdate) {
     this.regdate = regdate;
 }
}