package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTribunales;
import com.prosegur.sllpe.domain.M4sllTribunalesId;
import com.prosegur.sllpe.repository.M4sllTribunalesRepository;
import com.prosegur.sllpe.service.M4sllTribunalesServices;
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
public class M4sllTribunalesResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTribunalesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTribunales";

    @Autowired
    M4sllTribunalesServices m4sllTribunalesServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTribunalesRepository m4sllTribunalesRepository;

    public M4sllTribunalesResource(M4sllTribunalesRepository m4sllTribunalesRepository) {
        this.m4sllTribunalesRepository = m4sllTribunalesRepository;
    }

    @PostMapping("/m4sll_tribunales")
    public ResponseEntity<List<M4sllTribunales>> createM4sllTribunales(@RequestBody List<M4sllTribunales> listM4sllTribunales)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tribunales : {}", listM4sllTribunales);
        List<M4sllTribunales>result =  m4sllTribunalesServices.saveAllWithSecuencia(listM4sllTribunales);
        return ResponseEntity
               .created(new URI("/api/m4sll_tribunales/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tribunales")
    public ResponseEntity<List<M4sllTribunales>> updateM4sllTribunales(@RequestBody List<M4sllTribunales> listM4sllTribunales)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tribunales : {}", listM4sllTribunales);
        List<M4sllTribunales> result = m4sllTribunalesRepository.saveAll(listM4sllTribunales);
        return ResponseEntity
               .created(new URI("/api/m4sll_tribunales/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tribunales")
        public ResponseEntity<List<M4sllTribunales>> getAllM4sllTribunales() {
          log.debug("REST request to get ALL M4sllTribunales : {}");

          List<M4sllTribunales> M4sllTribunalesAll = m4sllTribunalesRepository.findAll();
          return ResponseEntity.ok().body(M4sllTribunalesAll);
        }
    */

    @GetMapping("/m4sll_tribunales")
    public ResponseEntity<List<M4sllTribunales>> getM4sllTribunales() {
        log.debug("REST request to get M4sllTribunales : {}", idOrganization);

        List<M4sllTribunales> M4sllTribunalesByInput = m4sllTribunalesRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTribunalesByInput);
    }


    @DeleteMapping("/m4sll_tribunales/{tri_id_tribunal}")
    public ResponseEntity<Void> deleteM4sllTribunales(@PathVariable("tri_id_tribunal") String triIdTribunal) {
        log.debug("REST request to delete m4sll_tribunales : {}", idOrganization + "|" + triIdTribunal);
        M4sllTribunalesId id = new M4sllTribunalesId();
        id.setIdOrganization(idOrganization);
        id.setTriIdTribunal(triIdTribunal);

        m4sllTribunalesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tribunales")
  public ResponseEntity<M4sllTribunales> createM4sllTribunales(@RequestBody M4sllTribunales m4sllTribunales)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tribunales : {}", m4sllTribunales);
    M4sllTribunalesId id = new M4sllTribunalesId();
    M4sllTribunalesServices m4sllTribunalesServices = new M4sllTribunalesServices(m4sllTribunalesRepository);
    String id_triIdTribunal = m4sllTribunalesServices.UltimaSecuencia(m4sllTribunales);

    id.setTriIdTribunal(id_triIdTribunal);
    id.setIdOrganization(idOrganization);

    m4sllTribunales.setId(id);
    M4sllTribunales result = m4sllTribunalesRepository.save(m4sllTribunales);
    return ResponseEntity
      .created(new URI("/api/m4sll_tribunales/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tribunales/{tri_id_tribunal}")
  public ResponseEntity<M4sllTribunales> getM4sllTribunales(@PathVariable("tri_id_tribunal") String triIdTribunal) {
      log.debug("REST request to get M4sllTribunales : {}", idOrganization + "|" + triIdTribunal);
      M4sllTribunalesId id = new M4sllTribunalesId();
      id.setIdOrganization(idOrganization);
      id.setTriIdTribunal(triIdTribunal);

      Optional<M4sllTribunales> m4sllTribunales = m4sllTribunalesRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTribunales);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tribunales")
  public ResponseEntity<Void> deleteM4sllTribunales() {
    log.debug("REST request to delete m4sll_tribunales : {}", idOrganization);
    List<M4sllTribunales> M4sllTribunalesByInput = m4sllTribunalesRepository.findByIdOrganization(idOrganization);

    m4sllTribunalesRepository.deleteAll(M4sllTribunalesByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTribunalesByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tribunales")
public ResponseEntity<M4sllTribunales> updateM4sllTribunales(@RequestBody M4sllTribunales m4sllTribunales)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tribunales : {}", m4sllTribunales);
  if (m4sllTribunales.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTribunales result = m4sllTribunalesRepository.save(m4sllTribunales);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTribunales.getId().toString()))
    .body(result);
}


*/
