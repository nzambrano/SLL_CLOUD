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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class StdGeoDivResource {
    private final Logger log = LoggerFactory.getLogger(StdGeoDivResource.class);
    private static final String ENTITY_NAME = "sllpeStdGeoDiv";

    @Autowired
    StdGeoDivServices stdGeoDivServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private StdGeoDivRepository stdGeoDivRepository;

    public StdGeoDivResource(StdGeoDivRepository stdGeoDivRepository) {
        this.stdGeoDivRepository = stdGeoDivRepository;
    }

    @PostMapping("/std_geo_div")
    public ResponseEntity<List<StdGeoDiv>> createStdGeoDiv(@RequestBody List<StdGeoDiv> listStdGeoDiv)
    throws URISyntaxException {
        log.debug("REST request to create std_geo_div : {}", listStdGeoDiv);
        List<StdGeoDiv>result =  stdGeoDivServices.saveAllWithSecuencia(listStdGeoDiv);
        return ResponseEntity
               .created(new URI("/api/std_geo_div/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/std_geo_div")
    public ResponseEntity<List<StdGeoDiv>> updateStdGeoDiv(@RequestBody List<StdGeoDiv> listStdGeoDiv)
    throws URISyntaxException {
        log.debug("REST request to update std_geo_div : {}", listStdGeoDiv);
        List<StdGeoDiv> result = stdGeoDivRepository.saveAll(listStdGeoDiv);
        return ResponseEntity
               .created(new URI("/api/std_geo_div/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/std_geo_div")
    public ResponseEntity<List<StdGeoDiv>> getAllStdGeoDiv() {
        log.debug("REST request to get ALL StdGeoDiv : {}");

        List<StdGeoDiv> StdGeoDivAll = stdGeoDivRepository.findAll();
        return ResponseEntity.ok().body(StdGeoDivAll);
    }

    @GetMapping("/std_geo_div/{std_id_country}")
    public ResponseEntity<List<StdGeoDiv>> getStdGeoDiv(@PathVariable("std_id_country") String stdIdCountry) {
        log.debug("REST request to get StdGeoDiv : {}", idOrganization + "|" + stdIdCountry);

        List<StdGeoDiv> StdGeoDivByInput = stdGeoDivRepository.findByIdOrganizationStdIdCountry(idOrganization, stdIdCountry);
        return ResponseEntity.ok().body(StdGeoDivByInput);
    }


    @DeleteMapping("/std_geo_div/{std_id_country}/{std_id_geo_div}")
    public ResponseEntity<Void> deleteStdGeoDiv(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv) {
        log.debug("REST request to delete std_geo_div : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv);
        StdGeoDivId id = new StdGeoDivId();
        id.setIdOrganization(idOrganization);
        id.setStdIdCountry(stdIdCountry);
        id.setStdIdGeoDiv(stdIdGeoDiv);

        stdGeoDivRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/std_geo_div")
  public ResponseEntity<StdGeoDiv> createStdGeoDiv(@RequestBody StdGeoDiv stdGeoDiv)
    throws URISyntaxException {
    log.debug("REST request to create std_geo_div : {}", stdGeoDiv);
    StdGeoDivId id = new StdGeoDivId();
    StdGeoDivServices stdGeoDivServices = new StdGeoDivServices(stdGeoDivRepository);
    String id_stdIdGeoDiv = stdGeoDivServices.UltimaSecuencia(stdGeoDiv);

    id.setStdIdGeoDiv(id_stdIdGeoDiv);
    id.setIdOrganization(idOrganization);
id.setStdIdCountry(stdGeoDiv.getId().getStdIdCountry());

    stdGeoDiv.setId(id);
    StdGeoDiv result = stdGeoDivRepository.save(stdGeoDiv);
    return ResponseEntity
      .created(new URI("/api/std_geo_div/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/std_geo_div/{std_id_country}/{std_id_geo_div}")
  public ResponseEntity<StdGeoDiv> getStdGeoDiv(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv) {
      log.debug("REST request to get StdGeoDiv : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv);
      StdGeoDivId id = new StdGeoDivId();
      id.setIdOrganization(idOrganization);
id.setStdIdCountry(stdIdCountry);
      id.setStdIdGeoDiv(stdIdGeoDiv);

      Optional<StdGeoDiv> stdGeoDiv = stdGeoDivRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(stdGeoDiv);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/std_geo_div/{std_id_country}")
  public ResponseEntity<Void> deleteStdGeoDiv(@PathVariable("std_id_country") String stdIdCountry) {
    log.debug("REST request to delete std_geo_div : {}", idOrganization + "|" + stdIdCountry);
    List<StdGeoDiv> StdGeoDivByInput = stdGeoDivRepository.findByIdOrganizationStdIdCountry(idOrganization, stdIdCountry);

    stdGeoDivRepository.deleteAll(StdGeoDivByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdGeoDivByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/std_geo_div")
public ResponseEntity<StdGeoDiv> updateStdGeoDiv(@RequestBody StdGeoDiv stdGeoDiv)
  throws URISyntaxException {
  log.debug("REST request to update std_geo_div : {}", stdGeoDiv);
  if (stdGeoDiv.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  StdGeoDiv result = stdGeoDivRepository.save(stdGeoDiv);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, stdGeoDiv.getId().toString()))
    .body(result);
}


*/
