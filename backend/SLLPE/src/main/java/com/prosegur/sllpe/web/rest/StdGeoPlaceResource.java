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
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    StdGeoPlaceServices stdGeoPlaceServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private StdGeoPlaceRepository stdGeoPlaceRepository;

    public StdGeoPlaceResource(StdGeoPlaceRepository stdGeoPlaceRepository) {
        this.stdGeoPlaceRepository = stdGeoPlaceRepository;
    }

    @PostMapping("/std_geo_place")
    public ResponseEntity<List<StdGeoPlace>> createStdGeoPlace(@RequestBody List<StdGeoPlace> listStdGeoPlace)
    throws URISyntaxException {
        log.debug("REST request to create std_geo_place : {}", listStdGeoPlace);
        List<StdGeoPlace>result =  stdGeoPlaceServices.saveAllWithSecuencia(listStdGeoPlace);
        return ResponseEntity
               .created(new URI("/api/std_geo_place/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/std_geo_place")
    public ResponseEntity<List<StdGeoPlace>> updateStdGeoPlace(@RequestBody List<StdGeoPlace> listStdGeoPlace)
    throws URISyntaxException {
        log.debug("REST request to update std_geo_place : {}", listStdGeoPlace);
        List<StdGeoPlace> result = stdGeoPlaceRepository.saveAll(listStdGeoPlace);
        return ResponseEntity
               .created(new URI("/api/std_geo_place/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/std_geo_place")
    public ResponseEntity<List<StdGeoPlace>> getAllStdGeoPlace() {
        log.debug("REST request to get ALL StdGeoPlace : {}");

        List<StdGeoPlace> StdGeoPlaceAll = stdGeoPlaceRepository.findAll();
        return ResponseEntity.ok().body(StdGeoPlaceAll);
    }

    @GetMapping("/std_geo_place/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
    public ResponseEntity<List<StdGeoPlace>> getStdGeoPlace(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv, @PathVariable("std_id_sub_geo_div") String stdIdSubGeoDiv) {
        log.debug("REST request to get StdGeoPlace : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv + "|" + stdIdSubGeoDiv);

        List<StdGeoPlace> StdGeoPlaceByInput = stdGeoPlaceRepository.findByIdOrganizationStdIdCountryStdIdGeoDivStdIdSubGeoDiv(idOrganization, stdIdCountry, stdIdGeoDiv, stdIdSubGeoDiv);
        return ResponseEntity.ok().body(StdGeoPlaceByInput);
    }


    @DeleteMapping("/std_geo_place/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}/{std_id_geo_place}")
    public ResponseEntity<Void> deleteStdGeoPlace(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv, @PathVariable("std_id_sub_geo_div") String stdIdSubGeoDiv, @PathVariable("std_id_geo_place") String stdIdGeoPlace) {
        log.debug("REST request to delete std_geo_place : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv + "|" + stdIdSubGeoDiv + "|" + stdIdGeoPlace);
        StdGeoPlaceId id = new StdGeoPlaceId();
        id.setIdOrganization(idOrganization);
        id.setStdIdCountry(stdIdCountry);
        id.setStdIdGeoDiv(stdIdGeoDiv);
        id.setStdIdSubGeoDiv(stdIdSubGeoDiv);
        id.setStdIdGeoPlace(stdIdGeoPlace);

        stdGeoPlaceRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/std_geo_place")
  public ResponseEntity<StdGeoPlace> createStdGeoPlace(@RequestBody StdGeoPlace stdGeoPlace)
    throws URISyntaxException {
    log.debug("REST request to create std_geo_place : {}", stdGeoPlace);
    StdGeoPlaceId id = new StdGeoPlaceId();
    StdGeoPlaceServices stdGeoPlaceServices = new StdGeoPlaceServices(stdGeoPlaceRepository);
    String id_stdIdGeoPlace = stdGeoPlaceServices.UltimaSecuencia(stdGeoPlace);

    id.setStdIdGeoPlace(id_stdIdGeoPlace);
    id.setIdOrganization(idOrganization);
id.setStdIdCountry(stdGeoPlace.getId().getStdIdCountry());
id.setStdIdGeoDiv(stdGeoPlace.getId().getStdIdGeoDiv());
id.setStdIdSubGeoDiv(stdGeoPlace.getId().getStdIdSubGeoDiv());

    stdGeoPlace.setId(id);
    StdGeoPlace result = stdGeoPlaceRepository.save(stdGeoPlace);
    return ResponseEntity
      .created(new URI("/api/std_geo_place/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/std_geo_place/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}/{std_id_geo_place}")
  public ResponseEntity<StdGeoPlace> getStdGeoPlace(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv, @PathVariable("std_id_sub_geo_div") String stdIdSubGeoDiv, @PathVariable("std_id_geo_place") String stdIdGeoPlace) {
      log.debug("REST request to get StdGeoPlace : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv + "|" + stdIdSubGeoDiv + "|" + stdIdGeoPlace);
      StdGeoPlaceId id = new StdGeoPlaceId();
      id.setIdOrganization(idOrganization);
id.setStdIdCountry(stdIdCountry);
id.setStdIdGeoDiv(stdIdGeoDiv);
id.setStdIdSubGeoDiv(stdIdSubGeoDiv);
      id.setStdIdGeoPlace(stdIdGeoPlace);

      Optional<StdGeoPlace> stdGeoPlace = stdGeoPlaceRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(stdGeoPlace);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/std_geo_place/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
  public ResponseEntity<Void> deleteStdGeoPlace(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv, @PathVariable("std_id_sub_geo_div") String stdIdSubGeoDiv) {
    log.debug("REST request to delete std_geo_place : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv + "|" + stdIdSubGeoDiv);
    List<StdGeoPlace> StdGeoPlaceByInput = stdGeoPlaceRepository.findByIdOrganizationStdIdCountryStdIdGeoDivStdIdSubGeoDiv(idOrganization, stdIdCountry, stdIdGeoDiv, stdIdSubGeoDiv);

    stdGeoPlaceRepository.deleteAll(StdGeoPlaceByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdGeoPlaceByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/std_geo_place")
public ResponseEntity<StdGeoPlace> updateStdGeoPlace(@RequestBody StdGeoPlace stdGeoPlace)
  throws URISyntaxException {
  log.debug("REST request to update std_geo_place : {}", stdGeoPlace);
  if (stdGeoPlace.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  StdGeoPlace result = stdGeoPlaceRepository.save(stdGeoPlace);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, stdGeoPlace.getId().toString()))
    .body(result);
}


*/
