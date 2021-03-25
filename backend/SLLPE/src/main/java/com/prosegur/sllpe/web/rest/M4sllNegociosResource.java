package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.domain.M4sllNegociosId;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;
import com.prosegur.sllpe.service.NegocioServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
// import io.github.jhipster.web.util.PaginationUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
// import org.springframework.data.domain.Page;
// import org.springframework.data.domain.Pageable;
// import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
// import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional

public class M4sllNegociosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllNegociosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllNegocios";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllNegociosRepository M4sllNegociosRepository;

    public M4sllNegociosResource(M4sllNegociosRepository M4sllNegociosRepository) {
        this.M4sllNegociosRepository = M4sllNegociosRepository;
    }

    /* Select en la BD */
    @GetMapping("/m4sll_negocios/{id_organization}")
    public ResponseEntity<List<M4sllNegocios>> getAllM4sllNegocios(
    		@PathVariable("id_organization") String idOrganization
    ) {
        log.debug("REST request to get ALL M4sllNegocios : {}");

        List<M4sllNegocios> M4sllNegociosAll = M4sllNegociosRepository.findNegocioByPais(idOrganization);
        return ResponseEntity.ok().body(M4sllNegociosAll);
    }

    /* Update en la BD */
    @PutMapping("/m4sll_negocios")
    public ResponseEntity<M4sllNegocios> M4sllNegocios(@RequestBody M4sllNegocios m4sll_negocios)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_negocios : {}", m4sll_negocios);
        if (m4sll_negocios.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllNegocios result = M4sllNegociosRepository.save(m4sll_negocios);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sll_negocios.getId().toString())).body(result);
    }

    /* Delete en la BD */
    
    @DeleteMapping("/m4sll_negocios/{id_idOrganization}/{neg_idNegocio}")
    public ResponseEntity<Void> deleteM4sllNegocios(
            @PathVariable("id_idOrganization") String id_idOrganization,
            @PathVariable("neg_idNegocio") String neg_idNegocio) {
        log.debug("REST request to delete m4sll_negocios : {} | {}",id_idOrganization,neg_idNegocio);
        M4sllNegociosId id = new M4sllNegociosId();
        id.setIdOrganization(id_idOrganization);
        id.setNegIdNegocio(neg_idNegocio);
        
        M4sllNegociosRepository.deleteById(id);
        return ResponseEntity.noContent()
                .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
                .build();
    }

     /* Insert en la BD */
     @PostMapping("/m4sll_negocios")
     public ResponseEntity<M4sllNegocios> createM4sllNegocios(@RequestBody M4sllNegocios m4sll_negocios)
             throws URISyntaxException {
 
         log.debug("REST request to create m4sll_mt_abogados : {}", m4sll_negocios);
         
         M4sllNegociosId id = new M4sllNegociosId();
         
         NegocioServices negocioServices = new NegocioServices(M4sllNegociosRepository);
         String neg_id_negocio = negocioServices.UltimaSecuencia(m4sll_negocios).toString();
         
         id.setIdOrganization(m4sll_negocios.getId().getIdOrganization());
         id.setNegIdNegocio(neg_id_negocio);
         
         m4sll_negocios.setId(id);
 
         M4sllNegocios result = M4sllNegociosRepository.save(m4sll_negocios);
         return ResponseEntity
                 .created(new URI("/api/m4sll_negocios/" + result.getId())).headers(HeaderUtil
                         .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                 .body(result);
     }
}