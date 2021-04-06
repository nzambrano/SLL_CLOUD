package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpValEco;
import com.prosegur.sllpe.domain.M4sllTpValEcoId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpValEcoRepository extends JpaRepository<M4sllTpValEco, M4sllTpValEcoId> {
    @Query(
        value = "select COALESCE(max(cast(tve_id_val_eco as integer)),0)+1 from sll.m4sll_tp_val_eco where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_val_eco where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpValEco> findByIdOrganization(@Param("id_organization") String id_organization);


}
