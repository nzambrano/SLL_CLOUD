package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllFasesRepository extends JpaRepository<M4sllFases, M4sllFasesId> {
    @Query(
        value = "select COALESCE(max(fas_secuencia),0)+1 from sll.m4sll_fases where id_organization = :idOrganization and lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "select * from sll.m4sll_fases where id_organization = :idOrganization and lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public List<M4sllFases> findByIdOrganizationLitIdLitigio(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "select * from sll.m4sll_fases where id_organization = :idOrganization and lit_id_litigio = :litIdLitigio and fas_secuencia = :fasSecuencia",
        nativeQuery = true
    )
    public List<M4sllFases> findByIdOrganizationLitIdLitigioFasSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio, @Param("fasSecuencia") Long fasSecuencia);

}
