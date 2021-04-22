package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtoRiesgos;
import com.prosegur.sllpe.domain.M4sllMtoRiesgosId;
import com.prosegur.sllpe.repository.M4sllMtoRiesgosRepository;
import com.prosegur.sllpe.service.M4sllMtoRiesgosServices;
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
public class M4sllMtoRiesgosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllMtoRiesgosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtoRiesgos";

    @Autowired
    M4sllMtoRiesgosServices m4sllMtoRiesgosServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository;

    public M4sllMtoRiesgosResource(M4sllMtoRiesgosRepository m4sllMtoRiesgosRepository) {
        this.m4sllMtoRiesgosRepository = m4sllMtoRiesgosRepository;
    }

    @PostMapping("/m4sll_mto_riesgos")
    public ResponseEntity<List<M4sllMtoRiesgos>> createM4sllMtoRiesgos(@RequestBody List<M4sllMtoRiesgos> listM4sllMtoRiesgos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mto_riesgos : {}", listM4sllMtoRiesgos);
        List<M4sllMtoRiesgos>result =  m4sllMtoRiesgosServices.saveAllWithSecuencia(listM4sllMtoRiesgos);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_riesgos/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_mto_riesgos")
    public ResponseEntity<List<M4sllMtoRiesgos>> updateM4sllMtoRiesgos(@RequestBody List<M4sllMtoRiesgos> listM4sllMtoRiesgos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mto_riesgos : {}", listM4sllMtoRiesgos);
        List<M4sllMtoRiesgos> result = m4sllMtoRiesgosRepository.saveAll(listM4sllMtoRiesgos);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_riesgos/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_mto_riesgos")
        public ResponseEntity<List<M4sllMtoRiesgos>> getAllM4sllMtoRiesgos() {
          log.debug("REST request to get ALL M4sllMtoRiesgos : {}");

          List<M4sllMtoRiesgos> M4sllMtoRiesgosAll = m4sllMtoRiesgosRepository.findAll();
          return ResponseEntity.ok().body(M4sllMtoRiesgosAll);
        }
    */

    @GetMapping("/m4sll_mto_riesgos")
    public ResponseEntity<List<M4sllMtoRiesgos>> getM4sllMtoRiesgos() {
        log.debug("REST request to get M4sllMtoRiesgos : {}", idOrganization);

        List<M4sllMtoRiesgos> M4sllMtoRiesgosByInput = m4sllMtoRiesgosRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllMtoRiesgosByInput);
    }


    @DeleteMapping("/m4sll_mto_riesgos/{mri_id_riesgo}")
    public ResponseEntity<Void> deleteM4sllMtoRiesgos(@PathVariable("mri_id_riesgo") String mriIdRiesgo) {
        log.debug("REST request to delete m4sll_mto_riesgos : {}", idOrganization + "|" + mriIdRiesgo);
        M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
        id.setIdOrganization(idOrganization);
        id.setMriIdRiesgo(mriIdRiesgo);

        m4sllMtoRiesgosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_mto_riesgos")
  public ResponseEntity<M4sllMtoRiesgos> createM4sllMtoRiesgos(@RequestBody M4sllMtoRiesgos m4sllMtoRiesgos)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_mto_riesgos : {}", m4sllMtoRiesgos);
    M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
    M4sllMtoRiesgosServices m4sllMtoRiesgosServices = new M4sllMtoRiesgosServices(m4sllMtoRiesgosRepository);
    String id_mriIdRiesgo = m4sllMtoRiesgosServices.UltimaSecuencia(m4sllMtoRiesgos);

    id.setMriIdRiesgo(id_mriIdRiesgo);
    id.setIdOrganization(idOrganization);

    m4sllMtoRiesgos.setId(id);
    M4sllMtoRiesgos result = m4sllMtoRiesgosRepository.save(m4sllMtoRiesgos);
    return ResponseEntity
      .created(new URI("/api/m4sll_mto_riesgos/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_mto_riesgos/{mri_id_riesgo}")
  public ResponseEntity<M4sllMtoRiesgos> getM4sllMtoRiesgos(@PathVariable("mri_id_riesgo") String mriIdRiesgo) {
      log.debug("REST request to get M4sllMtoRiesgos : {}", idOrganization + "|" + mriIdRiesgo);
      M4sllMtoRiesgosId id = new M4sllMtoRiesgosId();
      id.setIdOrganization(idOrganization);
      id.setMriIdRiesgo(mriIdRiesgo);

      Optional<M4sllMtoRiesgos> m4sllMtoRiesgos = m4sllMtoRiesgosRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllMtoRiesgos);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_mto_riesgos")
  public ResponseEntity<Void> deleteM4sllMtoRiesgos() {
    log.debug("REST request to delete m4sll_mto_riesgos : {}", idOrganization);
    List<M4sllMtoRiesgos> M4sllMtoRiesgosByInput = m4sllMtoRiesgosRepository.findByIdOrganization(idOrganization);

    m4sllMtoRiesgosRepository.deleteAll(M4sllMtoRiesgosByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllMtoRiesgosByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_mto_riesgos")
public ResponseEntity<M4sllMtoRiesgos> updateM4sllMtoRiesgos(@RequestBody M4sllMtoRiesgos m4sllMtoRiesgos)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_mto_riesgos : {}", m4sllMtoRiesgos);
  if (m4sllMtoRiesgos.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllMtoRiesgos result = m4sllMtoRiesgosRepository.save(m4sllMtoRiesgos);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllMtoRiesgos.getId().toString()))
    .body(result);
}


*/
