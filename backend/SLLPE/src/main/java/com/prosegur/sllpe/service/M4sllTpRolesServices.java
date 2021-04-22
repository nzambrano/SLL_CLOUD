package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpRoles;
import com.prosegur.sllpe.domain.M4sllTpRolesId;
import com.prosegur.sllpe.repository.M4sllTpRolesRepository;

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
public class M4sllTpRolesServices {
    private final Logger log = LoggerFactory.getLogger(M4sllTpRolesServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final M4sllTpRolesRepository m4sllTpRolesRepository;

    public M4sllTpRolesServices(M4sllTpRolesRepository m4sllTpRolesRepository) {
        this.m4sllTpRolesRepository = m4sllTpRolesRepository;
    }

    public boolean casteoError(M4sllTpRoles m4sllTpRoles) {
        return m4sllTpRoles != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllTpRoles m4sllTpRoles) {
        return m4sllTpRolesRepository.obtenerUltimaSecuencia(m4sllTpRoles.getId().getIdOrganization());
    }

    public List<M4sllTpRoles> saveAllWithSecuencia(List<M4sllTpRoles> listM4sllTpRoles)  {
        listM4sllTpRoles.stream().forEach((m4sllTpRoles) -> {
            Long ultimaSecuencia = UltimaSecuencia(m4sllTpRoles);
            M4sllTpRolesId id = new M4sllTpRolesId();
            id.setTprIdTpRol(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert m4sll_tp_roles id: {}, seq: {}", classToString, ultimaSecuencia);

            m4sllTpRoles.setId(id);
            m4sllTpRolesRepository.save(m4sllTpRoles);
        });
        return listM4sllTpRoles;
    }
}
