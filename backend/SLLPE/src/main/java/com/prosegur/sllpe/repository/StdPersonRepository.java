
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdPerson;
import com.prosegur.sllpe.domain.StdPersonId;


public interface StdPersonRepository extends JpaRepository<StdPerson, StdPersonId> {
}