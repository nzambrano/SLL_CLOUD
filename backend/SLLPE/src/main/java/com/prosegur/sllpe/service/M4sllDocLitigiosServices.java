package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllDocLitigios;
import com.prosegur.sllpe.repository.M4sllDocLitigiosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllDocLitigiosServices {

    private final M4sllDocLitigiosRepository M4sllDocLitigiosRepository;

    public M4sllDocLitigiosServices(M4sllDocLitigiosRepository m4sllDocLitigiosRepository) {
        this.M4sllDocLitigiosRepository = m4sllDocLitigiosRepository;
    }

    public boolean casteoError(M4sllDocLitigios m4sllDocLitigios) {
        return m4sllDocLitigios != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllDocLitigios m4sllDocLitigios) {
        return M4sllDocLitigiosRepository.obtenerUltimaSecuencia(m4sllDocLitigios.getId().getIdOrganization(), m4sllDocLitigios.getId().getLitIdLitigio());
    }
}
