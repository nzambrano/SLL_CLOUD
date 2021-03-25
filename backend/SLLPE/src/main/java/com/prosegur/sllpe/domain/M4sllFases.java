package com.prosegur.sllpe.domain;
// Generated 23 mar. 2021 16:38:46 by Hibernate Tools 5.2.0.Final


import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * M4sllFases generated by hbm2java
 */
@Entity
@Table(name="m4sll_fases"
    ,schema="sll"
)
public class M4sllFases  implements java.io.Serializable {


     private M4sllFasesId id;
     private String fasIdFaseEstado;
     private String farIdFaseResultado;
     private Date fasFecha;
     private String fasObservacion;
     private Date fasDtCitacion;
     private String fasNroRadicacion;
     private String triIdTribunal;
     private String fasJuez;
     private BigDecimal fasValorCondena;
     private BigDecimal fasValorHonorarios;
     private Short fasPorcCondena;
     private Short fasPorcHonorarios;
     private String idApprole;
     private String idSecuser;
     private Date dtLastUpdate;
     private String fasChkRobot;
     private Long fasSecuencia;
     private String fasNumJuzgado;
     private Date fasFechaCond;
     private Date fasFechaHon;
     private String fasObsHon;
     private Date fasDtImpacto;
     private String fasHora;

    public M4sllFases() {
    }

	
    public M4sllFases(M4sllFasesId id) {
        this.id = id;
    }
    public M4sllFases(M4sllFasesId id, String fasIdFaseEstado, String farIdFaseResultado, Date fasFecha, String fasObservacion, Date fasDtCitacion, String fasNroRadicacion, String triIdTribunal, String fasJuez, BigDecimal fasValorCondena, BigDecimal fasValorHonorarios, Short fasPorcCondena, Short fasPorcHonorarios, String idApprole, String idSecuser, Date dtLastUpdate, String fasChkRobot, Long fasSecuencia, String fasNumJuzgado, Date fasFechaCond, Date fasFechaHon, String fasObsHon, Date fasDtImpacto, String fasHora) {
       this.id = id;
       this.fasIdFaseEstado = fasIdFaseEstado;
       this.farIdFaseResultado = farIdFaseResultado;
       this.fasFecha = fasFecha;
       this.fasObservacion = fasObservacion;
       this.fasDtCitacion = fasDtCitacion;
       this.fasNroRadicacion = fasNroRadicacion;
       this.triIdTribunal = triIdTribunal;
       this.fasJuez = fasJuez;
       this.fasValorCondena = fasValorCondena;
       this.fasValorHonorarios = fasValorHonorarios;
       this.fasPorcCondena = fasPorcCondena;
       this.fasPorcHonorarios = fasPorcHonorarios;
       this.idApprole = idApprole;
       this.idSecuser = idSecuser;
       this.dtLastUpdate = dtLastUpdate;
       this.fasChkRobot = fasChkRobot;
       this.fasSecuencia = fasSecuencia;
       this.fasNumJuzgado = fasNumJuzgado;
       this.fasFechaCond = fasFechaCond;
       this.fasFechaHon = fasFechaHon;
       this.fasObsHon = fasObsHon;
       this.fasDtImpacto = fasDtImpacto;
       this.fasHora = fasHora;
    }
   
