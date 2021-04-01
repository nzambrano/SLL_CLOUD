package com.prosegur.sllpe.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;


@Service
@Transactional

public class NegocioServices {

    private final M4sllNegociosRepository M4sllNegociosRepository;

    public NegocioServices(M4sllNegociosRepository M4sllNegociosRepository) {
        this.M4sllNegociosRepository = M4sllNegociosRepository;
    }

    public boolean casteoError(M4sllNegocios negocioServices) {
        return negocioServices != null ? true: false;
    }


    public  Long UltimaSecuencia(M4sllNegocios negocioServices) {
        return  M4sllNegociosRepository.obtenerUltimaSecuencia(negocioServices.getId().getIdOrganization());
    }
}
