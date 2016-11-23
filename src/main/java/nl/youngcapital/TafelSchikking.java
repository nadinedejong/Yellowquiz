//Deze methode bevat algoritme om gasten goed te plaatsen. o.a., welke gasten zitten naast mekaar? 

package nl.youngcapital;

import java.util.ArrayList;
import java.util.List;

public class TafelSchikking {
	private int totaalStoelen;
	private int maxScore;
	private List<Tafel> tafels = new ArrayList<>();
	private Gast[] gastOpStoelMax;
	
	public int getMaxScore() {
		return maxScore;
	}

	public void setMaxScore(int maxScore) {
		this.maxScore = maxScore;
	}

	public TafelSchikking(int totaalStoelen){
		this.totaalStoelen = totaalStoelen;
		this.gastOpStoelMax = new Gast[totaalStoelen];
	}
	
	public List<Tafel> getTafels() {
		return tafels;
	}

	public int getTotaalStoelen() {
		return totaalStoelen;
	}

	public void setTotaalStoelen(int totaalStoelen) {
		this.totaalStoelen = totaalStoelen;
	}

	public Gast[] getGastOpStoelMax() {
		return gastOpStoelMax;
	}

	public void setGastOpStoelMax(Gast[] gastOpStoel) {
		if (gastOpStoel.length != gastOpStoelMax.length){System.out.println("FOUT "); return;}
		System.out.println("hoogste score wordt gezet, setter gastopstoel in tafelschikking");
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
	
	public int gemengd(Gast g1, Gast g2){
		int score = 0;
		
		if (g1.isVrouw() == g2.isVrouw()){
			score -=1;
		} else {
			score +=1; 
		}		
		return score; 
	}
	
	public int calcScore(Iterable<Tafel> tafels){
		int score = 0;
		int i = 0;
		
		for (Tafel t: tafels){
			List<Gast> gasten = t.getGasten();
			while (i<(gasten.size()-1)){
				if (gasten.get(i) != null && gasten.get(i+1) != null){
					score += gemengd(gasten.get(i), gasten.get(++i));
				}
			}
			if (t.getStoelen() > 2 && gasten.get(0) != null && gasten.get(i) !=null){ 
				/*laatste plek wordt met eerste vergeleken als alle stoelen bezet zijn en er meer dan 2 stoelen zijn*/ 
				score += gemengd(gasten.get(0), gasten.get(i));
			}			
		}
		return score; 
	}	
}
