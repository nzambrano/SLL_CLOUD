package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllCpeCejpjD;
import com.prosegur.sllpe.repository.M4sllCpeCejpjDRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllCpeCejpjDServices {

    private final M4sllCpeCejpjDRepository M4sllCpeCejpjDRepository;

    public M4sllCpeCejpjDServices(M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository) {
        this.M4sllCpeCejpjDRepository = m4sllCpeCejpjDRepository;
    }

    public boolean casteoError(M4sllCpeCejpjD m4sllCpeCejpjD) {
        return m4sllCpeCejpjD != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllCpeCejpjD m4sllCpeCejpjD) {
        return M4sllCpeCejpjDRepository.obtenerUltimaSecuencia(m4sllCpeCejpjD.getId().getLitIdLitigio(), m4sllCpeCejpjD.getId().getIdOrganization());
    }
}
