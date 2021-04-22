package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpRecurren;
import com.prosegur.sllpe.domain.M4sllTpRecurrenId;
import com.prosegur.sllpe.repository.M4sllTpRecurrenRepository;

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
public class M4sllTpRecurrenServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpRecurrenServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpRecurrenRepository m4sllTpRecurrenRepository;

    public M4sllTpRecurrenServices(M4sllTpRecurrenRepository m4sllTpRecurrenRepository) {
        this.m4sllTpRecurrenRepository = m4sllTpRecurrenRepository;
    }

    public boolean casteoError(M4sllTpRecurren m4sllTpRecurren) {
        return m4sllTpRecurren != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpRecurren m4sllTpRecurren) {
        return m4sllTpRecurrenRepository.obtenerUltimaSecuencia(m4sllTpRecurren.getId().getIdOrganization());
    }

    public List<M4sllTpRecurren> saveAllWithSecuencia(List<M4sllTpRecurren> listM4sllTpRecurren)  {
        listM4sllTpRecurren.stream().forEach((m4sllTpRecurren) -> {
            String ultimaSecuencia = UltimaSecuencia(m4sllTpRecurren);
            M4sllTpRecurrenId id = new M4sllTpRecurrenId();
            id.setTreIdRecurrencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_recurren id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpRecurren.setId(id);
            m4sllTpRecurrenRepository.save(m4sllTpRecurren);
        });
        return listM4sllTpRecurren;
    }
}
