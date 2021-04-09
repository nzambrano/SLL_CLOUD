package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpLitigios;
import com.prosegur.sllpe.domain.M4sllTpLitigiosId;
import com.prosegur.sllpe.repository.M4sllTpLitigiosRepository;
import com.prosegur.sllpe.service.M4sllTpLitigiosServices;
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
public class M4sllTpLitigiosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpLitigiosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpLitigios";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpLitigiosRepository m4sllTpLitigiosRepository;

    public M4sllTpLitigiosResource(M4sllTpLitigiosRepository m4sllTpLitigiosRepository) {
        this.m4sllTpLitigiosRepository = m4sllTpLitigiosRepository;
    }

    @PostMapping("/m4sll_tp_litigios")
    public ResponseEntity<M4sllTpLitigios> createM4sllTpLitigios(@RequestBody M4sllTpLitigios m4sll_tp_litigios)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_litigios : {}", m4sll_tp_litigios);
        M4sllTpLitigiosId id = new M4sllTpLitigiosId();
        M4sllTpLitigiosServices m4sllTpLitigiosServices = new M4sllTpLitigiosServices(m4sllTpLitigiosRepository);
        String id_tpl_id_tp_litigio = m4sllTpLitigiosServices.UltimaSecuencia(m4sll_tp_litigios);

        id.setTplIdTpLitigio(id_tpl_id_tp_litigio);
        id.setIdOrganization(m4sll_tp_litigios.getId().getIdOrganization());

        m4sll_tp_litigios.setId(id);
        M4sllTpLitigios result = m4sllTpLitigiosRepository.save(m4sll_tp_litigios);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_litigios/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_litigios")
    public ResponseEntity<M4sllTpLitigios> updateM4sllTpLitigios(@RequestBody M4sllTpLitigios m4sll_tp_litigios)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_litigios : {}", m4sll_tp_litigios);
        if (m4sll_tp_litigios.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpLitigios result = m4sllTpLitigiosRepository.save(m4sll_tp_litigios);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_litigios.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_litigios")
    public ResponseEntity<List<M4sllTpLitigios>> getAllM4sllTpLitigios() {
        log.debug("REST request to get ALL M4sllTpLitigios : {}");

        List<M4sllTpLitigios> M4sllTpLitigiosAll = m4sllTpLitigiosRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpLitigiosAll);
    }

    @GetMapping("/m4sll_tp_litigios/{id_organization}")
    public ResponseEntity<List<M4sllTpLitigios>> getM4sllTpLitigios(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpLitigios : {}", id_organization);

        List<M4sllTpLitigios> M4sllTpLitigiosByInput = m4sllTpLitigiosRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpLitigiosByInput);
    }


    /*
      @GetMapping("/m4sll_tp_litigios/{id_organization}/{tpl_id_tp_litigio}")
      public ResponseEntity<M4sllTpLitigios> getM4sllTpLitigios(@PathVariable("id_organization") String id_organization, @PathVariable("tpl_id_tp_litigio") String tpl_id_tp_litigio) {
          log.debug("REST request to get M4sllTpLitigios : {}", id_organization + "|" + tpl_id_tp_litigio);
          M4sllTpLitigiosId id = new M4sllTpLitigiosId();
          id.setIdOrganization(id_organization);
          id.setTplIdTpLitigio(tpl_id_tp_litigio);

          Optional<M4sllTpLitigios> m4sll_tp_litigios = m4sllTpLitigiosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_litigios);
      }

      @DeleteMapping("/m4sll_tp_litigios/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpLitigios(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_litigios : {}", id_organization);
        List<M4sllTpLitigios> M4sllTpLitigiosByInput = m4sllTpLitigiosRepository.findByIdOrganization(id_organization);

        m4sllTpLitigiosRepository.deleteAll(M4sllTpLitigiosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpLitigiosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_litigios/{id_organization}/{tpl_id_tp_litigio}")
    public ResponseEntity<Void> deleteM4sllTpLitigios(@PathVariable("id_organization") String id_organization, @PathVariable("tpl_id_tp_litigio") String tpl_id_tp_litigio) {
        log.debug("REST request to delete m4sll_tp_litigios : {}", id_organization + "|" + tpl_id_tp_litigio);
        M4sllTpLitigiosId id = new M4sllTpLitigiosId();
        id.setIdOrganization(id_organization);
        id.setTplIdTpLitigio(tpl_id_tp_litigio);

        m4sllTpLitigiosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
