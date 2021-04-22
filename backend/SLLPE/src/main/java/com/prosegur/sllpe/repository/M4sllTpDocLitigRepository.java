package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.domain.M4sllTpDocLitigId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpDocLitigRepository extends JpaRepository<M4sllTpDocLitig, M4sllTpDocLitigId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tdl_id_tp_doc_litigio as integer)),0)+1 FROM sll.m4sll_tp_doc_litig WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_doc_litig WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tdl_id_tp_doc_litigio) DESC",
        nativeQuery = true
    )
    public List<M4sllTpDocLitig> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
