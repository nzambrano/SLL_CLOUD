package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllAutorReu;
import com.prosegur.sllpe.domain.M4sllAutorReuId;
import com.prosegur.sllpe.domain.SllVwAutorReu;
import com.prosegur.sllpe.repository.M4sllAutorReuRepository;
import com.prosegur.sllpe.repository.SllVwAutorReuRepository;
import com.prosegur.sllpe.service.M4sllAutorReuServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/api")
@Transactional

public class M4sllAutorReuResource {

    private final Logger log = LoggerFactory.getLogger(M4sllAutorReuResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllAutorReu";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllAutorReuRepository m4sllAutorReuRepository;
    private SllVwAutorReuRepository sllVwAutorReuRepository;

    public M4sllAutorReuResource(M4sllAutorReuRepository m4sllAutorReuRepository, SllVwAutorReuRepository sllVwAutorReuRepository) {
        this.m4sllAutorReuRepository = m4sllAutorReuRepository;
        this.sllVwAutorReuRepository = sllVwAutorReuRepository;
    }

    @PostMapping("/m4sll_autor_reu")
    public ResponseEntity<M4sllAutorReu> createM4sllAutorReu(@RequestBody M4sllAutorReu m4sll_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_autor_reu : {}", m4sll_autor_reu);
        M4sllAutorReuId id = new M4sllAutorReuId();
        M4sllAutorReuServices autorReuServices = new M4sllAutorReuServices(m4sllAutorReuRepository);
        Long id_aurSecuencia = autorReuServices.UltimaSecuencia(m4sll_autor_reu);

        id.setAurSecuencia(id_aurSecuencia);
        id.setLitIdLitigio(m4sll_autor_reu.getId().getLitIdLitigio());
        id.setIdOrganization(m4sll_autor_reu.getId().getIdOrganization());

        m4sll_autor_reu.setId(id);
        M4sllAutorReu result = m4sllAutorReuRepository.save(m4sll_autor_reu);
        return ResponseEntity
               .created(new URI("/api/m4sll_autor_reu/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_autor_reu")
    public ResponseEntity<M4sllAutorReu> updateM4sllAutorReu(@RequestBody M4sllAutorReu m4sll_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_autor_reu : {}", m4sll_autor_reu);
        if (m4sll_autor_reu.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllAutorReu result = m4sllAutorReuRepository.save(m4sll_autor_reu);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_autor_reu.getId().toString())).body(result);
    }

    @GetMapping("/m4sll_autor_reu")
    public ResponseEntity<List<M4sllAutorReu>> getAllM4sllAutorReu() {
        log.debug("REST request to get ALL M4sllAutorReu : {}");

        List<M4sllAutorReu> M4sllAutorReuAll = m4sllAutorReuRepository.findAll();
        return ResponseEntity.ok().body(M4sllAutorReuAll);
    }

    @GetMapping("/m4sll_autor_reu/{id_organization}/{lit_id_litigio}/{aur_autor_reu}")
    public ResponseEntity<List<M4sllAutorReu>> getAutoresByLitigio(
        @PathVariable("id_organization") String id_organization,
        @PathVariable("lit_id_litigio") String lit_id_litigio,
        @PathVariable("aur_autor_reu") String aur_autor_reu

    ) {
        log.debug("REST request to get ALL M4sllAutorReu : {}");

        List<M4sllAutorReu> M4sllAutorReuAll = m4sllAutorReuRepository.findAutorReuByLitigio(
                id_organization,
                lit_id_litigio,
                aur_autor_reu

                                               );
        return ResponseEntity.ok().body(M4sllAutorReuAll);
    }

    @GetMapping("/sll_autor_reu/{lit_id_litigio}")
    public ResponseEntity<List<SllVwAutorReu>> getVwAutoresByLitigio(
        @PathVariable("lit_id_litigio") String lit_id_litigio

    ) {
        log.debug("REST request to get ALL M4sllAutorReu : {}");

        List<SllVwAutorReu> SllvWAutorReuAll = sllVwAutorReuRepository.findAllVwAutorReuByLitigio(
                lit_id_litigio
                                               );
        return ResponseEntity.ok().body(SllvWAutorReuAll);
    }

    /*
    @GetMapping("/m4sll_autor_reu/{id_organization}/{lit_id_litigio}/{aur_secuencia}")
    public ResponseEntity<M4sllAutorReu> getM4sllAutorReu(
    		@PathVariable("id_organization") String idOrganization,
    		@PathVariable("lit_id_litigio") String litIdLitigio,
    		@PathVariable("aur_secuencia") Integer aurSecuencia
            ) {
        log.debug("REST request to get m4sll_autor_reu : {} | {}", litIdLitigio, idOrganization, aurSecuencia );
        M4sllAutorReuId id = new M4sllAutorReuId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setAurSecuencia(aurSecuencia);

        Optional<M4sllAutorReu> m4sll_autor_reu = m4sllAutorReuRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_autor_reu);
    }
    */

    @DeleteMapping("/m4sll_autor_reu/{id_organization}/{lit_id_litigio}/{aur_secuencia}")
    public ResponseEntity<Void> deleteM4sllAutorReu(
        @PathVariable("id_organization") String idOrganization,
        @PathVariable("lit_id_litigio") String litIdLitigio,
        @PathVariable("aur_secuencia") Integer  aurSecuencia
    ) {
        log.debug("REST request to delete m4sll_autor_reu : {} | {} | {}", litIdLitigio, idOrganization, aurSecuencia );
        M4sllAutorReuId id = new M4sllAutorReuId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setAurSecuencia(aurSecuencia);


        m4sllAutorReuRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}