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
    private string idOrganization = "0050";
    private final Logger log = LoggerFactory.getLogger(M4sllPedidosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllPedidos";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllPedidosRepository m4sllPedidosRepository;

    public M4sllPedidosResource(M4sllPedidosRepository m4sllPedidosRepository) {
        this.m4sllPedidosRepository = m4sllPedidosRepository;
    }

    @PostMapping("/m4sll_pedidos")
    public ResponseEntity<List<M4sllPedidos>> createM4sllPedidos(@RequestBody List<M4sllPedidos> listM4sll_pedidos)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_pedidos : {}", listM4sll_pedidos);

        List<M4sllPedidos> result = m4sllPedidosRepository.saveAll(listM4sll_pedidos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedidos/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, ""))
               .body(result);
    }

    @PutMapping("/m4sll_pedidos")
    public ResponseEntity<M4sllPedidos> updateM4sllPedidos(@RequestBody M4sllPedidos m4sll_pedidos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pedidos : {}", m4sll_pedidos);
        if (m4sll_pedidos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllPedidos result = m4sllPedidosRepository.save(m4sll_pedidos);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_pedidos.getId().toString())).body(result);
    }

    @GetMapping("/m4sll_pedidos")
    public ResponseEntity<List<M4sllPedidos>> getAllM4sllPedidos() {
        log.debug("REST request to get ALL M4sllPedidos : {}");

        List<M4sllPedidos> M4sllPedidosAll = m4sllPedidosRepository.findAll();
        return ResponseEntity.ok().body(M4sllPedidosAll);
    }

    @GetMapping("/m4sll_pedidos/{lit_id_litigio}/{tpe_id_pedido}")
    public ResponseEntity<M4sllPedidos> getM4sllPedidos(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("tpe_id_pedido") String tpe_id_pedido) {
        log.debug("REST request to get M4sllPedidos : {}", id_organization + "|" + lit_id_litigio + "|" + tpe_id_pedido);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(lit_id_litigio);
        id.setTpeIdPedido(tpe_id_pedido);

        Optional<M4sllPedidos> m4sll_pedidos = m4sllPedidosRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_pedidos);
    }

    @GetMapping("/m4sll_pedidos/{lit_id_litigio}")
    public ResponseEntity<List<M4sllPedidos>> getM4sllPedidos(@PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllPedidos : {}", idOrganization + "|" + lit_id_litigio);

        List<M4sllPedidos> M4sllPedidosByInput = m4sllPedidosRepository.findByIdOrganizationLitIdLitigio(idOrganization, lit_id_litigio);
        return ResponseEntity.ok().body(M4sllPedidosByInput);
    }

    @DeleteMapping("/m4sll_pedidos/{lit_id_litigio}/{tpe_id_pedido}")
    public ResponseEntity<Void> deleteM4sllPedidos(@PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("tpe_id_pedido") String tpe_id_pedido) {
        log.debug("REST request to delete m4sll_pedidos : {}", idOrganization + "|" + lit_id_litigio + "|" + tpe_id_pedido);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(lit_id_litigio);
        id.setTpeIdPedido(tpe_id_pedido);

        m4sllPedidosRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}