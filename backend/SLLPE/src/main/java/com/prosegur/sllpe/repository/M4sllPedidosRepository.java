
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.M4sllPedidos;
import com.prosegur.sllpe.domain.M4sllPedidosId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllPedidosRepository extends JpaRepository<M4sllPedidos, M4sllPedidosId> {
	
    @Query(
        value = "select * from sll.m4sll_pedidos where id_organization = :id_organization and lit_id_litigio = :lit_id_litigio",
        nativeQuery = true
    )
    
    public List<M4sllPedidos> findByIdOrganizationLitIdLitigio(@Param("id_organization") String id_organization, @Param("lit_id_litigio") String lit_id_litigio);
}