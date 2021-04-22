package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpCompromis;
import com.prosegur.sllpe.domain.M4sllTpCompromisId;
import com.prosegur.sllpe.repository.M4sllTpCompromisRepository;
import com.prosegur.sllpe.service.M4sllTpCompromisServices;
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
public class M4sllTpCompromisResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpCompromisResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpCompromis";

    @Autowired
    M4sllTpCompromisServices m4sllTpCompromisServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpCompromisRepository m4sllTpCompromisRepository;

    public M4sllTpCompromisResource(M4sllTpCompromisRepository m4sllTpCompromisRepository) {
        this.m4sllTpCompromisRepository = m4sllTpCompromisRepository;
    }

    @PostMapping("/m4sll_tp_compromis")
    public ResponseEntity<List<M4sllTpCompromis>> createM4sllTpCompromis(@RequestBody List<M4sllTpCompromis> listM4sllTpCompromis)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_compromis : {}", listM4sllTpCompromis);
        List<M4sllTpCompromis>result =  m4sllTpCompromisServices.saveAllWithSecuencia(listM4sllTpCompromis);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_compromis/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_compromis")
    public ResponseEntity<List<M4sllTpCompromis>> updateM4sllTpCompromis(@RequestBody List<M4sllTpCompromis> listM4sllTpCompromis)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_compromis : {}", listM4sllTpCompromis);
        List<M4sllTpCompromis> result = m4sllTpCompromisRepository.saveAll(listM4sllTpCompromis);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_compromis/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_compromis")
        public ResponseEntity<List<M4sllTpCompromis>> getAllM4sllTpCompromis() {
          log.debug("REST request to get ALL M4sllTpCompromis : {}");

          List<M4sllTpCompromis> M4sllTpCompromisAll = m4sllTpCompromisRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpCompromisAll);
        }
    */

    @GetMapping("/m4sll_tp_compromis")
    public ResponseEntity<List<M4sllTpCompromis>> getM4sllTpCompromis() {
        log.debug("REST request to get M4sllTpCompromis : {}", idOrganization);

        List<M4sllTpCompromis> M4sllTpCompromisByInput = m4sllTpCompromisRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpCompromisByInput);
    }


    @DeleteMapping("/m4sll_tp_compromis/{tco_id_tp_compromiso}")
    public ResponseEntity<Void> deleteM4sllTpCompromis(@PathVariable("tco_id_tp_compromiso") String tcoIdTpCompromiso) {
        log.debug("REST request to delete m4sll_tp_compromis : {}", idOrganization + "|" + tcoIdTpCompromiso);
        M4sllTpCompromisId id = new M4sllTpCompromisId();
        id.setIdOrganization(idOrganization);
        id.setTcoIdTpCompromiso(tcoIdTpCompromiso);

        m4sllTpCompromisRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_compromis")
  public ResponseEntity<M4sllTpCompromis> createM4sllTpCompromis(@RequestBody M4sllTpCompromis m4sllTpCompromis)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_compromis : {}", m4sllTpCompromis);
    M4sllTpCompromisId id = new M4sllTpCompromisId();
    M4sllTpCompromisServices m4sllTpCompromisServices = new M4sllTpCompromisServices(m4sllTpCompromisRepository);
    String id_tcoIdTpCompromiso = m4sllTpCompromisServices.UltimaSecuencia(m4sllTpCompromis);

    id.setTcoIdTpCompromiso(id_tcoIdTpCompromiso);
    id.setIdOrganization(idOrganization);

    m4sllTpCompromis.setId(id);
    M4sllTpCompromis result = m4sllTpCompromisRepository.save(m4sllTpCompromis);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_compromis/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_compromis/{tco_id_tp_compromiso}")
  public ResponseEntity<M4sllTpCompromis> getM4sllTpCompromis(@PathVariable("tco_id_tp_compromiso") String tcoIdTpCompromiso) {
      log.debug("REST request to get M4sllTpCompromis : {}", idOrganization + "|" + tcoIdTpCompromiso);
      M4sllTpCompromisId id = new M4sllTpCompromisId();
      id.setIdOrganization(idOrganization);
      id.setTcoIdTpCompromiso(tcoIdTpCompromiso);

      Optional<M4sllTpCompromis> m4sllTpCompromis = m4sllTpCompromisRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpCompromis);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_compromis")
  public ResponseEntity<Void> deleteM4sllTpCompromis() {
    log.debug("REST request to delete m4sll_tp_compromis : {}", idOrganization);
    List<M4sllTpCompromis> M4sllTpCompromisByInput = m4sllTpCompromisRepository.findByIdOrganization(idOrganization);

    m4sllTpCompromisRepository.deleteAll(M4sllTpCompromisByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpCompromisByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_compromis")
public ResponseEntity<M4sllTpCompromis> updateM4sllTpCompromis(@RequestBody M4sllTpCompromis m4sllTpCompromis)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_compromis : {}", m4sllTpCompromis);
  if (m4sllTpCompromis.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpCompromis result = m4sllTpCompromisRepository.save(m4sllTpCompromis);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpCompromis.getId().toString()))
    .body(result);
}


*/
