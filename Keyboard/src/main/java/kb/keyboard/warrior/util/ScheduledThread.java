package kb.keyboard.warrior.util;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledThread {

	
	@Scheduled(fixedRate = 3600000) // �ϴ��� 1�ð��� �� ���� ���ư�. 
	public void autoCrawler() { 
		// �ڵ����� ���ư��� �� �� ����ٰ� ������ ��.
		System.out.println("�ȳ� �ȳ�~~");
		
		
		
		
		
		
		
		
		
	}
}
