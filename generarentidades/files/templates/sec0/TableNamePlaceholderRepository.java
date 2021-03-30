package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;

public interface TableNamePlaceholderRepository extends JpaRepository<TableNamePlaceholder, TableNamePlaceholderId> {
//CustomLinesCustomGet1  @Query(
//CustomLinesCustomGet1    value = "select * from sll.table_name_placeholder where_and_colscustom_placeholder",
//CustomLinesCustomGet1    nativeQuery = true
//CustomLinesCustomGet1  )
//CustomLinesCustomGet1    public List<TableNamePlaceholder> findTableNamePlaceholderByColsCustomPlaceholder(param_colscustom_placeholder);
}