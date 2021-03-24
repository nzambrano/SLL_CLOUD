package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllCompromisos;
import com.prosegur.sllpe.domain.M4sllCompromisosId;
import com.prosegur.sllpe.repository.M4sllCompromisosRepository;
import com.prosegur.sllpe.service.secuencias.CompromisosServices;
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

public class M4sllCompromisosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllCompromisosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllCompromisos";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllCompromisosRepository M4sllCompromisosRepository;

    public M4sllCompromisosResource(M4sllCompromisosRepository M4sllCompromisosRepository) {
        this.M4sllCompromisosRepository = M4sllCompromisosRepository;
    }

    @PostMapping("/m4sll_compromisos")
    public ResponseEntity<M4sllCompromisos> createM4sllCompromisos(@RequestBody M4sllCompromisos m4sll_compromisos)
            throws URISyntaxException {
        log.debug("REST request to create m4sll_compromisos : {}", m4sll_compromisos);
        M4sllCompromisosId id = new M4sllCompromisosId();
        CompromisosServices CompromisosServices = new CompromisosServices(M4sllCompromisosRepository);
        Long com_secuencia = CompromisosServices.UltimaSecuencia(m4sll_compromisos);
        
        id.setComSecuencia(com_secuencia);
        id.setTcoIdTpCompromiso(m4sll_compromisos.getId().getTcoIdTpCompromiso());
        id.setLitIdLitigio(m4sll_compromisos.getId().getLitIdLitigio());
        id.setIdOrganization(m4sll_compromisos.getId().getIdOrganization());
        
        m4sll_compromisos.setId(id);
        M4sllCompromisos result = M4sllCompromisosRepository.save(m4sll_compromisos);
        return ResponseEntity
                .created(new URI("/api/m4sll_compromisos/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

    @PutMapping("/m4sll_compromisos")
    public ResponseEntity<M4sllCompromisos> updateM4sllCompromisos(@RequestBody M4sllCompromisos m4sll_compromisos)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_compromisos : {}", m4sll_compromisos);
        if (m4sll_compromisos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllCompromisos result = M4sllCompromisosRepository.save(m4sll_compromisos);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sll_compromisos.getId().toString())).body(result);
    }

    /*
    @GetMapping("/m4sll_compromisos")
    public ResponseEntity<List<M4sllCompromisos>> getAllM4sllCompromisos() {
        log.debug("REST request to get ALL M4sllCompromisos : {}");

        List<M4sllCompromisos> M4sllCompromisosAll = M4sllCompromisosRepository.findAll();
        return ResponseEntity.ok().body(M4sllCompromisosAll);
    }
    */
    
    @GetMapping("/m4sll_compromisos/{id_organization}/{lit_id_litigio}/{tfa_id_tp_fase}")
    public ResponseEntity<List<M4sllCompromisos>> getCompromisosByFase(
    		@PathVariable("id_organization") String id_organization,
    		@PathVariable("lit_id_litigio") String lit_id_litigio,
    		@PathVariable("tfa_id_tp_fase") String tfa_id_tp_fase
            
            ) {
        log.debug("REST request to get ALL M4sllCompromisos : {}");

        List<M4sllCompromisos> M4sllCompromisosAll = M4sllCompromisosRepository.getCompromisosLitigio(
        		id_organization,
        		lit_id_litigio,
        		tfa_id_tp_fase
        		
        		);
        return ResponseEntity.ok().body(M4sllCompromisosAll);
    }

    /*
    @GetMapping("/m4sll_compromisos/{id_organization}/{lit_id_litigio}/{aur_secuencia}")
    public ResponseEntity<M4sllCompromisos> getM4sllCompromisos(
    		@PathVariable("id_organization") String idOrganization,
    		@PathVariable("lit_id_litigio") String litIdLitigio,
    		@PathVariable("aur_secuencia") Integer aurSecuencia    		
            ) {
        log.debug("REST request to get m4sll_compromisos : {} | {}", litIdLitigio, idOrganization, aurSecuencia );
        M4sllCompromisosId id = new M4sllCompromisosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);        
        id.setAurSecuencia(aurSecuencia);

        Optional<M4sllCompromisos> m4sll_compromisos = M4sllCompromisosRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_compromisos);
    }
    */

    @DeleteMapping("/m4sll_compromisos/{id_organization}/{lit_id_litigio}/{tco_id_tp_compromiso}/{com_secuencia}")
    public ResponseEntity<Void> deleteM4sllCompromisos(
    		@PathVariable("id_organization") String idOrganization,
            @PathVariable("lit_id_litigio") String litIdLitigio,
            @PathVariable("tco_id_tp_compromiso") String  tcoIDTpCompromiso,
            @PathVariable("com_secuencia") Integer  comSecuencia
            ) {
        log.debug("REST request to delete m4sll_compromisos : {} | {}", litIdLitigio, idOrganization, tcoIDTpCompromiso, comSecuencia );
        M4sllCompromisosId id = new M4sllCompromisosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setTcoIdTpCompromiso(tcoIDTpCompromiso);
        id.setComSecuencia(comSecuencia);
        

        M4sllCompromisosRepository.deleteById(id);
        return ResponseEntity.noContent()
                .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
                .build();
    }
}