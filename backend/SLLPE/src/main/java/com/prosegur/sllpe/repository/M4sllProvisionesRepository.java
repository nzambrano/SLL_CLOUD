package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllValEcLit;
import com.prosegur.sllpe.domain.M4sllValEcLitId;


public interface M4sllProvisionesRepository extends JpaRepository<M4sllValEcLit, M4sllValEcLitId> {

	@Query(value = "select COALESCE(max(vel_secuencia),0)+1 from sll.m4sll_val_ec_lit where id_organization = :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO ", nativeQuery = true)
	public Long obtenerUltimaSecuencia(
			@Param("ID_ORGANIZATION") String ID_ORGANIZATION,
			@Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO
			);

	@Query(
		    value = "select * from sll.m4sll_val_ec_lit  where id_organization =  :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO AND TVE_ID_VAL_ECO = :TVE_ID_VAL_ECO",
		    nativeQuery = true
		  )
	public M4sllValEcLit getProvisionByLitigioByTveIdValEco(@Param("ID_ORGANIZATION") String ID_ORGANIZATION, @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO, @Param("TVE_ID_VAL_ECO") String TVE_ID_VAL_ECO);



	@Query(
		    value = "SELECT *FROM sll.M4SLL_VAL_EC_LIT FP\r\n" +
		    		"INNER JOIN (\r\n" +
		    		"	select LIT_ID_LITIGIO, TVE_ID_VAL_ECO, MAX(VEL_SECUENCIA) maxFaseP from sll.M4SLL_VAL_EC_LIT WHERE ID_ORGANIZATION = :ID_ORGANIZATION GROUP BY LIT_ID_LITIGIO, TVE_ID_VAL_ECO) MFP\r\n" +
		    		"      ON ( MFP.LIT_ID_LITIGIO = :LIT_ID_LITIGIO AND MFP.TVE_ID_VAL_ECO = FP.TVE_ID_VAL_ECO )\r\n" +
		    		"WHERE FP.ID_ORGANIZATION = :ID_ORGANIZATION AND  FP.LIT_ID_LITIGIO = :LIT_ID_LITIGIO AND FP.VEL_SECUENCIA  = MFP.maxFaseP",
		    nativeQuery = true
		  )
	public List <M4sllValEcLit> getProvisionByLitigio(@Param("ID_ORGANIZATION") String ID_ORGANIZATION, @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO);


}
