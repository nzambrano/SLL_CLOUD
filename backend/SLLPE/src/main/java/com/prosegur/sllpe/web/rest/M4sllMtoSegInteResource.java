package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtoSegInte;
import com.prosegur.sllpe.domain.M4sllMtoSegInteId;
import com.prosegur.sllpe.repository.M4sllMtoSegInteRepository;
import com.prosegur.sllpe.service.M4sllMtoSegInteServices;
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
public class M4sllMtoSegInteResource {
    private final Logger log = LoggerFactory.getLogger(M4sllMtoSegInteResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtoSegInte";

    @Autowired
    M4sllMtoSegInteServices m4sllMtoSegInteServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllMtoSegInteRepository m4sllMtoSegInteRepository;

    public M4sllMtoSegInteResource(M4sllMtoSegInteRepository m4sllMtoSegInteRepository) {
        this.m4sllMtoSegInteRepository = m4sllMtoSegInteRepository;
    }

    @PostMapping("/m4sll_mto_seg_inte")
    public ResponseEntity<List<M4sllMtoSegInte>> createM4sllMtoSegInte(@RequestBody List<M4sllMtoSegInte> listM4sllMtoSegInte)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mto_seg_inte : {}", listM4sllMtoSegInte);
        List<M4sllMtoSegInte>result =  m4sllMtoSegInteServices.saveAllWithSecuencia(listM4sllMtoSegInte);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_seg_inte/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_mto_seg_inte")
    public ResponseEntity<List<M4sllMtoSegInte>> updateM4sllMtoSegInte(@RequestBody List<M4sllMtoSegInte> listM4sllMtoSegInte)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mto_seg_inte : {}", listM4sllMtoSegInte);
        List<M4sllMtoSegInte> result = m4sllMtoSegInteRepository.saveAll(listM4sllMtoSegInte);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_seg_inte/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_mto_seg_inte")
    public ResponseEntity<List<M4sllMtoSegInte>> getAllM4sllMtoSegInte() {
        log.debug("REST request to get ALL M4sllMtoSegInte : {}");

        List<M4sllMtoSegInte> M4sllMtoSegInteAll = m4sllMtoSegInteRepository.findAll();
        return ResponseEntity.ok().body(M4sllMtoSegInteAll);
    }

    @GetMapping("/m4sll_mto_seg_inte/{id_app_role}")
    public ResponseEntity<List<M4sllMtoSegInte>> getM4sllMtoSegInte(@PathVariable("id_app_role") String idAppRole) {
        log.debug("REST request to get M4sllMtoSegInte : {}", idOrganization + "|" + idAppRole);

        List<M4sllMtoSegInte> M4sllMtoSegInteByInput = m4sllMtoSegInteRepository.findByIdOrganizationIdAppRole(idOrganization, idAppRole);
        return ResponseEntity.ok().body(M4sllMtoSegInteByInput);
    }

<<<<<<< HEAD

=======
>>>>>>> 10e07f8b19038d1eec29c16735c0b78a791ae0a9

    @DeleteMapping("/m4sll_mto_seg_inte/{id_app_role}/{msi_secuencia}")
    public ResponseEntity<Void> deleteM4sllMtoSegInte(@PathVariable("id_app_role") String idAppRole, @PathVariable("msi_secuencia") Long msiSecuencia) {
        log.debug("REST request to delete m4sll_mto_seg_inte : {}", idOrganization + "|" + idAppRole + "|" + msiSecuencia);
        M4sllMtoSegInteId id = new M4sllMtoSegInteId();
        id.setIdOrganization(idOrganization);
        id.setIdAppRole(idAppRole);
        id.setMsiSecuencia(msiSecuencia);

        m4sllMtoSegInteRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_mto_seg_inte")
  public ResponseEntity<M4sllMtoSegInte> createM4sllMtoSegInte(@RequestBody M4sllMtoSegInte m4sllMtoSegInte)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_mto_seg_inte : {}", m4sllMtoSegInte);
    M4sllMtoSegInteId id = new M4sllMtoSegInteId();
    M4sllMtoSegInteServices m4sllMtoSegInteServices = new M4sllMtoSegInteServices(m4sllMtoSegInteRepository);
    Long id_msiSecuencia = m4sllMtoSegInteServices.UltimaSecuencia(m4sllMtoSegInte);

    id.setMsiSecuencia(id_msiSecuencia);
    id.setIdOrganization(idOrganization);
id.setIdAppRole(m4sllMtoSegInte.getId().getIdAppRole());

    m4sllMtoSegInte.setId(id);
    M4sllMtoSegInte result = m4sllMtoSegInteRepository.save(m4sllMtoSegInte);
    return ResponseEntity
      .created(new URI("/api/m4sll_mto_seg_inte/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_mto_seg_inte/{id_app_role}/{msi_secuencia}")
  public ResponseEntity<M4sllMtoSegInte> getM4sllMtoSegInte(@PathVariable("id_app_role") String idAppRole, @PathVariable("msi_secuencia") Long msiSecuencia) {
      log.debug("REST request to get M4sllMtoSegInte : {}", idOrganization + "|" + idAppRole + "|" + msiSecuencia);
      M4sllMtoSegInteId id = new M4sllMtoSegInteId();
      id.setIdOrganization(idOrganization);
id.setIdAppRole(idAppRole);
      id.setMsiSecuencia(msiSecuencia);

      Optional<M4sllMtoSegInte> m4sllMtoSegInte = m4sllMtoSegInteRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllMtoSegInte);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_mto_seg_inte/{id_app_role}")
  public ResponseEntity<Void> deleteM4sllMtoSegInte(@PathVariable("id_app_role") String idAppRole) {
    log.debug("REST request to delete m4sll_mto_seg_inte : {}", idOrganization + "|" + idAppRole);
    List<M4sllMtoSegInte> M4sllMtoSegInteByInput = m4sllMtoSegInteRepository.findByIdOrganizationIdAppRole(idOrganization, idAppRole);

    m4sllMtoSegInteRepository.deleteAll(M4sllMtoSegInteByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllMtoSegInteByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_mto_seg_inte")
public ResponseEntity<M4sllMtoSegInte> updateM4sllMtoSegInte(@RequestBody M4sllMtoSegInte m4sllMtoSegInte)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_mto_seg_inte : {}", m4sllMtoSegInte);
  if (m4sllMtoSegInte.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllMtoSegInte result = m4sllMtoSegInteRepository.save(m4sllMtoSegInte);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllMtoSegInte.getId().toString()))
    .body(result);
}


*/
