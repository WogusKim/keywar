package kb.keyboard.warrior.dto;


//DeptMemoDTO.java
public class DeptMemoDTO {
 private String memoid;    // 메모 id
 private String deptno;    // 부서 번호
 private String userno;    // 사번
 private String content;   // 내용
 private String createdate;  // 생성일

 public DeptMemoDTO() {
 }

 public DeptMemoDTO(String memoid, String deptno, String userno, String content, String createdate) {
     this.memoid = memoid;
     this.deptno = deptno;
     this.userno = userno;
     this.content = content;
     this.createdate = createdate;
 }

 // Getters and Setters
 public String getMemoid() {
     return memoid;
 }

 public void setMemoid(String memoid) {
     this.memoid = memoid;
 }

 public String getDeptno() {
     return deptno;
 }

 public void setDeptno(String deptno) {
     this.deptno = deptno;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getContent() {
     return content;
 }

 public void setContent(String content) {
     this.content = content;
 }

 public String getCreatedate() {
     return createdate;
 }

 public void setCreatedate(String createdate) {
     this.createdate = createdate;
 }
}
