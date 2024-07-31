package kb.keyboard.warrior.dto;

public class BoardDTO {
	private String data;
	private String management_number;
	private String title;
	private String titleShare;
	private String username;
	private int id;
	private int isOpen;
	
	
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(int isOpen) {
		this.isOpen = isOpen;
	}
	public String getManagement_number() {
		return management_number;
	}
	public void setManagement_number(String management_number) {
		this.management_number = management_number;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTitleShare() {
		return titleShare;
	}
	public void setTitleShare(String titleShare) {
		this.titleShare = titleShare;
	}
	
	
	
	
}
