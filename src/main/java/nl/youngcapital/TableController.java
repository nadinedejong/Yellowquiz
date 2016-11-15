package nl.youngcapital;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TableController {

	
	//deze geeft de naam van de jsp file "hello" terug, want is geen responsebody
	@RequestMapping("/indextest")
	public String helloWorld(Model model){
		model.addAttribute("naam", "nadine");
		return "Index";
	}
	
	
	//deze geeft letterlijk de string "goulash" terug, want is een responsebody
	@RequestMapping("/pagina2")
	public @ResponseBody String eten(){
		return "Goulash";
	}
	
}