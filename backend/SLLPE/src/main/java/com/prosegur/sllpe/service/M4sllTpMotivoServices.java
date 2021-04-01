package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpMotivo;
import com.prosegur.sllpe.repository.M4sllTpMotivoRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpMotivoServices {

    private final M4sllTpMotivoRepository M4sllTpMotivoRepository;

    public M4sllTpMotivoServices(M4sllTpMotivoRepository m4sllTpMotivoRepository) {
        this.M4sllTpMotivoRepository = m4sllTpMotivoRepository;
    }

    public boolean casteoError(M4sllTpMotivo m4sllTpMotivo) {
        return m4sllTpMotivo != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpMotivo m4sllTpMotivo) {
        return M4sllTpMotivoRepository.obtenerUltimaSecuencia(m4sllTpMotivo.getId().getIdOrganization());
    }
}
