package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;


public interface M4sllFasesRepository extends JpaRepository<M4sllFases, M4sllFasesId> {

    @Query(value = "select COALESCE(max(fas_secuencia),0)+1 from sll.m4sll_fases where id_organization = :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO", nativeQuery = true)
    public String obtenerUltimaSecuencia(
        @Param("ID_ORGANIZATION") String ID_ORGANIZATION,
        @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO
    );

    @Query(
        value = "select * from sll.m4sll_fases  where id_organization =  :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO",
        nativeQuery = true
    )
    public List<M4sllFases> getFases(@Param("ID_ORGANIZATION") String ID_ORGANIZATION, @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO);

    @Query(
        value = "select * from sll.m4sll_fases  where id_organization =  :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO and fas_secuencia = :FAS_SECUENCIA",
        nativeQuery = true
    )
    public M4sllFases getFaseFasSecuencia(@Param("ID_ORGANIZATION") String ID_ORGANIZATION, @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO, @Param("FAS_SECUENCIA") Integer FAS_SECUENCIA);



}