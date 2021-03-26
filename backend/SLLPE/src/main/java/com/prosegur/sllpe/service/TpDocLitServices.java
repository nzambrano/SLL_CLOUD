package com.prosegur.sllpe.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllTpDocLitig;
import com.prosegur.sllpe.repository.M4sllTpDocLitigRepository;

@Service
@Transactional

public class TpDocLitServices {

	private final M4sllTpDocLitigRepository M4sllTpDocLitigRepository;
	
	public TpDocLitServices(M4sllTpDocLitigRepository M4sllTpDocLitigRepository) {
		this.M4sllTpDocLitigRepository = M4sllTpDocLitigRepository;
	}
	
	public boolean casteoError(M4sllTpDocLitig tpDocLitServices) {
		return tpDocLitServices != null ? true: false;
 	}
	
	
	public  Long UltimaSecuencia(M4sllTpDocLitig tpDocLitServices) {
		return  M4sllTpDocLitigRepository.obtenerUltimaSecuencia(tpDocLitServices.getId().getIdOrganization());
	}
}
