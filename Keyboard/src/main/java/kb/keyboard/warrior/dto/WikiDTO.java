package kb.keyboard.warrior.dto;



//WikiDTO.java
public class WikiDTO {
 private String wikiid;           // 위키 id
 private String title;            // 제목
 private String content;          // 내용
 private String author;           // 작성자 사번 (userno)
 private String createdate;         // 생성일
 private String originalwikiid;   // 오리지날 위키 id
 private String wikistatus;       // 위키 상태
 private String attachedfiles;    // 첨부파일
 private String category_large;   // 대 카테고리
 private String category_medium;  // 중 카테고리
 private String category_small;   // 소 카테고리

 public WikiDTO() {
 }

 public WikiDTO(String wikiid, String title, String content, String author, String createdate, String originalwikiid, String wikistatus, String attachedfiles, String category_large, String category_medium, String category_small) {
     this.wikiid = wikiid;
     this.title = title;
     this.content = content;
     this.author = author;
     this.createdate = createdate;
     this.originalwikiid = originalwikiid;
     this.wikistatus = wikistatus;
     this.attachedfiles = attachedfiles;
     this.category_large = category_large;
     this.category_medium = category_medium;
     this.category_small = category_small;
 }

 // Getters and Setters
 public String getWikiid() {
     return wikiid;
 }

 public void setWikiid(String wikiid) {
     this.wikiid = wikiid;
 }

 public String getTitle() {
     return title;
 }

 public void setTitle(String title) {
     this.title = title;
 }

 public String getContent() {
     return content;
 }

 public void setContent(String content) {
     this.content = content;
 }

 public String getAuthor() {
     return author;
 }

 public void setAuthor(String author) {
     this.author = author;
 }

 public String getCreatedate() {
     return createdate;
 }

 public void setCreatedate(String createdate) {
     this.createdate = createdate;
 }

 public String getOriginalwikiid() {
     return originalwikiid;
 }

 public void setOriginalwikiid(String originalwikiid) {
     this.originalwikiid = originalwikiid;
 }

 public String getWikistatus() {
     return wikistatus;
 }

 public void setWikistatus(String wikistatus) {
     this.wikistatus = wikistatus;
 }

 public String getAttachedfiles() {
     return attachedfiles;
 }

 public void setAttachedfiles(String attachedfiles) {
     this.attachedfiles = attachedfiles;
 }

 public String getCategory_large() {
     return category_large;
 }

 public void setCategory_large(String category_large) {
     this.category_large = category_large;
 }

 public String getCategory_medium() {
     return category_medium;
 }

 public void setCategory_medium(String category_medium) {
     this.category_medium = category_medium;
 }

 public String getCategory_small() {
     return category_small;
 }

 public void setCategory_small(String category_small) {
     this.category_small = category_small;
 }
}