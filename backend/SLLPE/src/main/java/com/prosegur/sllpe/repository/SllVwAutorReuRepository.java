package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import com.prosegur.sllpe.domain.SllVwAutorReu;


public interface SllVwAutorReuRepository extends JpaRepository<SllVwAutorReu, Long> {

	

	@Query(
		    value = "select * from sll.sll_vw_autor_reu  where  lit_id_litigio = :lit_id_litigio",
		    nativeQuery = true
		  )
	public List<SllVwAutorReu> findAllVwAutorReuByLitigio(@Param("lit_id_litigio") String lit_id_litigio);



}
