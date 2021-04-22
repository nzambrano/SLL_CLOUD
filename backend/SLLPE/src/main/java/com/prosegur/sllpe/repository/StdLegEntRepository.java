
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdLegEnt;
import com.prosegur.sllpe.domain.StdLegEntId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdLegEntRepository extends JpaRepository<StdLegEnt, StdLegEntId> {
    @Query(
        value = "select * from public.std_leg_ent WHERE id_organization = :idOrganization ORDER BY id_organization, std_id_leg_ent DESC",
        nativeQuery = true
    )
    public List<StdLegEnt> findByIdOrganization(@Param("idOrganization") String idOrganization);
}