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
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    M4sllTpIdentificServices m4sllTpIdentificServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpIdentificRepository m4sllTpIdentificRepository;

    public M4sllTpIdentificResource(M4sllTpIdentificRepository m4sllTpIdentificRepository) {
        this.m4sllTpIdentificRepository = m4sllTpIdentificRepository;
    }

    @PostMapping("/m4sll_tp_identific")
    public ResponseEntity<List<M4sllTpIdentific>> createM4sllTpIdentific(@RequestBody List<M4sllTpIdentific> listM4sllTpIdentific)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_identific : {}", listM4sllTpIdentific);
        List<M4sllTpIdentific>result =  m4sllTpIdentificServices.saveAllWithSecuencia(listM4sllTpIdentific);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_identific/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_identific")
    public ResponseEntity<List<M4sllTpIdentific>> updateM4sllTpIdentific(@RequestBody List<M4sllTpIdentific> listM4sllTpIdentific)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_identific : {}", listM4sllTpIdentific);
        List<M4sllTpIdentific> result = m4sllTpIdentificRepository.saveAll(listM4sllTpIdentific);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_identific/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_identific")
        public ResponseEntity<List<M4sllTpIdentific>> getAllM4sllTpIdentific() {
          log.debug("REST request to get ALL M4sllTpIdentific : {}");

          List<M4sllTpIdentific> M4sllTpIdentificAll = m4sllTpIdentificRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpIdentificAll);
        }
    */

    @GetMapping("/m4sll_tp_identific")
    public ResponseEntity<List<M4sllTpIdentific>> getM4sllTpIdentific() {
        log.debug("REST request to get M4sllTpIdentific : {}", idOrganization);

        List<M4sllTpIdentific> M4sllTpIdentificByInput = m4sllTpIdentificRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpIdentificByInput);
    }


    @DeleteMapping("/m4sll_tp_identific/{tpi_id_tp_identificacion}")
    public ResponseEntity<Void> deleteM4sllTpIdentific(@PathVariable("tpi_id_tp_identificacion") String tpiIdTpIdentificacion) {
        log.debug("REST request to delete m4sll_tp_identific : {}", idOrganization + "|" + tpiIdTpIdentificacion);
        M4sllTpIdentificId id = new M4sllTpIdentificId();
        id.setIdOrganization(idOrganization);
        id.setTpiIdTpIdentificacion(tpiIdTpIdentificacion);

        m4sllTpIdentificRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_identific")
  public ResponseEntity<M4sllTpIdentific> createM4sllTpIdentific(@RequestBody M4sllTpIdentific m4sllTpIdentific)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_identific : {}", m4sllTpIdentific);
    M4sllTpIdentificId id = new M4sllTpIdentificId();
    M4sllTpIdentificServices m4sllTpIdentificServices = new M4sllTpIdentificServices(m4sllTpIdentificRepository);
    String id_tpiIdTpIdentificacion = m4sllTpIdentificServices.UltimaSecuencia(m4sllTpIdentific);

    id.setTpiIdTpIdentificacion(id_tpiIdTpIdentificacion);
    id.setIdOrganization(idOrganization);

    m4sllTpIdentific.setId(id);
    M4sllTpIdentific result = m4sllTpIdentificRepository.save(m4sllTpIdentific);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_identific/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_identific/{tpi_id_tp_identificacion}")
  public ResponseEntity<M4sllTpIdentific> getM4sllTpIdentific(@PathVariable("tpi_id_tp_identificacion") String tpiIdTpIdentificacion) {
      log.debug("REST request to get M4sllTpIdentific : {}", idOrganization + "|" + tpiIdTpIdentificacion);
      M4sllTpIdentificId id = new M4sllTpIdentificId();
      id.setIdOrganization(idOrganization);
      id.setTpiIdTpIdentificacion(tpiIdTpIdentificacion);

      Optional<M4sllTpIdentific> m4sllTpIdentific = m4sllTpIdentificRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpIdentific);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_identific")
  public ResponseEntity<Void> deleteM4sllTpIdentific() {
    log.debug("REST request to delete m4sll_tp_identific : {}", idOrganization);
    List<M4sllTpIdentific> M4sllTpIdentificByInput = m4sllTpIdentificRepository.findByIdOrganization(idOrganization);

    m4sllTpIdentificRepository.deleteAll(M4sllTpIdentificByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpIdentificByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_identific")
public ResponseEntity<M4sllTpIdentific> updateM4sllTpIdentific(@RequestBody M4sllTpIdentific m4sllTpIdentific)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_identific : {}", m4sllTpIdentific);
  if (m4sllTpIdentific.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpIdentific result = m4sllTpIdentificRepository.save(m4sllTpIdentific);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpIdentific.getId().toString()))
    .body(result);
}


*/
