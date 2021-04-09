package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdGeoDiv;
import com.prosegur.sllpe.domain.StdGeoDivId;
import com.prosegur.sllpe.repository.StdGeoDivRepository;
import com.prosegur.sllpe.service.StdGeoDivServices;
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
public class StdGeoDivResource {

    private final Logger log = LoggerFactory.getLogger(StdGeoDivResource.class);
    private static final String ENTITY_NAME = "sllpeStdGeoDiv";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private StdGeoDivRepository stdGeoDivRepository;

    public StdGeoDivResource(StdGeoDivRepository stdGeoDivRepository) {
        this.stdGeoDivRepository = stdGeoDivRepository;
    }

    @PostMapping("/std_geo_div")
    public ResponseEntity<StdGeoDiv> createStdGeoDiv(@RequestBody StdGeoDiv std_geo_div)
    throws URISyntaxException {
        log.debug("REST request to create std_geo_div : {}", std_geo_div);
        StdGeoDivId id = new StdGeoDivId();
        StdGeoDivServices stdGeoDivServices = new StdGeoDivServices(stdGeoDivRepository);
        String id_std_id_geo_div = stdGeoDivServices.UltimaSecuencia(std_geo_div);

        id.setStdIdGeoDiv(id_std_id_geo_div);
        id.setStdIdCountry(std_geo_div.getId().getStdIdCountry());
        id.setIdOrganization(std_geo_div.getId().getIdOrganization());

        std_geo_div.setId(id);
        StdGeoDiv result = stdGeoDivRepository.save(std_geo_div);
        return ResponseEntity
               .created(new URI("/api/std_geo_div/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/std_geo_div")
    public ResponseEntity<StdGeoDiv> updateStdGeoDiv(@RequestBody StdGeoDiv std_geo_div)
    throws URISyntaxException {
        log.debug("REST request to update std_geo_div : {}", std_geo_div);
        if (std_geo_div.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdGeoDiv result = stdGeoDivRepository.save(std_geo_div);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, std_geo_div.getId().toString()))
               .body(result);
    }

    @GetMapping("/std_geo_div")
    public ResponseEntity<List<StdGeoDiv>> getAllStdGeoDiv() {
        log.debug("REST request to get ALL StdGeoDiv : {}");

        List<StdGeoDiv> StdGeoDivAll = stdGeoDivRepository.findAll();
        return ResponseEntity.ok().body(StdGeoDivAll);
    }

    @GetMapping("/std_geo_div/{std_id_country}/{id_organization}")
    public ResponseEntity<List<StdGeoDiv>> getStdGeoDiv(@PathVariable("std_id_country") String std_id_country, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get StdGeoDiv : {}", std_id_country + "|" + id_organization);

        List<StdGeoDiv> StdGeoDivByInput = stdGeoDivRepository.findByStdIdCountryIdOrganization(std_id_country, id_organization);
        return ResponseEntity.ok().body(StdGeoDivByInput);
    }


    /*
      @GetMapping("/std_geo_div/{std_id_country}/{id_organization}/{std_id_geo_div}")
      public ResponseEntity<StdGeoDiv> getStdGeoDiv(@PathVariable("std_id_country") String std_id_country, @PathVariable("id_organization") String id_organization, @PathVariable("std_id_geo_div") String std_id_geo_div) {
          log.debug("REST request to get StdGeoDiv : {}", std_id_country + "|" + id_organization + "|" + std_id_geo_div);
          StdGeoDivId id = new StdGeoDivId();
          id.setStdIdCountry(std_id_country); id.setIdOrganization(id_organization);
          id.setStdIdGeoDiv(std_id_geo_div);

          Optional<StdGeoDiv> std_geo_div = stdGeoDivRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(std_geo_div);
      }

      @DeleteMapping("/std_geo_div/{std_id_country}/{id_organization}")
      public ResponseEntity<Void> deleteStdGeoDiv(@PathVariable("std_id_country") String std_id_country, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete std_geo_div : {}", std_id_country + "|" + id_organization);
        List<StdGeoDiv> StdGeoDivByInput = stdGeoDivRepository.findByStdIdCountryIdOrganization(std_id_country, id_organization);

        stdGeoDivRepository.deleteAll(StdGeoDivByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdGeoDivByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/std_geo_div/{std_id_country}/{id_organization}/{std_id_geo_div}")
    public ResponseEntity<Void> deleteStdGeoDiv(@PathVariable("std_id_country") String std_id_country, @PathVariable("id_organization") String id_organization, @PathVariable("std_id_geo_div") String std_id_geo_div) {
        log.debug("REST request to delete std_geo_div : {}", std_id_country + "|" + id_organization + "|" + std_id_geo_div);
        StdGeoDivId id = new StdGeoDivId();
        id.setStdIdCountry(std_id_country);
        id.setIdOrganization(id_organization);
        id.setStdIdGeoDiv(std_id_geo_div);

        stdGeoDivRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
