package kb.keyboard.warrior.util;

import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class NotificationWebSocketHandler extends TextWebSocketHandler  {
	 	@Override
	    public void handleTextMessage(WebSocketSession session, org.springframework.web.socket.TextMessage message) throws Exception {
	        // Handle incoming messages from clients if needed
	    }
	    
	    // You can add methods to send messages to clients
	    public void sendNotification(String notification) throws Exception {
	        for (WebSocketSession session : sessions) {
	            session.sendMessage(new org.springframework.web.socket.TextMessage(notification));
	        }
	    }
}
