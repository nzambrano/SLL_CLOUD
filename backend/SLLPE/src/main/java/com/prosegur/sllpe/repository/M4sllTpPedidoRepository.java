package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.domain.M4sllTpPedidoId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllTpPedidoRepository extends JpaRepository<M4sllTpPedido, M4sllTpPedidoId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(tpe_id_pedido as integer)),0)+1 FROM sll.m4sll_tp_pedido WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM sll.m4sll_tp_pedido WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(tpe_id_pedido) DESC",
        nativeQuery = true
    )
    public List<M4sllTpPedido> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
