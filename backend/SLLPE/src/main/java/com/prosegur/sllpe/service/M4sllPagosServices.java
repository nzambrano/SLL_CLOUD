package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllPagos;
import com.prosegur.sllpe.domain.M4sllPagosId;
import com.prosegur.sllpe.repository.M4sllPagosRepository;

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
public class M4sllPagosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllPagosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllPagosRepository m4sllPagosRepository;

    public M4sllPagosServices(M4sllPagosRepository m4sllPagosRepository) {
        this.m4sllPagosRepository = m4sllPagosRepository;
    }

    public boolean casteoError(M4sllPagos m4sllPagos) {
        return m4sllPagos != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllPagos m4sllPagos) {
        return m4sllPagosRepository.obtenerUltimaSecuencia(m4sllPagos.getId().getIdOrganization(), m4sllPagos.getId().getLitIdLitigio());
    }

    public List<M4sllPagos> saveAllWithSecuencia(List<M4sllPagos> listM4sllPagos)  {
        listM4sllPagos.stream().forEach((m4sllPagos) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllPagos);
            M4sllPagosId id = new M4sllPagosId();
            id.setPagSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setLitIdLitigio(m4sllPagos.getId().getLitIdLitigio());

            log.info("idOrganization: {}", idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.info("REST request to insert m4sll_pagos id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllPagos.setId(id);
            m4sllPagosRepository.save(m4sllPagos);
        });
        return listM4sllPagos;
    }
}
