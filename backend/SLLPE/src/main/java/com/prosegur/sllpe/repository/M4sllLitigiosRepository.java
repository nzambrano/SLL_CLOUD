package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllLitigios;
import com.prosegur.sllpe.domain.M4sllLitigiosId;

public interface M4sllLitigiosRepository extends JpaRepository<M4sllLitigios, M4sllLitigiosId> {
	@Query(
	        value = "select COALESCE(max(cast(lit_id_litigio as integer)),0)+1 from sll.m4sll_litigios where id_organization = :id_organization",
	        nativeQuery = true
	    )
	public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);
}
