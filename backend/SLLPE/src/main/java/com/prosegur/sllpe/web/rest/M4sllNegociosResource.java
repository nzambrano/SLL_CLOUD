package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.domain.M4sllNegociosId;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;
import com.prosegur.sllpe.service.M4sllNegociosServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;
import io.github.jhipster.web.util.HeaderUtil;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class M4sllNegociosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllNegociosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllNegocios";

    @Autowired
    M4sllNegociosServices m4sllNegociosServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllNegociosRepository m4sllNegociosRepository;

    public M4sllNegociosResource(M4sllNegociosRepository m4sllNegociosRepository) {
        this.m4sllNegociosRepository = m4sllNegociosRepository;
    }

    @PostMapping("/m4sll_negocios")
    public ResponseEntity<List<M4sllNegocios>> createM4sllNegocios(@RequestBody List<M4sllNegocios> listM4sllNegocios)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_negocios : {}", listM4sllNegocios);
        List<M4sllNegocios>result =  m4sllNegociosServices.saveAllWithSecuencia(listM4sllNegocios);
        return ResponseEntity
               .created(new URI("/api/m4sll_negocios/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_negocios")
    public ResponseEntity<List<M4sllNegocios>> updateM4sllNegocios(@RequestBody List<M4sllNegocios> listM4sllNegocios)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_negocios : {}", listM4sllNegocios);
        List<M4sllNegocios> result = m4sllNegociosRepository.saveAll(listM4sllNegocios);
        return ResponseEntity
               .created(new URI("/api/m4sll_negocios/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_negocios")
        public ResponseEntity<List<M4sllNegocios>> getAllM4sllNegocios() {
          log.debug("REST request to get ALL M4sllNegocios : {}");

          List<M4sllNegocios> M4sllNegociosAll = m4sllNegociosRepository.findAll();
          return ResponseEntity.ok().body(M4sllNegociosAll);
        }
    */

    @GetMapping("/m4sll_negocios")
    public ResponseEntity<List<M4sllNegocios>> getM4sllNegocios() {
        log.debug("REST request to get M4sllNegocios : {}", idOrganization);

        List<M4sllNegocios> M4sllNegociosByInput = m4sllNegociosRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllNegociosByInput);
    }


    @DeleteMapping("/m4sll_negocios/{neg_id_negocio}")
    public ResponseEntity<Void> deleteM4sllNegocios(@PathVariable("neg_id_negocio") String negIdNegocio) {
        log.debug("REST request to delete m4sll_negocios : {}", idOrganization + "|" + negIdNegocio);
        M4sllNegociosId id = new M4sllNegociosId();
        id.setIdOrganization(idOrganization);
        id.setNegIdNegocio(negIdNegocio);

        m4sllNegociosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_negocios")
  public ResponseEntity<M4sllNegocios> createM4sllNegocios(@RequestBody M4sllNegocios m4sllNegocios)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_negocios : {}", m4sllNegocios);
    M4sllNegociosId id = new M4sllNegociosId();
    M4sllNegociosServices m4sllNegociosServices = new M4sllNegociosServices(m4sllNegociosRepository);
    String id_negIdNegocio = m4sllNegociosServices.UltimaSecuencia(m4sllNegocios);

    id.setNegIdNegocio(id_negIdNegocio);
    id.setIdOrganization(idOrganization);

    m4sllNegocios.setId(id);
    M4sllNegocios result = m4sllNegociosRepository.save(m4sllNegocios);
    return ResponseEntity
      .created(new URI("/api/m4sll_negocios/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_negocios/{neg_id_negocio}")
  public ResponseEntity<M4sllNegocios> getM4sllNegocios(@PathVariable("neg_id_negocio") String negIdNegocio) {
      log.debug("REST request to get M4sllNegocios : {}", idOrganization + "|" + negIdNegocio);
      M4sllNegociosId id = new M4sllNegociosId();
      id.setIdOrganization(idOrganization);
      id.setNegIdNegocio(negIdNegocio);

      Optional<M4sllNegocios> m4sllNegocios = m4sllNegociosRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllNegocios);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_negocios")
  public ResponseEntity<Void> deleteM4sllNegocios() {
    log.debug("REST request to delete m4sll_negocios : {}", idOrganization);
    List<M4sllNegocios> M4sllNegociosByInput = m4sllNegociosRepository.findByIdOrganization(idOrganization);

    m4sllNegociosRepository.deleteAll(M4sllNegociosByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllNegociosByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_negocios")
public ResponseEntity<M4sllNegocios> updateM4sllNegocios(@RequestBody M4sllNegocios m4sllNegocios)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_negocios : {}", m4sllNegocios);
  if (m4sllNegocios.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllNegocios result = m4sllNegociosRepository.save(m4sllNegocios);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllNegocios.getId().toString()))
    .body(result);
}


*/
