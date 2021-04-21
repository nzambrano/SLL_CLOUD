package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdPerson;
import com.prosegur.sllpe.domain.StdPersonId;
import com.prosegur.sllpe.repository.StdPersonRepository;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional

public class StdPersonResource {
    private final Logger log = LoggerFactory.getLogger(StdPersonResource.class);
    private static final String ENTITY_NAME = "sllpeStdPerson";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private StdPersonRepository stdPersonRepository;

    public StdPersonResource(StdPersonRepository stdPersonRepository) {
        this.stdPersonRepository = stdPersonRepository;
    }
    @PostMapping("/std_person")
    public ResponseEntity<List<StdPerson>> createStdPerson(@RequestBody List<StdPerson> listStdPerson)
    throws URISyntaxException {
        log.debug("REST request to create std_person : {}", listStdPerson);
        List<StdPerson> result = stdPersonRepository.saveAll(listStdPerson);
        return ResponseEntity
               .created(new URI("/api/std_person/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @PutMapping("/std_person")
    public ResponseEntity<List<StdPerson>> updateStdPerson(@RequestBody List<StdPerson> listStdPerson)
    throws URISyntaxException {
        log.debug("REST request to update std_person : {}", listStdPerson);
        List<StdPerson> result = stdPersonRepository.saveAll(listStdPerson);
        return ResponseEntity
               .created(new URI("/api/std_person/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/std_person")
    public ResponseEntity<List<StdPerson>> getAllStdPerson() {
        log.debug("REST request to get ALL StdPerson : {}");

        List<StdPerson> StdPersonAll = stdPersonRepository.findAll();
        return ResponseEntity.ok().body(StdPersonAll);
    }

    @GetMapping("/std_person/{std_id_person}")
    public ResponseEntity<StdPerson> getStdPerson(@PathVariable("std_id_person") String stdIdPerson) {
        log.debug("REST request to get StdPerson : {}", idOrganization + "|" + stdIdPerson);
        StdPersonId id = new StdPersonId();
        id.setIdOrganization(idOrganization);
        id.setStdIdPerson(stdIdPerson);

        Optional<StdPerson> stdPerson = stdPersonRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(stdPerson);
    }


    @DeleteMapping("/std_person/{std_id_person}")
    public ResponseEntity<Void> deleteStdPerson(@PathVariable("std_id_person") String stdIdPerson) {
        log.debug("REST request to delete std_person : {}", idOrganization + "|" + stdIdPerson);
        StdPersonId id = new StdPersonId();
        id.setIdOrganization(idOrganization);
        id.setStdIdPerson(stdIdPerson);

        stdPersonRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/std_person")
    public ResponseEntity<StdPerson> createStdPerson(@RequestBody StdPerson stdPerson)
            throws URISyntaxException {
        log.debug("REST request to create std_person : {}", stdPerson);

        StdPerson result = stdPersonRepository.save(stdPerson);
        return ResponseEntity
                .created(new URI("/api/std_person/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un solo registro
    @PutMapping("/std_person")
    public ResponseEntity<StdPerson> updateStdPerson(@RequestBody StdPerson stdPerson)
            throws URISyntaxException {
        log.debug("REST request to update std_person : {}", stdPerson);
        if (stdPerson.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdPerson result = stdPersonRepository.save(stdPerson);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                stdPerson.getId().toString())).body(result);
    }


*/