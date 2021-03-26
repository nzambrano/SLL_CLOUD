package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllPedidoDet;
import com.prosegur.sllpe.repository.M4sllPedidoDetRepository;
// import java.util.List;

// import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllPedidoDetServices {

  private final M4sllPedidoDetRepository M4sllPedidoDetRepository;

  public M4sllPedidoDetServices(M4sllPedidoDetRepository m4sllPedidoDetRepository) {
    this.M4sllPedidoDetRepository = m4sllPedidoDetRepository;
  }

  public boolean casteoError(M4sllPedidoDet m4sllPedidoDet) {
    return m4sllPedidoDet != null ? true : false;
  }

  public Long UltimaSecuencia(M4sllPedidoDet m4sllPedidoDet) {
    return M4sllPedidoDetRepository.obtenerUltimaSecuencia(
      m4sllPedidoDet.getId().getIdOrganization(),
      m4sllPedidoDet.getId().getLitIdLitigio(),
      m4sllPedidoDet.getId().getTpeIdPedido()
    );
  }
}
