package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTribunales;
import com.prosegur.sllpe.domain.M4sllTribunalesId;
import com.prosegur.sllpe.repository.M4sllTribunalesRepository;

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
public class M4sllTribunalesServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTribunalesServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTribunalesRepository m4sllTribunalesRepository;

    public M4sllTribunalesServices(M4sllTribunalesRepository m4sllTribunalesRepository) {
        this.m4sllTribunalesRepository = m4sllTribunalesRepository;
    }

    public boolean casteoError(M4sllTribunales m4sllTribunales) {
        return m4sllTribunales != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTribunales m4sllTribunales) {
        return m4sllTribunalesRepository.obtenerUltimaSecuencia(m4sllTribunales.getId().getIdOrganization());
    }

    public List<M4sllTribunales> saveAllWithSecuencia(List<M4sllTribunales> listM4sllTribunales)  {
        listM4sllTribunales.stream().forEach((m4sllTribunales) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTribunales);
            M4sllTribunalesId id = new M4sllTribunalesId();
            id.setTriIdTribunal(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tribunales id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTribunales.setId(id);
            m4sllTribunalesRepository.save(m4sllTribunales);
        });
        return listM4sllTribunales;
    }
}
