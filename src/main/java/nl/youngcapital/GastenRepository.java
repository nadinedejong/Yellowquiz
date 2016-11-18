package nl.youngcapital;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface GastenRepository extends CrudRepository<Gast, Long> {
	List<Gast> findAllByOrderById();
}