package kb.keyboard.warrior.dto;

public class SoosinRateDTO {
    private String period;
    private String fixedRate; // �������޽� �ݸ�
    private String monthlyInterestRate; // ���������޽� �ݸ�
    private String compoundMonthlyRate; // �����ں����� �ݸ�
    
    public SoosinRateDTO() {
    }
    public SoosinRateDTO(String period, String fixedRate, String monthlyInterestRate, String compoundMonthlyRate) {
        this.period = period;
        this.fixedRate = fixedRate;
        this.monthlyInterestRate = monthlyInterestRate;
        this.compoundMonthlyRate = compoundMonthlyRate;
    }

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getFixedRate() {
		return fixedRate;
	}

	public void setFixedRate(String fixedRate) {
		this.fixedRate = fixedRate;
	}

	public String getMonthlyInterestRate() {
		return monthlyInterestRate;
	}

	public void setMonthlyInterestRate(String monthlyInterestRate) {
		this.monthlyInterestRate = monthlyInterestRate;
	}

	public String getCompoundMonthlyRate() {
		return compoundMonthlyRate;
	}

	public void setCompoundMonthlyRate(String compoundMonthlyRate) {
		this.compoundMonthlyRate = compoundMonthlyRate;
	}
    
    
}
