package nl.youngcapital;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

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
	public String voegToe(String naam, int leeftijd, boolean vrouw){
		Gast b = new Gast();
		b.setNaam(naam);
		b.setLeeftijd(leeftijd);
		b.setVrouw(vrouw);
		b = gastenRepo.save(b);
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
	public String plaatsGasten(){
		//maak lijst tafels en gasten 
		Iterable<Tafel> tafels = tafelRepo.findAll();
		Iterable<Gast> gasten  = gastenRepo.findAll();
	
		int totaalStoelen=0; 
		for (Tafel t: tafels){totaalStoelen += t.getStoelen();} //totaal aantal stoelen berekenen
		Gast[] gastOpStoel = new Gast[totaalStoelen];
		TafelSchikking ts = new TafelSchikking(totaalStoelen);
		ts.setGastOpStoelMax(gastOpStoel);
		
		int max_score = -10000;
		int iterations = 100; 
		
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
				score = ts.calcScore(tafels);
				System.out.println("Score is "+score);
				if (score > max_score){
					max_score = score;
					ts.setGastOpStoelMax(gastOpStoel); //configuratie met hoogste score wordt opgeslagen in Tafelschikking klasse
					System.out.println("Print ts.gastopstoelmax array met hoogste score");
					for (int i=0; i<ts.getGastOpStoelMax().length;i++){
						System.out.println(ts.getGastOpStoelMax()[i].isVrouw());
					}
				}
			}
			clearIt(tafels, gasten, gastOpStoel);
			zetGastenAanTafels(ts.getGastOpStoelMax(), tafels); // configuratie met hoogste score wordt aan tafels gezet.
			ts.setMaxScore(max_score); //onnodig?
			System.out.println("max score is "+ max_score+ ", en dit is configuratie met hoogste score uiteindelijk;");
			for (int i=0; i<ts.getGastOpStoelMax().length;i++){
				if (ts.getGastOpStoelMax()[i] != null){System.out.println(ts.getGastOpStoelMax()[i].isVrouw());}
			}
		}
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
	
	public void clearIt(Iterable<Tafel> tafels, Iterable<Gast> gasten){
		for (Tafel t: tafels){
			t.getGasten().clear();
		} 
		for (Gast g: gasten){
			g.setTafel(null);
		}
	}
	
	public void zetGastenAanTafels(Gast[] gastOpStoel, Iterable<Tafel> tafels){
		System.out.println("lengte gastOpStoel array is "+ gastOpStoel.length);
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