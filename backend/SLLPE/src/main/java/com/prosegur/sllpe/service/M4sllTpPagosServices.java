package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpPagos;
import com.prosegur.sllpe.repository.M4sllTpPagosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpPagosServices {

    private final M4sllTpPagosRepository M4sllTpPagosRepository;

    public M4sllTpPagosServices(M4sllTpPagosRepository m4sllTpPagosRepository) {
        this.M4sllTpPagosRepository = m4sllTpPagosRepository;
    }

    public boolean casteoError(M4sllTpPagos m4sllTpPagos) {
        return m4sllTpPagos != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpPagos m4sllTpPagos) {
        return M4sllTpPagosRepository.obtenerUltimaSecuencia(m4sllTpPagos.getId().getIdOrganization());
    }
}
