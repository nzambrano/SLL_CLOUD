package com.prosegur.sllpe.web.rest;


import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;
import com.prosegur.sllpe.repository.M4sllVwBanPeConsultaRepository;



import io.github.jhipster.web.util.PaginationUtil;

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


import java.util.List;


@RestController
@RequestMapping("/api")
@Transactional

public class M4sllVwBanPeResource {

    private final Logger log = LoggerFactory.getLogger(M4sllVwBanPeResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllVwBanPe";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;

    public M4sllVwBanPeResource(M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository) {
        this.m4sllVwBanPeConsultaRepository = m4sllVwBanPeConsultaRepository;
    }

    /**
     * {@code GET  /m4sll_vw_ban_pe_consulta} : get all the m4sll_vw_ban_pe_consulta.
     *
     * @param pageable the pagination information.
     * @return the {@link ResponseEntity} with Bandeja {@code 200 (OK)} and the list of m4sll_vw_ban_pe_consulta in body.
     */

    @GetMapping("/m4sll_vw_ban_pe_consulta/{lit_id_litigio}/{lit_nro_proceso}")
    public ResponseEntity<List<M4sllVwBanPeConsulta>> getM4sllVwBanPeConsulta(Pageable pageable, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("lit_nro_proceso") String lit_nro_proceso) {
        log.debug("REST request to get a page of m4sll_vw_ban_pe_consulta : {}");
        Page<M4sllVwBanPeConsulta> page = m4sllVwBanPeConsultaRepository.obtenerM4sllVwBanPeConsulta(pageable, lit_id_litigio, lit_nro_proceso);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

}
