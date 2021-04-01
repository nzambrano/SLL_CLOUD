package com.prosegur.sllpe.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.repository.M4sllAbogadosRepository;


@Service
@Transactional

public class AbogadoServices {

    private final M4sllAbogadosRepository M4sllAbogadosRepository;

    public AbogadoServices(M4sllAbogadosRepository M4sllAbogadosRepository) {
        this.M4sllAbogadosRepository = M4sllAbogadosRepository;
    }

    public boolean casteoError(M4sllMtAbogados abogadoServices) {
        return abogadoServices != null ? true: false;
    }


    public  Long UltimaSecuencia(M4sllMtAbogados abogadoServices) {
        return  M4sllAbogadosRepository.obtenerUltimaSecuencia(abogadoServices.getId().getIdOrganization());
    }
}
