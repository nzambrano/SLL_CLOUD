package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllPedidoDet;
import com.prosegur.sllpe.domain.M4sllPedidoDetId;
import com.prosegur.sllpe.repository.M4sllPedidoDetRepository;
import com.prosegur.sllpe.service.M4sllPedidoDetServices;
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
public class M4sllPedidoDetResource {
    private final Logger log = LoggerFactory.getLogger(M4sllPedidoDetResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllPedidoDet";

    @Autowired
    M4sllPedidoDetServices m4sllPedidoDetServices;

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    @Value("${idOrganization}")
    private String idOrganization;
    private M4sllPedidoDetRepository m4sllPedidoDetRepository;

    public M4sllPedidoDetResource(M4sllPedidoDetRepository m4sllPedidoDetRepository) {
        this.m4sllPedidoDetRepository = m4sllPedidoDetRepository;
    }

    @PostMapping("/m4sll_pedido_det")
    public ResponseEntity<List<M4sllPedidoDet>> createM4sllPedidoDet(@RequestBody List<M4sllPedidoDet> listM4sllPedidoDet)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_pedido_det : {}", listM4sllPedidoDet);
        List<M4sllPedidoDet>result =  m4sllPedidoDetServices.saveAllWithSecuencia(listM4sllPedidoDet);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedido_det/")).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }


    @PutMapping("/m4sll_pedido_det")
    public ResponseEntity<List<M4sllPedidoDet>> updateM4sllPedidoDet(@RequestBody List<M4sllPedidoDet> listM4sllPedidoDet)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pedido_det : {}", listM4sllPedidoDet);
        List<M4sllPedidoDet> result = m4sllPedidoDetRepository.saveAll(listM4sllPedidoDet);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedido_det/")).headers(HeaderUtil
                       .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
               .body(result);
    }

    @GetMapping("/m4sll_pedido_det")
    public ResponseEntity<List<M4sllPedidoDet>> getAllM4sllPedidoDet() {
        log.debug("REST request to get ALL M4sllPedidoDet : {}");

        List<M4sllPedidoDet> M4sllPedidoDetAll = m4sllPedidoDetRepository.findAll();
        return ResponseEntity.ok().body(M4sllPedidoDetAll);
    }

    @GetMapping("/m4sll_pedido_det/{lit_id_litigio}/{tpe_id_pedido}")
    public ResponseEntity<List<M4sllPedidoDet>> getM4sllPedidoDet(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("tpe_id_pedido") String tpeIdPedido) {
        log.debug("REST request to get M4sllPedidoDet : {}", idOrganization + "|" + litIdLitigio + "|" + tpeIdPedido);

        List<M4sllPedidoDet> M4sllPedidoDetByInput = m4sllPedidoDetRepository.findByIdOrganizationLitIdLitigioTpeIdPedido(idOrganization, litIdLitigio, tpeIdPedido);
        return ResponseEntity.ok().body(M4sllPedidoDetByInput);
    }


    @DeleteMapping("/m4sll_pedido_det/{lit_id_litigio}/{tpe_id_pedido}/{pde_secuencia}")
    public ResponseEntity<Void> deleteM4sllPedidoDet(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("tpe_id_pedido") String tpeIdPedido, @PathVariable("pde_secuencia") Long pdeSecuencia) {
        log.debug("REST request to delete m4sll_pedido_det : {}", idOrganization + "|" + litIdLitigio + "|" + tpeIdPedido + "|" + pdeSecuencia);
        M4sllPedidoDetId id = new M4sllPedidoDetId();
        id.setIdOrganization(idOrganization);
        id.setLitIdLitigio(litIdLitigio);
        id.setTpeIdPedido(tpeIdPedido);
        id.setPdeSecuencia(pdeSecuencia);

        m4sllPedidoDetRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
/*
// PostMapping para un solo registro
  @PostMapping("/m4sll_pedido_det")
  public ResponseEntity<M4sllPedidoDet> createM4sllPedidoDet(@RequestBody M4sllPedidoDet m4sllPedidoDet)
    throws URISyntaxException {
    log.debug("REST request to create m4sll_pedido_det : {}", m4sllPedidoDet);
    M4sllPedidoDetId id = new M4sllPedidoDetId();
    M4sllPedidoDetServices m4sllPedidoDetServices = new M4sllPedidoDetServices(m4sllPedidoDetRepository);
    Long id_pdeSecuencia = m4sllPedidoDetServices.UltimaSecuencia(m4sllPedidoDet);

    id.setPdeSecuencia(id_pdeSecuencia);
    id.setIdOrganization(idOrganization);
id.setLitIdLitigio(m4sllPedidoDet.getId().getLitIdLitigio());
id.setTpeIdPedido(m4sllPedidoDet.getId().getTpeIdPedido());

    m4sllPedidoDet.setId(id);
    M4sllPedidoDet result = m4sllPedidoDetRepository.save(m4sllPedidoDet);
    return ResponseEntity
      .created(new URI("/api/m4sll_pedido_det/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

// GetMapping para un solo registro
  @GetMapping("/m4sll_pedido_det/{lit_id_litigio}/{tpe_id_pedido}/{pde_secuencia}")
  public ResponseEntity<M4sllPedidoDet> getM4sllPedidoDet(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("tpe_id_pedido") String tpeIdPedido, @PathVariable("pde_secuencia") Long pdeSecuencia) {
      log.debug("REST request to get M4sllPedidoDet : {}", idOrganization + "|" + litIdLitigio + "|" + tpeIdPedido + "|" + pdeSecuencia);
      M4sllPedidoDetId id = new M4sllPedidoDetId();
      id.setIdOrganization(idOrganization);
id.setLitIdLitigio(litIdLitigio);
id.setTpeIdPedido(tpeIdPedido);
      id.setPdeSecuencia(pdeSecuencia);

      Optional<M4sllPedidoDet> m4sllPedidoDet = m4sllPedidoDetRepository.findById(id);
      return ResponseUtil.wrapOrNotFound(m4sllPedidoDet);
  }

// DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
  @DeleteMapping("/m4sll_pedido_det/{lit_id_litigio}/{tpe_id_pedido}")
  public ResponseEntity<Void> deleteM4sllPedidoDet(@PathVariable("lit_id_litigio") String litIdLitigio, @PathVariable("tpe_id_pedido") String tpeIdPedido) {
    log.debug("REST request to delete m4sll_pedido_det : {}", idOrganization + "|" + litIdLitigio + "|" + tpeIdPedido);
    List<M4sllPedidoDet> M4sllPedidoDetByInput = m4sllPedidoDetRepository.findByIdOrganizationLitIdLitigioTpeIdPedido(idOrganization, litIdLitigio, tpeIdPedido);

    m4sllPedidoDetRepository.deleteAll(M4sllPedidoDetByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllPedidoDetByInput.toString()))
      .build();
}

// PutMapping para un registro
@PutMapping("/m4sll_pedido_det")
public ResponseEntity<M4sllPedidoDet> updateM4sllPedidoDet(@RequestBody M4sllPedidoDet m4sllPedidoDet)
  throws URISyntaxException {
  log.debug("REST request to update m4sll_pedido_det : {}", m4sllPedidoDet);
  if (m4sllPedidoDet.getId() == null) {
    throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
  }
  M4sllPedidoDet result = m4sllPedidoDetRepository.save(m4sllPedidoDet);
  return ResponseEntity
    .ok()
    .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sllPedidoDet.getId().toString()))
    .body(result);
}


*/
