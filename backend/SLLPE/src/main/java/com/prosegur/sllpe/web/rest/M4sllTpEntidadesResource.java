package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpEntidades;
import com.prosegur.sllpe.domain.M4sllTpEntidadesId;
import com.prosegur.sllpe.repository.M4sllTpEntidadesRepository;
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

public class M4sllTpEntidadesResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpEntidadesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpEntidades";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpEntidadesRepository m4sllTpEntidadesRepository;

    public M4sllTpEntidadesResource(M4sllTpEntidadesRepository m4sllTpEntidadesRepository) {
        this.m4sllTpEntidadesRepository = m4sllTpEntidadesRepository;
    }
    @PostMapping("/m4sll_tp_entidades")
    public ResponseEntity<List<M4sllTpEntidades>> createM4sllTpEntidades(@RequestBody List<M4sllTpEntidades> listM4sllTpEntidades)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_entidades : {}", listM4sllTpEntidades);
        List<M4sllTpEntidades> result = m4sllTpEntidadesRepository.saveAll(listM4sllTpEntidades);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_entidades/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_entidades")
    public ResponseEntity<List<M4sllTpEntidades>> updateM4sllTpEntidades(@RequestBody List<M4sllTpEntidades> listM4sllTpEntidades)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_entidades : {}", listM4sllTpEntidades);
        List<M4sllTpEntidades> result = m4sllTpEntidadesRepository.saveAll(listM4sllTpEntidades);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_entidades/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_entidades")
    public ResponseEntity<List<M4sllTpEntidades>> getAllM4sllTpEntidades() {
        log.debug("REST request to get ALL M4sllTpEntidades : {}");

        List<M4sllTpEntidades> M4sllTpEntidadesAll = m4sllTpEntidadesRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpEntidadesAll);
    }

    @GetMapping("/m4sll_tp_entidades/{tpe_id_tp_entidad}")
    public ResponseEntity<M4sllTpEntidades> getM4sllTpEntidades(@PathVariable("tpe_id_tp_entidad") String tpeIdTpEntidad) {
        log.debug("REST request to get M4sllTpEntidades : {}", idOrganization + "|" + tpeIdTpEntidad);
        M4sllTpEntidadesId id = new M4sllTpEntidadesId();
        id.setIdOrganization(idOrganization);
        id.setTpeIdTpEntidad(tpeIdTpEntidad);

        Optional<M4sllTpEntidades> m4sllTpEntidades = m4sllTpEntidadesRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sllTpEntidades);
    }


    @DeleteMapping("/m4sll_tp_entidades/{tpe_id_tp_entidad}")
    public ResponseEntity<Void> deleteM4sllTpEntidades(@PathVariable("tpe_id_tp_entidad") String tpeIdTpEntidad) {
        log.debug("REST request to delete m4sll_tp_entidades : {}", idOrganization + "|" + tpeIdTpEntidad);
        M4sllTpEntidadesId id = new M4sllTpEntidadesId();
        id.setIdOrganization(idOrganization);
        id.setTpeIdTpEntidad(tpeIdTpEntidad);

        m4sllTpEntidadesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/m4sll_tp_entidades")
    public ResponseEntity<M4sllTpEntidades> createM4sllTpEntidades(@RequestBody M4sllTpEntidades m4sllTpEntidades)
            throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_entidades : {}", m4sllTpEntidades);

        M4sllTpEntidades result = m4sllTpEntidadesRepository.save(m4sllTpEntidades);
        return ResponseEntity
                .created(new URI("/api/m4sll_tp_entidades/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un solo registro
    @PutMapping("/m4sll_tp_entidades")
    public ResponseEntity<M4sllTpEntidades> updateM4sllTpEntidades(@RequestBody M4sllTpEntidades m4sllTpEntidades)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_entidades : {}", m4sllTpEntidades);
        if (m4sllTpEntidades.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpEntidades result = m4sllTpEntidadesRepository.save(m4sllTpEntidades);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sllTpEntidades.getId().toString())).body(result);
    }


*/