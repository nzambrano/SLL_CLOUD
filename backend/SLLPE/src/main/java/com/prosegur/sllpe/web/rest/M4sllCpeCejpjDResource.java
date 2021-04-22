package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllCpeCejpjD;
import com.prosegur.sllpe.domain.M4sllCpeCejpjDId;
import com.prosegur.sllpe.repository.M4sllCpeCejpjDRepository;
import com.prosegur.sllpe.service.M4sllCpeCejpjDServices;
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
public class M4sllCpeCejpjDResource {
    private final Logger log = LoggerFactory.getLogger(M4sllCpeCejpjDResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllCpeCejpjD";

    @Autowired
    M4sllCpeCejpjDServices m4sllCpeCejpjDServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository;

    public M4sllCpeCejpjDResource(M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository) {
        this.m4sllCpeCejpjDRepository = m4sllCpeCejpjDRepository;
    }

    @PostMapping("/m4sll_cpe_cejpj_d")
    public ResponseEntity<List<M4sllCpeCejpjD>> createM4sllCpeCejpjD(@RequestBody List<M4sllCpeCejpjD> listM4sllCpeCejpjD)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_cpe_cejpj_d : {}", listM4sllCpeCejpjD);
        List<M4sllCpeCejpjD>result =  m4sllCpeCejpjDServices.saveAllWithSecuencia(listM4sllCpeCejpjD);
        return ResponseEntity
               .created(new URI("/api/m4sll_cpe_cejpj_d/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_cpe_cejpj_d")
    public ResponseEntity<List<M4sllCpeCejpjD>> updateM4sllCpeCejpjD(@RequestBody List<M4sllCpeCejpjD> listM4sllCpeCejpjD)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_cpe_cejpj_d : {}", listM4sllCpeCejpjD);
        List<M4sllCpeCejpjD> result = m4sllCpeCejpjDRepository.saveAll(listM4sllCpeCejpjD);
        return ResponseEntity
               .created(new URI("/api/m4sll_cpe_cejpj_d/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_cpe_cejpj_d")
    public ResponseEntity<List<M4sllCpeCejpjD>> getAllM4sllCpeCejpjD() {
        log.debug("REST request to get ALL M4sllCpeCejpjD : {}");

        List<M4sllCpeCejpjD> M4sllCpeCejpjDAll = m4sllCpeCejpjDRepository.findAll();
        return ResponseEntity.ok().body(M4sllCpeCejpjDAll);
    }

    @GetMapping("/m4sll_cpe_cejpj_d/{lit_id_litigio}")
    public ResponseEntity<List<M4sllCpeCejpjD>> getM4sllCpeCejpjD(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllCpeCejpjD : {}", idOrganization + "|" + litIdLitigio);

        List<M4sllCpeCejpjD> M4sllCpeCejpjDByInput = m4sllCpeCejpjDRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);
        return ResponseEntity.ok().body(M4sllCpeCejpjDByInput);
    }


    @DeleteMapping("/m4sll_cpe_cejpj_d/{lit_id_litigio}/{ccd_id_secuencia}")
    public ResponseEntity<Void> deleteM4sllCpeCejpjD(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("ccd_id_secuencia") Long ccdIdSecuencia) {
        log.debug("REST request to delete m4sll_cpe_cejpj_d : {}", idOrganization + "|" + litIdLitigio + "|" + ccdIdSecuencia);
        M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setCcdIdSecuencia(ccdIdSecuencia);

        m4sllCpeCejpjDRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_cpe_cejpj_d")
  public ResponseEntity<M4sllCpeCejpjD> createM4sllCpeCejpjD(@RequestBody M4sllCpeCejpjD m4sllCpeCejpjD)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_cpe_cejpj_d : {}", m4sllCpeCejpjD);
    M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
    M4sllCpeCejpjDServices m4sllCpeCejpjDServices = new M4sllCpeCejpjDServices(m4sllCpeCejpjDRepository);
    Long id_ccdIdSecuencia = m4sllCpeCejpjDServices.UltimaSecuencia(m4sllCpeCejpjD);

    id.setCcdIdSecuencia(id_ccdIdSecuencia);
    id.setIdOrganization(idOrganization);
id.setLitIdLitigio(m4sllCpeCejpjD.getId().getLitIdLitigio());

    m4sllCpeCejpjD.setId(id);
    M4sllCpeCejpjD result = m4sllCpeCejpjDRepository.save(m4sllCpeCejpjD);
    return ResponseEntity
      .created(new URI("/api/m4sll_cpe_cejpj_d/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_cpe_cejpj_d/{lit_id_litigio}/{ccd_id_secuencia}")
  public ResponseEntity<M4sllCpeCejpjD> getM4sllCpeCejpjD(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("ccd_id_secuencia") Long ccdIdSecuencia) {
      log.debug("REST request to get M4sllCpeCejpjD : {}", idOrganization + "|" + litIdLitigio + "|" + ccdIdSecuencia);
      M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
      id.setIdOrganization(idOrganization);
id.setLitIdLitigio(litIdLitigio);
      id.setCcdIdSecuencia(ccdIdSecuencia);

      Optional<M4sllCpeCejpjD> m4sllCpeCejpjD = m4sllCpeCejpjDRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllCpeCejpjD);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_cpe_cejpj_d/{lit_id_litigio}")
  public ResponseEntity<Void> deleteM4sllCpeCejpjD(@PathVariable("lit_id_litigio") String litIdLitigio) {
    log.debug("REST request to delete m4sll_cpe_cejpj_d : {}", idOrganization + "|" + litIdLitigio);
    List<M4sllCpeCejpjD> M4sllCpeCejpjDByInput = m4sllCpeCejpjDRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);

    m4sllCpeCejpjDRepository.deleteAll(M4sllCpeCejpjDByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllCpeCejpjDByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_cpe_cejpj_d")
public ResponseEntity<M4sllCpeCejpjD> updateM4sllCpeCejpjD(@RequestBody M4sllCpeCejpjD m4sllCpeCejpjD)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_cpe_cejpj_d : {}", m4sllCpeCejpjD);
  if (m4sllCpeCejpjD.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllCpeCejpjD result = m4sllCpeCejpjDRepository.save(m4sllCpeCejpjD);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllCpeCejpjD.getId().toString()))
    .body(result);
}


*/
