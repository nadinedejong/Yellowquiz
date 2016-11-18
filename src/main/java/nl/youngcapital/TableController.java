package nl.youngcapital;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
		b = gastenRepo.save(b);
		
//		Tafel tafel = tafelRepo.findOne(2L);
//		tafel.plaatsGast(b);
//		b = gastenRepo.save(b);
//		tafel = tafelRepo.save(tafel);
		return "redirect:index"; 
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
	
	public boolean zetGastAanTafel(Gast g, Tafel t){
		if (t.getStoelen() > t.getGasten().size()){
			t.plaatsGast(g);
			g.setTafel(t);
			g = gastenRepo.save(g);
			t = tafelRepo.save(t);
			return true;
		}	else {return false;}
	}	

	
	@RequestMapping(value="/plaatsGasten")
	public String plaatsGasten(){
		int totaalStoelen=0; 
		Iterable<Tafel> tafels = tafelRepo.findAllByOrderById();
		Iterable<Gast> gasten = gastenRepo.findAllByOrderById();
		
		for (Tafel t: tafels){
			totaalStoelen += t.getStoelen();
		}
		if (gastenRepo.count() > totaalStoelen){
			// er zijn geen genoeg stoelen!!!
		} else { // plaats gasten aan tafels
			for (Tafel t: tafels){
				for (Gast g: gasten){
					if (zetGastAanTafel(g, t)== false) break;
				}
			}
		}
		return "redirect:index";
	}	
	
	public static int getLength(Iterable<Gast> list){
		int size = 0;
		for(Gast value : list) {
		   size++;
		}
		return size;
	}
}