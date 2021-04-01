package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpCompromis;
import com.prosegur.sllpe.domain.M4sllTpCompromisId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpCompromisRepository extends JpaRepository<M4sllTpCompromis, M4sllTpCompromisId> {
    @Query(
        value = "select COALESCE(max(cast(tco_id_tp_compromiso as integer)),0)+1 from sll.m4sll_tp_compromis where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_compromis where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpCompromis> findM4sllTpCompromisByIdOrganization(@Param("id_organization") String id_organization);


}
