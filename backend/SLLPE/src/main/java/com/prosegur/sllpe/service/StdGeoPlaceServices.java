package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdGeoPlace;
import com.prosegur.sllpe.domain.StdGeoPlaceId;
import com.prosegur.sllpe.repository.StdGeoPlaceRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import java.util.List;
import java.util.Collection;

@Service
@Transactional
public class StdGeoPlaceServices {
    private final Logger log = LoggerFactory.getLogger(StdGeoPlaceServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final StdGeoPlaceRepository stdGeoPlaceRepository;

    public StdGeoPlaceServices(StdGeoPlaceRepository stdGeoPlaceRepository) {
        this.stdGeoPlaceRepository = stdGeoPlaceRepository;
    }

    public boolean casteoError(StdGeoPlace stdGeoPlace) {
        return stdGeoPlace != null ? true : false;
    }

    public String UltimaSecuencia(StdGeoPlace stdGeoPlace) {
        return stdGeoPlaceRepository.obtenerUltimaSecuencia(stdGeoPlace.getId().getIdOrganization(), stdGeoPlace.getId().getStdIdCountry(), stdGeoPlace.getId().getStdIdGeoDiv(), stdGeoPlace.getId().getStdIdSubGeoDiv());
    }

    public List<StdGeoPlace> saveAllWithSecuencia(List<StdGeoPlace> listStdGeoPlace)  {
        listStdGeoPlace.stream().forEach((stdGeoPlace) -> {
            String ultimaSecuencia = UltimaSecuencia(stdGeoPlace);
            StdGeoPlaceId id = new StdGeoPlaceId();
            id.setStdIdGeoPlace(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setStdIdCountry(stdGeoPlace.getId().getStdIdCountry());
            id.setStdIdGeoDiv(stdGeoPlace.getId().getStdIdGeoDiv());
            id.setStdIdSubGeoDiv(stdGeoPlace.getId().getStdIdSubGeoDiv());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert std_geo_place id: {}, seq: {}", classToString, ultimaSecuencia);

            stdGeoPlace.setId(id);
            stdGeoPlaceRepository.save(stdGeoPlace);
        });
        return listStdGeoPlace;
    }
}
