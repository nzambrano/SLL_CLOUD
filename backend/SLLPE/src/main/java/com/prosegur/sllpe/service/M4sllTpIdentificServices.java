package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpIdentific;
import com.prosegur.sllpe.repository.M4sllTpIdentificRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpIdentificServices {

    private final M4sllTpIdentificRepository M4sllTpIdentificRepository;

    public M4sllTpIdentificServices(M4sllTpIdentificRepository m4sllTpIdentificRepository) {
        this.M4sllTpIdentificRepository = m4sllTpIdentificRepository;
    }

    public boolean casteoError(M4sllTpIdentific m4sllTpIdentific) {
        return m4sllTpIdentific != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpIdentific m4sllTpIdentific) {
        return M4sllTpIdentificRepository.obtenerUltimaSecuencia(m4sllTpIdentific.getId().getIdOrganization());
    }
}
