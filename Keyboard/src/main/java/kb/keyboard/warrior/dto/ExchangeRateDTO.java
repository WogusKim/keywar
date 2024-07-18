package kb.keyboard.warrior.dto;

//È¯À²DTO
public class ExchangeRateDTO {

    private String currencyCode;
    private String currencyName;
    private Double standardRate;
    private Double transferSend;
    private Double transferReceive;
    private Double cashBuy;
    private Double cashSell;
    private Double usdRate;
    private String rateChangeLink;
    
	public String getCurrencyCode() {
		return currencyCode;
	}
	public void setCurrencyCode(String currencyCode) {
		this.currencyCode = currencyCode;
	}
	public String getCurrencyName() {
		return currencyName;
	}
	public void setCurrencyName(String currencyName) {
		this.currencyName = currencyName;
	}
	public Double getStandardRate() {
		return standardRate;
	}
	public void setStandardRate(Double standardRate) {
		this.standardRate = standardRate;
	}
	public Double getTransferSend() {
		return transferSend;
	}
	public void setTransferSend(Double transferSend) {
		this.transferSend = transferSend;
	}
	public Double getTransferReceive() {
		return transferReceive;
	}
	public void setTransferReceive(Double transferReceive) {
		this.transferReceive = transferReceive;
	}
	public Double getCashBuy() {
		return cashBuy;
	}
	public void setCashBuy(Double cashBuy) {
		this.cashBuy = cashBuy;
	}
	public Double getCashSell() {
		return cashSell;
	}
	public void setCashSell(Double cashSell) {
		this.cashSell = cashSell;
	}
	public Double getUsdRate() {
		return usdRate;
	}
	public void setUsdRate(Double usdRate) {
		this.usdRate = usdRate;
	}
	public String getRateChangeLink() {
		return rateChangeLink;
	}
	public void setRateChangeLink(String rateChangeLink) {
		this.rateChangeLink = rateChangeLink;
	}
    
    
   
    
}
