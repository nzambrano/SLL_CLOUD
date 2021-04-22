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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class M4sllTpStatusResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpStatusResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpStatus";

    @Autowired
    M4sllTpStatusServices m4sllTpStatusServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpStatusRepository m4sllTpStatusRepository;

    public M4sllTpStatusResource(M4sllTpStatusRepository m4sllTpStatusRepository) {
        this.m4sllTpStatusRepository = m4sllTpStatusRepository;
    }

    @PostMapping("/m4sll_tp_status")
    public ResponseEntity<List<M4sllTpStatus>> createM4sllTpStatus(@RequestBody List<M4sllTpStatus> listM4sllTpStatus)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_status : {}", listM4sllTpStatus);
        List<M4sllTpStatus>result =  m4sllTpStatusServices.saveAllWithSecuencia(listM4sllTpStatus);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_status/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_status")
    public ResponseEntity<List<M4sllTpStatus>> updateM4sllTpStatus(@RequestBody List<M4sllTpStatus> listM4sllTpStatus)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_status : {}", listM4sllTpStatus);
        List<M4sllTpStatus> result = m4sllTpStatusRepository.saveAll(listM4sllTpStatus);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_status/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_status")
        public ResponseEntity<List<M4sllTpStatus>> getAllM4sllTpStatus() {
          log.debug("REST request to get ALL M4sllTpStatus : {}");

          List<M4sllTpStatus> M4sllTpStatusAll = m4sllTpStatusRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpStatusAll);
        }
    */

    @GetMapping("/m4sll_tp_status")
    public ResponseEntity<List<M4sllTpStatus>> getM4sllTpStatus() {
        log.debug("REST request to get M4sllTpStatus : {}", idOrganization);

        List<M4sllTpStatus> M4sllTpStatusByInput = m4sllTpStatusRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpStatusByInput);
    }


    @DeleteMapping("/m4sll_tp_status/{tst_id_tp_status}")
    public ResponseEntity<Void> deleteM4sllTpStatus(@PathVariable("tst_id_tp_status") String tstIdTpStatus) {
        log.debug("REST request to delete m4sll_tp_status : {}", idOrganization + "|" + tstIdTpStatus);
        M4sllTpStatusId id = new M4sllTpStatusId();
        id.setIdOrganization(idOrganization);
        id.setTstIdTpStatus(tstIdTpStatus);

        m4sllTpStatusRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_status")
  public ResponseEntity<M4sllTpStatus> createM4sllTpStatus(@RequestBody M4sllTpStatus m4sllTpStatus)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_status : {}", m4sllTpStatus);
    M4sllTpStatusId id = new M4sllTpStatusId();
    M4sllTpStatusServices m4sllTpStatusServices = new M4sllTpStatusServices(m4sllTpStatusRepository);
    String id_tstIdTpStatus = m4sllTpStatusServices.UltimaSecuencia(m4sllTpStatus);

    id.setTstIdTpStatus(id_tstIdTpStatus);
    id.setIdOrganization(idOrganization);

    m4sllTpStatus.setId(id);
    M4sllTpStatus result = m4sllTpStatusRepository.save(m4sllTpStatus);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_status/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_status/{tst_id_tp_status}")
  public ResponseEntity<M4sllTpStatus> getM4sllTpStatus(@PathVariable("tst_id_tp_status") String tstIdTpStatus) {
      log.debug("REST request to get M4sllTpStatus : {}", idOrganization + "|" + tstIdTpStatus);
      M4sllTpStatusId id = new M4sllTpStatusId();
      id.setIdOrganization(idOrganization);
      id.setTstIdTpStatus(tstIdTpStatus);

      Optional<M4sllTpStatus> m4sllTpStatus = m4sllTpStatusRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpStatus);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_status")
  public ResponseEntity<Void> deleteM4sllTpStatus() {
    log.debug("REST request to delete m4sll_tp_status : {}", idOrganization);
    List<M4sllTpStatus> M4sllTpStatusByInput = m4sllTpStatusRepository.findByIdOrganization(idOrganization);

    m4sllTpStatusRepository.deleteAll(M4sllTpStatusByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpStatusByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_status")
public ResponseEntity<M4sllTpStatus> updateM4sllTpStatus(@RequestBody M4sllTpStatus m4sllTpStatus)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_status : {}", m4sllTpStatus);
  if (m4sllTpStatus.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpStatus result = m4sllTpStatusRepository.save(m4sllTpStatus);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpStatus.getId().toString()))
    .body(result);
}


*/
