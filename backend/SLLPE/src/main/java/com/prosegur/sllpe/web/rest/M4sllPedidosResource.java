package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.M4sllPedidos;
import com.prosegur.sllpe.domain.M4sllPedidosId;
import com.prosegur.sllpe.repository.M4sllPedidosRepository;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;
import com.prosegur.sllpe.service.PedidoServices;

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

public class M4sllPedidosResource {

    private final Logger log = LoggerFactory.getLogger(M4sllPedidosResource.class);
    private static final String ENTITY_NAME = "sllpeM4sllPedidos";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private M4sllPedidosRepository M4sllPedidosRepository;

    public M4sllPedidosResource(M4sllPedidosRepository M4sllPedidosRepository) {
        this.M4sllPedidosRepository = M4sllPedidosRepository;
    }


    @PostMapping("/m4sll_pedidos")
    public ResponseEntity<M4sllPedidos> createM4sllPedidos(@RequestBody M4sllPedidos m4sll_pedidos)
    throws URISyntaxException {

        log.debug("REST request to create m4sll_pedidos : {}", m4sll_pedidos);

        M4sllPedidosId id = new M4sllPedidosId();
        PedidoServices pedidoServices = new PedidoServices(M4sllPedidosRepository);
        Long ped_secuencia = pedidoServices.UltimaSecuencia(m4sll_pedidos);

        id.setPedSecuencia(ped_secuencia);
        id.setIdOrganization(m4sll_pedidos.getId().getIdOrganization());
        id.setLitIdLitigio(m4sll_pedidos.getId().getLitIdLitigio());
        id.setTpeIdPedido(m4sll_pedidos.getId().getTpeIdPedido());

        m4sll_pedidos.setId(id);
        M4sllPedidos result = M4sllPedidosRepository.save(m4sll_pedidos);
        return ResponseEntity
               .created(new URI("/api/m4sll_pedidos/" + result.getId())).headers(HeaderUtil
                       .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
               .body(result);
    }

    @PutMapping("/m4sll_pedidos")
    public ResponseEntity<M4sllPedidos> updateM4sllPedidos(@RequestBody M4sllPedidos m4sll_pedidos)
    throws URISyntaxException {
        log.debug("REST request to update m4sll_pedidos : {}", m4sll_pedidos);
        if (m4sll_pedidos.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        M4sllPedidos result = M4sllPedidosRepository.save(m4sll_pedidos);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                                           m4sll_pedidos.getId().toString())).body(result);
    }

    @GetMapping("/m4sll_pedidos/{id_idOrganization}/{id_litIdLitigio}")
    public ResponseEntity<List<M4sllPedidos>> getAllM4sllPedidos(
        @PathVariable("id_idOrganization") String id_idOrganization,
        @PathVariable("id_litIdLitigio") String id_litIdLitigio
    ) {
        log.debug("REST request to get ALL M4sllPedidos : {}",id_idOrganization,id_litIdLitigio);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setIdOrganization(id_idOrganization);
        id.setLitIdLitigio(id_litIdLitigio);

        List<M4sllPedidos> M4sllPedidosAll = M4sllPedidosRepository.findPedidosByLitigio(
                id_idOrganization,
                id_litIdLitigio
                                             );
        return ResponseEntity.ok().body(M4sllPedidosAll);
    }

    @GetMapping("/m4sll_pedidos/{id_idOrganization}/{id_litIdLitigio}/{id_tpeIdPedido}")
    public ResponseEntity<M4sllPedidos> getM4sllPedidos(
        @PathVariable("id_litIdLitigio") String id_litIdLitigio,
        @PathVariable("id_tpeIdPedido") String id_tpeIdPedido,
        @PathVariable("id_idOrganization") String id_idOrganization) {
        log.debug("REST request to get m4sll_pedidos : {} | {}", id_litIdLitigio, id_idOrganization,id_tpeIdPedido);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setTpeIdPedido(id_tpeIdPedido);
        id.setLitIdLitigio(id_litIdLitigio);
        id.setIdOrganization(id_idOrganization);

        Optional<M4sllPedidos> m4sll_pedidos = M4sllPedidosRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(m4sll_pedidos);
    }

    @DeleteMapping("/m4sll_pedidos/{id_tpeIdPedido}/{id_litIdLitigio}/{id_idOrganization}")
    public ResponseEntity<Void> deleteM4sllPedidos(
        @PathVariable("id_tpeIdPedido") String id_tpeIdPedido,
        @PathVariable("id_litIdLitigio") String id_litIdLitigio,
        @PathVariable("id_idOrganization") String id_idOrganization) {
        log.debug("REST request to delete m4sll_pedidos : {} | {}",id_tpeIdPedido,id_litIdLitigio,id_idOrganization);
        M4sllPedidosId id = new M4sllPedidosId();
        id.setLitIdLitigio(id_litIdLitigio);
        id.setIdOrganization(id_idOrganization);
        id.setTpeIdPedido(id_tpeIdPedido);

        M4sllPedidosRepository.deleteById(id);
        return ResponseEntity.noContent()
               .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
               .build();
    }

}