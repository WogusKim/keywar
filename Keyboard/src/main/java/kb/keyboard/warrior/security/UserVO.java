package kb.keyboard.warrior.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
 
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
 
public class UserVO implements UserDetails{
 
    private int member_id;
    private String user_id;
    private String user_pw;
    private String user_email;
    private Date create_date;
    private Date update_date;
    private boolean act_flg;
    private boolean del_flg;
    private String grant_name;
    
    public int getMember_id() {
        return member_id;
    }
    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }
    public String getUser_id() {
        return user_id;
    }
    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
    public String getUser_pw() {
        return user_pw;
    }
    public void setUser_pw(String user_pw) {
        this.user_pw = user_pw;
    }
    public String getUser_email() {
        return user_email;
    }
    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }
    public Date getCreate_date() {
        return create_date;
    }
    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }
    public Date getUpdate_date() {
        return update_date;
    }
    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }
    public boolean isAct_flg() {
        return act_flg;
    }
    public void setAct_flg(boolean act_flg) {
        this.act_flg = act_flg;
    }
    public boolean isDel_flg() {
        return del_flg;
    }
    public void setDel_flg(boolean del_flg) {
        this.del_flg = del_flg;
    }
    
    public String getGrant_name() {
        return grant_name;
    }
    public void setGrant_name(String grant_name) {
        this.grant_name = grant_name;
    }
    @Override
    public String toString() {
        return "MemberVO [member_id=" + member_id + ", user_id=" + user_id + ", user_pw=" + user_pw + ", user_email="
                + user_email + ", create_date=" + create_date + ", update_date=" + update_date + ", act_flg=" + act_flg
                + ", del_flg=" + del_flg + "]";
    }
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        
        String roleGrant = "ROLE_" + grant_name;
        
        GrantedAuthority myGrant = new SimpleGrantedAuthority(roleGrant);
        
        List<GrantedAuthority> authorities = new ArrayList<>();
        
        authorities.add(myGrant);
        
        return authorities;
    }
    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return user_pw;
    }
    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return user_id;
    }
    @Override
    public boolean isAccountNonExpired() {
        // TODO Auto-generated method stub
        return false;
    }
    @Override
    public boolean isAccountNonLocked() {
        // TODO Auto-generated method stub
        return false;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        // TODO Auto-generated method stub
        return false;
    }
    @Override
    public boolean isEnabled() {
        // TODO Auto-generated method stub
        return false;
    }
    
}
 
