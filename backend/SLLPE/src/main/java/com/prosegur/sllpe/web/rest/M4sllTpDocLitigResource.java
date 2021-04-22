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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class M4sllTpDocLitigResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpDocLitigResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpDocLitig";

    @Autowired
    M4sllTpDocLitigServices m4sllTpDocLitigServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpDocLitigRepository m4sllTpDocLitigRepository;

    public M4sllTpDocLitigResource(M4sllTpDocLitigRepository m4sllTpDocLitigRepository) {
        this.m4sllTpDocLitigRepository = m4sllTpDocLitigRepository;
    }

    @PostMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<List<M4sllTpDocLitig>> createM4sllTpDocLitig(@RequestBody List<M4sllTpDocLitig> listM4sllTpDocLitig)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_doc_litig : {}", listM4sllTpDocLitig);
        List<M4sllTpDocLitig>result =  m4sllTpDocLitigServices.saveAllWithSecuencia(listM4sllTpDocLitig);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_doc_litig/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<List<M4sllTpDocLitig>> updateM4sllTpDocLitig(@RequestBody List<M4sllTpDocLitig> listM4sllTpDocLitig)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_doc_litig : {}", listM4sllTpDocLitig);
        List<M4sllTpDocLitig> result = m4sllTpDocLitigRepository.saveAll(listM4sllTpDocLitig);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_doc_litig/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_doc_litig")
        public ResponseEntity<List<M4sllTpDocLitig>> getAllM4sllTpDocLitig() {
          log.debug("REST request to get ALL M4sllTpDocLitig : {}");

          List<M4sllTpDocLitig> M4sllTpDocLitigAll = m4sllTpDocLitigRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpDocLitigAll);
        }
    */

    @GetMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<List<M4sllTpDocLitig>> getM4sllTpDocLitig() {
        log.debug("REST request to get M4sllTpDocLitig : {}", idOrganization);

        List<M4sllTpDocLitig> M4sllTpDocLitigByInput = m4sllTpDocLitigRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpDocLitigByInput);
    }


    @DeleteMapping("/m4sll_tp_doc_litig/{tdl_id_tp_doc_litigio}")
    public ResponseEntity<Void> deleteM4sllTpDocLitig(@PathVariable("tdl_id_tp_doc_litigio") String tdlIdTpDocLitigio) {
        log.debug("REST request to delete m4sll_tp_doc_litig : {}", idOrganization + "|" + tdlIdTpDocLitigio);
        M4sllTpDocLitigId id = new M4sllTpDocLitigId();
        id.setIdOrganization(idOrganization);
        id.setTdlIdTpDocLitigio(tdlIdTpDocLitigio);

        m4sllTpDocLitigRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_doc_litig")
  public ResponseEntity<M4sllTpDocLitig> createM4sllTpDocLitig(@RequestBody M4sllTpDocLitig m4sllTpDocLitig)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_doc_litig : {}", m4sllTpDocLitig);
    M4sllTpDocLitigId id = new M4sllTpDocLitigId();
    M4sllTpDocLitigServices m4sllTpDocLitigServices = new M4sllTpDocLitigServices(m4sllTpDocLitigRepository);
    String id_tdlIdTpDocLitigio = m4sllTpDocLitigServices.UltimaSecuencia(m4sllTpDocLitig);

    id.setTdlIdTpDocLitigio(id_tdlIdTpDocLitigio);
    id.setIdOrganization(idOrganization);

    m4sllTpDocLitig.setId(id);
    M4sllTpDocLitig result = m4sllTpDocLitigRepository.save(m4sllTpDocLitig);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_doc_litig/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_doc_litig/{tdl_id_tp_doc_litigio}")
  public ResponseEntity<M4sllTpDocLitig> getM4sllTpDocLitig(@PathVariable("tdl_id_tp_doc_litigio") String tdlIdTpDocLitigio) {
      log.debug("REST request to get M4sllTpDocLitig : {}", idOrganization + "|" + tdlIdTpDocLitigio);
      M4sllTpDocLitigId id = new M4sllTpDocLitigId();
      id.setIdOrganization(idOrganization);
      id.setTdlIdTpDocLitigio(tdlIdTpDocLitigio);

      Optional<M4sllTpDocLitig> m4sllTpDocLitig = m4sllTpDocLitigRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpDocLitig);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_doc_litig")
  public ResponseEntity<Void> deleteM4sllTpDocLitig() {
    log.debug("REST request to delete m4sll_tp_doc_litig : {}", idOrganization);
    List<M4sllTpDocLitig> M4sllTpDocLitigByInput = m4sllTpDocLitigRepository.findByIdOrganization(idOrganization);

    m4sllTpDocLitigRepository.deleteAll(M4sllTpDocLitigByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpDocLitigByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_doc_litig")
public ResponseEntity<M4sllTpDocLitig> updateM4sllTpDocLitig(@RequestBody M4sllTpDocLitig m4sllTpDocLitig)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_doc_litig : {}", m4sllTpDocLitig);
  if (m4sllTpDocLitig.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpDocLitig result = m4sllTpDocLitigRepository.save(m4sllTpDocLitig);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpDocLitig.getId().toString()))
    .body(result);
}


*/
