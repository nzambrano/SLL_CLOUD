
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdLegEnt;
import com.prosegur.sllpe.domain.StdLegEntId;


public interface StdLegEntRepository extends JpaRepository<StdLegEnt, StdLegEntId> {
}