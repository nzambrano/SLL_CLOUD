package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdGeoDiv;
import com.prosegur.sllpe.domain.StdGeoDivId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdGeoDivRepository extends JpaRepository<StdGeoDiv, StdGeoDivId> {
    @Query(
        value = "select COALESCE(max(cast(std_id_geo_div as integer)),0)+1 from sll.std_geo_div where id_organization = :id_organization and std_id_country = :std_id_country",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization, @Param("std_id_country") String std_id_country);

    @Query(
        value = "select * from sll.std_geo_div where id_organization = :id_organization and std_id_country = :std_id_country",
        nativeQuery = true
    )
    public List<StdGeoDiv> findByIdOrganizationStdIdCountry(@Param("id_organization") String id_organization, @Param("std_id_country") String std_id_country);


}
