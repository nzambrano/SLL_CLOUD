package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.repository.M4sllTpDocLitigRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpDocLitigServices {

    private final M4sllTpDocLitigRepository M4sllTpDocLitigRepository;

    public M4sllTpDocLitigServices(M4sllTpDocLitigRepository m4sllTpDocLitigRepository) {
        this.M4sllTpDocLitigRepository = m4sllTpDocLitigRepository;
    }

    public boolean casteoError(M4sllTpDocLitig m4sllTpDocLitig) {
        return m4sllTpDocLitig != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpDocLitig m4sllTpDocLitig) {
        return M4sllTpDocLitigRepository.obtenerUltimaSecuencia(m4sllTpDocLitig.getId().getIdOrganization());
    }
}
