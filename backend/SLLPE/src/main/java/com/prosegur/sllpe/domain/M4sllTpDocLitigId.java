package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllTpDocLitigId generated by hbm2java
 */
@Embeddable
public class M4sllTpDocLitigId  implements java.io.Serializable {


    private String tdlIdTpDocLitigio;
    private String idOrganization;

    public M4sllTpDocLitigId() {
    }

    public M4sllTpDocLitigId(String tdlIdTpDocLitigio, String idOrganization) {
        this.tdlIdTpDocLitigio = tdlIdTpDocLitigio;
        this.idOrganization = idOrganization;
    }



    @Column(name="tdl_id_tp_doc_litigio", nullable=false, length=3)
    public String getTdlIdTpDocLitigio() {
        return this.tdlIdTpDocLitigio;
    }

    public void setTdlIdTpDocLitigio(String tdlIdTpDocLitigio) {
        this.tdlIdTpDocLitigio = tdlIdTpDocLitigio;
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
        if ( !(other instanceof M4sllTpDocLitigId) ) return false;
        M4sllTpDocLitigId castOther = ( M4sllTpDocLitigId ) other;

        return ( (this.getTdlIdTpDocLitigio()==castOther.getTdlIdTpDocLitigio()) || ( this.getTdlIdTpDocLitigio()!=null && castOther.getTdlIdTpDocLitigio()!=null && this.getTdlIdTpDocLitigio().equals(castOther.getTdlIdTpDocLitigio()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getTdlIdTpDocLitigio() == null ? 0 : this.getTdlIdTpDocLitigio().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


