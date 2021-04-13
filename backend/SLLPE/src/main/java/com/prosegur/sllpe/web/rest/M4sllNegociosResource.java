package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.domain.M4sllNegociosId;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;
import com.prosegur.sllpe.service.M4sllNegociosServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;
import io.github.jhipster.web.util.HeaderUtil;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class M4sllNegociosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllNegociosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllNegocios";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllNegociosRepository m4sllNegociosRepository;

    public M4sllNegociosResource(M4sllNegociosRepository m4sllNegociosRepository) {
        this.m4sllNegociosRepository = m4sllNegociosRepository;
    }

    @PostMapping("/m4sll_negocios")
    public ResponseEntity<M4sllNegocios> createM4sllNegocios(@RequestBody M4sllNegocios m4sll_negocios)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_negocios : {}", m4sll_negocios);
        M4sllNegociosId id = new M4sllNegociosId();
        M4sllNegociosServices m4sllNegociosServices = new M4sllNegociosServices(m4sllNegociosRepository);
        String id_neg_id_negocio = m4sllNegociosServices.UltimaSecuencia(m4sll_negocios);

        id.setNegIdNegocio(id_neg_id_negocio);
        id.setIdOrganization(m4sll_negocios.getId().getIdOrganization());

        m4sll_negocios.setId(id);
        M4sllNegocios result = m4sllNegociosRepository.save(m4sll_negocios);
        return ResponseEntity
               .created(new URI("/api/m4sll_negocios/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_negocios")
    public ResponseEntity<M4sllNegocios> updateM4sllNegocios(@RequestBody M4sllNegocios m4sll_negocios)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_negocios : {}", m4sll_negocios);
        if (m4sll_negocios.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllNegocios result = m4sllNegociosRepository.save(m4sll_negocios);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_negocios.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_negocios")
    public ResponseEntity<List<M4sllNegocios>> getAllM4sllNegocios() {
        log.debug("REST request to get ALL M4sllNegocios : {}");

        List<M4sllNegocios> M4sllNegociosAll = m4sllNegociosRepository.findAll();
        return ResponseEntity.ok().body(M4sllNegociosAll);
    }

    @GetMapping("/m4sll_negocios/{id_organization}")
    public ResponseEntity<List<M4sllNegocios>> getM4sllNegocios(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllNegocios : {}", id_organization);

        List<M4sllNegocios> M4sllNegociosByInput = m4sllNegociosRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllNegociosByInput);
    }


    /*
      @GetMapping("/m4sll_negocios/{id_organization}/{neg_id_negocio}")
      public ResponseEntity<M4sllNegocios> getM4sllNegocios(@PathVariable("id_organization") String id_organization, @PathVariable("neg_id_negocio") String neg_id_negocio) {
          log.debug("REST request to get M4sllNegocios : {}", id_organization + "|" + neg_id_negocio);
          M4sllNegociosId id = new M4sllNegociosId();
          id.setIdOrganization(id_organization);
          id.setNegIdNegocio(neg_id_negocio);

          Optional<M4sllNegocios> m4sll_negocios = m4sllNegociosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_negocios);
      }

      @DeleteMapping("/m4sll_negocios/{id_organization}")
      public ResponseEntity<Void> deleteM4sllNegocios(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_negocios : {}", id_organization);
        List<M4sllNegocios> M4sllNegociosByInput = m4sllNegociosRepository.findByIdOrganization(id_organization);

        m4sllNegociosRepository.deleteAll(M4sllNegociosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllNegociosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_negocios/{id_organization}/{neg_id_negocio}")
    public ResponseEntity<Void> deleteM4sllNegocios(@PathVariable("id_organization") String id_organization, @PathVariable("neg_id_negocio") String neg_id_negocio) {
        log.debug("REST request to delete m4sll_negocios : {}", id_organization + "|" + neg_id_negocio);
        M4sllNegociosId id = new M4sllNegociosId();
        id.setIdOrganization(id_organization);
        id.setNegIdNegocio(neg_id_negocio);

        m4sllNegociosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
