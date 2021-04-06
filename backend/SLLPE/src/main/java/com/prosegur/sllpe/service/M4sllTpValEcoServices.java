package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpValEco;
import com.prosegur.sllpe.repository.M4sllTpValEcoRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpValEcoServices {

    private final M4sllTpValEcoRepository M4sllTpValEcoRepository;

    public M4sllTpValEcoServices(M4sllTpValEcoRepository m4sllTpValEcoRepository) {
        this.M4sllTpValEcoRepository = m4sllTpValEcoRepository;
    }

    public boolean casteoError(M4sllTpValEco m4sllTpValEco) {
        return m4sllTpValEco != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpValEco m4sllTpValEco) {
        return M4sllTpValEcoRepository.obtenerUltimaSecuencia(m4sllTpValEco.getId().getIdOrganization());
    }
}
