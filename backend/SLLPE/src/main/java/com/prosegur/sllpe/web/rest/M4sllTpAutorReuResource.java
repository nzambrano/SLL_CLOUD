package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpAutorReu;
import com.prosegur.sllpe.domain.M4sllTpAutorReuId;
import com.prosegur.sllpe.repository.M4sllTpAutorReuRepository;
import com.prosegur.sllpe.service.M4sllTpAutorReuServices;
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
public class M4sllTpAutorReuResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpAutorReuResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpAutorReu";

    @Autowired
    M4sllTpAutorReuServices m4sllTpAutorReuServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpAutorReuRepository m4sllTpAutorReuRepository;

    public M4sllTpAutorReuResource(M4sllTpAutorReuRepository m4sllTpAutorReuRepository) {
        this.m4sllTpAutorReuRepository = m4sllTpAutorReuRepository;
    }

    @PostMapping("/m4sll_tp_autor_reu")
    public ResponseEntity<List<M4sllTpAutorReu>> createM4sllTpAutorReu(@RequestBody List<M4sllTpAutorReu> listM4sllTpAutorReu)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_autor_reu : {}", listM4sllTpAutorReu);
        List<M4sllTpAutorReu>result =  m4sllTpAutorReuServices.saveAllWithSecuencia(listM4sllTpAutorReu);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_autor_reu/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_autor_reu")
    public ResponseEntity<List<M4sllTpAutorReu>> updateM4sllTpAutorReu(@RequestBody List<M4sllTpAutorReu> listM4sllTpAutorReu)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_autor_reu : {}", listM4sllTpAutorReu);
        List<M4sllTpAutorReu> result = m4sllTpAutorReuRepository.saveAll(listM4sllTpAutorReu);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_autor_reu/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_autor_reu")
        public ResponseEntity<List<M4sllTpAutorReu>> getAllM4sllTpAutorReu() {
          log.debug("REST request to get ALL M4sllTpAutorReu : {}");

          List<M4sllTpAutorReu> M4sllTpAutorReuAll = m4sllTpAutorReuRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpAutorReuAll);
        }
    */

    @GetMapping("/m4sll_tp_autor_reu")
    public ResponseEntity<List<M4sllTpAutorReu>> getM4sllTpAutorReu() {
        log.debug("REST request to get M4sllTpAutorReu : {}", idOrganization);

        List<M4sllTpAutorReu> M4sllTpAutorReuByInput = m4sllTpAutorReuRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpAutorReuByInput);
    }


    @DeleteMapping("/m4sll_tp_autor_reu/{tar_id_tp_autor_reu}")
    public ResponseEntity<Void> deleteM4sllTpAutorReu(@PathVariable("tar_id_tp_autor_reu") String tarIdTpAutorReu) {
        log.debug("REST request to delete m4sll_tp_autor_reu : {}", idOrganization + "|" + tarIdTpAutorReu);
        M4sllTpAutorReuId id = new M4sllTpAutorReuId();
        id.setIdOrganization(idOrganization);
        id.setTarIdTpAutorReu(tarIdTpAutorReu);

        m4sllTpAutorReuRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_autor_reu")
  public ResponseEntity<M4sllTpAutorReu> createM4sllTpAutorReu(@RequestBody M4sllTpAutorReu m4sllTpAutorReu)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_autor_reu : {}", m4sllTpAutorReu);
    M4sllTpAutorReuId id = new M4sllTpAutorReuId();
    M4sllTpAutorReuServices m4sllTpAutorReuServices = new M4sllTpAutorReuServices(m4sllTpAutorReuRepository);
    String id_tarIdTpAutorReu = m4sllTpAutorReuServices.UltimaSecuencia(m4sllTpAutorReu);

    id.setTarIdTpAutorReu(id_tarIdTpAutorReu);
    id.setIdOrganization(idOrganization);

    m4sllTpAutorReu.setId(id);
    M4sllTpAutorReu result = m4sllTpAutorReuRepository.save(m4sllTpAutorReu);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_autor_reu/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_autor_reu/{tar_id_tp_autor_reu}")
  public ResponseEntity<M4sllTpAutorReu> getM4sllTpAutorReu(@PathVariable("tar_id_tp_autor_reu") String tarIdTpAutorReu) {
      log.debug("REST request to get M4sllTpAutorReu : {}", idOrganization + "|" + tarIdTpAutorReu);
      M4sllTpAutorReuId id = new M4sllTpAutorReuId();
      id.setIdOrganization(idOrganization);
      id.setTarIdTpAutorReu(tarIdTpAutorReu);

      Optional<M4sllTpAutorReu> m4sllTpAutorReu = m4sllTpAutorReuRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpAutorReu);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_autor_reu")
  public ResponseEntity<Void> deleteM4sllTpAutorReu() {
    log.debug("REST request to delete m4sll_tp_autor_reu : {}", idOrganization);
    List<M4sllTpAutorReu> M4sllTpAutorReuByInput = m4sllTpAutorReuRepository.findByIdOrganization(idOrganization);

    m4sllTpAutorReuRepository.deleteAll(M4sllTpAutorReuByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpAutorReuByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_autor_reu")
public ResponseEntity<M4sllTpAutorReu> updateM4sllTpAutorReu(@RequestBody M4sllTpAutorReu m4sllTpAutorReu)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_autor_reu : {}", m4sllTpAutorReu);
  if (m4sllTpAutorReu.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpAutorReu result = m4sllTpAutorReuRepository.save(m4sllTpAutorReu);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpAutorReu.getId().toString()))
    .body(result);
}


*/
