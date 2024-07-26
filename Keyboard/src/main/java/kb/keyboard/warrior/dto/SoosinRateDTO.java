package kb.keyboard.warrior.dto;

public class SoosinRateDTO {
    private String period;
    private String fixedRate; // 만기지급식 금리
    private String monthlyInterestRate; // 월이자지급식 금리
    private String compoundMonthlyRate; // 월이자복리식 금리
    
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
