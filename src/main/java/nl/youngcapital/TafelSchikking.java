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
	
	public int match(Gast g1, Gast g2){
		int score = 0;
		
		return score; 
	}
	
	public int tafelScore(Tafel t){
		int score = 0;
		int i = 0;
		List<Gast> gasten = t.getGasten();
		
		while (i<(gasten.size()-1)){
			score += match(gasten.get(i), gasten.get(++i)); 
		}
		if (t.checkVol()){ /*laatste plek wordt met eerste vergeleken als alle stoelen bezet zijn */ 
			score += match(gasten.get(0), gasten.get(i));
		}
		return score; 
	}	
}
