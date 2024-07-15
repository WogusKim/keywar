package kb.keyboard.warrior.dto;

public class DepartmentDTO {
    private String deptno;   // ����
    private String deptname; // �μ���
    private String teamno; // ����
    private String teamname; // ����
    private String deptstatus; // �⺻ 1, ���� ������ 0���� ��ȯ
    
    public DepartmentDTO() {
    }

    public DepartmentDTO(String deptno, String deptname, String teamno, String teamname, String deptstatus) {
        this.deptno = deptno;
        this.deptname = deptname;
        this.teamno = teamno;
        this.teamname = teamname;
        this.deptstatus = deptstatus;
    }

    // Getters and Setters
    public String getDeptno() {
        return deptno;
    }

    public void setDeptno(String deptno) {
        this.deptno = deptno;
    }

    public String getDeptname() {
        return deptname;
    }

    public void setDeptname(String deptname) {
        this.deptname = deptname;
    }

	public String getDeptstatus() {
		return deptstatus;
	}

	public void setDeptstatus(String deptStatus) {
		this.deptstatus = deptStatus;
	}

	public String getTeamno() {
		return teamno;
	}

	public void setTeamno(String teamno) {
		this.teamno = teamno;
	}

	public String getTeamname() {
		return teamname;
	}

	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}
	
	
    
    
}