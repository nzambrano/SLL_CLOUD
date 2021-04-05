package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.domain.StdCountryId;
import com.prosegur.sllpe.repository.StdCountryRepository;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
// import io.github.jhipster.web.util.PaginationUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
// import org.springframework.data.domain.Page;
// import org.springframework.data.domain.Pageable;
// import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
// import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional

public class StdCountryResource {

    private final Logger log = LoggerFactory.getLogger(StdCountryResource.class);
    private static final String ENTITY_NAME = "sllpeStdCountry";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private StdCountryRepository stdCountryRepository;

    public StdCountryResource(StdCountryRepository stdCountryRepository) {
        this.stdCountryRepository = stdCountryRepository;
    }

    @PostMapping("/std_country")
    public ResponseEntity<StdCountry> createStdCountry(@RequestBody StdCountry std_country)
    throws URISyntaxException {
        log.debug("REST request to create std_country : {}", std_country);

        StdCountry result = stdCountryRepository.save(std_country);
        return ResponseEntity
               .created(new URI("/api/std_country/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/std_country")
    public ResponseEntity<StdCountry> updateStdCountry(@RequestBody StdCountry std_country)
    throws URISyntaxException {
        log.debug("REST request to update std_country : {}", std_country);
        if (std_country.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StdCountry result = stdCountryRepository.save(std_country);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           std_country.getId().toString())).body(result);
    }

    @GetMapping("/std_country")
    public ResponseEntity<List<StdCountry>> getAllStdCountry() {
        log.debug("REST request to get ALL StdCountry : {}");

        List<StdCountry> StdCountryAll = stdCountryRepository.findAll();
        return ResponseEntity.ok().body(StdCountryAll);
    }

    @GetMapping("/std_country/{std_id_country}/{id_organization}")
    public ResponseEntity<StdCountry> getStdCountry(@PathVariable("std_id_country") String std_id_country, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get StdCountry : {}", std_id_country + "|" + id_organization);
        StdCountryId id = new StdCountryId();
        id.setStdIdCountry(std_id_country);
        id.setIdOrganization(id_organization);

        Optional<StdCountry> std_country = stdCountryRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(std_country);
    }


    @DeleteMapping("/std_country/{std_id_country}/{id_organization}")
    public ResponseEntity<Void> deleteStdCountry(@PathVariable("std_id_country") String std_id_country, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete std_country : {}", std_id_country + "|" + id_organization);
        StdCountryId id = new StdCountryId();
        id.setStdIdCountry(std_id_country);
        id.setIdOrganization(id_organization);

        stdCountryRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}