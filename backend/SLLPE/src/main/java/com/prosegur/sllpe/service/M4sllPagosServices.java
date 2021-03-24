package com.prosegur.sllpe.service;

// import java.util.List;

// import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllPagos;
import com.prosegur.sllpe.repository.M4sllPagosRepository;


@Service
@Transactional

public class M4sllPagosServices {

	private final M4sllPagosRepository M4sllPagosRepository;
	
	public M4sllPagosServices(M4sllPagosRepository m4ccoLlPagosRepository) {
		this.M4sllPagosRepository = m4ccoLlPagosRepository;
	}
	
	public boolean casteoError(M4sllPagos m4sllPagos) {
		return m4sllPagos != null ? true: false;
 	}
	
	
	public  Long UltimaSecuencia(M4sllPagos m4sllPagos) {
		return  M4sllPagosRepository.obtenerUltimaSecuencia(m4sllPagos.getId().getLitIdLitigio(), m4sllPagos.getId().getIdOrganization());
	}
	
	
}
