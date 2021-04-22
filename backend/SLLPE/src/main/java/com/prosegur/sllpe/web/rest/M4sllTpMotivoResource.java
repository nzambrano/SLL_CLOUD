package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpMotivo;
import com.prosegur.sllpe.domain.M4sllTpMotivoId;
import com.prosegur.sllpe.repository.M4sllTpMotivoRepository;
import com.prosegur.sllpe.service.M4sllTpMotivoServices;
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
public class M4sllTpMotivoResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpMotivoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpMotivo";

    @Autowired
    M4sllTpMotivoServices m4sllTpMotivoServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpMotivoRepository m4sllTpMotivoRepository;

    public M4sllTpMotivoResource(M4sllTpMotivoRepository m4sllTpMotivoRepository) {
        this.m4sllTpMotivoRepository = m4sllTpMotivoRepository;
    }

    @PostMapping("/m4sll_tp_motivo")
    public ResponseEntity<List<M4sllTpMotivo>> createM4sllTpMotivo(@RequestBody List<M4sllTpMotivo> listM4sllTpMotivo)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_motivo : {}", listM4sllTpMotivo);
        List<M4sllTpMotivo>result =  m4sllTpMotivoServices.saveAllWithSecuencia(listM4sllTpMotivo);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_motivo/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_motivo")
    public ResponseEntity<List<M4sllTpMotivo>> updateM4sllTpMotivo(@RequestBody List<M4sllTpMotivo> listM4sllTpMotivo)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_motivo : {}", listM4sllTpMotivo);
        List<M4sllTpMotivo> result = m4sllTpMotivoRepository.saveAll(listM4sllTpMotivo);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_motivo/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_motivo")
        public ResponseEntity<List<M4sllTpMotivo>> getAllM4sllTpMotivo() {
          log.debug("REST request to get ALL M4sllTpMotivo : {}");

          List<M4sllTpMotivo> M4sllTpMotivoAll = m4sllTpMotivoRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpMotivoAll);
        }
    */

    @GetMapping("/m4sll_tp_motivo")
    public ResponseEntity<List<M4sllTpMotivo>> getM4sllTpMotivo() {
        log.debug("REST request to get M4sllTpMotivo : {}", idOrganization);

        List<M4sllTpMotivo> M4sllTpMotivoByInput = m4sllTpMotivoRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpMotivoByInput);
    }


    @DeleteMapping("/m4sll_tp_motivo/{tmo_id_tp_motivo}")
    public ResponseEntity<Void> deleteM4sllTpMotivo(@PathVariable("tmo_id_tp_motivo") String tmoIdTpMotivo) {
        log.debug("REST request to delete m4sll_tp_motivo : {}", idOrganization + "|" + tmoIdTpMotivo);
        M4sllTpMotivoId id = new M4sllTpMotivoId();
        id.setIdOrganization(idOrganization);
        id.setTmoIdTpMotivo(tmoIdTpMotivo);

        m4sllTpMotivoRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_motivo")
  public ResponseEntity<M4sllTpMotivo> createM4sllTpMotivo(@RequestBody M4sllTpMotivo m4sllTpMotivo)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_motivo : {}", m4sllTpMotivo);
    M4sllTpMotivoId id = new M4sllTpMotivoId();
    M4sllTpMotivoServices m4sllTpMotivoServices = new M4sllTpMotivoServices(m4sllTpMotivoRepository);
    String id_tmoIdTpMotivo = m4sllTpMotivoServices.UltimaSecuencia(m4sllTpMotivo);

    id.setTmoIdTpMotivo(id_tmoIdTpMotivo);
    id.setIdOrganization(idOrganization);

    m4sllTpMotivo.setId(id);
    M4sllTpMotivo result = m4sllTpMotivoRepository.save(m4sllTpMotivo);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_motivo/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_motivo/{tmo_id_tp_motivo}")
  public ResponseEntity<M4sllTpMotivo> getM4sllTpMotivo(@PathVariable("tmo_id_tp_motivo") String tmoIdTpMotivo) {
      log.debug("REST request to get M4sllTpMotivo : {}", idOrganization + "|" + tmoIdTpMotivo);
      M4sllTpMotivoId id = new M4sllTpMotivoId();
      id.setIdOrganization(idOrganization);
      id.setTmoIdTpMotivo(tmoIdTpMotivo);

      Optional<M4sllTpMotivo> m4sllTpMotivo = m4sllTpMotivoRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpMotivo);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_motivo")
  public ResponseEntity<Void> deleteM4sllTpMotivo() {
    log.debug("REST request to delete m4sll_tp_motivo : {}", idOrganization);
    List<M4sllTpMotivo> M4sllTpMotivoByInput = m4sllTpMotivoRepository.findByIdOrganization(idOrganization);

    m4sllTpMotivoRepository.deleteAll(M4sllTpMotivoByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpMotivoByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_motivo")
public ResponseEntity<M4sllTpMotivo> updateM4sllTpMotivo(@RequestBody M4sllTpMotivo m4sllTpMotivo)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_motivo : {}", m4sllTpMotivo);
  if (m4sllTpMotivo.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpMotivo result = m4sllTpMotivoRepository.save(m4sllTpMotivo);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpMotivo.getId().toString()))
    .body(result);
}


*/
