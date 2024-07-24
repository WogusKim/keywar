package kb.keyboard.warrior.display.command;

import java.util.List;

import org.springframework.stereotype.Component;

import kb.keyboard.warrior.StockInterCrawler;
import kb.keyboard.warrior.StockKoreaCrawler;
import kb.keyboard.warrior.dto.StockDTO;



@Component
public class DisplayCommand {
	
	private StockKoreaCrawler koreaCrawler = new StockKoreaCrawler();
	private StockInterCrawler interCrawler = new StockInterCrawler();

	public List<StockDTO> getKoreaStocks() {
	    return koreaCrawler.fetchIndexData();
	}

	public List<StockDTO> getInterStocks() {
	    return interCrawler.fetchIndexData();
	}
    
	
}
