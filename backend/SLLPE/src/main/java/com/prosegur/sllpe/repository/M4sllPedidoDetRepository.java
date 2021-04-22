package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllPedidoDet;
import com.prosegur.sllpe.domain.M4sllPedidoDetId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllPedidoDetRepository extends JpaRepository<M4sllPedidoDet, M4sllPedidoDetId> {
    @Query(
        value = "SELECT COALESCE(MAX(pde_secuencia),0)+1 FROM sll.m4sll_pedido_det WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio AND tpe_id_pedido = :tpeIdPedido",
        nativeQuery = true
    )
    public Long obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio, @Param("tpeIdPedido") String tpeIdPedido);

    @Query(
        value = "SELECT * FROM sll.m4sll_pedido_det WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio AND tpe_id_pedido = :tpeIdPedido ORDER BY id_organization, lit_id_litigio, tpe_id_pedido, pde_secuencia DESC",
        nativeQuery = true
    )
    public List<M4sllPedidoDet> findByIdOrganizationLitIdLitigioTpeIdPedido(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio, @Param("tpeIdPedido") String tpeIdPedido);


}
