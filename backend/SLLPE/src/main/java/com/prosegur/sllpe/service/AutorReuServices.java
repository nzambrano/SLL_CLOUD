package com.prosegur.sllpe.service;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllAutorReu;
import com.prosegur.sllpe.repository.M4sllAutorReuRepository;


@Service
@Transactional

public class AutorReuServices {

	private final M4sllAutorReuRepository M4sllAutorReuRepository;
	
	public AutorReuServices(M4sllAutorReuRepository m4ccoLlPagosRepository) {
		this.M4sllAutorReuRepository = m4ccoLlPagosRepository;
	}
	
	public boolean casteoError(M4sllAutorReu autorReu) {
		return autorReu != null ? true: false;
 	}
	
	
	public  Long UltimaSecuencia(M4sllAutorReu autorReu) {
		return  M4sllAutorReuRepository.obtenerUltimaSecuencia(autorReu.getId().getLitIdLitigio(), autorReu.getId().getIdOrganization());
	}
	
	
}
