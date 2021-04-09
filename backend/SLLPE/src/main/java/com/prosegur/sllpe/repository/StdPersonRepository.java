
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdPerson;
import com.prosegur.sllpe.domain.StdPersonId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdPersonRepository extends JpaRepository<StdPerson, StdPersonId> {
    @Query(
        value = "select * from public.std_person where std_id_person = :std_id_person",
        nativeQuery = true
    )
    public List<StdPerson> findByStdIdPerson(@Param("std_id_person") String std_id_person);
    
    @Query(
            value = "select *from public.std_person where upper(std_n_first_name) LIKE (CONCAT('%',upper('GARAY'),'%')) OR upper(std_n_fam_name_1) LIKE (CONCAT('%',upper(:name),'%')) OR std_n_maiden_name like (CONCAT('%',upper(:name),'%')) limit 25",
            nativeQuery = true
        )
    public List<StdPerson> findByName(@Param("name") String name);
}