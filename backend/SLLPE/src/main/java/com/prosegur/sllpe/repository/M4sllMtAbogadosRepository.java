package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.domain.M4sllMtAbogadosId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllMtAbogadosRepository extends JpaRepository<M4sllMtAbogados, M4sllMtAbogadosId> {
    @Query(
        value = "select COALESCE(max(mab_secuencia),0)+1 from sll.m4sll_mt_abogados where id_organization = :id_organization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_mt_abogados where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllMtAbogados> findByIdOrganization(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_mt_abogados where id_organization = :id_organization and mab_secuencia = :mab_secuencia and mab_chk_int = :mab_chk_int",
        nativeQuery = true
    )
    public List<M4sllMtAbogados> findByIdOrganizationMabSecuenciaMabChkInt(@Param("id_organization") String id_organization, @Param("mab_secuencia") Long mab_secuencia, @Param("mab_chk_int") String mab_chk_int);

}
