package kb.keyboard.warrior.util;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledThread {

	
	@Scheduled(fixedRate = 3600000) // 일단은 1시간에 한 번씩 돌아감. 
	public void autoCrawler() { 
		// 자동으로 돌아가게 할 거 여기다가 넣으면 됨.
		System.out.println("안녕 안녕~~");
		
		
		
		
		
		
		
		
		
	}
}
