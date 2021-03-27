package com.prosegur.sllpe.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.repository.M4sllTipoPedidoRepository;

@Service
@Transactional

public class TpPedidoServices {

	private final M4sllTipoPedidoRepository M4sllTipoPedidoRepository;
	
	public TpPedidoServices(M4sllTipoPedidoRepository M4sllTipoPedidoRepository) {
		this.M4sllTipoPedidoRepository = M4sllTipoPedidoRepository;
	}
	
	public boolean casteoError(M4sllTpPedido TpPedidoServices) {
		return TpPedidoServices != null ? true: false;
 	}
	
	
	public  Long UltimaSecuencia(M4sllTpPedido TpPedidoServices) {
		return  M4sllTipoPedidoRepository.obtenerUltimaSecuencia(TpPedidoServices.getId().getIdOrganization());
	}
}
