package kb.keyboard.warrior.dto;


public class DocumentDTO {
    private String docid;          // 문서 id
    private String title;          // 제목
    private String content;        // 내용
    private String author;         // 작성자 사번 (userno)
    private String createdate;       // 작성일
    private String attachedfiles;  // 첨부파일
    private String docstatus;      // 문서 상태 (0: 삭제됨, 1: 활성)
    private String authordeptno;   // 작성부서 번호

    public DocumentDTO() {
    }

    public DocumentDTO(String docid, String title, String content, String author, String createdate, String attachedfiles, String docstatus, String authordeptno) {
        this.docid = docid;
        this.title = title;
        this.content = content;
        this.author = author;
        this.createdate = createdate;
        this.attachedfiles = attachedfiles;
        this.docstatus = docstatus;
        this.authordeptno = authordeptno;
    }

    // Getters and Setters
    public String getDocid() {
        return docid;
    }

    public void setDocid(String docid) {
        this.docid = docid;
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

    public String getAttachedfiles() {
        return attachedfiles;
    }

    public void setAttachedfiles(String attachedfiles) {
        this.attachedfiles = attachedfiles;
    }

    public String getDocstatus() {
        return docstatus;
    }

    public void setDocstatus(String docstatus) {
        this.docstatus = docstatus;
    }

    public String getAuthordeptno() {
        return authordeptno;
    }

    public void setAuthordeptno(String authordeptno) {
        this.authordeptno = authordeptno;
    }
}
