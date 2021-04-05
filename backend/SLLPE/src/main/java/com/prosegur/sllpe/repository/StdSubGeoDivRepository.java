package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdSubGeoDiv;
import com.prosegur.sllpe.domain.StdSubGeoDivId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdSubGeoDivRepository extends JpaRepository<StdSubGeoDiv, StdSubGeoDivId> {
    @Query(
        value = "select COALESCE(max(cast(std_id_sub_geo_div as integer)),0)+1 from sll.std_sub_geo_div where std_id_geo_div = :std_id_geo_div and std_id_country = :std_id_country and id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("std_id_geo_div") String std_id_geo_div, @Param("std_id_country") String std_id_country, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.std_sub_geo_div where std_id_geo_div = :std_id_geo_div and std_id_country = :std_id_country and id_organization = :id_organization",
        nativeQuery = true
    )
    public List<StdSubGeoDiv> findStdSubGeoDivByStdIdGeoDivStdIdCountryIdOrganization(@Param("std_id_geo_div") String std_id_geo_div, @Param("std_id_country") String std_id_country, @Param("id_organization") String id_organization);


}
