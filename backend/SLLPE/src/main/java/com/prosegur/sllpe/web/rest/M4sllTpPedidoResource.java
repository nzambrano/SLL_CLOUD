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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Transactional
public class M4sllTpPedidoResource {
    private final Logger log = LoggerFactory.getLogger(M4sllTpPedidoResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllTpPedido";

    @Autowired
    M4sllTpPedidoServices m4sllTpPedidoServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllTpPedidoRepository m4sllTpPedidoRepository;

    public M4sllTpPedidoResource(M4sllTpPedidoRepository m4sllTpPedidoRepository) {
        this.m4sllTpPedidoRepository = m4sllTpPedidoRepository;
    }

    @PostMapping("/m4sll_tp_pedido")
    public ResponseEntity<List<M4sllTpPedido>> createM4sllTpPedido(@RequestBody List<M4sllTpPedido> listM4sllTpPedido)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_tp_pedido : {}", listM4sllTpPedido);
        List<M4sllTpPedido>result =  m4sllTpPedidoServices.saveAllWithSecuencia(listM4sllTpPedido);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_pedido/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_tp_pedido")
    public ResponseEntity<List<M4sllTpPedido>> updateM4sllTpPedido(@RequestBody List<M4sllTpPedido> listM4sllTpPedido)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_pedido : {}", listM4sllTpPedido);
        List<M4sllTpPedido> result = m4sllTpPedidoRepository.saveAll(listM4sllTpPedido);
        return ResponseEntity
               .created(new URI("/api/m4sll_tp_pedido/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    // Este Servicio REST esta comentado porque particularmente para esta entidad, apuntaría al mismo End Point que otro que se encuentra habilitado
    /*
        @GetMapping("/m4sll_tp_pedido")
        public ResponseEntity<List<M4sllTpPedido>> getAllM4sllTpPedido() {
          log.debug("REST request to get ALL M4sllTpPedido : {}");

          List<M4sllTpPedido> M4sllTpPedidoAll = m4sllTpPedidoRepository.findAll();
          return ResponseEntity.ok().body(M4sllTpPedidoAll);
        }
    */

    @GetMapping("/m4sll_tp_pedido")
    public ResponseEntity<List<M4sllTpPedido>> getM4sllTpPedido() {
        log.debug("REST request to get M4sllTpPedido : {}", idOrganization);

        List<M4sllTpPedido> M4sllTpPedidoByInput = m4sllTpPedidoRepository.findByIdOrganization(idOrganization);
        return ResponseEntity.ok().body(M4sllTpPedidoByInput);
    }


    @DeleteMapping("/m4sll_tp_pedido/{tpe_id_pedido}")
    public ResponseEntity<Void> deleteM4sllTpPedido(@PathVariable("tpe_id_pedido") String tpeIdPedido) {
        log.debug("REST request to delete m4sll_tp_pedido : {}", idOrganization + "|" + tpeIdPedido);
        M4sllTpPedidoId id = new M4sllTpPedidoId();
        id.setIdOrganization(idOrganization);
        id.setTpeIdPedido(tpeIdPedido);

        m4sllTpPedidoRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_tp_pedido")
  public ResponseEntity<M4sllTpPedido> createM4sllTpPedido(@RequestBody M4sllTpPedido m4sllTpPedido)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_tp_pedido : {}", m4sllTpPedido);
    M4sllTpPedidoId id = new M4sllTpPedidoId();
    M4sllTpPedidoServices m4sllTpPedidoServices = new M4sllTpPedidoServices(m4sllTpPedidoRepository);
    String id_tpeIdPedido = m4sllTpPedidoServices.UltimaSecuencia(m4sllTpPedido);

    id.setTpeIdPedido(id_tpeIdPedido);
    id.setIdOrganization(idOrganization);

    m4sllTpPedido.setId(id);
    M4sllTpPedido result = m4sllTpPedidoRepository.save(m4sllTpPedido);
    return ResponseEntity
      .created(new URI("/api/m4sll_tp_pedido/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_tp_pedido/{tpe_id_pedido}")
  public ResponseEntity<M4sllTpPedido> getM4sllTpPedido(@PathVariable("tpe_id_pedido") String tpeIdPedido) {
      log.debug("REST request to get M4sllTpPedido : {}", idOrganization + "|" + tpeIdPedido);
      M4sllTpPedidoId id = new M4sllTpPedidoId();
      id.setIdOrganization(idOrganization);
      id.setTpeIdPedido(tpeIdPedido);

      Optional<M4sllTpPedido> m4sllTpPedido = m4sllTpPedidoRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllTpPedido);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_tp_pedido")
  public ResponseEntity<Void> deleteM4sllTpPedido() {
    log.debug("REST request to delete m4sll_tp_pedido : {}", idOrganization);
    List<M4sllTpPedido> M4sllTpPedidoByInput = m4sllTpPedidoRepository.findByIdOrganization(idOrganization);

    m4sllTpPedidoRepository.deleteAll(M4sllTpPedidoByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllTpPedidoByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_tp_pedido")
public ResponseEntity<M4sllTpPedido> updateM4sllTpPedido(@RequestBody M4sllTpPedido m4sllTpPedido)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_tp_pedido : {}", m4sllTpPedido);
  if (m4sllTpPedido.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllTpPedido result = m4sllTpPedidoRepository.save(m4sllTpPedido);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllTpPedido.getId().toString()))
    .body(result);
}


*/
