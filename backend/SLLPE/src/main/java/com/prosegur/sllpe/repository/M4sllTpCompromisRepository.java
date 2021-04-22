package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpCompromis;
import com.prosegur.sllpe.domain.M4sllTpCompromisId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpCompromisRepository extends JpaRepository<M4sllTpCompromis, M4sllTpCompromisId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tco_id_tp_compromiso as integer)),0)+1 FROM sll.m4sll_tp_compromis WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_compromis WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tco_id_tp_compromiso) DESC",
        nativeQuery = true
    )
    public List<M4sllTpCompromis> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
