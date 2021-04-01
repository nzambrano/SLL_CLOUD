package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpLitigios;
import com.prosegur.sllpe.repository.M4sllTpLitigiosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpLitigiosServices {

    private final M4sllTpLitigiosRepository M4sllTpLitigiosRepository;

    public M4sllTpLitigiosServices(M4sllTpLitigiosRepository m4sllTpLitigiosRepository) {
        this.M4sllTpLitigiosRepository = m4sllTpLitigiosRepository;
    }

    public boolean casteoError(M4sllTpLitigios m4sllTpLitigios) {
        return m4sllTpLitigios != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpLitigios m4sllTpLitigios) {
        return M4sllTpLitigiosRepository.obtenerUltimaSecuencia(m4sllTpLitigios.getId().getIdOrganization());
    }
}
