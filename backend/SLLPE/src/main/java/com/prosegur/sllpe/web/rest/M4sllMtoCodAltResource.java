package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtoCodAlt;
import com.prosegur.sllpe.domain.M4sllMtoCodAltId;
import com.prosegur.sllpe.repository.M4sllMtoCodAltRepository;
import com.prosegur.sllpe.service.M4sllMtoCodAltServices;
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
public class M4sllMtoCodAltResource {
    private final Logger log = LoggerFactory.getLogger(M4sllMtoCodAltResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtoCodAlt";

    @Autowired
    M4sllMtoCodAltServices m4sllMtoCodAltServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllMtoCodAltRepository m4sllMtoCodAltRepository;

    public M4sllMtoCodAltResource(M4sllMtoCodAltRepository m4sllMtoCodAltRepository) {
        this.m4sllMtoCodAltRepository = m4sllMtoCodAltRepository;
    }

    @PostMapping("/m4sll_mto_cod_alt")
    public ResponseEntity<List<M4sllMtoCodAlt>> createM4sllMtoCodAlt(@RequestBody List<M4sllMtoCodAlt> listM4sllMtoCodAlt)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mto_cod_alt : {}", listM4sllMtoCodAlt);
        List<M4sllMtoCodAlt>result =  m4sllMtoCodAltServices.saveAllWithSecuencia(listM4sllMtoCodAlt);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_cod_alt/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_mto_cod_alt")
    public ResponseEntity<List<M4sllMtoCodAlt>> updateM4sllMtoCodAlt(@RequestBody List<M4sllMtoCodAlt> listM4sllMtoCodAlt)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mto_cod_alt : {}", listM4sllMtoCodAlt);
        List<M4sllMtoCodAlt> result = m4sllMtoCodAltRepository.saveAll(listM4sllMtoCodAlt);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_cod_alt/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_mto_cod_alt")
        public ResponseEntity<List<M4sllMtoCodAlt>> getAllM4sllMtoCodAlt() {
          log.debug("REST request to get ALL M4sllMtoCodAlt : {}");

          List<M4sllMtoCodAlt> M4sllMtoCodAltAll = m4sllMtoCodAltRepository.findAll();
          return ResponseEntity.ok().body(M4sllMtoCodAltAll);
        }
    */

    @GetMapping("/m4sll_mto_cod_alt")
    public ResponseEntity<List<M4sllMtoCodAlt>> getM4sllMtoCodAlt() {
        log.debug("REST request to get M4sllMtoCodAlt : {}", idOrganization);

        List<M4sllMtoCodAlt> M4sllMtoCodAltByInput = m4sllMtoCodAltRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllMtoCodAltByInput);
    }


    @DeleteMapping("/m4sll_mto_cod_alt/{mca_id_codigo_alterno}")
    public ResponseEntity<Void> deleteM4sllMtoCodAlt(@PathVariable("mca_id_codigo_alterno") String mcaIdCodigoAlterno) {
        log.debug("REST request to delete m4sll_mto_cod_alt : {}", idOrganization + "|" + mcaIdCodigoAlterno);
        M4sllMtoCodAltId id = new M4sllMtoCodAltId();
        id.setIdOrganization(idOrganization);
        id.setMcaIdCodigoAlterno(mcaIdCodigoAlterno);

        m4sllMtoCodAltRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_mto_cod_alt")
  public ResponseEntity<M4sllMtoCodAlt> createM4sllMtoCodAlt(@RequestBody M4sllMtoCodAlt m4sllMtoCodAlt)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_mto_cod_alt : {}", m4sllMtoCodAlt);
    M4sllMtoCodAltId id = new M4sllMtoCodAltId();
    M4sllMtoCodAltServices m4sllMtoCodAltServices = new M4sllMtoCodAltServices(m4sllMtoCodAltRepository);
    String id_mcaIdCodigoAlterno = m4sllMtoCodAltServices.UltimaSecuencia(m4sllMtoCodAlt);

    id.setMcaIdCodigoAlterno(id_mcaIdCodigoAlterno);
    id.setIdOrganization(idOrganization);

    m4sllMtoCodAlt.setId(id);
    M4sllMtoCodAlt result = m4sllMtoCodAltRepository.save(m4sllMtoCodAlt);
    return ResponseEntity
      .created(new URI("/api/m4sll_mto_cod_alt/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_mto_cod_alt/{mca_id_codigo_alterno}")
  public ResponseEntity<M4sllMtoCodAlt> getM4sllMtoCodAlt(@PathVariable("mca_id_codigo_alterno") String mcaIdCodigoAlterno) {
      log.debug("REST request to get M4sllMtoCodAlt : {}", idOrganization + "|" + mcaIdCodigoAlterno);
      M4sllMtoCodAltId id = new M4sllMtoCodAltId();
      id.setIdOrganization(idOrganization);
      id.setMcaIdCodigoAlterno(mcaIdCodigoAlterno);

      Optional<M4sllMtoCodAlt> m4sllMtoCodAlt = m4sllMtoCodAltRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllMtoCodAlt);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_mto_cod_alt")
  public ResponseEntity<Void> deleteM4sllMtoCodAlt() {
    log.debug("REST request to delete m4sll_mto_cod_alt : {}", idOrganization);
    List<M4sllMtoCodAlt> M4sllMtoCodAltByInput = m4sllMtoCodAltRepository.findByIdOrganization(idOrganization);

    m4sllMtoCodAltRepository.deleteAll(M4sllMtoCodAltByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllMtoCodAltByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_mto_cod_alt")
public ResponseEntity<M4sllMtoCodAlt> updateM4sllMtoCodAlt(@RequestBody M4sllMtoCodAlt m4sllMtoCodAlt)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_mto_cod_alt : {}", m4sllMtoCodAlt);
  if (m4sllMtoCodAlt.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllMtoCodAlt result = m4sllMtoCodAltRepository.save(m4sllMtoCodAlt);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllMtoCodAlt.getId().toString()))
    .body(result);
}


*/
