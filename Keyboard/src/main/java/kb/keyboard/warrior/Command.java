package kb.keyboard.warrior;

import org.springframework.ui.Model;

public interface Command {

	void execute(Model model);
}
