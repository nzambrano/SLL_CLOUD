package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtoSegInte;
import com.prosegur.sllpe.domain.M4sllMtoSegInteId;
import com.prosegur.sllpe.repository.M4sllMtoSegInteRepository;

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
public class M4sllMtoSegInteServices {
    private final Logger log = LoggerFactory.getLogger(M4sllMtoSegInteServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllMtoSegInteRepository m4sllMtoSegInteRepository;

    public M4sllMtoSegInteServices(M4sllMtoSegInteRepository m4sllMtoSegInteRepository) {
        this.m4sllMtoSegInteRepository = m4sllMtoSegInteRepository;
    }

    public boolean casteoError(M4sllMtoSegInte m4sllMtoSegInte) {
        return m4sllMtoSegInte != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllMtoSegInte m4sllMtoSegInte) {
        return m4sllMtoSegInteRepository.obtenerUltimaSecuencia(m4sllMtoSegInte.getId().getIdOrganization(), m4sllMtoSegInte.getId().getIdAppRole());
    }

    public List<M4sllMtoSegInte> saveAllWithSecuencia(List<M4sllMtoSegInte> listM4sllMtoSegInte)  {
        listM4sllMtoSegInte.stream().forEach((m4sllMtoSegInte) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllMtoSegInte);
            M4sllMtoSegInteId id = new M4sllMtoSegInteId();
            id.setMsiSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setIdAppRole(m4sllMtoSegInte.getId().getIdAppRole());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_mto_seg_inte id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllMtoSegInte.setId(id);
            m4sllMtoSegInteRepository.save(m4sllMtoSegInte);
        });
        return listM4sllMtoSegInte;
    }
}
