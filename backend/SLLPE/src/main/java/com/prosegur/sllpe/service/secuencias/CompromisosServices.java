package com.prosegur.sllpe.service.secuencias;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllCompromisos;
import com.prosegur.sllpe.repository.M4sllCompromisosRepository;



@Service
@Transactional

public class CompromisosServices {

	private final M4sllCompromisosRepository m4sllCompromisosRepository;
	
	public CompromisosServices(M4sllCompromisosRepository m4sllCompromisosRepository) {
		this.m4sllCompromisosRepository = m4sllCompromisosRepository;
	}
	
	public boolean casteoError(M4sllCompromisos compromiso) {
		return compromiso != null ? true: false;
 	}
	
	
	public  Long UltimaSecuencia(M4sllCompromisos compromiso) {
		return  m4sllCompromisosRepository.obtenerUltimaSecuencia( compromiso.getId().getIdOrganization(), compromiso.getId().getLitIdLitigio(), compromiso.getId().getTcoIdTpCompromiso());
	}
	
	
}
