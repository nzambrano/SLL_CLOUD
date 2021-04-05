package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpRoles;
import com.prosegur.sllpe.repository.M4sllTpRolesRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpRolesServices {

    private final M4sllTpRolesRepository M4sllTpRolesRepository;

    public M4sllTpRolesServices(M4sllTpRolesRepository m4sllTpRolesRepository) {
        this.M4sllTpRolesRepository = m4sllTpRolesRepository;
    }

    public boolean casteoError(M4sllTpRoles m4sllTpRoles) {
        return m4sllTpRoles != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllTpRoles m4sllTpRoles) {
        return M4sllTpRolesRepository.obtenerUltimaSecuencia(m4sllTpRoles.getId().getIdOrganization());
    }
}
