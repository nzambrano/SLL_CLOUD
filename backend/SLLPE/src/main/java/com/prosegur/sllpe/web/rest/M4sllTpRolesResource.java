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
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    M4sllTpRolesServices m4sllTpRolesServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpRolesRepository m4sllTpRolesRepository;

    public M4sllTpRolesResource(M4sllTpRolesRepository m4sllTpRolesRepository) {
        this.m4sllTpRolesRepository = m4sllTpRolesRepository;
    }

    @PostMapping("/m4sll_tp_roles")
    public ResponseEntity<List<M4sllTpRoles>> createM4sllTpRoles(@RequestBody List<M4sllTpRoles> listM4sllTpRoles)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_roles : {}", listM4sllTpRoles);
        List<M4sllTpRoles>result =  m4sllTpRolesServices.saveAllWithSecuencia(listM4sllTpRoles);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_roles/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_roles")
    public ResponseEntity<List<M4sllTpRoles>> updateM4sllTpRoles(@RequestBody List<M4sllTpRoles> listM4sllTpRoles)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_roles : {}", listM4sllTpRoles);
        List<M4sllTpRoles> result = m4sllTpRolesRepository.saveAll(listM4sllTpRoles);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_roles/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_roles")
        public ResponseEntity<List<M4sllTpRoles>> getAllM4sllTpRoles() {
          log.debug("REST request to get ALL M4sllTpRoles : {}");

          List<M4sllTpRoles> M4sllTpRolesAll = m4sllTpRolesRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpRolesAll);
        }
    */

    @GetMapping("/m4sll_tp_roles")
    public ResponseEntity<List<M4sllTpRoles>> getM4sllTpRoles() {
        log.debug("REST request to get M4sllTpRoles : {}", idOrganization);

        List<M4sllTpRoles> M4sllTpRolesByInput = m4sllTpRolesRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpRolesByInput);
    }


    @DeleteMapping("/m4sll_tp_roles/{tpr_id_tp_rol}")
    public ResponseEntity<Void> deleteM4sllTpRoles(@PathVariable("tpr_id_tp_rol") Long tprIdTpRol) {
        log.debug("REST request to delete m4sll_tp_roles : {}", idOrganization + "|" + tprIdTpRol);
        M4sllTpRolesId id = new M4sllTpRolesId();
        id.setIdOrganization(idOrganization);
        id.setTprIdTpRol(tprIdTpRol);

        m4sllTpRolesRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_roles")
  public ResponseEntity<M4sllTpRoles> createM4sllTpRoles(@RequestBody M4sllTpRoles m4sllTpRoles)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_roles : {}", m4sllTpRoles);
    M4sllTpRolesId id = new M4sllTpRolesId();
    M4sllTpRolesServices m4sllTpRolesServices = new M4sllTpRolesServices(m4sllTpRolesRepository);
    Long id_tprIdTpRol = m4sllTpRolesServices.UltimaSecuencia(m4sllTpRoles);

    id.setTprIdTpRol(id_tprIdTpRol);
    id.setIdOrganization(idOrganization);

    m4sllTpRoles.setId(id);
    M4sllTpRoles result = m4sllTpRolesRepository.save(m4sllTpRoles);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_roles/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_roles/{tpr_id_tp_rol}")
  public ResponseEntity<M4sllTpRoles> getM4sllTpRoles(@PathVariable("tpr_id_tp_rol") Long tprIdTpRol) {
      log.debug("REST request to get M4sllTpRoles : {}", idOrganization + "|" + tprIdTpRol);
      M4sllTpRolesId id = new M4sllTpRolesId();
      id.setIdOrganization(idOrganization);
      id.setTprIdTpRol(tprIdTpRol);

      Optional<M4sllTpRoles> m4sllTpRoles = m4sllTpRolesRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpRoles);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_roles")
  public ResponseEntity<Void> deleteM4sllTpRoles() {
    log.debug("REST request to delete m4sll_tp_roles : {}", idOrganization);
    List<M4sllTpRoles> M4sllTpRolesByInput = m4sllTpRolesRepository.findByIdOrganization(idOrganization);

    m4sllTpRolesRepository.deleteAll(M4sllTpRolesByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpRolesByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_roles")
public ResponseEntity<M4sllTpRoles> updateM4sllTpRoles(@RequestBody M4sllTpRoles m4sllTpRoles)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_roles : {}", m4sllTpRoles);
  if (m4sllTpRoles.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpRoles result = m4sllTpRolesRepository.save(m4sllTpRoles);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpRoles.getId().toString()))
    .body(result);
}


*/
