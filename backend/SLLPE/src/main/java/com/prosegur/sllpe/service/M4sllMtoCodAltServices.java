package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtoCodAlt;
import com.prosegur.sllpe.repository.M4sllMtoCodAltRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllMtoCodAltServices {

    private final M4sllMtoCodAltRepository M4sllMtoCodAltRepository;

    public M4sllMtoCodAltServices(M4sllMtoCodAltRepository m4sllMtoCodAltRepository) {
        this.M4sllMtoCodAltRepository = m4sllMtoCodAltRepository;
    }

    public boolean casteoError(M4sllMtoCodAlt m4sllMtoCodAlt) {
        return m4sllMtoCodAlt != null ? true : false;
    }

    public String UltimaSecuencia(M4sllMtoCodAlt m4sllMtoCodAlt) {
        return M4sllMtoCodAltRepository.obtenerUltimaSecuencia(m4sllMtoCodAlt.getId().getIdOrganization());
    }
}
