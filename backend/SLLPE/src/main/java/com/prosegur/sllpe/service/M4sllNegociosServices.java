package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.domain.M4sllNegociosId;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;

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
public class M4sllNegociosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllNegociosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllNegociosRepository m4sllNegociosRepository;

    public M4sllNegociosServices(M4sllNegociosRepository m4sllNegociosRepository) {
        this.m4sllNegociosRepository = m4sllNegociosRepository;
    }

    public boolean casteoError(M4sllNegocios m4sllNegocios) {
        return m4sllNegocios != null ? true : false;
    }

    public String UltimaSecuencia(M4sllNegocios m4sllNegocios) {
        return m4sllNegociosRepository.obtenerUltimaSecuencia(m4sllNegocios.getId().getIdOrganization());
    }

    public List<M4sllNegocios> saveAllWithSecuencia(List<M4sllNegocios> listM4sllNegocios)  {
        listM4sllNegocios.stream().forEach((m4sllNegocios) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllNegocios);
            M4sllNegociosId id = new M4sllNegociosId();
            id.setNegIdNegocio(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_negocios id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllNegocios.setId(id);
            m4sllNegociosRepository.save(m4sllNegocios);
        });
        return listM4sllNegocios;
    }
}
