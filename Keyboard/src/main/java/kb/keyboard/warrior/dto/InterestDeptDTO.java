package kb.keyboard.warrior.dto;


//InterestDeptDTO.java
public class InterestDeptDTO {
 private String userno;   // 사번
 private String deptno;   // 관심 부서

 public InterestDeptDTO() {
 }

 public InterestDeptDTO(String userno, String deptno) {
     this.userno = userno;
     this.deptno = deptno;
 }

 // Getters and Setters
 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getDeptno() {
     return deptno;
 }

 public void setDeptno(String deptno) {
     this.deptno = deptno;
 }
}