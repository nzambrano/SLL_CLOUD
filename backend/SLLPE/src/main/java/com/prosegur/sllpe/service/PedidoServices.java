package com.prosegur.sllpe.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllPedidos;
import com.prosegur.sllpe.repository.M4sllPedidosRepository;


@Service
@Transactional

public class PedidoServices {

	private final M4sllPedidosRepository M4sllPedidosRepository;
	
	public PedidoServices(M4sllPedidosRepository M4sllPedidosRepository) {
		this.M4sllPedidosRepository = M4sllPedidosRepository;
	}
	
	public boolean casteoError(M4sllPedidos pedidosLit) {
		return pedidosLit != null ? true: false;
 	}
	
	
	public  Long UltimaSecuencia(M4sllPedidos pedidosLit) {
		return  M4sllPedidosRepository.obtenerUltimaSecuencia(pedidosLit.getId().getLitIdLitigio(), pedidosLit.getId().getIdOrganization());
	}
}
