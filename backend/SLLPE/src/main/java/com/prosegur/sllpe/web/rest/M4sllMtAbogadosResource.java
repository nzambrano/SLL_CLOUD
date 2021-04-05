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

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllMtAbogadosRepository m4sllMtAbogadosRepository;

    public M4sllMtAbogadosResource(M4sllMtAbogadosRepository m4sllMtAbogadosRepository) {
        this.m4sllMtAbogadosRepository = m4sllMtAbogadosRepository;
    }

    @PostMapping("/m4sll_mt_abogados")
    public ResponseEntity<M4sllMtAbogados> createM4sllMtAbogados(@RequestBody M4sllMtAbogados m4sll_mt_abogados)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mt_abogados : {}", m4sll_mt_abogados);
        M4sllMtAbogadosId id = new M4sllMtAbogadosId();
        M4sllMtAbogadosServices m4sllMtAbogadosServices = new M4sllMtAbogadosServices(m4sllMtAbogadosRepository);
        Long id_mab_secuencia = m4sllMtAbogadosServices.UltimaSecuencia(m4sll_mt_abogados);

        id.setMabSecuencia(id_mab_secuencia);
        id.setIdOrganization(m4sll_mt_abogados.getId().getIdOrganization());

        m4sll_mt_abogados.setId(id);
        M4sllMtAbogados result = m4sllMtAbogadosRepository.save(m4sll_mt_abogados);
        return ResponseEntity
               .created(new URI("/api/m4sll_mt_abogados/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_mt_abogados")
    public ResponseEntity<M4sllMtAbogados> updateM4sllMtAbogados(@RequestBody M4sllMtAbogados m4sll_mt_abogados)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mt_abogados : {}", m4sll_mt_abogados);
        if (m4sll_mt_abogados.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllMtAbogados result = m4sllMtAbogadosRepository.save(m4sll_mt_abogados);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_mt_abogados.getId().toString()))
               .body(result);
    }

    /*
    @GetMapping("/m4sll_mt_abogados")
    public ResponseEntity<List<M4sllMtAbogados>> getAllM4sllMtAbogados() {
        log.debug("REST request to get ALL M4sllMtAbogados : {}");

        List<M4sllMtAbogados> M4sllMtAbogadosAll = m4sllMtAbogadosRepository.findAll();
        return ResponseEntity.ok().body(M4sllMtAbogadosAll);
    }*/

    @GetMapping("/m4sll_mt_abogados/{id_organization}")
    public ResponseEntity<List<M4sllMtAbogados>> getM4sllMtAbogados(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllMtAbogados : {}", id_organization);

        List<M4sllMtAbogados> M4sllMtAbogadosByInput = m4sllMtAbogadosRepository.findM4sllMtAbogadosByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllMtAbogadosByInput);
    }

    @GetMapping("/m4sll_mt_abogados/{id_organization}/{mab_secuencia}/{mab_chk_int}")
    public ResponseEntity<List<M4sllMtAbogados>> getM4sllMtAbogados(@PathVariable("id_organization") String id_organization, @PathVariable("mab_secuencia") Long mab_secuencia, @PathVariable("mab_chk_int") String mab_chk_int) {
        log.debug("REST request to get M4sllMtAbogados : {}", id_organization + "|" + mab_secuencia + "|" + mab_chk_int);

        List<M4sllMtAbogados> M4sllMtAbogadosByInput = m4sllMtAbogadosRepository.findM4sllMtAbogadosByIdOrganizationMabSecuenciaMabChkInt(id_organization, mab_secuencia, mab_chk_int);
        return ResponseEntity.ok().body(M4sllMtAbogadosByInput);
    }

    /*
      @GetMapping("/m4sll_mt_abogados/{id_organization}/{mab_secuencia}")
      public ResponseEntity<M4sllMtAbogados> getM4sllMtAbogados(@PathVariable("id_organization") String id_organization, @PathVariable("mab_secuencia") Long mab_secuencia) {
          log.debug("REST request to get M4sllMtAbogados : {}", id_organization + "|" + mab_secuencia);
          M4sllMtAbogadosId id = new M4sllMtAbogadosId();
          id.setIdOrganization(id_organization);
          id.setMabSecuencia(mab_secuencia);

          Optional<M4sllMtAbogados> m4sll_mt_abogados = m4sllMtAbogadosRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_mt_abogados);
      }

      @DeleteMapping("/m4sll_mt_abogados/{id_organization}")
      public ResponseEntity<Void> deleteM4sllMtAbogados(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_mt_abogados : {}", id_organization);
        List<M4sllMtAbogados> M4sllMtAbogadosByInput = m4sllMtAbogadosRepository.findM4sllMtAbogadosByIdOrganization(id_organization);

        m4sllMtAbogadosRepository.deleteAll(M4sllMtAbogadosByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllMtAbogadosByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_mt_abogados/{id_organization}/{mab_secuencia}")
    public ResponseEntity<Void> deleteM4sllMtAbogados(@PathVariable("id_organization") String id_organization, @PathVariable("mab_secuencia") Long mab_secuencia) {
        log.debug("REST request to delete m4sll_mt_abogados : {}", id_organization + "|" + mab_secuencia);
        M4sllMtAbogadosId id = new M4sllMtAbogadosId();
        id.setIdOrganization(id_organization);
        id.setMabSecuencia(mab_secuencia);

        m4sllMtAbogadosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
