package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllFasesRepository extends JpaRepository<M4sllFases, M4sllFasesId> {
    @Query(
        value = "SELECT COALESCE(max(fas_secuencia),0)+1 FROM sll.m4sll_fases WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio AND tfa_id_tp_fase = :tfaIdTpFase",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio, @Param("tfaIdTpFase") String tfaIdTpFase);

    @Query(
        value = "SELECT * FROM sll.m4sll_fases WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio AND tfa_id_tp_fase = :tfaIdTpFase ORDER BY id_organization, lit_id_litigio, fas_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllFases> findByIdOrganizationLitIdLitigioTfaIdTpFase(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio, @Param("tfaIdTpFase") String tfaIdTpFase);

    @Query(
        value = "SELECT * FROM sll.m4sll_fases WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio AND fas_secuencia = :fasSecuencia ORDER BY id_organization, lit_id_litigio, fas_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllFases> findByIdOrganizationLitIdLitigioFasSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio, @Param("fasSecuencia") Long fasSecuencia);

}
