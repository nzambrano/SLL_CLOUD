package com.prosegur.sllpe.service.secuencias;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllValEcLit;

import com.prosegur.sllpe.repository.M4sllProvisionesRepository;



@Service
@Transactional

public class ProvisionesServices {

	private final M4sllProvisionesRepository m4sllProvisionesRepository;
	
	public ProvisionesServices(M4sllProvisionesRepository m4sllProvisionesRepository) {
		this.m4sllProvisionesRepository = m4sllProvisionesRepository;
	}
	
	public boolean casteoError(M4sllValEcLit provision) {
		return provision != null ? true: false;
 	}
	
	public  Long UltimaSecuencia(M4sllValEcLit provision) {
		return  m4sllProvisionesRepository.obtenerUltimaSecuencia( provision.getId().getIdOrganization(), provision.getId().getLitIdLitigio());
	}
		
}
