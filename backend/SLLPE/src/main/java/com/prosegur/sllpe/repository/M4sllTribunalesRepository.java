package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTribunales;
import com.prosegur.sllpe.domain.M4sllTribunalesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTribunalesRepository extends JpaRepository<M4sllTribunales, M4sllTribunalesId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tri_id_tribunal as integer)),0)+1 FROM sll.m4sll_tribunales WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tribunales WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tri_id_tribunal) DESC",
        nativeQuery = true
    )
    public List<M4sllTribunales> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
