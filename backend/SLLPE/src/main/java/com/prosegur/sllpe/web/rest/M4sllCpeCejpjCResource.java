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

    private M4sllCpeCejpjCRepository m4sllCpeCejpjCRepository;

    public M4sllCpeCejpjCResource(M4sllCpeCejpjCRepository m4sllCpeCejpjCRepository) {
        this.m4sllCpeCejpjCRepository = m4sllCpeCejpjCRepository;
    }

    @PostMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<M4sllCpeCejpjC> createM4sllCpeCejpjC(@RequestBody M4sllCpeCejpjC m4sll_cpe_cejpj_c)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_cpe_cejpj_c : {}", m4sll_cpe_cejpj_c);

        M4sllCpeCejpjC result = m4sllCpeCejpjCRepository.save(m4sll_cpe_cejpj_c);
        return ResponseEntity
               .created(new URI("/api/m4sll_cpe_cejpj_c/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<M4sllCpeCejpjC> updateM4sllCpeCejpjC(@RequestBody M4sllCpeCejpjC m4sll_cpe_cejpj_c)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_cpe_cejpj_c : {}", m4sll_cpe_cejpj_c);
        if (m4sll_cpe_cejpj_c.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllCpeCejpjC result = m4sllCpeCejpjCRepository.save(m4sll_cpe_cejpj_c);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_cpe_cejpj_c.getId().toString())).body(result);
    }

    @GetMapping("/m4sll_cpe_cejpj_c")
    public ResponseEntity<List<M4sllCpeCejpjC>> getAllM4sllCpeCejpjC() {
        log.debug("REST request to get ALL M4sllCpeCejpjC : {}");

        List<M4sllCpeCejpjC> M4sllCpeCejpjCAll = m4sllCpeCejpjCRepository.findAll();
        return ResponseEntity.ok().body(M4sllCpeCejpjCAll);
    }

    @GetMapping("/m4sll_cpe_cejpj_c/{lit_id_litigio}/{id_organization}")
    public ResponseEntity<M4sllCpeCejpjC> getM4sllCpeCejpjC(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllCpeCejpjC : {}", lit_id_litigio + "|" + id_organization);
        M4sllCpeCejpjCId id = new M4sllCpeCejpjCId();
        id.setLitIdLitigio(lit_id_litigio);
        id.setIdOrganization(id_organization);

        Optional<M4sllCpeCejpjC> m4sll_cpe_cejpj_c = m4sllCpeCejpjCRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_cpe_cejpj_c);
    }

    @GetMapping("/m4sll_cpe_cejpj_c/{lit_id_litigio}")
    public ResponseEntity<List<M4sllCpeCejpjC>> getM4sllCpeCejpjC(@PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllCpeCejpjC : {}", lit_id_litigio);

        List<M4sllCpeCejpjC> M4sllCpeCejpjCByInput = m4sllCpeCejpjCRepository.findByLitIdLitigio(lit_id_litigio);
        return ResponseEntity.ok().body(M4sllCpeCejpjCByInput);
    }

    @DeleteMapping("/m4sll_cpe_cejpj_c/{lit_id_litigio}/{id_organization}")
    public ResponseEntity<Void> deleteM4sllCpeCejpjC(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_cpe_cejpj_c : {}", lit_id_litigio + "|" + id_organization);
        M4sllCpeCejpjCId id = new M4sllCpeCejpjCId();
        id.setLitIdLitigio(lit_id_litigio);
        id.setIdOrganization(id_organization);

        m4sllCpeCejpjCRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
