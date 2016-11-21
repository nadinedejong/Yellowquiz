//Deze methode bevat algoritme om gasten goed te plaatsen. o.a., welke gasten zitten naast mekaar? 

package nl.youngcapital;

import java.util.ArrayList;
import java.util.List;

public class TafelSchikking {
	private List<Tafel> tafels = new ArrayList<>();

	public List<Tafel> getTafels() {
		return tafels;
	}

	public void setTafels(List<Tafel> tafels) {
		this.tafels = tafels;
	}
	
	public int gemengd(Gast g1, Gast g2){
		int score = 0;
		
		if (g1.isVrouw() == g2.isVrouw()){
			score -=1;
		} else {
			score +=1; 
		}
		
		return score; 
	}
	
	public int tafelScore(Iterable<Tafel> tafels){
		int score = 0;
		int i = 0;
		
		for (Tafel t: tafels){
			List<Gast> gasten = t.getGasten();
			while (i<(gasten.size()-1)){
				score += gemengd(gasten.get(i), gasten.get(++i));
			}
			if (t.checkVol() && t.getStoelen() > 2){ /*laatste plek wordt met eerste vergeleken als alle stoelen bezet zijn */ 
				score += gemengd(gasten.get(0), gasten.get(i));
			}			
		}
		return score; 
	}	
}
