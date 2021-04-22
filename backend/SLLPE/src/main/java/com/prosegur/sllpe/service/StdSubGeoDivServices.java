package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdSubGeoDiv;
import com.prosegur.sllpe.domain.StdSubGeoDivId;
import com.prosegur.sllpe.repository.StdSubGeoDivRepository;

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
public class StdSubGeoDivServices {
    private final Logger log = LoggerFactory.getLogger(StdSubGeoDivServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final StdSubGeoDivRepository stdSubGeoDivRepository;

    public StdSubGeoDivServices(StdSubGeoDivRepository stdSubGeoDivRepository) {
        this.stdSubGeoDivRepository = stdSubGeoDivRepository;
    }

    public boolean casteoError(StdSubGeoDiv stdSubGeoDiv) {
        return stdSubGeoDiv != null ? true : false;
    }

    public String UltimaSecuencia(StdSubGeoDiv stdSubGeoDiv) {
        return stdSubGeoDivRepository.obtenerUltimaSecuencia(stdSubGeoDiv.getId().getIdOrganization(), stdSubGeoDiv.getId().getStdIdCountry(), stdSubGeoDiv.getId().getStdIdGeoDiv());
    }

    public List<StdSubGeoDiv> saveAllWithSecuencia(List<StdSubGeoDiv> listStdSubGeoDiv)  {
        listStdSubGeoDiv.stream().forEach((stdSubGeoDiv) -> {
            String ultimaSecuencia = UltimaSecuencia(stdSubGeoDiv);
            StdSubGeoDivId id = new StdSubGeoDivId();
            id.setStdIdSubGeoDiv(ultimaSecuencia);
            id.setIdOrganization(idOrganization);
            id.setStdIdCountry(stdSubGeoDiv.getId().getStdIdCountry());
            id.setStdIdGeoDiv(stdSubGeoDiv.getId().getStdIdGeoDiv());

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert std_sub_geo_div id: {}, seq: {}", classToString, ultimaSecuencia);

            stdSubGeoDiv.setId(id);
            stdSubGeoDivRepository.save(stdSubGeoDiv);
        });
        return listStdSubGeoDiv;
    }
}
