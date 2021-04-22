package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpValEco;
import com.prosegur.sllpe.domain.M4sllTpValEcoId;
import com.prosegur.sllpe.repository.M4sllTpValEcoRepository;
import com.prosegur.sllpe.service.M4sllTpValEcoServices;
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
public class M4sllTpValEcoResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpValEcoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpValEco";

    @Autowired
    M4sllTpValEcoServices m4sllTpValEcoServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpValEcoRepository m4sllTpValEcoRepository;

    public M4sllTpValEcoResource(M4sllTpValEcoRepository m4sllTpValEcoRepository) {
        this.m4sllTpValEcoRepository = m4sllTpValEcoRepository;
    }

    @PostMapping("/m4sll_tp_val_eco")
    public ResponseEntity<List<M4sllTpValEco>> createM4sllTpValEco(@RequestBody List<M4sllTpValEco> listM4sllTpValEco)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_val_eco : {}", listM4sllTpValEco);
        List<M4sllTpValEco>result =  m4sllTpValEcoServices.saveAllWithSecuencia(listM4sllTpValEco);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_val_eco/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_val_eco")
    public ResponseEntity<List<M4sllTpValEco>> updateM4sllTpValEco(@RequestBody List<M4sllTpValEco> listM4sllTpValEco)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_val_eco : {}", listM4sllTpValEco);
        List<M4sllTpValEco> result = m4sllTpValEcoRepository.saveAll(listM4sllTpValEco);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_val_eco/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_val_eco")
        public ResponseEntity<List<M4sllTpValEco>> getAllM4sllTpValEco() {
          log.debug("REST request to get ALL M4sllTpValEco : {}");

          List<M4sllTpValEco> M4sllTpValEcoAll = m4sllTpValEcoRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpValEcoAll);
        }
    */

    @GetMapping("/m4sll_tp_val_eco")
    public ResponseEntity<List<M4sllTpValEco>> getM4sllTpValEco() {
        log.debug("REST request to get M4sllTpValEco : {}", idOrganization);

        List<M4sllTpValEco> M4sllTpValEcoByInput = m4sllTpValEcoRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpValEcoByInput);
    }


    @DeleteMapping("/m4sll_tp_val_eco/{tve_id_val_eco}")
    public ResponseEntity<Void> deleteM4sllTpValEco(@PathVariable("tve_id_val_eco") String tveIdValEco) {
        log.debug("REST request to delete m4sll_tp_val_eco : {}", idOrganization + "|" + tveIdValEco);
        M4sllTpValEcoId id = new M4sllTpValEcoId();
        id.setIdOrganization(idOrganization);
        id.setTveIdValEco(tveIdValEco);

        m4sllTpValEcoRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_val_eco")
  public ResponseEntity<M4sllTpValEco> createM4sllTpValEco(@RequestBody M4sllTpValEco m4sllTpValEco)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_val_eco : {}", m4sllTpValEco);
    M4sllTpValEcoId id = new M4sllTpValEcoId();
    M4sllTpValEcoServices m4sllTpValEcoServices = new M4sllTpValEcoServices(m4sllTpValEcoRepository);
    String id_tveIdValEco = m4sllTpValEcoServices.UltimaSecuencia(m4sllTpValEco);

    id.setTveIdValEco(id_tveIdValEco);
    id.setIdOrganization(idOrganization);

    m4sllTpValEco.setId(id);
    M4sllTpValEco result = m4sllTpValEcoRepository.save(m4sllTpValEco);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_val_eco/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_val_eco/{tve_id_val_eco}")
  public ResponseEntity<M4sllTpValEco> getM4sllTpValEco(@PathVariable("tve_id_val_eco") String tveIdValEco) {
      log.debug("REST request to get M4sllTpValEco : {}", idOrganization + "|" + tveIdValEco);
      M4sllTpValEcoId id = new M4sllTpValEcoId();
      id.setIdOrganization(idOrganization);
      id.setTveIdValEco(tveIdValEco);

      Optional<M4sllTpValEco> m4sllTpValEco = m4sllTpValEcoRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpValEco);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_val_eco")
  public ResponseEntity<Void> deleteM4sllTpValEco() {
    log.debug("REST request to delete m4sll_tp_val_eco : {}", idOrganization);
    List<M4sllTpValEco> M4sllTpValEcoByInput = m4sllTpValEcoRepository.findByIdOrganization(idOrganization);

    m4sllTpValEcoRepository.deleteAll(M4sllTpValEcoByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpValEcoByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_val_eco")
public ResponseEntity<M4sllTpValEco> updateM4sllTpValEco(@RequestBody M4sllTpValEco m4sllTpValEco)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_val_eco : {}", m4sllTpValEco);
  if (m4sllTpValEco.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpValEco result = m4sllTpValEcoRepository.save(m4sllTpValEco);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpValEco.getId().toString()))
    .body(result);
}


*/
