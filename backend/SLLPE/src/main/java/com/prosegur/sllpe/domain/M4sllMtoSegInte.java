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
 * M4sllMtoSegInte generated by hbm2java
 */
@Entity
@Table(name="m4sll_mto_seg_inte"
            ,schema="sll"
      )
public class M4sllMtoSegInte  implements java.io.Serializable {


    private M4sllMtoSegInteId id;
    private Date msiDtStart;
    private Date msiDtEnd;
    private String msiColumna;
    private String msiTabla;
    private String msiValor;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;
    private Long mtmIdModulo;

    public M4sllMtoSegInte() {
    }


    public M4sllMtoSegInte(M4sllMtoSegInteId id) {
        this.id = id;
    }
    public M4sllMtoSegInte(M4sllMtoSegInteId id, Date msiDtStart, Date msiDtEnd, String msiColumna, String msiTabla, String msiValor, String idApprole, String idSecuser, Date dtLastUpdate, Long mtmIdModulo) {
        this.id = id;
        this.msiDtStart = msiDtStart;
        this.msiDtEnd = msiDtEnd;
        this.msiColumna = msiColumna;
        this.msiTabla = msiTabla;
        this.msiValor = msiValor;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
        this.mtmIdModulo = mtmIdModulo;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="idAppRole", column=@Column(name="id_app_role", nullable=false, length=30) ),
        @AttributeOverride(name="msiSecuencia", column=@Column(name="msi_secuencia", nullable=false) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public M4sllMtoSegInteId getId() {
        return this.id;
    }

    public void setId(M4sllMtoSegInteId id) {
        this.id = id;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="msi_dt_start", length=22)
    public Date getMsiDtStart() {
        return this.msiDtStart;
    }

    public void setMsiDtStart(Date msiDtStart) {
        this.msiDtStart = msiDtStart;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="msi_dt_end", length=22)
    public Date getMsiDtEnd() {
        return this.msiDtEnd;
    }

    public void setMsiDtEnd(Date msiDtEnd) {
        this.msiDtEnd = msiDtEnd;
    }


    @Column(name="msi_columna", length=254)
    public String getMsiColumna() {
        return this.msiColumna;
    }

    public void setMsiColumna(String msiColumna) {
        this.msiColumna = msiColumna;
    }


    @Column(name="msi_tabla", length=254)
    public String getMsiTabla() {
        return this.msiTabla;
    }

    public void setMsiTabla(String msiTabla) {
        this.msiTabla = msiTabla;
    }


    @Column(name="msi_valor", length=254)
    public String getMsiValor() {
        return this.msiValor;
    }

    public void setMsiValor(String msiValor) {
        this.msiValor = msiValor;
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


    @Column(name="mtm_id_modulo")
    public Long getMtmIdModulo() {
        return this.mtmIdModulo;
    }

    public void setMtmIdModulo(Long mtmIdModulo) {
        this.mtmIdModulo = mtmIdModulo;
    }




}

