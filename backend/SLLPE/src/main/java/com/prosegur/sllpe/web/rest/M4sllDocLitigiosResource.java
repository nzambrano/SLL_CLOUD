package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllDocLitigios;
import com.prosegur.sllpe.domain.M4sllDocLitigiosId;
import com.prosegur.sllpe.repository.M4sllDocLitigiosRepository;
import com.prosegur.sllpe.service.M4sllDocLitigiosServices;
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
public class M4sllDocLitigiosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllDocLitigiosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllDocLitigios";

    @Autowired
    M4sllDocLitigiosServices m4sllDocLitigiosServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllDocLitigiosRepository m4sllDocLitigiosRepository;

    public M4sllDocLitigiosResource(M4sllDocLitigiosRepository m4sllDocLitigiosRepository) {
        this.m4sllDocLitigiosRepository = m4sllDocLitigiosRepository;
    }

    @PostMapping("/m4sll_doc_litigios")
    public ResponseEntity<List<M4sllDocLitigios>> createM4sllDocLitigios(@RequestBody List<M4sllDocLitigios> listM4sllDocLitigios)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_doc_litigios : {}", listM4sllDocLitigios);
        List<M4sllDocLitigios>result =  m4sllDocLitigiosServices.saveAllWithSecuencia(listM4sllDocLitigios);
        return ResponseEntity
               .created(new URI("/api/m4sll_doc_litigios/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_doc_litigios")
    public ResponseEntity<List<M4sllDocLitigios>> updateM4sllDocLitigios(@RequestBody List<M4sllDocLitigios> listM4sllDocLitigios)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_doc_litigios : {}", listM4sllDocLitigios);
        List<M4sllDocLitigios> result = m4sllDocLitigiosRepository.saveAll(listM4sllDocLitigios);
        return ResponseEntity
               .created(new URI("/api/m4sll_doc_litigios/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_doc_litigios")
    public ResponseEntity<List<M4sllDocLitigios>> getAllM4sllDocLitigios() {
        log.debug("REST request to get ALL M4sllDocLitigios : {}");

        List<M4sllDocLitigios> M4sllDocLitigiosAll = m4sllDocLitigiosRepository.findAll();
        return ResponseEntity.ok().body(M4sllDocLitigiosAll);
    }

    @GetMapping("/m4sll_doc_litigios/{lit_id_litigio}")
    public ResponseEntity<List<M4sllDocLitigios>> getM4sllDocLitigios(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllDocLitigios : {}", idOrganization + "|" + litIdLitigio);

        List<M4sllDocLitigios> M4sllDocLitigiosByInput = m4sllDocLitigiosRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);
        return ResponseEntity.ok().body(M4sllDocLitigiosByInput);
    }


    @DeleteMapping("/m4sll_doc_litigios/{lit_id_litigio}/{dol_secuencia}")
    public ResponseEntity<Void> deleteM4sllDocLitigios(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("dol_secuencia") Long dolSecuencia) {
        log.debug("REST request to delete m4sll_doc_litigios : {}", idOrganization + "|" + litIdLitigio + "|" + dolSecuencia);
        M4sllDocLitigiosId id = new M4sllDocLitigiosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setDolSecuencia(dolSecuencia);

        m4sllDocLitigiosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_doc_litigios")
  public ResponseEntity<M4sllDocLitigios> createM4sllDocLitigios(@RequestBody M4sllDocLitigios m4sllDocLitigios)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_doc_litigios : {}", m4sllDocLitigios);
    M4sllDocLitigiosId id = new M4sllDocLitigiosId();
    M4sllDocLitigiosServices m4sllDocLitigiosServices = new M4sllDocLitigiosServices(m4sllDocLitigiosRepository);
    Long id_dolSecuencia = m4sllDocLitigiosServices.UltimaSecuencia(m4sllDocLitigios);

    id.setDolSecuencia(id_dolSecuencia);
    id.setIdOrganization(idOrganization);
id.setLitIdLitigio(m4sllDocLitigios.getId().getLitIdLitigio());

    m4sllDocLitigios.setId(id);
    M4sllDocLitigios result = m4sllDocLitigiosRepository.save(m4sllDocLitigios);
    return ResponseEntity
      .created(new URI("/api/m4sll_doc_litigios/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_doc_litigios/{lit_id_litigio}/{dol_secuencia}")
  public ResponseEntity<M4sllDocLitigios> getM4sllDocLitigios(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("dol_secuencia") Long dolSecuencia) {
      log.debug("REST request to get M4sllDocLitigios : {}", idOrganization + "|" + litIdLitigio + "|" + dolSecuencia);
      M4sllDocLitigiosId id = new M4sllDocLitigiosId();
      id.setIdOrganization(idOrganization);
id.setLitIdLitigio(litIdLitigio);
      id.setDolSecuencia(dolSecuencia);

      Optional<M4sllDocLitigios> m4sllDocLitigios = m4sllDocLitigiosRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllDocLitigios);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_doc_litigios/{lit_id_litigio}")
  public ResponseEntity<Void> deleteM4sllDocLitigios(@PathVariable("lit_id_litigio") String litIdLitigio) {
    log.debug("REST request to delete m4sll_doc_litigios : {}", idOrganization + "|" + litIdLitigio);
    List<M4sllDocLitigios> M4sllDocLitigiosByInput = m4sllDocLitigiosRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);

    m4sllDocLitigiosRepository.deleteAll(M4sllDocLitigiosByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllDocLitigiosByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_doc_litigios")
public ResponseEntity<M4sllDocLitigios> updateM4sllDocLitigios(@RequestBody M4sllDocLitigios m4sllDocLitigios)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_doc_litigios : {}", m4sllDocLitigios);
  if (m4sllDocLitigios.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllDocLitigios result = m4sllDocLitigiosRepository.save(m4sllDocLitigios);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllDocLitigios.getId().toString()))
    .body(result);
}


*/
