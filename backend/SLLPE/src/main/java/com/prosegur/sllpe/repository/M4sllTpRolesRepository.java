package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpRoles;
import com.prosegur.sllpe.domain.M4sllTpRolesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpRolesRepository extends JpaRepository<M4sllTpRoles, M4sllTpRolesId> {
    @Query(
        value = "SELECT COALESCE(MAX(tpr_id_tp_rol),0)+1 FROM sll.m4sll_tp_roles WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_roles WHERE id_organization = :idOrganization ORDER BY id_organization, tpr_id_tp_rol DESC",
        nativeQuery = true
    )
    public List<M4sllTpRoles> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
