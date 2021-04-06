package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllPagos;
import com.prosegur.sllpe.repository.M4sllPagosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllPagosServices {

    private final M4sllPagosRepository M4sllPagosRepository;

    public M4sllPagosServices(M4sllPagosRepository m4sllPagosRepository) {
        this.M4sllPagosRepository = m4sllPagosRepository;
    }

    public boolean casteoError(M4sllPagos m4sllPagos) {
        return m4sllPagos != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllPagos m4sllPagos) {
        return M4sllPagosRepository.obtenerUltimaSecuencia(m4sllPagos.getId().getLitIdLitigio(), m4sllPagos.getId().getIdOrganization());
    }
}
