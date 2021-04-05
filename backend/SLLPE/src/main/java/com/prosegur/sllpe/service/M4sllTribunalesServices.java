package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTribunales;
import com.prosegur.sllpe.repository.M4sllTribunalesRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTribunalesServices {

    private final M4sllTribunalesRepository M4sllTribunalesRepository;

    public M4sllTribunalesServices(M4sllTribunalesRepository m4sllTribunalesRepository) {
        this.M4sllTribunalesRepository = m4sllTribunalesRepository;
    }

    public boolean casteoError(M4sllTribunales m4sllTribunales) {
        return m4sllTribunales != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTribunales m4sllTribunales) {
        return M4sllTribunalesRepository.obtenerUltimaSecuencia(m4sllTribunales.getId().getIdOrganization());
    }
}
