package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpPagos;
import com.prosegur.sllpe.domain.M4sllTpPagosId;
import com.prosegur.sllpe.repository.M4sllTpPagosRepository;

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
public class M4sllTpPagosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpPagosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpPagosRepository m4sllTpPagosRepository;

    public M4sllTpPagosServices(M4sllTpPagosRepository m4sllTpPagosRepository) {
        this.m4sllTpPagosRepository = m4sllTpPagosRepository;
    }

    public boolean casteoError(M4sllTpPagos m4sllTpPagos) {
        return m4sllTpPagos != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpPagos m4sllTpPagos) {
        return m4sllTpPagosRepository.obtenerUltimaSecuencia(m4sllTpPagos.getId().getIdOrganization());
    }

    public List<M4sllTpPagos> saveAllWithSecuencia(List<M4sllTpPagos> listM4sllTpPagos)  {
        listM4sllTpPagos.stream().forEach((m4sllTpPagos) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpPagos);
            M4sllTpPagosId id = new M4sllTpPagosId();
            id.setTpaIdPago(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_pagos id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpPagos.setId(id);
            m4sllTpPagosRepository.save(m4sllTpPagos);
        });
        return listM4sllTpPagos;
    }
}
