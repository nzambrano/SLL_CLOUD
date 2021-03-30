package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;
import java.util.List;
// import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TableNamePlaceholderRepository extends JpaRepository<TableNamePlaceholder, TableNamePlaceholderId> {
  @Query(
    value = "select COALESCE(max(sec_placeholder),0)+1 from sll.table_name_placeholder where_and_colsnotsec_placeholder",
    nativeQuery = true
  )
  public ColsecDatatype obtenerUltimaSecuencia(param_colsnotsec_placeholder);

  @Query(
    value = "select * from sll.table_name_placeholder where_and_colsnotsec_placeholder",
    nativeQuery = true
  )
  public List<TableNamePlaceholder> findTableNamePlaceholderByColsNotSecPlaceholder(param_colsnotsec_placeholder);

//CustomLinesCustomGet1  @Query(
//CustomLinesCustomGet1    value = "select * from sll.table_name_placeholder where_and_colscustom_placeholder",
//CustomLinesCustomGet1    nativeQuery = true
//CustomLinesCustomGet1  )
//CustomLinesCustomGet1    public List<TableNamePlaceholder> findTableNamePlaceholderByColsCustomPlaceholder(param_colscustom_placeholder);

}
