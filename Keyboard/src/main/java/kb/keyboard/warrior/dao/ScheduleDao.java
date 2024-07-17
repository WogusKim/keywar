package kb.keyboard.warrior.dao;

import java.util.List;

import kb.keyboard.warrior.dto.ScheduleDTO;

public interface ScheduleDao {
		
    void scheduleNew(ScheduleDTO dto);
    List<ScheduleDTO> scheduleLoad(String userno);
    void scheduleEdit(ScheduleDTO dto);
    void scheduleDelete(String scheduleid);
	
}
