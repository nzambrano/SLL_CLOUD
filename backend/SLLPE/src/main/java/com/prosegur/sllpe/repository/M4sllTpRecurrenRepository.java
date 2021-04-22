package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpRecurren;
import com.prosegur.sllpe.domain.M4sllTpRecurrenId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpRecurrenRepository extends JpaRepository<M4sllTpRecurren, M4sllTpRecurrenId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tre_id_recurrencia as integer)),0)+1 FROM sll.m4sll_tp_recurren WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_recurren WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tre_id_recurrencia) DESC",
        nativeQuery = true
    )
    public List<M4sllTpRecurren> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
