package nl.youngcapital;

public class Tafel {

	private int aantalZitplaatsen;
	
	public Tafel(int aantalZitplaatsen){
		this.aantalZitplaatsen = aantalZitplaatsen;
	}
	
	public static void main(String[] args){
		int aantalTafels = 3;
		
		Tafel t0 = new Tafel(4);
		Tafel t1 = new Tafel(5);
		Tafel t2 = new Tafel(6); 
		
		//array van tafels, naam tafels
		Tafel[] tafels = {t0, t1, t2};
		
		//plek is 2 dimensionale array, eerste index is tafelnummer, tweede is stoelnummer 
		int[][] plek = new int[aantalTafels][];
		
		for (int i=0; i<tafels.length; i++){
			plek[i] = new int[tafels[i].aantalZitplaatsen];
			System.out.println("Tafel "+ i +"Aantal stoelen "+ tafels[i].aantalZitplaatsen);
		}
	}
}
