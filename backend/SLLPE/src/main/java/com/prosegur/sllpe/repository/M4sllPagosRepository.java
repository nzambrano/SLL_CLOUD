package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllPagos;
import com.prosegur.sllpe.domain.M4sllPagosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllPagosRepository extends JpaRepository<M4sllPagos, M4sllPagosId> {
    @Query(
        value = "SELECT COALESCE(MAX(pag_secuencia),0)+1 FROM sll.m4sll_pagos WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "SELECT * FROM sll.m4sll_pagos WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio ORDER BY id_organization, lit_id_litigio, pag_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllPagos> findByIdOrganizationLitIdLitigio(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);


}
