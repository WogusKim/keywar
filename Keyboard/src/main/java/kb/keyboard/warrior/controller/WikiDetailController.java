package kb.keyboard.warrior.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;
import kb.keyboard.warrior.dao.EditorDao;
import kb.keyboard.warrior.dto.EditorDTO;

@Controller
public class WikiDetailController {
    @Autowired
    private EditorDao editorDAO;

    @RequestMapping(value = "/saveEditorData", method = RequestMethod.POST)
    @ResponseBody
    public String saveEditorData(@RequestBody EditorDTO editor) {
        editorDAO.insertEditor(editor);
        return "Data saved successfully";
    }

    @RequestMapping(value = "/loadEditorData", method = RequestMethod.GET)
    @ResponseBody
    public EditorDTO loadEditorData(int id) {
        return editorDAO.selectEditorById(id);
    }
}
