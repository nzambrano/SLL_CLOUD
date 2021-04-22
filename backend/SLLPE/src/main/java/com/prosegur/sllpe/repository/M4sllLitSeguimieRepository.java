package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllLitSeguimie;
import com.prosegur.sllpe.domain.M4sllLitSeguimieId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllLitSeguimieRepository extends JpaRepository<M4sllLitSeguimie, M4sllLitSeguimieId> {
    @Query(
        value = "SELECT COALESCE(MAX(lis_secuencia),0)+1 FROM sll.m4sll_lit_seguimie WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);

    @Query(
        value = "SELECT * FROM sll.m4sll_lit_seguimie WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio ORDER BY id_organization, lit_id_litigio, lis_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllLitSeguimie> findByIdOrganizationLitIdLitigio(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);


}
