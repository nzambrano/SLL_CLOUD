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
 * M4sllTpPagos generated by hbm2java
 */
@Entity
@Table(name="m4sll_tp_pagos"
            ,schema="sll"
      )
public class M4sllTpPagos  implements java.io.Serializable {


    private M4sllTpPagosId id;
    private String tpaNmPago;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;
    private String tpaNumeroCuenta;
    private String tplIdTpLitigio;
    private String tpaVendorId;
    private String tpaVendorSiteId;
    private String vendorName;
    private String tpaNominaSN;
    private String tpaConcepto;
    private Date tpaDtStart;
    private Date tpaDtEnd;

    public M4sllTpPagos() {
    }


    public M4sllTpPagos(M4sllTpPagosId id) {
        this.id = id;
    }
    public M4sllTpPagos(M4sllTpPagosId id, String tpaNmPago, String idApprole, String idSecuser, Date dtLastUpdate, String tpaNumeroCuenta, String tplIdTpLitigio, String tpaVendorId, String tpaVendorSiteId, String vendorName, String tpaNominaSN, String tpaConcepto, Date tpaDtStart, Date tpaDtEnd) {
        this.id = id;
        this.tpaNmPago = tpaNmPago;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
        this.tpaNumeroCuenta = tpaNumeroCuenta;
        this.tplIdTpLitigio = tplIdTpLitigio;
        this.tpaVendorId = tpaVendorId;
        this.tpaVendorSiteId = tpaVendorSiteId;
        this.vendorName = vendorName;
        this.tpaNominaSN = tpaNominaSN;
        this.tpaConcepto = tpaConcepto;
        this.tpaDtStart = tpaDtStart;
        this.tpaDtEnd = tpaDtEnd;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="tpaIdPago", column=@Column(name="tpa_id_pago", nullable=false, length=3) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public M4sllTpPagosId getId() {
        return this.id;
    }

    public void setId(M4sllTpPagosId id) {
        this.id = id;
    }


    @Column(name="tpa_nm_pago", length=254)
    public String getTpaNmPago() {
        return this.tpaNmPago;
    }

    public void setTpaNmPago(String tpaNmPago) {
        this.tpaNmPago = tpaNmPago;
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


    @Column(name="tpa_numero_cuenta", length=30)
    public String getTpaNumeroCuenta() {
        return this.tpaNumeroCuenta;
    }

    public void setTpaNumeroCuenta(String tpaNumeroCuenta) {
        this.tpaNumeroCuenta = tpaNumeroCuenta;
    }


    @Column(name="tpl_id_tp_litigio", length=3)
    public String getTplIdTpLitigio() {
        return this.tplIdTpLitigio;
    }

    public void setTplIdTpLitigio(String tplIdTpLitigio) {
        this.tplIdTpLitigio = tplIdTpLitigio;
    }


    @Column(name="tpa_vendor_id", length=15)
    public String getTpaVendorId() {
        return this.tpaVendorId;
    }

    public void setTpaVendorId(String tpaVendorId) {
        this.tpaVendorId = tpaVendorId;
    }


    @Column(name="tpa_vendor_site_id", length=15)
    public String getTpaVendorSiteId() {
        return this.tpaVendorSiteId;
    }

    public void setTpaVendorSiteId(String tpaVendorSiteId) {
        this.tpaVendorSiteId = tpaVendorSiteId;
    }


    @Column(name="vendor_name", length=240)
    public String getVendorName() {
        return this.vendorName;
    }

    public void setVendorName(String vendorName) {
        this.vendorName = vendorName;
    }


    @Column(name="tpa_nomina_s_n", length=1)
    public String getTpaNominaSN() {
        return this.tpaNominaSN;
    }

    public void setTpaNominaSN(String tpaNominaSN) {
        this.tpaNominaSN = tpaNominaSN;
    }


    @Column(name="tpa_concepto", length=1)
    public String getTpaConcepto() {
        return this.tpaConcepto;
    }

    public void setTpaConcepto(String tpaConcepto) {
        this.tpaConcepto = tpaConcepto;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="tpa_dt_start", length=22)
    public Date getTpaDtStart() {
        return this.tpaDtStart;
    }

    public void setTpaDtStart(Date tpaDtStart) {
        this.tpaDtStart = tpaDtStart;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="tpa_dt_end", length=22)
    public Date getTpaDtEnd() {
        return this.tpaDtEnd;
    }

    public void setTpaDtEnd(Date tpaDtEnd) {
        this.tpaDtEnd = tpaDtEnd;
    }




}

