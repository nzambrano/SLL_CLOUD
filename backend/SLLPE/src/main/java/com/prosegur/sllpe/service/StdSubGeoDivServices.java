package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdSubGeoDiv;
import com.prosegur.sllpe.repository.StdSubGeoDivRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StdSubGeoDivServices {

    private final StdSubGeoDivRepository StdSubGeoDivRepository;

    public StdSubGeoDivServices(StdSubGeoDivRepository stdSubGeoDivRepository) {
        this.StdSubGeoDivRepository = stdSubGeoDivRepository;
    }

    public boolean casteoError(StdSubGeoDiv stdSubGeoDiv) {
        return stdSubGeoDiv != null ? true : false;
    }

    public String UltimaSecuencia(StdSubGeoDiv stdSubGeoDiv) {
        return StdSubGeoDivRepository.obtenerUltimaSecuencia(stdSubGeoDiv.getId().getStdIdGeoDiv(), stdSubGeoDiv.getId().getStdIdCountry(), stdSubGeoDiv.getId().getIdOrganization());
    }
}
