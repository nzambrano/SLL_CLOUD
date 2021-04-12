package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllValEcLit;
import com.prosegur.sllpe.domain.M4sllValEcLitId;

import com.prosegur.sllpe.repository.M4sllProvisionesRepository;
import com.prosegur.sllpe.service.secuencias.ProvisionesServices;
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

import java.util.Optional;


@RestController
@RequestMapping("/sllpe")
@Transactional

public class M4sllProvisionesResource {

    private final Logger log = LoggerFactory.getLogger(M4sllProvisionesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllValEcLit";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllProvisionesRepository m4sllProvisionesRepository;

    public M4sllProvisionesResource(M4sllProvisionesRepository m4sllProvisionesRepository) {
        this.m4sllProvisionesRepository = m4sllProvisionesRepository;
    }

    @PostMapping("/provision")
    public ResponseEntity<M4sllValEcLit> createM4sllValEcLit(@RequestBody M4sllValEcLit provision)
    throws URISyntaxException {
        log.debug("REST request to create provision : {}", provision);
        M4sllValEcLitId id = new M4sllValEcLitId();
        ProvisionesServices provisionesServices = new ProvisionesServices(m4sllProvisionesRepository);
        Long velSecuencia = provisionesServices.UltimaSecuencia(provision);

        id.setVelSecuencia(velSecuencia);
        id.setLitIdLitigio(provision.getId().getLitIdLitigio());
        id.setIdOrganization(provision.getId().getIdOrganization());

        provision.setId(id);

        M4sllValEcLit result = m4sllProvisionesRepository.save(provision);
        return ResponseEntity
               .created(new URI("/api/provision/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/provision")
    public ResponseEntity<M4sllValEcLit> updateM4sllValEcLit(@RequestBody M4sllValEcLit provision)
    throws URISyntaxException {
        log.debug("REST request to update provision : {}", provision);
        if (provision.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllValEcLit result = m4sllProvisionesRepository.save(provision);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           provision.getId().toString())).body(result);
    }

    /*@GetMapping("/provision")
    public ResponseEntity<List<M4sllValEcLit>> getAllM4sllValEcLit() {
        log.debug("REST request to get ALL M4sllValEcLit : {}");

        List<M4sllValEcLit> M4sllValEcLitAll = m4sllProvisionesRepository.findAll();
        return ResponseEntity.ok().body(M4sllValEcLitAll);
    }
    */

    @GetMapping("/provision/{ID_ORGANIZATION}/{LIT_ID_LITIGIO}/{VEL_SECUENCIA}")
    public ResponseEntity<Optional<M4sllValEcLit>> getProvicionesByLitigioByTipo(
        @PathVariable("ID_ORGANIZATION") String idOrganization,
        @PathVariable("LIT_ID_LITIGIO") String litIdLitigio,
        @PathVariable("VEL_SECUENCIA") Long velSecuencia

    ) {
        log.debug("REST request to get ALL M4sllValEcLit : {}");

        M4sllValEcLitId id = new M4sllValEcLitId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setVelSecuencia(velSecuencia);

        Optional<M4sllValEcLit> provicion = m4sllProvisionesRepository.findById(id);

        return ResponseEntity.ok().body(provicion);
    }

    /*
    @GetMapping("/provision/{id_organization}/{lit_id_litigio}/{aur_secuencia}")
    public ResponseEntity<M4sllValEcLit> getM4sllValEcLit(
    		@PathVariable("id_organization") String idOrganization,
    		@PathVariable("lit_id_litigio") String litIdLitigio,
    		@PathVariable("aur_secuencia") Integer aurSecuencia
            ) {
        log.debug("REST request to get provision : {} | {}", litIdLitigio, idOrganization, aurSecuencia );
        M4sllValEcLitId id = new M4sllValEcLitId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setAurSecuencia(aurSecuencia);

        Optional<M4sllValEcLit> provision = m4sllProvisionesRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(provision);
    }
    */

    @DeleteMapping("/provision/{ID_ORGANIZATION}/{LIT_ID_LITIGIO}/{VEL_SECUENCIA}")
    public ResponseEntity<Void> deleteM4sllValEcLit(
        @PathVariable("ID_ORGANIZATION") String idOrganization,
        @PathVariable("LIT_ID_LITIGIO") String litIdLitigio,
        @PathVariable("VEL_SECUENCIA") Long  velSecuencia
    ) {
        log.debug("REST request to delete provision : {} | {}", litIdLitigio, idOrganization, velSecuencia );
        M4sllValEcLitId id = new M4sllValEcLitId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setVelSecuencia(velSecuencia);


        m4sllProvisionesRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
