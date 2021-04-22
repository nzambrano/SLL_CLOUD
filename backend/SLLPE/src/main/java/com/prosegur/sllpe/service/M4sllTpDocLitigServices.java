package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.domain.M4sllTpDocLitigId;
import com.prosegur.sllpe.repository.M4sllTpDocLitigRepository;

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
public class M4sllTpDocLitigServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpDocLitigServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpDocLitigRepository m4sllTpDocLitigRepository;

    public M4sllTpDocLitigServices(M4sllTpDocLitigRepository m4sllTpDocLitigRepository) {
        this.m4sllTpDocLitigRepository = m4sllTpDocLitigRepository;
    }

    public boolean casteoError(M4sllTpDocLitig m4sllTpDocLitig) {
        return m4sllTpDocLitig != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpDocLitig m4sllTpDocLitig) {
        return m4sllTpDocLitigRepository.obtenerUltimaSecuencia(m4sllTpDocLitig.getId().getIdOrganization());
    }

    public List<M4sllTpDocLitig> saveAllWithSecuencia(List<M4sllTpDocLitig> listM4sllTpDocLitig)  {
        listM4sllTpDocLitig.stream().forEach((m4sllTpDocLitig) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpDocLitig);
            M4sllTpDocLitigId id = new M4sllTpDocLitigId();
            id.setTdlIdTpDocLitigio(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_doc_litig id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpDocLitig.setId(id);
            m4sllTpDocLitigRepository.save(m4sllTpDocLitig);
        });
        return listM4sllTpDocLitig;
    }
}
