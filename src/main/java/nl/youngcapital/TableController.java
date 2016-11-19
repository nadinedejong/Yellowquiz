package nl.youngcapital;

import java.util.Iterator;
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
		model.addAttribute("gastenlijst", gastenRepo.findAll());
		model.addAttribute("tafels", tafelRepo.findAll());
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
		Iterable<Tafel> tafels = tafelRepo.findAllByOrderById();
		Iterable<Gast> gasten  = gastenRepo.findAllByOrderById();
		int iterations = 5; 
		
		int totaalStoelen=0; 
		for (Tafel t: tafels){totaalStoelen += t.getStoelen();}
		
		if (gastenRepo.count() > totaalStoelen){ // er zijn meer gasten dan stoelen!! geef een melding.
		} else {  // plaats gasten randomly
			int max_score = 0;
			int score = 0;
			for (int i = 0; i<iterations; i++){
				for (Tafel t: tafels){t.getGasten().clear();}//gastenlijst per tafel leegmaken
				for (Gast g: gasten){	
					int stoelNr = 0;
					for (Tafel t: tafels){
						int randomStoel = (int)(Math.random() * totaalStoelen);// zitplaats gast random
						stoelNr += t.getStoelen(); //aan welke tafel staat deze stoel? 
						if (randomStoel <= stoelNr) { //gast komt aan deze tafel te zitten als er plek is
							if (zetGastAanTafel(g, t)) break; //gast is geplaatst if true, kunnen naar volgende gast
						}
					}		
				}
				//update score, code nog schrijven
				if (score > max_score){/*bewaar deze tafelschikking*/}
				System.out.println("Iteratie "+i);  //log
				for (Tafel t: tafels){//log
					System.out.println("Tafel ID is " + t.getId() +", gastenlijst:");//log
					for (int z=0; z<t.getGasten().size(); z++)//log
						System.out.println("stoelnr: " + z+" naam is: "+ t.getGasten().get(z).getNaam());//log
				}//log
			}
		}
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
}