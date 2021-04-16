package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllDocLitigios;
import com.prosegur.sllpe.domain.M4sllDocLitigiosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllDocLitigiosRepository extends JpaRepository<M4sllDocLitigios, M4sllDocLitigiosId> {
    @Query(
        value = "select COALESCE(max(dol_secuencia),0)+1 from sll.m4sll_doc_litigios where id_organization = :idOrganization and lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "select * from sll.m4sll_doc_litigios where id_organization = :idOrganization and lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public List<M4sllDocLitigios> findByIdOrganizationLitIdLitigio(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);


}
