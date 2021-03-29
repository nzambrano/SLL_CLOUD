package com.prosegur.sllpe.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllAutorReu;
import com.prosegur.sllpe.domain.M4sllAutorReuId;


public interface M4sllAutorReuRepository extends JpaRepository<M4sllAutorReu, M4sllAutorReuId> {

	@Query(value = "select COALESCE(max(aur_secuencia),0)+1 from sll.m4sll_autor_reu where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio", nativeQuery = true)
	public Long obtenerUltimaSecuencia(@Param("lit_id_litigio") String lit_id_litigio,
			@Param("id_organization") String id_organization);

	@Query(
		    value = "select * from sll.m4sll_autor_reu  where id_organization =  :id_organization and lit_id_litigio = :lit_id_litigio and aur_autor_reu = :aur_autor_reu",
		    nativeQuery = true
		  )
	public List<M4sllAutorReu> findAutorReuByLitigio(@Param("id_organization") String id_organization, @Param("lit_id_litigio") String lit_id_litigio, @Param("aur_autor_reu") String aur_autor_reu);

	@Query(
		    value = "select * from sll.m4sll_autor_reu  where id_organization =  :id_organization and lit_id_litigio = :lit_id_litigio",
		    nativeQuery = true
		  )
	public List<M4sllAutorReu> findAllAutorReuByLitigio(@Param("id_organization") String id_organization, @Param("lit_id_litigio") String lit_id_litigio);



}
