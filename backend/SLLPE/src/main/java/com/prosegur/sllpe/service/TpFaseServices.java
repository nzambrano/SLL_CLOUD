package com.prosegur.sllpe.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;

@Service
@Transactional

public class TpFaseServices {

    private final M4sllTpFasesRepository M4sllTpFasesRepository;

    public TpFaseServices(M4sllTpFasesRepository M4sllTpFasesRepository) {
        this.M4sllTpFasesRepository = M4sllTpFasesRepository;
    }

    public boolean casteoError(M4sllTpFases tpFaseServices) {
        return tpFaseServices != null ? true: false;
    }


    public  Long UltimaSecuencia(M4sllTpFases tpFaseServices) {
        return  M4sllTpFasesRepository.obtenerUltimaSecuencia(tpFaseServices.getId().getIdOrganization());
    }
}
