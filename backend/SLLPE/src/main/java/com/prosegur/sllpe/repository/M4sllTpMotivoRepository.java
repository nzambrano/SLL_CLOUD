package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpMotivo;
import com.prosegur.sllpe.domain.M4sllTpMotivoId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpMotivoRepository extends JpaRepository<M4sllTpMotivo, M4sllTpMotivoId> {
    @Query(
        value = "select COALESCE(max(cast(tmo_id_tp_motivo as integer)),0)+1 from sll.m4sll_tp_motivo where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_motivo where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpMotivo> findM4sllTpMotivoByIdOrganization(@Param("id_organization") String id_organization);


}
