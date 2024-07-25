package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.ExchangeRateDTO;

public interface ExchangeRateDao {
	
	public void updateExchangeRate(ExchangeRateDTO dto);
	public List<ExchangeRateDTO> getAllExchangeRate();
}
