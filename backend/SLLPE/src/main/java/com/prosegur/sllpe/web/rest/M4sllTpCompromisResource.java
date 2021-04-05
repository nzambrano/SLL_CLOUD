package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpCompromis;
import com.prosegur.sllpe.domain.M4sllTpCompromisId;
import com.prosegur.sllpe.repository.M4sllTpCompromisRepository;
import com.prosegur.sllpe.service.M4sllTpCompromisServices;
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
public class M4sllTpCompromisResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpCompromisResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpCompromis";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpCompromisRepository m4sllTpCompromisRepository;

    public M4sllTpCompromisResource(M4sllTpCompromisRepository m4sllTpCompromisRepository) {
        this.m4sllTpCompromisRepository = m4sllTpCompromisRepository;
    }

    @PostMapping("/m4sll_tp_compromis")
    public ResponseEntity<M4sllTpCompromis> createM4sllTpCompromis(@RequestBody M4sllTpCompromis m4sll_tp_compromis)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_compromis : {}", m4sll_tp_compromis);
        M4sllTpCompromisId id = new M4sllTpCompromisId();
        M4sllTpCompromisServices m4sllTpCompromisServices = new M4sllTpCompromisServices(m4sllTpCompromisRepository);
        String id_tco_id_tp_compromiso = m4sllTpCompromisServices.UltimaSecuencia(m4sll_tp_compromis);

        id.setTcoIdTpCompromiso(id_tco_id_tp_compromiso);
        id.setIdOrganization(m4sll_tp_compromis.getId().getIdOrganization());

        m4sll_tp_compromis.setId(id);
        M4sllTpCompromis result = m4sllTpCompromisRepository.save(m4sll_tp_compromis);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_compromis/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_compromis")
    public ResponseEntity<M4sllTpCompromis> updateM4sllTpCompromis(@RequestBody M4sllTpCompromis m4sll_tp_compromis)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_compromis : {}", m4sll_tp_compromis);
        if (m4sll_tp_compromis.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpCompromis result = m4sllTpCompromisRepository.save(m4sll_tp_compromis);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_compromis.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_compromis")
    public ResponseEntity<List<M4sllTpCompromis>> getAllM4sllTpCompromis() {
        log.debug("REST request to get ALL M4sllTpCompromis : {}");

        List<M4sllTpCompromis> M4sllTpCompromisAll = m4sllTpCompromisRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpCompromisAll);
    }

    @GetMapping("/m4sll_tp_compromis/{id_organization}")
    public ResponseEntity<List<M4sllTpCompromis>> getM4sllTpCompromis(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpCompromis : {}", id_organization);

        List<M4sllTpCompromis> M4sllTpCompromisByInput = m4sllTpCompromisRepository.findM4sllTpCompromisByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpCompromisByInput);
    }


    /*
      @GetMapping("/m4sll_tp_compromis/{id_organization}/{tco_id_tp_compromiso}")
      public ResponseEntity<M4sllTpCompromis> getM4sllTpCompromis(@PathVariable("id_organization") String id_organization, @PathVariable("tco_id_tp_compromiso") String tco_id_tp_compromiso) {
          log.debug("REST request to get M4sllTpCompromis : {}", id_organization + "|" + tco_id_tp_compromiso);
          M4sllTpCompromisId id = new M4sllTpCompromisId();
          id.setIdOrganization(id_organization);
          id.setTcoIdTpCompromiso(tco_id_tp_compromiso);

          Optional<M4sllTpCompromis> m4sll_tp_compromis = m4sllTpCompromisRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_compromis);
      }

      @DeleteMapping("/m4sll_tp_compromis/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpCompromis(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_compromis : {}", id_organization);
        List<M4sllTpCompromis> M4sllTpCompromisByInput = m4sllTpCompromisRepository.findM4sllTpCompromisByIdOrganization(id_organization);

        m4sllTpCompromisRepository.deleteAll(M4sllTpCompromisByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpCompromisByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_compromis/{id_organization}/{tco_id_tp_compromiso}")
    public ResponseEntity<Void> deleteM4sllTpCompromis(@PathVariable("id_organization") String id_organization, @PathVariable("tco_id_tp_compromiso") String tco_id_tp_compromiso) {
        log.debug("REST request to delete m4sll_tp_compromis : {}", id_organization + "|" + tco_id_tp_compromiso);
        M4sllTpCompromisId id = new M4sllTpCompromisId();
        id.setIdOrganization(id_organization);
        id.setTcoIdTpCompromiso(tco_id_tp_compromiso);

        m4sllTpCompromisRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
