package com.prosegur.sllpe.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.domain.M4sllTpPedidoId;

public interface M4sllTipoPedidoRepository extends JpaRepository<M4sllTpPedido, M4sllTpPedidoId> {

	@Query(value = "select COALESCE(max(cast(tpe_id_pedido as integer)),0)+1 as secuencia from sll.m4sll_tp_pedido where id_organization = :id_organization", nativeQuery = true)
	
	public Long obtenerUltimaSecuencia(
            @Param("id_organization") String id_organization);

	@Query(
		    value = "select * from sll.m4sll_tp_pedido  where id_organization =  :id_organization",
		    nativeQuery = true
		  )

	public List<M4sllTpPedido> findTpPedido(@Param("id_organization") String id_organization);

}


