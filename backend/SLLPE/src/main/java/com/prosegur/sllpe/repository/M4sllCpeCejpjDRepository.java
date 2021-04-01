package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllCpeCejpjD;
import com.prosegur.sllpe.domain.M4sllCpeCejpjDId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllCpeCejpjDRepository extends JpaRepository<M4sllCpeCejpjD, M4sllCpeCejpjDId> {
    @Query(
        value = "select COALESCE(max(ccd_id_secuencia),0)+1 from sll.m4sll_cpe_cejpj_d where lit_id_litigio = :lit_id_litigio and id_organization = :id_organization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("lit_id_litigio") String lit_id_litigio, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_cpe_cejpj_d where lit_id_litigio = :lit_id_litigio and id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllCpeCejpjD> findM4sllCpeCejpjDByLitIdLitigioIdOrganization(@Param("lit_id_litigio") String lit_id_litigio, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_cpe_cejpj_d where lit_id_litigio = :lit_id_litigio",
        nativeQuery = true
    )
    public List<M4sllCpeCejpjD> findM4sllCpeCejpjDByLitIdLitigio(@Param("lit_id_litigio") String lit_id_litigio);

}
