package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpValEco;
import com.prosegur.sllpe.domain.M4sllTpValEcoId;
import com.prosegur.sllpe.repository.M4sllTpValEcoRepository;

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
public class M4sllTpValEcoServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpValEcoServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpValEcoRepository m4sllTpValEcoRepository;

    public M4sllTpValEcoServices(M4sllTpValEcoRepository m4sllTpValEcoRepository) {
        this.m4sllTpValEcoRepository = m4sllTpValEcoRepository;
    }

    public boolean casteoError(M4sllTpValEco m4sllTpValEco) {
        return m4sllTpValEco != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpValEco m4sllTpValEco) {
        return m4sllTpValEcoRepository.obtenerUltimaSecuencia(m4sllTpValEco.getId().getIdOrganization());
    }

    public List<M4sllTpValEco> saveAllWithSecuencia(List<M4sllTpValEco> listM4sllTpValEco)  {
        listM4sllTpValEco.stream().forEach((m4sllTpValEco) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpValEco);
            M4sllTpValEcoId id = new M4sllTpValEcoId();
            id.setTveIdValEco(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_val_eco id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpValEco.setId(id);
            m4sllTpValEcoRepository.save(m4sllTpValEco);
        });
        return listM4sllTpValEco;
    }
}
