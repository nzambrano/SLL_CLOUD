package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllFasesId generated by hbm2java
 */
@Embeddable
public class M4sllFasesId  implements java.io.Serializable {


    private String litIdLitigio;
    private String tfaIdTpFase;
    private String idOrganization;

    public M4sllFasesId() {
    }

    public M4sllFasesId(String litIdLitigio, String tfaIdTpFase, String idOrganization) {
        this.litIdLitigio = litIdLitigio;
        this.tfaIdTpFase = tfaIdTpFase;
        this.idOrganization = idOrganization;
    }



    @Column(name="lit_id_litigio", nullable=false, length=10)
    public String getLitIdLitigio() {
        return this.litIdLitigio;
    }

    public void setLitIdLitigio(String litIdLitigio) {
        this.litIdLitigio = litIdLitigio;
    }


    @Column(name="tfa_id_tp_fase", nullable=false, length=3)
    public String getTfaIdTpFase() {
        return this.tfaIdTpFase;
    }

    public void setTfaIdTpFase(String tfaIdTpFase) {
        this.tfaIdTpFase = tfaIdTpFase;
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
        if ( !(other instanceof M4sllFasesId) ) return false;
        M4sllFasesId castOther = ( M4sllFasesId ) other;

        return ( (this.getLitIdLitigio()==castOther.getLitIdLitigio()) || ( this.getLitIdLitigio()!=null && castOther.getLitIdLitigio()!=null && this.getLitIdLitigio().equals(castOther.getLitIdLitigio()) ) )
               && ( (this.getTfaIdTpFase()==castOther.getTfaIdTpFase()) || ( this.getTfaIdTpFase()!=null && castOther.getTfaIdTpFase()!=null && this.getTfaIdTpFase().equals(castOther.getTfaIdTpFase()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getLitIdLitigio() == null ? 0 : this.getLitIdLitigio().hashCode() );
        result = 37 * result + ( getTfaIdTpFase() == null ? 0 : this.getTfaIdTpFase().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


