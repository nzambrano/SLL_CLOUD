package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllPedidoDet;
import com.prosegur.sllpe.domain.M4sllPedidoDetId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllPedidoDetRepository extends JpaRepository<M4sllPedidoDet, M4sllPedidoDetId> {
    @Query(
        value = "select COALESCE(max(pde_secuencia),0)+1 from sll.m4sll_pedido_det where tpe_id_pedido = :tpe_id_pedido and lit_id_litigio = :lit_id_litigio and id_organization = :id_organization",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("tpe_id_pedido") String tpe_id_pedido, @Param("lit_id_litigio") String lit_id_litigio, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_pedido_det where tpe_id_pedido = :tpe_id_pedido and lit_id_litigio = :lit_id_litigio and id_organization = :id_organization",
        nativeQuery = true
    )
    public List<M4sllPedidoDet> findM4sllPedidoDetByTpeIdPedidoLitIdLitigioIdOrganization(@Param("tpe_id_pedido") String tpe_id_pedido, @Param("lit_id_litigio") String lit_id_litigio, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.m4sll_pedido_det where tpe_id_pedido = :tpe_id_pedido and lit_id_litigio = :lit_id_litigio",
        nativeQuery = true
    )
    public List<M4sllPedidoDet> findM4sllPedidoDetByTpeIdPedidoLitIdLitigio(@Param("tpe_id_pedido") String tpe_id_pedido, @Param("lit_id_litigio") String lit_id_litigio);

}
