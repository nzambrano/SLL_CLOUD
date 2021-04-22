package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpAutorReu;
import com.prosegur.sllpe.domain.M4sllTpAutorReuId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpAutorReuRepository extends JpaRepository<M4sllTpAutorReu, M4sllTpAutorReuId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tar_id_tp_autor_reu as integer)),0)+1 FROM sll.m4sll_tp_autor_reu WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_autor_reu WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tar_id_tp_autor_reu) DESC",
        nativeQuery = true
    )
    public List<M4sllTpAutorReu> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
