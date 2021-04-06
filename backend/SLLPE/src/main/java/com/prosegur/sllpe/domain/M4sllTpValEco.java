package com.prosegur.sllpe.domain;


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
 * M4sllTpValEco generated by hbm2java
 */
@Entity
@Table(name="m4sll_tp_val_eco"
            ,schema="sll"
      )
public class M4sllTpValEco  implements java.io.Serializable {


    private M4sllTpValEcoId id;
    private String tveNmValEco;
    private Date tveDtStart;
    private Date tveDtEnd;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;

    public M4sllTpValEco() {
    }


    public M4sllTpValEco(M4sllTpValEcoId id) {
        this.id = id;
    }
    public M4sllTpValEco(M4sllTpValEcoId id, String tveNmValEco, Date tveDtStart, Date tveDtEnd, String idApprole, String idSecuser, Date dtLastUpdate) {
        this.id = id;
        this.tveNmValEco = tveNmValEco;
        this.tveDtStart = tveDtStart;
        this.tveDtEnd = tveDtEnd;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="tveIdValEco", column=@Column(name="tve_id_val_eco", nullable=false, length=3) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public M4sllTpValEcoId getId() {
        return this.id;
    }

    public void setId(M4sllTpValEcoId id) {
        this.id = id;
    }


    @Column(name="tve_nm_val_eco", length=254)
    public String getTveNmValEco() {
        return this.tveNmValEco;
    }

    public void setTveNmValEco(String tveNmValEco) {
        this.tveNmValEco = tveNmValEco;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="tve_dt_start", length=22)
    public Date getTveDtStart() {
        return this.tveDtStart;
    }

    public void setTveDtStart(Date tveDtStart) {
        this.tveDtStart = tveDtStart;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="tve_dt_end", length=22)
    public Date getTveDtEnd() {
        return this.tveDtEnd;
    }

    public void setTveDtEnd(Date tveDtEnd) {
        this.tveDtEnd = tveDtEnd;
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




}


