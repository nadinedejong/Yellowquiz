package nl.youngcapital;

import javax.persistence.Entity;   
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Gast {
	private String naam; 
	private int leeftijd; 
	private boolean vrouw;
	private long id; 
	private Tafel tafel;
	private Event event;
	
	@ManyToOne()
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}
	@ManyToOne()
	public Tafel getTafel() {
		return tafel;
	}
	public void setTafel(Tafel tafel) {
		this.tafel = tafel;
	}
	
	public Gast(){}

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
