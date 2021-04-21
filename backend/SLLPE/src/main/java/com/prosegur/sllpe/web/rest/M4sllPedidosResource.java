package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllPedidos;
import com.prosegur.sllpe.domain.M4sllPedidosId;
import com.prosegur.sllpe.repository.M4sllPedidosRepository;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;

import io.github.jhipster.web.util.HeaderUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional

public class M4sllPedidosResource {
    private final Logger log = LoggerFactory.getLogger(M4sllPedidosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllPedidos";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllPedidosRepository m4sllPedidosRepository;

    public M4sllPedidosResource(M4sllPedidosRepository m4sllPedidosRepository) {
        this.m4sllPedidosRepository = m4sllPedidosRepository;
    }
    @PostMapping("/m4sll_pedidos")
    public ResponseEntity<List<M4sllPedidos>> createM4sllPedidos(@RequestBody List<M4sllPedidos> listM4sllPedidos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_pedidos : {}", listM4sllPedidos);
        List<M4sllPedidos> result = m4sllPedidosRepository.saveAll(listM4sllPedidos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedidos/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @PutMapping("/m4sll_pedidos")
    public ResponseEntity<List<M4sllPedidos>> updateM4sllPedidos(@RequestBody List<M4sllPedidos> listM4sllPedidos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pedidos : {}", listM4sllPedidos);
        List<M4sllPedidos> result = m4sllPedidosRepository.saveAll(listM4sllPedidos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedidos/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_pedidos")
    public ResponseEntity<List<M4sllPedidos>> getAllM4sllPedidos() {
        log.debug("REST request to get ALL M4sllPedidos : {}");

        List<M4sllPedidos> M4sllPedidosAll = m4sllPedidosRepository.findAll();
        return ResponseEntity.ok().body(M4sllPedidosAll);
    }

    @GetMapping("/m4sll_pedidos/{lit_id_litigio}/{tpe_id_pedido}")
    public ResponseEntity<M4sllPedidos> getM4sllPedidos(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("tpe_id_pedido") String tpeIdPedido) {
        log.debug("REST request to get M4sllPedidos : {}", idOrganization + "|" + litIdLitigio + "|" + tpeIdPedido);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setTpeIdPedido(tpeIdPedido);

        Optional<M4sllPedidos> m4sllPedidos = m4sllPedidosRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sllPedidos);
    }

    @GetMapping("/m4sll_pedidos/{lit_id_litigio}")
    public ResponseEntity<List<M4sllPedidos>> getM4sllPedidos(@PathVariable("lit_id_litigio") String litIdLitigio) {
        log.debug("REST request to get M4sllPedidos : {}", idOrganization + "|" + litIdLitigio);

        List<M4sllPedidos> M4sllPedidosByInput = m4sllPedidosRepository.findByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio);
        return ResponseEntity.ok().body(M4sllPedidosByInput);
    }

    @DeleteMapping("/m4sll_pedidos/{lit_id_litigio}/{tpe_id_pedido}")
    public ResponseEntity<Void> deleteM4sllPedidos(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("tpe_id_pedido") String tpeIdPedido) {
        log.debug("REST request to delete m4sll_pedidos : {}", idOrganization + "|" + litIdLitigio + "|" + tpeIdPedido);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setTpeIdPedido(tpeIdPedido);

        m4sllPedidosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/m4sll_pedidos")
    public ResponseEntity<M4sllPedidos> createM4sllPedidos(@RequestBody M4sllPedidos m4sllPedidos)
            throws URISyntaxException {
        log.debug("REST request to create m4sll_pedidos : {}", m4sllPedidos);

        M4sllPedidos result = m4sllPedidosRepository.save(m4sllPedidos);
        return ResponseEntity
                .created(new URI("/api/m4sll_pedidos/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un solo registro
    @PutMapping("/m4sll_pedidos")
    public ResponseEntity<M4sllPedidos> updateM4sllPedidos(@RequestBody M4sllPedidos m4sllPedidos)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_pedidos : {}", m4sllPedidos);
        if (m4sllPedidos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllPedidos result = m4sllPedidosRepository.save(m4sllPedidos);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sllPedidos.getId().toString())).body(result);
    }


*/