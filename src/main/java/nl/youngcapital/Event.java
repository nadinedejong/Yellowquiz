package nl.youngcapital;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Event {

	private String naam; 
	private LocalDate datum; 
	private boolean sorteergeslacht;
	private long id;
		
		
	public String getNaam() {
			return naam;
	}
	public void setNaam(String naam) {
		this.naam = naam;
	}
	public LocalDate getDatum() {
		return datum;
	}
	public void setDatum(LocalDate datum) {
		this.datum = datum;
	}
	public boolean isSorteergeslacht() {
		return sorteergeslacht;
	}
	public void setSorteergeslacht(boolean sorteergeslacht) {
		this.sorteergeslacht = sorteergeslacht;
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	} 
		
		
}
