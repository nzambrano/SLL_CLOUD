package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.domain.M4sllMtAbogadosId;
import com.prosegur.sllpe.repository.M4sllMtAbogadosRepository;

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
public class M4sllMtAbogadosServices {
    private final Logger log = LoggerFactory.getLogger(M4sllMtAbogadosServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllMtAbogadosRepository m4sllMtAbogadosRepository;

    public M4sllMtAbogadosServices(M4sllMtAbogadosRepository m4sllMtAbogadosRepository) {
        this.m4sllMtAbogadosRepository = m4sllMtAbogadosRepository;
    }

    public boolean casteoError(M4sllMtAbogados m4sllMtAbogados) {
        return m4sllMtAbogados != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllMtAbogados m4sllMtAbogados) {
        return m4sllMtAbogadosRepository.obtenerUltimaSecuencia(m4sllMtAbogados.getId().getIdOrganization());
    }

    public List<M4sllMtAbogados> saveAllWithSecuencia(List<M4sllMtAbogados> listM4sllMtAbogados)  {
        listM4sllMtAbogados.stream().forEach((m4sllMtAbogados) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllMtAbogados);
            M4sllMtAbogadosId id = new M4sllMtAbogadosId();
            id.setMabSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_mt_abogados id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllMtAbogados.setId(id);
            m4sllMtAbogadosRepository.save(m4sllMtAbogados);
        });
        return listM4sllMtAbogados;
    }
}
