package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:07:16 AM by Hibernate Tools 5.2.0.Final


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
 * M4sllMtoCodAlt generated by hbm2java
 */
@Entity
@Table(name="m4sll_mto_cod_alt"
            ,schema="sll"
      )
public class M4sllMtoCodAlt  implements java.io.Serializable {


    private M4sllMtoCodAltId id;
    private String mcaNmCodigoAlterno;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;
    private Date mcaDtEnd;
    private Date mcaDtStart;

    public M4sllMtoCodAlt() {
    }


    public M4sllMtoCodAlt(M4sllMtoCodAltId id) {
        this.id = id;
    }
    public M4sllMtoCodAlt(M4sllMtoCodAltId id, String mcaNmCodigoAlterno, String idApprole, String idSecuser, Date dtLastUpdate, Date mcaDtEnd, Date mcaDtStart) {
        this.id = id;
        this.mcaNmCodigoAlterno = mcaNmCodigoAlterno;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
        this.mcaDtEnd = mcaDtEnd;
        this.mcaDtStart = mcaDtStart;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="mcaIdCodigoAlterno", column=@Column(name="mca_id_codigo_alterno", nullable=false, length=3) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public M4sllMtoCodAltId getId() {
        return this.id;
    }

    public void setId(M4sllMtoCodAltId id) {
        this.id = id;
    }


    @Column(name="mca_nm_codigo_alterno", length=254)
    public String getMcaNmCodigoAlterno() {
        return this.mcaNmCodigoAlterno;
    }

    public void setMcaNmCodigoAlterno(String mcaNmCodigoAlterno) {
        this.mcaNmCodigoAlterno = mcaNmCodigoAlterno;
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

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="mca_dt_end", length=22)
    public Date getMcaDtEnd() {
        return this.mcaDtEnd;
    }

    public void setMcaDtEnd(Date mcaDtEnd) {
        this.mcaDtEnd = mcaDtEnd;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="mca_dt_start", length=22)
    public Date getMcaDtStart() {
        return this.mcaDtStart;
    }

    public void setMcaDtStart(Date mcaDtStart) {
        this.mcaDtStart = mcaDtStart;
    }




}


