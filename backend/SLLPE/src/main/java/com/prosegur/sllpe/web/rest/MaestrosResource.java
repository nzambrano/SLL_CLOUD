package com.prosegur.sllpe.web.rest;

import com.prosegur.sllpe.repository.StdGeoDivRepository;
import com.prosegur.sllpe.repository.M4sllNegociosRepository;
import com.prosegur.sllpe.repository.StdLegEntRepository;
import com.prosegur.sllpe.repository.M4sllMtAbogadosRepository;
import com.prosegur.sllpe.repository.M4sllEstudioJurRepository;
import com.prosegur.sllpe.repository.M4sllMtoCodAltRepository;
import com.prosegur.sllpe.repository.M4sllMtoRiesgosRepository;
import com.prosegur.sllpe.repository.M4sllTpStatusRepository;
import com.prosegur.sllpe.repository.M4sllTpAutorReuRepository;
import com.prosegur.sllpe.repository.M4sllTpPedidoRepository;
import com.prosegur.sllpe.repository.M4sllTpFasesRepository;
import com.prosegur.sllpe.repository.M4sllTribunalesRepository;
import com.prosegur.sllpe.repository.M4sllTpCompromisRepository;
import com.prosegur.sllpe.repository.M4sllTpDocLitigRepository;
import com.prosegur.sllpe.repository.M4sllTpEntidadesRepository;
import com.prosegur.sllpe.repository.M4sllTpIdentificRepository;
import com.prosegur.sllpe.repository.M4sllTpLitigiosRepository;
import com.prosegur.sllpe.repository.M4sllTpMotivoRepository;
import com.prosegur.sllpe.repository.M4sllTpPagosRepository;
import com.prosegur.sllpe.repository.M4sllTpRecurrenRepository;
import com.prosegur.sllpe.repository.M4sllTpRolesRepository;
import com.prosegur.sllpe.repository.M4sllTpStaDetRepository;
import com.prosegur.sllpe.repository.M4sllTpValEcoRepository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * FooResource controller
 */
@RestController
@RequestMapping("/api/maestros")
public class MaestrosResource {

    private final Logger log = LoggerFactory.getLogger(MaestrosResource.class);

    private StdGeoDivRepository             stdGeoDivRepository;
    private M4sllNegociosRepository         m4sllNegociosRepository;
    private StdLegEntRepository             stdLegEntRepository;
    private M4sllMtAbogadosRepository       m4sllMtAbogadosRepository;
    private M4sllEstudioJurRepository       m4sllEstudioJurRepository;
    private M4sllMtoCodAltRepository        m4sllMtoCodAltRepository;
    private M4sllMtoRiesgosRepository       m4sllMtoRiesgosRepository;
    private M4sllTpStatusRepository         m4sllTpStatusRepository;
    private M4sllTpAutorReuRepository       m4sllTpAutorReuRepository;
    private M4sllTpPedidoRepository         m4sllTpPedidoRepository;
    private M4sllTpFasesRepository          m4sllTpFasesRepository;
    private M4sllTribunalesRepository       m4sllTribunalesRepository;
    private M4sllTpCompromisRepository      m4sllTpCompromisRepository;
    private M4sllTpDocLitigRepository       m4sllTpDocLitigRepository;
    private M4sllTpEntidadesRepository      m4sllTpEntidadesRepository;
    private M4sllTpIdentificRepository      m4sllTpIdentificRepository;
    private M4sllTpLitigiosRepository       m4sllTpLitigiosRepository;
    private M4sllTpMotivoRepository         m4sllTpMotivoRepository;
    private M4sllTpPagosRepository          m4sllTpPagosRepository;
    private M4sllTpRecurrenRepository       m4sllTpRecurrenRepository;
    private M4sllTpRolesRepository          m4sllTpRolesRepository;
    private M4sllTpStaDetRepository         m4sllTpStaDetRepository;
    private M4sllTpValEcoRepository         m4sllTpValEcoRepository;

