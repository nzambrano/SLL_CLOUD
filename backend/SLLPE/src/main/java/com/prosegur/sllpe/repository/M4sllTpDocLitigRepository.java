package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.domain.M4sllTpDocLitigId;


public interface M4sllTpDocLitigRepository extends JpaRepository<M4sllTpDocLitig, M4sllTpDocLitigId> {

    @Query(value = "select COALESCE(max(cast(tdl_id_tp_doc_litigio as integer)),0)+1 as secuencia from sll.m4sll_tp_doc_litig where id_organization = :id_organization", nativeQuery = true)

    public Long obtenerUltimaSecuencia(
        @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_doc_litig  where id_organization =  :id_organization",
        nativeQuery = true
    )

    public List<M4sllTpDocLitig> findTpDocLitig(@Param("id_organization") String idOrganization);
}






