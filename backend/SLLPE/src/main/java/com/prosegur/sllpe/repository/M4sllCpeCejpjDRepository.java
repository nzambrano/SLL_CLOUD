package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllCpeCejpjD;
import com.prosegur.sllpe.domain.M4sllCpeCejpjDId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllCpeCejpjDRepository extends JpaRepository<M4sllCpeCejpjD, M4sllCpeCejpjDId> {
    @Query(
        value = "SELECT COALESCE(MAX(ccd_id_secuencia),0)+1 FROM sll.m4sll_cpe_cejpj_d WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "SELECT * FROM sll.m4sll_cpe_cejpj_d WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio ORDER BY id_organization, lit_id_litigio, ccd_id_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllCpeCejpjD> findByIdOrganizationLitIdLitigio(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "SELECT * FROM sll.m4sll_cpe_cejpj_d WHERE lit_id_litigio = :litIdLitigio ORDER BY id_organization, lit_id_litigio, ccd_id_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllCpeCejpjD> findByLitIdLitigio(@Param("litIdLitigio") String litIdLitigio);

}
