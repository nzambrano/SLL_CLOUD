package com.prosegur.sllpe.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;

@Service
@Transactional
public class SeguridadService {
	@Autowired
	

		
	// private final M4sllVwBanPeConsultaRepository m4sllVwBanPeConsultaRepository;
	private static final Logger LOGGER = LoggerFactory.getLogger(SeguridadService.class);
	

	public boolean casteoError(M4sllVwBanPeConsulta banPeConsulta) {
		return banPeConsulta != null ? true : false;
	}

	public List<String> getRoles() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		@SuppressWarnings("unchecked")
		Collection<GrantedAuthority> authorities = (Collection<GrantedAuthority>) auth.getAuthorities();
		List<String> roles = new ArrayList<String>();
		for (GrantedAuthority grantedAuthority : authorities) {
			roles.add(grantedAuthority.getAuthority());
		}
		return roles;
	}

	

}
