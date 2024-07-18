package kb.keyboard.warrior.dto;

public class MorCoffixDTO {
	
    private String rateType;        // �ݸ��� ���� (��: 3���� �����ݸ�)
    private String previousWeekRate; // ���� �ݸ�
    private String currentWeekRate;  // ���� �ݸ�
    private String change;           // ����

    // ������
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
