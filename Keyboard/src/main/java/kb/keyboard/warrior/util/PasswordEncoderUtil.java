package kb.keyboard.warrior.util;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderUtil {
	
	   private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	    public static String encodePassword(String rawPassword) {
	        return passwordEncoder.encode(rawPassword);
	    }

	    public static boolean matches(String rawPassword, String encodedPassword) {  //�Է��� �н����� + DB���� ������ �н�����
	        return passwordEncoder.matches(rawPassword, encodedPassword);
	    }
	}