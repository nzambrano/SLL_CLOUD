package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpRoles;
import com.prosegur.sllpe.domain.M4sllTpRolesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpRolesRepository extends JpaRepository<M4sllTpRoles, M4sllTpRolesId> {
    @Query(
        value = "select COALESCE(max(tpr_id_tp_rol),0)+1 from sll.m4sll_tp_roles where id_organization = :id_organization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_roles where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpRoles> findByIdOrganization(@Param("id_organization") String id_organization);


}
