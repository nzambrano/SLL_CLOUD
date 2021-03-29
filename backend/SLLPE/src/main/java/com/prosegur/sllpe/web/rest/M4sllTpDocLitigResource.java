package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.domain.M4sllTpDocLitigId;
import com.prosegur.sllpe.repository.M4sllTpDocLitigRepository;
import com.prosegur.sllpe.service.TpDocLitServices;
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

public class M4sllTpDocLitigResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpDocLitigResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpDocLitig";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpDocLitigRepository M4sllTpDocLitigRepository;

    public M4sllTpDocLitigResource(M4sllTpDocLitigRepository M4sllTpDocLitigRepository) {
        this.M4sllTpDocLitigRepository = M4sllTpDocLitigRepository;
    }

    /* Insert en la BD */
    @PostMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<M4sllTpDocLitig> createM4sllTpDocLitig(@RequestBody M4sllTpDocLitig m4sll_tp_doc_litig)
    throws URISyntaxException {

        log.debug("REST request to create m4sll_tp_doc_litig : {}", m4sll_tp_doc_litig);

        M4sllTpDocLitigId id = new M4sllTpDocLitigId();

        TpDocLitServices tpDocLitServices = new TpDocLitServices(M4sllTpDocLitigRepository);
        String tdl_id_tp_doc_litigio = tpDocLitServices.UltimaSecuencia(m4sll_tp_doc_litig).toString();

        id.setIdOrganization(m4sll_tp_doc_litig.getId().getIdOrganization());
        id.setTdlIdTpDocLitigio(tdl_id_tp_doc_litigio);

        m4sll_tp_doc_litig.setId(id);

        M4sllTpDocLitig result = M4sllTpDocLitigRepository.save(m4sll_tp_doc_litig);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_doc_litig/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    /* Select en la BD */
    @GetMapping("/m4sll_tp_doc_litig/{id_organization}")
    public ResponseEntity<List<M4sllTpDocLitig>> getAllM4sllTpDocLitig(
        @PathVariable("id_organization") String idOrganization
    ) {
        log.debug("REST request to get ALL M4sllTpDocLitig : {}");

        List<M4sllTpDocLitig> M4sllTpDocLitigAll = M4sllTpDocLitigRepository.findTpDocLitig(idOrganization);
        return ResponseEntity.ok().body(M4sllTpDocLitigAll);
    }

    /* Update en la BD */
    @PutMapping("/m4sll_tp_doc_litig")
    public ResponseEntity<M4sllTpDocLitig> updateM4sllTpDocLitig(@RequestBody M4sllTpDocLitig m4sll_tp_doc_litig)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_doc_litig : {}", m4sll_tp_doc_litig);
        if (m4sll_tp_doc_litig.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpDocLitig result = M4sllTpDocLitigRepository.save(m4sll_tp_doc_litig);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_tp_doc_litig.getId().toString())).body(result);
    }

    /* Delete en la BD */
    @DeleteMapping("/m4sll_tp_doc_litig/{id_organization}/{tdl_id_tp_doc_litigio}")
    public ResponseEntity<Void> deleteM4sllTpDocLitig(
        @PathVariable("id_organization") String idOrganization,
        @PathVariable("tdl_id_tp_doc_litigio") String idTpDocLitig
    ) {

        log.debug("REST request to delete m4sll_tp_doc_litig : {} | {}", idOrganization, idTpDocLitig);
        M4sllTpDocLitigId id = new M4sllTpDocLitigId();

        id.setIdOrganization(idOrganization);
        id.setTdlIdTpDocLitigio(idTpDocLitig);

        M4sllTpDocLitigRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }

}