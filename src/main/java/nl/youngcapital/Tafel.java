package nl.youngcapital;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Tafel {
	private long id; 
	private int stoelen; 
	private enum Vorm {ROND, VIERKANT, RECHTHOEK}
	
	//database ID van tafel. Hibernate genereert onze IDs. 
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public int getStoelen() {
		return stoelen;
	}
	public void setStoelen(int stoelen) {
		this.stoelen = stoelen;
	}
}
