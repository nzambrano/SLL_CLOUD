package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpLitigios;
import com.prosegur.sllpe.domain.M4sllTpLitigiosId;
import com.prosegur.sllpe.repository.M4sllTpLitigiosRepository;

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
public class M4sllTpLitigiosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpLitigiosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpLitigiosRepository m4sllTpLitigiosRepository;

    public M4sllTpLitigiosServices(M4sllTpLitigiosRepository m4sllTpLitigiosRepository) {
        this.m4sllTpLitigiosRepository = m4sllTpLitigiosRepository;
    }

    public boolean casteoError(M4sllTpLitigios m4sllTpLitigios) {
        return m4sllTpLitigios != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpLitigios m4sllTpLitigios) {
        return m4sllTpLitigiosRepository.obtenerUltimaSecuencia(m4sllTpLitigios.getId().getIdOrganization());
    }

    public List<M4sllTpLitigios> saveAllWithSecuencia(List<M4sllTpLitigios> listM4sllTpLitigios)  {
        listM4sllTpLitigios.stream().forEach((m4sllTpLitigios) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpLitigios);
            M4sllTpLitigiosId id = new M4sllTpLitigiosId();
            id.setTplIdTpLitigio(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_litigios id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpLitigios.setId(id);
            m4sllTpLitigiosRepository.save(m4sllTpLitigios);
        });
        return listM4sllTpLitigios;
    }
}
