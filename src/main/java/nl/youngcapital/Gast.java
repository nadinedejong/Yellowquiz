package nl.youngcapital;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Entity;   //gecopypaste

@Entity
public class Gast {
	private String naam; 
	private int leeftijd; 
	private boolean vrouw;
	private long id; 
	
//	private long tafel_id; 
	
//	public long getTafel_id() {
//		return tafel_id;
//	}
//	public void setTafel_id(long tafel_id) {
//		this.tafel_id = tafel_id;
//	}
	//database ID van bloem. Hibernate genereert onze IDs. 
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public boolean isVrouw() {
		return vrouw;
	}
	public void setVrouw(boolean vrouw) {
		this.vrouw = vrouw;
	}
	public String getNaam() {
		return naam;
	}
	public void setNaam(String naam) {
		this.naam = naam;
	}
	public int getLeeftijd() {
		return leeftijd;
	}
	public void setLeeftijd(int leeftijd) {
		this.leeftijd = leeftijd;
	}
	
	
	
}
