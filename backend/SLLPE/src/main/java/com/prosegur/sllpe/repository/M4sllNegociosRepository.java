package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.domain.M4sllNegociosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllNegociosRepository extends JpaRepository<M4sllNegocios, M4sllNegociosId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(neg_id_negocio as integer)),0)+1 FROM sll.m4sll_negocios WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_negocios WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(neg_id_negocio) DESC",
        nativeQuery = true
    )
    public List<M4sllNegocios> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
