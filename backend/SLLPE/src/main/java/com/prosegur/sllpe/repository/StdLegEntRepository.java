
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdLegEnt;
import com.prosegur.sllpe.domain.StdLegEntId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdLegEntRepository extends JpaRepository<StdLegEnt, StdLegEntId> {
    @Query(
        value = "select * from public.std_leg_ent where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<StdLegEnt> findByIdOrganization(@Param("id_organization") String id_organization);
}