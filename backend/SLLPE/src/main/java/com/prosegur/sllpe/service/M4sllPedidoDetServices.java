package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllPedidoDet;
import com.prosegur.sllpe.domain.M4sllPedidoDetId;
import com.prosegur.sllpe.repository.M4sllPedidoDetRepository;

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
public class M4sllPedidoDetServices {
    private final Logger log = LoggerFactory.getLogger(M4sllPedidoDetServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllPedidoDetRepository m4sllPedidoDetRepository;

    public M4sllPedidoDetServices(M4sllPedidoDetRepository m4sllPedidoDetRepository) {
        this.m4sllPedidoDetRepository = m4sllPedidoDetRepository;
    }

    public boolean casteoError(M4sllPedidoDet m4sllPedidoDet) {
        return m4sllPedidoDet != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllPedidoDet m4sllPedidoDet) {
        return m4sllPedidoDetRepository.obtenerUltimaSecuencia(m4sllPedidoDet.getId().getIdOrganization(), m4sllPedidoDet.getId().getLitIdLitigio(), m4sllPedidoDet.getId().getTpeIdPedido());
    }

    public List<M4sllPedidoDet> saveAllWithSecuencia(List<M4sllPedidoDet> listM4sllPedidoDet)  {
        listM4sllPedidoDet.stream().forEach((m4sllPedidoDet) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllPedidoDet);
            M4sllPedidoDetId id = new M4sllPedidoDetId();
            id.setPdeSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setLitIdLitigio(m4sllPedidoDet.getId().getLitIdLitigio());
            id.setTpeIdPedido(m4sllPedidoDet.getId().getTpeIdPedido());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_pedido_det id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllPedidoDet.setId(id);
            m4sllPedidoDetRepository.save(m4sllPedidoDet);
        });
        return listM4sllPedidoDet;
    }
}
