package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.repository.M4sllMtAbogadosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllMtAbogadosServices {

    private final M4sllMtAbogadosRepository M4sllMtAbogadosRepository;

    public M4sllMtAbogadosServices(M4sllMtAbogadosRepository m4sllMtAbogadosRepository) {
        this.M4sllMtAbogadosRepository = m4sllMtAbogadosRepository;
    }

    public boolean casteoError(M4sllMtAbogados m4sllMtAbogados) {
        return m4sllMtAbogados != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllMtAbogados m4sllMtAbogados) {
        return M4sllMtAbogadosRepository.obtenerUltimaSecuencia(m4sllMtAbogados.getId().getIdOrganization());
    }
}
