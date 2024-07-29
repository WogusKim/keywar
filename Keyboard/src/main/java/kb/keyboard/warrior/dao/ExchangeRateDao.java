package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.ExchangeRateDTO;
import kb.keyboard.warrior.dto.MorCoffixDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO;
import kb.keyboard.warrior.dto.SoosinRateDTO2;
import kb.keyboard.warrior.dto.StockDTO;

public interface ExchangeRateDao {
	
	public void updateExchangeRate(ExchangeRateDTO dto);
	public void updateMor(MorCoffixDTO dto);
	public void updateCofix(MorCoffixDTO dto);
	public void updateStock(StockDTO dto);
	public void updateInterestRate(SoosinRateDTO dto);
	public void updateInterestRate2(SoosinRateDTO2 dto);
	public List<ExchangeRateDTO> getAllExchangeRate();
	public List<MorCoffixDTO> getAllMor();
	public List<MorCoffixDTO> getAllCofix();
	public List<StockDTO> getAllStock();
	public List<SoosinRateDTO> getAllInterestRate();
	public List<SoosinRateDTO2> getAllInterestRate2();
}
