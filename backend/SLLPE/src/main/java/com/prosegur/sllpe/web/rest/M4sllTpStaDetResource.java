package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpStaDet;
import com.prosegur.sllpe.domain.M4sllTpStaDetId;
import com.prosegur.sllpe.repository.M4sllTpStaDetRepository;
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

public class M4sllTpStaDetResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpStaDetResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpStaDet";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpStaDetRepository m4sllTpStaDetRepository;

    public M4sllTpStaDetResource(M4sllTpStaDetRepository m4sllTpStaDetRepository) {
        this.m4sllTpStaDetRepository = m4sllTpStaDetRepository;
    }
    @PostMapping("/m4sll_tp_sta_det")
    public ResponseEntity<List<M4sllTpStaDet>> createM4sllTpStaDet(@RequestBody List<M4sllTpStaDet> listM4sllTpStaDet)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_sta_det : {}", listM4sllTpStaDet);
        List<M4sllTpStaDet> result = m4sllTpStaDetRepository.saveAll(listM4sllTpStaDet);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_sta_det/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_sta_det")
    public ResponseEntity<List<M4sllTpStaDet>> updateM4sllTpStaDet(@RequestBody List<M4sllTpStaDet> listM4sllTpStaDet)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_sta_det : {}", listM4sllTpStaDet);
        List<M4sllTpStaDet> result = m4sllTpStaDetRepository.saveAll(listM4sllTpStaDet);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_sta_det/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_sta_det")
    public ResponseEntity<List<M4sllTpStaDet>> getAllM4sllTpStaDet() {
        log.debug("REST request to get ALL M4sllTpStaDet : {}");

        List<M4sllTpStaDet> M4sllTpStaDetAll = m4sllTpStaDetRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpStaDetAll);
    }

    @GetMapping("/m4sll_tp_sta_det/{tsd_id_tp_sta_det}")
    public ResponseEntity<M4sllTpStaDet> getM4sllTpStaDet(@PathVariable("tsd_id_tp_sta_det") String tsdIdTpStaDet) {
        log.debug("REST request to get M4sllTpStaDet : {}", idOrganization + "|" + tsdIdTpStaDet);
        M4sllTpStaDetId id = new M4sllTpStaDetId();
        id.setIdOrganization(idOrganization);
        id.setTsdIdTpStaDet(tsdIdTpStaDet);

        Optional<M4sllTpStaDet> m4sllTpStaDet = m4sllTpStaDetRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sllTpStaDet);
    }


    @DeleteMapping("/m4sll_tp_sta_det/{tsd_id_tp_sta_det}")
    public ResponseEntity<Void> deleteM4sllTpStaDet(@PathVariable("tsd_id_tp_sta_det") String tsdIdTpStaDet) {
        log.debug("REST request to delete m4sll_tp_sta_det : {}", idOrganization + "|" + tsdIdTpStaDet);
        M4sllTpStaDetId id = new M4sllTpStaDetId();
        id.setIdOrganization(idOrganization);
        id.setTsdIdTpStaDet(tsdIdTpStaDet);

        m4sllTpStaDetRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/m4sll_tp_sta_det")
    public ResponseEntity<M4sllTpStaDet> createM4sllTpStaDet(@RequestBody M4sllTpStaDet m4sllTpStaDet)
            throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_sta_det : {}", m4sllTpStaDet);

        M4sllTpStaDet result = m4sllTpStaDetRepository.save(m4sllTpStaDet);
        return ResponseEntity
                .created(new URI("/api/m4sll_tp_sta_det/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un solo registro
    @PutMapping("/m4sll_tp_sta_det")
    public ResponseEntity<M4sllTpStaDet> updateM4sllTpStaDet(@RequestBody M4sllTpStaDet m4sllTpStaDet)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_sta_det : {}", m4sllTpStaDet);
        if (m4sllTpStaDet.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpStaDet result = m4sllTpStaDetRepository.save(m4sllTpStaDet);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sllTpStaDet.getId().toString())).body(result);
    }


*/