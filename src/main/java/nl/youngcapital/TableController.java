package nl.youngcapital;


import java.time.LocalDate;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	@Autowired
	private EventRepository eventRepo;
	
	@RequestMapping("/index")
	public String overzicht(Model model){
		model.addAttribute("events", eventRepo.findAll());
		model.addAttribute("gastenlijst", gastenRepo.findAllByOrderById());
		model.addAttribute("tafels", tafelRepo.findAllByOrderById()); 
		return "Index";
	}
	
	@RequestMapping(value="/maakTafel", method=RequestMethod.POST)
	public String maakTafel(int stoelen){
		Tafel t = new Tafel(stoelen);
		tafelRepo.save(t);
		return "redirect:index";
		}
		
	@RequestMapping(value="/maakGast", method=RequestMethod.POST)
	public String voegToe(String naam, int leeftijd, boolean vrouw, int interesse, int relatie){
		Gast b = new Gast();
		b.setNaam(naam);
		b.setLeeftijd(leeftijd);
		b.setVrouw(vrouw);
		b.setInteresse(interesse);
		b.setRelatie(relatie);
		b = gastenRepo.save(b);
		return "redirect:index"; 
	}
	
	//Evenement aanmaken
	@RequestMapping(value="/maakEvent", method=RequestMethod.POST)
	public String maakEvent(Model model, String naam, String datum, boolean sorteergeslacht){
		Event e = new Event();
		e.setNaam(naam);
		LocalDate parsedDate = LocalDate.parse(datum);
		e.setDatum(parsedDate);
		e.setSorteergeslacht(sorteergeslacht);
		//model.addAttribute("events", eventRepo.findAll());
		e = eventRepo.save(e);
		return "redirect:index"; 
	}
	@RequestMapping(value="/aanpassenEvent")
	public String aanpassenEvent(HttpServletResponse resp,  String naam, String datum, boolean sorteergeslacht){
		Event e;
		try{ 
			e = eventRepo.findAllByOrderById().get(0);
			
		} catch (Exception ex){
			e = new Event();
		}
		e.setNaam(naam);
		LocalDate parsedDate = LocalDate.parse(datum);
		e.setDatum(parsedDate);
		e.setSorteergeslacht(sorteergeslacht);
		e = eventRepo.save(e);
		
		return "redirect:index";
	}
	
	//gaat naar de tweede pagina waar de gegevens worden gecontroleerd, Nadine aangepast
	@RequestMapping(value="/gegevens-controleren")
	public String overzicht2(Model model){
		model.addAttribute("gastenlijst", gastenRepo.findAllByOrderById());
		model.addAttribute("tafels", tafelRepo.findAllByOrderById());
		return "Definitief";
	}
	
	//gaat naar de laatste pagina met de tafelschikking, Nadine aangepast
	@RequestMapping(value="/tafelschikking")
	public String overzicht3(Model model){
		model.addAttribute("gastenlijst", gastenRepo.findAllByOrderById());
		model.addAttribute("tafels", tafelRepo.findAllByOrderById());
		return "Schikking";
	}
	
	
		
	@RequestMapping(value="/deleteGast")
	public String deleteGast(long id, HttpServletResponse resp){
		Gast b = gastenRepo.findOne(id);
		if (b==null){
			resp.setStatus(404);
			return null; 
		}
		gastenRepo.delete(b);	
		return "redirect:index";
	}
	
	@RequestMapping(value="/deleteTafel")
	public String deleteTafel(long id, HttpServletResponse resp){
		Tafel t = tafelRepo.findOne(id);
		if (t==null){
			resp.setStatus(404);
			return null; 
		}
		List<Gast> gasten = t.getGasten();
		for (Gast g: gasten){
			g.setTafel(null); 
		}
		tafelRepo.delete(t);	
		//redirect naar overzicht pagina, nieuwe get request. 
		return "redirect:index";
	}
	
	@RequestMapping(value="/plaatsGasten")
	public String plaatsGasten(Model model, HttpSession session){
		model.addAttribute("gastenlijst", gastenRepo.findAllByOrderById());
		model.addAttribute("tafels", tafelRepo.findAllByOrderById());
		//maak lijst tafels en gasten 
		Iterable<Tafel> tafels = tafelRepo.findAll();
		Iterable<Gast> gasten  = gastenRepo.findAll();
	
		int totaalStoelen=0; 
		for (Tafel t: tafels){totaalStoelen += t.getStoelen();} //totaal aantal stoelen berekenen
		Gast[] gastOpStoel = new Gast[totaalStoelen];
		TafelSchikking ts = new TafelSchikking(totaalStoelen);
		ts.setGastOpStoelMax(gastOpStoel);
		
//		if (session.getAttribute("voorkeuren") != null && session.getAttribute("voorkeuren") instanceof VoorkeurenLijst){
			VoorkeurenLijst voorkeuren = (VoorkeurenLijst)session.getAttribute("voorkeuren");
//		} else { /* throw error */ return "redirect:index";}
	
		int max_score = -10000;
		int iterations = 10; 
		
		if (gastenRepo.count() > totaalStoelen){ // er zijn meer gasten dan stoelen!! geef een melding.
		} else {  // plaats gasten RANDOMLY
			for (int l = 0; l<iterations; l++){
				System.out.println("ITERATIE "+l);		
				clearIt(tafels, gasten, gastOpStoel);				
				int k = 0;	
				for (Gast g: gasten){
					gastOpStoel[k++]= g;
				}
				Collections.shuffle(Arrays.asList(gastOpStoel)); //genereer randomlijst met lengte aantal stoelen waar gasten op geplaatst worde					
				
				zetGastenAanTafels(gastOpStoel, tafels); //gasten worden random aan de tafels gezet
				int score = 0;
				score = ts.calcScore(tafels, voorkeuren);
				if (score > max_score){
					max_score = score;
					ts.setGastOpStoelMax(gastOpStoel); //configuratie met hoogste score wordt opgeslagen in Tafelschikking klasse
				}
			}
			clearIt(tafels, gasten, gastOpStoel);
			zetGastenAanTafels(ts.getGastOpStoelMax(), tafels); // configuratie met hoogste score wordt aan tafels gezet.
			for (int i=0; i<ts.getGastOpStoelMax().length;i++){
				if (ts.getGastOpStoelMax()[i] != null){System.out.println(ts.getGastOpStoelMax()[i].isVrouw());}
			}
		}
		return "Schikking";
	}
	
	@RequestMapping(value="/zetVoorkeuren", method=RequestMethod.POST)
	public String zetVoorkeuren(boolean manVrouw, boolean opLeeftijd, boolean interesse, boolean relatie,  
			int factManVrouw, int factOpLeeftijd, int factInteresse, int factRelatie,  HttpSession session){
		VoorkeurenLijst voorkeuren = new VoorkeurenLijst();
		voorkeuren.setManVrouw(factManVrouw, manVrouw);
		voorkeuren.setInteresse(factInteresse, interesse);
		voorkeuren.setRelatie(factRelatie, relatie);
		voorkeuren.setOpLeeftijd(factOpLeeftijd, opLeeftijd);
		session.setAttribute("voorkeuren", voorkeuren);
		System.out.println("voorkeurenlijst: "+voorkeuren.getFactInteresse()+voorkeuren.isInteresse());
		return "redirect:index";
	}
	
	public void clearIt(Iterable<Tafel> tafels, Iterable<Gast> gasten, Gast[] gastOpStoel){
		for (Tafel t: tafels){
			t.getGasten().clear();
		} 
		for (Gast g: gasten){
			g.setTafel(null);
		}
		for (int i = 0; i<gastOpStoel.length; i++){
			gastOpStoel[i] = null; // empty is true
		}
	}

	public void zetGastenAanTafels(Gast[] gastOpStoel, Iterable<Tafel> tafels){
		int i=0;
		for (Tafel t: tafels){ // zet de lijst met gasten aan de tafels
			for(int j=0; j<t.getStoelen(); j++, i++){
				if (gastOpStoel[i] != null){
					if (!zetGastAanTafel(gastOpStoel[i], t)){ };//throw error 
					gastOpStoel[i].setStoelNr(j);
				} 
			}
		}
	}
	
	public boolean zetGastAanTafel(Gast g, Tafel t){
		if (t.getStoelen() > t.getGasten().size()){ 
			t.plaatsGast(g);		
			g.setTafel(t);
			g = gastenRepo.save(g);
			t = tafelRepo.save(t);
			return true;
		} else {
			return false;
		}
	}
}