package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpLitigios;
import com.prosegur.sllpe.domain.M4sllTpLitigiosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpLitigiosRepository extends JpaRepository<M4sllTpLitigios, M4sllTpLitigiosId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tpl_id_tp_litigio as integer)),0)+1 FROM sll.m4sll_tp_litigios WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_litigios WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tpl_id_tp_litigio) DESC",
        nativeQuery = true
    )
    public List<M4sllTpLitigios> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
