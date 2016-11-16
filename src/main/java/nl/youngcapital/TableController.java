package nl.youngcapital;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import nl.youngcapital.Gast;
import nl.youngcapital.GastenRepository;

@Controller
public class TableController {
	
	@Autowired
	private GastenRepository repo;
	
	//deze geeft de naam van de jsp file "hello" terug, want is geen responsebody
	@RequestMapping("/index")
	public String overzicht(Model model){
		model.addAttribute("gastenlijst", repo.findAll());
		return "Index";
	}
	
	@RequestMapping(value="/index", method=RequestMethod.POST)
	public String maakGast(String naam, int leeftijd, boolean vrouw){
		Gast b = new Gast();
		b.setNaam(naam);
		b.setLeeftijd(leeftijd);
		b.setVrouw(vrouw);
		repo.save(b);
		return "redirect:index";
	}
	
	@RequestMapping(value="/delete")
	public String deleteGast(long id, HttpServletResponse resp){
		Gast b = repo.findOne(id);
		if (b==null){
			resp.setStatus(404);
			return null; 
		}
		repo.delete(b);
		
		//redirect naar overzicht pagina, nieuwe get request. 
		return "redirect:index";
	}
	
	//deze geeft letterlijk de string "goulash" terug, want is een responsebody
	@RequestMapping("/pagina2")
	public @ResponseBody String eten(){
		return "Goulash";
	}
	
	
}