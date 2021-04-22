package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtoCodAlt;
import com.prosegur.sllpe.domain.M4sllMtoCodAltId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtoCodAltRepository extends JpaRepository<M4sllMtoCodAlt, M4sllMtoCodAltId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(mca_id_codigo_alterno as integer)),0)+1 FROM sll.m4sll_mto_cod_alt WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_mto_cod_alt WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(mca_id_codigo_alterno) DESC",
        nativeQuery = true
    )
    public List<M4sllMtoCodAlt> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
