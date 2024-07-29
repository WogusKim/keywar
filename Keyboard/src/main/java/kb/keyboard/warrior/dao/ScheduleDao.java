package kb.keyboard.warrior.dao;

import java.util.List;
import java.util.Map;

import kb.keyboard.warrior.dto.ScheduleDTO;

public interface ScheduleDao {
		
    void scheduleNew(ScheduleDTO dto);
    List<ScheduleDTO> scheduleLoad(String userno);
    int scheduleEdit(ScheduleDTO dto);
    void scheduleDelete(String scheduleid);
	List<Map<String, String>> loadCustomShareto(String userno);
}
