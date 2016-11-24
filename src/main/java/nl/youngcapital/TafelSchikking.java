//Deze methode bevat algoritme om gasten goed te plaatsen. o.a., welke gasten zitten naast mekaar? 

package nl.youngcapital;

import java.util.ArrayList;
import java.util.List;

public class TafelSchikking {
	private List<Tafel> tafels = new ArrayList<>();
	private Gast[] gastOpStoelMax;
	
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
	
	public int gemengdManVrouw(Gast g1, Gast g2){
		int score = 0;
		
		if (g1.isVrouw() == g2.isVrouw()){
			score -=1;
		} else {
			score +=1; 
		}		
		return score; 
	}
	
	public int opLeeftijd(Gast g1, Gast g2){
		int score = 0; 
		
		System.out.println(" opleeftijd berekening "+Math.abs(g1.getLeeftijd()-g2.getLeeftijd()));
		score = -Math.abs(g1.getLeeftijd()-g2.getLeeftijd());
			
		return score; 		
	}
	
	public int calcScore(Iterable<Tafel> tafels){
		int score = 0;
		int i = 0;
		
		for (Tafel t: tafels){
			List<Gast> gasten = t.getGasten();
			while (i<(gasten.size()-1)){
				if (gasten.get(i) != null && gasten.get(i+1) != null){
					score += gemengdManVrouw(gasten.get(i), gasten.get(i+1));
					score += opLeeftijd(gasten.get(i), gasten.get(i+1));
					i++;
				}
			}
			if (t.getStoelen() > 2 && gasten.get(0) != null && gasten.get(i) !=null){ 
				/*laatste plek wordt met eerste vergeleken als alle stoelen bezet zijn en er meer dan 2 stoelen zijn*/ 
				score += gemengdManVrouw(gasten.get(0), gasten.get(i));
				System.out.println("Score is voor gemengd"+score);
				score += opLeeftijd(gasten.get(0), gasten.get(i));
				System.out.println("Score is voor gemengd + opleeftijd "+score);
			}			
		}
		return score; 
	}	
}
