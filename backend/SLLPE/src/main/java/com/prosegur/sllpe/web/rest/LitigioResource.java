package com.prosegur.sllpe.web.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.prosegur.sllpe.domain.M4sllLitigiosId;

import com.prosegur.sllpe.repository.M4sllFasesRepository;
import com.prosegur.sllpe.repository.M4sllLitigiosRepository;
import com.prosegur.sllpe.repository.M4sllPedidosRepository;
import com.prosegur.sllpe.repository.M4sllProvisionesRepository;
import com.prosegur.sllpe.repository.SllVwAutorReuRepository;



/**
 * FooResource controller
 */
@RestController
@RequestMapping("/api/litigio")
public class LitigioResource {

    private final Logger log = LoggerFactory.getLogger(LitigioResource.class);

    private M4sllLitigiosRepository litigiosRepository;
    private M4sllPedidosRepository pedidosRepository;
    private M4sllFasesRepository fasesRepository;
    private SllVwAutorReuRepository sllVwAutorReuRepository;
    private M4sllProvisionesRepository provisionesRepository;

    private  String idOrganization = "0050";

    public LitigioResource(
        M4sllLitigiosRepository litigiosRepository,
        SllVwAutorReuRepository sllVwAutorReuRepository,
        M4sllPedidosRepository pedidosRepository,
        M4sllFasesRepository fasesRepository,
        M4sllProvisionesRepository provisionesRepository


    ) {

        this.litigiosRepository = litigiosRepository;
        this.sllVwAutorReuRepository = sllVwAutorReuRepository;
        this.pedidosRepository = pedidosRepository;
        this.fasesRepository = fasesRepository;
        this.provisionesRepository = provisionesRepository;

    }


    /**
     * GET listar
     *
     * @throws JSONException
     */
    @GetMapping("/{id_litIdLitigio}")
    public ResponseEntity<Object> listar(
        @PathVariable("id_litIdLitigio") String litIdLitigio
    ) {
        List<HashMap<String, Object>> entities = new ArrayList<HashMap<String, Object>>();
        HashMap<String, Object> map = new HashMap<>();

        M4sllLitigiosId id = new M4sllLitigiosId();
        id.setLitIdLitigio(litIdLitigio);
        id.setIdOrganization(idOrganization);
        map.put("EXPEDIENTE", litigiosRepository.findById(id));
        map.put("SLL_AUTOR_REU", sllVwAutorReuRepository.findAllVwAutorReuByLitigio(litIdLitigio));
        // map.put("PEDIDOS", pedidosRepository.findPedidosByLitigio(idOrganization, litIdLitigio));
        map.put("PEDIDOS", pedidosRepository.findM4sllPedidosByIdOrganizationLitIdLitigio(idOrganization, litIdLitigio));
        map.put("SLL_FASES", fasesRepository.getFases(idOrganization, litIdLitigio));
        map.put("SLL_PROV", provisionesRepository.getProvisionByLitigio(idOrganization, litIdLitigio));

        // map.put("abogados", abogadosRepository.findAbogados("0050"));
        // map.put("negocios", negociosRepository.findNegocioByPais("0050"));



        entities.add(map);
        return new ResponseEntity<Object>(entities, HttpStatus.OK);
    }



}
