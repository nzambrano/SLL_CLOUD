package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdGeoPlace;
import com.prosegur.sllpe.domain.StdGeoPlaceId;
import com.prosegur.sllpe.repository.StdGeoPlaceRepository;
import com.prosegur.sllpe.service.StdGeoPlaceServices;
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
@RequestMapping("/api")
@Transactional
public class StdGeoPlaceResource {

    private final Logger log = LoggerFactory.getLogger(StdGeoPlaceResource.class);
    private static final String ENTITY_NAME = "sllpeStdGeoPlace";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private StdGeoPlaceRepository stdGeoPlaceRepository;

    public StdGeoPlaceResource(StdGeoPlaceRepository stdGeoPlaceRepository) {
        this.stdGeoPlaceRepository = stdGeoPlaceRepository;
    }

    @PostMapping("/std_geo_place")
    public ResponseEntity<StdGeoPlace> createStdGeoPlace(@RequestBody StdGeoPlace std_geo_place)
    throws URISyntaxException {
        log.debug("REST request to create std_geo_place : {}", std_geo_place);
        StdGeoPlaceId id = new StdGeoPlaceId();
        StdGeoPlaceServices stdGeoPlaceServices = new StdGeoPlaceServices(stdGeoPlaceRepository);
        String id_std_id_geo_place = stdGeoPlaceServices.UltimaSecuencia(std_geo_place);

        id.setStdIdGeoPlace(id_std_id_geo_place);
        id.setIdOrganization(std_geo_place.getId().getIdOrganization());
        id.setStdIdCountry(std_geo_place.getId().getStdIdCountry());
        id.setStdIdGeoDiv(std_geo_place.getId().getStdIdGeoDiv());
        id.setStdIdSubGeoDiv(std_geo_place.getId().getStdIdSubGeoDiv());

        std_geo_place.setId(id);
        StdGeoPlace result = stdGeoPlaceRepository.save(std_geo_place);
        return ResponseEntity
               .created(new URI("/api/std_geo_place/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/std_geo_place")
    public ResponseEntity<StdGeoPlace> updateStdGeoPlace(@RequestBody StdGeoPlace std_geo_place)
    throws URISyntaxException {
        log.debug("REST request to update std_geo_place : {}", std_geo_place);
        if (std_geo_place.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdGeoPlace result = stdGeoPlaceRepository.save(std_geo_place);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, std_geo_place.getId().toString()))
               .body(result);
    }

    @GetMapping("/std_geo_place")
    public ResponseEntity<List<StdGeoPlace>> getAllStdGeoPlace() {
        log.debug("REST request to get ALL StdGeoPlace : {}");

        List<StdGeoPlace> StdGeoPlaceAll = stdGeoPlaceRepository.findAll();
        return ResponseEntity.ok().body(StdGeoPlaceAll);
    }

    @GetMapping("/std_geo_place/{id_organization}/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
    public ResponseEntity<List<StdGeoPlace>> getStdGeoPlace(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div, @PathVariable("std_id_sub_geo_div") String std_id_sub_geo_div) {
        log.debug("REST request to get StdGeoPlace : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div + "|" + std_id_sub_geo_div);

        List<StdGeoPlace> StdGeoPlaceByInput = stdGeoPlaceRepository.findByIdOrganizationStdIdCountryStdIdGeoDivStdIdSubGeoDiv(id_organization, std_id_country, std_id_geo_div, std_id_sub_geo_div);
        return ResponseEntity.ok().body(StdGeoPlaceByInput);
    }


    /*
      @GetMapping("/std_geo_place/{id_organization}/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}/{std_id_geo_place}")
      public ResponseEntity<StdGeoPlace> getStdGeoPlace(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div, @PathVariable("std_id_sub_geo_div") String std_id_sub_geo_div, @PathVariable("std_id_geo_place") String std_id_geo_place) {
          log.debug("REST request to get StdGeoPlace : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div + "|" + std_id_sub_geo_div + "|" + std_id_geo_place);
          StdGeoPlaceId id = new StdGeoPlaceId();
          id.setIdOrganization(id_organization); id.setStdIdCountry(std_id_country); id.setStdIdGeoDiv(std_id_geo_div); id.setStdIdSubGeoDiv(std_id_sub_geo_div);
          id.setStdIdGeoPlace(std_id_geo_place);

          Optional<StdGeoPlace> std_geo_place = stdGeoPlaceRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(std_geo_place);
      }

      @DeleteMapping("/std_geo_place/{id_organization}/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
      public ResponseEntity<Void> deleteStdGeoPlace(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div, @PathVariable("std_id_sub_geo_div") String std_id_sub_geo_div) {
        log.debug("REST request to delete std_geo_place : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div + "|" + std_id_sub_geo_div);
        List<StdGeoPlace> StdGeoPlaceByInput = stdGeoPlaceRepository.findByIdOrganizationStdIdCountryStdIdGeoDivStdIdSubGeoDiv(id_organization, std_id_country, std_id_geo_div, std_id_sub_geo_div);

        stdGeoPlaceRepository.deleteAll(StdGeoPlaceByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdGeoPlaceByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/std_geo_place/{id_organization}/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}/{std_id_geo_place}")
    public ResponseEntity<Void> deleteStdGeoPlace(@PathVariable("id_organization") String id_organization, @PathVariable("std_id_country") String std_id_country, @PathVariable("std_id_geo_div") String std_id_geo_div, @PathVariable("std_id_sub_geo_div") String std_id_sub_geo_div, @PathVariable("std_id_geo_place") String std_id_geo_place) {
        log.debug("REST request to delete std_geo_place : {}", id_organization + "|" + std_id_country + "|" + std_id_geo_div + "|" + std_id_sub_geo_div + "|" + std_id_geo_place);
        StdGeoPlaceId id = new StdGeoPlaceId();
        id.setIdOrganization(id_organization);
        id.setStdIdCountry(std_id_country);
        id.setStdIdGeoDiv(std_id_geo_div);
        id.setStdIdSubGeoDiv(std_id_sub_geo_div);
        id.setStdIdGeoPlace(std_id_geo_place);

        stdGeoPlaceRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
