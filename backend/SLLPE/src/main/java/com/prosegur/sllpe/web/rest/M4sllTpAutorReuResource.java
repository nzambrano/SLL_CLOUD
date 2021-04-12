package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpAutorReu;
import com.prosegur.sllpe.domain.M4sllTpAutorReuId;
import com.prosegur.sllpe.repository.M4sllTpAutorReuRepository;
import com.prosegur.sllpe.service.M4sllTpAutorReuServices;
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
public class M4sllTpAutorReuResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpAutorReuResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpAutorReu";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpAutorReuRepository m4sllTpAutorReuRepository;

    public M4sllTpAutorReuResource(M4sllTpAutorReuRepository m4sllTpAutorReuRepository) {
        this.m4sllTpAutorReuRepository = m4sllTpAutorReuRepository;
    }

    @PostMapping("/m4sll_tp_autor_reu")
    public ResponseEntity<M4sllTpAutorReu> createM4sllTpAutorReu(@RequestBody M4sllTpAutorReu m4sll_tp_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_autor_reu : {}", m4sll_tp_autor_reu);
        M4sllTpAutorReuId id = new M4sllTpAutorReuId();
        M4sllTpAutorReuServices m4sllTpAutorReuServices = new M4sllTpAutorReuServices(m4sllTpAutorReuRepository);
        String id_tar_id_tp_autor_reu = m4sllTpAutorReuServices.UltimaSecuencia(m4sll_tp_autor_reu);

        id.setTarIdTpAutorReu(id_tar_id_tp_autor_reu);
        id.setIdOrganization(m4sll_tp_autor_reu.getId().getIdOrganization());

        m4sll_tp_autor_reu.setId(id);
        M4sllTpAutorReu result = m4sllTpAutorReuRepository.save(m4sll_tp_autor_reu);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_autor_reu/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_autor_reu")
    public ResponseEntity<M4sllTpAutorReu> updateM4sllTpAutorReu(@RequestBody M4sllTpAutorReu m4sll_tp_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_autor_reu : {}", m4sll_tp_autor_reu);
        if (m4sll_tp_autor_reu.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpAutorReu result = m4sllTpAutorReuRepository.save(m4sll_tp_autor_reu);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_autor_reu.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_autor_reu")
    public ResponseEntity<List<M4sllTpAutorReu>> getAllM4sllTpAutorReu() {
        log.debug("REST request to get ALL M4sllTpAutorReu : {}");

        List<M4sllTpAutorReu> M4sllTpAutorReuAll = m4sllTpAutorReuRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpAutorReuAll);
    }

    @GetMapping("/m4sll_tp_autor_reu/{id_organization}")
    public ResponseEntity<List<M4sllTpAutorReu>> getM4sllTpAutorReu(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpAutorReu : {}", id_organization);

        List<M4sllTpAutorReu> M4sllTpAutorReuByInput = m4sllTpAutorReuRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpAutorReuByInput);
    }


    /*
      @GetMapping("/m4sll_tp_autor_reu/{id_organization}/{tar_id_tp_autor_reu}")
      public ResponseEntity<M4sllTpAutorReu> getM4sllTpAutorReu(@PathVariable("id_organization") String id_organization, @PathVariable("tar_id_tp_autor_reu") String tar_id_tp_autor_reu) {
          log.debug("REST request to get M4sllTpAutorReu : {}", id_organization + "|" + tar_id_tp_autor_reu);
          M4sllTpAutorReuId id = new M4sllTpAutorReuId();
          id.setIdOrganization(id_organization);
          id.setTarIdTpAutorReu(tar_id_tp_autor_reu);

          Optional<M4sllTpAutorReu> m4sll_tp_autor_reu = m4sllTpAutorReuRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_autor_reu);
      }

      @DeleteMapping("/m4sll_tp_autor_reu/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpAutorReu(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_autor_reu : {}", id_organization);
        List<M4sllTpAutorReu> M4sllTpAutorReuByInput = m4sllTpAutorReuRepository.findByIdOrganization(id_organization);

        m4sllTpAutorReuRepository.deleteAll(M4sllTpAutorReuByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpAutorReuByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_autor_reu/{id_organization}/{tar_id_tp_autor_reu}")
    public ResponseEntity<Void> deleteM4sllTpAutorReu(@PathVariable("id_organization") String id_organization, @PathVariable("tar_id_tp_autor_reu") String tar_id_tp_autor_reu) {
        log.debug("REST request to delete m4sll_tp_autor_reu : {}", id_organization + "|" + tar_id_tp_autor_reu);
        M4sllTpAutorReuId id = new M4sllTpAutorReuId();
        id.setIdOrganization(id_organization);
        id.setTarIdTpAutorReu(tar_id_tp_autor_reu);

        m4sllTpAutorReuRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
