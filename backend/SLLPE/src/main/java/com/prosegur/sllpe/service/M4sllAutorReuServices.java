package com.prosegur.sllpe.service;


import java.util.Collection;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prosegur.sllpe.domain.M4sllAutorReu;
import com.prosegur.sllpe.domain.M4sllAutorReuId;
import com.prosegur.sllpe.repository.M4sllAutorReuRepository;

@Service
@Transactional

public class M4sllAutorReuServices {
	String idOrganization = "0050";
    private final M4sllAutorReuRepository m4sllAutorReuRepository;

    public M4sllAutorReuServices(M4sllAutorReuRepository m4sllAutorReuRepository) {
        this.m4sllAutorReuRepository = m4sllAutorReuRepository;
    }

    public boolean casteoError(M4sllAutorReu autorReu) {
        return autorReu != null ? true: false;
    }


    public  Long UltimaSecuencia(M4sllAutorReu autorReu) {
        return  m4sllAutorReuRepository.obtenerUltimaSecuencia(autorReu.getId().getLitIdLitigio(), autorReu.getId().getIdOrganization());
    }
    
    public Collection<M4sllAutorReu> saveAllWithSecuencia(Collection<M4sllAutorReu> listAutorReu)  {
    	listAutorReu.stream().forEach((m4sll_autor_reu) -> {      	
    		System.out.println(m4sll_autor_reu);        	
    		Long id_aurSecuencia = UltimaSecuencia(m4sll_autor_reu);
    		M4sllAutorReuId id = new M4sllAutorReuId(id_aurSecuencia, m4sll_autor_reu.getId().getLitIdLitigio(), idOrganization);
    		m4sll_autor_reu.setId(id);
    		m4sllAutorReuRepository.save(m4sll_autor_reu);
    });
    	return listAutorReu;
    }


}
