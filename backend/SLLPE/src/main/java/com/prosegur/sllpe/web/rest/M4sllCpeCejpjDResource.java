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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sllpe")
@Transactional
public class M4sllCpeCejpjDResource {

    private final Logger log = LoggerFactory.getLogger(M4sllCpeCejpjDResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllCpeCejpjD";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository;

    public M4sllCpeCejpjDResource(M4sllCpeCejpjDRepository m4sllCpeCejpjDRepository) {
        this.m4sllCpeCejpjDRepository = m4sllCpeCejpjDRepository;
    }

    @PostMapping("/m4sll_cpe_cejpj_d")
    public ResponseEntity<M4sllCpeCejpjD> createM4sllCpeCejpjD(@RequestBody M4sllCpeCejpjD m4sll_cpe_cejpj_d)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_cpe_cejpj_d : {}", m4sll_cpe_cejpj_d);
        M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
        M4sllCpeCejpjDServices m4sllCpeCejpjDServices = new M4sllCpeCejpjDServices(m4sllCpeCejpjDRepository);
        Long id_ccd_id_secuencia = m4sllCpeCejpjDServices.UltimaSecuencia(m4sll_cpe_cejpj_d);

        id.setCcdIdSecuencia(id_ccd_id_secuencia);
        id.setIdOrganization(m4sll_cpe_cejpj_d.getId().getIdOrganization());
        id.setLitIdLitigio(m4sll_cpe_cejpj_d.getId().getLitIdLitigio());

        m4sll_cpe_cejpj_d.setId(id);
        M4sllCpeCejpjD result = m4sllCpeCejpjDRepository.save(m4sll_cpe_cejpj_d);
        return ResponseEntity
               .created(new URI("/api/m4sll_cpe_cejpj_d/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_cpe_cejpj_d")
    public ResponseEntity<M4sllCpeCejpjD> updateM4sllCpeCejpjD(@RequestBody M4sllCpeCejpjD m4sll_cpe_cejpj_d)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_cpe_cejpj_d : {}", m4sll_cpe_cejpj_d);
        if (m4sll_cpe_cejpj_d.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllCpeCejpjD result = m4sllCpeCejpjDRepository.save(m4sll_cpe_cejpj_d);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_cpe_cejpj_d.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_cpe_cejpj_d")
    public ResponseEntity<List<M4sllCpeCejpjD>> getAllM4sllCpeCejpjD() {
        log.debug("REST request to get ALL M4sllCpeCejpjD : {}");

        List<M4sllCpeCejpjD> M4sllCpeCejpjDAll = m4sllCpeCejpjDRepository.findAll();
        return ResponseEntity.ok().body(M4sllCpeCejpjDAll);
    }

    @GetMapping("/m4sll_cpe_cejpj_d/{id_organization}/{lit_id_litigio}")
    public ResponseEntity<List<M4sllCpeCejpjD>> getM4sllCpeCejpjD(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllCpeCejpjD : {}", id_organization + "|" + lit_id_litigio);

        List<M4sllCpeCejpjD> M4sllCpeCejpjDByInput = m4sllCpeCejpjDRepository.findByIdOrganizationLitIdLitigio(id_organization, lit_id_litigio);
        return ResponseEntity.ok().body(M4sllCpeCejpjDByInput);
    }

    @GetMapping("/m4sll_cpe_cejpj_d/{lit_id_litigio}")
    public ResponseEntity<List<M4sllCpeCejpjD>> getM4sllCpeCejpjD(@PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllCpeCejpjD : {}", lit_id_litigio);

        List<M4sllCpeCejpjD> M4sllCpeCejpjDByInput = m4sllCpeCejpjDRepository.findByLitIdLitigio(lit_id_litigio);
        return ResponseEntity.ok().body(M4sllCpeCejpjDByInput);
    }

    /*
      @GetMapping("/m4sll_cpe_cejpj_d/{id_organization}/{lit_id_litigio}/{ccd_id_secuencia}")
      public ResponseEntity<M4sllCpeCejpjD> getM4sllCpeCejpjD(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("ccd_id_secuencia") Long ccd_id_secuencia) {
          log.debug("REST request to get M4sllCpeCejpjD : {}", id_organization + "|" + lit_id_litigio + "|" + ccd_id_secuencia);
          M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
          id.setIdOrganization(id_organization); id.setLitIdLitigio(lit_id_litigio);
          id.setCcdIdSecuencia(ccd_id_secuencia);

          Optional<M4sllCpeCejpjD> m4sll_cpe_cejpj_d = m4sllCpeCejpjDRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_cpe_cejpj_d);
      }

      @DeleteMapping("/m4sll_cpe_cejpj_d/{id_organization}/{lit_id_litigio}")
      public ResponseEntity<Void> deleteM4sllCpeCejpjD(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to delete m4sll_cpe_cejpj_d : {}", id_organization + "|" + lit_id_litigio);
        List<M4sllCpeCejpjD> M4sllCpeCejpjDByInput = m4sllCpeCejpjDRepository.findByIdOrganizationLitIdLitigio(id_organization, lit_id_litigio);

        m4sllCpeCejpjDRepository.deleteAll(M4sllCpeCejpjDByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllCpeCejpjDByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_cpe_cejpj_d/{id_organization}/{lit_id_litigio}/{ccd_id_secuencia}")
    public ResponseEntity<Void> deleteM4sllCpeCejpjD(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("ccd_id_secuencia") Long ccd_id_secuencia) {
        log.debug("REST request to delete m4sll_cpe_cejpj_d : {}", id_organization + "|" + lit_id_litigio + "|" + ccd_id_secuencia);
        M4sllCpeCejpjDId id = new M4sllCpeCejpjDId();
        id.setIdOrganization(id_organization);
        id.setLitIdLitigio(lit_id_litigio);
        id.setCcdIdSecuencia(ccd_id_secuencia);

        m4sllCpeCejpjDRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
