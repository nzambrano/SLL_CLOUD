package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdGeoPlace;
import com.prosegur.sllpe.domain.StdGeoPlaceId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdGeoPlaceRepository extends JpaRepository<StdGeoPlace, StdGeoPlaceId> {
    @Query(
        value = "select COALESCE(max(cast(std_id_geo_place as integer)),0)+1 from sll.std_geo_place where std_id_sub_geo_div = :std_id_sub_geo_div and std_id_geo_div = :std_id_geo_div and std_id_country = :std_id_country and id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("std_id_sub_geo_div") String std_id_sub_geo_div, @Param("std_id_geo_div") String std_id_geo_div, @Param("std_id_country") String std_id_country, @Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.std_geo_place where std_id_sub_geo_div = :std_id_sub_geo_div and std_id_geo_div = :std_id_geo_div and std_id_country = :std_id_country and id_organization = :id_organization",
        nativeQuery = true
    )
    public List<StdGeoPlace> findStdGeoPlaceByStdIdSubGeoDivStdIdGeoDivStdIdCountryIdOrganization(@Param("std_id_sub_geo_div") String std_id_sub_geo_div, @Param("std_id_geo_div") String std_id_geo_div, @Param("std_id_country") String std_id_country, @Param("id_organization") String id_organization);


}
