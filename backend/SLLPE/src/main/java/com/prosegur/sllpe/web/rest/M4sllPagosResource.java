package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllPagos;
import com.prosegur.sllpe.domain.M4sllPagosId;
import com.prosegur.sllpe.repository.M4sllPagosRepository;
import com.prosegur.sllpe.service.M4sllPagosServices;
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
public class M4sllPagosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllPagosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllPagos";

    @Autowired
    M4sllPagosServices m4sllPagosServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllPagosRepository m4sllPagosRepository;

    public M4sllPagosResource(M4sllPagosRepository m4sllPagosRepository) {
        this.m4sllPagosRepository = m4sllPagosRepository;
    }

    @PostMapping("/m4sll_pagos")
    public ResponseEntity<List<M4sllPagos>> createM4sllPagos(@RequestBody List<M4sllPagos> listM4sllPagos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_pagos : {}", listM4sllPagos);
        List<M4sllPagos>result =  m4sllPagosServices.saveAllWithSecuencia(listM4sllPagos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pagos/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_pagos")
    public ResponseEntity<List<M4sllPagos>> updateM4sllPagos(@RequestBody List<M4sllPagos> listM4sllPagos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pagos : {}", listM4sllPagos);
        List<M4sllPagos> result = m4sllPagosRepository.saveAll(listM4sllPagos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pagos/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_pagos")
    public ResponseEntity<List<M4sllPagos>> getAllM4sllPagos() {
        log.debug("REST request to get ALL M4sllPagos : {}");

        List<M4sllPagos> M4sllPagosAll = m4sllPagosRepository.findAll();
        return ResponseEntity.ok().body(M4sllPagosAll);
    }

    @GetMapping("/m4sll_pagos/{lit_id_litigio}")
    public ResponseEntity<List<M4sllPagos>> getM4sllPagos(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllPagos : {}", idOrganization + "|" + litIdLitigio);

        List<M4sllPagos> M4sllPagosByInput = m4sllPagosRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);
        return ResponseEntity.ok().body(M4sllPagosByInput);
    }



    @DeleteMapping("/m4sll_pagos/{lit_id_litigio}/{pag_secuencia}")
    public ResponseEntity<Void> deleteM4sllPagos(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("pag_secuencia") Long pagSecuencia) {
        log.debug("REST request to delete m4sll_pagos : {}", idOrganization + "|" + litIdLitigio + "|" + pagSecuencia);
        M4sllPagosId id = new M4sllPagosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setPagSecuencia(pagSecuencia);

        m4sllPagosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_pagos")
  public ResponseEntity<M4sllPagos> createM4sllPagos(@RequestBody M4sllPagos m4sllPagos)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_pagos : {}", m4sllPagos);
    M4sllPagosId id = new M4sllPagosId();
    M4sllPagosServices m4sllPagosServices = new M4sllPagosServices(m4sllPagosRepository);
    Long id_pagSecuencia = m4sllPagosServices.UltimaSecuencia(m4sllPagos);

    id.setPagSecuencia(id_pagSecuencia);
    id.setIdOrganization(idOrganization);
id.setLitIdLitigio(m4sllPagos.getId().getLitIdLitigio());

    m4sllPagos.setId(id);
    M4sllPagos result = m4sllPagosRepository.save(m4sllPagos);
    return ResponseEntity
      .created(new URI("/api/m4sll_pagos/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_pagos/{lit_id_litigio}/{pag_secuencia}")
  public ResponseEntity<M4sllPagos> getM4sllPagos(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("pag_secuencia") Long pagSecuencia) {
      log.debug("REST request to get M4sllPagos : {}", idOrganization + "|" + litIdLitigio + "|" + pagSecuencia);
      M4sllPagosId id = new M4sllPagosId();
      id.setIdOrganization(idOrganization);
id.setLitIdLitigio(litIdLitigio);
      id.setPagSecuencia(pagSecuencia);

      Optional<M4sllPagos> m4sllPagos = m4sllPagosRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllPagos);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_pagos/{lit_id_litigio}")
  public ResponseEntity<Void> deleteM4sllPagos(@PathVariable("lit_id_litigio") String litIdLitigio) {
    log.debug("REST request to delete m4sll_pagos : {}", idOrganization + "|" + litIdLitigio);
    List<M4sllPagos> M4sllPagosByInput = m4sllPagosRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);

    m4sllPagosRepository.deleteAll(M4sllPagosByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllPagosByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_pagos")
public ResponseEntity<M4sllPagos> updateM4sllPagos(@RequestBody M4sllPagos m4sllPagos)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_pagos : {}", m4sllPagos);
  if (m4sllPagos.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllPagos result = m4sllPagosRepository.save(m4sllPagos);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllPagos.getId().toString()))
    .body(result);
}


*/
