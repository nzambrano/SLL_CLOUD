package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpCompromis;
import com.prosegur.sllpe.domain.M4sllTpCompromisId;
import com.prosegur.sllpe.repository.M4sllTpCompromisRepository;

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
public class M4sllTpCompromisServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpCompromisServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpCompromisRepository m4sllTpCompromisRepository;

    public M4sllTpCompromisServices(M4sllTpCompromisRepository m4sllTpCompromisRepository) {
        this.m4sllTpCompromisRepository = m4sllTpCompromisRepository;
    }

    public boolean casteoError(M4sllTpCompromis m4sllTpCompromis) {
        return m4sllTpCompromis != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpCompromis m4sllTpCompromis) {
        return m4sllTpCompromisRepository.obtenerUltimaSecuencia(m4sllTpCompromis.getId().getIdOrganization());
    }

    public List<M4sllTpCompromis> saveAllWithSecuencia(List<M4sllTpCompromis> listM4sllTpCompromis)  {
        listM4sllTpCompromis.stream().forEach((m4sllTpCompromis) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpCompromis);
            M4sllTpCompromisId id = new M4sllTpCompromisId();
            id.setTcoIdTpCompromiso(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_compromis id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpCompromis.setId(id);
            m4sllTpCompromisRepository.save(m4sllTpCompromis);
        });
        return listM4sllTpCompromis;
    }
}
