package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllAutorReu;
import com.prosegur.sllpe.domain.M4sllAutorReuId;
import com.prosegur.sllpe.domain.M4sllAutorReuCustom;
import com.prosegur.sllpe.repository.M4sllAutorReuRepository;
import com.prosegur.sllpe.repository.M4sllVwAutorReuCustomRepository;
import com.prosegur.sllpe.service.M4sllAutorReuServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/api")
@Transactional

public class M4sllAutorReuResource {
    private String idOrganization = "0050";
    private final Logger log = LoggerFactory.getLogger(M4sllAutorReuResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllAutorReu";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllAutorReuRepository m4sllAutorReuRepository;
    private M4sllVwAutorReuCustomRepository m4sllVwAutorReuCustomRepository;

    public M4sllAutorReuResource(M4sllAutorReuRepository m4sllAutorReuRepository, M4sllVwAutorReuCustomRepository m4sllVwAutorReuCustomRepository) {
        this.m4sllAutorReuRepository = m4sllAutorReuRepository;
        this.m4sllVwAutorReuCustomRepository = m4sllVwAutorReuCustomRepository;
    }

    /*
    @PostMapping("/m4sll_autor_reu")
    public ResponseEntity<M4sllAutorReu> createM4sllAutorReu(@RequestBody M4sllAutorReu m4sll_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_autor_reu : {}", m4sll_autor_reu);
        M4sllAutorReuId id = new M4sllAutorReuId();
        M4sllAutorReuServices autorReuServices = new M4sllAutorReuServices(m4sllAutorReuRepository);
        Long id_aurSecuencia = autorReuServices.UltimaSecuencia(m4sll_autor_reu);

        id.setAurSecuencia(id_aurSecuencia);
        id.setLitIdLitigio(m4sll_autor_reu.getId().getLitIdLitigio());
        id.setIdOrganization(m4sll_autor_reu.getId().getIdOrganization());

        m4sll_autor_reu.setId(id);
        M4sllAutorReu result = m4sllAutorReuRepository.save(m4sll_autor_reu);
        return ResponseEntity
               .created(new URI("/api/m4sll_autor_reu/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }*/

    @PostMapping("/m4sll_autor_reu")
    public ResponseEntity<List<M4sllAutorReu>> createM4sllAutorReu(@RequestBody List<M4sllAutorReu> listM4sll_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_autor_reu : {}", listM4sll_autor_reu);

        M4sllAutorReuServices autorReuServices = new M4sllAutorReuServices(m4sllAutorReuRepository);


        autorReuServices.saveAllWithSecuencia(listM4sll_autor_reu);


        List<M4sllAutorReu> result = listM4sll_autor_reu;
        return ResponseEntity
               .created(new URI("/api/m4sll_autor_reu/" )).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, ""))
               .body(result);
    }

    @PutMapping("/m4sll_autor_reu")
    public ResponseEntity<List<M4sllAutorReu>> updateM4sllAutorReu(@RequestBody  List<M4sllAutorReu> listM4sll_autor_reu)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_autor_reu : {}", listM4sll_autor_reu);
        /*if (m4sll_autor_reu.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }*/
        List<M4sllAutorReu> result = m4sllAutorReuRepository.saveAll(listM4sll_autor_reu);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           ""//m4sll_autor_reu.getId().toString()
                                                                             )).body(result);
    }

    /*
    @GetMapping("/m4sll_autor_reu/{id_organization}/{lit_id_litigio}/{aur_autor_reu}")
    public ResponseEntity<List<M4sllAutorReu>> getAutoresByLitigio(
        @PathVariable("id_organization") String id_organization,
        @PathVariable("lit_id_litigio") String lit_id_litigio,
        @PathVariable("aur_autor_reu") String aur_autor_reu

    ) {
        log.debug("REST request to get ALL M4sllAutorReu : {}");

        List<M4sllAutorReu> M4sllAutorReuAll = m4sllAutorReuRepository.findAutorReuByLitigio(
                id_organization,
                lit_id_litigio,
                aur_autor_reu

                                               );
        return ResponseEntity.ok().body(M4sllAutorReuAll);
    }
    */

    @GetMapping("/m4sll_autor_reu/{lit_id_litigio}")
    public ResponseEntity<List<M4sllAutorReuCustom>> getAutorReuByLitigio(
        @PathVariable("lit_id_litigio") String lit_id_litigio

    ) {
        log.debug("REST request to get ALL M4sllAutorReuCustom : {}");

        List<M4sllAutorReuCustom> M4llvWAutorReuList = m4sllVwAutorReuCustomRepository.findAllVwAutorReuByLitigio(lit_id_litigio);
        return ResponseEntity.ok().body(M4llvWAutorReuList);
    }



    @DeleteMapping("/m4sll_autor_reu/{lit_id_litigio}/{aur_secuencia}")
    public ResponseEntity<Void> deleteM4sllAutorReu(
        // @PathVariable("id_organization") String idOrganization,
        @PathVariable("lit_id_litigio") String litIdLitigio,
        @PathVariable("aur_secuencia") Integer  aurSecuencia
    ) {
        log.debug("REST request to delete m4sll_autor_reu : {} | {} | {}", litIdLitigio, idOrganization, aurSecuencia );
        M4sllAutorReuId id = new M4sllAutorReuId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setAurSecuencia(aurSecuencia);


        m4sllAutorReuRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
