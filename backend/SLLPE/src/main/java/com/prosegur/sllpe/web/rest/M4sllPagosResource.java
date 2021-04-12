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

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllPagosRepository m4sllPagosRepository;

    public M4sllPagosResource(M4sllPagosRepository m4sllPagosRepository) {
        this.m4sllPagosRepository = m4sllPagosRepository;
    }

    @PostMapping("/m4sll_pagos")
    public ResponseEntity<M4sllPagos> createM4sllPagos(@RequestBody M4sllPagos m4sll_pagos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_pagos : {}", m4sll_pagos);
        M4sllPagosId id = new M4sllPagosId();
        M4sllPagosServices m4sllPagosServices = new M4sllPagosServices(m4sllPagosRepository);
        Long id_pag_secuencia = m4sllPagosServices.UltimaSecuencia(m4sll_pagos);

        id.setPagSecuencia(id_pag_secuencia);
        id.setLitIdLitigio(m4sll_pagos.getId().getLitIdLitigio());
        id.setIdOrganization(m4sll_pagos.getId().getIdOrganization());

        m4sll_pagos.setId(id);
        M4sllPagos result = m4sllPagosRepository.save(m4sll_pagos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pagos/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_pagos")
    public ResponseEntity<M4sllPagos> updateM4sllPagos(@RequestBody M4sllPagos m4sll_pagos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pagos : {}", m4sll_pagos);
        if (m4sll_pagos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllPagos result = m4sllPagosRepository.save(m4sll_pagos);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_pagos.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_pagos")
    public ResponseEntity<List<M4sllPagos>> getAllM4sllPagos() {
        log.debug("REST request to get ALL M4sllPagos : {}");

        List<M4sllPagos> M4sllPagosAll = m4sllPagosRepository.findAll();
        return ResponseEntity.ok().body(M4sllPagosAll);
    }

    @GetMapping("/m4sll_pagos/{lit_id_litigio}/{id_organization}")
    public ResponseEntity<List<M4sllPagos>> getM4sllPagos(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllPagos : {}", lit_id_litigio + "|" + id_organization);

        List<M4sllPagos> M4sllPagosByInput = m4sllPagosRepository.findByLitIdLitigioIdOrganization(lit_id_litigio, id_organization);
        return ResponseEntity.ok().body(M4sllPagosByInput);
    }


    /*
      @GetMapping("/m4sll_pagos/{lit_id_litigio}/{id_organization}/{pag_secuencia}")
      public ResponseEntity<M4sllPagos> getM4sllPagos(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization, @PathVariable("pag_secuencia") Long pag_secuencia) {
          log.debug("REST request to get M4sllPagos : {}", lit_id_litigio + "|" + id_organization + "|" + pag_secuencia);
          M4sllPagosId id = new M4sllPagosId();
          id.setLitIdLitigio(lit_id_litigio); id.setIdOrganization(id_organization);
          id.setPagSecuencia(pag_secuencia);

          Optional<M4sllPagos> m4sll_pagos = m4sllPagosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_pagos);
      }

      @DeleteMapping("/m4sll_pagos/{lit_id_litigio}/{id_organization}")
      public ResponseEntity<Void> deleteM4sllPagos(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_pagos : {}", lit_id_litigio + "|" + id_organization);
        List<M4sllPagos> M4sllPagosByInput = m4sllPagosRepository.findByLitIdLitigioIdOrganization(lit_id_litigio, id_organization);

        m4sllPagosRepository.deleteAll(M4sllPagosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllPagosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_pagos/{lit_id_litigio}/{id_organization}/{pag_secuencia}")
    public ResponseEntity<Void> deleteM4sllPagos(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization, @PathVariable("pag_secuencia") Long pag_secuencia) {
        log.debug("REST request to delete m4sll_pagos : {}", lit_id_litigio + "|" + id_organization + "|" + pag_secuencia);
        M4sllPagosId id = new M4sllPagosId();
        id.setLitIdLitigio(lit_id_litigio);
        id.setIdOrganization(id_organization);
        id.setPagSecuencia(pag_secuencia);

        m4sllPagosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
