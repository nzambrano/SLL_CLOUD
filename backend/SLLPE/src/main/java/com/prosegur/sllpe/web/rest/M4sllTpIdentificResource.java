package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpIdentific;
import com.prosegur.sllpe.domain.M4sllTpIdentificId;
import com.prosegur.sllpe.repository.M4sllTpIdentificRepository;
import com.prosegur.sllpe.service.M4sllTpIdentificServices;
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
public class M4sllTpIdentificResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpIdentificResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpIdentific";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpIdentificRepository m4sllTpIdentificRepository;

    public M4sllTpIdentificResource(M4sllTpIdentificRepository m4sllTpIdentificRepository) {
        this.m4sllTpIdentificRepository = m4sllTpIdentificRepository;
    }

    @PostMapping("/m4sll_tp_identific")
    public ResponseEntity<M4sllTpIdentific> createM4sllTpIdentific(@RequestBody M4sllTpIdentific m4sll_tp_identific)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_identific : {}", m4sll_tp_identific);
        M4sllTpIdentificId id = new M4sllTpIdentificId();
        M4sllTpIdentificServices m4sllTpIdentificServices = new M4sllTpIdentificServices(m4sllTpIdentificRepository);
        String id_tpi_id_tp_identificacion = m4sllTpIdentificServices.UltimaSecuencia(m4sll_tp_identific);

        id.setTpiIdTpIdentificacion(id_tpi_id_tp_identificacion);
        id.setIdOrganization(m4sll_tp_identific.getId().getIdOrganization());

        m4sll_tp_identific.setId(id);
        M4sllTpIdentific result = m4sllTpIdentificRepository.save(m4sll_tp_identific);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_identific/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_identific")
    public ResponseEntity<M4sllTpIdentific> updateM4sllTpIdentific(@RequestBody M4sllTpIdentific m4sll_tp_identific)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_identific : {}", m4sll_tp_identific);
        if (m4sll_tp_identific.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpIdentific result = m4sllTpIdentificRepository.save(m4sll_tp_identific);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_identific.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_identific")
    public ResponseEntity<List<M4sllTpIdentific>> getAllM4sllTpIdentific() {
        log.debug("REST request to get ALL M4sllTpIdentific : {}");

        List<M4sllTpIdentific> M4sllTpIdentificAll = m4sllTpIdentificRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpIdentificAll);
    }

    @GetMapping("/m4sll_tp_identific/{id_organization}")
    public ResponseEntity<List<M4sllTpIdentific>> getM4sllTpIdentific(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpIdentific : {}", id_organization);

        List<M4sllTpIdentific> M4sllTpIdentificByInput = m4sllTpIdentificRepository.findM4sllTpIdentificByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpIdentificByInput);
    }


    /*
      @GetMapping("/m4sll_tp_identific/{id_organization}/{tpi_id_tp_identificacion}")
      public ResponseEntity<M4sllTpIdentific> getM4sllTpIdentific(@PathVariable("id_organization") String id_organization, @PathVariable("tpi_id_tp_identificacion") String tpi_id_tp_identificacion) {
          log.debug("REST request to get M4sllTpIdentific : {}", id_organization + "|" + tpi_id_tp_identificacion);
          M4sllTpIdentificId id = new M4sllTpIdentificId();
          id.setIdOrganization(id_organization);
          id.setTpiIdTpIdentificacion(tpi_id_tp_identificacion);

          Optional<M4sllTpIdentific> m4sll_tp_identific = m4sllTpIdentificRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_identific);
      }

      @DeleteMapping("/m4sll_tp_identific/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpIdentific(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_identific : {}", id_organization);
        List<M4sllTpIdentific> M4sllTpIdentificByInput = m4sllTpIdentificRepository.findM4sllTpIdentificByIdOrganization(id_organization);

        m4sllTpIdentificRepository.deleteAll(M4sllTpIdentificByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpIdentificByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_identific/{id_organization}/{tpi_id_tp_identificacion}")
    public ResponseEntity<Void> deleteM4sllTpIdentific(@PathVariable("id_organization") String id_organization, @PathVariable("tpi_id_tp_identificacion") String tpi_id_tp_identificacion) {
        log.debug("REST request to delete m4sll_tp_identific : {}", id_organization + "|" + tpi_id_tp_identificacion);
        M4sllTpIdentificId id = new M4sllTpIdentificId();
        id.setIdOrganization(id_organization);
        id.setTpiIdTpIdentificacion(tpi_id_tp_identificacion);

        m4sllTpIdentificRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
