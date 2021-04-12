package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpMotivo;
import com.prosegur.sllpe.domain.M4sllTpMotivoId;
import com.prosegur.sllpe.repository.M4sllTpMotivoRepository;
import com.prosegur.sllpe.service.M4sllTpMotivoServices;
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
public class M4sllTpMotivoResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpMotivoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpMotivo";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpMotivoRepository m4sllTpMotivoRepository;

    public M4sllTpMotivoResource(M4sllTpMotivoRepository m4sllTpMotivoRepository) {
        this.m4sllTpMotivoRepository = m4sllTpMotivoRepository;
    }

    @PostMapping("/m4sll_tp_motivo")
    public ResponseEntity<M4sllTpMotivo> createM4sllTpMotivo(@RequestBody M4sllTpMotivo m4sll_tp_motivo)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_motivo : {}", m4sll_tp_motivo);
        M4sllTpMotivoId id = new M4sllTpMotivoId();
        M4sllTpMotivoServices m4sllTpMotivoServices = new M4sllTpMotivoServices(m4sllTpMotivoRepository);
        String id_tmo_id_tp_motivo = m4sllTpMotivoServices.UltimaSecuencia(m4sll_tp_motivo);

        id.setTmoIdTpMotivo(id_tmo_id_tp_motivo);
        id.setIdOrganization(m4sll_tp_motivo.getId().getIdOrganization());

        m4sll_tp_motivo.setId(id);
        M4sllTpMotivo result = m4sllTpMotivoRepository.save(m4sll_tp_motivo);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_motivo/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_motivo")
    public ResponseEntity<M4sllTpMotivo> updateM4sllTpMotivo(@RequestBody M4sllTpMotivo m4sll_tp_motivo)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_motivo : {}", m4sll_tp_motivo);
        if (m4sll_tp_motivo.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpMotivo result = m4sllTpMotivoRepository.save(m4sll_tp_motivo);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_motivo.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_motivo")
    public ResponseEntity<List<M4sllTpMotivo>> getAllM4sllTpMotivo() {
        log.debug("REST request to get ALL M4sllTpMotivo : {}");

        List<M4sllTpMotivo> M4sllTpMotivoAll = m4sllTpMotivoRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpMotivoAll);
    }

    @GetMapping("/m4sll_tp_motivo/{id_organization}")
    public ResponseEntity<List<M4sllTpMotivo>> getM4sllTpMotivo(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpMotivo : {}", id_organization);

        List<M4sllTpMotivo> M4sllTpMotivoByInput = m4sllTpMotivoRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpMotivoByInput);
    }


    /*
      @GetMapping("/m4sll_tp_motivo/{id_organization}/{tmo_id_tp_motivo}")
      public ResponseEntity<M4sllTpMotivo> getM4sllTpMotivo(@PathVariable("id_organization") String id_organization, @PathVariable("tmo_id_tp_motivo") String tmo_id_tp_motivo) {
          log.debug("REST request to get M4sllTpMotivo : {}", id_organization + "|" + tmo_id_tp_motivo);
          M4sllTpMotivoId id = new M4sllTpMotivoId();
          id.setIdOrganization(id_organization);
          id.setTmoIdTpMotivo(tmo_id_tp_motivo);

          Optional<M4sllTpMotivo> m4sll_tp_motivo = m4sllTpMotivoRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_motivo);
      }

      @DeleteMapping("/m4sll_tp_motivo/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpMotivo(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_motivo : {}", id_organization);
        List<M4sllTpMotivo> M4sllTpMotivoByInput = m4sllTpMotivoRepository.findByIdOrganization(id_organization);

        m4sllTpMotivoRepository.deleteAll(M4sllTpMotivoByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpMotivoByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_motivo/{id_organization}/{tmo_id_tp_motivo}")
    public ResponseEntity<Void> deleteM4sllTpMotivo(@PathVariable("id_organization") String id_organization, @PathVariable("tmo_id_tp_motivo") String tmo_id_tp_motivo) {
        log.debug("REST request to delete m4sll_tp_motivo : {}", id_organization + "|" + tmo_id_tp_motivo);
        M4sllTpMotivoId id = new M4sllTpMotivoId();
        id.setIdOrganization(id_organization);
        id.setTmoIdTpMotivo(tmo_id_tp_motivo);

        m4sllTpMotivoRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
