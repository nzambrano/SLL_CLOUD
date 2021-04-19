package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllDocLitigios;
import com.prosegur.sllpe.domain.M4sllDocLitigiosId;
import com.prosegur.sllpe.repository.M4sllDocLitigiosRepository;

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
public class M4sllDocLitigiosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllDocLitigiosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllDocLitigiosRepository m4sllDocLitigiosRepository;

    public M4sllDocLitigiosServices(M4sllDocLitigiosRepository m4sllDocLitigiosRepository) {
        this.m4sllDocLitigiosRepository = m4sllDocLitigiosRepository;
    }

    public boolean casteoError(M4sllDocLitigios m4sllDocLitigios) {
        return m4sllDocLitigios != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllDocLitigios m4sllDocLitigios) {
        return m4sllDocLitigiosRepository.obtenerUltimaSecuencia(m4sllDocLitigios.getId().getIdOrganization(), m4sllDocLitigios.getId().getLitIdLitigio());
    }

    public List<M4sllDocLitigios> saveAllWithSecuencia(List<M4sllDocLitigios> listM4sllDocLitigios)  {
        listM4sllDocLitigios.stream().forEach((m4sllDocLitigios) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllDocLitigios);
            M4sllDocLitigiosId id = new M4sllDocLitigiosId();
            id.setDolSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setLitIdLitigio(m4sllDocLitigios.getId().getLitIdLitigio());

            log.info("idOrganization: {}", idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.info("REST request to insert m4sll_doc_litigios id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllDocLitigios.setId(id);
            m4sllDocLitigiosRepository.save(m4sllDocLitigios);
        });
        return listM4sllDocLitigios;
    }
}
