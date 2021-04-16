package com.prosegur.sllpe.web.rest;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import com.prosegur.sllpe.SllpeApp;
import com.prosegur.sllpe.domain.M4sllFases;
import com.prosegur.sllpe.domain.M4sllFasesId;



@RunWith(SpringRunner.class)
@SpringBootTest(classes = SllpeApp.class)
@AutoConfigureMockMvc
@WithMockUser()
@TestPropertySource(properties = { "spring.cloud.discovery.enabled = false" })
@ActiveProfiles("dev,no-liquibase")

class M4sllFasesResourceTest {

	@Autowired
	private MockMvc fasesMockMvc;
	private M4sllFases fase;

	@Test
	void guardarFase() throws IOException, Exception {
		
		M4sllFases fase = new M4sllFases(new M4sllFasesId("1", "1", "0050"));
		fase.setFasNroRadicacion("11111");
		List<M4sllFases> listaFases= Arrays.asList(fase);
		
		fasesMockMvc
				.perform(post("/api/m4sll_fases").contentType(MediaType.APPLICATION_JSON)
						.content(TestUtil.convertObjectToJsonBytes(listaFases)).characterEncoding("UTF-8"))
				.andDo(print()).andExpect(status().isCreated()).andReturn();


	}

}
