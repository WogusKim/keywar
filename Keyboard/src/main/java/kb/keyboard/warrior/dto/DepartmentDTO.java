package kb.keyboard.warrior.dto;

public class DepartmentDTO {
    private String deptno;   // 점번
    private String deptname; // 부서명
    private String teamno; // 팀번
    private String teamname; // 팀명
    private String deptstatus; // 기본 1, 점번 삭제시 0으로 변환
    
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