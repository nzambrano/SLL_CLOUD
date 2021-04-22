package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdGeoPlace;
import com.prosegur.sllpe.domain.StdGeoPlaceId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdGeoPlaceRepository extends JpaRepository<StdGeoPlace, StdGeoPlaceId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(std_id_geo_place as integer)),0)+1 FROM public.std_geo_place WHERE id_organization = :idOrganization AND std_id_country = :stdIdCountry AND std_id_geo_div = :stdIdGeoDiv AND std_id_sub_geo_div = :stdIdSubGeoDiv",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("stdIdCountry") String stdIdCountry, @Param("stdIdGeoDiv") String stdIdGeoDiv, @Param("stdIdSubGeoDiv") String stdIdSubGeoDiv);

    @Query(
        value = "SELECT * FROM public.std_geo_place WHERE id_organization = :idOrganization AND std_id_country = :stdIdCountry AND std_id_geo_div = :stdIdGeoDiv AND std_id_sub_geo_div = :stdIdSubGeoDiv ORDER BY id_organization, std_id_country, std_id_geo_div, std_id_sub_geo_div, TO_NUMBER(std_id_geo_place) DESC",
        nativeQuery = true
    )
    public List<StdGeoPlace> findByIdOrganizationStdIdCountryStdIdGeoDivStdIdSubGeoDiv(@Param("idOrganization") String idOrganization, @Param("stdIdCountry") String stdIdCountry, @Param("stdIdGeoDiv") String stdIdGeoDiv, @Param("stdIdSubGeoDiv") String stdIdSubGeoDiv);


}
