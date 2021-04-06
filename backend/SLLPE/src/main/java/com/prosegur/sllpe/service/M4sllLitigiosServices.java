package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllLitSeguimie;
import com.prosegur.sllpe.domain.M4sllLitigios;
import com.prosegur.sllpe.repository.M4sllLitigiosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllLitigiosServices {

    private final M4sllLitigiosRepository m4sllLitigiosRepository;

    public M4sllLitigiosServices(M4sllLitigiosRepository m4sllLitigiosRepository) {
        this.m4sllLitigiosRepository = m4sllLitigiosRepository;
    }

    public boolean casteoError(M4sllLitSeguimie m4sllLitSeguimie) {
        return m4sllLitSeguimie != null ? true : false;
    }

    public String UltimaSecuencia(M4sllLitigios m4sllLitigios) {
        return m4sllLitigiosRepository.obtenerUltimaSecuencia( m4sllLitigios.getId().getIdOrganization());
    }
}
