package com.prosegur.sllpe.repository;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.domain.StdCountryId;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface StdCountryRepository extends JpaRepository<StdCountry, StdCountryId> {
    @Query(
        value = "select COALESCE(max(cast(std_id_country as integer)),0)+1 from sll.std_country where id_organization = :id_organization",
        nativeQuery = true
    )
    public String obtenerUltimaSecuencia(@Param("id_organization") String id_organization);

    @Query(
        value = "select * from sll.std_country where id_organization = :id_organization",
        nativeQuery = true
    )
    public List<StdCountry> findByIdOrganization(@Param("id_organization") String id_organization);


}
