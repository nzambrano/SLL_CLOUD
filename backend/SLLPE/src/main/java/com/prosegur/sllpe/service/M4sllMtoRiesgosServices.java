package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtoRiesgos;
import com.prosegur.sllpe.domain.M4sllMtoRiesgosId;
import com.prosegur.sllpe.repository.M4sllMtoRiesgosRepository;

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
public class M4sllMtoRiesgosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllMtoRiesgosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository;

    public M4sllMtoRiesgosServices(M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository) {
        this.m4sllMtoRiesgosRepository = m4sllMtoRiesgosRepository;
    }

    public boolean casteoError(M4sllMtoRiesgos m4sllMtoRiesgos) {
        return m4sllMtoRiesgos != null ? true : false;
    }

    public String UltimaSecuencia(M4sllMtoRiesgos m4sllMtoRiesgos) {
        return m4sllMtoRiesgosRepository.obtenerUltimaSecuencia(m4sllMtoRiesgos.getId().getIdOrganization());
    }

    public List<M4sllMtoRiesgos> saveAllWithSecuencia(List<M4sllMtoRiesgos> listM4sllMtoRiesgos)  {
        listM4sllMtoRiesgos.stream().forEach((m4sllMtoRiesgos) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllMtoRiesgos);
            M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
            id.setMriIdRiesgo(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_mto_riesgos id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllMtoRiesgos.setId(id);
            m4sllMtoRiesgosRepository.save(m4sllMtoRiesgos);
        });
        return listM4sllMtoRiesgos;
    }
}
