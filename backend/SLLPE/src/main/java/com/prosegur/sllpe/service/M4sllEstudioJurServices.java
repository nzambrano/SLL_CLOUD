package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllEstudioJurServices {

    private final M4sllEstudioJurRepository M4sllEstudioJurRepository;

    public M4sllEstudioJurServices(M4sllEstudioJurRepository m4sllEstudioJurRepository) {
        this.M4sllEstudioJurRepository = m4sllEstudioJurRepository;
    }

    public boolean casteoError(M4sllEstudioJur m4sllEstudioJur) {
        return m4sllEstudioJur != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllEstudioJur m4sllEstudioJur) {
        return M4sllEstudioJurRepository.obtenerUltimaSecuencia(m4sllEstudioJur.getId().getIdOrganization());
    }
}
