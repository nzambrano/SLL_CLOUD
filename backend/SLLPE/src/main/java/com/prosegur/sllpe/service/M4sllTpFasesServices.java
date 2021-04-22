package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.domain.M4sllTpFasesId;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;

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
public class M4sllTpFasesServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpFasesServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpFasesRepository m4sllTpFasesRepository;

    public M4sllTpFasesServices(M4sllTpFasesRepository m4sllTpFasesRepository) {
        this.m4sllTpFasesRepository = m4sllTpFasesRepository;
    }

    public boolean casteoError(M4sllTpFases m4sllTpFases) {
        return m4sllTpFases != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpFases m4sllTpFases) {
        return m4sllTpFasesRepository.obtenerUltimaSecuencia(m4sllTpFases.getId().getIdOrganization());
    }

    public List<M4sllTpFases> saveAllWithSecuencia(List<M4sllTpFases> listM4sllTpFases)  {
        listM4sllTpFases.stream().forEach((m4sllTpFases) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpFases);
            M4sllTpFasesId id = new M4sllTpFasesId();
            id.setTfaIdTpFase(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_fases id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpFases.setId(id);
            m4sllTpFasesRepository.save(m4sllTpFases);
        });
        return listM4sllTpFases;
    }
}
