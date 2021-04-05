
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.M4sllTpStaDet;
import com.prosegur.sllpe.domain.M4sllTpStaDetId;


public interface M4sllTpStaDetRepository extends JpaRepository<M4sllTpStaDet, M4sllTpStaDetId> {
}