package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllTpPedido;
import com.prosegur.sllpe.domain.M4sllTpPedidoId;
import com.prosegur.sllpe.repository.M4sllTipoPedidoRepository;
import com.prosegur.sllpe.service.TpPedidoServices;
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

    /* Select en BD */
    @GetMapping("/m4sll_tp_pedido/{id_organization}")
    public ResponseEntity<List<M4sllTpPedido>> getAllM4sllTpPedido(
        @PathVariable("id_organization") String idOrganization
    ) {
        log.debug("REST request to get ALL M4sllTpPedido : {}");

        List<M4sllTpPedido> M4sllTpPedidoAll = M4sllTipoPedidoRepository.findTpPedido(idOrganization);
        return ResponseEntity.ok().body(M4sllTpPedidoAll);
    }

    /* Update en la BD */
    @PutMapping("/m4sll_tp_pedido")
    public ResponseEntity<M4sllTpPedido> updateM4sllTpPedido(@RequestBody M4sllTpPedido m4sll_tp_pedido)
            throws URISyntaxException {
        log.debug("REST request to update m4sll_tp_pedido : {}", m4sll_tp_pedido);
        if (m4sll_tp_pedido.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllTpPedido result = M4sllTipoPedidoRepository.save(m4sll_tp_pedido);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                m4sll_tp_pedido.getId().toString())).body(result);
    }

    /* Insert en la BD */
    @PostMapping("/m4sll_tp_pedido")
    public ResponseEntity<M4sllTpPedido> createM4sllTpPedido(@RequestBody M4sllTpPedido m4sll_tp_pedido)
            throws URISyntaxException {

        log.debug("REST request to create m4sll_tp_pedido : {}", m4sll_tp_pedido);
        
        M4sllTpPedidoId id = new M4sllTpPedidoId();
        
        TpPedidoServices tpPedidoServices = new TpPedidoServices(M4sllTipoPedidoRepository);
        String tpe_id_pedido = tpPedidoServices.UltimaSecuencia(m4sll_tp_pedido).toString();
        
        id.setIdOrganization(m4sll_tp_pedido.getId().getIdOrganization());
        id.setTpeIdPedido(tpe_id_pedido);
        
        m4sll_tp_pedido.setId(id);

        M4sllTpPedido result = M4sllTipoPedidoRepository.save(m4sll_tp_pedido);
        return ResponseEntity
                .created(new URI("/api/m4sll_tp_pedido/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }
    
    /* Delete en la BD */
    @DeleteMapping("/m4sll_tp_pedido/{id_organization}/{tpe_id_pedido}")
    public ResponseEntity<Void> deleteM4sllTpPedido(
    		@PathVariable("id_organization") String idOrganization,
            @PathVariable("tpe_id_pedido") String idTpPedido
            ) {

        log.debug("REST request to delete m4sll_tp_pedido : {} | {}", idOrganization, idTpPedido);
        M4sllTpPedidoId id = new M4sllTpPedidoId();

        id.setIdOrganization(idOrganization);
        id.setTpeIdPedido(idTpPedido);
 
        M4sllTipoPedidoRepository.deleteById(id);
        return ResponseEntity.noContent()
                .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
                .build();
    }
}