package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpStatus;
import com.prosegur.sllpe.domain.M4sllTpStatusId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpStatusRepository extends JpaRepository<M4sllTpStatus, M4sllTpStatusId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tst_id_tp_status as integer)),0)+1 FROM sll.m4sll_tp_status WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_status WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tst_id_tp_status) DESC",
        nativeQuery = true
    )
    public List<M4sllTpStatus> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
