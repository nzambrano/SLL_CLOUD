package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTribunales;
import com.prosegur.sllpe.domain.M4sllTribunalesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTribunalesRepository extends JpaRepository<M4sllTribunales, M4sllTribunalesId> {
    @Query(
        value = "select COALESCE(max(cast(tri_id_tribunal as integer)),0)+1 from sll.m4sll_tribunales where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tribunales where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTribunales> findM4sllTribunalesByIdOrganization(@Param("id_organization") String id_organization);


}
