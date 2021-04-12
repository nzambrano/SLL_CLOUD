package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdSubGeoDiv;
import com.prosegur.sllpe.domain.StdSubGeoDivId;
import com.prosegur.sllpe.repository.StdSubGeoDivRepository;
import com.prosegur.sllpe.service.StdSubGeoDivServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;
import io.github.jhipster.web.util.HeaderUtil;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sllpe")
@Transactional
public class StdSubGeoDivResource {

    private final Logger log = LoggerFactory.getLogger(StdSubGeoDivResource.class);
    private static final String ENTITY_NAME = "sllpeStdSubGeoDiv";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private StdSubGeoDivRepository stdSubGeoDivRepository;

    public StdSubGeoDivResource(StdSubGeoDivRepository stdSubGeoDivRepository) {
        this.stdSubGeoDivRepository = stdSubGeoDivRepository;
    }

    @PostMapping("/std_sub_geo_div")
    public ResponseEntity<StdSubGeoDiv> createStdSubGeoDiv(@RequestBody StdSubGeoDiv std_sub_geo_div)
    throws URISyntaxException {
        log.debug("REST request to create std_sub_geo_div : {}", std_sub_geo_div);
        StdSubGeoDivId id = new StdSubGeoDivId();
        StdSubGeoDivServices stdSubGeoDivServices = new StdSubGeoDivServices(stdSubGeoDivRepository);
        String id_std_id_sub_geo_div = stdSubGeoDivServices.UltimaSecuencia(std_sub_geo_div);

        id.setStdIdSubGeoDiv(id_std_id_sub_geo_div);
        id.setIdOrganization(std_sub_geo_div.getId().getIdOrganization());
        id.setStdIdCountry(std_sub_geo_div.getId().getStdIdCountry());
        id.setStdIdGeoDiv(std_sub_geo_div.getId().getStdIdGeoDiv());

        std_sub_geo_div.setId(id);
        StdSubGeoDiv result = stdSubGeoDivRepository.save(std_sub_geo_div);
        return ResponseEntity
               .created(new URI("/api/std_sub_geo_div/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/std_sub_geo_div")
    public ResponseEntity<StdSubGeoDiv> updateStdSubGeoDiv(@RequestBody StdSubGeoDiv std_sub_geo_div)
    throws URISyntaxException {
        log.debug("REST request to update std_sub_geo_div : {}", std_sub_geo_div);
        if (std_sub_geo_div.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdSubGeoDiv result = stdSubGeoDivRepository.save(std_sub_geo_div);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, std_sub_geo_div.getId().toString()))
               .body(result);
    }

    @GetMapping("/std_sub_geo_div")
    public ResponseEntity<List<StdSubGeoDiv>> getAllStdSubGeoDiv() {
        log.debug("REST request to get ALL StdSubGeoDiv : {}");

        List<StdSubGeoDiv> StdSubGeoDivAll = stdSubGeoDivRepository.findAll();
        return ResponseEntity.ok().body(StdSubGeoDivAll);
    }

    @GetMapping("/std_sub_geo_div/{id_organization}/{std_id_country}/{std_id_geo_div}")
    public ResponseEntity<List<StdSubGeoDiv>> getStdSubGeoDiv(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div) {
        log.debug("REST request to get StdSubGeoDiv : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div);

        List<StdSubGeoDiv> StdSubGeoDivByInput = stdSubGeoDivRepository.findByIdOrganizationStdIdCountryStdIdGeoDiv(id_organization, std_id_country, std_id_geo_div);
        return ResponseEntity.ok().body(StdSubGeoDivByInput);
    }


    /*
      @GetMapping("/std_sub_geo_div/{id_organization}/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
      public ResponseEntity<StdSubGeoDiv> getStdSubGeoDiv(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div, @PathVariable("std_id_sub_geo_div") String std_id_sub_geo_div) {
          log.debug("REST request to get StdSubGeoDiv : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div + "|" + std_id_sub_geo_div);
          StdSubGeoDivId id = new StdSubGeoDivId();
          id.setIdOrganization(id_organization); id.setStdIdCountry(std_id_country); id.setStdIdGeoDiv(std_id_geo_div);
          id.setStdIdSubGeoDiv(std_id_sub_geo_div);

          Optional<StdSubGeoDiv> std_sub_geo_div = stdSubGeoDivRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(std_sub_geo_div);
      }

      @DeleteMapping("/std_sub_geo_div/{id_organization}/{std_id_country}/{std_id_geo_div}")
      public ResponseEntity<Void> deleteStdSubGeoDiv(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div) {
        log.debug("REST request to delete std_sub_geo_div : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div);
        List<StdSubGeoDiv> StdSubGeoDivByInput = stdSubGeoDivRepository.findByIdOrganizationStdIdCountryStdIdGeoDiv(id_organization, std_id_country, std_id_geo_div);

        stdSubGeoDivRepository.deleteAll(StdSubGeoDivByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdSubGeoDivByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/std_sub_geo_div/{id_organization}/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
    public ResponseEntity<Void> deleteStdSubGeoDiv(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div, @PathVariable("std_id_sub_geo_div") String std_id_sub_geo_div) {
        log.debug("REST request to delete std_sub_geo_div : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div + "|" + std_id_sub_geo_div);
        StdSubGeoDivId id = new StdSubGeoDivId();
        id.setIdOrganization(id_organization);
        id.setStdIdCountry(std_id_country);
        id.setStdIdGeoDiv(std_id_geo_div);
        id.setStdIdSubGeoDiv(std_id_sub_geo_div);

        stdSubGeoDivRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
