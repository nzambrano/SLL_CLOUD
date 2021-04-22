package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.domain.StdCountryId;
import com.prosegur.sllpe.repository.StdCountryRepository;
import com.prosegur.sllpe.service.StdCountryServices;
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
public class StdCountryResource {
    private final Logger log = LoggerFactory.getLogger(StdCountryResource.class);
    private static final String ENTITY_NAME = "sllpeStdCountry";

    @Autowired
    StdCountryServices stdCountryServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private StdCountryRepository stdCountryRepository;

    public StdCountryResource(StdCountryRepository stdCountryRepository) {
        this.stdCountryRepository = stdCountryRepository;
    }

    @PostMapping("/std_country")
    public ResponseEntity<List<StdCountry>> createStdCountry(@RequestBody List<StdCountry> listStdCountry)
    throws URISyntaxException {
        log.debug("REST request to create std_country : {}", listStdCountry);
        List<StdCountry>result =  stdCountryServices.saveAllWithSecuencia(listStdCountry);
        return ResponseEntity
               .created(new URI("/api/std_country/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/std_country")
    public ResponseEntity<List<StdCountry>> updateStdCountry(@RequestBody List<StdCountry> listStdCountry)
    throws URISyntaxException {
        log.debug("REST request to update std_country : {}", listStdCountry);
        List<StdCountry> result = stdCountryRepository.saveAll(listStdCountry);
        return ResponseEntity
               .created(new URI("/api/std_country/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/std_country")
        public ResponseEntity<List<StdCountry>> getAllStdCountry() {
          log.debug("REST request to get ALL StdCountry : {}");

          List<StdCountry> StdCountryAll = stdCountryRepository.findAll();
          return ResponseEntity.ok().body(StdCountryAll);
        }
    */

    @GetMapping("/std_country")
    public ResponseEntity<List<StdCountry>> getStdCountry() {
        log.debug("REST request to get StdCountry : {}", idOrganization);

        List<StdCountry> StdCountryByInput = stdCountryRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(StdCountryByInput);
    }


    @DeleteMapping("/std_country/{std_id_country}")
    public ResponseEntity<Void> deleteStdCountry(@PathVariable("std_id_country") String stdIdCountry) {
        log.debug("REST request to delete std_country : {}", idOrganization + "|" + stdIdCountry);
        StdCountryId id = new StdCountryId();
        id.setIdOrganization(idOrganization);
        id.setStdIdCountry(stdIdCountry);

        stdCountryRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/std_country")
  public ResponseEntity<StdCountry> createStdCountry(@RequestBody StdCountry stdCountry)
    throws URISyntaxException {
    log.debug("REST request to create std_country : {}", stdCountry);
    StdCountryId id = new StdCountryId();
    StdCountryServices stdCountryServices = new StdCountryServices(stdCountryRepository);
    String id_stdIdCountry = stdCountryServices.UltimaSecuencia(stdCountry);

    id.setStdIdCountry(id_stdIdCountry);
    id.setIdOrganization(idOrganization);

    stdCountry.setId(id);
    StdCountry result = stdCountryRepository.save(stdCountry);
    return ResponseEntity
      .created(new URI("/api/std_country/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/std_country/{std_id_country}")
  public ResponseEntity<StdCountry> getStdCountry(@PathVariable("std_id_country") String stdIdCountry) {
      log.debug("REST request to get StdCountry : {}", idOrganization + "|" + stdIdCountry);
      StdCountryId id = new StdCountryId();
      id.setIdOrganization(idOrganization);
      id.setStdIdCountry(stdIdCountry);

      Optional<StdCountry> stdCountry = stdCountryRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(stdCountry);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/std_country")
  public ResponseEntity<Void> deleteStdCountry() {
    log.debug("REST request to delete std_country : {}", idOrganization);
    List<StdCountry> StdCountryByInput = stdCountryRepository.findByIdOrganization(idOrganization);

    stdCountryRepository.deleteAll(StdCountryByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, StdCountryByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/std_country")
public ResponseEntity<StdCountry> updateStdCountry(@RequestBody StdCountry stdCountry)
  throws URISyntaxException {
  log.debug("REST request to update std_country : {}", stdCountry);
  if (stdCountry.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  StdCountry result = stdCountryRepository.save(stdCountry);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, stdCountry.getId().toString()))
    .body(result);
}


*/
