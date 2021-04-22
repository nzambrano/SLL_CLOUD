package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.domain.M4sllMtAbogadosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtAbogadosRepository extends JpaRepository<M4sllMtAbogados, M4sllMtAbogadosId> {
    @Query(
        value = "SELECT COALESCE(MAX(mab_secuencia),0)+1 FROM sll.m4sll_mt_abogados WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_mt_abogados WHERE id_organization = :idOrganization ORDER BY id_organization, mab_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllMtAbogados> findByIdOrganization(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_mt_abogados WHERE id_organization = :idOrganization AND mab_chk_int = :mabChkInt ORDER BY id_organization, mab_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllMtAbogados> findByIdOrganizationMabChkInt(@Param("idOrganization") String idOrganization, @Param("mabChkInt") String mabChkInt);

}
