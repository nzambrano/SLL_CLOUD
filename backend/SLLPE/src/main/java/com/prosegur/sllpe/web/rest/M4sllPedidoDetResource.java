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

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllPedidoDetRepository m4sllPedidoDetRepository;

    public M4sllPedidoDetResource(M4sllPedidoDetRepository m4sllPedidoDetRepository) {
        this.m4sllPedidoDetRepository = m4sllPedidoDetRepository;
    }

    @PostMapping("/m4sll_pedido_det")
    public ResponseEntity<M4sllPedidoDet> createM4sllPedidoDet(@RequestBody M4sllPedidoDet m4sll_pedido_det)
    throws URISyntaxException {
        log.debug("REST request to create m4sll_pedido_det : {}", m4sll_pedido_det);
        M4sllPedidoDetId id = new M4sllPedidoDetId();
        M4sllPedidoDetServices m4sllPedidoDetServices = new M4sllPedidoDetServices(m4sllPedidoDetRepository);
        Long id_pde_secuencia = m4sllPedidoDetServices.UltimaSecuencia(m4sll_pedido_det);

        id.setPdeSecuencia(id_pde_secuencia);
        id.setIdOrganization(m4sll_pedido_det.getId().getIdOrganization());
        id.setLitIdLitigio(m4sll_pedido_det.getId().getLitIdLitigio());
        id.setTpeIdPedido(m4sll_pedido_det.getId().getTpeIdPedido());

        m4sll_pedido_det.setId(id);
        M4sllPedidoDet result = m4sllPedidoDetRepository.save(m4sll_pedido_det);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedido_det/" + result.getId()))
               .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_pedido_det")
    public ResponseEntity<M4sllPedidoDet> updateM4sllPedidoDet(@RequestBody M4sllPedidoDet m4sll_pedido_det)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pedido_det : {}", m4sll_pedido_det);
        if (m4sll_pedido_det.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllPedidoDet result = m4sllPedidoDetRepository.save(m4sll_pedido_det);
        return ResponseEntity
               .ok()
               .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, m4sll_pedido_det.getId().toString()))
               .body(result);
    }

    @GetMapping("/m4sll_pedido_det")
    public ResponseEntity<List<M4sllPedidoDet>> getAllM4sllPedidoDet() {
        log.debug("REST request to get ALL M4sllPedidoDet : {}");

        List<M4sllPedidoDet> M4sllPedidoDetAll = m4sllPedidoDetRepository.findAll();
        return ResponseEntity.ok().body(M4sllPedidoDetAll);
    }

    @GetMapping("/m4sll_pedido_det/{id_organization}/{lit_id_litigio}/{tpe_id_pedido}")
    public ResponseEntity<List<M4sllPedidoDet>> getM4sllPedidoDet(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("tpe_id_pedido") String tpe_id_pedido) {
        log.debug("REST request to get M4sllPedidoDet : {}", id_organization + "|" + lit_id_litigio + "|" + tpe_id_pedido);

        List<M4sllPedidoDet> M4sllPedidoDetByInput = m4sllPedidoDetRepository.findByIdOrganizationLitIdLitigioTpeIdPedido(id_organization, lit_id_litigio, tpe_id_pedido);
        return ResponseEntity.ok().body(M4sllPedidoDetByInput);
    }

    @GetMapping("/m4sll_pedido_det/{tpe_id_pedido}/{lit_id_litigio}")
    public ResponseEntity<List<M4sllPedidoDet>> getM4sllPedidoDet(@PathVariable("tpe_id_pedido") String tpe_id_pedido, @PathVariable("lit_id_litigio") String lit_id_litigio) {
        log.debug("REST request to get M4sllPedidoDet : {}", tpe_id_pedido + "|" + lit_id_litigio);

        List<M4sllPedidoDet> M4sllPedidoDetByInput = m4sllPedidoDetRepository.findByTpeIdPedidoLitIdLitigio(tpe_id_pedido, lit_id_litigio);
        return ResponseEntity.ok().body(M4sllPedidoDetByInput);
    }

    /*
      @GetMapping("/m4sll_pedido_det/{id_organization}/{lit_id_litigio}/{tpe_id_pedido}/{pde_secuencia}")
      public ResponseEntity<M4sllPedidoDet> getM4sllPedidoDet(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("tpe_id_pedido") String tpe_id_pedido, @PathVariable("pde_secuencia") Long pde_secuencia) {
          log.debug("REST request to get M4sllPedidoDet : {}", id_organization + "|" + lit_id_litigio + "|" + tpe_id_pedido + "|" + pde_secuencia);
          M4sllPedidoDetId id = new M4sllPedidoDetId();
          id.setIdOrganization(id_organization); id.setLitIdLitigio(lit_id_litigio); id.setTpeIdPedido(tpe_id_pedido);
          id.setPdeSecuencia(pde_secuencia);

          Optional<M4sllPedidoDet> m4sll_pedido_det = m4sllPedidoDetRepository.findById(id);
          return ResponseUtil.wrapOrNotFound(m4sll_pedido_det);
      }

      @DeleteMapping("/m4sll_pedido_det/{id_organization}/{lit_id_litigio}/{tpe_id_pedido}")
      public ResponseEntity<Void> deleteM4sllPedidoDet(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("tpe_id_pedido") String tpe_id_pedido) {
        log.debug("REST request to delete m4sll_pedido_det : {}", id_organization + "|" + lit_id_litigio + "|" + tpe_id_pedido);
        List<M4sllPedidoDet> M4sllPedidoDetByInput = m4sllPedidoDetRepository.findByIdOrganizationLitIdLitigioTpeIdPedido(id_organization, lit_id_litigio, tpe_id_pedido);

        m4sllPedidoDetRepository.deleteAll(M4sllPedidoDetByInput);
        return ResponseEntity
          .noContent()
          .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, M4sllPedidoDetByInput.toString()))
          .build();
    }
    */

    @DeleteMapping("/m4sll_pedido_det/{id_organization}/{lit_id_litigio}/{tpe_id_pedido}/{pde_secuencia}")
    public ResponseEntity<Void> deleteM4sllPedidoDet(@PathVariable("id_organization") String id_organization, @PathVariable("lit_id_litigio") String lit_id_litigio, @PathVariable("tpe_id_pedido") String tpe_id_pedido, @PathVariable("pde_secuencia") Long pde_secuencia) {
        log.debug("REST request to delete m4sll_pedido_det : {}", id_organization + "|" + lit_id_litigio + "|" + tpe_id_pedido + "|" + pde_secuencia);
        M4sllPedidoDetId id = new M4sllPedidoDetId();
        id.setIdOrganization(id_organization);
        id.setLitIdLitigio(lit_id_litigio);
        id.setTpeIdPedido(tpe_id_pedido);
        id.setPdeSecuencia(pde_secuencia);

        m4sllPedidoDetRepository.deleteById(id);
        return ResponseEntity
               .noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }
}
