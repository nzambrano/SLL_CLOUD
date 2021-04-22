package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpIdentific;
import com.prosegur.sllpe.domain.M4sllTpIdentificId;
import com.prosegur.sllpe.repository.M4sllTpIdentificRepository;

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
public class M4sllTpIdentificServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpIdentificServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpIdentificRepository m4sllTpIdentificRepository;

    public M4sllTpIdentificServices(M4sllTpIdentificRepository m4sllTpIdentificRepository) {
        this.m4sllTpIdentificRepository = m4sllTpIdentificRepository;
    }

    public boolean casteoError(M4sllTpIdentific m4sllTpIdentific) {
        return m4sllTpIdentific != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpIdentific m4sllTpIdentific) {
        return m4sllTpIdentificRepository.obtenerUltimaSecuencia(m4sllTpIdentific.getId().getIdOrganization());
    }

    public List<M4sllTpIdentific> saveAllWithSecuencia(List<M4sllTpIdentific> listM4sllTpIdentific)  {
        listM4sllTpIdentific.stream().forEach((m4sllTpIdentific) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpIdentific);
            M4sllTpIdentificId id = new M4sllTpIdentificId();
            id.setTpiIdTpIdentificacion(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_identific id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpIdentific.setId(id);
            m4sllTpIdentificRepository.save(m4sllTpIdentific);
        });
        return listM4sllTpIdentific;
    }
}
