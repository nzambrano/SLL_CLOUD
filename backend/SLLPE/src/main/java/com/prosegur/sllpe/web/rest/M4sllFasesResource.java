package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import com.prosegur.sllpe.repository.M4sllFasesRepository;
import com.prosegur.sllpe.service.M4sllFasesServices;
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
public class M4sllFasesResource {
    private final Logger log = LoggerFactory.getLogger(M4sllFasesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllFases";

    @Autowired
    M4sllFasesServices m4sllFasesServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllFasesRepository m4sllFasesRepository;

    public M4sllFasesResource(M4sllFasesRepository m4sllFasesRepository) {
        this.m4sllFasesRepository = m4sllFasesRepository;
    }

    @PostMapping("/m4sll_fases")
    public ResponseEntity<List<M4sllFases>> createM4sllFases(@RequestBody List<M4sllFases> listM4sllFases)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_fases : {}", listM4sllFases);
        List<M4sllFases>result =  m4sllFasesServices.saveAllWithSecuencia(listM4sllFases);
        return ResponseEntity
               .created(new URI("/api/m4sll_fases/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_fases")
    public ResponseEntity<List<M4sllFases>> updateM4sllFases(@RequestBody List<M4sllFases> listM4sllFases)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_fases : {}", listM4sllFases);
        List<M4sllFases> result = m4sllFasesRepository.saveAll(listM4sllFases);
        return ResponseEntity
               .created(new URI("/api/m4sll_fases/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_fases")
    public ResponseEntity<List<M4sllFases>> getAllM4sllFases() {
        log.debug("REST request to get ALL M4sllFases : {}");

        List<M4sllFases> M4sllFasesAll = m4sllFasesRepository.findAll();
        return ResponseEntity.ok().body(M4sllFasesAll);
    }

    @GetMapping("/m4sll_fases/{lit_id_litigio}")
    public ResponseEntity<List<M4sllFases>> getM4sllFases(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllFases : {}", idOrganization + "|" + litIdLitigio);

        List<M4sllFases> M4sllFasesByInput = m4sllFasesRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);
        return ResponseEntity.ok().body(M4sllFasesByInput);
    }

    @GetMapping("/m4sll_fases/{lit_id_litigio}/{fas_secuencia}")
    public ResponseEntity<List<M4sllFases>> getM4sllFases(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("fas_secuencia") Long fasSecuencia) {
        log.debug("REST request to get M4sllFases : {}", idOrganization + "|" + litIdLitigio + "|" + fasSecuencia);

        List<M4sllFases> M4sllFasesByInput = m4sllFasesRepository.findByIdOrganizationLitIdLitigioFasSecuencia(idOrganization, litIdLitigio, fasSecuencia);
        return ResponseEntity.ok().body(M4sllFasesByInput);
    }


    @DeleteMapping("/m4sll_fases/{lit_id_litigio}/{fas_secuencia}")
    public ResponseEntity<Void> deleteM4sllFases(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("fas_secuencia") Long fasSecuencia) {
        log.debug("REST request to delete m4sll_fases : {}", idOrganization + "|" + litIdLitigio + "|" + fasSecuencia);
        M4sllFasesId id = new M4sllFasesId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);


        m4sllFasesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_fases")
  public ResponseEntity<M4sllFases> createM4sllFases(@RequestBody M4sllFases m4sllFases)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_fases : {}", m4sllFases);
    M4sllFasesId id = new M4sllFasesId();
    M4sllFasesServices m4sllFasesServices = new M4sllFasesServices(m4sllFasesRepository);
    Long id_fasSecuencia = m4sllFasesServices.UltimaSecuencia(m4sllFases);


    id.setIdOrganization(idOrganization);
id.setLitIdLitigio(m4sllFases.getId().getLitIdLitigio());

    m4sllFases.setId(id);
    M4sllFases result = m4sllFasesRepository.save(m4sllFases);
    return ResponseEntity
      .created(new URI("/api/m4sll_fases/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_fases/{lit_id_litigio}/{fas_secuencia}")
  public ResponseEntity<M4sllFases> getM4sllFases(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("fas_secuencia") Long fasSecuencia) {
      log.debug("REST request to get M4sllFases : {}", idOrganization + "|" + litIdLitigio + "|" + fasSecuencia);
      M4sllFasesId id = new M4sllFasesId();
      id.setIdOrganization(idOrganization);
id.setLitIdLitigio(litIdLitigio);


      Optional<M4sllFases> m4sllFases = m4sllFasesRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllFases);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_fases/{lit_id_litigio}")
  public ResponseEntity<Void> deleteM4sllFases(@PathVariable("lit_id_litigio") String litIdLitigio) {
    log.debug("REST request to delete m4sll_fases : {}", idOrganization + "|" + litIdLitigio);
    List<M4sllFases> M4sllFasesByInput = m4sllFasesRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);

    m4sllFasesRepository.deleteAll(M4sllFasesByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllFasesByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_fases")
public ResponseEntity<M4sllFases> updateM4sllFases(@RequestBody M4sllFases m4sllFases)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_fases : {}", m4sllFases);
  if (m4sllFases.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllFases result = m4sllFasesRepository.save(m4sllFases);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllFases.getId().toString()))
    .body(result);
}


*/
