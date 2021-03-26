package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllLitSeguimie;
import com.prosegur.sllpe.domain.M4sllLitSeguimieId;
import java.util.List;
// import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllLitSeguimieRepository extends JpaRepository<M4sllLitSeguimie, M4sllLitSeguimieId> {
  @Query(
    value = "select COALESCE(max(lis_secuencia),0)+1 from sll.m4sll_lit_seguimie where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio",
    nativeQuery = true
  )
  public Long obtenerUltimaSecuencia(@Param("id_organization") String id_organization, @Param("lit_id_litigio") String lit_id_litigio);

  @Query(
    value = "select * from sll.m4sll_lit_seguimie where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio",
    nativeQuery = true
  )
  public List<M4sllLitSeguimie> findM4sllLitSeguimieByInput(
    @Param("id_organization") String id_organization,
    @Param("lit_id_litigio") String lit_id_litigio
  );
}
