
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdPerson;
import com.prosegur.sllpe.domain.StdPersonId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdPersonRepository extends JpaRepository<StdPerson, StdPersonId> {
    @Query(
        value = "select * from sll.std_person where std_id_person = :std_id_person",
        nativeQuery = true
    )
    public List<StdPerson> findByStdIdPerson(@Param("std_id_person") String std_id_person);
}