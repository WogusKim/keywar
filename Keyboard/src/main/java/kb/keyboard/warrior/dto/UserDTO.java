package kb.keyboard.warrior.dto;


//UserDTO.java
public class UserDTO {
 private String userno;    // 사번
 private String username;  // 이름
 private String userpw;    // 비밀번호
 private String deptno;    // 점번
 private String phoneno;   // 전화번호
 private String mail;      // 메일아이디
 private String hiredate;    // 입사일
 private String gender;    // 성별
 private String birthdate;   // 생년월일
 private String regdate;     // 등록일

 public UserDTO() {
 }

 public UserDTO(String userno, String username, String userpw, String deptno, String phoneno, String mail, String hiredate, String gender, String birthdate, String regdate) {
     this.userno = userno;
     this.username = username;
     this.userpw = userpw;
     this.deptno = deptno;
     this.phoneno = phoneno;
     this.mail = mail;
     this.hiredate = hiredate;
     this.gender = gender;
     this.birthdate = birthdate;
     this.regdate = regdate;
 }

 // Getters and Setters
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