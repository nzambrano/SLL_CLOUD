package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllTpLitigiosId generated by hbm2java
 */
@Embeddable
public class M4sllTpLitigiosId  implements java.io.Serializable {


    private String tplIdTpLitigio;
    private String idOrganization;

    public M4sllTpLitigiosId() {
    }

    public M4sllTpLitigiosId(String tplIdTpLitigio, String idOrganization) {
        this.tplIdTpLitigio = tplIdTpLitigio;
        this.idOrganization = idOrganization;
    }



    @Column(name="tpl_id_tp_litigio", nullable=false, length=3)
    public String getTplIdTpLitigio() {
        return this.tplIdTpLitigio;
    }

    public void setTplIdTpLitigio(String tplIdTpLitigio) {
        this.tplIdTpLitigio = tplIdTpLitigio;
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
        if ( !(other instanceof M4sllTpLitigiosId) ) return false;
        M4sllTpLitigiosId castOther = ( M4sllTpLitigiosId ) other;

        return ( (this.getTplIdTpLitigio()==castOther.getTplIdTpLitigio()) || ( this.getTplIdTpLitigio()!=null && castOther.getTplIdTpLitigio()!=null && this.getTplIdTpLitigio().equals(castOther.getTplIdTpLitigio()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getTplIdTpLitigio() == null ? 0 : this.getTplIdTpLitigio().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}

