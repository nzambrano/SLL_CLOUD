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

import com.prosegur.sllpe.repository.M4sllMtAbogadosRepository;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;


/**
 * FooResource controller
 */
@RestController
@RequestMapping("/api/maestros")
public class MaestrosResource {

    private final Logger log = LoggerFactory.getLogger(MaestrosResource.class);

    private M4sllMtAbogadosRepository abogadosRepository;
    private M4sllNegociosRepository negociosRepository;



    public MaestrosResource(
        M4sllMtAbogadosRepository abogadosRepository,
        M4sllNegociosRepository negociosRepository

    ) {

        this.abogadosRepository = abogadosRepository;
        this.negociosRepository = negociosRepository;

    }

    /**
     * GET listar
     *
     * @throws JSONException
     */
    @GetMapping("/listarMaestros")
    public ResponseEntity<Object> listar() {
        List<HashMap<String, Object>> entities = new ArrayList<HashMap<String, Object>>();
        HashMap<String, Object> map = new HashMap<>();
        // map.put("litigio", litigiosRepository.findAll());
        map.put("M4SLL_MT_ABOGADOS", abogadosRepository.findByIdOrganization("0050"));
        map.put("M4SLL_NEGOCIOS", negociosRepository.findByIdOrganization("0050"));



        entities.add(map);
        return new ResponseEntity<Object>(entities, HttpStatus.OK);
    }


    @GetMapping("/listarMaestro/{id}")
    public ResponseEntity<Object> listarFiltrado(@PathVariable String id) {
        List<HashMap<String, Object>> entities = new ArrayList<HashMap<String, Object>>();

        if(id.equals("negocios")) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("negocios", negociosRepository.findByIdOrganization("0050"));
            entities.add(map);
        } else if(id.equals("status")) {
            HashMap<String, Object> map = new HashMap<>();
            //map.put("Status", fasesRepository.findAll());
            entities.add(map);
        }

        return new ResponseEntity<Object>(entities, HttpStatus.OK);



    }
}
