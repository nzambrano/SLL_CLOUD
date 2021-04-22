package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllCpeCejpjC;
import com.prosegur.sllpe.domain.M4sllCpeCejpjCId;
import com.prosegur.sllpe.repository.M4sllCpeCejpjCRepository;
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

public class M4sllCpeCejpjCResource {
    private final Logger log = LoggerFactory.getLogger(M4sllCpeCejpjCResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllCpeCejpjC";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllCpeCejpjCRepository m4sllCpeCejpjCRepository;

    public M4sllCpeCejpjCResource(M4sllCpeCejpjCRepository m4sllCpeCejpjCRepository) {
        this.m4sllCpeCejpjCRepository = m4sllCpeCejpjCRepository;
    }
    @PostMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<List<M4sllCpeCejpjC>> createM4sllCpeCejpjC(@RequestBody List<M4sllCpeCejpjC> listM4sllCpeCejpjC)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_cpe_cejpj_c : {}", listM4sllCpeCejpjC);
        List<M4sllCpeCejpjC> result = m4sllCpeCejpjCRepository.saveAll(listM4sllCpeCejpjC);
        return ResponseEntity
               .created(new URI("/api/m4sll_cpe_cejpj_c/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @PutMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<List<M4sllCpeCejpjC>> updateM4sllCpeCejpjC(@RequestBody List<M4sllCpeCejpjC> listM4sllCpeCejpjC)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_cpe_cejpj_c : {}", listM4sllCpeCejpjC);
        List<M4sllCpeCejpjC> result = m4sllCpeCejpjCRepository.saveAll(listM4sllCpeCejpjC);
        return ResponseEntity
               .created(new URI("/api/m4sll_cpe_cejpj_c/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<List<M4sllCpeCejpjC>> getAllM4sllCpeCejpjC() {
        log.debug("REST request to get ALL M4sllCpeCejpjC : {}");

        List<M4sllCpeCejpjC> M4sllCpeCejpjCAll = m4sllCpeCejpjCRepository.findAll();
        return ResponseEntity.ok().body(M4sllCpeCejpjCAll);
    }

    @GetMapping("/m4sll_cpe_cejpj_c/{lit_id_litigio}")
    public ResponseEntity<M4sllCpeCejpjC> getM4sllCpeCejpjC(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllCpeCejpjC : {}", idOrganization + "|" + litIdLitigio);
        M4sllCpeCejpjCId id = new M4sllCpeCejpjCId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);

        Optional<M4sllCpeCejpjC> m4sllCpeCejpjC = m4sllCpeCejpjCRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sllCpeCejpjC);
    }

    @GetMapping("/m4sll_cpe_cejpj_c/{lit_id_litigio}")
    public ResponseEntity<List<M4sllCpeCejpjC>> getM4sllCpeCejpjC(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllCpeCejpjC : {}", litIdLitigio);

        List<M4sllCpeCejpjC> M4sllCpeCejpjCByInput = m4sllCpeCejpjCRepository.findByLitIdLitigio(litIdLitigio);
        return ResponseEntity.ok().body(M4sllCpeCejpjCByInput);
    }

    @DeleteMapping("/m4sll_cpe_cejpj_c/{lit_id_litigio}")
    public ResponseEntity<Void> deleteM4sllCpeCejpjC(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to delete m4sll_cpe_cejpj_c : {}", idOrganization + "|" + litIdLitigio);
        M4sllCpeCejpjCId id = new M4sllCpeCejpjCId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);

        m4sllCpeCejpjCRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<M4sllCpeCejpjC> createM4sllCpeCejpjC(@RequestBody M4sllCpeCejpjC m4sllCpeCejpjC)
            throws URISyntaxException {
        log.debug("REST request to create m4sll_cpe_cejpj_c : {}", m4sllCpeCejpjC);

        M4sllCpeCejpjC result = m4sllCpeCejpjCRepository.save(m4sllCpeCejpjC);
        return ResponseEntity
                .created(new URI("/api/m4sll_cpe_cejpj_c/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un solo registro
    @PutMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<M4sllCpeCejpjC> updateM4sllCpeCejpjC(@RequestBody M4sllCpeCejpjC m4sllCpeCejpjC)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_cpe_cejpj_c : {}", m4sllCpeCejpjC);
        if (m4sllCpeCejpjC.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllCpeCejpjC result = m4sllCpeCejpjCRepository.save(m4sllCpeCejpjC);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sllCpeCejpjC.getId().toString())).body(result);
    }


*/