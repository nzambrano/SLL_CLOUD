package com.prosegur.sllpe.security;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;


import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;

import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import com.prosegur.sllpe.SllpeApp;
import com.prosegur.sllpe.service.SeguridadService;



//import org.junit.Assert;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SllpeApp.class)
@AutoConfigureMockMvc
@WithMockUser()
@TestPropertySource(properties = { "spring.cloud.discovery.enabled = false" })
@ActiveProfiles("dev,no-liquibase")

class SeguridadUnitTest {
	private final Logger log = LoggerFactory.getLogger(SeguridadUnitTest.class);
	
	@Autowired
	private SeguridadService seguridadService;

	@Test
	void getRoles() throws IOException, Exception {

		List<String> roles = seguridadService.getRoles();
		// Assert.assertNotNull(roles);
		log.debug("Roles getRoles : {}", roles);
		Arrays.asList(roles).stream().forEach(s -> System.out.println(s));
		
		assertThat(roles.isEmpty()).isEqualTo(false);

	}

}
