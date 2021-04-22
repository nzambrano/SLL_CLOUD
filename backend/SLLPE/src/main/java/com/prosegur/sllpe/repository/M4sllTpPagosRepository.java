package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpPagos;
import com.prosegur.sllpe.domain.M4sllTpPagosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpPagosRepository extends JpaRepository<M4sllTpPagos, M4sllTpPagosId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tpa_id_pago as integer)),0)+1 FROM sll.m4sll_tp_pagos WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_pagos WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tpa_id_pago) DESC",
        nativeQuery = true
    )
    public List<M4sllTpPagos> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
