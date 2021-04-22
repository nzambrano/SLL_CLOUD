package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpValEco;
import com.prosegur.sllpe.domain.M4sllTpValEcoId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpValEcoRepository extends JpaRepository<M4sllTpValEco, M4sllTpValEcoId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tve_id_val_eco as integer)),0)+1 FROM sll.m4sll_tp_val_eco WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_val_eco WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tve_id_val_eco) DESC",
        nativeQuery = true
    )
    public List<M4sllTpValEco> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
