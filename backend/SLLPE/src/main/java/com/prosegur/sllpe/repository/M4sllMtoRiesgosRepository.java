package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtoRiesgos;
import com.prosegur.sllpe.domain.M4sllMtoRiesgosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtoRiesgosRepository extends JpaRepository<M4sllMtoRiesgos, M4sllMtoRiesgosId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(mri_id_riesgo as integer)),0)+1 FROM sll.m4sll_mto_riesgos WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_mto_riesgos WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(mri_id_riesgo) DESC",
        nativeQuery = true
    )
    public List<M4sllMtoRiesgos> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
