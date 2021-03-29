package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpFases;
import com.prosegur.sllpe.domain.M4sllTpFasesId;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;
import com.prosegur.sllpe.service.TpFaseServices;

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

public class M4sllTpFasesResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpFasesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpFases";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpFasesRepository M4sllTpFasesRepository;

    public M4sllTpFasesResource(M4sllTpFasesRepository M4sllTpFasesRepository) {
        this.M4sllTpFasesRepository = M4sllTpFasesRepository;
    }

    /* Insert en la BD */
    @PostMapping("/m4sll_tp_fases")
    public ResponseEntity<M4sllTpFases> createM4sllTpFases(@RequestBody M4sllTpFases m4sll_tp_fases)
    throws URISyntaxException {

        log.debug("REST request to create m4sll_tp_fases : {}", m4sll_tp_fases);

        M4sllTpFasesId id = new M4sllTpFasesId();

        TpFaseServices tpFaseServices = new TpFaseServices(M4sllTpFasesRepository);
        String tfa_id_tp_fase = tpFaseServices.UltimaSecuencia(m4sll_tp_fases).toString();

        id.setIdOrganization(m4sll_tp_fases.getId().getIdOrganization());
        id.setTfaIdTpFase(tfa_id_tp_fase);

        m4sll_tp_fases.setId(id);

        M4sllTpFases result = M4sllTpFasesRepository.save(m4sll_tp_fases);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_fases/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    /* Update en la BD */
    @PutMapping("/m4sll_tp_fases")
    public ResponseEntity<M4sllTpFases> updateM4sllTpFases(@RequestBody M4sllTpFases m4sll_tp_fases)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_fases : {}", m4sll_tp_fases);
        if (m4sll_tp_fases.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpFases result = M4sllTpFasesRepository.save(m4sll_tp_fases);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_tp_fases.getId().toString())).body(result);
    }

    /* Select en la BD */
    @GetMapping("/m4sll_tp_fases/{id_organization}")
    public ResponseEntity<List<M4sllTpFases>> getAllM4sllTpFases(
        @PathVariable("id_organization") String idOrganization
    ) {
        log.debug("REST request to get ALL M4sllTpFases : {}");

        List<M4sllTpFases> M4sllTpFasesAll = M4sllTpFasesRepository.findTpFases(idOrganization);
        return ResponseEntity.ok().body(M4sllTpFasesAll);
    }

    /* Delete en la BD */
    @DeleteMapping("/m4sll_tp_fases/{id_organization}/{tfa_id_tp_fase}")
    public ResponseEntity<Void> deleteM4sllTpFases(
        @PathVariable("id_organization") String idOrganization,
        @PathVariable("tfa_id_tp_fase") String idTpFase
    ) {

        log.debug("REST request to delete m4sll_tp_fases : {} | {}", idOrganization, idTpFase);
        M4sllTpFasesId id = new M4sllTpFasesId();

        id.setIdOrganization(idOrganization);
        id.setTfaIdTpFase(idTpFase);

        M4sllTpFasesRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }

}