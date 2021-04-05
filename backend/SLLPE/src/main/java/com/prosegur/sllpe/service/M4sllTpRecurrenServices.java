package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllTpRecurren;
import com.prosegur.sllpe.repository.M4sllTpRecurrenRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllTpRecurrenServices {

    private final M4sllTpRecurrenRepository M4sllTpRecurrenRepository;

    public M4sllTpRecurrenServices(M4sllTpRecurrenRepository m4sllTpRecurrenRepository) {
        this.M4sllTpRecurrenRepository = m4sllTpRecurrenRepository;
    }

    public boolean casteoError(M4sllTpRecurren m4sllTpRecurren) {
        return m4sllTpRecurren != null ? true : false;
    }

    public String UltimaSecuencia(M4sllTpRecurren m4sllTpRecurren) {
        return M4sllTpRecurrenRepository.obtenerUltimaSecuencia(m4sllTpRecurren.getId().getIdOrganization());
    }
}
