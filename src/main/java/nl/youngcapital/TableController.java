package nl.youngcapital;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.assertj.core.util.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TableController {
	
	
	@Autowired
	private GastenRepository gastenRepo;
	
	@Autowired
	private TafelRepository tafelRepo; 
	
	@RequestMapping("/index")
	public String overzicht(Model model){
		model.addAttribute("gastenlijst", gastenRepo.findAll());
		model.addAttribute("tafels", tafelRepo.findAll());
		return "Index";
	}
	
	@RequestMapping(value="/maakTafel", method=RequestMethod.POST)
	public String maakTafel(int stoelen){
		Tafel t = new Tafel();
		t.setStoelen(stoelen);
		tafelRepo.save(t);
//		t.getGasten().add(e);
		return "redirect:index";
		}
	
	@RequestMapping(value="/deleteTafel")
	public String deleteTafel(long id, HttpServletResponse resp){
		Tafel t = tafelRepo.findOne(id);
		if (t==null){
			resp.setStatus(404);
			return null; 
		}
		tafelRepo.delete(t);	
		//redirect naar overzicht pagina, nieuwe get request. 
		return "redirect:index";
	}

	
	@RequestMapping(value="/maakGast", method=RequestMethod.POST)
	public String voegToe(String naam, int leeftijd, boolean vrouw){
		Gast b = new Gast();
		b.setNaam(naam);
		b.setLeeftijd(leeftijd);
		b.setVrouw(vrouw);
		gastenRepo.save(b);
		gastAanTafel(4l, 4l);
		return "redirect:index"; 
	}
	
	//experimentje!!! 
	@RequestMapping(value="/zetGastAanTafel", method=RequestMethod.POST)
	public String gastAanTafel(long tafel_id, long gast_id){
		Tafel t = tafelRepo.findOne(tafel_id);
		Gast g = gastenRepo.findOne(gast_id);
		t.getGasten().add(g);
		tafelRepo.save(t);
		return "redirect:index";
		
		//crasht op deze regel:
//		ArrayList<Gast> myList = Lists.newArrayList(myIterator);
		
//		Tafel t = tafelRepo.findOne(id); 
//		t.setGasten(myList);
//		tafelRepo.save(t);
	}
	
	@RequestMapping(value="/deleteGast")
	public String deleteGast(long id, HttpServletResponse resp){
		Gast b = gastenRepo.findOne(id);
		if (b==null){
			resp.setStatus(404);
			return null; 
		}
		gastenRepo.delete(b);	
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