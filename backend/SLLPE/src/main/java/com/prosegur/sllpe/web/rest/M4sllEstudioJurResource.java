package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.domain.M4sllEstudioJurId;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;
import com.prosegur.sllpe.service.M4sllEstudioJurServices;
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
public class M4sllEstudioJurResource {

    private final Logger log = LoggerFactory.getLogger(M4sllEstudioJurResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllEstudioJur";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllEstudioJurRepository m4sllEstudioJurRepository;

    public M4sllEstudioJurResource(M4sllEstudioJurRepository m4sllEstudioJurRepository) {
        this.m4sllEstudioJurRepository = m4sllEstudioJurRepository;
    }

    @PostMapping("/m4sll_estudio_jur")
    public ResponseEntity<M4sllEstudioJur> createM4sllEstudioJur(@RequestBody M4sllEstudioJur m4sll_estudio_jur)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_estudio_jur : {}", m4sll_estudio_jur);
        M4sllEstudioJurId id = new M4sllEstudioJurId();
        M4sllEstudioJurServices m4sllEstudioJurServices = new M4sllEstudioJurServices(m4sllEstudioJurRepository);
        Long id_eju_id_est_juridico = m4sllEstudioJurServices.UltimaSecuencia(m4sll_estudio_jur);

        id.setEjuIdEstJuridico(id_eju_id_est_juridico);
        id.setIdOrganization(m4sll_estudio_jur.getId().getIdOrganization());

        m4sll_estudio_jur.setId(id);
        M4sllEstudioJur result = m4sllEstudioJurRepository.save(m4sll_estudio_jur);
        return ResponseEntity
               .created(new URI("/api/m4sll_estudio_jur/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_estudio_jur")
    public ResponseEntity<M4sllEstudioJur> updateM4sllEstudioJur(@RequestBody M4sllEstudioJur m4sll_estudio_jur)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_estudio_jur : {}", m4sll_estudio_jur);
        if (m4sll_estudio_jur.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllEstudioJur result = m4sllEstudioJurRepository.save(m4sll_estudio_jur);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_estudio_jur.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_estudio_jur")
    public ResponseEntity<List<M4sllEstudioJur>> getAllM4sllEstudioJur() {
        log.debug("REST request to get ALL M4sllEstudioJur : {}");

        List<M4sllEstudioJur> M4sllEstudioJurAll = m4sllEstudioJurRepository.findAll();
        return ResponseEntity.ok().body(M4sllEstudioJurAll);
    }

    @GetMapping("/m4sll_estudio_jur/{id_organization}")
    public ResponseEntity<List<M4sllEstudioJur>> getM4sllEstudioJur(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllEstudioJur : {}", id_organization);

        List<M4sllEstudioJur> M4sllEstudioJurByInput = m4sllEstudioJurRepository.findM4sllEstudioJurByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllEstudioJurByInput);
    }


    /*
      @GetMapping("/m4sll_estudio_jur/{id_organization}/{eju_id_est_juridico}")
      public ResponseEntity<M4sllEstudioJur> getM4sllEstudioJur(@PathVariable("id_organization") String id_organization, @PathVariable("eju_id_est_juridico") Long eju_id_est_juridico) {
          log.debug("REST request to get M4sllEstudioJur : {}", id_organization + "|" + eju_id_est_juridico);
          M4sllEstudioJurId id = new M4sllEstudioJurId();
          id.setIdOrganization(id_organization);
          id.setEjuIdEstJuridico(eju_id_est_juridico);

          Optional<M4sllEstudioJur> m4sll_estudio_jur = m4sllEstudioJurRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_estudio_jur);
      }

      @DeleteMapping("/m4sll_estudio_jur/{id_organization}")
      public ResponseEntity<Void> deleteM4sllEstudioJur(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_estudio_jur : {}", id_organization);
        List<M4sllEstudioJur> M4sllEstudioJurByInput = m4sllEstudioJurRepository.findM4sllEstudioJurByIdOrganization(id_organization);

        m4sllEstudioJurRepository.deleteAll(M4sllEstudioJurByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllEstudioJurByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_estudio_jur/{id_organization}/{eju_id_est_juridico}")
    public ResponseEntity<Void> deleteM4sllEstudioJur(@PathVariable("id_organization") String id_organization, @PathVariable("eju_id_est_juridico") Long eju_id_est_juridico) {
        log.debug("REST request to delete m4sll_estudio_jur : {}", id_organization + "|" + eju_id_est_juridico);
        M4sllEstudioJurId id = new M4sllEstudioJurId();
        id.setIdOrganization(id_organization);
        id.setEjuIdEstJuridico(eju_id_est_juridico);

        m4sllEstudioJurRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
