package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpRoles;
import com.prosegur.sllpe.domain.M4sllTpRolesId;
import com.prosegur.sllpe.repository.M4sllTpRolesRepository;
import com.prosegur.sllpe.service.M4sllTpRolesServices;
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
public class M4sllTpRolesResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpRolesResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpRoles";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpRolesRepository m4sllTpRolesRepository;

    public M4sllTpRolesResource(M4sllTpRolesRepository m4sllTpRolesRepository) {
        this.m4sllTpRolesRepository = m4sllTpRolesRepository;
    }

    @PostMapping("/m4sll_tp_roles")
    public ResponseEntity<M4sllTpRoles> createM4sllTpRoles(@RequestBody M4sllTpRoles m4sll_tp_roles)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_roles : {}", m4sll_tp_roles);
        M4sllTpRolesId id = new M4sllTpRolesId();
        M4sllTpRolesServices m4sllTpRolesServices = new M4sllTpRolesServices(m4sllTpRolesRepository);
        Long id_tpr_id_tp_rol = m4sllTpRolesServices.UltimaSecuencia(m4sll_tp_roles);

        id.setTprIdTpRol(id_tpr_id_tp_rol);
        id.setIdOrganization(m4sll_tp_roles.getId().getIdOrganization());

        m4sll_tp_roles.setId(id);
        M4sllTpRoles result = m4sllTpRolesRepository.save(m4sll_tp_roles);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_roles/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_roles")
    public ResponseEntity<M4sllTpRoles> updateM4sllTpRoles(@RequestBody M4sllTpRoles m4sll_tp_roles)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_roles : {}", m4sll_tp_roles);
        if (m4sll_tp_roles.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpRoles result = m4sllTpRolesRepository.save(m4sll_tp_roles);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_roles.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_roles")
    public ResponseEntity<List<M4sllTpRoles>> getAllM4sllTpRoles() {
        log.debug("REST request to get ALL M4sllTpRoles : {}");

        List<M4sllTpRoles> M4sllTpRolesAll = m4sllTpRolesRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpRolesAll);
    }

    @GetMapping("/m4sll_tp_roles/{id_organization}")
    public ResponseEntity<List<M4sllTpRoles>> getM4sllTpRoles(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpRoles : {}", id_organization);

        List<M4sllTpRoles> M4sllTpRolesByInput = m4sllTpRolesRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpRolesByInput);
    }


    /*
      @GetMapping("/m4sll_tp_roles/{id_organization}/{tpr_id_tp_rol}")
      public ResponseEntity<M4sllTpRoles> getM4sllTpRoles(@PathVariable("id_organization") String id_organization, @PathVariable("tpr_id_tp_rol") Long tpr_id_tp_rol) {
          log.debug("REST request to get M4sllTpRoles : {}", id_organization + "|" + tpr_id_tp_rol);
          M4sllTpRolesId id = new M4sllTpRolesId();
          id.setIdOrganization(id_organization);
          id.setTprIdTpRol(tpr_id_tp_rol);

          Optional<M4sllTpRoles> m4sll_tp_roles = m4sllTpRolesRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_roles);
      }

      @DeleteMapping("/m4sll_tp_roles/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpRoles(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_roles : {}", id_organization);
        List<M4sllTpRoles> M4sllTpRolesByInput = m4sllTpRolesRepository.findByIdOrganization(id_organization);

        m4sllTpRolesRepository.deleteAll(M4sllTpRolesByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpRolesByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_roles/{id_organization}/{tpr_id_tp_rol}")
    public ResponseEntity<Void> deleteM4sllTpRoles(@PathVariable("id_organization") String id_organization, @PathVariable("tpr_id_tp_rol") Long tpr_id_tp_rol) {
        log.debug("REST request to delete m4sll_tp_roles : {}", id_organization + "|" + tpr_id_tp_rol);
        M4sllTpRolesId id = new M4sllTpRolesId();
        id.setIdOrganization(id_organization);
        id.setTprIdTpRol(tpr_id_tp_rol);

        m4sllTpRolesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
