package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpAutorReu;
import com.prosegur.sllpe.domain.M4sllTpAutorReuId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpAutorReuRepository extends JpaRepository<M4sllTpAutorReu, M4sllTpAutorReuId> {
    @Query(
        value = "select COALESCE(max(cast(tar_id_tp_autor_reu as integer)),0)+1 from sll.m4sll_tp_autor_reu where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_tp_autor_reu where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllTpAutorReu> findM4sllTpAutorReuByIdOrganization(@Param("id_organization") String id_organization);


}
