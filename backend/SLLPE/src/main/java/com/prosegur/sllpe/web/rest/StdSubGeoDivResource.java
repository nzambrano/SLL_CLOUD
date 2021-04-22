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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class StdSubGeoDivResource {
    private final Logger log = LoggerFactory.getLogger(StdSubGeoDivResource.class);
    private static final String ENTITY_NAME = "sllpeStdSubGeoDiv";

    @Autowired
    StdSubGeoDivServices stdSubGeoDivServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private StdSubGeoDivRepository stdSubGeoDivRepository;

    public StdSubGeoDivResource(StdSubGeoDivRepository stdSubGeoDivRepository) {
        this.stdSubGeoDivRepository = stdSubGeoDivRepository;
    }

    @PostMapping("/std_sub_geo_div")
    public ResponseEntity<List<StdSubGeoDiv>> createStdSubGeoDiv(@RequestBody List<StdSubGeoDiv> listStdSubGeoDiv)
    throws URISyntaxException {
        log.debug("REST request to create std_sub_geo_div : {}", listStdSubGeoDiv);
        List<StdSubGeoDiv>result =  stdSubGeoDivServices.saveAllWithSecuencia(listStdSubGeoDiv);
        return ResponseEntity
               .created(new URI("/api/std_sub_geo_div/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/std_sub_geo_div")
    public ResponseEntity<List<StdSubGeoDiv>> updateStdSubGeoDiv(@RequestBody List<StdSubGeoDiv> listStdSubGeoDiv)
    throws URISyntaxException {
        log.debug("REST request to update std_sub_geo_div : {}", listStdSubGeoDiv);
        List<StdSubGeoDiv> result = stdSubGeoDivRepository.saveAll(listStdSubGeoDiv);
        return ResponseEntity
               .created(new URI("/api/std_sub_geo_div/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/std_sub_geo_div")
    public ResponseEntity<List<StdSubGeoDiv>> getAllStdSubGeoDiv() {
        log.debug("REST request to get ALL StdSubGeoDiv : {}");

        List<StdSubGeoDiv> StdSubGeoDivAll = stdSubGeoDivRepository.findAll();
        return ResponseEntity.ok().body(StdSubGeoDivAll);
    }

    @GetMapping("/std_sub_geo_div/{std_id_country}/{std_id_geo_div}")
    public ResponseEntity<List<StdSubGeoDiv>> getStdSubGeoDiv(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv) {
        log.debug("REST request to get StdSubGeoDiv : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv);

        List<StdSubGeoDiv> StdSubGeoDivByInput = stdSubGeoDivRepository.findByIdOrganizationStdIdCountryStdIdGeoDiv(idOrganization, stdIdCountry, stdIdGeoDiv);
        return ResponseEntity.ok().body(StdSubGeoDivByInput);
    }


    @DeleteMapping("/std_sub_geo_div/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
    public ResponseEntity<Void> deleteStdSubGeoDiv(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv, @PathVariable("std_id_sub_geo_div") String stdIdSubGeoDiv) {
        log.debug("REST request to delete std_sub_geo_div : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv + "|" + stdIdSubGeoDiv);
        StdSubGeoDivId id = new StdSubGeoDivId();
        id.setIdOrganization(idOrganization);
        id.setStdIdCountry(stdIdCountry);
        id.setStdIdGeoDiv(stdIdGeoDiv);
        id.setStdIdSubGeoDiv(stdIdSubGeoDiv);

        stdSubGeoDivRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/std_sub_geo_div")
  public ResponseEntity<StdSubGeoDiv> createStdSubGeoDiv(@RequestBody StdSubGeoDiv stdSubGeoDiv)
    throws URISyntaxException {
    log.debug("REST request to create std_sub_geo_div : {}", stdSubGeoDiv);
    StdSubGeoDivId id = new StdSubGeoDivId();
    StdSubGeoDivServices stdSubGeoDivServices = new StdSubGeoDivServices(stdSubGeoDivRepository);
    String id_stdIdSubGeoDiv = stdSubGeoDivServices.UltimaSecuencia(stdSubGeoDiv);

    id.setStdIdSubGeoDiv(id_stdIdSubGeoDiv);
    id.setIdOrganization(idOrganization);
id.setStdIdCountry(stdSubGeoDiv.getId().getStdIdCountry());
id.setStdIdGeoDiv(stdSubGeoDiv.getId().getStdIdGeoDiv());

    stdSubGeoDiv.setId(id);
    StdSubGeoDiv result = stdSubGeoDivRepository.save(stdSubGeoDiv);
    return ResponseEntity
      .created(new URI("/api/std_sub_geo_div/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/std_sub_geo_div/{std_id_country}/{std_id_geo_div}/{std_id_sub_geo_div}")
  public ResponseEntity<StdSubGeoDiv> getStdSubGeoDiv(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv, @PathVariable("std_id_sub_geo_div") String stdIdSubGeoDiv) {
      log.debug("REST request to get StdSubGeoDiv : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv + "|" + stdIdSubGeoDiv);
      StdSubGeoDivId id = new StdSubGeoDivId();
      id.setIdOrganization(idOrganization);
id.setStdIdCountry(stdIdCountry);
id.setStdIdGeoDiv(stdIdGeoDiv);
      id.setStdIdSubGeoDiv(stdIdSubGeoDiv);

      Optional<StdSubGeoDiv> stdSubGeoDiv = stdSubGeoDivRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(stdSubGeoDiv);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/std_sub_geo_div/{std_id_country}/{std_id_geo_div}")
  public ResponseEntity<Void> deleteStdSubGeoDiv(@PathVariable("std_id_country") String stdIdCountry, @PathVariable("std_id_geo_div") String stdIdGeoDiv) {
    log.debug("REST request to delete std_sub_geo_div : {}", idOrganization + "|" + stdIdCountry + "|" + stdIdGeoDiv);
    List<StdSubGeoDiv> StdSubGeoDivByInput = stdSubGeoDivRepository.findByIdOrganizationStdIdCountryStdIdGeoDiv(idOrganization, stdIdCountry, stdIdGeoDiv);

    stdSubGeoDivRepository.deleteAll(StdSubGeoDivByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdSubGeoDivByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/std_sub_geo_div")
public ResponseEntity<StdSubGeoDiv> updateStdSubGeoDiv(@RequestBody StdSubGeoDiv stdSubGeoDiv)
  throws URISyntaxException {
  log.debug("REST request to update std_sub_geo_div : {}", stdSubGeoDiv);
  if (stdSubGeoDiv.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  StdSubGeoDiv result = stdSubGeoDivRepository.save(stdSubGeoDiv);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, stdSubGeoDiv.getId().toString()))
    .body(result);
}


*/
