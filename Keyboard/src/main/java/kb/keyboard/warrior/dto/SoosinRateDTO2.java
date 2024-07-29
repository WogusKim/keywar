package kb.keyboard.warrior.dto;

public class SoosinRateDTO2 {
	
	
    private String period;
    private double basicRate;
    private double customerRate;
    public SoosinRateDTO2() {
    }
    public SoosinRateDTO2(String period, double basicRate, double customerRate) {
        this.period = period;
        this.basicRate = basicRate;
        this.customerRate = customerRate;
    }

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public double getBasicRate() {
		return basicRate;
	}

	public void setBasicRate(double basicRate) {
		this.basicRate = basicRate;
	}

	public double getCustomerRate() {
		return customerRate;
	}

	public void setCustomerRate(double customerRate) {
		this.customerRate = customerRate;
	}
    
    
    
    

    
}
