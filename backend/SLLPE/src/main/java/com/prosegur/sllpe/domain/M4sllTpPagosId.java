package com.prosegur.sllpe.domain;
// Generated Apr 1, 2021, 12:10:01 AM by Hibernate Tools 5.2.0.Final


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllTpPagosId generated by hbm2java
 */
@Embeddable
public class M4sllTpPagosId  implements java.io.Serializable {


    private String tpaIdPago;
    private String idOrganization;

    public M4sllTpPagosId() {
    }

    public M4sllTpPagosId(String tpaIdPago, String idOrganization) {
        this.tpaIdPago = tpaIdPago;
        this.idOrganization = idOrganization;
    }



    @Column(name="tpa_id_pago", nullable=false, length=3)
    public String getTpaIdPago() {
        return this.tpaIdPago;
    }

    public void setTpaIdPago(String tpaIdPago) {
        this.tpaIdPago = tpaIdPago;
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
        if ( !(other instanceof M4sllTpPagosId) ) return false;
        M4sllTpPagosId castOther = ( M4sllTpPagosId ) other;

        return ( (this.getTpaIdPago()==castOther.getTpaIdPago()) || ( this.getTpaIdPago()!=null && castOther.getTpaIdPago()!=null && this.getTpaIdPago().equals(castOther.getTpaIdPago()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getTpaIdPago() == null ? 0 : this.getTpaIdPago().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


