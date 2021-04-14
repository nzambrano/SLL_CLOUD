package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;
import com.prosegur.sllpe.repository.TableNamePlaceholderRepository;
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

public class TableNamePlaceholderResource {
    private final Logger log = LoggerFactory.getLogger(TableNamePlaceholderResource.class);
    private static final String ENTITY_NAME = "sllpeTableNamePlaceholder";
    @Value("${jhipster.clientApp.name}")
    private String applicationName;

//CustomLinesColsEv    @Value("${ColsEvNamePlaceholder}") private ColsEvDatatype ColsEvNamePlaceholder;

    private TableNamePlaceholderRepository tableNamePlaceholderRepository;

    public TableNamePlaceholderResource(TableNamePlaceholderRepository tableNamePlaceholderRepository) {
        this.tableNamePlaceholderRepository = tableNamePlaceholderRepository;
    }
  @PostMapping("/table_name_placeholder")
  public ResponseEntity<List<TableNamePlaceholder>> createTableNamePlaceholder(@RequestBody List<TableNamePlaceholder> listTableNamePlaceholder)
    throws URISyntaxException {
    log.debug("REST request to create table_name_placeholder : {}", listTableNamePlaceholder);
    List<M4sllPedidos> result = tableNamePlaceholderRepository.saveAll(listTableNamePlaceholder);
    return ResponseEntity
      .created(new URI("/api/m4sll_pedidos/")).headers(HeaderUtil
      .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.toString()))
      .body(result);
  }


    @PutMapping("/table_name_placeholder")
    public ResponseEntity<TableNamePlaceholder> updateTableNamePlaceholder(@RequestBody TableNamePlaceholder tableNamePlaceholder)
            throws URISyntaxException {
        log.debug("REST request to update table_name_placeholder : {}", tableNamePlaceholder);
        if (tableNamePlaceholder.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        TableNamePlaceholder result = tableNamePlaceholderRepository.save(tableNamePlaceholder);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME,
                tableNamePlaceholder.getId().toString())).body(result);
    }

    @GetMapping("/table_name_placeholder")
    public ResponseEntity<List<TableNamePlaceholder>> getAllTableNamePlaceholder() {
        log.debug("REST request to get ALL TableNamePlaceholder : {}");

        List<TableNamePlaceholder> TableNamePlaceholderAll = tableNamePlaceholderRepository.findAll();
        return ResponseEntity.ok().body(TableNamePlaceholderAll);
    }

  @GetMapping("/table_name_placeholder/{colsnotsec_placeholder}")
  public ResponseEntity<TableNamePlaceholder> getTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder) {
    log.debug("REST request to get TableNamePlaceholder : {}", debugcolsnotsec_placeholder);
    TableNamePlaceholderId id = new TableNamePlaceholderId();
    id.setColsNotSecPlaceholder(cols_not_sec_placeholder);        

    Optional<TableNamePlaceholder> tableNamePlaceholder = tableNamePlaceholderRepository.findById(id);
    return ResponseUtil.wrapOrNotFound(tableNamePlaceholder);
  }

//CustomLinesCustomGet1   @GetMapping("/table_name_placeholder/{colscustom_placeholder}")
//CustomLinesCustomGet1   public ResponseEntity<List<TableNamePlaceholder>> getTableNamePlaceholder(@PathVariable("colscustom_placeholder") ColscustomDatatype colscustom_placeholder) {
//CustomLinesCustomGet1     log.debug("REST request to get TableNamePlaceholder : {}", debugcolscustom_placeholder);
//CustomLinesCustomGet1 
//CustomLinesCustomGet1     List<TableNamePlaceholder> TableNamePlaceholderByInput = tableNamePlaceholderRepository.findByColsCustomPlaceholder(colscustom_placeholder);
//CustomLinesCustomGet1     return ResponseEntity.ok().body(TableNamePlaceholderByInput);
//CustomLinesCustomGet1   }

  @DeleteMapping("/table_name_placeholder/{colsnotsec_placeholder}")
  public ResponseEntity<Void> deleteTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder) {
    log.debug("REST request to delete table_name_placeholder : {}", debugcolsnotsec_placeholder);
    TableNamePlaceholderId id = new TableNamePlaceholderId();
    id.setColsNotSecPlaceholder(cols_not_sec_placeholder);        

    tableNamePlaceholderRepository.deleteById(id);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, id.toString()))
      .build();
  }
}

/*
  // PostMapping para un solo registro
    @PostMapping("/table_name_placeholder")
    public ResponseEntity<TableNamePlaceholder> createTableNamePlaceholder(@RequestBody TableNamePlaceholder tableNamePlaceholder)
            throws URISyntaxException {
        log.debug("REST request to create table_name_placeholder : {}", tableNamePlaceholder);

        TableNamePlaceholder result = tableNamePlaceholderRepository.save(tableNamePlaceholder);
        return ResponseEntity
                .created(new URI("/api/table_name_placeholder/" + result.getId())).headers(HeaderUtil
                        .createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
                .body(result);
    }

  // PutMapping para un muchos registros
    @PutMapping("/table_name_placeholder")
    public <List<ResponseEntity<TableNamePlaceholder>> updateTableNamePlaceholder(@RequestBody List<TableNamePlaceholder> listTableNamePlaceholder)
      throws URISyntaxException {
      log.debug("REST request to update table_name_placeholder : {}", listTableNamePlaceholder);
      List<M4sllPedidos> result = tableNamePlaceholderRepository.saveAll(listTableNamePlaceholder);
      return ResponseEntity
        .created(new URI("/api/m4sll_pedidos/")).headers(HeaderUtil
        .createEntityUpdateAlert(applicationName, false, ENTITY_NAME, result.toString()))
        .body(result);
*/