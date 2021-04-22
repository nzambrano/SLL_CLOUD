package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.domain.M4sllTpFasesId;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;
import com.prosegur.sllpe.service.M4sllTpFasesServices;
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
public class M4sllTpFasesResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpFasesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpFases";

    @Autowired
    M4sllTpFasesServices m4sllTpFasesServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpFasesRepository m4sllTpFasesRepository;

    public M4sllTpFasesResource(M4sllTpFasesRepository m4sllTpFasesRepository) {
        this.m4sllTpFasesRepository = m4sllTpFasesRepository;
    }

    @PostMapping("/m4sll_tp_fases")
    public ResponseEntity<List<M4sllTpFases>> createM4sllTpFases(@RequestBody List<M4sllTpFases> listM4sllTpFases)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_fases : {}", listM4sllTpFases);
        List<M4sllTpFases>result =  m4sllTpFasesServices.saveAllWithSecuencia(listM4sllTpFases);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_fases/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_fases")
    public ResponseEntity<List<M4sllTpFases>> updateM4sllTpFases(@RequestBody List<M4sllTpFases> listM4sllTpFases)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_fases : {}", listM4sllTpFases);
        List<M4sllTpFases> result = m4sllTpFasesRepository.saveAll(listM4sllTpFases);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_fases/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_fases")
        public ResponseEntity<List<M4sllTpFases>> getAllM4sllTpFases() {
          log.debug("REST request to get ALL M4sllTpFases : {}");

          List<M4sllTpFases> M4sllTpFasesAll = m4sllTpFasesRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpFasesAll);
        }
    */

    @GetMapping("/m4sll_tp_fases")
    public ResponseEntity<List<M4sllTpFases>> getM4sllTpFases() {
        log.debug("REST request to get M4sllTpFases : {}", idOrganization);

        List<M4sllTpFases> M4sllTpFasesByInput = m4sllTpFasesRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpFasesByInput);
    }


    @DeleteMapping("/m4sll_tp_fases/{tfa_id_tp_fase}")
    public ResponseEntity<Void> deleteM4sllTpFases(@PathVariable("tfa_id_tp_fase") String tfaIdTpFase) {
        log.debug("REST request to delete m4sll_tp_fases : {}", idOrganization + "|" + tfaIdTpFase);
        M4sllTpFasesId id = new M4sllTpFasesId();
        id.setIdOrganization(idOrganization);
        id.setTfaIdTpFase(tfaIdTpFase);

        m4sllTpFasesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_fases")
  public ResponseEntity<M4sllTpFases> createM4sllTpFases(@RequestBody M4sllTpFases m4sllTpFases)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_fases : {}", m4sllTpFases);
    M4sllTpFasesId id = new M4sllTpFasesId();
    M4sllTpFasesServices m4sllTpFasesServices = new M4sllTpFasesServices(m4sllTpFasesRepository);
    String id_tfaIdTpFase = m4sllTpFasesServices.UltimaSecuencia(m4sllTpFases);

    id.setTfaIdTpFase(id_tfaIdTpFase);
    id.setIdOrganization(idOrganization);

    m4sllTpFases.setId(id);
    M4sllTpFases result = m4sllTpFasesRepository.save(m4sllTpFases);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_fases/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_fases/{tfa_id_tp_fase}")
  public ResponseEntity<M4sllTpFases> getM4sllTpFases(@PathVariable("tfa_id_tp_fase") String tfaIdTpFase) {
      log.debug("REST request to get M4sllTpFases : {}", idOrganization + "|" + tfaIdTpFase);
      M4sllTpFasesId id = new M4sllTpFasesId();
      id.setIdOrganization(idOrganization);
      id.setTfaIdTpFase(tfaIdTpFase);

      Optional<M4sllTpFases> m4sllTpFases = m4sllTpFasesRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpFases);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_fases")
  public ResponseEntity<Void> deleteM4sllTpFases() {
    log.debug("REST request to delete m4sll_tp_fases : {}", idOrganization);
    List<M4sllTpFases> M4sllTpFasesByInput = m4sllTpFasesRepository.findByIdOrganization(idOrganization);

    m4sllTpFasesRepository.deleteAll(M4sllTpFasesByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpFasesByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_fases")
public ResponseEntity<M4sllTpFases> updateM4sllTpFases(@RequestBody M4sllTpFases m4sllTpFases)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_fases : {}", m4sllTpFases);
  if (m4sllTpFases.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpFases result = m4sllTpFasesRepository.save(m4sllTpFases);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpFases.getId().toString()))
    .body(result);
}


*/
