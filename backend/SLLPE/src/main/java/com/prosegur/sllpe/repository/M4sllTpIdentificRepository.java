package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpIdentific;
import com.prosegur.sllpe.domain.M4sllTpIdentificId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpIdentificRepository extends JpaRepository<M4sllTpIdentific, M4sllTpIdentificId> {
    @Query(
        value = "select COALESCE(max(cast(tpi_id_tp_identificacion as integer)),0)+1 from sll.m4sll_tp_identific where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_identific where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpIdentific> findByIdOrganization(@Param("id_organization") String id_organization);


}
