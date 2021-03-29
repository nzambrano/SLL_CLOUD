package com.prosegur.sllpe.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.domain.M4sllMtAbogadosId;

public interface M4sllAbogadosRepository extends JpaRepository<M4sllMtAbogados, M4sllMtAbogadosId> {

    @Query(value = "select COALESCE(max(mab_secuencia),0)+1 as secuencia from sll.m4sll_mt_abogados where id_organization = :id_organization", nativeQuery = true)
    public Long obtenerUltimaSecuencia(
        @Param("id_organization") String id_organization);
    @Query(
        value = "select * from sll.m4sll_mt_abogados  where id_organization =  :id_organization",
        nativeQuery = true
    )
    public List<M4sllMtAbogados> findAbogados(@Param("id_organization") String id_organization);

}
