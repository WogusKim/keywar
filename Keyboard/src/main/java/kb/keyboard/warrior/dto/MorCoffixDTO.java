package kb.keyboard.warrior.dto;

public class MorCoffixDTO {
	
    private String rateType;        // 금리의 구분 (예: 3개월 변동금리)
    private String previousWeekRate; // 전주 금리
    private String currentWeekRate;  // 금주 금리
    private String change;           // 증감

    // 생성자
    public MorCoffixDTO(String rateType, String previousWeekRate, String currentWeekRate, String change) {
        this.rateType = rateType;
        this.previousWeekRate = previousWeekRate;
        this.currentWeekRate = currentWeekRate;
        this.change = change;
    }
    
    // Getter and Setter
    public String getRateType() {
        return rateType;
    }

    public void setRateType(String rateType) {
        this.rateType = rateType;
    }

    public String getPreviousWeekRate() {
        return previousWeekRate;
    }

    public void setPreviousWeekRate(String previousWeekRate) {
        this.previousWeekRate = previousWeekRate;
    }

    public String getCurrentWeekRate() {
        return currentWeekRate;
    }

    public void setCurrentWeekRate(String currentWeekRate) {
        this.currentWeekRate = currentWeekRate;
    }

    public String getChange() {
        return change;
    }

    public void setChange(String change) {
        this.change = change;
    }

    @Override
    public String toString() {
        return "MorDTO{" +
               "rateType='" + rateType + '\'' +
               ", previousWeekRate='" + previousWeekRate + '\'' +
               ", currentWeekRate='" + currentWeekRate + '\'' +
               ", change='" + change + '\'' +
               '}';
    }
}
