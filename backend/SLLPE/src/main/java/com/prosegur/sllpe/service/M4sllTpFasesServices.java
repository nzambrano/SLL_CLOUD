package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpFasesServices {

    private final M4sllTpFasesRepository M4sllTpFasesRepository;

    public M4sllTpFasesServices(M4sllTpFasesRepository m4sllTpFasesRepository) {
        this.M4sllTpFasesRepository = m4sllTpFasesRepository;
    }

    public boolean casteoError(M4sllTpFases m4sllTpFases) {
        return m4sllTpFases != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpFases m4sllTpFases) {
        return M4sllTpFasesRepository.obtenerUltimaSecuencia(m4sllTpFases.getId().getIdOrganization());
    }
}
