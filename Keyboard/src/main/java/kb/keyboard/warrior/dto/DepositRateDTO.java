package kb.keyboard.warrior.dto;


//DepositRateDTO.java
public class DepositRateDTO {
 private String depositid;      // 수신금리 id
 private String deposittype;    // 수신 종류
 private double rate;           // 금리
 private String effectivedate;    // 시행일
 private String enddate;          // 종료일

 public DepositRateDTO() {
 }

 public DepositRateDTO(String depositid, String deposittype, double rate, String effectivedate, String enddate) {
     this.depositid = depositid;
     this.deposittype = deposittype;
     this.rate = rate;
     this.effectivedate = effectivedate;
     this.enddate = enddate;
 }

 // Getters and Setters
 public String getDepositid() {
     return depositid;
 }

 public void setDepositid(String depositid) {
     this.depositid = depositid;
 }

 public String getDeposittype() {
     return deposittype;
 }

 public void setDeposittype(String deposittype) {
     this.deposittype = deposittype;
 }

 public double getRate() {
     return rate;
 }

 public void setRate(double rate) {
     this.rate = rate;
 }

 public String getEffectivedate() {
     return effectivedate;
 }

 public void setEffectivedate(String effectivedate) {
     this.effectivedate = effectivedate;
 }

 public String getEnddate() {
     return enddate;
 }

 public void setEnddate(String enddate) {
     this.enddate = enddate;
 }
}
