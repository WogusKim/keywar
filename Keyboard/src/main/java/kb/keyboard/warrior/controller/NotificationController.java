package kb.keyboard.warrior.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.CopyOnWriteArrayList;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kb.keyboard.warrior.util.Post;

@Controller
public class NotificationController {


    private final CopyOnWriteArrayList<HttpServletResponse> clients = new CopyOnWriteArrayList<>();

    @RequestMapping(value = "/subscribe", method = RequestMethod.GET)
    public void subscribe(HttpServletResponse response) throws IOException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Connection", "keep-alive");
//        clients.add(response);

        // 데이터를 보내는 부분을 제거
        // PrintWriter writer = response.getWriter();
        // writer.write("data: connected\n\n");
        // writer.flush();
        
        try {
        	  PrintWriter writer = response.getWriter();
              writer.write("data: connected\n\n");
              writer.flush();
        } catch (IOException e) {
            // 로그를 찍어 서버 오류를 확인합니다.
            System.err.println("Error writing to response: " + e.getMessage());
        }
    }

    @RequestMapping(value = "/new-post", method = RequestMethod.POST)
    @ResponseBody
    public void newPost(@RequestBody Post post) {
        // 새로운 글을 저장하는 로직 (DB 저장 등)
        // 예: postService.save(post);

        // 클라이언트로 알림 전송
        for (HttpServletResponse client : clients) {
            try {
                PrintWriter writer = client.getWriter();
                writer.write("data: " + post.getTitle() + "\n\n");
                writer.flush();
            } catch (IOException e) {
                clients.remove(client);
            }
        }
    }
}
