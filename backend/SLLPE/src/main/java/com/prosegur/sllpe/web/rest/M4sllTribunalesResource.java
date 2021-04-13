package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTribunales;
import com.prosegur.sllpe.domain.M4sllTribunalesId;
import com.prosegur.sllpe.repository.M4sllTribunalesRepository;
import com.prosegur.sllpe.service.M4sllTribunalesServices;
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
public class M4sllTribunalesResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTribunalesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTribunales";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTribunalesRepository m4sllTribunalesRepository;

    public M4sllTribunalesResource(M4sllTribunalesRepository m4sllTribunalesRepository) {
        this.m4sllTribunalesRepository = m4sllTribunalesRepository;
    }

    @PostMapping("/m4sll_tribunales")
    public ResponseEntity<M4sllTribunales> createM4sllTribunales(@RequestBody M4sllTribunales m4sll_tribunales)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tribunales : {}", m4sll_tribunales);
        M4sllTribunalesId id = new M4sllTribunalesId();
        M4sllTribunalesServices m4sllTribunalesServices = new M4sllTribunalesServices(m4sllTribunalesRepository);
        String id_tri_id_tribunal = m4sllTribunalesServices.UltimaSecuencia(m4sll_tribunales);

        id.setTriIdTribunal(id_tri_id_tribunal);
        id.setIdOrganization(m4sll_tribunales.getId().getIdOrganization());

        m4sll_tribunales.setId(id);
        M4sllTribunales result = m4sllTribunalesRepository.save(m4sll_tribunales);
        return ResponseEntity
               .created(new URI("/api/m4sll_tribunales/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tribunales")
    public ResponseEntity<M4sllTribunales> updateM4sllTribunales(@RequestBody M4sllTribunales m4sll_tribunales)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tribunales : {}", m4sll_tribunales);
        if (m4sll_tribunales.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTribunales result = m4sllTribunalesRepository.save(m4sll_tribunales);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tribunales.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tribunales")
    public ResponseEntity<List<M4sllTribunales>> getAllM4sllTribunales() {
        log.debug("REST request to get ALL M4sllTribunales : {}");

        List<M4sllTribunales> M4sllTribunalesAll = m4sllTribunalesRepository.findAll();
        return ResponseEntity.ok().body(M4sllTribunalesAll);
    }

    @GetMapping("/m4sll_tribunales/{id_organization}")
    public ResponseEntity<List<M4sllTribunales>> getM4sllTribunales(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTribunales : {}", id_organization);

        List<M4sllTribunales> M4sllTribunalesByInput = m4sllTribunalesRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTribunalesByInput);
    }


    /*
      @GetMapping("/m4sll_tribunales/{id_organization}/{tri_id_tribunal}")
      public ResponseEntity<M4sllTribunales> getM4sllTribunales(@PathVariable("id_organization") String id_organization, @PathVariable("tri_id_tribunal") String tri_id_tribunal) {
          log.debug("REST request to get M4sllTribunales : {}", id_organization + "|" + tri_id_tribunal);
          M4sllTribunalesId id = new M4sllTribunalesId();
          id.setIdOrganization(id_organization);
          id.setTriIdTribunal(tri_id_tribunal);

          Optional<M4sllTribunales> m4sll_tribunales = m4sllTribunalesRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tribunales);
      }

      @DeleteMapping("/m4sll_tribunales/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTribunales(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tribunales : {}", id_organization);
        List<M4sllTribunales> M4sllTribunalesByInput = m4sllTribunalesRepository.findByIdOrganization(id_organization);

        m4sllTribunalesRepository.deleteAll(M4sllTribunalesByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTribunalesByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tribunales/{id_organization}/{tri_id_tribunal}")
    public ResponseEntity<Void> deleteM4sllTribunales(@PathVariable("id_organization") String id_organization, @PathVariable("tri_id_tribunal") String tri_id_tribunal) {
        log.debug("REST request to delete m4sll_tribunales : {}", id_organization + "|" + tri_id_tribunal);
        M4sllTribunalesId id = new M4sllTribunalesId();
        id.setIdOrganization(id_organization);
        id.setTriIdTribunal(tri_id_tribunal);

        m4sllTribunalesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
