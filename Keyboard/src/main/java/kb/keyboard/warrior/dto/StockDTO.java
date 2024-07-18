package kb.keyboard.warrior.dto;

//ȯ��DTO
public class StockDTO {
	
	    private String indexName;        // 종목 이름
	    private double currentPrice;     // 현재 주가
	    private double priceChange;      // 전일대비 변동폭
	    private double changePercentage; // 변동 퍼센트

	    // 기본 생성자
	    public StockDTO() {}

	    // 모든 필드를 포함한 생성자
	    public StockDTO(String indexName, double currentPrice, double priceChange, double changePercentage) {
	        this.indexName = indexName;
	        this.currentPrice = currentPrice;
	        this.priceChange = priceChange;
	        this.changePercentage = changePercentage;
	    }

	    // Getter와 Setter 메서드
	    public String getIndexName() {
	        return indexName;
	    }

	    public void setIndexName(String indexName) {
	        this.indexName = indexName;
	    }

	    public double getCurrentPrice() {
	        return currentPrice;
	    }

	    public void setCurrentPrice(double currentPrice) {
	        this.currentPrice = currentPrice;
	    }

	    public double getPriceChange() {
	        return priceChange;
	    }

	    public void setPriceChange(double priceChange) {
	        this.priceChange = priceChange;
	    }

	    public double getChangePercentage() {
	        return changePercentage;
	    }

	    public void setChangePercentage(double changePercentage) {
	        this.changePercentage = changePercentage;
	    }

	    // toString 메서드 오버라이드
	    @Override
	    public String toString() {
	        return "StockDTO{" +
	                "indexName='" + indexName + '\'' +
	                ", currentPrice=" + currentPrice +
	                ", priceChange=" + priceChange +
	                ", changePercentage=" + changePercentage +
	                '}';
	    }
	}