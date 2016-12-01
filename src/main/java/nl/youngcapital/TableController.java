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
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TableController {
	@Autowired
	private GastenRepository gastenRepo;
	
	@Autowired
	private TafelRepository tafelRepo; 
	
	@Autowired
	private EventRepository eventRepo;
	
	@RequestMapping("/index")
	public String overzicht(Model model, HttpSession session){
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
	public String overzicht2(Model model, HttpSession session){
		model.addAttribute("gastenlijst", gastenRepo.findAllByOrderById());
		model.addAttribute("tafels", tafelRepo.findAllByOrderById());
		model.addAttribute("events", eventRepo.findAll());
		VoorkeurenLijst voorkeuren = (VoorkeurenLijst)session.getAttribute("voorkeuren");
		model.addAttribute(voorkeuren);
		return "Definitief";
	}
	
	//gaat naar de laatste pagina met de tafelschikking, Nadine aangepast
	@RequestMapping(value="/tafelschikking")
	public String overzicht3(Model model){
		model.addAttribute("gastenlijst", gastenRepo.findAllByOrderById());
		model.addAttribute("tafels", tafelRepo.findAllByOrderById());
		return "Schikking";
	}	
	
	@RequestMapping(value="alletafels")
	public @ResponseBody Iterable<Tafel> alleTafels(){
		Iterable<Tafel> tafels = tafelRepo.findAllByOrderById();
		for (Tafel t: tafels){
			for (Gast g: t.getGasten()){
				System.out.println("check "+ g.getNaam());
			}
		}
		return tafelRepo.findAllByOrderById();		
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
		Iterable<Tafel> tafels = tafelRepo.findAll(); //maak lijst tafels en gasten 
		Iterable<Gast> gasten  = gastenRepo.findAll();
		int max_score = -1000000; 
		int iterations = 600; //aantal simulaties		
		int totaalStoelen=0; 
		for (Tafel t: tafels){totaalStoelen += t.getStoelen();} //totaal aantal stoelen berekenen
		Gast[] gastOpStoel = new Gast[totaalStoelen]; 
		TafelSchikking ts = new TafelSchikking(totaalStoelen); //berekent kwaliteit tafelschikking en bewaart beste configuratie
		ts.setGastOpStoelMax(gastOpStoel);		
		VoorkeurenLijst voorkeuren = new VoorkeurenLijst(); //initialisatie klasse waar voorkeuren worden opgeslagen voor schikking 
		if (session.getAttribute("voorkeuren") != null && session.getAttribute("voorkeuren") instanceof VoorkeurenLijst){
			voorkeuren = (VoorkeurenLijst)session.getAttribute("voorkeuren");
		} else {iterations=0;}	
		
		if (gastenRepo.count() > totaalStoelen){ // er zijn geen genoeg stoelen! geef melding
			return "meerstoelen";
		} else {  // plaats gasten RANDOMLY
			for (int l = 0; l<iterations; l++){	
				System.out.println("Iteratie "+l);
				clearIt(tafels, gasten, gastOpStoel); //lijsten leeggemaakt begin van iteratie			
				int k = 0;	
				int score = 0;
				for (Gast g: gasten){
					gastOpStoel[k++]= g; 
				}
				Collections.shuffle(Arrays.asList(gastOpStoel)); //genereer randomlijst met lengte aantal stoelen waar gasten op geplaatst worden					
				
				zetGastenAanTafels(gastOpStoel, tafels); //gasten worden aan de tafels gezet				
				score = ts.calcScore(tafels, voorkeuren); //kwaliteit schikking berekend aan de hand van voorkeuren
				System.out.println("Score is "+score);
				if (score > max_score){
					max_score = score;
					ts.setGastOpStoelMax(gastOpStoel); //configuratie met hoogste score wordt bewaard
					for(int z=0; z<gastOpStoel.length; z++){
						if (gastOpStoel[z] != null){
							System.out.println(gastOpStoel[z].getNaam());
						} else {System.out.println("nullo");}			
					}
				}
			}
			System.out.println("maxscore is "+max_score);
			clearIt(tafels, gasten, gastOpStoel);
			zetGastenAanTafels(ts.getGastOpStoelMax(), tafels); // configuratie met hoogste score wordt aan tafels gezet.
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
			gastOpStoel[i] = null; 
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