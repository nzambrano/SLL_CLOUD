package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.repository.StdCountryRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StdCountryServices {

    private final StdCountryRepository StdCountryRepository;

    public StdCountryServices(StdCountryRepository stdCountryRepository) {
        this.StdCountryRepository = stdCountryRepository;
    }

    public boolean casteoError(StdCountry stdCountry) {
        return stdCountry != null ? true : false;
    }

    public String UltimaSecuencia(StdCountry stdCountry) {
        return StdCountryRepository.obtenerUltimaSecuencia(stdCountry.getId().getIdOrganization());
    }
}
