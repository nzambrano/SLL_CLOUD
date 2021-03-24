package com.prosegur.sllpe.domain;
// Generated 24 mar. 2021 12:53:48 by Hibernate Tools 5.2.0.Final


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
 * M4sllValEcLit generated by hbm2java
 */
@Entity
@Table(name="m4sll_val_ec_lit"
    ,schema="sll"
)
public class M4sllValEcLit  implements java.io.Serializable {


     private M4sllValEcLitId id;
     private String idApprole;
     private String idSecuser;
     private Date dtLastUpdate;
     private String tveIdValEco;
     private BigDecimal velValor;
     private BigDecimal velPorcProv;
     private BigDecimal velImpProv;
     private BigDecimal velValorFinal;
     private Date velDtImpacto;
     private String velObs;

    public M4sllValEcLit() {
    }

	
    public M4sllValEcLit(M4sllValEcLitId id) {
        this.id = id;
    }
    public M4sllValEcLit(M4sllValEcLitId id, String idApprole, String idSecuser, Date dtLastUpdate, String tveIdValEco, BigDecimal velValor, BigDecimal velPorcProv, BigDecimal velImpProv, BigDecimal velValorFinal, Date velDtImpacto, String velObs) {
       this.id = id;
       this.idApprole = idApprole;
       this.idSecuser = idSecuser;
       this.dtLastUpdate = dtLastUpdate;
       this.tveIdValEco = tveIdValEco;
       this.velValor = velValor;
       this.velPorcProv = velPorcProv;
       this.velImpProv = velImpProv;
       this.velValorFinal = velValorFinal;
       this.velDtImpacto = velDtImpacto;
       this.velObs = velObs;
    }
   
     @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="velSecuencia", column=@Column(name="vel_secuencia", nullable=false) ), 
        @AttributeOverride(name="litIdLitigio", column=@Column(name="lit_id_litigio", nullable=false, length=10) ), 
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) ) } )
    public M4sllValEcLitId getId() {
        return this.id;
    }
    
    public void setId(M4sllValEcLitId id) {
        this.id = id;
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

    
    @Column(name="tve_id_val_eco", length=3)
    public String getTveIdValEco() {
        return this.tveIdValEco;
    }
    
    public void setTveIdValEco(String tveIdValEco) {
        this.tveIdValEco = tveIdValEco;
    }

    
    @Column(name="vel_valor", precision=18, scale=4)
    public BigDecimal getVelValor() {
        return this.velValor;
    }
    
    public void setVelValor(BigDecimal velValor) {
        this.velValor = velValor;
    }

    
    @Column(name="vel_porc_prov", precision=18, scale=4)
    public BigDecimal getVelPorcProv() {
        return this.velPorcProv;
    }
    
    public void setVelPorcProv(BigDecimal velPorcProv) {
        this.velPorcProv = velPorcProv;
    }

    
    @Column(name="vel_imp_prov", precision=18, scale=4)
    public BigDecimal getVelImpProv() {
        return this.velImpProv;
    }
    
    public void setVelImpProv(BigDecimal velImpProv) {
        this.velImpProv = velImpProv;
    }

    
    @Column(name="vel_valor_final", precision=18, scale=4)
    public BigDecimal getVelValorFinal() {
        return this.velValorFinal;
    }
    
    public void setVelValorFinal(BigDecimal velValorFinal) {
        this.velValorFinal = velValorFinal;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="vel_dt_impacto", length=22)
    public Date getVelDtImpacto() {
        return this.velDtImpacto;
    }
    
    public void setVelDtImpacto(Date velDtImpacto) {
        this.velDtImpacto = velDtImpacto;
    }

    
    @Column(name="vel_obs", length=1000)
    public String getVelObs() {
        return this.velObs;
    }
    
    public void setVelObs(String velObs) {
        this.velObs = velObs;
    }




}


