package com.prosegur.sllpe.service;

import com.prosegur.sllpe.domain.M4sllLitSeguimie;
import com.prosegur.sllpe.repository.M4sllLitSeguimieRepository;
// import java.util.List;

// import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class M4sllLitSeguimieServices {

    private final M4sllLitSeguimieRepository M4sllLitSeguimieRepository;

    public M4sllLitSeguimieServices(M4sllLitSeguimieRepository m4sllLitSeguimieRepository) {
        this.M4sllLitSeguimieRepository = m4sllLitSeguimieRepository;
    }

    public boolean casteoError(M4sllLitSeguimie m4sllLitSeguimie) {
        return m4sllLitSeguimie != null ? true : false;
    }

    public Long UltimaSecuencia(M4sllLitSeguimie m4sllLitSeguimie) {
        return M4sllLitSeguimieRepository.obtenerUltimaSecuencia(
                   m4sllLitSeguimie.getId().getIdOrganization(),
                   m4sllLitSeguimie.getId().getLitIdLitigio()
               );
    }
}
