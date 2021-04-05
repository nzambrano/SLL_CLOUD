package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpRecurren;
import com.prosegur.sllpe.domain.M4sllTpRecurrenId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpRecurrenRepository extends JpaRepository<M4sllTpRecurren, M4sllTpRecurrenId> {
    @Query(
        value = "select COALESCE(max(cast(tre_id_recurrencia as integer)),0)+1 from sll.m4sll_tp_recurren where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_recurren where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpRecurren> findByIdOrganization(@Param("id_organization") String id_organization);


}
