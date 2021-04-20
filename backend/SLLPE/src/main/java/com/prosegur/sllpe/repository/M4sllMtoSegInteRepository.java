package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtoSegInte;
import com.prosegur.sllpe.domain.M4sllMtoSegInteId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtoSegInteRepository extends JpaRepository<M4sllMtoSegInte, M4sllMtoSegInteId> {
    @Query(
        value = "select COALESCE(max(msi_secuencia),0)+1 from sll.m4sll_mto_seg_inte where id_organization = :idOrganization and id_app_role = :idAppRole",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("idAppRole") String idAppRole);

    @Query(
        value = "select * from sll.m4sll_mto_seg_inte where id_organization = :idOrganization and id_app_role = :idAppRole",
        nativeQuery = true
    )
    public List<M4sllMtoSegInte> findByIdOrganizationIdAppRole(@Param("idOrganization") String idOrganization, @Param("idAppRole") String idAppRole);

    @Query(
        value = "select * from sll.m4sll_mto_seg_inte where id_app_role = :idAppRole",
        nativeQuery = true
    )
    public List<M4sllMtoSegInte> findByIdAppRole(@Param("idAppRole") String idAppRole);

}