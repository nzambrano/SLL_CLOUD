package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.domain.M4sllTpFasesId;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;
import com.prosegur.sllpe.service.M4sllTpFasesServices;
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
public class M4sllTpFasesResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpFasesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpFases";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpFasesRepository m4sllTpFasesRepository;

    public M4sllTpFasesResource(M4sllTpFasesRepository m4sllTpFasesRepository) {
        this.m4sllTpFasesRepository = m4sllTpFasesRepository;
    }

    @PostMapping("/m4sll_tp_fases")
    public ResponseEntity<M4sllTpFases> createM4sllTpFases(@RequestBody M4sllTpFases m4sll_tp_fases)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_fases : {}", m4sll_tp_fases);
        M4sllTpFasesId id = new M4sllTpFasesId();
        M4sllTpFasesServices m4sllTpFasesServices = new M4sllTpFasesServices(m4sllTpFasesRepository);
        String id_tfa_id_tp_fase = m4sllTpFasesServices.UltimaSecuencia(m4sll_tp_fases);

        id.setTfaIdTpFase(id_tfa_id_tp_fase);
        id.setIdOrganization(m4sll_tp_fases.getId().getIdOrganization());

        m4sll_tp_fases.setId(id);
        M4sllTpFases result = m4sllTpFasesRepository.save(m4sll_tp_fases);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_fases/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_fases")
    public ResponseEntity<M4sllTpFases> updateM4sllTpFases(@RequestBody M4sllTpFases m4sll_tp_fases)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_fases : {}", m4sll_tp_fases);
        if (m4sll_tp_fases.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpFases result = m4sllTpFasesRepository.save(m4sll_tp_fases);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_fases.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_fases")
    public ResponseEntity<List<M4sllTpFases>> getAllM4sllTpFases() {
        log.debug("REST request to get ALL M4sllTpFases : {}");

        List<M4sllTpFases> M4sllTpFasesAll = m4sllTpFasesRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpFasesAll);
    }

    @GetMapping("/m4sll_tp_fases/{id_organization}")
    public ResponseEntity<List<M4sllTpFases>> getM4sllTpFases(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpFases : {}", id_organization);

        List<M4sllTpFases> M4sllTpFasesByInput = m4sllTpFasesRepository.findM4sllTpFasesByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpFasesByInput);
    }


    /*
      @GetMapping("/m4sll_tp_fases/{id_organization}/{tfa_id_tp_fase}")
      public ResponseEntity<M4sllTpFases> getM4sllTpFases(@PathVariable("id_organization") String id_organization, @PathVariable("tfa_id_tp_fase") String tfa_id_tp_fase) {
          log.debug("REST request to get M4sllTpFases : {}", id_organization + "|" + tfa_id_tp_fase);
          M4sllTpFasesId id = new M4sllTpFasesId();
          id.setIdOrganization(id_organization);
          id.setTfaIdTpFase(tfa_id_tp_fase);

          Optional<M4sllTpFases> m4sll_tp_fases = m4sllTpFasesRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_fases);
      }

      @DeleteMapping("/m4sll_tp_fases/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpFases(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_fases : {}", id_organization);
        List<M4sllTpFases> M4sllTpFasesByInput = m4sllTpFasesRepository.findM4sllTpFasesByIdOrganization(id_organization);

        m4sllTpFasesRepository.deleteAll(M4sllTpFasesByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpFasesByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_fases/{id_organization}/{tfa_id_tp_fase}")
    public ResponseEntity<Void> deleteM4sllTpFases(@PathVariable("id_organization") String id_organization, @PathVariable("tfa_id_tp_fase") String tfa_id_tp_fase) {
        log.debug("REST request to delete m4sll_tp_fases : {}", id_organization + "|" + tfa_id_tp_fase);
        M4sllTpFasesId id = new M4sllTpFasesId();
        id.setIdOrganization(id_organization);
        id.setTfaIdTpFase(tfa_id_tp_fase);

        m4sllTpFasesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
