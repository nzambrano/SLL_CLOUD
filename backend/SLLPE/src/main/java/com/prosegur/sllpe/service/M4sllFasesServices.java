package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import com.prosegur.sllpe.repository.M4sllFasesRepository;

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
public class M4sllFasesServices {
    private final Logger log = LoggerFactory.getLogger(M4sllFasesServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllFasesRepository m4sllFasesRepository;

    public M4sllFasesServices(M4sllFasesRepository m4sllFasesRepository) {
        this.m4sllFasesRepository = m4sllFasesRepository;
    }

    public boolean casteoError(M4sllFases m4sllFases) {
        return m4sllFases != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllFases m4sllFases) {
        return m4sllFasesRepository.obtenerUltimaSecuencia(m4sllFases.getId().getIdOrganization(), m4sllFases.getId().getLitIdLitigio(), m4sllFases.getId().getTfaIdTpFase());
    }

    public List<M4sllFases> saveAllWithSecuencia(List<M4sllFases> listM4sllFases)  {
        listM4sllFases.stream().forEach((m4sllFases) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllFases);
            M4sllFasesId id = new M4sllFasesId();

            id.setIdOrganization(idOrganization);
            id.setLitIdLitigio(m4sllFases.getId().getLitIdLitigio());
            id.setTfaIdTpFase(m4sllFases.getId().getTfaIdTpFase());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_fases id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllFases.setId(id);
            m4sllFasesRepository.save(m4sllFases);
        });
        return listM4sllFases;
    }
}
