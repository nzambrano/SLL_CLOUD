package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.domain.M4sllMtAbogadosId;
import com.prosegur.sllpe.repository.M4sllMtAbogadosRepository;
import com.prosegur.sllpe.service.M4sllMtAbogadosServices;
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
public class M4sllMtAbogadosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllMtAbogadosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtAbogados";

    @Autowired
    M4sllMtAbogadosServices m4sllMtAbogadosServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllMtAbogadosRepository m4sllMtAbogadosRepository;

    public M4sllMtAbogadosResource(M4sllMtAbogadosRepository m4sllMtAbogadosRepository) {
        this.m4sllMtAbogadosRepository = m4sllMtAbogadosRepository;
    }

    @PostMapping("/m4sll_mt_abogados")
    public ResponseEntity<List<M4sllMtAbogados>> createM4sllMtAbogados(@RequestBody List<M4sllMtAbogados> listM4sllMtAbogados)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mt_abogados : {}", listM4sllMtAbogados);
        List<M4sllMtAbogados>result =  m4sllMtAbogadosServices.saveAllWithSecuencia(listM4sllMtAbogados);
        return ResponseEntity
               .created(new URI("/api/m4sll_mt_abogados/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_mt_abogados")
    public ResponseEntity<List<M4sllMtAbogados>> updateM4sllMtAbogados(@RequestBody List<M4sllMtAbogados> listM4sllMtAbogados)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mt_abogados : {}", listM4sllMtAbogados);
        List<M4sllMtAbogados> result = m4sllMtAbogadosRepository.saveAll(listM4sllMtAbogados);
        return ResponseEntity
               .created(new URI("/api/m4sll_mt_abogados/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_mt_abogados")
        public ResponseEntity<List<M4sllMtAbogados>> getAllM4sllMtAbogados() {
          log.debug("REST request to get ALL M4sllMtAbogados : {}");

          List<M4sllMtAbogados> M4sllMtAbogadosAll = m4sllMtAbogadosRepository.findAll();
          return ResponseEntity.ok().body(M4sllMtAbogadosAll);
        }
    */

    @GetMapping("/m4sll_mt_abogados")
    public ResponseEntity<List<M4sllMtAbogados>> getM4sllMtAbogados() {
        log.debug("REST request to get M4sllMtAbogados : {}", idOrganization);

        List<M4sllMtAbogados> M4sllMtAbogadosByInput = m4sllMtAbogadosRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllMtAbogadosByInput);
    }

    @GetMapping("/m4sll_mt_abogados/{mab_chk_int}")
    public ResponseEntity<List<M4sllMtAbogados>> getM4sllMtAbogados(@PathVariable("mab_chk_int") String mabChkInt) {
        log.debug("REST request to get M4sllMtAbogados : {}", idOrganization + "|" + mabChkInt);

        List<M4sllMtAbogados> M4sllMtAbogadosByInput = m4sllMtAbogadosRepository.findByIdOrganizationMabChkInt(idOrganization, mabChkInt);
        return ResponseEntity.ok().body(M4sllMtAbogadosByInput);
    }

    @DeleteMapping("/m4sll_mt_abogados/{mab_secuencia}")
    public ResponseEntity<Void> deleteM4sllMtAbogados(@PathVariable("mab_secuencia") Long mabSecuencia) {
        log.debug("REST request to delete m4sll_mt_abogados : {}", idOrganization + "|" + mabSecuencia);
        M4sllMtAbogadosId id = new M4sllMtAbogadosId();
        id.setIdOrganization(idOrganization);
        id.setMabSecuencia(mabSecuencia);

        m4sllMtAbogadosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_mt_abogados")
  public ResponseEntity<M4sllMtAbogados> createM4sllMtAbogados(@RequestBody M4sllMtAbogados m4sllMtAbogados)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_mt_abogados : {}", m4sllMtAbogados);
    M4sllMtAbogadosId id = new M4sllMtAbogadosId();
    M4sllMtAbogadosServices m4sllMtAbogadosServices = new M4sllMtAbogadosServices(m4sllMtAbogadosRepository);
    Long id_mabSecuencia = m4sllMtAbogadosServices.UltimaSecuencia(m4sllMtAbogados);

    id.setMabSecuencia(id_mabSecuencia);
    id.setIdOrganization(idOrganization);

    m4sllMtAbogados.setId(id);
    M4sllMtAbogados result = m4sllMtAbogadosRepository.save(m4sllMtAbogados);
    return ResponseEntity
      .created(new URI("/api/m4sll_mt_abogados/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_mt_abogados/{mab_secuencia}")
  public ResponseEntity<M4sllMtAbogados> getM4sllMtAbogados(@PathVariable("mab_secuencia") Long mabSecuencia) {
      log.debug("REST request to get M4sllMtAbogados : {}", idOrganization + "|" + mabSecuencia);
      M4sllMtAbogadosId id = new M4sllMtAbogadosId();
      id.setIdOrganization(idOrganization);
      id.setMabSecuencia(mabSecuencia);

      Optional<M4sllMtAbogados> m4sllMtAbogados = m4sllMtAbogadosRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllMtAbogados);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_mt_abogados")
  public ResponseEntity<Void> deleteM4sllMtAbogados() {
    log.debug("REST request to delete m4sll_mt_abogados : {}", idOrganization);
    List<M4sllMtAbogados> M4sllMtAbogadosByInput = m4sllMtAbogadosRepository.findByIdOrganization(idOrganization);

    m4sllMtAbogadosRepository.deleteAll(M4sllMtAbogadosByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllMtAbogadosByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_mt_abogados")
public ResponseEntity<M4sllMtAbogados> updateM4sllMtAbogados(@RequestBody M4sllMtAbogados m4sllMtAbogados)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_mt_abogados : {}", m4sllMtAbogados);
  if (m4sllMtAbogados.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllMtAbogados result = m4sllMtAbogadosRepository.save(m4sllMtAbogados);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllMtAbogados.getId().toString()))
    .body(result);
}


*/
