package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllPedidoDet;
import com.prosegur.sllpe.domain.M4sllPedidoDetId;
import java.util.List;
// import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllPedidoDetRepository extends JpaRepository<M4sllPedidoDet, M4sllPedidoDetId> {
    @Query(
        value = "select COALESCE(max(pde_secuencia),0)+1 from sll.m4sll_pedido_det where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio and tpe_id_pedido = :tpe_id_pedido",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(
        @Param("id_organization") String id_organization,
        @Param("lit_id_litigio") String lit_id_litigio,
        @Param("tpe_id_pedido") String tpe_id_pedido
    );

    @Query(
        value = "select * from sll.m4sll_pedido_det where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio and tpe_id_pedido = :tpe_id_pedido",
        nativeQuery = true
    )
    public List<M4sllPedidoDet> findM4sllPedidoDetByInput(
        @Param("id_organization") String id_organization,
        @Param("lit_id_litigio") String lit_id_litigio,
        @Param("tpe_id_pedido") String tpe_id_pedido
    );
}
