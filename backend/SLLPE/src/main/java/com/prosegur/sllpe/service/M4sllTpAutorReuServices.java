package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpAutorReu;
import com.prosegur.sllpe.domain.M4sllTpAutorReuId;
import com.prosegur.sllpe.repository.M4sllTpAutorReuRepository;

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
public class M4sllTpAutorReuServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpAutorReuServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpAutorReuRepository m4sllTpAutorReuRepository;

    public M4sllTpAutorReuServices(M4sllTpAutorReuRepository m4sllTpAutorReuRepository) {
        this.m4sllTpAutorReuRepository = m4sllTpAutorReuRepository;
    }

    public boolean casteoError(M4sllTpAutorReu m4sllTpAutorReu) {
        return m4sllTpAutorReu != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpAutorReu m4sllTpAutorReu) {
        return m4sllTpAutorReuRepository.obtenerUltimaSecuencia(m4sllTpAutorReu.getId().getIdOrganization());
    }

    public List<M4sllTpAutorReu> saveAllWithSecuencia(List<M4sllTpAutorReu> listM4sllTpAutorReu)  {
        listM4sllTpAutorReu.stream().forEach((m4sllTpAutorReu) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpAutorReu);
            M4sllTpAutorReuId id = new M4sllTpAutorReuId();
            id.setTarIdTpAutorReu(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_autor_reu id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpAutorReu.setId(id);
            m4sllTpAutorReuRepository.save(m4sllTpAutorReu);
        });
        return listM4sllTpAutorReu;
    }
}
