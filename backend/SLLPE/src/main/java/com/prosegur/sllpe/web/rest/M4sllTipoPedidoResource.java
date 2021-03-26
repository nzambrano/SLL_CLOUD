package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.domain.M4sllTpPedidoId;
import com.prosegur.sllpe.repository.M4sllTipoPedidoRepository;
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

public class M4sllTipoPedidoResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTipoPedidoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTipoPedido";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTipoPedidoRepository M4sllTipoPedidoRepository;

    public M4sllTipoPedidoResource(M4sllTipoPedidoRepository M4sllTipoPedidoRepository) {
        this.M4sllTipoPedidoRepository = M4sllTipoPedidoRepository;
    }

    @GetMapping("/m4sll_tp_pedido/{id_organization}")
    public ResponseEntity<List<M4sllTpPedido>> getAllM4sllTpPedido(
        @PathVariable("id_organization") String idOrganization
    ) {
        log.debug("REST request to get ALL M4sllTpPedido : {}");

        List<M4sllTpPedido> M4sllTpPedidoAll = M4sllTipoPedidoRepository.findTpPedido(idOrganization);
        return ResponseEntity.ok().body(M4sllTpPedidoAll);
    }
}