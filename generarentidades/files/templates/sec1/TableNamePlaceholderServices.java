package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.repository.TableNamePlaceholderRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TableNamePlaceholderServices {

  private final TableNamePlaceholderRepository TableNamePlaceholderRepository;

  public TableNamePlaceholderServices(TableNamePlaceholderRepository tableNamePlaceholderRepository) {
    this.TableNamePlaceholderRepository = tableNamePlaceholderRepository;
  }

  public boolean casteoError(TableNamePlaceholder tableNamePlaceholder) {
    return tableNamePlaceholder != null ? true : false;
  }

  public ColsecDatatype UltimaSecuencia(TableNamePlaceholder tableNamePlaceholder) {
    return TableNamePlaceholderRepository.obtenerUltimaSecuencia(tableNamePlaceholder.getId().getColsNotSecPlaceholder());
  }
}
