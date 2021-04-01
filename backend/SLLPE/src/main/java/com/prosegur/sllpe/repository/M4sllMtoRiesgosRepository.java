package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtoRiesgos;
import com.prosegur.sllpe.domain.M4sllMtoRiesgosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtoRiesgosRepository extends JpaRepository<M4sllMtoRiesgos, M4sllMtoRiesgosId> {
    @Query(
        value = "select COALESCE(max(cast(mri_id_riesgo as integer)),0)+1 from sll.m4sll_mto_riesgos where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_mto_riesgos where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllMtoRiesgos> findM4sllMtoRiesgosByIdOrganization(@Param("id_organization") String id_organization);


}
