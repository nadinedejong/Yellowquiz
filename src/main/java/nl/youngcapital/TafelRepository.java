package nl.youngcapital;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface TafelRepository extends CrudRepository<Tafel, Long> {
	List<Tafel> findAllByOrderById();
}