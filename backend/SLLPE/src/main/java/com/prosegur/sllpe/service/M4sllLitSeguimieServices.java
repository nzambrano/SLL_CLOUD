package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllLitSeguimie;
import com.prosegur.sllpe.domain.M4sllLitSeguimieId;
import com.prosegur.sllpe.repository.M4sllLitSeguimieRepository;

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
public class M4sllLitSeguimieServices {
    private final Logger log = LoggerFactory.getLogger(M4sllLitSeguimieServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllLitSeguimieRepository m4sllLitSeguimieRepository;

    public M4sllLitSeguimieServices(M4sllLitSeguimieRepository m4sllLitSeguimieRepository) {
        this.m4sllLitSeguimieRepository = m4sllLitSeguimieRepository;
    }

    public boolean casteoError(M4sllLitSeguimie m4sllLitSeguimie) {
        return m4sllLitSeguimie != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllLitSeguimie m4sllLitSeguimie) {
        return m4sllLitSeguimieRepository.obtenerUltimaSecuencia(m4sllLitSeguimie.getId().getIdOrganization(), m4sllLitSeguimie.getId().getLitIdLitigio());
    }

    public List<M4sllLitSeguimie> saveAllWithSecuencia(List<M4sllLitSeguimie> listM4sllLitSeguimie)  {
        listM4sllLitSeguimie.stream().forEach((m4sllLitSeguimie) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllLitSeguimie);
            M4sllLitSeguimieId id = new M4sllLitSeguimieId();
            id.setLisSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setLitIdLitigio(m4sllLitSeguimie.getId().getLitIdLitigio());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_lit_seguimie id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllLitSeguimie.setId(id);
            m4sllLitSeguimieRepository.save(m4sllLitSeguimie);
        });
        return listM4sllLitSeguimie;
    }
}
