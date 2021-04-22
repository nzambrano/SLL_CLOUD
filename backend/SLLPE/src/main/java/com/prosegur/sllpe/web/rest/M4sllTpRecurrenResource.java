package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpRecurren;
import com.prosegur.sllpe.domain.M4sllTpRecurrenId;
import com.prosegur.sllpe.repository.M4sllTpRecurrenRepository;
import com.prosegur.sllpe.service.M4sllTpRecurrenServices;
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
public class M4sllTpRecurrenResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpRecurrenResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpRecurren";

    @Autowired
    M4sllTpRecurrenServices m4sllTpRecurrenServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpRecurrenRepository m4sllTpRecurrenRepository;

    public M4sllTpRecurrenResource(M4sllTpRecurrenRepository m4sllTpRecurrenRepository) {
        this.m4sllTpRecurrenRepository = m4sllTpRecurrenRepository;
    }

    @PostMapping("/m4sll_tp_recurren")
    public ResponseEntity<List<M4sllTpRecurren>> createM4sllTpRecurren(@RequestBody List<M4sllTpRecurren> listM4sllTpRecurren)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_recurren : {}", listM4sllTpRecurren);
        List<M4sllTpRecurren>result =  m4sllTpRecurrenServices.saveAllWithSecuencia(listM4sllTpRecurren);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_recurren/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_recurren")
    public ResponseEntity<List<M4sllTpRecurren>> updateM4sllTpRecurren(@RequestBody List<M4sllTpRecurren> listM4sllTpRecurren)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_recurren : {}", listM4sllTpRecurren);
        List<M4sllTpRecurren> result = m4sllTpRecurrenRepository.saveAll(listM4sllTpRecurren);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_recurren/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_recurren")
        public ResponseEntity<List<M4sllTpRecurren>> getAllM4sllTpRecurren() {
          log.debug("REST request to get ALL M4sllTpRecurren : {}");

          List<M4sllTpRecurren> M4sllTpRecurrenAll = m4sllTpRecurrenRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpRecurrenAll);
        }
    */

    @GetMapping("/m4sll_tp_recurren")
    public ResponseEntity<List<M4sllTpRecurren>> getM4sllTpRecurren() {
        log.debug("REST request to get M4sllTpRecurren : {}", idOrganization);

        List<M4sllTpRecurren> M4sllTpRecurrenByInput = m4sllTpRecurrenRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpRecurrenByInput);
    }


    @DeleteMapping("/m4sll_tp_recurren/{tre_id_recurrencia}")
    public ResponseEntity<Void> deleteM4sllTpRecurren(@PathVariable("tre_id_recurrencia") String treIdRecurrencia) {
        log.debug("REST request to delete m4sll_tp_recurren : {}", idOrganization + "|" + treIdRecurrencia);
        M4sllTpRecurrenId id = new M4sllTpRecurrenId();
        id.setIdOrganization(idOrganization);
        id.setTreIdRecurrencia(treIdRecurrencia);

        m4sllTpRecurrenRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_recurren")
  public ResponseEntity<M4sllTpRecurren> createM4sllTpRecurren(@RequestBody M4sllTpRecurren m4sllTpRecurren)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_recurren : {}", m4sllTpRecurren);
    M4sllTpRecurrenId id = new M4sllTpRecurrenId();
    M4sllTpRecurrenServices m4sllTpRecurrenServices = new M4sllTpRecurrenServices(m4sllTpRecurrenRepository);
    String id_treIdRecurrencia = m4sllTpRecurrenServices.UltimaSecuencia(m4sllTpRecurren);

    id.setTreIdRecurrencia(id_treIdRecurrencia);
    id.setIdOrganization(idOrganization);

    m4sllTpRecurren.setId(id);
    M4sllTpRecurren result = m4sllTpRecurrenRepository.save(m4sllTpRecurren);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_recurren/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_recurren/{tre_id_recurrencia}")
  public ResponseEntity<M4sllTpRecurren> getM4sllTpRecurren(@PathVariable("tre_id_recurrencia") String treIdRecurrencia) {
      log.debug("REST request to get M4sllTpRecurren : {}", idOrganization + "|" + treIdRecurrencia);
      M4sllTpRecurrenId id = new M4sllTpRecurrenId();
      id.setIdOrganization(idOrganization);
      id.setTreIdRecurrencia(treIdRecurrencia);

      Optional<M4sllTpRecurren> m4sllTpRecurren = m4sllTpRecurrenRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpRecurren);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_recurren")
  public ResponseEntity<Void> deleteM4sllTpRecurren() {
    log.debug("REST request to delete m4sll_tp_recurren : {}", idOrganization);
    List<M4sllTpRecurren> M4sllTpRecurrenByInput = m4sllTpRecurrenRepository.findByIdOrganization(idOrganization);

    m4sllTpRecurrenRepository.deleteAll(M4sllTpRecurrenByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpRecurrenByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_recurren")
public ResponseEntity<M4sllTpRecurren> updateM4sllTpRecurren(@RequestBody M4sllTpRecurren m4sllTpRecurren)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_recurren : {}", m4sllTpRecurren);
  if (m4sllTpRecurren.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpRecurren result = m4sllTpRecurrenRepository.save(m4sllTpRecurren);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpRecurren.getId().toString()))
    .body(result);
}


*/
