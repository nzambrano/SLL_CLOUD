package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllTpStaDetId generated by hbm2java
 */
@Embeddable
public class M4sllTpStaDetId  implements java.io.Serializable {


    private String tsdIdTpStaDet;
    private String idOrganization;

    public M4sllTpStaDetId() {
    }

    public M4sllTpStaDetId(String tsdIdTpStaDet, String idOrganization) {
        this.tsdIdTpStaDet = tsdIdTpStaDet;
        this.idOrganization = idOrganization;
    }



    @Column(name="tsd_id_tp_sta_det", nullable=false, length=3)
    public String getTsdIdTpStaDet() {
        return this.tsdIdTpStaDet;
    }

    public void setTsdIdTpStaDet(String tsdIdTpStaDet) {
        this.tsdIdTpStaDet = tsdIdTpStaDet;
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
        if ( !(other instanceof M4sllTpStaDetId) ) return false;
        M4sllTpStaDetId castOther = ( M4sllTpStaDetId ) other;

        return ( (this.getTsdIdTpStaDet()==castOther.getTsdIdTpStaDet()) || ( this.getTsdIdTpStaDet()!=null && castOther.getTsdIdTpStaDet()!=null && this.getTsdIdTpStaDet().equals(castOther.getTsdIdTpStaDet()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getTsdIdTpStaDet() == null ? 0 : this.getTsdIdTpStaDet().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}

