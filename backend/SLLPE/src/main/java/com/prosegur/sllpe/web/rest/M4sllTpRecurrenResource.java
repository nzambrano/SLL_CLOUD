package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpRecurren;
import com.prosegur.sllpe.domain.M4sllTpRecurrenId;
import com.prosegur.sllpe.repository.M4sllTpRecurrenRepository;
import com.prosegur.sllpe.service.M4sllTpRecurrenServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;
import io.github.jhipster.web.util.HeaderUtil;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class M4sllTpRecurrenResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpRecurrenResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpRecurren";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpRecurrenRepository m4sllTpRecurrenRepository;

    public M4sllTpRecurrenResource(M4sllTpRecurrenRepository m4sllTpRecurrenRepository) {
        this.m4sllTpRecurrenRepository = m4sllTpRecurrenRepository;
    }

    @PostMapping("/m4sll_tp_recurren")
    public ResponseEntity<M4sllTpRecurren> createM4sllTpRecurren(@RequestBody M4sllTpRecurren m4sll_tp_recurren)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_recurren : {}", m4sll_tp_recurren);
        M4sllTpRecurrenId id = new M4sllTpRecurrenId();
        M4sllTpRecurrenServices m4sllTpRecurrenServices = new M4sllTpRecurrenServices(m4sllTpRecurrenRepository);
        String id_tre_id_recurrencia = m4sllTpRecurrenServices.UltimaSecuencia(m4sll_tp_recurren);

        id.setTreIdRecurrencia(id_tre_id_recurrencia);
        id.setIdOrganization(m4sll_tp_recurren.getId().getIdOrganization());

        m4sll_tp_recurren.setId(id);
        M4sllTpRecurren result = m4sllTpRecurrenRepository.save(m4sll_tp_recurren);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_recurren/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_recurren")
    public ResponseEntity<M4sllTpRecurren> updateM4sllTpRecurren(@RequestBody M4sllTpRecurren m4sll_tp_recurren)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_recurren : {}", m4sll_tp_recurren);
        if (m4sll_tp_recurren.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpRecurren result = m4sllTpRecurrenRepository.save(m4sll_tp_recurren);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_recurren.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_recurren")
    public ResponseEntity<List<M4sllTpRecurren>> getAllM4sllTpRecurren() {
        log.debug("REST request to get ALL M4sllTpRecurren : {}");

        List<M4sllTpRecurren> M4sllTpRecurrenAll = m4sllTpRecurrenRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpRecurrenAll);
    }

    @GetMapping("/m4sll_tp_recurren/{id_organization}")
    public ResponseEntity<List<M4sllTpRecurren>> getM4sllTpRecurren(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpRecurren : {}", id_organization);

        List<M4sllTpRecurren> M4sllTpRecurrenByInput = m4sllTpRecurrenRepository.findM4sllTpRecurrenByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpRecurrenByInput);
    }


    /*
      @GetMapping("/m4sll_tp_recurren/{id_organization}/{tre_id_recurrencia}")
      public ResponseEntity<M4sllTpRecurren> getM4sllTpRecurren(@PathVariable("id_organization") String id_organization, @PathVariable("tre_id_recurrencia") String tre_id_recurrencia) {
          log.debug("REST request to get M4sllTpRecurren : {}", id_organization + "|" + tre_id_recurrencia);
          M4sllTpRecurrenId id = new M4sllTpRecurrenId();
          id.setIdOrganization(id_organization);
          id.setTreIdRecurrencia(tre_id_recurrencia);

          Optional<M4sllTpRecurren> m4sll_tp_recurren = m4sllTpRecurrenRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_recurren);
      }

      @DeleteMapping("/m4sll_tp_recurren/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpRecurren(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_recurren : {}", id_organization);
        List<M4sllTpRecurren> M4sllTpRecurrenByInput = m4sllTpRecurrenRepository.findM4sllTpRecurrenByIdOrganization(id_organization);

        m4sllTpRecurrenRepository.deleteAll(M4sllTpRecurrenByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpRecurrenByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_recurren/{id_organization}/{tre_id_recurrencia}")
    public ResponseEntity<Void> deleteM4sllTpRecurren(@PathVariable("id_organization") String id_organization, @PathVariable("tre_id_recurrencia") String tre_id_recurrencia) {
        log.debug("REST request to delete m4sll_tp_recurren : {}", id_organization + "|" + tre_id_recurrencia);
        M4sllTpRecurrenId id = new M4sllTpRecurrenId();
        id.setIdOrganization(id_organization);
        id.setTreIdRecurrencia(tre_id_recurrencia);

        m4sllTpRecurrenRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
