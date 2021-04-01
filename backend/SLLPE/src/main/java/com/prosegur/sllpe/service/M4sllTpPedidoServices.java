package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.repository.M4sllTpPedidoRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpPedidoServices {

    private final M4sllTpPedidoRepository M4sllTpPedidoRepository;

    public M4sllTpPedidoServices(M4sllTpPedidoRepository m4sllTpPedidoRepository) {
        this.M4sllTpPedidoRepository = m4sllTpPedidoRepository;
    }

    public boolean casteoError(M4sllTpPedido m4sllTpPedido) {
        return m4sllTpPedido != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpPedido m4sllTpPedido) {
        return M4sllTpPedidoRepository.obtenerUltimaSecuencia(m4sllTpPedido.getId().getIdOrganization());
    }
}
