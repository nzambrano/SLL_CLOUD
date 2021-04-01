package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllTpIdentificId generated by hbm2java
 */
@Embeddable
public class M4sllTpIdentificId  implements java.io.Serializable {


    private String tpiIdTpIdentificacion;
    private String idOrganization;

    public M4sllTpIdentificId() {
    }

    public M4sllTpIdentificId(String tpiIdTpIdentificacion, String idOrganization) {
        this.tpiIdTpIdentificacion = tpiIdTpIdentificacion;
        this.idOrganization = idOrganization;
    }



    @Column(name="tpi_id_tp_identificacion", nullable=false, length=3)
    public String getTpiIdTpIdentificacion() {
        return this.tpiIdTpIdentificacion;
    }

    public void setTpiIdTpIdentificacion(String tpiIdTpIdentificacion) {
        this.tpiIdTpIdentificacion = tpiIdTpIdentificacion;
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
        if ( !(other instanceof M4sllTpIdentificId) ) return false;
        M4sllTpIdentificId castOther = ( M4sllTpIdentificId ) other;

        return ( (this.getTpiIdTpIdentificacion()==castOther.getTpiIdTpIdentificacion()) || ( this.getTpiIdTpIdentificacion()!=null && castOther.getTpiIdTpIdentificacion()!=null && this.getTpiIdTpIdentificacion().equals(castOther.getTpiIdTpIdentificacion()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getTpiIdTpIdentificacion() == null ? 0 : this.getTpiIdTpIdentificacion().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}

