package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import com.prosegur.sllpe.domain.M4sllPedidosId;
import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import com.prosegur.sllpe.repository.M4sllFasesRepository;
import com.prosegur.sllpe.service.M4sllAutorReuServices;
import com.prosegur.sllpe.service.secuencias.FasesServices;

import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional

public class M4sllFasesResource {
	String idOrganization = "0050";
    private final Logger log = LoggerFactory.getLogger(M4sllFasesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllFases";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllFasesRepository m4sllfasesRepository;

    public M4sllFasesResource(M4sllFasesRepository m4sllFasesRepository) {
        this.m4sllfasesRepository = m4sllFasesRepository;
    }

    @PostMapping("/m4sll_fases")
    public ResponseEntity<List<M4sllFases>> createM4sllFases(@RequestBody List<M4sllFases> listFases)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_fases : {}", listFases); 
        FasesServices faseServices = new FasesServices(m4sllfasesRepository); 
        // faseServices.saveAllWithSecuencia(listFases);
        m4sllfasesRepository.saveAll(listFases);
        List<M4sllFases> result = listFases;
        return ResponseEntity
               .created(new URI("/api/m4sll_fases/" )).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, ""))
               .body(result);
    }

    @PutMapping("/m4sll_fases")
    public ResponseEntity<M4sllFases> updateM4sllFases(@RequestBody M4sllFases m4sll_fases)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_fases : {}", m4sll_fases);
        if (m4sll_fases.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllFases result = m4sllfasesRepository.save(m4sll_fases);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_fases.getId().toString())).body(result);
    }

    /*
     @GetMapping("/m4sll_fases")
     public ResponseEntity<List<M4sllFases>> getAllM4sllFases() {
         log.debug("REST request to get ALL M4sllFases : {}");

         List<M4sllFases> M4sllFasesAll = m4sllfasesRepository.findAll();
         return ResponseEntity.ok().body(M4sllFasesAll);
     }
     */

    @GetMapping("/m4sll_fases/{LIT_ID_LITIGIO}")
    public ResponseEntity<List<M4sllFases>> getAutoresByLitigio(
        // @PathVariable("ID_ORGANIZATION") String ID_ORGANIZATION,
        @PathVariable("LIT_ID_LITIGIO") String litIdLitigio

    ) {
        log.debug("REST request to get ALL M4sllFases : {}");

        List<M4sllFases> M4sllFasesAll = m4sllfasesRepository.getFases(
        		idOrganization,
        		litIdLitigio
                                         );
        return ResponseEntity.ok().body(M4sllFasesAll);
    }

    /*
    @GetMapping("/m4sll_fases/{ID_ORGANIZATION}/{LIT_ID_LITIGIO}/{aur_secuencia}")
    public ResponseEntity<M4sllFases> getM4sllFases(
    		@PathVariable("ID_ORGANIZATION") String idOrganization,
    		@PathVariable("LIT_ID_LITIGIO") String litIdLitigio,
    		@PathVariable("aur_secuencia") Integer aurSecuencia
            ) {
        log.debug("REST request to get m4sll_fases : {} | {}", litIdLitigio, idOrganization, aurSecuencia );
        M4sllFasesId id = new M4sllFasesId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setAurSecuencia(aurSecuencia);

        Optional<M4sllFases> m4sll_fases = m4sllFasesRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_fases);
    }
    */

    @DeleteMapping("/m4sll_fases/{LIT_ID_LITIGIO}/{TFA_ID_TP_FASE}")
    public ResponseEntity<Void> deleteM4sllFases(
        // @PathVariable("ID_ORGANIZATION") String idOrganization,
        @PathVariable("LIT_ID_LITIGIO") String litIdLitigio,
        @PathVariable("TFA_ID_TP_FASE") String  tfaIdTpFase
    ) {
        log.debug("REST request to delete m4sll_fases : {} | {}", litIdLitigio, idOrganization, tfaIdTpFase );
        /* antes pensando en que posiblemente fas_secuencia pase a ser primary key
        M4sllFasesId id = new M4sllFasesId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        M4sllFases fase = m4sllfasesRepository.getFaseFasSecuencia(idOrganization, litIdLitigio, fasSecuencia);
        m4sllfasesRepository.delete(fase);
        */
        // m4sllfasesRepository.setFasSecuencia(fasSecuencia);
        M4sllFasesId id = new M4sllFasesId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setTfaIdTpFase(tfaIdTpFase);
                
        m4sllfasesRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}