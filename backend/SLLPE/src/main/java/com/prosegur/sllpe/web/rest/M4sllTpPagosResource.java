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

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpPagosRepository m4sllTpPagosRepository;

    public M4sllTpPagosResource(M4sllTpPagosRepository m4sllTpPagosRepository) {
        this.m4sllTpPagosRepository = m4sllTpPagosRepository;
    }

    @PostMapping("/m4sll_tp_pagos")
    public ResponseEntity<M4sllTpPagos> createM4sllTpPagos(@RequestBody M4sllTpPagos m4sll_tp_pagos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_pagos : {}", m4sll_tp_pagos);
        M4sllTpPagosId id = new M4sllTpPagosId();
        M4sllTpPagosServices m4sllTpPagosServices = new M4sllTpPagosServices(m4sllTpPagosRepository);
        String id_tpa_id_pago = m4sllTpPagosServices.UltimaSecuencia(m4sll_tp_pagos);

        id.setTpaIdPago(id_tpa_id_pago);
        id.setIdOrganization(m4sll_tp_pagos.getId().getIdOrganization());

        m4sll_tp_pagos.setId(id);
        M4sllTpPagos result = m4sllTpPagosRepository.save(m4sll_tp_pagos);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_pagos/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_pagos")
    public ResponseEntity<M4sllTpPagos> updateM4sllTpPagos(@RequestBody M4sllTpPagos m4sll_tp_pagos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_pagos : {}", m4sll_tp_pagos);
        if (m4sll_tp_pagos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpPagos result = m4sllTpPagosRepository.save(m4sll_tp_pagos);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_pagos.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_pagos")
    public ResponseEntity<List<M4sllTpPagos>> getAllM4sllTpPagos() {
        log.debug("REST request to get ALL M4sllTpPagos : {}");

        List<M4sllTpPagos> M4sllTpPagosAll = m4sllTpPagosRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpPagosAll);
    }

    @GetMapping("/m4sll_tp_pagos/{id_organization}")
    public ResponseEntity<List<M4sllTpPagos>> getM4sllTpPagos(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpPagos : {}", id_organization);

        List<M4sllTpPagos> M4sllTpPagosByInput = m4sllTpPagosRepository.findM4sllTpPagosByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpPagosByInput);
    }


    /*
      @GetMapping("/m4sll_tp_pagos/{id_organization}/{tpa_id_pago}")
      public ResponseEntity<M4sllTpPagos> getM4sllTpPagos(@PathVariable("id_organization") String id_organization, @PathVariable("tpa_id_pago") String tpa_id_pago) {
          log.debug("REST request to get M4sllTpPagos : {}", id_organization + "|" + tpa_id_pago);
          M4sllTpPagosId id = new M4sllTpPagosId();
          id.setIdOrganization(id_organization);
          id.setTpaIdPago(tpa_id_pago);

          Optional<M4sllTpPagos> m4sll_tp_pagos = m4sllTpPagosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_pagos);
      }

      @DeleteMapping("/m4sll_tp_pagos/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpPagos(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_pagos : {}", id_organization);
        List<M4sllTpPagos> M4sllTpPagosByInput = m4sllTpPagosRepository.findM4sllTpPagosByIdOrganization(id_organization);

        m4sllTpPagosRepository.deleteAll(M4sllTpPagosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpPagosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_pagos/{id_organization}/{tpa_id_pago}")
    public ResponseEntity<Void> deleteM4sllTpPagos(@PathVariable("id_organization") String id_organization, @PathVariable("tpa_id_pago") String tpa_id_pago) {
        log.debug("REST request to delete m4sll_tp_pagos : {}", id_organization + "|" + tpa_id_pago);
        M4sllTpPagosId id = new M4sllTpPagosId();
        id.setIdOrganization(id_organization);
        id.setTpaIdPago(tpa_id_pago);

        m4sllTpPagosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
