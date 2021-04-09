package com.prosegur.sllpe.web.rest;


import com.prosegur.sllpe.domain.M4sllLitigios;
import com.prosegur.sllpe.domain.M4sllLitigiosId;
import com.prosegur.sllpe.repository.M4sllLitigiosRepository;
import com.prosegur.sllpe.service.M4sllLitigiosServices;
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

public class M4sllLitigiosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllLitigiosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllLitigios";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private String idOrganization = "0050";

    private M4sllLitigiosRepository m4sllLitigiosRepository;

    public M4sllLitigiosResource(M4sllLitigiosRepository m4sllLitigiosRepository) {
        this.m4sllLitigiosRepository = m4sllLitigiosRepository;
    }

    @PostMapping("/m4sll_litigios")
    public ResponseEntity<M4sllLitigios> createM4sllLitigios(@RequestBody M4sllLitigios m4sll_litigios)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_litigios : {}", m4sll_litigios);
        M4sllLitigiosServices litigiosService = new M4sllLitigiosServices(m4sllLitigiosRepository);
        String id = litigiosService.UltimaSecuencia(m4sll_litigios);

        M4sllLitigiosId idLitigio = new M4sllLitigiosId();
        idLitigio.setLitIdLitigio(id);
        idLitigio.setIdOrganization(idOrganization);

        m4sll_litigios.setId(idLitigio);
        M4sllLitigios result = m4sllLitigiosRepository.save(m4sll_litigios);

        return ResponseEntity
               .created(new URI("/api/m4sll_litigios/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_litigios")
    public ResponseEntity<M4sllLitigios> updateM4sllLitigios(@RequestBody M4sllLitigios m4sll_litigios)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_litigios : {}", m4sll_litigios);
        if (m4sll_litigios.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllLitigios result = m4sllLitigiosRepository.save(m4sll_litigios);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_litigios.getId().toString())).body(result);
    }

    @GetMapping("/m4sll_litigios")
    public ResponseEntity<List<M4sllLitigios>> getAllM4sllLitigios() {
        log.debug("REST request to get ALL M4sllLitigios : {}");

        List<M4sllLitigios> M4sllLitigiosAll = m4sllLitigiosRepository.findAll();
        return ResponseEntity.ok().body(M4sllLitigiosAll);
    }

    @GetMapping("/m4sll_litigios/{id_litIdLitigio}/{id_idOrganization}")
    public ResponseEntity<M4sllLitigios> getM4sllLitigios(
        @PathVariable("id_litIdLitigio") String id_litIdLitigio,
        @PathVariable("id_idOrganization") String id_idOrganization) {
        log.debug("REST request to get m4sll_litigios : {} | {}", id_litIdLitigio, id_idOrganization);
        M4sllLitigiosId id = new M4sllLitigiosId();
        id.setLitIdLitigio(id_litIdLitigio);
        id.setIdOrganization(id_idOrganization);
        
        Optional<M4sllLitigios> m4sll_litigios = m4sllLitigiosRepository.findById(id);
        // m4sll_litigios.getAutorReu();
        return ResponseUtil.wrapOrNotFound(m4sll_litigios);
        
    }

    @DeleteMapping("/m4sll_litigios/{id_litIdLitigio}/{id_idOrganization}")
    public ResponseEntity<Void> deleteM4sllLitigios(
        @PathVariable("id_litIdLitigio") String id_litIdLitigio,
        @PathVariable("id_idOrganization") String id_idOrganization) {
        log.debug("REST request to delete m4sll_litigios : {} | {}", id_litIdLitigio, id_idOrganization);
        M4sllLitigiosId id = new M4sllLitigiosId();
        id.setLitIdLitigio(id_litIdLitigio);
        id.setIdOrganization(id_idOrganization);

        m4sllLitigiosRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}