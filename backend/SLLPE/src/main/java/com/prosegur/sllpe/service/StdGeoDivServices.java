package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdGeoDiv;
import com.prosegur.sllpe.domain.StdGeoDivId;
import com.prosegur.sllpe.repository.StdGeoDivRepository;

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
public class StdGeoDivServices {
    private final Logger log = LoggerFactory.getLogger(StdGeoDivServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final StdGeoDivRepository stdGeoDivRepository;

    public StdGeoDivServices(StdGeoDivRepository stdGeoDivRepository) {
        this.stdGeoDivRepository = stdGeoDivRepository;
    }

    public boolean casteoError(StdGeoDiv stdGeoDiv) {
        return stdGeoDiv != null ? true : false;
    }

    public String UltimaSecuencia(StdGeoDiv stdGeoDiv) {
        return stdGeoDivRepository.obtenerUltimaSecuencia(stdGeoDiv.getId().getIdOrganization(), stdGeoDiv.getId().getStdIdCountry());
    }

    public List<StdGeoDiv> saveAllWithSecuencia(List<StdGeoDiv> listStdGeoDiv)  {
        listStdGeoDiv.stream().forEach((stdGeoDiv) -> {
            String ultimaSecuencia = UltimaSecuencia(stdGeoDiv);
            StdGeoDivId id = new StdGeoDivId();
            id.setStdIdGeoDiv(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setStdIdCountry(stdGeoDiv.getId().getStdIdCountry());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert std_geo_div id: {}, seq: {}", classToString, ultimaSecuencia);

            stdGeoDiv.setId(id);
            stdGeoDivRepository.save(stdGeoDiv);
        });
        return listStdGeoDiv;
    }
}
