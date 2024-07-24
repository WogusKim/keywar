package kb.keyboard.warrior.dto;

//ȯ��DTO
public class StockDTO {

		private String country;        // 국가명
	    private String indexName;        // 종목 이름
	    private double currentPrice;     // 현재 주가
	    private double priceChange;      // 전일대비 변동폭
	    private double changePercentage; // 변동 퍼센트
	    private double weekHigh52; // 52주 최고
	    private double weekLow52; // 52주 최저
	    private String isFavorite;


		// 기본 생성자
	    public StockDTO() {}

	    // 모든 필드를 포함한 생성자
	    public StockDTO(String country, String indexName, double currentPrice, double priceChange, double changePercentage, double weekHigh52, double weekLow52) {
	    	this.country = country;
	    	this.indexName = indexName;
	        this.currentPrice = currentPrice;
	        this.priceChange = priceChange;
	        this.changePercentage = changePercentage;
	        this.weekHigh52 = weekHigh52;
	        this.weekLow52 = weekLow52;
	    }

	    // Getter와 Setter 메서드
	    
	    
	    
	    public String getIndexName() {
	        return indexName;
	    }

	    public String getCountry() {
			return country;
		}

		public void setCountry(String country) {
			this.country = country;
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
	    
	    public double getWeekHigh52() {
	        return weekHigh52;
	    }

	    public void setWeekHigh52(double weekHigh52) {
	        this.weekHigh52 = weekHigh52;
	    }

	    public double getWeekLow52() {
	        return weekLow52;
	    }

	    public void setWeekLow52(double weekLow52) {
	        this.weekLow52 = weekLow52;
	    }

	    // toString 메서드 오버라이드
	    @Override
	    public String toString() {
	        return "StockDTO{" +
	                "country='" + country + '\'' +
	                "indexName='" + indexName + '\'' +
	                ", currentPrice=" + currentPrice +
	                ", priceChange=" + priceChange +
	                ", changePercentage=" + changePercentage +
	                ", weekHigh52=" + weekHigh52 +
	                ", weekLow52=" + weekLow52 +
	                '}';
	    }
	    
	    
	    public String getisFavorite() {
			return isFavorite;
		}

		public void setisFavorite(String isFavorite) {
			this.isFavorite = isFavorite;
		}

	}