package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllMtAbogados;
import com.prosegur.sllpe.domain.M4sllMtAbogadosId;
import com.prosegur.sllpe.repository.M4sllAbogadosRepository;
import com.prosegur.sllpe.service.AbogadoServices;
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

public class M4sllAbogadosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllAbogadosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllMtAbogados";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllAbogadosRepository M4sllAbogadosRepository;

    public M4sllAbogadosResource(M4sllAbogadosRepository M4sllAbogadosRepository) {
        this.M4sllAbogadosRepository = M4sllAbogadosRepository;
    }

    /* Select en la BD */
    @GetMapping("/m4sll_mt_abogados")
    public ResponseEntity<List<M4sllMtAbogados>> getAllM4sllMtAbogados(
    ) {
        log.debug("REST request to get ALL M4sllMtAbogados : {}");

        List<M4sllMtAbogados> M4sllMtAbogadosAll = M4sllAbogadosRepository.findAll();
        return ResponseEntity.ok().body(M4sllMtAbogadosAll);
    }

    /* Update en la BD */
    @PutMapping("/m4sll_mt_abogados")
    public ResponseEntity<M4sllMtAbogados> M4sllMtAbogados(@RequestBody M4sllMtAbogados m4sll_mt_abogados)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_mt_abogados : {}", m4sll_mt_abogados);
        if (m4sll_mt_abogados.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllMtAbogados result = M4sllAbogadosRepository.save(m4sll_mt_abogados);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_mt_abogados.getId().toString())).body(result);
    }

    /* Delete en la BD */

    @DeleteMapping("/m4sll_mt_abogados/{id_idOrganization}/{mab_secuencia}")
    public ResponseEntity<Void> deleteM4sllAbogados(
        @PathVariable("id_idOrganization") String id_idOrganization,
        @PathVariable("mab_secuencia") Long mab_secuencia) {
        log.debug("REST request to delete m4sll_mt_abogados : {} | {}",id_idOrganization,mab_secuencia);
        M4sllMtAbogadosId id = new M4sllMtAbogadosId();
        id.setIdOrganization(id_idOrganization);
        id.setMabSecuencia(mab_secuencia);

        M4sllAbogadosRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }

    /* Insert en la BD
    @PostMapping("/m4sll_mt_abogados")
    public ResponseEntity<M4sllMtAbogados> createM4sllAbogados(@RequestBody M4sllMtAbogados m4sll_mt_abogados)
            throws URISyntaxException {
        log.debug("REST request to create m4sll_mt_abogados : {}", m4sll_mt_abogados);

        M4sllMtAbogados result = M4sllAbogadosRepository.save(m4sll_mt_abogados);
        return ResponseEntity
                .created(new URI("/api/m4sll_mt_abogados/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }
    */

    /* Insert en la BD */
    @PostMapping("/m4sll_mt_abogados")
    public ResponseEntity<M4sllMtAbogados> createM4sllAbogados(@RequestBody M4sllMtAbogados m4sll_mt_abogados)
    throws URISyntaxException {

        log.debug("REST request to create m4sll_mt_abogados : {}", m4sll_mt_abogados);

        M4sllMtAbogadosId id = new M4sllMtAbogadosId();

        AbogadoServices abogadoServices = new AbogadoServices(M4sllAbogadosRepository);
        Long mab_secuencia = abogadoServices.UltimaSecuencia(m4sll_mt_abogados);

        id.setIdOrganization(m4sll_mt_abogados.getId().getIdOrganization());
        id.setMabSecuencia(mab_secuencia);

        m4sll_mt_abogados.setId(id);

        M4sllMtAbogados result = M4sllAbogadosRepository.save(m4sll_mt_abogados);
        return ResponseEntity
               .created(new URI("/api/m4sll_mt_abogados/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

}