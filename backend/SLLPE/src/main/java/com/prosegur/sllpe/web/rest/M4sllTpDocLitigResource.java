package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.domain.M4sllTpDocLitigId;
import com.prosegur.sllpe.repository.M4sllTpDocLitigRepository;
import com.prosegur.sllpe.service.M4sllTpDocLitigServices;
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
public class M4sllTpDocLitigResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpDocLitigResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpDocLitig";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpDocLitigRepository m4sllTpDocLitigRepository;

    public M4sllTpDocLitigResource(M4sllTpDocLitigRepository m4sllTpDocLitigRepository) {
        this.m4sllTpDocLitigRepository = m4sllTpDocLitigRepository;
    }

    @PostMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<M4sllTpDocLitig> createM4sllTpDocLitig(@RequestBody M4sllTpDocLitig m4sll_tp_doc_litig)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_doc_litig : {}", m4sll_tp_doc_litig);
        M4sllTpDocLitigId id = new M4sllTpDocLitigId();
        M4sllTpDocLitigServices m4sllTpDocLitigServices = new M4sllTpDocLitigServices(m4sllTpDocLitigRepository);
        String id_tdl_id_tp_doc_litigio = m4sllTpDocLitigServices.UltimaSecuencia(m4sll_tp_doc_litig);

        id.setTdlIdTpDocLitigio(id_tdl_id_tp_doc_litigio);
        id.setIdOrganization(m4sll_tp_doc_litig.getId().getIdOrganization());

        m4sll_tp_doc_litig.setId(id);
        M4sllTpDocLitig result = m4sllTpDocLitigRepository.save(m4sll_tp_doc_litig);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_doc_litig/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<M4sllTpDocLitig> updateM4sllTpDocLitig(@RequestBody M4sllTpDocLitig m4sll_tp_doc_litig)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_doc_litig : {}", m4sll_tp_doc_litig);
        if (m4sll_tp_doc_litig.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpDocLitig result = m4sllTpDocLitigRepository.save(m4sll_tp_doc_litig);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_doc_litig.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<List<M4sllTpDocLitig>> getAllM4sllTpDocLitig() {
        log.debug("REST request to get ALL M4sllTpDocLitig : {}");

        List<M4sllTpDocLitig> M4sllTpDocLitigAll = m4sllTpDocLitigRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpDocLitigAll);
    }

    @GetMapping("/m4sll_tp_doc_litig/{id_organization}")
    public ResponseEntity<List<M4sllTpDocLitig>> getM4sllTpDocLitig(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpDocLitig : {}", id_organization);

        List<M4sllTpDocLitig> M4sllTpDocLitigByInput = m4sllTpDocLitigRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpDocLitigByInput);
    }


    /*
      @GetMapping("/m4sll_tp_doc_litig/{id_organization}/{tdl_id_tp_doc_litigio}")
      public ResponseEntity<M4sllTpDocLitig> getM4sllTpDocLitig(@PathVariable("id_organization") String id_organization, @PathVariable("tdl_id_tp_doc_litigio") String tdl_id_tp_doc_litigio) {
          log.debug("REST request to get M4sllTpDocLitig : {}", id_organization + "|" + tdl_id_tp_doc_litigio);
          M4sllTpDocLitigId id = new M4sllTpDocLitigId();
          id.setIdOrganization(id_organization);
          id.setTdlIdTpDocLitigio(tdl_id_tp_doc_litigio);

          Optional<M4sllTpDocLitig> m4sll_tp_doc_litig = m4sllTpDocLitigRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_doc_litig);
      }

      @DeleteMapping("/m4sll_tp_doc_litig/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpDocLitig(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_doc_litig : {}", id_organization);
        List<M4sllTpDocLitig> M4sllTpDocLitigByInput = m4sllTpDocLitigRepository.findByIdOrganization(id_organization);

        m4sllTpDocLitigRepository.deleteAll(M4sllTpDocLitigByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpDocLitigByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_doc_litig/{id_organization}/{tdl_id_tp_doc_litigio}")
    public ResponseEntity<Void> deleteM4sllTpDocLitig(@PathVariable("id_organization") String id_organization, @PathVariable("tdl_id_tp_doc_litigio") String tdl_id_tp_doc_litigio) {
        log.debug("REST request to delete m4sll_tp_doc_litig : {}", id_organization + "|" + tdl_id_tp_doc_litigio);
        M4sllTpDocLitigId id = new M4sllTpDocLitigId();
        id.setIdOrganization(id_organization);
        id.setTdlIdTpDocLitigio(tdl_id_tp_doc_litigio);

        m4sllTpDocLitigRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
