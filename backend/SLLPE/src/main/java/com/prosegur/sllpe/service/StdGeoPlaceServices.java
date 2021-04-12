package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdGeoPlace;
import com.prosegur.sllpe.repository.StdGeoPlaceRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StdGeoPlaceServices {

    private final StdGeoPlaceRepository StdGeoPlaceRepository;

    public StdGeoPlaceServices(StdGeoPlaceRepository stdGeoPlaceRepository) {
        this.StdGeoPlaceRepository = stdGeoPlaceRepository;
    }

    public boolean casteoError(StdGeoPlace stdGeoPlace) {
        return stdGeoPlace != null ? true : false;
    }

    public String UltimaSecuencia(StdGeoPlace stdGeoPlace) {
        return StdGeoPlaceRepository.obtenerUltimaSecuencia(stdGeoPlace.getId().getIdOrganization(), stdGeoPlace.getId().getStdIdCountry(), stdGeoPlace.getId().getStdIdGeoDiv(), stdGeoPlace.getId().getStdIdSubGeoDiv());
    }
}
