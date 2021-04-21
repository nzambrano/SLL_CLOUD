
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.M4sllPedidos;
import com.prosegur.sllpe.domain.M4sllPedidosId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllPedidosRepository extends JpaRepository<M4sllPedidos, M4sllPedidosId> {
    @Query(
        value = "select * from sll.m4sll_pedidos WHERE id_organization = :idOrganization AND lit_id_litigio = :litIdLitigio ORDER BY id_organization, tpe_id_pedido, lit_id_litigio DESC",
        nativeQuery = true
    )
    public List<M4sllPedidos> findByIdOrganizationLitIdLitigio(@Param("idOrganization") String idOrganization, @Param("litIdLitigio") String litIdLitigio);
}