     @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="litIdLitigio", column=@Column(name="lit_id_litigio", nullable=false, length=10) ), 
        @AttributeOverride(name="tfaIdTpFase", column=@Column(name="tfa_id_tp_fase", nullable=false, length=3) ), 
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) ) } )
    public M4sllFasesId getId() {
        return this.id;
    }
    
    public void setId(M4sllFasesId id) {
        this.id = id;
    }

    
    @Column(name="fas_id_fase_estado", length=3)
    public String getFasIdFaseEstado() {
        return this.fasIdFaseEstado;
    }
    
    public void setFasIdFaseEstado(String fasIdFaseEstado) {
        this.fasIdFaseEstado = fasIdFaseEstado;
    }

    
    @Column(name="far_id_fase_resultado", length=3)
    public String getFarIdFaseResultado() {
        return this.farIdFaseResultado;
    }
    
    public void setFarIdFaseResultado(String farIdFaseResultado) {
        this.farIdFaseResultado = farIdFaseResultado;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="fas_fecha", length=22)
    public Date getFasFecha() {
        return this.fasFecha;
    }
    
    public void setFasFecha(Date fasFecha) {
        this.fasFecha = fasFecha;
    }

    
    @Column(name="fas_observacion", length=1000)
    public String getFasObservacion() {
        return this.fasObservacion;
    }
    
    public void setFasObservacion(String fasObservacion) {
        this.fasObservacion = fasObservacion;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="fas_dt_citacion", length=22)
    public Date getFasDtCitacion() {
        return this.fasDtCitacion;
    }
    
    public void setFasDtCitacion(Date fasDtCitacion) {
        this.fasDtCitacion = fasDtCitacion;
    }

    
    @Column(name="fas_nro_radicacion", length=30)
    public String getFasNroRadicacion() {
        return this.fasNroRadicacion;
    }
    
    public void setFasNroRadicacion(String fasNroRadicacion) {
        this.fasNroRadicacion = fasNroRadicacion;
    }

    
    @Column(name="tri_id_tribunal", length=3)
    public String getTriIdTribunal() {
        return this.triIdTribunal;
    }
    
    public void setTriIdTribunal(String triIdTribunal) {
        this.triIdTribunal = triIdTribunal;
    }

    
    @Column(name="fas_juez", length=254)
    public String getFasJuez() {
        return this.fasJuez;
    }
    
    public void setFasJuez(String fasJuez) {
        this.fasJuez = fasJuez;
    }

    
    @Column(name="fas_valor_condena", precision=18, scale=4)
    public BigDecimal getFasValorCondena() {
        return this.fasValorCondena;
    }
    
    public void setFasValorCondena(BigDecimal fasValorCondena) {
        this.fasValorCondena = fasValorCondena;
    }

    
    @Column(name="fas_valor_honorarios", precision=14, scale=4)
    public BigDecimal getFasValorHonorarios() {
        return this.fasValorHonorarios;
    }
    
    public void setFasValorHonorarios(BigDecimal fasValorHonorarios) {
        this.fasValorHonorarios = fasValorHonorarios;
    }

    
    @Column(name="fas_porc_condena")
    public Short getFasPorcCondena() {
        return this.fasPorcCondena;
    }
    
    public void setFasPorcCondena(Short fasPorcCondena) {
        this.fasPorcCondena = fasPorcCondena;
    }

    
    @Column(name="fas_porc_honorarios")
    public Short getFasPorcHonorarios() {
        return this.fasPorcHonorarios;
    }
    
    public void setFasPorcHonorarios(Short fasPorcHonorarios) {
        this.fasPorcHonorarios = fasPorcHonorarios;
    }

    
    @Column(name="id_approle", length=30)
    public String getIdApprole() {
        return this.idApprole;
    }
    
    public void setIdApprole(String idApprole) {
        this.idApprole = idApprole;
    }

    
    @Column(name="id_secuser", length=30)
    public String getIdSecuser() {
        return this.idSecuser;
    }
    
    public void setIdSecuser(String idSecuser) {
        this.idSecuser = idSecuser;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="dt_last_update", length=22)
    public Date getDtLastUpdate() {
        return this.dtLastUpdate;
    }
    
    public void setDtLastUpdate(Date dtLastUpdate) {
        this.dtLastUpdate = dtLastUpdate;
    }

    
    @Column(name="fas_chk_robot", length=1)
    public String getFasChkRobot() {
        return this.fasChkRobot;
    }
    
    public void setFasChkRobot(String fasChkRobot) {
        this.fasChkRobot = fasChkRobot;
    }

    
    @Column(name="fas_secuencia")
    public Long getFasSecuencia() {
        return this.fasSecuencia;
    }
    
    public void setFasSecuencia(Long fasSecuencia) {
        this.fasSecuencia = fasSecuencia;
    }

    
    @Column(name="fas_num_juzgado", length=10)
    public String getFasNumJuzgado() {
        return this.fasNumJuzgado;
    }
    
    public void setFasNumJuzgado(String fasNumJuzgado) {
        this.fasNumJuzgado = fasNumJuzgado;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="fas_fecha_cond", length=22)
    public Date getFasFechaCond() {
        return this.fasFechaCond;
    }
    
    public void setFasFechaCond(Date fasFechaCond) {
        this.fasFechaCond = fasFechaCond;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="fas_fecha_hon", length=22)
    public Date getFasFechaHon() {
        return this.fasFechaHon;
    }
    
    public void setFasFechaHon(Date fasFechaHon) {
        this.fasFechaHon = fasFechaHon;
    }

    
    @Column(name="fas_obs_hon", length=1000)
    public String getFasObsHon() {
        return this.fasObsHon;
    }
    
    public void setFasObsHon(String fasObsHon) {
        this.fasObsHon = fasObsHon;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="fas_dt_impacto", length=22)
    public Date getFasDtImpacto() {
        return this.fasDtImpacto;
    }
    
    public void setFasDtImpacto(Date fasDtImpacto) {
        this.fasDtImpacto = fasDtImpacto;
    }

    
    @Column(name="fas_hora", length=5)
    public String getFasHora() {
        return this.fasHora;
    }
    
    public void setFasHora(String fasHora) {
        this.fasHora = fasHora;
    }




}

