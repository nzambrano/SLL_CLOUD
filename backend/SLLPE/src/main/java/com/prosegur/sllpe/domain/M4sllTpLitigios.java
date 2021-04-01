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
 * M4sllTpLitigios generated by hbm2java
 */
@Entity
@Table(name="m4sll_tp_litigios"
            ,schema="sll"
      )
public class M4sllTpLitigios  implements java.io.Serializable {


    private M4sllTpLitigiosId id;
    private String tplNmTpLitigio;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;
    private Date tplDtStart;
    private Date tplDtEnd;

    public M4sllTpLitigios() {
    }


    public M4sllTpLitigios(M4sllTpLitigiosId id) {
        this.id = id;
    }
    public M4sllTpLitigios(M4sllTpLitigiosId id, String tplNmTpLitigio, String idApprole, String idSecuser, Date dtLastUpdate, Date tplDtStart, Date tplDtEnd) {
        this.id = id;
        this.tplNmTpLitigio = tplNmTpLitigio;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
        this.tplDtStart = tplDtStart;
        this.tplDtEnd = tplDtEnd;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="tplIdTpLitigio", column=@Column(name="tpl_id_tp_litigio", nullable=false, length=3) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public M4sllTpLitigiosId getId() {
        return this.id;
    }

    public void setId(M4sllTpLitigiosId id) {
        this.id = id;
    }


    @Column(name="tpl_nm_tp_litigio", length=254)
    public String getTplNmTpLitigio() {
        return this.tplNmTpLitigio;
    }

    public void setTplNmTpLitigio(String tplNmTpLitigio) {
        this.tplNmTpLitigio = tplNmTpLitigio;
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
    @Column(name="tpl_dt_start", length=22)
    public Date getTplDtStart() {
        return this.tplDtStart;
    }

    public void setTplDtStart(Date tplDtStart) {
        this.tplDtStart = tplDtStart;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="tpl_dt_end", length=22)
    public Date getTplDtEnd() {
        return this.tplDtEnd;
    }

    public void setTplDtEnd(Date tplDtEnd) {
        this.tplDtEnd = tplDtEnd;
    }




}


