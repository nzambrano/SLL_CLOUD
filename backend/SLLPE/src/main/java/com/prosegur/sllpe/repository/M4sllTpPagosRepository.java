package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpPagos;
import com.prosegur.sllpe.domain.M4sllTpPagosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpPagosRepository extends JpaRepository<M4sllTpPagos, M4sllTpPagosId> {
    @Query(
        value = "select COALESCE(max(cast(tpa_id_pago as integer)),0)+1 from sll.m4sll_tp_pagos where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_pagos where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpPagos> findByIdOrganization(@Param("id_organization") String id_organization);


}
