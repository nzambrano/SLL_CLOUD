package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllLitSeguimie;
import com.prosegur.sllpe.domain.M4sllLitSeguimieId;
import com.prosegur.sllpe.repository.M4sllLitSeguimieRepository;
import com.prosegur.sllpe.service.M4sllLitSeguimieServices;
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
public class M4sllLitSeguimieResource {
    private final Logger log = LoggerFactory.getLogger(M4sllLitSeguimieResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllLitSeguimie";

    @Autowired
    M4sllLitSeguimieServices m4sllLitSeguimieServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllLitSeguimieRepository m4sllLitSeguimieRepository;

    public M4sllLitSeguimieResource(M4sllLitSeguimieRepository m4sllLitSeguimieRepository) {
        this.m4sllLitSeguimieRepository = m4sllLitSeguimieRepository;
    }

    @PostMapping("/m4sll_lit_seguimie")
    public ResponseEntity<List<M4sllLitSeguimie>> createM4sllLitSeguimie(@RequestBody List<M4sllLitSeguimie> listM4sllLitSeguimie)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_lit_seguimie : {}", listM4sllLitSeguimie);
        List<M4sllLitSeguimie>result =  m4sllLitSeguimieServices.saveAllWithSecuencia(listM4sllLitSeguimie);
        return ResponseEntity
               .created(new URI("/api/m4sll_lit_seguimie/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_lit_seguimie")
    public ResponseEntity<List<M4sllLitSeguimie>> updateM4sllLitSeguimie(@RequestBody List<M4sllLitSeguimie> listM4sllLitSeguimie)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_lit_seguimie : {}", listM4sllLitSeguimie);
        List<M4sllLitSeguimie> result = m4sllLitSeguimieRepository.saveAll(listM4sllLitSeguimie);
        return ResponseEntity
               .created(new URI("/api/m4sll_lit_seguimie/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_lit_seguimie")
    public ResponseEntity<List<M4sllLitSeguimie>> getAllM4sllLitSeguimie() {
        log.debug("REST request to get ALL M4sllLitSeguimie : {}");

        List<M4sllLitSeguimie> M4sllLitSeguimieAll = m4sllLitSeguimieRepository.findAll();
        return ResponseEntity.ok().body(M4sllLitSeguimieAll);
    }

    @GetMapping("/m4sll_lit_seguimie/{lit_id_litigio}")
    public ResponseEntity<List<M4sllLitSeguimie>> getM4sllLitSeguimie(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllLitSeguimie : {}", idOrganization + "|" + litIdLitigio);

        List<M4sllLitSeguimie> M4sllLitSeguimieByInput = m4sllLitSeguimieRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);
        return ResponseEntity.ok().body(M4sllLitSeguimieByInput);
    }


    @DeleteMapping("/m4sll_lit_seguimie/{lit_id_litigio}/{lis_secuencia}")
    public ResponseEntity<Void> deleteM4sllLitSeguimie(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("lis_secuencia") Long lisSecuencia) {
        log.debug("REST request to delete m4sll_lit_seguimie : {}", idOrganization + "|" + litIdLitigio + "|" + lisSecuencia);
        M4sllLitSeguimieId id = new M4sllLitSeguimieId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setLisSecuencia(lisSecuencia);

        m4sllLitSeguimieRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_lit_seguimie")
  public ResponseEntity<M4sllLitSeguimie> createM4sllLitSeguimie(@RequestBody M4sllLitSeguimie m4sllLitSeguimie)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_lit_seguimie : {}", m4sllLitSeguimie);
    M4sllLitSeguimieId id = new M4sllLitSeguimieId();
    M4sllLitSeguimieServices m4sllLitSeguimieServices = new M4sllLitSeguimieServices(m4sllLitSeguimieRepository);
    Long id_lisSecuencia = m4sllLitSeguimieServices.UltimaSecuencia(m4sllLitSeguimie);

    id.setLisSecuencia(id_lisSecuencia);
    id.setIdOrganization(idOrganization);
id.setLitIdLitigio(m4sllLitSeguimie.getId().getLitIdLitigio());

    m4sllLitSeguimie.setId(id);
    M4sllLitSeguimie result = m4sllLitSeguimieRepository.save(m4sllLitSeguimie);
    return ResponseEntity
      .created(new URI("/api/m4sll_lit_seguimie/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_lit_seguimie/{lit_id_litigio}/{lis_secuencia}")
  public ResponseEntity<M4sllLitSeguimie> getM4sllLitSeguimie(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("lis_secuencia") Long lisSecuencia) {
      log.debug("REST request to get M4sllLitSeguimie : {}", idOrganization + "|" + litIdLitigio + "|" + lisSecuencia);
      M4sllLitSeguimieId id = new M4sllLitSeguimieId();
      id.setIdOrganization(idOrganization);
id.setLitIdLitigio(litIdLitigio);
      id.setLisSecuencia(lisSecuencia);

      Optional<M4sllLitSeguimie> m4sllLitSeguimie = m4sllLitSeguimieRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllLitSeguimie);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_lit_seguimie/{lit_id_litigio}")
  public ResponseEntity<Void> deleteM4sllLitSeguimie(@PathVariable("lit_id_litigio") String litIdLitigio) {
    log.debug("REST request to delete m4sll_lit_seguimie : {}", idOrganization + "|" + litIdLitigio);
    List<M4sllLitSeguimie> M4sllLitSeguimieByInput = m4sllLitSeguimieRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);

    m4sllLitSeguimieRepository.deleteAll(M4sllLitSeguimieByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllLitSeguimieByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_lit_seguimie")
public ResponseEntity<M4sllLitSeguimie> updateM4sllLitSeguimie(@RequestBody M4sllLitSeguimie m4sllLitSeguimie)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_lit_seguimie : {}", m4sllLitSeguimie);
  if (m4sllLitSeguimie.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllLitSeguimie result = m4sllLitSeguimieRepository.save(m4sllLitSeguimie);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllLitSeguimie.getId().toString()))
    .body(result);
}


*/
