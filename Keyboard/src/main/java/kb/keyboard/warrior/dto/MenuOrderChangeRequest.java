package kb.keyboard.warrior.dto;

public class MenuOrderChangeRequest {
	
    private String itemId;
    private String direction;

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }
}
