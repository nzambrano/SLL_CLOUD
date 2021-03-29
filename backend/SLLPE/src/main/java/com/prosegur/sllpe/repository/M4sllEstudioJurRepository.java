package com.prosegur.sllpe.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.domain.M4sllEstudioJurId;

public interface M4sllEstudioJurRepository extends JpaRepository<M4sllEstudioJur, M4sllEstudioJurId> {
    @Query(value = "select COALESCE(max(eju_id_est_juridico),0)+1  as secuencia from sll.m4sll_estudio_jur where id_organization = :id_organization", nativeQuery = true)
    public Long obtenerUltimaSecuencia(
        @Param("id_organization") String id_organization
    );
}
