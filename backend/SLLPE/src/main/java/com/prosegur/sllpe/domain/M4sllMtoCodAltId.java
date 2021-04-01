package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:07:16 AM by Hibernate Tools 5.2.0.Final


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllMtoCodAltId generated by hbm2java
 */
@Embeddable
public class M4sllMtoCodAltId  implements java.io.Serializable {


    private String mcaIdCodigoAlterno;
    private String idOrganization;

    public M4sllMtoCodAltId() {
    }

    public M4sllMtoCodAltId(String mcaIdCodigoAlterno, String idOrganization) {
        this.mcaIdCodigoAlterno = mcaIdCodigoAlterno;
        this.idOrganization = idOrganization;
    }



    @Column(name="mca_id_codigo_alterno", nullable=false, length=3)
    public String getMcaIdCodigoAlterno() {
        return this.mcaIdCodigoAlterno;
    }

    public void setMcaIdCodigoAlterno(String mcaIdCodigoAlterno) {
        this.mcaIdCodigoAlterno = mcaIdCodigoAlterno;
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
        if ( !(other instanceof M4sllMtoCodAltId) ) return false;
        M4sllMtoCodAltId castOther = ( M4sllMtoCodAltId ) other;

        return ( (this.getMcaIdCodigoAlterno()==castOther.getMcaIdCodigoAlterno()) || ( this.getMcaIdCodigoAlterno()!=null && castOther.getMcaIdCodigoAlterno()!=null && this.getMcaIdCodigoAlterno().equals(castOther.getMcaIdCodigoAlterno()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getMcaIdCodigoAlterno() == null ? 0 : this.getMcaIdCodigoAlterno().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


