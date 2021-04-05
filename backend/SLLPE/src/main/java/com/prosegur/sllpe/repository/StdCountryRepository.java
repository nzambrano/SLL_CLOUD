package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.StdCountry;
import com.prosegur.sllpe.domain.StdCountryId;

public interface StdCountryRepository extends JpaRepository<StdCountry, StdCountryId> {
}