package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpStatus;
import com.prosegur.sllpe.domain.M4sllTpStatusId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpStatusRepository extends JpaRepository<M4sllTpStatus, M4sllTpStatusId> {
    @Query(
        value = "select COALESCE(max(cast(tst_id_tp_status as integer)),0)+1 from sll.m4sll_tp_status where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_status where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpStatus> findM4sllTpStatusByIdOrganization(@Param("id_organization") String id_organization);


}
