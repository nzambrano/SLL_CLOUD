package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllCpeCejpjD;
import com.prosegur.sllpe.domain.M4sllCpeCejpjDId;
import com.prosegur.sllpe.repository.M4sllCpeCejpjDRepository;

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
public class M4sllCpeCejpjDServices {
    private final Logger log = LoggerFactory.getLogger(M4sllCpeCejpjDServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository;

    public M4sllCpeCejpjDServices(M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository) {
        this.m4sllCpeCejpjDRepository = m4sllCpeCejpjDRepository;
    }

    public boolean casteoError(M4sllCpeCejpjD m4sllCpeCejpjD) {
        return m4sllCpeCejpjD != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllCpeCejpjD m4sllCpeCejpjD) {
        return m4sllCpeCejpjDRepository.obtenerUltimaSecuencia(m4sllCpeCejpjD.getId().getIdOrganization(), m4sllCpeCejpjD.getId().getLitIdLitigio());
    }

    public List<M4sllCpeCejpjD> saveAllWithSecuencia(List<M4sllCpeCejpjD> listM4sllCpeCejpjD)  {
        listM4sllCpeCejpjD.stream().forEach((m4sllCpeCejpjD) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllCpeCejpjD);
            M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
            id.setCcdIdSecuencia(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setLitIdLitigio(m4sllCpeCejpjD.getId().getLitIdLitigio());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_cpe_cejpj_d id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllCpeCejpjD.setId(id);
            m4sllCpeCejpjDRepository.save(m4sllCpeCejpjD);
        });
        return listM4sllCpeCejpjD;
    }
}
