package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:12:02 AM by Hibernate Tools 5.2.0.Final


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
 * StdGeoPlace generated by hbm2java
 */
@Entity
@Table(name="std_geo_place"
            ,schema="public"
      )
public class StdGeoPlace  implements java.io.Serializable {


    private StdGeoPlaceId id;
    private String stdNGeoPlaceng;
    private String stdNGeoPlacesp;
    private String stdNGeoPlacfra;
    private String stdNGeoPlacger;
    private String stdNGeoPlacbra;
    private String stdNGeoPlacita;
    private String stdNGeoPlacgen;
    private String stdIdLegalPlace;
    private String scbIdZonaUpc;
    private String idApprole;
    private String idSecuser;
    private Date dtLastUpdate;

    public StdGeoPlace() {
    }


    public StdGeoPlace(StdGeoPlaceId id) {
        this.id = id;
    }
    public StdGeoPlace(StdGeoPlaceId id, String stdNGeoPlaceng, String stdNGeoPlacesp, String stdNGeoPlacfra, String stdNGeoPlacger, String stdNGeoPlacbra, String stdNGeoPlacita, String stdNGeoPlacgen, String stdIdLegalPlace, String scbIdZonaUpc, String idApprole, String idSecuser, Date dtLastUpdate) {
        this.id = id;
        this.stdNGeoPlaceng = stdNGeoPlaceng;
        this.stdNGeoPlacesp = stdNGeoPlacesp;
        this.stdNGeoPlacfra = stdNGeoPlacfra;
        this.stdNGeoPlacger = stdNGeoPlacger;
        this.stdNGeoPlacbra = stdNGeoPlacbra;
        this.stdNGeoPlacita = stdNGeoPlacita;
        this.stdNGeoPlacgen = stdNGeoPlacgen;
        this.stdIdLegalPlace = stdIdLegalPlace;
        this.scbIdZonaUpc = scbIdZonaUpc;
        this.idApprole = idApprole;
        this.idSecuser = idSecuser;
        this.dtLastUpdate = dtLastUpdate;
    }

    @EmbeddedId


    @AttributeOverrides( {
        @AttributeOverride(name="stdIdCountry", column=@Column(name="std_id_country", nullable=false, length=4) ),
        @AttributeOverride(name="stdIdGeoDiv", column=@Column(name="std_id_geo_div", nullable=false, length=4) ),
        @AttributeOverride(name="stdIdSubGeoDiv", column=@Column(name="std_id_sub_geo_div", nullable=false, length=8) ),
        @AttributeOverride(name="stdIdGeoPlace", column=@Column(name="std_id_geo_place", nullable=false, length=9) ),
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) )
    } )
    public StdGeoPlaceId getId() {
        return this.id;
    }

    public void setId(StdGeoPlaceId id) {
        this.id = id;
    }


    @Column(name="std_n_geo_placeng", length=62)
    public String getStdNGeoPlaceng() {
        return this.stdNGeoPlaceng;
    }

    public void setStdNGeoPlaceng(String stdNGeoPlaceng) {
        this.stdNGeoPlaceng = stdNGeoPlaceng;
    }


    @Column(name="std_n_geo_placesp", length=62)
    public String getStdNGeoPlacesp() {
        return this.stdNGeoPlacesp;
    }

    public void setStdNGeoPlacesp(String stdNGeoPlacesp) {
        this.stdNGeoPlacesp = stdNGeoPlacesp;
    }


    @Column(name="std_n_geo_placfra", length=62)
    public String getStdNGeoPlacfra() {
        return this.stdNGeoPlacfra;
    }

    public void setStdNGeoPlacfra(String stdNGeoPlacfra) {
        this.stdNGeoPlacfra = stdNGeoPlacfra;
    }


    @Column(name="std_n_geo_placger", length=62)
    public String getStdNGeoPlacger() {
        return this.stdNGeoPlacger;
    }

    public void setStdNGeoPlacger(String stdNGeoPlacger) {
        this.stdNGeoPlacger = stdNGeoPlacger;
    }


    @Column(name="std_n_geo_placbra", length=62)
    public String getStdNGeoPlacbra() {
        return this.stdNGeoPlacbra;
    }

    public void setStdNGeoPlacbra(String stdNGeoPlacbra) {
        this.stdNGeoPlacbra = stdNGeoPlacbra;
    }


    @Column(name="std_n_geo_placita", length=62)
    public String getStdNGeoPlacita() {
        return this.stdNGeoPlacita;
    }

    public void setStdNGeoPlacita(String stdNGeoPlacita) {
        this.stdNGeoPlacita = stdNGeoPlacita;
    }


    @Column(name="std_n_geo_placgen", length=62)
    public String getStdNGeoPlacgen() {
        return this.stdNGeoPlacgen;
    }

    public void setStdNGeoPlacgen(String stdNGeoPlacgen) {
        this.stdNGeoPlacgen = stdNGeoPlacgen;
    }


    @Column(name="std_id_legal_place", length=9)
    public String getStdIdLegalPlace() {
        return this.stdIdLegalPlace;
    }

    public void setStdIdLegalPlace(String stdIdLegalPlace) {
        this.stdIdLegalPlace = stdIdLegalPlace;
    }


    @Column(name="scb_id_zona_upc", length=3)
    public String getScbIdZonaUpc() {
        return this.scbIdZonaUpc;
    }

    public void setScbIdZonaUpc(String scbIdZonaUpc) {
        this.scbIdZonaUpc = scbIdZonaUpc;
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


