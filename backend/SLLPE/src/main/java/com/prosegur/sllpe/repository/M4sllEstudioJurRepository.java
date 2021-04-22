package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.domain.M4sllEstudioJurId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllEstudioJurRepository extends JpaRepository<M4sllEstudioJur, M4sllEstudioJurId> {
    @Query(
        value = "SELECT COALESCE(MAX(eju_id_est_juridico),0)+1 FROM sll.m4sll_estudio_jur WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_estudio_jur WHERE id_organization = :idOrganization ORDER BY id_organization, eju_id_est_juridico DESC",
        nativeQuery = true
    )
    public List<M4sllEstudioJur> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
