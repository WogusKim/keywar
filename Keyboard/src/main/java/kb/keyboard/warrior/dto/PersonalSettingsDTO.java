package kb.keyboard.warrior.dto;



//PersonalSettingsDTO.java
public class PersonalSettingsDTO {
 private String settingid;           // ���� id
 private String userno;              // ���
 private String alert_setting;       // �˸� ����
 private String display_setting;     // ������ ����
 private String dept_doc_alert;      // ���� �μ� ���� �˸�
 private String neg_notice_alert;    // ���� �������� �˸�
 private String like_alert;          // ���ƿ� �˸�
 private String comment_alert;       // ��� �˸�
 private String fx_display;          // ȯ�� ������
 private String stock_display;       // ���� ������
 private String rate_display;        // �ݸ� ������
 private String dept_display;        // ���� �μ� ������
 private String news_display;        // ������ ���� ������

 public PersonalSettingsDTO() {
 }

 public PersonalSettingsDTO(String settingid, String userno, String alert_setting, String display_setting, String dept_doc_alert, String neg_notice_alert, String like_alert, String comment_alert, String fx_display, String stock_display, String rate_display, String dept_display, String news_display) {
     this.settingid = settingid;
     this.userno = userno;
     this.alert_setting = alert_setting;
     this.display_setting = display_setting;
     this.dept_doc_alert = dept_doc_alert;
     this.neg_notice_alert = neg_notice_alert;
     this.like_alert = like_alert;
     this.comment_alert = comment_alert;
     this.fx_display = fx_display;
     this.stock_display = stock_display;
     this.rate_display = rate_display;
     this.dept_display = dept_display;
     this.news_display = news_display;
 }

 // Getters and Setters
 public String getSettingid() {
     return settingid;
 }

 public void setSettingid(String settingid) {
     this.settingid = settingid;
 }

 public String getUserno() {
     return userno;
 }

 public void setUserno(String userno) {
     this.userno = userno;
 }

 public String getAlert_setting() {
     return alert_setting;
 }

 public void setAlert_setting(String alert_setting) {
     this.alert_setting = alert_setting;
 }

 public String getDisplay_setting() {
     return display_setting;
 }

 public void setDisplay_setting(String display_setting) {
     this.display_setting = display_setting;
 }

 public String getDept_doc_alert() {
     return dept_doc_alert;
 }

 public void setDept_doc_alert(String dept_doc_alert) {
     this.dept_doc_alert = dept_doc_alert;
 }

 public String getNeg_notice_alert() {
     return neg_notice_alert;
 }

 public void setNeg_notice_alert(String neg_notice_alert) {
     this.neg_notice_alert = neg_notice_alert;
 }

 public String getLike_alert() {
     return like_alert;
 }

 public void setLike_alert(String like_alert) {
     this.like_alert = like_alert;
 }

 public String getComment_alert() {
     return comment_alert;
 }

 public void setComment_alert(String comment_alert) {
     this.comment_alert = comment_alert;
 }

 public String getFx_display() {
     return fx_display;
 }

 public void setFx_display(String fx_display) {
     this.fx_display = fx_display;
 }

 public String getStock_display() {
     return stock_display;
 }

 public void setStock_display(String stock_display) {
     this.stock_display = stock_display;
 }

 public String getRate_display() {
     return rate_display;
 }

 public void setRate_display(String rate_display) {
     this.rate_display = rate_display;
 }

 public String getDept_display() {
     return dept_display;
 }

 public void setDept_display(String dept_display) {
     this.dept_display = dept_display;
 }

 public String getNews_display() {
     return news_display;
 }

 public void setNews_display(String news_display) {
     this.news_display = news_display;
 }
}
