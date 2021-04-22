package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.domain.M4sllEstudioJurId;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;

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
public class M4sllEstudioJurServices {
    private final Logger log = LoggerFactory.getLogger(M4sllEstudioJurServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllEstudioJurRepository m4sllEstudioJurRepository;

    public M4sllEstudioJurServices(M4sllEstudioJurRepository m4sllEstudioJurRepository) {
        this.m4sllEstudioJurRepository = m4sllEstudioJurRepository;
    }

    public boolean casteoError(M4sllEstudioJur m4sllEstudioJur) {
        return m4sllEstudioJur != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllEstudioJur m4sllEstudioJur) {
        return m4sllEstudioJurRepository.obtenerUltimaSecuencia(m4sllEstudioJur.getId().getIdOrganization());
    }

    public List<M4sllEstudioJur> saveAllWithSecuencia(List<M4sllEstudioJur> listM4sllEstudioJur)  {
        listM4sllEstudioJur.stream().forEach((m4sllEstudioJur) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllEstudioJur);
            M4sllEstudioJurId id = new M4sllEstudioJurId();
            id.setEjuIdEstJuridico(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_estudio_jur id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllEstudioJur.setId(id);
            m4sllEstudioJurRepository.save(m4sllEstudioJur);
        });
        return listM4sllEstudioJur;
    }
}
