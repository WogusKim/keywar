package kb.keyboard.warrior.dto;


//UserDTO.java
public class UserDTO {
 private String userno;    // ���
 private String username;  // �̸�
 private String userpw;    // ��й�ȣ
 private String deptno;    // ����
 private String phoneno;   // ��ȭ��ȣ
 private String mail;      // ���Ͼ��̵�
 private String hiredate;    // �Ի���
 private String gender;    // ����
 private String birthdate;   // �������
 private String regdate;     // �����

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