package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.domain.M4sllTpPedidoId;
import com.prosegur.sllpe.repository.M4sllTpPedidoRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import java.util.List;
import java.util.Collection;

@Service
@Transactional
public class M4sllTpPedidoServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpPedidoServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpPedidoRepository m4sllTpPedidoRepository;

    public M4sllTpPedidoServices(M4sllTpPedidoRepository m4sllTpPedidoRepository) {
        this.m4sllTpPedidoRepository = m4sllTpPedidoRepository;
    }

    public boolean casteoError(M4sllTpPedido m4sllTpPedido) {
        return m4sllTpPedido != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpPedido m4sllTpPedido) {
        return m4sllTpPedidoRepository.obtenerUltimaSecuencia(m4sllTpPedido.getId().getIdOrganization());
    }

    public List<M4sllTpPedido> saveAllWithSecuencia(List<M4sllTpPedido> listM4sllTpPedido)  {
        listM4sllTpPedido.stream().forEach((m4sllTpPedido) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpPedido);
            M4sllTpPedidoId id = new M4sllTpPedidoId();
            id.setTpeIdPedido(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_pedido id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpPedido.setId(id);
            m4sllTpPedidoRepository.save(m4sllTpPedido);
        });
        return listM4sllTpPedido;
    }
}
