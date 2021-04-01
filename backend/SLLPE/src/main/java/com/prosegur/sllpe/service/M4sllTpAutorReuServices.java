package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpAutorReu;
import com.prosegur.sllpe.repository.M4sllTpAutorReuRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpAutorReuServices {

    private final M4sllTpAutorReuRepository M4sllTpAutorReuRepository;

    public M4sllTpAutorReuServices(M4sllTpAutorReuRepository m4sllTpAutorReuRepository) {
        this.M4sllTpAutorReuRepository = m4sllTpAutorReuRepository;
    }

    public boolean casteoError(M4sllTpAutorReu m4sllTpAutorReu) {
        return m4sllTpAutorReu != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpAutorReu m4sllTpAutorReu) {
        return M4sllTpAutorReuRepository.obtenerUltimaSecuencia(m4sllTpAutorReu.getId().getIdOrganization());
    }
}
