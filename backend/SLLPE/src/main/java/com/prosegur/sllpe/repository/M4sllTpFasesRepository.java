package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.domain.M4sllTpFasesId;


public interface M4sllTpFasesRepository extends JpaRepository<M4sllTpFases, M4sllTpFasesId> {

	@Query(value = "select COALESCE(max(cast(tfa_id_tp_fase as integer)),0)+1 as secuencia from sll.m4sll_tp_fases where id_organization = :id_organization", nativeQuery = true)
	
	public Long obtenerUltimaSecuencia(
            @Param("id_organization") String id_organization);

	@Query(
		    value = "select * from sll.m4sll_tp_fases  where id_organization =  :id_organization",
		    nativeQuery = true
		  )

	public List<M4sllTpFases> findTpFases(@Param("id_organization") String idOrganization);
}




