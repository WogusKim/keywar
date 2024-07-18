package kb.keyboard.warrior.security;
 
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
 
import kb.keyboard.warrior.dto.UserDTO;
 
@Service
public class CustomUserDetailsService implements UserDetailsService {
 
	@Autowired
	public SqlSession sqlSession;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDetails userInfo = null;
        try {
            int member_id = dao.selectMemberID(username);
            userInfo = (UserDetails) dao.selectMember(member_id); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return userInfo;
    }
    
 
}