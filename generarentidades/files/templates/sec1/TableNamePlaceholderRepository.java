package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TableNamePlaceholderRepository extends JpaRepository<TableNamePlaceholder, TableNamePlaceholderId> {
  @Query(
    value = "SELECT COALESCE(MAX(sec_placeholder),0)+1 FROM schema_name_placeholder.table_name_placeholder where_and_colsnotsec_placeholder",
    nativeQuery = true
  )
  public ColsecDatatype obtenerUltimaSecuencia(param_colsnotsec_placeholder);

  @Query(
    value = "SELECT * FROM schema_name_placeholder.table_name_placeholder where_and_colsnotsec_placeholder orderbypks_placeholder",
    nativeQuery = true
  )
  public List<TableNamePlaceholder> findByColsNotSecPlaceholder(param_colsnotsec_placeholder);

//CustomLinesCustomGet1   @Query(
//CustomLinesCustomGet1     value = "SELECT * FROM schema_name_placeholder.table_name_placeholder where_and_colscustom_placeholder orderbypks_placeholder",
//CustomLinesCustomGet1     nativeQuery = true
//CustomLinesCustomGet1   )
//CustomLinesCustomGet1     public List<TableNamePlaceholder> findByColsCustomPlaceholder(param_colscustom_placeholder);

}
