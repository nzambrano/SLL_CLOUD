package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpLitigios;
import com.prosegur.sllpe.domain.M4sllTpLitigiosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpLitigiosRepository extends JpaRepository<M4sllTpLitigios, M4sllTpLitigiosId> {
    @Query(
        value = "select COALESCE(max(cast(tpl_id_tp_litigio as integer)),0)+1 from sll.m4sll_tp_litigios where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_litigios where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpLitigios> findM4sllTpLitigiosByIdOrganization(@Param("id_organization") String id_organization);


}
