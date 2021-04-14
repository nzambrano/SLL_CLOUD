package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;
import com.prosegur.sllpe.repository.TableNamePlaceholderRepository;
import com.prosegur.sllpe.service.TableNamePlaceholderServices;
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
public class TableNamePlaceholderResource {

//CustomLinesColsEv    private ColsEvDatatype ColsEvNamePlaceholder = System.getenv().get("COLS_EV_NAMES_PLACEHOLDER");

  private final Logger log = LoggerFactory.getLogger(TableNamePlaceholderResource.class);
  private static final String ENTITY_NAME = "sllpeTableNamePlaceholder";

  @Value("${jhipster.clientApp.name}")
  private String applicationName;

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
    return ResponseEntity
      .ok()
      .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, tableNamePlaceholder.getId().toString()))
      .body(result);
  }

  @GetMapping("/table_name_placeholder")
  public ResponseEntity<List<TableNamePlaceholder>> getAllTableNamePlaceholder() {
    log.debug("REST request to get ALL TableNamePlaceholder : {}");

    List<TableNamePlaceholder> TableNamePlaceholderAll = tableNamePlaceholderRepository.findAll();
    return ResponseEntity.ok().body(TableNamePlaceholderAll);
  }

  @GetMapping("/table_name_placeholder/{colsnotsec_placeholder}")
  public ResponseEntity<List<TableNamePlaceholder>> getTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder) {
    log.debug("REST request to get TableNamePlaceholder : {}", debugcolsnotsec_placeholder);

    List<TableNamePlaceholder> TableNamePlaceholderByInput = tableNamePlaceholderRepository.findByColsNotSecPlaceholder(colsnotsec_placeholder);
    return ResponseEntity.ok().body(TableNamePlaceholderByInput);
  }

//CustomLinesCustomGet1   @GetMapping("/table_name_placeholder/{colscustom_placeholder}")
//CustomLinesCustomGet1   public ResponseEntity<List<TableNamePlaceholder>> getTableNamePlaceholder(@PathVariable("colscustom_placeholder") ColscustomDatatype colscustom_placeholder) {
//CustomLinesCustomGet1     log.debug("REST request to get TableNamePlaceholder : {}", debugcolscustom_placeholder);
//CustomLinesCustomGet1 
//CustomLinesCustomGet1     List<TableNamePlaceholder> TableNamePlaceholderByInput = tableNamePlaceholderRepository.findByColsCustomPlaceholder(colscustom_placeholder);
//CustomLinesCustomGet1     return ResponseEntity.ok().body(TableNamePlaceholderByInput);
//CustomLinesCustomGet1   }


  @DeleteMapping("/table_name_placeholder/{colsnotsec_placeholder}/{sec_placeholder}")
  public ResponseEntity<Void> deleteTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder, @PathVariable("sec_placeholder") ColsecDatatype sec_placeholder) {
    log.debug("REST request to delete table_name_placeholder : {}", debugcolsnotsec_placeholder + "|" + debugsec_placeholder);
    TableNamePlaceholderId id = new TableNamePlaceholderId();
    id.setColsNotSecPlaceholder(cols_not_sec_placeholder);        
    id.setSecPlaceholder(sec_placeholder);

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
      TableNamePlaceholderId id = new TableNamePlaceholderId();
      TableNamePlaceholderServices tableNamePlaceholderServices = new TableNamePlaceholderServices(tableNamePlaceholderRepository);
      ColsecDatatype id_sec_placeholder = tableNamePlaceholderServices.UltimaSecuencia(tableNamePlaceholder);

      id.setSecPlaceholder(id_sec_placeholder);
      id.setColsNotSecPlaceholder(tableNamePlaceholder.getId().getColsNotSecPlaceholder());

      tableNamePlaceholder.setId(id);
      TableNamePlaceholder result = tableNamePlaceholderRepository.save(tableNamePlaceholder);
      return ResponseEntity
        .created(new URI("/api/table_name_placeholder/" + result.getId()))
        .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
        .body(result);
    }

  // GetMapping para un solo registro
    @GetMapping("/table_name_placeholder/{colsnotsec_placeholder}/{sec_placeholder}")
    public ResponseEntity<TableNamePlaceholder> getTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder, @PathVariable("sec_placeholder") ColsecDatatype sec_placeholder) {
        log.debug("REST request to get TableNamePlaceholder : {}", debugcolsnotsec_placeholder + "|" + debugsec_placeholder);
        TableNamePlaceholderId id = new TableNamePlaceholderId();
        id.setColsNotSecPlaceholder(cols_not_sec_placeholder);        
        id.setSecPlaceholder(sec_placeholder);

        Optional<TableNamePlaceholder> tableNamePlaceholder = tableNamePlaceholderRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(tableNamePlaceholder);
    }

  // DeleteMapping para muchos registros de una misma combinacion (se excluye la columna de secuencia)
    @DeleteMapping("/table_name_placeholder/{colsnotsec_placeholder}")
    public ResponseEntity<Void> deleteTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder) {
      log.debug("REST request to delete table_name_placeholder : {}", debugcolsnotsec_placeholder);
      List<TableNamePlaceholder> TableNamePlaceholderByInput = tableNamePlaceholderRepository.findByColsNotSecPlaceholder(colsnotsec_placeholder);

      tableNamePlaceholderRepository.deleteAll(TableNamePlaceholderByInput);
      return ResponseEntity
        .noContent()
        .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, TableNamePlaceholderByInput.toString()))
        .build();
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
