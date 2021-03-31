package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllNegocios;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;
// import java.util.List;

// import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllNegociosServices {

    private final M4sllNegociosRepository M4sllNegociosRepository;

    public M4sllNegociosServices(M4sllNegociosRepository m4sllNegociosRepository) {
        this.M4sllNegociosRepository = m4sllNegociosRepository;
    }

    public boolean casteoError(M4sllNegocios m4sllNegocios) {
        return m4sllNegocios != null ? true : false;
    }

    public String UltimaSecuencia(M4sllNegocios m4sllNegocios) {
        return M4sllNegociosRepository.obtenerUltimaSecuencia(m4sllNegocios.getId().getIdOrganization());
    }
}
