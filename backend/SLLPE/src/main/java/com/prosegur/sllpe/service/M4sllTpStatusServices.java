package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpStatus;
import com.prosegur.sllpe.domain.M4sllTpStatusId;
import com.prosegur.sllpe.repository.M4sllTpStatusRepository;

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
public class M4sllTpStatusServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpStatusServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpStatusRepository m4sllTpStatusRepository;

    public M4sllTpStatusServices(M4sllTpStatusRepository m4sllTpStatusRepository) {
        this.m4sllTpStatusRepository = m4sllTpStatusRepository;
    }

    public boolean casteoError(M4sllTpStatus m4sllTpStatus) {
        return m4sllTpStatus != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpStatus m4sllTpStatus) {
        return m4sllTpStatusRepository.obtenerUltimaSecuencia(m4sllTpStatus.getId().getIdOrganization());
    }

    public List<M4sllTpStatus> saveAllWithSecuencia(List<M4sllTpStatus> listM4sllTpStatus)  {
        listM4sllTpStatus.stream().forEach((m4sllTpStatus) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpStatus);
            M4sllTpStatusId id = new M4sllTpStatusId();
            id.setTstIdTpStatus(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_status id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpStatus.setId(id);
            m4sllTpStatusRepository.save(m4sllTpStatus);
        });
        return listM4sllTpStatus;
    }
}
