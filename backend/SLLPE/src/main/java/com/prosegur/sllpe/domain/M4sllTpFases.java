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
 * M4sllTpFases generated by hbm2java
 */
@Entity
@Table(name="m4sll_tp_fases"
            ,schema="sll"
      )
public class M4sllTpFases  implements java.io.Serializable {


    private M4sllTpFasesId id;
    private String tfaNmTpFase;
    private String tplIdTpLitigio;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;
    private Date tfaDtStart;
    private Date tfaDtEnd;

    public M4sllTpFases() {
    }


    public M4sllTpFases(M4sllTpFasesId id) {
        this.id = id;
    }
    public M4sllTpFases(M4sllTpFasesId id, String tfaNmTpFase, String tplIdTpLitigio, String idApprole, String idSecuser, Date dtLastUpdate, Date tfaDtStart, Date tfaDtEnd) {
        this.id = id;
        this.tfaNmTpFase = tfaNmTpFase;
        this.tplIdTpLitigio = tplIdTpLitigio;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
        this.tfaDtStart = tfaDtStart;
        this.tfaDtEnd = tfaDtEnd;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="tfaIdTpFase", column=@Column(name="tfa_id_tp_fase", nullable=false, length=3) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public M4sllTpFasesId getId() {
        return this.id;
    }

    public void setId(M4sllTpFasesId id) {
        this.id = id;
    }


    @Column(name="tfa_nm_tp_fase", length=254)
    public String getTfaNmTpFase() {
        return this.tfaNmTpFase;
    }

    public void setTfaNmTpFase(String tfaNmTpFase) {
        this.tfaNmTpFase = tfaNmTpFase;
    }


    @Column(name="tpl_id_tp_litigio", length=3)
    public String getTplIdTpLitigio() {
        return this.tplIdTpLitigio;
    }

    public void setTplIdTpLitigio(String tplIdTpLitigio) {
        this.tplIdTpLitigio = tplIdTpLitigio;
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
    @Column(name="tfa_dt_start", length=22)
    public Date getTfaDtStart() {
        return this.tfaDtStart;
    }

    public void setTfaDtStart(Date tfaDtStart) {
        this.tfaDtStart = tfaDtStart;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="tfa_dt_end", length=22)
    public Date getTfaDtEnd() {
        return this.tfaDtEnd;
    }

    public void setTfaDtEnd(Date tfaDtEnd) {
        this.tfaDtEnd = tfaDtEnd;
    }




}


