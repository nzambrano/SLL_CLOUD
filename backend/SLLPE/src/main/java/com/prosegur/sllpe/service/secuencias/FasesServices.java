package com.prosegur.sllpe.service.secuencias;


import java.util.Collection;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import com.prosegur.sllpe.repository.M4sllFasesRepository;


@Service
@Transactional

public class FasesServices {
    private String idOrganization = "0050";
    private final M4sllFasesRepository m4sllFasesRepository;

    public FasesServices(M4sllFasesRepository m4sllFasesRepository) {
        this.m4sllFasesRepository = m4sllFasesRepository;
    }

    public boolean casteoError(M4sllFases fases) {
        return fases != null ? true: false;
    }


    public  String UltimaSecuencia(M4sllFases fase) {
        return  m4sllFasesRepository.obtenerUltimaSecuencia( fase.getId().getIdOrganization(), fase.getId().getLitIdLitigio());
    }

    public Collection<M4sllFases> saveAllWithSecuencia(Collection<M4sllFases> listM4sllFases)  {
        listM4sllFases.stream().forEach((m4sllFase) -> {
            String idFase = UltimaSecuencia(m4sllFase);
            M4sllFasesId id = new M4sllFasesId(m4sllFase.getId().getLitIdLitigio(), idFase, idOrganization);
            m4sllFase.setId(id);
            m4sllFasesRepository.save(m4sllFase);
        });
        return listM4sllFases;
    }


}
