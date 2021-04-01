package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllMtoRiesgos;
import com.prosegur.sllpe.repository.M4sllMtoRiesgosRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllMtoRiesgosServices {

    private final M4sllMtoRiesgosRepository M4sllMtoRiesgosRepository;

    public M4sllMtoRiesgosServices(M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository) {
        this.M4sllMtoRiesgosRepository = m4sllMtoRiesgosRepository;
    }

    public boolean casteoError(M4sllMtoRiesgos m4sllMtoRiesgos) {
        return m4sllMtoRiesgos != null ? true : false;
    }

    public String UltimaSecuencia(M4sllMtoRiesgos m4sllMtoRiesgos) {
        return M4sllMtoRiesgosRepository.obtenerUltimaSecuencia(m4sllMtoRiesgos.getId().getIdOrganization());
    }
}
