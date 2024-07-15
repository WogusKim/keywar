package kb.keyboard.warrior.dto;



//TodoListDTO.java
public class TodoListDTO {
 private String todoid;   // �� �� id
 private String userno;   // ���
 private String task;     // �� ��
 private String duedate;    // ������
 private String status;   // ����

 public TodoListDTO() {
 }

 public TodoListDTO(String todoid, String userno, String task, String duedate, String status) {
     this.todoid = todoid;
     this.userno = userno;
     this.task = task;
     this.duedate = duedate;
     this.status = status;
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

 public String getDuedate() {
     return duedate;
 }

 public void setDuedate(String duedate) {
     this.duedate = duedate;
 }

 public String getStatus() {
     return status;
 }

 public void setStatus(String status) {
     this.status = status;
 }
}