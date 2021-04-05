package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtoRiesgos;
import com.prosegur.sllpe.domain.M4sllMtoRiesgosId;
import com.prosegur.sllpe.repository.M4sllMtoRiesgosRepository;
import com.prosegur.sllpe.service.M4sllMtoRiesgosServices;
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
public class M4sllMtoRiesgosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllMtoRiesgosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtoRiesgos";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository;

    public M4sllMtoRiesgosResource(M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository) {
        this.m4sllMtoRiesgosRepository = m4sllMtoRiesgosRepository;
    }

    @PostMapping("/m4sll_mto_riesgos")
    public ResponseEntity<M4sllMtoRiesgos> createM4sllMtoRiesgos(@RequestBody M4sllMtoRiesgos m4sll_mto_riesgos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mto_riesgos : {}", m4sll_mto_riesgos);
        M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
        M4sllMtoRiesgosServices m4sllMtoRiesgosServices = new M4sllMtoRiesgosServices(m4sllMtoRiesgosRepository);
        String id_mri_id_riesgo = m4sllMtoRiesgosServices.UltimaSecuencia(m4sll_mto_riesgos);

        id.setMriIdRiesgo(id_mri_id_riesgo);
        id.setIdOrganization(m4sll_mto_riesgos.getId().getIdOrganization());

        m4sll_mto_riesgos.setId(id);
        M4sllMtoRiesgos result = m4sllMtoRiesgosRepository.save(m4sll_mto_riesgos);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_riesgos/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_mto_riesgos")
    public ResponseEntity<M4sllMtoRiesgos> updateM4sllMtoRiesgos(@RequestBody M4sllMtoRiesgos m4sll_mto_riesgos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mto_riesgos : {}", m4sll_mto_riesgos);
        if (m4sll_mto_riesgos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllMtoRiesgos result = m4sllMtoRiesgosRepository.save(m4sll_mto_riesgos);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_mto_riesgos.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_mto_riesgos")
    public ResponseEntity<List<M4sllMtoRiesgos>> getAllM4sllMtoRiesgos() {
        log.debug("REST request to get ALL M4sllMtoRiesgos : {}");

        List<M4sllMtoRiesgos> M4sllMtoRiesgosAll = m4sllMtoRiesgosRepository.findAll();
        return ResponseEntity.ok().body(M4sllMtoRiesgosAll);
    }

    @GetMapping("/m4sll_mto_riesgos/{id_organization}")
    public ResponseEntity<List<M4sllMtoRiesgos>> getM4sllMtoRiesgos(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllMtoRiesgos : {}", id_organization);

        List<M4sllMtoRiesgos> M4sllMtoRiesgosByInput = m4sllMtoRiesgosRepository.findM4sllMtoRiesgosByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllMtoRiesgosByInput);
    }


    /*
      @GetMapping("/m4sll_mto_riesgos/{id_organization}/{mri_id_riesgo}")
      public ResponseEntity<M4sllMtoRiesgos> getM4sllMtoRiesgos(@PathVariable("id_organization") String id_organization, @PathVariable("mri_id_riesgo") String mri_id_riesgo) {
          log.debug("REST request to get M4sllMtoRiesgos : {}", id_organization + "|" + mri_id_riesgo);
          M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
          id.setIdOrganization(id_organization);
          id.setMriIdRiesgo(mri_id_riesgo);

          Optional<M4sllMtoRiesgos> m4sll_mto_riesgos = m4sllMtoRiesgosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_mto_riesgos);
      }

      @DeleteMapping("/m4sll_mto_riesgos/{id_organization}")
      public ResponseEntity<Void> deleteM4sllMtoRiesgos(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_mto_riesgos : {}", id_organization);
        List<M4sllMtoRiesgos> M4sllMtoRiesgosByInput = m4sllMtoRiesgosRepository.findM4sllMtoRiesgosByIdOrganization(id_organization);

        m4sllMtoRiesgosRepository.deleteAll(M4sllMtoRiesgosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllMtoRiesgosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_mto_riesgos/{id_organization}/{mri_id_riesgo}")
    public ResponseEntity<Void> deleteM4sllMtoRiesgos(@PathVariable("id_organization") String id_organization, @PathVariable("mri_id_riesgo") String mri_id_riesgo) {
        log.debug("REST request to delete m4sll_mto_riesgos : {}", id_organization + "|" + mri_id_riesgo);
        M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
        id.setIdOrganization(id_organization);
        id.setMriIdRiesgo(mri_id_riesgo);

        m4sllMtoRiesgosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
