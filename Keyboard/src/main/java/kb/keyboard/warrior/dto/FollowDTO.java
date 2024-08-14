package kb.keyboard.warrior.dto;

public class FollowDTO {
    private String followId;
    private String userno;
    private String targetUserno;
    private String status;
    
    public FollowDTO(){
    	
    }
    public FollowDTO(String userno, String targetUserno){
    	this.userno = userno;
    	this.targetUserno = targetUserno;
    }
    
	public String getFollowId() {
		return followId;
	}
	public void setFollowId(String followId) {
		this.followId = followId;
	}
	public String getUserno() {
		return userno;
	}
	public void setUserno(String userno) {
		this.userno = userno;
	}
	public String getTargetUserno() {
		return targetUserno;
	}
	public void setTargetUserno(String targetUserno) {
		this.targetUserno = targetUserno;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	} 
    
    
    
}
