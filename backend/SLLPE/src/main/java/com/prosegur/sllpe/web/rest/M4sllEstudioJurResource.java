package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.domain.M4sllEstudioJurId;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;
import com.prosegur.sllpe.service.M4sllEstudioJurServices;
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
public class M4sllEstudioJurResource {
    private final Logger log = LoggerFactory.getLogger(M4sllEstudioJurResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllEstudioJur";

    @Autowired
    M4sllEstudioJurServices m4sllEstudioJurServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllEstudioJurRepository m4sllEstudioJurRepository;

    public M4sllEstudioJurResource(M4sllEstudioJurRepository m4sllEstudioJurRepository) {
        this.m4sllEstudioJurRepository = m4sllEstudioJurRepository;
    }

    @PostMapping("/m4sll_estudio_jur")
    public ResponseEntity<List<M4sllEstudioJur>> createM4sllEstudioJur(@RequestBody List<M4sllEstudioJur> listM4sllEstudioJur)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_estudio_jur : {}", listM4sllEstudioJur);
        List<M4sllEstudioJur>result =  m4sllEstudioJurServices.saveAllWithSecuencia(listM4sllEstudioJur);
        return ResponseEntity
               .created(new URI("/api/m4sll_estudio_jur/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_estudio_jur")
    public ResponseEntity<List<M4sllEstudioJur>> updateM4sllEstudioJur(@RequestBody List<M4sllEstudioJur> listM4sllEstudioJur)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_estudio_jur : {}", listM4sllEstudioJur);
        List<M4sllEstudioJur> result = m4sllEstudioJurRepository.saveAll(listM4sllEstudioJur);
        return ResponseEntity
               .created(new URI("/api/m4sll_estudio_jur/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_estudio_jur")
        public ResponseEntity<List<M4sllEstudioJur>> getAllM4sllEstudioJur() {
          log.debug("REST request to get ALL M4sllEstudioJur : {}");

          List<M4sllEstudioJur> M4sllEstudioJurAll = m4sllEstudioJurRepository.findAll();
          return ResponseEntity.ok().body(M4sllEstudioJurAll);
        }
    */

    @GetMapping("/m4sll_estudio_jur")
    public ResponseEntity<List<M4sllEstudioJur>> getM4sllEstudioJur() {
        log.debug("REST request to get M4sllEstudioJur : {}", idOrganization);

        List<M4sllEstudioJur> M4sllEstudioJurByInput = m4sllEstudioJurRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllEstudioJurByInput);
    }


    @DeleteMapping("/m4sll_estudio_jur/{eju_id_est_juridico}")
    public ResponseEntity<Void> deleteM4sllEstudioJur(@PathVariable("eju_id_est_juridico") Long ejuIdEstJuridico) {
        log.debug("REST request to delete m4sll_estudio_jur : {}", idOrganization + "|" + ejuIdEstJuridico);
        M4sllEstudioJurId id = new M4sllEstudioJurId();
        id.setIdOrganization(idOrganization);
        id.setEjuIdEstJuridico(ejuIdEstJuridico);

        m4sllEstudioJurRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_estudio_jur")
  public ResponseEntity<M4sllEstudioJur> createM4sllEstudioJur(@RequestBody M4sllEstudioJur m4sllEstudioJur)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_estudio_jur : {}", m4sllEstudioJur);
    M4sllEstudioJurId id = new M4sllEstudioJurId();
    M4sllEstudioJurServices m4sllEstudioJurServices = new M4sllEstudioJurServices(m4sllEstudioJurRepository);
    Long id_ejuIdEstJuridico = m4sllEstudioJurServices.UltimaSecuencia(m4sllEstudioJur);

    id.setEjuIdEstJuridico(id_ejuIdEstJuridico);
    id.setIdOrganization(idOrganization);

    m4sllEstudioJur.setId(id);
    M4sllEstudioJur result = m4sllEstudioJurRepository.save(m4sllEstudioJur);
    return ResponseEntity
      .created(new URI("/api/m4sll_estudio_jur/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_estudio_jur/{eju_id_est_juridico}")
  public ResponseEntity<M4sllEstudioJur> getM4sllEstudioJur(@PathVariable("eju_id_est_juridico") Long ejuIdEstJuridico) {
      log.debug("REST request to get M4sllEstudioJur : {}", idOrganization + "|" + ejuIdEstJuridico);
      M4sllEstudioJurId id = new M4sllEstudioJurId();
      id.setIdOrganization(idOrganization);
      id.setEjuIdEstJuridico(ejuIdEstJuridico);

      Optional<M4sllEstudioJur> m4sllEstudioJur = m4sllEstudioJurRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllEstudioJur);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_estudio_jur")
  public ResponseEntity<Void> deleteM4sllEstudioJur() {
    log.debug("REST request to delete m4sll_estudio_jur : {}", idOrganization);
    List<M4sllEstudioJur> M4sllEstudioJurByInput = m4sllEstudioJurRepository.findByIdOrganization(idOrganization);

    m4sllEstudioJurRepository.deleteAll(M4sllEstudioJurByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllEstudioJurByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_estudio_jur")
public ResponseEntity<M4sllEstudioJur> updateM4sllEstudioJur(@RequestBody M4sllEstudioJur m4sllEstudioJur)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_estudio_jur : {}", m4sllEstudioJur);
  if (m4sllEstudioJur.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllEstudioJur result = m4sllEstudioJurRepository.save(m4sllEstudioJur);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllEstudioJur.getId().toString()))
    .body(result);
}


*/
