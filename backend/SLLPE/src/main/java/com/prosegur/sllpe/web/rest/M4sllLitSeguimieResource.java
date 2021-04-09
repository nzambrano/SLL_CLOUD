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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sllpe")
@Transactional
public class M4sllLitSeguimieResource {

    private final Logger log = LoggerFactory.getLogger(M4sllLitSeguimieResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllLitSeguimie";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllLitSeguimieRepository m4sllLitSeguimieRepository;

    public M4sllLitSeguimieResource(M4sllLitSeguimieRepository m4sllLitSeguimieRepository) {
        this.m4sllLitSeguimieRepository = m4sllLitSeguimieRepository;
    }

    @PostMapping("/m4sll_lit_seguimie")
    public ResponseEntity<M4sllLitSeguimie> createM4sllLitSeguimie(@RequestBody M4sllLitSeguimie m4sll_lit_seguimie)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_lit_seguimie : {}", m4sll_lit_seguimie);
        M4sllLitSeguimieId id = new M4sllLitSeguimieId();
        M4sllLitSeguimieServices m4sllLitSeguimieServices = new M4sllLitSeguimieServices(m4sllLitSeguimieRepository);
        Long id_lis_secuencia = m4sllLitSeguimieServices.UltimaSecuencia(m4sll_lit_seguimie);

        id.setLisSecuencia(id_lis_secuencia);
        id.setLitIdLitigio(m4sll_lit_seguimie.getId().getLitIdLitigio());
        id.setIdOrganization(m4sll_lit_seguimie.getId().getIdOrganization());

        m4sll_lit_seguimie.setId(id);
        M4sllLitSeguimie result = m4sllLitSeguimieRepository.save(m4sll_lit_seguimie);
        return ResponseEntity
               .created(new URI("/api/m4sll_lit_seguimie/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_lit_seguimie")
    public ResponseEntity<M4sllLitSeguimie> updateM4sllLitSeguimie(@RequestBody M4sllLitSeguimie m4sll_lit_seguimie)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_lit_seguimie : {}", m4sll_lit_seguimie);
        if (m4sll_lit_seguimie.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllLitSeguimie result = m4sllLitSeguimieRepository.save(m4sll_lit_seguimie);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_lit_seguimie.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_lit_seguimie")
    public ResponseEntity<List<M4sllLitSeguimie>> getAllM4sllLitSeguimie() {
        log.debug("REST request to get ALL M4sllLitSeguimie : {}");

        List<M4sllLitSeguimie> M4sllLitSeguimieAll = m4sllLitSeguimieRepository.findAll();
        return ResponseEntity.ok().body(M4sllLitSeguimieAll);
    }

    @GetMapping("/m4sll_lit_seguimie/{lit_id_litigio}/{id_organization}")
    public ResponseEntity<List<M4sllLitSeguimie>> getM4sllLitSeguimie(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllLitSeguimie : {}", lit_id_litigio + "|" + id_organization);

        List<M4sllLitSeguimie> M4sllLitSeguimieByInput = m4sllLitSeguimieRepository.findByLitIdLitigioIdOrganization(lit_id_litigio, id_organization);
        return ResponseEntity.ok().body(M4sllLitSeguimieByInput);
    }

    @GetMapping("/m4sll_lit_seguimie/{lit_id_litigio}")
    public ResponseEntity<List<M4sllLitSeguimie>> getM4sllLitSeguimie(@PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllLitSeguimie : {}", lit_id_litigio);

        List<M4sllLitSeguimie> M4sllLitSeguimieByInput = m4sllLitSeguimieRepository.findByLitIdLitigio(lit_id_litigio);
        return ResponseEntity.ok().body(M4sllLitSeguimieByInput);
    }

    /*
      @GetMapping("/m4sll_lit_seguimie/{lit_id_litigio}/{id_organization}/{lis_secuencia}")
      public ResponseEntity<M4sllLitSeguimie> getM4sllLitSeguimie(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization, @PathVariable("lis_secuencia") Long lis_secuencia) {
          log.debug("REST request to get M4sllLitSeguimie : {}", lit_id_litigio + "|" + id_organization + "|" + lis_secuencia);
          M4sllLitSeguimieId id = new M4sllLitSeguimieId();
          id.setLitIdLitigio(lit_id_litigio); id.setIdOrganization(id_organization);
          id.setLisSecuencia(lis_secuencia);

          Optional<M4sllLitSeguimie> m4sll_lit_seguimie = m4sllLitSeguimieRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_lit_seguimie);
      }

      @DeleteMapping("/m4sll_lit_seguimie/{lit_id_litigio}/{id_organization}")
      public ResponseEntity<Void> deleteM4sllLitSeguimie(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_lit_seguimie : {}", lit_id_litigio + "|" + id_organization);
        List<M4sllLitSeguimie> M4sllLitSeguimieByInput = m4sllLitSeguimieRepository.findByLitIdLitigioIdOrganization(lit_id_litigio, id_organization);

        m4sllLitSeguimieRepository.deleteAll(M4sllLitSeguimieByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllLitSeguimieByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_lit_seguimie/{lit_id_litigio}/{id_organization}/{lis_secuencia}")
    public ResponseEntity<Void> deleteM4sllLitSeguimie(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization, @PathVariable("lis_secuencia") Long lis_secuencia) {
        log.debug("REST request to delete m4sll_lit_seguimie : {}", lit_id_litigio + "|" + id_organization + "|" + lis_secuencia);
        M4sllLitSeguimieId id = new M4sllLitSeguimieId();
        id.setLitIdLitigio(lit_id_litigio);
        id.setIdOrganization(id_organization);
        id.setLisSecuencia(lis_secuencia);

        m4sllLitSeguimieRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
