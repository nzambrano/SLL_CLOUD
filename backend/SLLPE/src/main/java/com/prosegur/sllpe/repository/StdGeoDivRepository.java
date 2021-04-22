package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdGeoDiv;
import com.prosegur.sllpe.domain.StdGeoDivId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdGeoDivRepository extends JpaRepository<StdGeoDiv, StdGeoDivId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(std_id_geo_div as integer)),0)+1 FROM public.std_geo_div WHERE id_organization = :idOrganization AND std_id_country = :stdIdCountry",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization, @Param("stdIdCountry") String stdIdCountry);

    @Query(
        value = "SELECT * FROM public.std_geo_div WHERE id_organization = :idOrganization AND std_id_country = :stdIdCountry ORDER BY id_organization, std_id_country, TO_NUMBER(std_id_geo_div) DESC",
        nativeQuery = true
    )
    public List<StdGeoDiv> findByIdOrganizationStdIdCountry(@Param("idOrganization") String idOrganization, @Param("stdIdCountry") String stdIdCountry);


}
