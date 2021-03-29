package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;
import com.prosegur.sllpe.repository.TableNamePlaceholderRepository;
import com.prosegur.sllpe.service.TableNamePlaceholderServices;
import com.prosegur.sllpe.web.rest.errors.BadRequestAlertException;
import io.github.jhipster.web.util.HeaderUtil;
// import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
// import io.github.jhipster.web.util.PaginationUtil;
// import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
// import org.springframework.data.domain.Page;
// import org.springframework.data.domain.Pageable;
// import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

// import java.util.Optional;

@RestController
@RequestMapping("/api")
@Transactional
public class TableNamePlaceholderResource {

  private final Logger log = LoggerFactory.getLogger(TableNamePlaceholderResource.class);
  private static final String ENTITY_NAME = "sllpeTableNamePlaceholder";

  @Value("${jhipster.clientApp.name}")
  private String applicationName;

  private TableNamePlaceholderRepository tableNamePlaceholderRepository;

  public TableNamePlaceholderResource(TableNamePlaceholderRepository tableNamePlaceholderRepository) {
    this.tableNamePlaceholderRepository = tableNamePlaceholderRepository;
  }

  @PostMapping("/table_name_placeholder")
  public ResponseEntity<TableNamePlaceholder> createTableNamePlaceholder(@RequestBody TableNamePlaceholder table_name_placeholder)
    throws URISyntaxException {
    log.debug("REST request to create table_name_placeholder : {}", table_name_placeholder);
    TableNamePlaceholderId id = new TableNamePlaceholderId();
    TableNamePlaceholderServices tableNamePlaceholderServices = new TableNamePlaceholderServices(tableNamePlaceholderRepository);
    ColsecDatatype id_sec_placeholder = tableNamePlaceholderServices.UltimaSecuencia(table_name_placeholder);

    id.setSecPlaceholder(id_sec_placeholder);
    id.setColsNotSecPlaceholder(table_name_placeholder.getId().getColsNotSecPlaceholder());


    table_name_placeholder.setId(id);
    TableNamePlaceholder result = tableNamePlaceholderRepository.save(table_name_placeholder);
    return ResponseEntity
      .created(new URI("/api/table_name_placeholder/" + result.getId()))
      .headers(HeaderUtil.createEntityCreationAlert(applicationName, false, ENTITY_NAME, result.getId().toString()))
      .body(result);
  }

  @PutMapping("/table_name_placeholder")
  public ResponseEntity<TableNamePlaceholder> updateTableNamePlaceholder(@RequestBody TableNamePlaceholder table_name_placeholder)
    throws URISyntaxException {
    log.debug("REST request to update table_name_placeholder : {}", table_name_placeholder);
    if (table_name_placeholder.getId() == null) {
      throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
    }
    TableNamePlaceholder result = tableNamePlaceholderRepository.save(table_name_placeholder);
    return ResponseEntity
      .ok()
      .headers(HeaderUtil.createEntityUpdateAlert(applicationName, false, ENTITY_NAME, table_name_placeholder.getId().toString()))
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

    List<TableNamePlaceholder> TableNamePlaceholderByInput = tableNamePlaceholderRepository.findTableNamePlaceholderByInput(colsnotsec_placeholder);
    return ResponseEntity.ok().body(TableNamePlaceholderByInput);
  }

  /*
    @GetMapping("/table_name_placeholder/{colsnotsec_placeholder}/{sec_placeholder}")
    public ResponseEntity<TableNamePlaceholder> getTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder, @PathVariable("sec_placeholder") ColsecDatatype sec_placeholder) {
        log.debug("REST request to get TableNamePlaceholder : {}", debugcolsnotsec_placeholder + "|" + debugsec_placeholder);
        TableNamePlaceholderId id = new TableNamePlaceholderId();
        id.setColsNotSecPlaceholder(cols_not_sec_placeholder);        
        id.setSecPlaceholder(sec_placeholder);

        Optional<TableNamePlaceholder> table_name_placeholder = tableNamePlaceholderRepository.findById(id);
        return ResponseUtil.wrapOrNotFound(table_name_placeholder);
    }
    */

  @DeleteMapping("/table_name_placeholder/{colsnotsec_placeholder}")
  public ResponseEntity<Void> deleteTableNamePlaceholder(@PathVariable("colsnotsec_placeholder") ColsnotsecDatatype colsnotsec_placeholder) {
    log.debug("REST request to delete table_name_placeholder : {}", debugcolsnotsec_placeholder);
    List<TableNamePlaceholder> TableNamePlaceholderByInput = tableNamePlaceholderRepository.findTableNamePlaceholderByInput(colsnotsec_placeholder);

    tableNamePlaceholderRepository.deleteAll(TableNamePlaceholderByInput);
    return ResponseEntity
      .noContent()
      .headers(HeaderUtil.createEntityDeletionAlert(applicationName, false, ENTITY_NAME, TableNamePlaceholderByInput.toString()))
      .build();
  }

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
