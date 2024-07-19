package kb.keyboard.warrior.util;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderUtil {
	
	   private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	    public static String encodePassword(String rawPassword) {
	        return passwordEncoder.encode(rawPassword);
	    }

	    public static boolean matches(String rawPassword, String encodedPassword) {  //입력한 패스워드 + DB에서 가져온 패스워드
	        return passwordEncoder.matches(rawPassword, encodedPassword);
	    }
	}