package nl.youngcapital;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

@Entity
public class Tafel {
	private long id; 
	private int stoelen; 
	private enum Vorm {ROND, VIERKANT, RECHTHOEK}
	private List<Gast> gasten = new ArrayList<>();
	
	@OneToMany(mappedBy = "tafel")
	public List<Gast> getGasten() {
		return gasten;
	}
	public void setGasten(List<Gast> gasten) {
		this.gasten = gasten;
	}
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
	
	public void plaatsGast(Gast g){
		if (this.getStoelen() > this.getGasten().size()){
			this.getGasten().add(g);
			g.setTafel(this);
		} else {
			//throw an exception 
		}
	}
}
