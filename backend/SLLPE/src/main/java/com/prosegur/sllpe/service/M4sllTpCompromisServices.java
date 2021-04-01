package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpCompromis;
import com.prosegur.sllpe.repository.M4sllTpCompromisRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpCompromisServices {

    private final M4sllTpCompromisRepository M4sllTpCompromisRepository;

    public M4sllTpCompromisServices(M4sllTpCompromisRepository m4sllTpCompromisRepository) {
        this.M4sllTpCompromisRepository = m4sllTpCompromisRepository;
    }

    public boolean casteoError(M4sllTpCompromis m4sllTpCompromis) {
        return m4sllTpCompromis != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpCompromis m4sllTpCompromis) {
        return M4sllTpCompromisRepository.obtenerUltimaSecuencia(m4sllTpCompromis.getId().getIdOrganization());
    }
}
