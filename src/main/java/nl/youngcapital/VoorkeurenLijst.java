package nl.youngcapital;

public class VoorkeurenLijst {
	private boolean manVrouw=true; //true is zelfde geslacht bij mekaar 
	private boolean opLeeftijd=true; //true is zelfde leeftijd bij mekaar
	private boolean interesse=true; //true is zelfde interesse bij mekaar
	private boolean relatie=true; //true is gelijke relaties bij mekaar
	
	private int factManVrouw =0;
	private int factOpLeeftijd =0;
	private int factInteresse =0;
	private int factRelatie =0;
	
	public boolean isManVrouw() {
		return manVrouw;
	}
	public void setManVrouw(int factManVrouw, boolean manVrouw) {
		this.factManVrouw = factManVrouw; 
		this.manVrouw = manVrouw;
	}
	public boolean isOpLeeftijd() {
		return opLeeftijd;
	}
	public void setOpLeeftijd(int factOpLeeftijd, boolean opLeeftijd) {
		this.opLeeftijd = opLeeftijd;
		this.factOpLeeftijd = factOpLeeftijd;
	}
	public boolean isInteresse() {
		return interesse;
	}
	public void setInteresse(int factInteresse, boolean interesse) {
		this.interesse = interesse;
		this.factInteresse = factInteresse;
	}
	public boolean isRelatie() {
		return relatie;
	}
	public void setRelatie(int factRelatie, boolean relatie) {
		this.relatie = relatie;
		this.factRelatie = factRelatie; 
	}
	public int getFactManVrouw() {
		return factManVrouw;
	}
	public void setFactManVrouw(int factManVrouw) {
		this.factManVrouw = factManVrouw;
	}
	public int getFactOpLeeftijd() {
		return factOpLeeftijd;
	}
	public void setFactOpLeeftijd(int factOpLeeftijd) {
		this.factOpLeeftijd = factOpLeeftijd;
	}
	public int getFactInteresse() {
		return factInteresse;
	}
	public void setFactInteresse(int factInteresse) {
		this.factInteresse = factInteresse;
	}
	public int getFactRelatie() {
		return factRelatie;
	}
	public void setFactRelatie(int factRelatie) {
		this.factRelatie = factRelatie;
	}
	

}
