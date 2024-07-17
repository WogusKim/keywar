package kb.keyboard.warrior.dto;



//TodoListDTO.java
public class TodoListDTO {
 private String todoid;   // 할 일 id
 private String userno;   // 사번
 private String task;     // 할 일
 private String startdate;    // 시작일
 private String duedate;    // 마감일
 private String isdone;   // 상태

 public TodoListDTO() {
 }

 public TodoListDTO(String todoid, String userno, String task, String duedate, String isdone) {
     this.todoid = todoid;
     this.userno = userno;
     this.task = task;
     this.duedate = duedate;
     this.isdone = isdone;
 }

 // Getters and Setters
 public String getTodoid() {
     return todoid;
 }

 public void setTodoid(String todoid) {
     this.todoid = todoid;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getTask() {
     return task;
 }

 public void setTask(String task) {
     this.task = task;
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

 public String getIsdone() {
     return isdone;
 }

 public void setIsdone(String isdone) {
     this.isdone = isdone;
 }
}