package kb.keyboard.warrior.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kb.keyboard.warrior.dto.ScheduleDTO;

public interface ScheduleDao {
		
    void scheduleNew(ScheduleDTO dto);
    List<ScheduleDTO> scheduleLoad(String userno);
    int scheduleEdit(ScheduleDTO dto);
    void scheduleDelete(String scheduleid);
	List<Map<String, String>> loadCustomShareto(String userno);
	int checkGroupName(String groupName);
//	List<Map<String, String>> searchUser(Map<String, Object> params);
	List<Map<String, String>> searchUser(@Param("searchUsername") String searchUsername, @Param("userno") String userno);
	void saveGroup(List<Map<String, String>> groupData);
//	void saveSelf(String userno);
	void saveSelf(@Param("userno") String userno);
	void leaveGroup(@Param("groupId") String groupId, @Param("userno") String userno);
	void alertInsertCalendar(Map<String, Object> params);
	List<ScheduleDTO> countTodoList(@Param("userno") String userno);
	List<ScheduleDTO> getUserGroups(@Param("userno") String userno);
	List<Map<String, String>> searchUsersForInvite(@Param("searchUsername") String searchUsername, @Param("userno") String userno, @Param("groupNum") String groupNum);
    void inviteUsersToGroup(List<Map<String, Object>> paramsList);
    void alertInsertCalendarForInvite(List<Map<String, Object>> paramsList);
    

}
