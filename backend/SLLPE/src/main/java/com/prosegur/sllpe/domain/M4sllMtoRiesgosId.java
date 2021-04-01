package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllMtoRiesgosId generated by hbm2java
 */
@Embeddable
public class M4sllMtoRiesgosId  implements java.io.Serializable {


    private String mriIdRiesgo;
    private String idOrganization;

    public M4sllMtoRiesgosId() {
    }

    public M4sllMtoRiesgosId(String mriIdRiesgo, String idOrganization) {
        this.mriIdRiesgo = mriIdRiesgo;
        this.idOrganization = idOrganization;
    }



    @Column(name="mri_id_riesgo", nullable=false, length=3)
    public String getMriIdRiesgo() {
        return this.mriIdRiesgo;
    }

    public void setMriIdRiesgo(String mriIdRiesgo) {
        this.mriIdRiesgo = mriIdRiesgo;
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
        if ( !(other instanceof M4sllMtoRiesgosId) ) return false;
        M4sllMtoRiesgosId castOther = ( M4sllMtoRiesgosId ) other;

        return ( (this.getMriIdRiesgo()==castOther.getMriIdRiesgo()) || ( this.getMriIdRiesgo()!=null && castOther.getMriIdRiesgo()!=null && this.getMriIdRiesgo().equals(castOther.getMriIdRiesgo()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getMriIdRiesgo() == null ? 0 : this.getMriIdRiesgo().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


