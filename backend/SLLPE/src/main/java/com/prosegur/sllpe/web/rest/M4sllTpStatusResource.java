package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpStatus;
import com.prosegur.sllpe.domain.M4sllTpStatusId;
import com.prosegur.sllpe.repository.M4sllTpStatusRepository;
import com.prosegur.sllpe.service.M4sllTpStatusServices;
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
public class M4sllTpStatusResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpStatusResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpStatus";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpStatusRepository m4sllTpStatusRepository;

    public M4sllTpStatusResource(M4sllTpStatusRepository m4sllTpStatusRepository) {
        this.m4sllTpStatusRepository = m4sllTpStatusRepository;
    }

    @PostMapping("/m4sll_tp_status")
    public ResponseEntity<M4sllTpStatus> createM4sllTpStatus(@RequestBody M4sllTpStatus m4sll_tp_status)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_status : {}", m4sll_tp_status);
        M4sllTpStatusId id = new M4sllTpStatusId();
        M4sllTpStatusServices m4sllTpStatusServices = new M4sllTpStatusServices(m4sllTpStatusRepository);
        String id_tst_id_tp_status = m4sllTpStatusServices.UltimaSecuencia(m4sll_tp_status);

        id.setTstIdTpStatus(id_tst_id_tp_status);
        id.setIdOrganization(m4sll_tp_status.getId().getIdOrganization());

        m4sll_tp_status.setId(id);
        M4sllTpStatus result = m4sllTpStatusRepository.save(m4sll_tp_status);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_status/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_status")
    public ResponseEntity<M4sllTpStatus> updateM4sllTpStatus(@RequestBody M4sllTpStatus m4sll_tp_status)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_status : {}", m4sll_tp_status);
        if (m4sll_tp_status.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpStatus result = m4sllTpStatusRepository.save(m4sll_tp_status);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_status.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_status")
    public ResponseEntity<List<M4sllTpStatus>> getAllM4sllTpStatus() {
        log.debug("REST request to get ALL M4sllTpStatus : {}");

        List<M4sllTpStatus> M4sllTpStatusAll = m4sllTpStatusRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpStatusAll);
    }

    @GetMapping("/m4sll_tp_status/{id_organization}")
    public ResponseEntity<List<M4sllTpStatus>> getM4sllTpStatus(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpStatus : {}", id_organization);

        List<M4sllTpStatus> M4sllTpStatusByInput = m4sllTpStatusRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpStatusByInput);
    }


    /*
      @GetMapping("/m4sll_tp_status/{id_organization}/{tst_id_tp_status}")
      public ResponseEntity<M4sllTpStatus> getM4sllTpStatus(@PathVariable("id_organization") String id_organization, @PathVariable("tst_id_tp_status") String tst_id_tp_status) {
          log.debug("REST request to get M4sllTpStatus : {}", id_organization + "|" + tst_id_tp_status);
          M4sllTpStatusId id = new M4sllTpStatusId();
          id.setIdOrganization(id_organization);
          id.setTstIdTpStatus(tst_id_tp_status);

          Optional<M4sllTpStatus> m4sll_tp_status = m4sllTpStatusRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_status);
      }

      @DeleteMapping("/m4sll_tp_status/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpStatus(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_status : {}", id_organization);
        List<M4sllTpStatus> M4sllTpStatusByInput = m4sllTpStatusRepository.findByIdOrganization(id_organization);

        m4sllTpStatusRepository.deleteAll(M4sllTpStatusByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpStatusByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_status/{id_organization}/{tst_id_tp_status}")
    public ResponseEntity<Void> deleteM4sllTpStatus(@PathVariable("id_organization") String id_organization, @PathVariable("tst_id_tp_status") String tst_id_tp_status) {
        log.debug("REST request to delete m4sll_tp_status : {}", id_organization + "|" + tst_id_tp_status);
        M4sllTpStatusId id = new M4sllTpStatusId();
        id.setIdOrganization(id_organization);
        id.setTstIdTpStatus(tst_id_tp_status);

        m4sllTpStatusRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
