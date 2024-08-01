package kb.keyboard.warrior.dto;

//ScheduleDTO.java
public class ScheduleDTO {
	private String scheduleid; //
	private String userno; //
	private String title; //
	private String content; //
	private String startDate; //
	private String endDate; //
	private String sharedepth1; //
	private String deptname; //
	private String sharedepth2; //
	private String teamname; //
	private String sharedepth3; //
	private String customname; // share to who(personal, team, branch/dept)
	private String sharecolor; //
	private String category; //
	private String customShare; //
	private String shareto; //
	private String status; //
	private String groupName; //
	private String username; //
	private String maxSharedepth3;

	public ScheduleDTO() {
	}

	public ScheduleDTO(String scheduleid, String userno, String title, String content, String startDate, String endDate,
			String sharedepth1, String deptname, String sharedepth2, String teamname, String sharedepth3, String customname, 
			String customShare, String sharecolor, String shareto, String category, String status, String groupName, String username
			, String maxSharedepth3) {
		this.scheduleid = scheduleid;
		this.userno = userno;
		this.title = title;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
		this.sharedepth1 = sharedepth1;
		this.sharedepth2 = sharedepth2;
		this.sharedepth3 = sharedepth3;
		this.deptname = deptname;
		this.teamname = teamname;
		this.customname = customname;
		this.customShare = customShare;
		this.sharecolor = sharecolor;
		this.shareto = shareto;
		this.category = category;
		this.status = status;
		this.groupName = groupName;
		this.username = username;
		this.maxSharedepth3 = maxSharedepth3;
	}

	// Getters and Setters
	public String getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(String scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getUserno() {
		return userno;
	}

	public void setUserno(String userno) {
		this.userno = userno;
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

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSharedepth1() {
		return sharedepth1;
	}

	public void setSharedepth1(String sharedepth1) {
		this.sharedepth1 = sharedepth1;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	public String getSharedepth2() {
		return sharedepth2;
	}

	public void setSharedepth2(String sharedepth2) {
		this.sharedepth2 = sharedepth2;
	}

	public String getTeamname() {
		return teamname;
	}

	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}

	public String getSharedepth3() {
		return sharedepth3;
	}

	public void setSharedepth3(String sharedepth3) {
		this.sharedepth3 = sharedepth3;
	}

	public String getCustomname() {
		return customname;
	}

	public void setCustomname(String customname) {
		this.customname = customname;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSharecolor() {
		return sharecolor;
	}

	public void setSharecolor(String sharecolor) {
		this.sharecolor = sharecolor;
	}

	public String getCustomShare() {
		return customShare;
	}

	public void setCustomShare(String customShare) {
		this.customShare = customShare;
	}

	public String getShareto() {
		return shareto;
	}

	public void setShareto(String shareto) {
		this.shareto = shareto;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getMaxSharedepth3() {
		return maxSharedepth3;
	}

	public void setMaxSharedepth3(String maxSharedepth3) {
		this.maxSharedepth3 = maxSharedepth3;
	}
	
	
	

}