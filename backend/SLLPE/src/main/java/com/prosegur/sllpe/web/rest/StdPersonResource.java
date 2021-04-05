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

    private StdPersonRepository stdPersonRepository;

    public StdPersonResource(StdPersonRepository stdPersonRepository) {
        this.stdPersonRepository = stdPersonRepository;
    }

    @PostMapping("/std_person")
    public ResponseEntity<StdPerson> createStdPerson(@RequestBody StdPerson std_person)
    throws URISyntaxException {
        log.debug("REST request to create std_person : {}", std_person);

        StdPerson result = stdPersonRepository.save(std_person);
        return ResponseEntity
               .created(new URI("/api/std_person/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/std_person")
    public ResponseEntity<StdPerson> updateStdPerson(@RequestBody StdPerson std_person)
    throws URISyntaxException {
        log.debug("REST request to update std_person : {}", std_person);
        if (std_person.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdPerson result = stdPersonRepository.save(std_person);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           std_person.getId().toString())).body(result);
    }

    @GetMapping("/std_person")
    public ResponseEntity<List<StdPerson>> getAllStdPerson() {
        log.debug("REST request to get ALL StdPerson : {}");

        List<StdPerson> StdPersonAll = stdPersonRepository.findAll();
        return ResponseEntity.ok().body(StdPersonAll);
    }

    @GetMapping("/std_person/{std_id_person}/{id_organization}")
    public ResponseEntity<StdPerson> getStdPerson(@PathVariable("std_id_person") String std_id_person, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get StdPerson : {}", std_id_person + "|" + id_organization);
        StdPersonId id = new StdPersonId();
        id.setStdIdPerson(std_id_person);
        id.setIdOrganization(id_organization);

        Optional<StdPerson> std_person = stdPersonRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(std_person);
    }

    @GetMapping("/std_person/{std_id_person}")
    public ResponseEntity<List<StdPerson>> getStdPerson(@PathVariable("std_id_person") String std_id_person) {
        log.debug("REST request to get StdPerson : {}", std_id_person);

        List<StdPerson> StdPersonByInput = stdPersonRepository.findByStdIdPerson(std_id_person);
        return ResponseEntity.ok().body(StdPersonByInput);
    }

    @DeleteMapping("/std_person/{std_id_person}/{id_organization}")
    public ResponseEntity<Void> deleteStdPerson(@PathVariable("std_id_person") String std_id_person, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete std_person : {}", std_id_person + "|" + id_organization);
        StdPersonId id = new StdPersonId();
        id.setStdIdPerson(std_id_person);
        id.setIdOrganization(id_organization);

        stdPersonRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}