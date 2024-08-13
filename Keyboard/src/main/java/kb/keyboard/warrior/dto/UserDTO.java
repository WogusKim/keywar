package kb.keyboard.warrior.dto;

// UserDTO.java
public class UserDTO {
    private String userno;    // ����� ��ȣ
    private String username;  // �̸�
    private String userpw;    // ��й�ȣ
    private String deptno;    // �μ� ��ȣ
    private String teamno;    // �� ��ȣ
    private String phoneno;   // ��ȭ ��ȣ
    private String mail;      // �̸���
    private String hiredate;  // �Ի���
    private String gender;    // ����
    private String birthdate; // �������
    private String regdate;   // �����
    private String nickname;  // �г���
    private String profile;  // 마이페이지 프로필 사진용 일단 대충 추가했음
    private byte[] picture; //����
    
    public UserDTO() {
    }

    public UserDTO(String userno, String username, String userpw, String deptno, String teamno, String phoneno,
			String mail, String hiredate, String gender, String birthdate, String regdate, String nickname,
			byte[] picture) {
		super();
		this.userno = userno;
		this.username = username;
		this.userpw = userpw;
		this.deptno = deptno;
		this.teamno = teamno;
		this.phoneno = phoneno;
		this.mail = mail;
		this.hiredate = hiredate;
		this.gender = gender;
		this.birthdate = birthdate;
		this.regdate = regdate;
		this.nickname = nickname;
		this.picture = picture;
	}



	// Getters and Setters
    public String getNickname() {
        return nickname;
    }
    
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    
    public String getUserno() {
        return userno;
    }

    public void setUserno(String userno) {
        this.userno = userno;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserpw() {
        return userpw;
    }

    public void setUserpw(String userpw) {
        this.userpw = userpw;
    }

    public String getDeptno() {
        return deptno;
    }

    public void setDeptno(String deptno) {
        this.deptno = deptno;
    }

    public String getTeamno() {
        return teamno;
    }

    public void setTeamno(String teamno) {
        this.teamno = teamno;
    }

    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getHiredate() {
        return hiredate;
    }

    public void setHiredate(String hiredate) {
        this.hiredate = hiredate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

	public byte[] getPicture() {
		return picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}
	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}
    
    
}
