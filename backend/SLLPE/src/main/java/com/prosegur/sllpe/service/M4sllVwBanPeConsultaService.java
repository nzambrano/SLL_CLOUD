package com.prosegur.sllpe.service;

import java.util.ArrayList;
import java.util.Collection;
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
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllMtoSegInte;
import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;
import com.prosegur.sllpe.repository.M4sllMtoSegInteRepository;
import com.prosegur.sllpe.repository.M4sllVwBanPeConsultaRepository;

import org.springframework.data.domain.Page;
import org.springframework.core.env.Environment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
// import org.springframework.security.core.Authentication;

@Service
@Transactional
public class M4sllVwBanPeConsultaService {
	@Autowired
	private Environment environment;

	@Value("${idOrganization}")
	private String idOrganization;

	private String nameColumn = "";
	private int i = 1;
	
	// private final M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;
	private static final Logger LOGGER = LoggerFactory.getLogger(M4sllVwBanPeConsultaService.class);

	@Autowired
	private EntityManager em;

	@Autowired
	M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;
	
	@Autowired
	M4sllMtoSegInteRepository m4sllMtoSegInteRepository;
	
	@Autowired
	SeguridadService seguridadService;
	/*
	 * public M4sllVwBanPeConsultaService(M4sllVwBanPeConsultaRepository
	 * m4sllVwBanPeConsultaRepository) { this.m4sllVwBanPeConsultaRepository =
	 * m4sllVwBanPeConsultaRepository; }
	 */

	public boolean casteoError(M4sllVwBanPeConsulta banPeConsulta) {
		return banPeConsulta != null ? true : false;
	}
	

