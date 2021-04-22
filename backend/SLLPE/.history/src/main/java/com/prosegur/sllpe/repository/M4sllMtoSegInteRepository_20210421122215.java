package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtoSegInte;
import com.prosegur.sllpe.domain.M4sllMtoSegInteId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtoSegInteRepository extends JpaRepository<M4sllMtoSegInte, M4sllMtoSegInteId> {
    @Query(
        value = "SELECT COALESCE(MAX(msi_secuencia),0)+1 FROM sll.m4sll_mto_seg_inte WHERE id_organization = :idOrganization AND id_app_role = :idAppRole",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("idAppRole") String idAppRole);

    @Query(
        value = "SELECT * FROM sll.m4sll_mto_seg_inte WHERE id_organization = :idOrganization AND id_app_role = :idAppRole ORDER BY id_organization, id_app_role, msi_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllMtoSegInte> findByIdOrganizationIdAppRole(@Param("idOrganization") String idOrganization, @Param("idAppRole") String idAppRole);

    @Query(
        value = "select * from sll.m4sll_mto_seg_inte where id_app_role = :idAppRole",
        nativeQuery = true
    )
    public List<M4sllMtoSegInte> findByIdAppRole(@Param("idAppRole") String idAppRole);


    @Query(nativeQuery =true,value = "select * from sll.m4sll_mto_seg_inte where id_organization = :idOrganization AND  id_app_role IN (:idAppRole)")
    public List<M4sllMtoSegInte> findByIdAppRole(@Param("idOrganization") String idOrganization, @Param("idAppRole") List<String> names);

}
