package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtoCodAlt;
import com.prosegur.sllpe.domain.M4sllMtoCodAltId;
import com.prosegur.sllpe.repository.M4sllMtoCodAltRepository;
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

public class M4sllMtoCodAltResource {

    private final Logger log = LoggerFactory.getLogger(M4sllMtoCodAltResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtoCodAlt";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllMtoCodAltRepository m4sllMtoCodAltRepository;

    public M4sllMtoCodAltResource(M4sllMtoCodAltRepository m4sllMtoCodAltRepository) {
        this.m4sllMtoCodAltRepository = m4sllMtoCodAltRepository;
    }

    @PostMapping("/m4sll_mto_cod_alt")
    public ResponseEntity<M4sllMtoCodAlt> createM4sllMtoCodAlt(@RequestBody M4sllMtoCodAlt m4sll_mto_cod_alt)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_mto_cod_alt : {}", m4sll_mto_cod_alt);

        M4sllMtoCodAlt result = m4sllMtoCodAltRepository.save(m4sll_mto_cod_alt);
        return ResponseEntity
               .created(new URI("/api/m4sll_mto_cod_alt/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_mto_cod_alt")
    public ResponseEntity<M4sllMtoCodAlt> updateM4sllMtoCodAlt(@RequestBody M4sllMtoCodAlt m4sll_mto_cod_alt)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mto_cod_alt : {}", m4sll_mto_cod_alt);
        if (m4sll_mto_cod_alt.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllMtoCodAlt result = m4sllMtoCodAltRepository.save(m4sll_mto_cod_alt);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_mto_cod_alt.getId().toString())).body(result);
    }

    @GetMapping("/m4sll_mto_cod_alt")
    public ResponseEntity<List<M4sllMtoCodAlt>> getAllM4sllMtoCodAlt() {
        log.debug("REST request to get ALL M4sllMtoCodAlt : {}");

        List<M4sllMtoCodAlt> M4sllMtoCodAltAll = m4sllMtoCodAltRepository.findAll();
        return ResponseEntity.ok().body(M4sllMtoCodAltAll);
    }

    @GetMapping("/m4sll_mto_cod_alt/{mca_id_codigo_alterno}/{id_organization}")
    public ResponseEntity<M4sllMtoCodAlt> getM4sllMtoCodAlt(@PathVariable("mca_id_codigo_alterno") String mca_id_codigo_alterno, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllMtoCodAlt : {}", mca_id_codigo_alterno + "|" + id_organization);
        M4sllMtoCodAltId id = new M4sllMtoCodAltId();
        id.setMcaIdCodigoAlterno(mca_id_codigo_alterno);
        id.setIdOrganization(id_organization);

        Optional<M4sllMtoCodAlt> m4sll_mto_cod_alt = m4sllMtoCodAltRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_mto_cod_alt);
    }


    @DeleteMapping("/m4sll_mto_cod_alt/{mca_id_codigo_alterno}/{id_organization}")
    public ResponseEntity<Void> deleteM4sllMtoCodAlt(@PathVariable("mca_id_codigo_alterno") String mca_id_codigo_alterno, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_mto_cod_alt : {}", mca_id_codigo_alterno + "|" + id_organization);
        M4sllMtoCodAltId id = new M4sllMtoCodAltId();
        id.setMcaIdCodigoAlterno(mca_id_codigo_alterno);
        id.setIdOrganization(id_organization);

        m4sllMtoCodAltRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}