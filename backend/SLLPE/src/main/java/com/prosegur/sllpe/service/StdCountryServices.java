package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.domain.StdCountryId;
import com.prosegur.sllpe.repository.StdCountryRepository;

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
public class StdCountryServices {
    private final Logger log = LoggerFactory.getLogger(StdCountryServices.class);
    @Value("${idOrganization}")
    private String idOrganization;
    private final StdCountryRepository stdCountryRepository;

    public StdCountryServices(StdCountryRepository stdCountryRepository) {
        this.stdCountryRepository = stdCountryRepository;
    }

    public boolean casteoError(StdCountry stdCountry) {
        return stdCountry != null ? true : false;
    }

    public String UltimaSecuencia(StdCountry stdCountry) {
        return stdCountryRepository.obtenerUltimaSecuencia(stdCountry.getId().getIdOrganization());
    }

    public List<StdCountry> saveAllWithSecuencia(List<StdCountry> listStdCountry)  {
        listStdCountry.stream().forEach((stdCountry) -> {
            String ultimaSecuencia = UltimaSecuencia(stdCountry);
            StdCountryId id = new StdCountryId();
            id.setStdIdCountry(ultimaSecuencia);
            id.setIdOrganization(idOrganization);

            String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
            log.debug("REST request to insert std_country id: {}, seq: {}", classToString, ultimaSecuencia);

            stdCountry.setId(id);
            stdCountryRepository.save(stdCountry);
        });
        return listStdCountry;
    }
}
