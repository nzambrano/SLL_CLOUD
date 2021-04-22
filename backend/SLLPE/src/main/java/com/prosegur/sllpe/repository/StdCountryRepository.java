package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.domain.StdCountryId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdCountryRepository extends JpaRepository<StdCountry, StdCountryId> {
    @Query(
        value = "SELECT COALESCE(MAX(CAST(std_id_country as integer)),0)+1 FROM public.std_country WHERE id_organization = :idOrganization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("idOrganization") String idOrganization);

    @Query(
        value = "SELECT * FROM public.std_country WHERE id_organization = :idOrganization ORDER BY id_organization, TO_NUMBER(std_id_country) DESC",
        nativeQuery = true
    )
    public List<StdCountry> findByIdOrganization(@Param("idOrganization") String idOrganization);


}
