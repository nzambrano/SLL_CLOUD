package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllEstudioJur;
import com.prosegur.sllpe.domain.M4sllEstudioJurId;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;
import com.prosegur.sllpe.service.secuencias.EstudioJurServices;
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

public class M4sllEstudioJurResource {

    private final Logger log = LoggerFactory.getLogger(M4sllEstudioJurResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllEstudioJur";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllEstudioJurRepository M4sllEstudioJurRepository;

    public M4sllEstudioJurResource(M4sllEstudioJurRepository M4sllEstudioJurRepository) {
        this.M4sllEstudioJurRepository = M4sllEstudioJurRepository;
    }

    /* Select en la BD */
    @GetMapping("/m4sll_estudio_jur")
    public ResponseEntity<List<M4sllEstudioJur>> getAllM4sllEstudioJur(
    ) {
        log.debug("REST request to get ALL M4sllEstudioJur : {}");

        List<M4sllEstudioJur> M4sllEstudioJurAll = M4sllEstudioJurRepository.findAll();
        return ResponseEntity.ok().body(M4sllEstudioJurAll);
    }

    /* Update en la BD */
    @PutMapping("/m4sll_estudio_jur")
    public ResponseEntity<M4sllEstudioJur> M4sllEstudioJur(@RequestBody M4sllEstudioJur m4sll_estudio_jur)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_estudio_jur : {}", m4sll_estudio_jur);
        if (m4sll_estudio_jur.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllEstudioJur result = M4sllEstudioJurRepository.save(m4sll_estudio_jur);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sll_estudio_jur.getId().toString())).body(result);
    }
    

    /* Delete en la BD */
    
    @DeleteMapping("/m4sll_estudio_jur/{id_idOrganization}/{eju_id_est_juridico}")
    public ResponseEntity<Void> deleteM4sllEstudioJur(
            @PathVariable("id_idOrganization") String id_idOrganization,
            @PathVariable("eju_id_est_juridico") Long eju_id_est_juridico) {
        log.debug("REST request to delete m4sll_estudio_jur : {} | {}",id_idOrganization,eju_id_est_juridico);
        M4sllEstudioJurId id = new M4sllEstudioJurId();
        id.setIdOrganization(id_idOrganization);
        id.setEjuIdEstJuridico(eju_id_est_juridico);
        
        M4sllEstudioJurRepository.deleteById(id);
        return ResponseEntity.noContent()
                .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
                .build();
    }

     /* Insert en la BD */
     @PostMapping("/m4sll_estudio_jur") 
     public ResponseEntity<M4sllEstudioJur> createM4sllEstudioJur(@RequestBody M4sllEstudioJur m4sll_estudio_jur)
             throws URISyntaxException {
 
         log.debug("REST request to create m4sll_estudio_jur : {}", m4sll_estudio_jur);
         
         M4sllEstudioJurId id = new M4sllEstudioJurId();
         
         EstudioJurServices estudiojurServices = new EstudioJurServices(M4sllEstudioJurRepository);
         
         Long eju_id_est_juridico = estudiojurServices.UltimaSecuencia(m4sll_estudio_jur);
         
         id.setIdOrganization(m4sll_estudio_jur.getId().getIdOrganization());
         id.setEjuIdEstJuridico(eju_id_est_juridico);
         
         m4sll_estudio_jur.setId(id);
 
         M4sllEstudioJur result = M4sllEstudioJurRepository.save(m4sll_estudio_jur);
         return ResponseEntity
                 .created(new URI("/api/m4sll_estudio_jur/" + result.getId())).headers(HeaderUtil
                         .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                 .body(result);
     }
    
}