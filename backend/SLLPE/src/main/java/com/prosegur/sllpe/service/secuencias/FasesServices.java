package com.prosegur.sllpe.service.secuencias;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.repository.M4sllFasesRepository;


@Service
@Transactional

public class FasesServices {

    private final M4sllFasesRepository m4sllFasesRepository;

    public FasesServices(M4sllFasesRepository m4sllFasesRepository) {
        this.m4sllFasesRepository = m4sllFasesRepository;
    }

    public boolean casteoError(M4sllFases fases) {
        return fases != null ? true: false;
    }


    public  Long UltimaSecuencia(M4sllFases fase) {
        return  m4sllFasesRepository.obtenerUltimaSecuencia( fase.getId().getIdOrganization(), fase.getId().getLitIdLitigio());
    }


}
