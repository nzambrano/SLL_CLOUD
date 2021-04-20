
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;

//CustomLinesCustomGet1 import java.util.List;
//CustomLinesCustomGet1 import org.springframework.data.jpa.repository.Query;
//CustomLinesCustomGet1 import org.springframework.data.repository.query.Param;

public interface TableNamePlaceholderRepository extends JpaRepository<TableNamePlaceholder, TableNamePlaceholderId> {
//CustomLinesCustomGet1   @Query(
//CustomLinesCustomGet1     value = "select * from schema_name_placeholder.table_name_placeholder where_and_colscustom_placeholder orderbypks_placeholder",
//CustomLinesCustomGet1     nativeQuery = true
//CustomLinesCustomGet1   )
//CustomLinesCustomGet1     public List<TableNamePlaceholder> findByColsCustomPlaceholder(param_colscustom_placeholder);
}