	public Page<M4sllVwBanPeConsulta> getBanPeConsultaWithSeg(Pageable page) {
		LOGGER.info("Generating getBanPeWithSeg");
		LOGGER.info("Generating getBanPeWithSeg" + environment.getProperty("idOrganization"));
		// LOGGER.info("idOrganization99: " + idOrganization99);

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<M4sllVwBanPeConsulta> cr = cb.createQuery(M4sllVwBanPeConsulta.class);
		Root<M4sllVwBanPeConsulta> root = cr.from(M4sllVwBanPeConsulta.class);

		List<Predicate> predicates = new ArrayList<>();
		List<Predicate> predicatesFinal = new ArrayList<>();

		// Agregamos condiciones

		// traerme los roles de la persona autenticada
		List<String> roles = seguridadService.getRoles();

		// ir a base de datos a tabla seguridad y traer array de condiciones
		List<M4sllMtoSegInte> listSegInterna = m4sllMtoSegInteRepository.findByIdAppRole(idOrganization, roles);
		LOGGER.debug("lista seguridad interna: ", listSegInterna);
		CriteriaBuilder criteriaBuilder;
		// for agregando condiciones
		// esta linea se repite por
		
		
		
		/*Predicate predicateForBlueColor
		  = cb.equal(root.get("color"), "blue");
		Predicate predicateForRedColor
		  = cb.equal(root.get("color"), "red");
		Predicate predicateForColor
		  = cb.or(predicateForBlueColor, predicateForRedColor);
		*/
		
		//listSegInterna.stream().forEach((segInterna) -> {
		Integer countlistSeg = listSegInterna.size();
		i = 1;
		listSegInterna.forEach((segInterna) -> {
			nameColumn = segInterna.getMsiColumna();
			
			// si se cambia de nombre de columna se agregan las condiciones anteriors en Or ya que pertenecen a la misma agrupacion de condiciones
			// ejmp "msiTabla" : "M4SLL_LITIGIOS",  "msiColumna" : "std_id_geo_div", "msiValor" : "12",
			//      "msiTabla" : "M4SLL_LITIGIOS",  "msiColumna" : "std_id_geo_div", "msiValor" : "10",
			// debe quedar AND (std_id_geo_div = '12' or std_id_geo_div = '10')
			
			
			
			if (nameColumn.equals(segInterna.getMsiColumna()) ) {
				Predicate predicateMatchNameColumnCondition
				  = cb.equal(root.get(segInterna.getMsiColumna()), segInterna.getMsiValor());
				
				predicates.add(predicateMatchNameColumnCondition);
			}
			
			if (!nameColumn.equals(segInterna.getMsiColumna()) || countlistSeg == i) {
				Predicate predicateGroupColumn
				  = cb.or(predicates.toArray(new Predicate[predicates.size()]));
				
				predicatesFinal.add(predicateGroupColumn);
				
				predicates.clear();
				LOGGER.debug("cambio de columna ");
				System.out.println("cambio de columna ");

				//se empieza nuevamente a agregar condiciones para el prox grupo de colmnas
				Predicate predicateMatchNameColumnCondition
				  = cb.equal(root.get(segInterna.getMsiColumna()), segInterna.getMsiValor());
				/*
				 Predicate finalPredicate
  					= criteriaBuilder.and(predicateForColor, predicateForGrade);
				 */
				predicates.add(predicateMatchNameColumnCondition);
				
				// si es el ultimo elemento se agrega de una vez al predicado final para posteriormente ejecutar el query
				if (countlistSeg == i) {
					LOGGER.debug("ultimo elemento for o cambio de columna ");
					System.out.println("ultimo elemento for o cambio de columna ");
					
					predicatesFinal.add(predicateMatchNameColumnCondition);
				}

				
				
			}
			
			System.out.println(segInterna);
			LOGGER.debug("Roles getRoles : {}", roles);
			System.out.println("roles: " + roles);
			LOGGER.debug("seguridad interna: ", segInterna);
			LOGGER.debug("seguridad getMsiColumna: ", segInterna.getMsiColumna());
			System.out.println("seguridad getMsiColumna: " + segInterna.getMsiColumna());
			LOGGER.debug("seguridad getMsiValor: ", segInterna.getMsiValor());
			System.out.println("seguridad getMsiColumna: " + segInterna.getMsiValor());
			
			// predicates.add(cb.equal(root.get(segInterna.getMsiColumna()), segInterna.getMsiValor()));
			// predicates.add(cb.equal(root.get(segInterna.getMsiColumna()), segInterna.getMsiValor()));
			
			
			
		 	
			// predicates.add(predicateMatchNameColumnCondition);
		 	
			
			
			i++;
			
		});
		// cb.or(null)
		
		// predicates.add(cb.equal(root.get("std_id_geo_div"), "12"));

		if (predicatesFinal.isEmpty()) {
			cr.select(root);
		} else {
			/*Predicate finalPredicate
			  = cb.and(predicatesFinal.toArray(new Predicate[predicatesFinal.size()]));
			*/
			
			cr.select(root).where(predicatesFinal.toArray(new Predicate[predicatesFinal.size()]));
		}
		// cr.setFirstResult(page.getPageNumber() * page.getPageSize());
		// cr.select(root).setMaxResults(page.getPageSize());

		// paginado
		TypedQuery<M4sllVwBanPeConsulta> query = em.createQuery(cr);
		LOGGER.debug("seguridad query: ",query.toString());
		System.out.println("seguridad query: " + query.toString());
		
		int totalRows = query.getResultList().size();
		query.setFirstResult(page.getPageNumber() * page.getPageSize());
		query.setMaxResults(page.getPageSize());

		// listaBandeja = em.createQuery(cr).getResultList();

		Page<M4sllVwBanPeConsulta> result = new PageImpl<M4sllVwBanPeConsulta>(query.getResultList(), page, totalRows);
		return result;
		// return result;

	}

	/*
	 * public Collection<M4sllAutorReu>
	 * saveAllWithSecuencia(Collection<M4sllAutorReu> listAutorReu) {
	 * listAutorReu.stream().forEach((m4sll_autor_reu) -> {
	 * System.out.println(m4sll_autor_reu); Long id_aurSecuencia =
	 * UltimaSecuencia(m4sll_autor_reu); M4sllAutorReuId id = new
	 * M4sllAutorReuId(id_aurSecuencia, m4sll_autor_reu.getId().getLitIdLitigio(),
	 * idOrganization); m4sll_autor_reu.setId(id);
	 * m4sllAutorReuRepository.save(m4sll_autor_reu); }); return listAutorReu; }
	 */

}
