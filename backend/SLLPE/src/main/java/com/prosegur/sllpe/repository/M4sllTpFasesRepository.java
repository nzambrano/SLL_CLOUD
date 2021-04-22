package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.domain.M4sllTpFasesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpFasesRepository extends JpaRepository<M4sllTpFases, M4sllTpFasesId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tfa_id_tp_fase as integer)),0)+1 FROM sll.m4sll_tp_fases WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_fases WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tfa_id_tp_fase) DESC",
        nativeQuery = true
    )
    public List<M4sllTpFases> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