    public MaestrosResource(
        StdGeoDivRepository             stdGeoDivRepository,
        M4sllNegociosRepository         m4sllNegociosRepository,
        StdLegEntRepository             stdLegEntRepository,
        M4sllMtAbogadosRepository       m4sllMtAbogadosRepository,
        M4sllEstudioJurRepository       m4sllEstudioJurRepository,
        M4sllMtoCodAltRepository        m4sllMtoCodAltRepository,
        M4sllMtoRiesgosRepository       m4sllMtoRiesgosRepository,
        M4sllTpStatusRepository         m4sllTpStatusRepository,
        M4sllTpAutorReuRepository       m4sllTpAutorReuRepository,
        M4sllTpPedidoRepository         m4sllTpPedidoRepository,
        M4sllTpFasesRepository          m4sllTpFasesRepository,
        M4sllTribunalesRepository       m4sllTribunalesRepository,
        M4sllTpCompromisRepository      m4sllTpCompromisRepository,
        M4sllTpDocLitigRepository       m4sllTpDocLitigRepository,
        M4sllTpEntidadesRepository      m4sllTpEntidadesRepository,
        M4sllTpIdentificRepository      m4sllTpIdentificRepository,
        M4sllTpLitigiosRepository       m4sllTpLitigiosRepository,
        M4sllTpMotivoRepository         m4sllTpMotivoRepository,
        M4sllTpPagosRepository          m4sllTpPagosRepository,
        M4sllTpRecurrenRepository       m4sllTpRecurrenRepository,
        M4sllTpRolesRepository          m4sllTpRolesRepository,
        M4sllTpStaDetRepository         m4sllTpStaDetRepository,
        M4sllTpValEcoRepository         m4sllTpValEcoRepository
    ) {
        this.stdGeoDivRepository           =  stdGeoDivRepository;
        this.m4sllNegociosRepository       =  m4sllNegociosRepository;
        this.stdLegEntRepository           =  stdLegEntRepository;
        this.m4sllMtAbogadosRepository     =  m4sllMtAbogadosRepository;
        this.m4sllEstudioJurRepository     =  m4sllEstudioJurRepository;
        this.m4sllMtoCodAltRepository      =  m4sllMtoCodAltRepository;
        this.m4sllMtoRiesgosRepository     =  m4sllMtoRiesgosRepository;
        this.m4sllTpStatusRepository       =  m4sllTpStatusRepository;
        this.m4sllTpAutorReuRepository     =  m4sllTpAutorReuRepository;
        this.m4sllTpPedidoRepository       =  m4sllTpPedidoRepository;
        this.m4sllTpFasesRepository        =  m4sllTpFasesRepository;
        this.m4sllTribunalesRepository     =  m4sllTribunalesRepository;
        this.m4sllTpCompromisRepository    =  m4sllTpCompromisRepository;
        this.m4sllTpDocLitigRepository     =  m4sllTpDocLitigRepository;
        this.m4sllTpEntidadesRepository    =  m4sllTpEntidadesRepository;
        this.m4sllTpIdentificRepository    =  m4sllTpIdentificRepository;
        this.m4sllTpLitigiosRepository     =  m4sllTpLitigiosRepository;
        this.m4sllTpMotivoRepository       =  m4sllTpMotivoRepository;
        this.m4sllTpPagosRepository        =  m4sllTpPagosRepository;
        this.m4sllTpRecurrenRepository     =  m4sllTpRecurrenRepository;
        this.m4sllTpRolesRepository        =  m4sllTpRolesRepository;
        this.m4sllTpStaDetRepository       =  m4sllTpStaDetRepository;
        this.m4sllTpValEcoRepository       =  m4sllTpValEcoRepository;
    }

    /**
     * GET listar
     *
     * @throws JSONException
     */
    @GetMapping("/listarMaestros")
    public ResponseEntity<Object> listar() {
        List<HashMap<String, Object>> entities = new ArrayList<HashMap<String, Object>>();
        HashMap<String, Object> map = new HashMap<>();
        // StdIdCountry = 7 es  Perú
        map.put("STD_GEO_DIV",             stdGeoDivRepository.findByIdOrganizationStdIdCountry("0050","7"));
        map.put("M4SLL_NEGOCIOS",          m4sllNegociosRepository.findByIdOrganization("0050"));
        map.put("STD_LEG_ENT",             stdLegEntRepository.findByIdOrganization("0050"));
        map.put("M4SLL_MT_ABOGADOS",       m4sllMtAbogadosRepository.findByIdOrganization("0050"));
        map.put("M4SLL_MT_ABOGADOSINT",    m4sllMtAbogadosRepository.findByIdOrganizationMabChkInt("0050", "I"));
        map.put("M4SLL_MT_ABOGADOSEXT",    m4sllMtAbogadosRepository.findByIdOrganizationMabChkInt("0050","E"));
        map.put("M4SLL_ESTUDIO_JUR",       m4sllEstudioJurRepository.findByIdOrganization("0050"));
        map.put("M4SLL_MTO_COD_ALT",       m4sllMtoCodAltRepository.findByIdOrganization("0050"));
        map.put("M4SLL_MTO_RIESGOS",       m4sllMtoRiesgosRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_STATUS",         m4sllTpStatusRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_AUTOR_REU",      m4sllTpAutorReuRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_PEDIDO",         m4sllTpPedidoRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_FASES",          m4sllTpFasesRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TRIBUNALES",        m4sllTribunalesRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_COMPROMIS",      m4sllTpCompromisRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_DOC_LITIG",      m4sllTpDocLitigRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_ENTIDADES",      m4sllTpEntidadesRepository.findAll());
        map.put("M4SLL_TP_IDENTIFIC",      m4sllTpIdentificRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_LITIGIOS",       m4sllTpLitigiosRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_MOTIVO",         m4sllTpMotivoRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_PAGOS",          m4sllTpPagosRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_RECURREN",       m4sllTpRecurrenRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_ROLES",          m4sllTpRolesRepository.findByIdOrganization("0050"));
        map.put("M4SLL_TP_STA_DET",        m4sllTpStaDetRepository.findAll());
        map.put("M4SLL_TP_VAL_ECO",        m4sllTpValEcoRepository.findByIdOrganization("0050"));

        entities.add(map);
        return new ResponseEntity<Object>(entities, HttpStatus.OK);
    }

    @GetMapping("/listarMaestro/{id}")
    public ResponseEntity<Object> listarFiltrado(@PathVariable String id) {
        List<HashMap<String, Object>> entities = new ArrayList<HashMap<String, Object>>();

        if (id.equals("negocios")) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("negocios", m4sllNegociosRepository.findByIdOrganization("0050"));
            entities.add(map);
        } else if (id.equals("status")) {
            HashMap<String, Object> map = new HashMap<>();
            //map.put("Status", fasesRepository.findAll());
            entities.add(map);
        }

        return new ResponseEntity<Object>(entities, HttpStatus.OK);
    }
}
