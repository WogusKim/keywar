package kb.keyboard.warrior.dto;


//LoanRateDTO.java
public class LoanRateDTO {
 private String loanid;         // 여신금리 id
 private String loantype;       // 여신 종류
 private double rate;           // 금리
 private String effectivedate;    // 시행일
 private String enddate;          // 종료일

 public LoanRateDTO() {
 }

 public LoanRateDTO(String loanid, String loantype, double rate, String effectivedate, String enddate) {
     this.loanid = loanid;
     this.loantype = loantype;
     this.rate = rate;
     this.effectivedate = effectivedate;
     this.enddate = enddate;
 }

 // Getters and Setters
 public String getLoanid() {
     return loanid;
 }

 public void setLoanid(String loanid) {
     this.loanid = loanid;
 }

 public String getLoantype() {
     return loantype;
 }

 public void setLoantype(String loantype) {
     this.loantype = loantype;
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