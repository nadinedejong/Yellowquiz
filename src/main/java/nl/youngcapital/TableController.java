package nl.youngcapital;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TableController {
	
	@Autowired
	private GastenRepository repo;
	
	@Autowired
	private TafelRepository tafelRepo; 
	
	@RequestMapping("/index")
	public String overzicht(Model model){
		model.addAttribute("gastenlijst", repo.findAll());
		model.addAttribute("tafels", repo.findAll());
		return "Index";
	}
	
	@RequestMapping(value="/index", method=RequestMethod.POST)
	public String maakTafel(int stoelen){
		Tafel t = new Tafel();
		t.setStoelen(stoelen);
		tafelRepo.save(t);
		return "redirect:index";
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
	
	//dit is onzin
	//deze geeft letterlijk de string "goulash" terug, want is een responsebody
	@RequestMapping("/pagina2")
	public @ResponseBody String eten(){
		return "Goulash";
	}
	
	@RequestMapping(value="/accomodatie")
	public String accomodatie(Model model){
		return "ruimte";
	}

	@RequestMapping(value="/accomodatie", method=RequestMethod.POST)
	public String maakRuimte(int aantalTafels){
		Ruimte zaal = new Ruimte();
		zaal.setAantalTafels(aantalTafels);
		return "ruimte2";
	}
	
	
}