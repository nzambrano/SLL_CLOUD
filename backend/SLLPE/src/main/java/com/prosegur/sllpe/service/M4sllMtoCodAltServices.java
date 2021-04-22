package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtoCodAlt;
import com.prosegur.sllpe.domain.M4sllMtoCodAltId;
import com.prosegur.sllpe.repository.M4sllMtoCodAltRepository;

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
public class M4sllMtoCodAltServices {
    private final Logger log = LoggerFactory.getLogger(M4sllMtoCodAltServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllMtoCodAltRepository m4sllMtoCodAltRepository;

    public M4sllMtoCodAltServices(M4sllMtoCodAltRepository m4sllMtoCodAltRepository) {
        this.m4sllMtoCodAltRepository = m4sllMtoCodAltRepository;
    }

    public boolean casteoError(M4sllMtoCodAlt m4sllMtoCodAlt) {
        return m4sllMtoCodAlt != null ? true : false;
    }

    public String UltimaSecuencia(M4sllMtoCodAlt m4sllMtoCodAlt) {
        return m4sllMtoCodAltRepository.obtenerUltimaSecuencia(m4sllMtoCodAlt.getId().getIdOrganization());
    }

    public List<M4sllMtoCodAlt> saveAllWithSecuencia(List<M4sllMtoCodAlt> listM4sllMtoCodAlt)  {
        listM4sllMtoCodAlt.stream().forEach((m4sllMtoCodAlt) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllMtoCodAlt);
            M4sllMtoCodAltId id = new M4sllMtoCodAltId();
            id.setMcaIdCodigoAlterno(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_mto_cod_alt id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllMtoCodAlt.setId(id);
            m4sllMtoCodAltRepository.save(m4sllMtoCodAlt);
        });
        return listM4sllMtoCodAlt;
    }
}
