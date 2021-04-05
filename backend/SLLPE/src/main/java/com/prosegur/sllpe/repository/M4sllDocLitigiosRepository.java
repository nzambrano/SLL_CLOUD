package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllDocLitigios;
import com.prosegur.sllpe.domain.M4sllDocLitigiosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllDocLitigiosRepository extends JpaRepository<M4sllDocLitigios, M4sllDocLitigiosId> {
    @Query(
        value = "select COALESCE(max(dol_secuencia),0)+1 from sll.m4sll_doc_litigios where lit_id_litigio = :lit_id_litigio and id_organization = :id_organization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("lit_id_litigio") String lit_id_litigio, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_doc_litigios where lit_id_litigio = :lit_id_litigio and id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllDocLitigios> findByLitIdLitigioIdOrganization(@Param("lit_id_litigio") String lit_id_litigio, @Param("id_organization") String id_organization);


}
