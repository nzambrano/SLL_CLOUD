package com.prosegur.sllpe.service.secuencias;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;


@Service
@Transactional

public class EstudioJurServices {

    private final M4sllEstudioJurRepository M4sllEstudioJurRepository;

    public EstudioJurServices(M4sllEstudioJurRepository M4sllEstudioJurRepository) {
        this.M4sllEstudioJurRepository = M4sllEstudioJurRepository;
    }

    public boolean casteoError(M4sllEstudioJur estudioJur) {
        return estudioJur != null ? true: false;
    }


    public  Long UltimaSecuencia(M4sllEstudioJur estudioJur) {
        return  M4sllEstudioJurRepository.obtenerUltimaSecuencia(estudioJur.getId().getIdOrganization());
    }


}
