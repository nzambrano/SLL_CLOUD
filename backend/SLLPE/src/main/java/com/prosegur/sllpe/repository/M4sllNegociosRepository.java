package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.domain.M4sllNegociosId;
import java.util.List;
// import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllNegociosRepository extends JpaRepository<M4sllNegocios, M4sllNegociosId> {
    @Query(
        value = "select COALESCE(max(cast(neg_id_negocio as integer)),0)+1 from sll.m4sll_negocios where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_negocios where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllNegocios> findM4sllNegociosByIdOrganization(@Param("id_organization") String id_organization);


}
