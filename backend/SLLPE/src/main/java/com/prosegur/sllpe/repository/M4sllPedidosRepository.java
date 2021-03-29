package com.prosegur.sllpe.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllPedidos;
import com.prosegur.sllpe.domain.M4sllPedidosId;

public interface M4sllPedidosRepository extends JpaRepository<M4sllPedidos, M4sllPedidosId> {

    @Query(value = "select COALESCE(max(ped_secuencia),0)+1 as secuencia from sll.m4sll_pedidos where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio", nativeQuery = true)
    public Long obtenerUltimaSecuencia(
        @Param("id_organization") String id_organization,
        @Param("lit_id_litigio") String lit_id_litigio);
    @Query(
        value = "select * from sll.m4sll_pedidos  where id_organization =  :id_organization and lit_id_litigio = :lit_id_litigio",
        nativeQuery = true
    )
    public List<M4sllPedidos> findPedidosByLitigio(@Param("id_organization") String id_organization, @Param("lit_id_litigio") String lit_id_litigio);
}
