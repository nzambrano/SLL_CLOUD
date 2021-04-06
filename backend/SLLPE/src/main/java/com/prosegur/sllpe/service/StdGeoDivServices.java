package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdGeoDiv;
import com.prosegur.sllpe.repository.StdGeoDivRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StdGeoDivServices {

    private final StdGeoDivRepository StdGeoDivRepository;

    public StdGeoDivServices(StdGeoDivRepository stdGeoDivRepository) {
        this.StdGeoDivRepository = stdGeoDivRepository;
    }

    public boolean casteoError(StdGeoDiv stdGeoDiv) {
        return stdGeoDiv != null ? true : false;
    }

    public String UltimaSecuencia(StdGeoDiv stdGeoDiv) {
        return StdGeoDivRepository.obtenerUltimaSecuencia(stdGeoDiv.getId().getStdIdCountry(), stdGeoDiv.getId().getIdOrganization());
    }
}
