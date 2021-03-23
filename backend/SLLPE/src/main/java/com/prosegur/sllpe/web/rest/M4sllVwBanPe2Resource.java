package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllVwBanPe;
import com.prosegur.sllpe.domain.M4sllVwBanPeId;
import com.prosegur.sllpe.repository.M4sllVwBanPeRepository;
import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;
import com.prosegur.sllpe.repository.M4sllVwBanPe2ConsultaRepository;
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

public class M4sllVwBanPe2Resource {

    private final Logger log = LoggerFactory.getLogger(M4sllVwBanPe2Resource.class);
    private static final String ENTITY_NAME = "sllpeM4sllVwBanPe2";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final M4sllVwBanPe2ConsultaRepository m4sllVwBanPe2ConsultaRepository;

    public M4sllVwBanPe2Resource(M4sllVwBanPe2ConsultaRepository m4sllVwBanPe2ConsultaRepository) {
        this.m4sllVwBanPe2ConsultaRepository = m4sllVwBanPe2ConsultaRepository;
    }

    /**
     * {@code GET  /m4sll_vw_ban_pe_consulta} : get all the m4sll_vw_ban_pe_consulta.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with Bandeja {@code 200 (OK)} and the list of m4sll_vw_ban_pe_consulta in body.
     */

    @GetMapping("/m4sll_vw_ban_pe2_consulta/{lit_id_litigio}/{lit_nro_proceso}")
    public ResponseEntity<List<M4sllVwBanPeConsulta>> getM4sllVwBanPe2Consulta(Pageable pageable, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("lit_nro_proceso") String lit_nro_proceso) {
        log.debug("REST request to get a page of m4sll_vw_ban_pe_consulta : {}");
        Page<M4sllVwBanPeConsulta> page = m4sllVwBanPe2ConsultaRepository.obtenerM4sllVwBanPe2Consulta(pageable, lit_id_litigio, lit_nro_proceso);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

}