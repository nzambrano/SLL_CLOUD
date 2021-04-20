package com.prosegur.sllpe.web.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.prosegur.sllpe.service.SeguridadService;








/**
 * FooResource controller
 */


@RestController
@RequestMapping("/api/")
public class SeguridadResource {

    private final Logger log = LoggerFactory.getLogger(SeguridadResource.class);

    @Autowired
    private SeguridadService seguridadService;



    /**
     * GET listar
     *
     * @throws JSONException
     */
    @GetMapping("/seguridad/roles")
    public ResponseEntity<List<String>> getRoles() {
    	List<String> roles = this.seguridadService.getRoles();
    	return ResponseEntity.ok().body(roles);
    }



}
