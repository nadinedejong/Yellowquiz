//Deze methode bevat algoritme om gasten goed te plaatsen. o.a., welke gasten zitten naast mekaar? 

package nl.youngcapital;

import java.util.ArrayList;
import java.util.List;

public class TafelSchikking {
	private List<Tafel> tafels = new ArrayList<>();
	private Gast[] gastOpStoelMax;
	private int opRelatie, opInteresse, gemengdManVrouw, opLeeftijd;
	
	public TafelSchikking(int totaalStoelen){
		this.gastOpStoelMax = new Gast[totaalStoelen];
	}
	
	public List<Tafel> getTafels() {
		return tafels;
	}

	public Gast[] getGastOpStoelMax() {
		return gastOpStoelMax;
	}

	public void setGastOpStoelMax(Gast[] gastOpStoel) {
		if (gastOpStoel.length != gastOpStoelMax.length){/*throw error */}
		for (int i=0; i<gastOpStoel.length; i++){
			if (gastOpStoel[i] == null){
				gastOpStoelMax[i] = null;
			} else {
				gastOpStoelMax[i] = gastOpStoel[i];
			}
		}		
	}

	public void setTafels(List<Tafel> tafels) {
		this.tafels = tafels;
	}
	
	public int calcScore(Iterable<Tafel> tafels, VoorkeurenLijst voorkeuren){
		int score = 0;
		int i = 0;
		
		for (Tafel t: tafels){
			List<Gast> gasten = t.getGasten();
			while (i<(gasten.size()-1)){
				Gast eerste = gasten.get(i);
				Gast tweede = gasten.get(i+1);
				score += gemengdManVrouw(eerste, tweede, voorkeuren);
				score += opLeeftijd(eerste, tweede, voorkeuren);
				score += opInteresse(eerste, tweede, voorkeuren);
				score += opRelatie(eerste, tweede, voorkeuren);
				i++;
			}
			if (t.getStoelen() > 2 && t.checkVol()){
				Gast eerste = gasten.get(0);
				Gast laatste = gasten.get(gasten.size()-1);
				/*laatste plek wordt met eerste vergeleken als alle stoelen bezet zijn en er meer dan 2 stoelen zijn*/ 
				score += gemengdManVrouw(eerste, laatste, voorkeuren);
				score += opLeeftijd(eerste, laatste, voorkeuren);
				score += opInteresse(eerste, laatste, voorkeuren);
				score += opRelatie(eerste, laatste, voorkeuren);
			}			
		}
		return score; 
	}	
	
	public int gemengdManVrouw(Gast g1, Gast g2, VoorkeurenLijst voorkeuren){
		int score = 0;
	
		if (g1.isVrouw() == g2.isVrouw()){
			score -=1;
		} else {
			score +=1; 
		}				
		if (voorkeuren.isManVrouw()) {score *= -1;} // true is hogere score wanneer zelfde geslacht bij mekaar		
		return voorkeuren.getFactManVrouw()*score; 
	}
	
	public int opLeeftijd(Gast g1, Gast g2, VoorkeurenLijst voorkeuren){
		int score = 0; 
		
		if (((double)Math.abs(g1.getLeeftijd()-g2.getLeeftijd()) / Math.max(g1.getLeeftijd(), g2.getLeeftijd())) < 0.30){
			score -=1;
		} else {
			score +=1;
		}		
		if (voorkeuren.isOpLeeftijd()) {score *=-1 ;} //true is hogere score bij gelijkere leeftijd		
		return voorkeuren.getFactOpLeeftijd()*score; 		
	}
	
	public int opInteresse(Gast g1, Gast g2, VoorkeurenLijst voorkeuren){
		int score = 0; 

		if (g1.getInteresse() == g2.getInteresse()){
			score -= 1;
		} else {
			score += 1;
		}
		
		if (voorkeuren.isInteresse()){score *=-1;} 		// true is hogere score wanneer zelfde interesse bij mekaar 		
		return voorkeuren.getFactInteresse()*score; 
	}
	
	public int opRelatie(Gast g1, Gast g2, VoorkeurenLijst voorkeuren){
		int score = 0; 

		if (g1.getRelatie() == g2.getRelatie()){
			score -= 1;
		} else {
			score += 1;
		}
		
		if (voorkeuren.isRelatie()){score *=-1;} // true is hogere score wanneer zelfde interesse bij mekaar 		
		return voorkeuren.getFactRelatie()*score; 
	}
}
