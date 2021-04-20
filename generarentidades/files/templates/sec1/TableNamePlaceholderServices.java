package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;
import com.prosegur.sllpe.repository.TableNamePlaceholderRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//CustomLinesColsEv import org.springframework.beans.factory.annotation.Value;
import java.util.List;
import java.util.Collection;

@Service
@Transactional
public class TableNamePlaceholderServices {
  private final Logger log = LoggerFactory.getLogger(TableNamePlaceholderServices.class);
//CustomLinesColsEv @Value("${colsEvNamePlaceholder}") private ColsEvDatatype colsEvNamePlaceholder;
  private final TableNamePlaceholderRepository tableNamePlaceholderRepository;

  public TableNamePlaceholderServices(TableNamePlaceholderRepository tableNamePlaceholderRepository) {
    this.tableNamePlaceholderRepository = tableNamePlaceholderRepository;
  }

  public boolean casteoError(TableNamePlaceholder tableNamePlaceholder) {
    return tableNamePlaceholder != null ? true : false;
  }

  public ColsecDatatypeInServices UltimaSecuencia(TableNamePlaceholder tableNamePlaceholder) {
    return tableNamePlaceholderRepository.obtenerUltimaSecuencia(tableNamePlaceholder.getId().getColsNotSecPlaceholder());
  }

  public List<TableNamePlaceholder> saveAllWithSecuencia(List<TableNamePlaceholder> listTableNamePlaceholder)  {
    listTableNamePlaceholder.stream().forEach((tableNamePlaceholder) -> {
      ColsecDatatypeInServices ultimaSecuencia = UltimaSecuencia(tableNamePlaceholder);
      TableNamePlaceholderId id = new TableNamePlaceholderId();
      id.setSecPlaceholder(ultimaSecuencia);
      id.setColsNotSecPlaceholder(tableNamePlaceholder.getId().getColsNotSecPlaceholder());

      String classToString = ReflectionToStringBuilder.toString(id, ToStringStyle.JSON_STYLE);
      log.info("REST request to insert table_name_placeholder id: {}, seq: {}", classToString, ultimaSecuencia);

      tableNamePlaceholder.setId(id);
      tableNamePlaceholderRepository.save(tableNamePlaceholder);
  });
    return listTableNamePlaceholder;
  }
}
