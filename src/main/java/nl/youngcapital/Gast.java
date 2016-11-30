package nl.youngcapital;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Gast {
	private String naam; 
	private long id; 
	private Tafel tafel;
	private Event event;
	private int stoelNr;
	private boolean empty; 

	private int leeftijd; 
	private boolean vrouw;	
	private int relatie; 
	private int interesse; 
	
	public static final int FAM = 0;
	public static final int VR = 1;
	public static final int COL = 2;
	
	public static final int VOETBAL = 0;
	public static final int LEGO = 1;
	public static final int GTST = 2;
	public static final int SPREEKWOORDEN = 3;
	
	public Gast(boolean empty){
		this.empty = empty; 
	}
	
	public boolean isEmpty() {
		return empty;
	}
	public void setEmpty(boolean empty) {
		this.empty = empty;
	}
	public int getRelatie() {
		return relatie;
	}
	public void setRelatie(int relatie) {
		this.relatie = relatie;
	}
	public int getInteresse() {
		return interesse;
	}
	public void setInteresse(int interesse) {
		this.interesse = interesse;
	}
	public int getStoelNr() {
		return stoelNr;
	}
	public void setStoelNr(int stoelNr) {
		this.stoelNr = stoelNr;
	}
	@ManyToOne()
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}
	@ManyToOne()
	@JsonIgnore
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
