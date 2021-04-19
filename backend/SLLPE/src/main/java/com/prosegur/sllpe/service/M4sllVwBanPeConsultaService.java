package com.prosegur.sllpe.service;




import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;
import com.prosegur.sllpe.repository.M4sllVwBanPeConsultaRepository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.core.env.Environment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
@Transactional
public class M4sllVwBanPeConsultaService {
    @Autowired
    private Environment environment;


    @Value("${idOrganization}")
    private String idOrganization99;

    String idOrganization = "0050";
    //  private final M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;
    private static final Logger LOGGER = LoggerFactory.getLogger(M4sllVwBanPeConsultaService.class);

    @Autowired
    private EntityManager em;

    @Autowired
    M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;
    /*public M4sllVwBanPeConsultaService(M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository) {
        this.m4sllVwBanPeConsultaRepository = m4sllVwBanPeConsultaRepository;
    }*/

    public boolean casteoError(M4sllVwBanPeConsulta banPeConsulta) {
        return banPeConsulta != null ? true: false;
    }

    public Page<M4sllVwBanPeConsulta> getBanPeConsultaWithSeg(Pageable page) {
        LOGGER.info("Generating getBanPeWithSeg");
        LOGGER.info("Generating getBanPeWithSeg"+ environment.getProperty("idOrganization"));
        LOGGER.info("idOrganization99: "+ idOrganization99);



        List<M4sllVwBanPeConsulta> listaBandeja = null;
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<M4sllVwBanPeConsulta> cr = cb.createQuery(M4sllVwBanPeConsulta.class);
        Root<M4sllVwBanPeConsulta> root = cr.from(M4sllVwBanPeConsulta.class);


        List<Predicate> predicates = new ArrayList<>();

        // Agregamos condiciones

        // traerme los roles de la persona autenticada

        // ir a base de datos a tabla seguridad y traer array de condiciones

        // for agregando condiciones
        // esta linea se repite por
        predicates.add(cb.equal(root.get("std_id_geo_div"), "12"));

        if (predicates.isEmpty()) {
            cr.select(root);
        } else {
            cr.select(root).where(predicates.toArray(new Predicate[predicates.size()]));
        }
        // cr.setFirstResult(page.getPageNumber() * page.getPageSize());
        // cr.select(root).setMaxResults(page.getPageSize());

        // paginado
        TypedQuery<M4sllVwBanPeConsulta> query = em.createQuery(cr);
        int totalRows = query.getResultList().size();
        query.setFirstResult(page.getPageNumber() * page.getPageSize());
        query.setMaxResults(page.getPageSize());

        // listaBandeja = em.createQuery(cr).getResultList();

        Page<M4sllVwBanPeConsulta> result = new PageImpl<M4sllVwBanPeConsulta>(query.getResultList(), page, totalRows);
        return result;
        //return result;


    }


    /*public Collection<M4sllAutorReu> saveAllWithSecuencia(Collection<M4sllAutorReu> listAutorReu)  {
    	listAutorReu.stream().forEach((m4sll_autor_reu) -> {
    		System.out.println(m4sll_autor_reu);
    		Long id_aurSecuencia = UltimaSecuencia(m4sll_autor_reu);
    		M4sllAutorReuId id = new M4sllAutorReuId(id_aurSecuencia, m4sll_autor_reu.getId().getLitIdLitigio(), idOrganization);
    		m4sll_autor_reu.setId(id);
    		m4sllAutorReuRepository.save(m4sll_autor_reu);
    });
    	return listAutorReu;
    }
    */


}
