package kb.keyboard.warrior.dto;

public class BoardDTO {
	private String data;
	private String management_number;
	private String title;
	private String titleShare;
	private String username;
	private String nickname;
	private String category;
	private String picture;
	private int id;
	private int isOpen;
	private int like_count;
	private int comment_count;
	private int note_count;
	//프로필사진을 위해서 급조함 20240806
	private String userno;
	//조회수 관련 추가 20240806
	private Integer hits_count;
	
	//프로필사진을 위해서 급조함 20240806	
	public String getUserno() {
		return userno;
	}
	public void setUserno(String userno) {
		this.userno = userno;
	}
	//프로필사진을 위해서 급조함 20240806	

	//조회수 관련 추가 20240806
	public Integer getHits_count() {
		return hits_count;
	}
	public void setHits_count(Integer hits_count) {
		this.hits_count = hits_count;
	}
	//조회수 관련 추가 20240806
	
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
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getComment_count() {
		return comment_count;
	}
	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public int getNote_count() {
		return note_count;
	}
	public void setNote_count(int note_count) {
		this.note_count = note_count;
	}

	
	
	
	
	
}
