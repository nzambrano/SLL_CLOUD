package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.TableNamePlaceholder;
import com.prosegur.sllpe.domain.TableNamePlaceholderId;

public interface TableNamePlaceholderRepository extends JpaRepository<TableNamePlaceholder, TableNamePlaceholderId> {
}