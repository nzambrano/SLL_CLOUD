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
@RequestMapping("/sllpe")
@Transactional

public class StdLegEntResource {

    private final Logger log = LoggerFactory.getLogger(StdLegEntResource.class);
    private static final String ENTITY_NAME = "sllpeStdLegEnt";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private StdLegEntRepository stdLegEntRepository;

    public StdLegEntResource(StdLegEntRepository stdLegEntRepository) {
        this.stdLegEntRepository = stdLegEntRepository;
    }

    @PostMapping("/std_leg_ent")
    public ResponseEntity<StdLegEnt> createStdLegEnt(@RequestBody StdLegEnt std_leg_ent)
    throws URISyntaxException {
        log.debug("REST request to create std_leg_ent : {}", std_leg_ent);

        StdLegEnt result = stdLegEntRepository.save(std_leg_ent);
        return ResponseEntity
               .created(new URI("/api/std_leg_ent/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/std_leg_ent")
    public ResponseEntity<StdLegEnt> updateStdLegEnt(@RequestBody StdLegEnt std_leg_ent)
    throws URISyntaxException {
        log.debug("REST request to update std_leg_ent : {}", std_leg_ent);
        if (std_leg_ent.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdLegEnt result = stdLegEntRepository.save(std_leg_ent);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           std_leg_ent.getId().toString())).body(result);
    }

    @GetMapping("/std_leg_ent")
    public ResponseEntity<List<StdLegEnt>> getAllStdLegEnt() {
        log.debug("REST request to get ALL StdLegEnt : {}");

        List<StdLegEnt> StdLegEntAll = stdLegEntRepository.findAll();
        return ResponseEntity.ok().body(StdLegEntAll);
    }

    @GetMapping("/std_leg_ent/{std_id_leg_ent}/{id_organization}")
    public ResponseEntity<StdLegEnt> getStdLegEnt(@PathVariable("std_id_leg_ent") String std_id_leg_ent, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get StdLegEnt : {}", std_id_leg_ent + "|" + id_organization);
        StdLegEntId id = new StdLegEntId();
        id.setStdIdLegEnt(std_id_leg_ent);
        id.setIdOrganization(id_organization);

        Optional<StdLegEnt> std_leg_ent = stdLegEntRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(std_leg_ent);
    }


    @DeleteMapping("/std_leg_ent/{std_id_leg_ent}/{id_organization}")
    public ResponseEntity<Void> deleteStdLegEnt(@PathVariable("std_id_leg_ent") String std_id_leg_ent, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete std_leg_ent : {}", std_id_leg_ent + "|" + id_organization);
        StdLegEntId id = new StdLegEntId();
        id.setStdIdLegEnt(std_id_leg_ent);
        id.setIdOrganization(id_organization);

        stdLegEntRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}