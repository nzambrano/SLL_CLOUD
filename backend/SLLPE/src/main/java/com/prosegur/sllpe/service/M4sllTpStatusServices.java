package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpStatus;
import com.prosegur.sllpe.repository.M4sllTpStatusRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpStatusServices {

    private final M4sllTpStatusRepository M4sllTpStatusRepository;

    public M4sllTpStatusServices(M4sllTpStatusRepository m4sllTpStatusRepository) {
        this.M4sllTpStatusRepository = m4sllTpStatusRepository;
    }

    public boolean casteoError(M4sllTpStatus m4sllTpStatus) {
        return m4sllTpStatus != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpStatus m4sllTpStatus) {
        return M4sllTpStatusRepository.obtenerUltimaSecuencia(m4sllTpStatus.getId().getIdOrganization());
    }
}
