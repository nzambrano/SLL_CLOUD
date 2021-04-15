package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;
import com.prosegur.sllpe.domain.M4sllPagos;
import com.prosegur.sllpe.domain.M4sllPagosId;
import com.prosegur.sllpe.repository.M4sllPagosRepository;

import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllPagosServices {

    private final M4sllPagosRepository M4sllPagosRepository;

    public M4sllPagosServices(M4sllPagosRepository m4sllPagosRepository) {
        this.M4sllPagosRepository = m4sllPagosRepository;
    }

    public boolean casteoError(M4sllPagos m4sllPagos) {
        return m4sllPagos != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllPagos m4sllPagos) {
        return M4sllPagosRepository.obtenerUltimaSecuencia(m4sllPagos.getId().getIdOrganization(), m4sllPagos.getId().getLitIdLitigio());
    }
    
    public List<M4sllPagos> saveAllWithSecuencia(List<M4sllPagos> listM4sllPagos)  {
    	listM4sllPagos.stream().forEach((m4sllPago) -> {
    		Long pagoSecuencia = UltimaSecuencia(m4sllPago);
    		M4sllPagosId id = new M4sllPagosId(m4sllPago.getId().getLitIdLitigio(), pagoSecuencia , "0050");
    		m4sllPago.setId(id);
    		M4sllPagosRepository.save(m4sllPago);
    });
    	return listM4sllPagos;
    }
}
