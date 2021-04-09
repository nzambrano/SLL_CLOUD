package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.domain.M4sllTpPedidoId;
import com.prosegur.sllpe.repository.M4sllTpPedidoRepository;
import com.prosegur.sllpe.service.M4sllTpPedidoServices;
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
public class M4sllTpPedidoResource {

    private final Logger log = LoggerFactory.getLogger(M4sllTpPedidoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpPedido";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllTpPedidoRepository m4sllTpPedidoRepository;

    public M4sllTpPedidoResource(M4sllTpPedidoRepository m4sllTpPedidoRepository) {
        this.m4sllTpPedidoRepository = m4sllTpPedidoRepository;
    }

    @PostMapping("/m4sll_tp_pedido")
    public ResponseEntity<M4sllTpPedido> createM4sllTpPedido(@RequestBody M4sllTpPedido m4sll_tp_pedido)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_pedido : {}", m4sll_tp_pedido);
        M4sllTpPedidoId id = new M4sllTpPedidoId();
        M4sllTpPedidoServices m4sllTpPedidoServices = new M4sllTpPedidoServices(m4sllTpPedidoRepository);
        String id_tpe_id_pedido = m4sllTpPedidoServices.UltimaSecuencia(m4sll_tp_pedido);

        id.setTpeIdPedido(id_tpe_id_pedido);
        id.setIdOrganization(m4sll_tp_pedido.getId().getIdOrganization());

        m4sll_tp_pedido.setId(id);
        M4sllTpPedido result = m4sllTpPedidoRepository.save(m4sll_tp_pedido);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_pedido/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_tp_pedido")
    public ResponseEntity<M4sllTpPedido> updateM4sllTpPedido(@RequestBody M4sllTpPedido m4sll_tp_pedido)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_pedido : {}", m4sll_tp_pedido);
        if (m4sll_tp_pedido.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpPedido result = m4sllTpPedidoRepository.save(m4sll_tp_pedido);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_tp_pedido.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_tp_pedido")
    public ResponseEntity<List<M4sllTpPedido>> getAllM4sllTpPedido() {
        log.debug("REST request to get ALL M4sllTpPedido : {}");

        List<M4sllTpPedido> M4sllTpPedidoAll = m4sllTpPedidoRepository.findAll();
        return ResponseEntity.ok().body(M4sllTpPedidoAll);
    }

    @GetMapping("/m4sll_tp_pedido/{id_organization}")
    public ResponseEntity<List<M4sllTpPedido>> getM4sllTpPedido(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to get M4sllTpPedido : {}", id_organization);

        List<M4sllTpPedido> M4sllTpPedidoByInput = m4sllTpPedidoRepository.findByIdOrganization(id_organization);
        return ResponseEntity.ok().body(M4sllTpPedidoByInput);
    }


    /*
      @GetMapping("/m4sll_tp_pedido/{id_organization}/{tpe_id_pedido}")
      public ResponseEntity<M4sllTpPedido> getM4sllTpPedido(@PathVariable("id_organization") String id_organization, @PathVariable("tpe_id_pedido") String tpe_id_pedido) {
          log.debug("REST request to get M4sllTpPedido : {}", id_organization + "|" + tpe_id_pedido);
          M4sllTpPedidoId id = new M4sllTpPedidoId();
          id.setIdOrganization(id_organization);
          id.setTpeIdPedido(tpe_id_pedido);

          Optional<M4sllTpPedido> m4sll_tp_pedido = m4sllTpPedidoRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_tp_pedido);
      }

      @DeleteMapping("/m4sll_tp_pedido/{id_organization}")
      public ResponseEntity<Void> deleteM4sllTpPedido(@PathVariable("id_organization") String id_organization) {
        log.debug("REST request to delete m4sll_tp_pedido : {}", id_organization);
        List<M4sllTpPedido> M4sllTpPedidoByInput = m4sllTpPedidoRepository.findByIdOrganization(id_organization);

        m4sllTpPedidoRepository.deleteAll(M4sllTpPedidoByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpPedidoByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_tp_pedido/{id_organization}/{tpe_id_pedido}")
    public ResponseEntity<Void> deleteM4sllTpPedido(@PathVariable("id_organization") String id_organization, @PathVariable("tpe_id_pedido") String tpe_id_pedido) {
        log.debug("REST request to delete m4sll_tp_pedido : {}", id_organization + "|" + tpe_id_pedido);
        M4sllTpPedidoId id = new M4sllTpPedidoId();
        id.setIdOrganization(id_organization);
        id.setTpeIdPedido(tpe_id_pedido);

        m4sllTpPedidoRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
