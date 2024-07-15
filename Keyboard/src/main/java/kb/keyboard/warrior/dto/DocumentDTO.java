package kb.keyboard.warrior.dto;


public class DocumentDTO {
    private String docid;          // ���� id
    private String title;          // ����
    private String content;        // ����
    private String author;         // �ۼ��� ��� (userno)
    private String createdate;       // �ۼ���
    private String attachedfiles;  // ÷������
    private String docstatus;      // ���� ���� (0: ������, 1: Ȱ��)
    private String authordeptno;   // �ۼ��μ� ��ȣ

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
