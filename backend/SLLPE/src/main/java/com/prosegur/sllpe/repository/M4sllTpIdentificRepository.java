package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpIdentific;
import com.prosegur.sllpe.domain.M4sllTpIdentificId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpIdentificRepository extends JpaRepository<M4sllTpIdentific, M4sllTpIdentificId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tpi_id_tp_identificacion as integer)),0)+1 FROM sll.m4sll_tp_identific WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_identific WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tpi_id_tp_identificacion) DESC",
        nativeQuery = true
    )
    public List<M4sllTpIdentific> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
