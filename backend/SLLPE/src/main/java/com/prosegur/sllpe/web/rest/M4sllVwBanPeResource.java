package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllVwBanPe;
import com.prosegur.sllpe.domain.M4sllVwBanPeId;
import com.prosegur.sllpe.repository.M4sllVwBanPeRepository;
import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;
import com.prosegur.sllpe.repository.M4sllVwBanPeConsultaRepository;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
import io.github.jhipster.web.util.PaginationUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional

public class M4sllVwBanPeResource {

    private final Logger log = LoggerFactory.getLogger(M4sllVwBanPeResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllVwBanPe";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllVwBanPeRepository m4sllVwBanPeRepository;
    private M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;

    public M4sllVwBanPeResource(M4sllVwBanPeRepository m4sllVwBanPeRepository, M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository) {
        this.m4sllVwBanPeRepository = m4sllVwBanPeRepository;
        this.m4sllVwBanPeConsultaRepository = m4sllVwBanPeConsultaRepository;
    }


    @GetMapping("/m4sll_vw_ban_pe")
    public ResponseEntity<List<M4sllVwBanPe>> getAllM4sllVwBanPe() {
        log.debug("REST request to get ALL M4sllVwBanPe : {}");

        List<M4sllVwBanPe> M4sllVwBanPeAll = m4sllVwBanPeRepository.findAll();
        return ResponseEntity.ok().body(M4sllVwBanPeAll);
    }

    /**
     * {@code GET  /m4sll_vw_ban_pe_consulta} : get all the m4sll_vw_ban_pe_consulta.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with Bandeja {@code 200 (OK)} and the list of m4sll_vw_ban_pe_consulta in body.
     */

    @GetMapping("/m4sll_vw_ban_pe_consulta")
    public ResponseEntity<List<M4sllVwBanPeConsulta>> getM4sllVwBanPeConsultas(Pageable pageable) {
        log.debug("REST request to get a page of m4sll_vw_ban_pe_consulta : {}");
        Page<M4sllVwBanPeConsulta> page = m4sllVwBanPeConsultaRepository.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

}