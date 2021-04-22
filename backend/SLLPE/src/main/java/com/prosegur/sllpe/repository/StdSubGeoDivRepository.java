package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdSubGeoDiv;
import com.prosegur.sllpe.domain.StdSubGeoDivId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdSubGeoDivRepository extends JpaRepository<StdSubGeoDiv, StdSubGeoDivId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(std_id_sub_geo_div as integer)),0)+1 FROM public.std_sub_geo_div WHERE id_organization = :idOrganization AND std_id_country = :stdIdCountry AND std_id_geo_div = :stdIdGeoDiv",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("stdIdCountry") String stdIdCountry, @Param("stdIdGeoDiv") String stdIdGeoDiv);

    @Query(
        value = "SELECT * FROM public.std_sub_geo_div WHERE id_organization = :idOrganization AND std_id_country = :stdIdCountry AND std_id_geo_div = :stdIdGeoDiv ORDER BY id_organization, std_id_country, std_id_geo_div, TO_NUMBER(std_id_sub_geo_div) DESC",
        nativeQuery = true
    )
    public List<StdSubGeoDiv> findByIdOrganizationStdIdCountryStdIdGeoDiv(@Param("idOrganization") String idOrganization, @Param("stdIdCountry") String stdIdCountry, @Param("stdIdGeoDiv") String stdIdGeoDiv);


}
