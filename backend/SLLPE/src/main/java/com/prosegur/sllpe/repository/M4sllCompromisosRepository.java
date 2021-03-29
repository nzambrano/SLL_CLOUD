package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import com.prosegur.sllpe.domain.M4sllCompromisos;
import com.prosegur.sllpe.domain.M4sllCompromisosId;


public interface M4sllCompromisosRepository extends JpaRepository<M4sllCompromisos, M4sllCompromisosId> {

    @Query(value = "select COALESCE(max(com_secuencia),0)+1 from sll.m4sll_compromisos where id_organization = :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO and tco_id_tp_compromiso = :TCO_ID_TP_COMPROMISO", nativeQuery = true)
    public Long obtenerUltimaSecuencia(
        @Param("ID_ORGANIZATION") String ID_ORGANIZATION,
        @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO,
        @Param("TCO_ID_TP_COMPROMISO") String TFA_ID_TP_FASE
    );

    @Query(
        value = "select *from sll.m4sll_compromisos where id_organization =  :ID_ORGANIZATION and lit_id_litigio = :LIT_ID_LITIGIO and TFA_ID_TP_FASE = :TFA_ID_TP_FASE",
        nativeQuery = true
    )
    public List<M4sllCompromisos> getCompromisosLitigio(@Param("ID_ORGANIZATION") String ID_ORGANIZATION, @Param("LIT_ID_LITIGIO") String LIT_ID_LITIGIO, @Param("TFA_ID_TP_FASE") String TFA_ID_TP_FASE);



}