package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:12:48 AM by Hibernate Tools 5.2.0.Final


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * StdSubGeoDivId generated by hbm2java
 */
@Embeddable
public class StdSubGeoDivId  implements java.io.Serializable {


    private String stdIdCountry;
    private String stdIdGeoDiv;
    private String stdIdSubGeoDiv;
    private String idOrganization;

    public StdSubGeoDivId() {
    }

    public StdSubGeoDivId(String stdIdCountry, String stdIdGeoDiv, String stdIdSubGeoDiv, String idOrganization) {
        this.stdIdCountry = stdIdCountry;
        this.stdIdGeoDiv = stdIdGeoDiv;
        this.stdIdSubGeoDiv = stdIdSubGeoDiv;
        this.idOrganization = idOrganization;
    }



    @Column(name="std_id_country", nullable=false, length=4)
    public String getStdIdCountry() {
        return this.stdIdCountry;
    }

    public void setStdIdCountry(String stdIdCountry) {
        this.stdIdCountry = stdIdCountry;
    }


    @Column(name="std_id_geo_div", nullable=false, length=4)
    public String getStdIdGeoDiv() {
        return this.stdIdGeoDiv;
    }

    public void setStdIdGeoDiv(String stdIdGeoDiv) {
        this.stdIdGeoDiv = stdIdGeoDiv;
    }


    @Column(name="std_id_sub_geo_div", nullable=false, length=8)
    public String getStdIdSubGeoDiv() {
        return this.stdIdSubGeoDiv;
    }

    public void setStdIdSubGeoDiv(String stdIdSubGeoDiv) {
        this.stdIdSubGeoDiv = stdIdSubGeoDiv;
    }


    @Column(name="id_organization", nullable=false, length=4)
    public String getIdOrganization() {
        return this.idOrganization;
    }

    public void setIdOrganization(String idOrganization) {
        this.idOrganization = idOrganization;
    }


    public boolean equals(Object other) {
        if ( (this == other ) ) return true;
        if ( (other == null ) ) return false;
        if ( !(other instanceof StdSubGeoDivId) ) return false;
        StdSubGeoDivId castOther = ( StdSubGeoDivId ) other;

        return ( (this.getStdIdCountry()==castOther.getStdIdCountry()) || ( this.getStdIdCountry()!=null && castOther.getStdIdCountry()!=null && this.getStdIdCountry().equals(castOther.getStdIdCountry()) ) )
               && ( (this.getStdIdGeoDiv()==castOther.getStdIdGeoDiv()) || ( this.getStdIdGeoDiv()!=null && castOther.getStdIdGeoDiv()!=null && this.getStdIdGeoDiv().equals(castOther.getStdIdGeoDiv()) ) )
               && ( (this.getStdIdSubGeoDiv()==castOther.getStdIdSubGeoDiv()) || ( this.getStdIdSubGeoDiv()!=null && castOther.getStdIdSubGeoDiv()!=null && this.getStdIdSubGeoDiv().equals(castOther.getStdIdSubGeoDiv()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getStdIdCountry() == null ? 0 : this.getStdIdCountry().hashCode() );
        result = 37 * result + ( getStdIdGeoDiv() == null ? 0 : this.getStdIdGeoDiv().hashCode() );
        result = 37 * result + ( getStdIdSubGeoDiv() == null ? 0 : this.getStdIdSubGeoDiv().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


