package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdLegEnt;
import com.prosegur.sllpe.domain.StdLegEntId;
import com.prosegur.sllpe.repository.StdLegEntRepository;
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

public class StdLegEntResource {
    private final Logger log = LoggerFactory.getLogger(StdLegEntResource.class);
    private static final String ENTITY_NAME = "sllpeStdLegEnt";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private StdLegEntRepository stdLegEntRepository;

    public StdLegEntResource(StdLegEntRepository stdLegEntRepository) {
        this.stdLegEntRepository = stdLegEntRepository;
    }
    @PostMapping("/std_leg_ent")
    public ResponseEntity<List<StdLegEnt>> createStdLegEnt(@RequestBody List<StdLegEnt> listStdLegEnt)
    throws URISyntaxException {
        log.debug("REST request to create std_leg_ent : {}", listStdLegEnt);
        List<StdLegEnt> result = stdLegEntRepository.saveAll(listStdLegEnt);
        return ResponseEntity
               .created(new URI("/api/std_leg_ent/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @PutMapping("/std_leg_ent")
    public ResponseEntity<List<StdLegEnt>> updateStdLegEnt(@RequestBody List<StdLegEnt> listStdLegEnt)
    throws URISyntaxException {
        log.debug("REST request to update std_leg_ent : {}", listStdLegEnt);
        List<StdLegEnt> result = stdLegEntRepository.saveAll(listStdLegEnt);
        return ResponseEntity
               .created(new URI("/api/std_leg_ent/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/std_leg_ent")
    public ResponseEntity<List<StdLegEnt>> getAllStdLegEnt() {
        log.debug("REST request to get ALL StdLegEnt : {}");

        List<StdLegEnt> StdLegEntAll = stdLegEntRepository.findAll();
        return ResponseEntity.ok().body(StdLegEntAll);
    }

    @GetMapping("/std_leg_ent/{std_id_leg_ent}")
    public ResponseEntity<StdLegEnt> getStdLegEnt(@PathVariable("std_id_leg_ent") String stdIdLegEnt) {
        log.debug("REST request to get StdLegEnt : {}", idOrganization + "|" + stdIdLegEnt);
        StdLegEntId id = new StdLegEntId();
        id.setIdOrganization(idOrganization);
        id.setStdIdLegEnt(stdIdLegEnt);

        Optional<StdLegEnt> stdLegEnt = stdLegEntRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(stdLegEnt);
    }

    @GetMapping("/std_leg_ent/")
    public ResponseEntity<List<StdLegEnt>> getStdLegEnt() {
        log.debug("REST request to get StdLegEnt : {}", idOrganization);

        List<StdLegEnt> StdLegEntByInput = stdLegEntRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(StdLegEntByInput);
    }

    @DeleteMapping("/std_leg_ent/{std_id_leg_ent}")
    public ResponseEntity<Void> deleteStdLegEnt(@PathVariable("std_id_leg_ent") String stdIdLegEnt) {
        log.debug("REST request to delete std_leg_ent : {}", idOrganization + "|" + stdIdLegEnt);
        StdLegEntId id = new StdLegEntId();
        id.setIdOrganization(idOrganization);
        id.setStdIdLegEnt(stdIdLegEnt);

        stdLegEntRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/std_leg_ent")
    public ResponseEntity<StdLegEnt> createStdLegEnt(@RequestBody StdLegEnt stdLegEnt)
            throws URISyntaxException {
        log.debug("REST request to create std_leg_ent : {}", stdLegEnt);

        StdLegEnt result = stdLegEntRepository.save(stdLegEnt);
        return ResponseEntity
                .created(new URI("/api/std_leg_ent/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un solo registro
    @PutMapping("/std_leg_ent")
    public ResponseEntity<StdLegEnt> updateStdLegEnt(@RequestBody StdLegEnt stdLegEnt)
            throws URISyntaxException {
        log.debug("REST request to update std_leg_ent : {}", stdLegEnt);
        if (stdLegEnt.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdLegEnt result = stdLegEntRepository.save(stdLegEnt);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                stdLegEnt.getId().toString())).body(result);
    }


*/