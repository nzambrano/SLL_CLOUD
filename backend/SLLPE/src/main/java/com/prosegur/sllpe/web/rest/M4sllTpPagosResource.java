package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpPagos;
import com.prosegur.sllpe.domain.M4sllTpPagosId;
import com.prosegur.sllpe.repository.M4sllTpPagosRepository;
import com.prosegur.sllpe.service.M4sllTpPagosServices;
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
public class M4sllTpPagosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpPagosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpPagos";

    @Autowired
    M4sllTpPagosServices m4sllTpPagosServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpPagosRepository m4sllTpPagosRepository;

    public M4sllTpPagosResource(M4sllTpPagosRepository m4sllTpPagosRepository) {
        this.m4sllTpPagosRepository = m4sllTpPagosRepository;
    }

    @PostMapping("/m4sll_tp_pagos")
    public ResponseEntity<List<M4sllTpPagos>> createM4sllTpPagos(@RequestBody List<M4sllTpPagos> listM4sllTpPagos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_pagos : {}", listM4sllTpPagos);
        List<M4sllTpPagos>result =  m4sllTpPagosServices.saveAllWithSecuencia(listM4sllTpPagos);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_pagos/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_pagos")
    public ResponseEntity<List<M4sllTpPagos>> updateM4sllTpPagos(@RequestBody List<M4sllTpPagos> listM4sllTpPagos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_pagos : {}", listM4sllTpPagos);
        List<M4sllTpPagos> result = m4sllTpPagosRepository.saveAll(listM4sllTpPagos);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_pagos/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_pagos")
        public ResponseEntity<List<M4sllTpPagos>> getAllM4sllTpPagos() {
          log.debug("REST request to get ALL M4sllTpPagos : {}");

          List<M4sllTpPagos> M4sllTpPagosAll = m4sllTpPagosRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpPagosAll);
        }
    */

    @GetMapping("/m4sll_tp_pagos")
    public ResponseEntity<List<M4sllTpPagos>> getM4sllTpPagos() {
        log.debug("REST request to get M4sllTpPagos : {}", idOrganization);

        List<M4sllTpPagos> M4sllTpPagosByInput = m4sllTpPagosRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpPagosByInput);
    }


    @DeleteMapping("/m4sll_tp_pagos/{tpa_id_pago}")
    public ResponseEntity<Void> deleteM4sllTpPagos(@PathVariable("tpa_id_pago") String tpaIdPago) {
        log.debug("REST request to delete m4sll_tp_pagos : {}", idOrganization + "|" + tpaIdPago);
        M4sllTpPagosId id = new M4sllTpPagosId();
        id.setIdOrganization(idOrganization);
        id.setTpaIdPago(tpaIdPago);

        m4sllTpPagosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_pagos")
  public ResponseEntity<M4sllTpPagos> createM4sllTpPagos(@RequestBody M4sllTpPagos m4sllTpPagos)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_pagos : {}", m4sllTpPagos);
    M4sllTpPagosId id = new M4sllTpPagosId();
    M4sllTpPagosServices m4sllTpPagosServices = new M4sllTpPagosServices(m4sllTpPagosRepository);
    String id_tpaIdPago = m4sllTpPagosServices.UltimaSecuencia(m4sllTpPagos);

    id.setTpaIdPago(id_tpaIdPago);
    id.setIdOrganization(idOrganization);

    m4sllTpPagos.setId(id);
    M4sllTpPagos result = m4sllTpPagosRepository.save(m4sllTpPagos);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_pagos/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_pagos/{tpa_id_pago}")
  public ResponseEntity<M4sllTpPagos> getM4sllTpPagos(@PathVariable("tpa_id_pago") String tpaIdPago) {
      log.debug("REST request to get M4sllTpPagos : {}", idOrganization + "|" + tpaIdPago);
      M4sllTpPagosId id = new M4sllTpPagosId();
      id.setIdOrganization(idOrganization);
      id.setTpaIdPago(tpaIdPago);

      Optional<M4sllTpPagos> m4sllTpPagos = m4sllTpPagosRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpPagos);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_pagos")
  public ResponseEntity<Void> deleteM4sllTpPagos() {
    log.debug("REST request to delete m4sll_tp_pagos : {}", idOrganization);
    List<M4sllTpPagos> M4sllTpPagosByInput = m4sllTpPagosRepository.findByIdOrganization(idOrganization);

    m4sllTpPagosRepository.deleteAll(M4sllTpPagosByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpPagosByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_pagos")
public ResponseEntity<M4sllTpPagos> updateM4sllTpPagos(@RequestBody M4sllTpPagos m4sllTpPagos)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_pagos : {}", m4sllTpPagos);
  if (m4sllTpPagos.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpPagos result = m4sllTpPagosRepository.save(m4sllTpPagos);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpPagos.getId().toString()))
    .body(result);
}


*/
