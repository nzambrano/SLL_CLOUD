package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpMotivo;
import com.prosegur.sllpe.domain.M4sllTpMotivoId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpMotivoRepository extends JpaRepository<M4sllTpMotivo, M4sllTpMotivoId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tmo_id_tp_motivo as integer)),0)+1 FROM sll.m4sll_tp_motivo WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_motivo WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tmo_id_tp_motivo) DESC",
        nativeQuery = true
    )
    public List<M4sllTpMotivo> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
