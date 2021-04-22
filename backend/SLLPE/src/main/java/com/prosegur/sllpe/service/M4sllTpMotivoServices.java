package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpMotivo;
import com.prosegur.sllpe.domain.M4sllTpMotivoId;
import com.prosegur.sllpe.repository.M4sllTpMotivoRepository;

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
public class M4sllTpMotivoServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpMotivoServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpMotivoRepository m4sllTpMotivoRepository;

    public M4sllTpMotivoServices(M4sllTpMotivoRepository m4sllTpMotivoRepository) {
        this.m4sllTpMotivoRepository = m4sllTpMotivoRepository;
    }

    public boolean casteoError(M4sllTpMotivo m4sllTpMotivo) {
        return m4sllTpMotivo != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpMotivo m4sllTpMotivo) {
        return m4sllTpMotivoRepository.obtenerUltimaSecuencia(m4sllTpMotivo.getId().getIdOrganization());
    }

    public List<M4sllTpMotivo> saveAllWithSecuencia(List<M4sllTpMotivo> listM4sllTpMotivo)  {
        listM4sllTpMotivo.stream().forEach((m4sllTpMotivo) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpMotivo);
            M4sllTpMotivoId id = new M4sllTpMotivoId();
            id.setTmoIdTpMotivo(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_motivo id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpMotivo.setId(id);
            m4sllTpMotivoRepository.save(m4sllTpMotivo);
        });
        return listM4sllTpMotivo;
    }
}
