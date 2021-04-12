package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpValEco;
import com.prosegur.sllpe.domain.M4sllTpValEcoId;
import com.prosegur.sllpe.repository.M4sllTpValEcoRepository;
import com.prosegur.sllpe.service.M4sllTpValEcoServices;
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
@RequestMapping("/sllpe")
@Transactional
public class M4sllTpValEcoResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpValEcoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpValEco";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpValEcoRepository m4sllTpValEcoRepository;

    public M4sllTpValEcoResource(M4sllTpValEcoRepository m4sllTpValEcoRepository) {
        this.m4sllTpValEcoRepository = m4sllTpValEcoRepository;
    }

    @PostMapping("/m4sll_tp_val_eco")
    public ResponseEntity<M4sllTpValEco> createM4sllTpValEco(@RequestBody M4sllTpValEco m4sll_tp_val_eco)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_val_eco : {}", m4sll_tp_val_eco);
        M4sllTpValEcoId id = new M4sllTpValEcoId();
        M4sllTpValEcoServices m4sllTpValEcoServices = new M4sllTpValEcoServices(m4sllTpValEcoRepository);
        String id_tve_id_val_eco = m4sllTpValEcoServices.UltimaSecuencia(m4sll_tp_val_eco);

        id.setTveIdValEco(id_tve_id_val_eco);
        id.setIdOrganization(m4sll_tp_val_eco.getId().getIdOrganization());

        m4sll_tp_val_eco.setId(id);
        M4sllTpValEco result = m4sllTpValEcoRepository.save(m4sll_tp_val_eco);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_val_eco/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_val_eco")
    public ResponseEntity<M4sllTpValEco> updateM4sllTpValEco(@RequestBody M4sllTpValEco m4sll_tp_val_eco)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_val_eco : {}", m4sll_tp_val_eco);
        if (m4sll_tp_val_eco.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpValEco result = m4sllTpValEcoRepository.save(m4sll_tp_val_eco);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_val_eco.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_val_eco")
    public ResponseEntity<List<M4sllTpValEco>> getAllM4sllTpValEco() {
        log.debug("REST request to get ALL M4sllTpValEco : {}");

        List<M4sllTpValEco> M4sllTpValEcoAll = m4sllTpValEcoRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpValEcoAll);
    }

    @GetMapping("/m4sll_tp_val_eco/{id_organization}")
    public ResponseEntity<List<M4sllTpValEco>> getM4sllTpValEco(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpValEco : {}", id_organization);

        List<M4sllTpValEco> M4sllTpValEcoByInput = m4sllTpValEcoRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpValEcoByInput);
    }


    /*
      @GetMapping("/m4sll_tp_val_eco/{id_organization}/{tve_id_val_eco}")
      public ResponseEntity<M4sllTpValEco> getM4sllTpValEco(@PathVariable("id_organization") String id_organization, @PathVariable("tve_id_val_eco") String tve_id_val_eco) {
          log.debug("REST request to get M4sllTpValEco : {}", id_organization + "|" + tve_id_val_eco);
          M4sllTpValEcoId id = new M4sllTpValEcoId();
          id.setIdOrganization(id_organization);
          id.setTveIdValEco(tve_id_val_eco);

          Optional<M4sllTpValEco> m4sll_tp_val_eco = m4sllTpValEcoRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_val_eco);
      }

      @DeleteMapping("/m4sll_tp_val_eco/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpValEco(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_val_eco : {}", id_organization);
        List<M4sllTpValEco> M4sllTpValEcoByInput = m4sllTpValEcoRepository.findByIdOrganization(id_organization);

        m4sllTpValEcoRepository.deleteAll(M4sllTpValEcoByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpValEcoByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_val_eco/{id_organization}/{tve_id_val_eco}")
    public ResponseEntity<Void> deleteM4sllTpValEco(@PathVariable("id_organization") String id_organization, @PathVariable("tve_id_val_eco") String tve_id_val_eco) {
        log.debug("REST request to delete m4sll_tp_val_eco : {}", id_organization + "|" + tve_id_val_eco);
        M4sllTpValEcoId id = new M4sllTpValEcoId();
        id.setIdOrganization(id_organization);
        id.setTveIdValEco(tve_id_val_eco);

        m4sllTpValEcoRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
