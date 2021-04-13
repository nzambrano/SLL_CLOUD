package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllDocLitigios;
import com.prosegur.sllpe.domain.M4sllDocLitigiosId;
import com.prosegur.sllpe.repository.M4sllDocLitigiosRepository;
import com.prosegur.sllpe.service.M4sllDocLitigiosServices;
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
public class M4sllDocLitigiosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllDocLitigiosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllDocLitigios";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllDocLitigiosRepository m4sllDocLitigiosRepository;

    public M4sllDocLitigiosResource(M4sllDocLitigiosRepository m4sllDocLitigiosRepository) {
        this.m4sllDocLitigiosRepository = m4sllDocLitigiosRepository;
    }

    @PostMapping("/m4sll_doc_litigios")
    public ResponseEntity<M4sllDocLitigios> createM4sllDocLitigios(@RequestBody M4sllDocLitigios m4sll_doc_litigios)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_doc_litigios : {}", m4sll_doc_litigios);
        M4sllDocLitigiosId id = new M4sllDocLitigiosId();
        M4sllDocLitigiosServices m4sllDocLitigiosServices = new M4sllDocLitigiosServices(m4sllDocLitigiosRepository);
        Long id_dol_secuencia = m4sllDocLitigiosServices.UltimaSecuencia(m4sll_doc_litigios);

        id.setDolSecuencia(id_dol_secuencia);
        id.setIdOrganization(m4sll_doc_litigios.getId().getIdOrganization());
        id.setLitIdLitigio(m4sll_doc_litigios.getId().getLitIdLitigio());

        m4sll_doc_litigios.setId(id);
        M4sllDocLitigios result = m4sllDocLitigiosRepository.save(m4sll_doc_litigios);
        return ResponseEntity
               .created(new URI("/api/m4sll_doc_litigios/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_doc_litigios")
    public ResponseEntity<M4sllDocLitigios> updateM4sllDocLitigios(@RequestBody M4sllDocLitigios m4sll_doc_litigios)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_doc_litigios : {}", m4sll_doc_litigios);
        if (m4sll_doc_litigios.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllDocLitigios result = m4sllDocLitigiosRepository.save(m4sll_doc_litigios);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_doc_litigios.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_doc_litigios")
    public ResponseEntity<List<M4sllDocLitigios>> getAllM4sllDocLitigios() {
        log.debug("REST request to get ALL M4sllDocLitigios : {}");

        List<M4sllDocLitigios> M4sllDocLitigiosAll = m4sllDocLitigiosRepository.findAll();
        return ResponseEntity.ok().body(M4sllDocLitigiosAll);
    }

    @GetMapping("/m4sll_doc_litigios/{id_organization}/{lit_id_litigio}")
    public ResponseEntity<List<M4sllDocLitigios>> getM4sllDocLitigios(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllDocLitigios : {}", id_organization + "|" + lit_id_litigio);

        List<M4sllDocLitigios> M4sllDocLitigiosByInput = m4sllDocLitigiosRepository.findByIdOrganizationLitIdLitigio(id_organization, lit_id_litigio);
        return ResponseEntity.ok().body(M4sllDocLitigiosByInput);
    }


    /*
      @GetMapping("/m4sll_doc_litigios/{id_organization}/{lit_id_litigio}/{dol_secuencia}")
      public ResponseEntity<M4sllDocLitigios> getM4sllDocLitigios(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("dol_secuencia") Long dol_secuencia) {
          log.debug("REST request to get M4sllDocLitigios : {}", id_organization + "|" + lit_id_litigio + "|" + dol_secuencia);
          M4sllDocLitigiosId id = new M4sllDocLitigiosId();
          id.setIdOrganization(id_organization); id.setLitIdLitigio(lit_id_litigio);
          id.setDolSecuencia(dol_secuencia);

          Optional<M4sllDocLitigios> m4sll_doc_litigios = m4sllDocLitigiosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_doc_litigios);
      }

      @DeleteMapping("/m4sll_doc_litigios/{id_organization}/{lit_id_litigio}")
      public ResponseEntity<Void> deleteM4sllDocLitigios(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to delete m4sll_doc_litigios : {}", id_organization + "|" + lit_id_litigio);
        List<M4sllDocLitigios> M4sllDocLitigiosByInput = m4sllDocLitigiosRepository.findByIdOrganizationLitIdLitigio(id_organization, lit_id_litigio);

        m4sllDocLitigiosRepository.deleteAll(M4sllDocLitigiosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllDocLitigiosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_doc_litigios/{id_organization}/{lit_id_litigio}/{dol_secuencia}")
    public ResponseEntity<Void> deleteM4sllDocLitigios(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("dol_secuencia") Long dol_secuencia) {
        log.debug("REST request to delete m4sll_doc_litigios : {}", id_organization + "|" + lit_id_litigio + "|" + dol_secuencia);
        M4sllDocLitigiosId id = new M4sllDocLitigiosId();
        id.setIdOrganization(id_organization);
        id.setLitIdLitigio(lit_id_litigio);
        id.setDolSecuencia(dol_secuencia);

        m4sllDocLitigiosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
