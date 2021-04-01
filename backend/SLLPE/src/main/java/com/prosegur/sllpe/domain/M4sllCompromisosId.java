package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllCompromisosId generated by hbm2java
 */
@Embeddable
public class M4sllCompromisosId  implements java.io.Serializable {


    private String tcoIdTpCompromiso;
    private String litIdLitigio;
    private long comSecuencia;
    private String idOrganization;

    public M4sllCompromisosId() {
    }

    public M4sllCompromisosId(String tcoIdTpCompromiso, String litIdLitigio, long comSecuencia, String idOrganization) {
        this.tcoIdTpCompromiso = tcoIdTpCompromiso;
        this.litIdLitigio = litIdLitigio;
        this.comSecuencia = comSecuencia;
        this.idOrganization = idOrganization;
    }



    @Column(name="tco_id_tp_compromiso", nullable=false, length=3)
    public String getTcoIdTpCompromiso() {
        return this.tcoIdTpCompromiso;
    }

    public void setTcoIdTpCompromiso(String tcoIdTpCompromiso) {
        this.tcoIdTpCompromiso = tcoIdTpCompromiso;
    }


    @Column(name="lit_id_litigio", nullable=false, length=10)
    public String getLitIdLitigio() {
        return this.litIdLitigio;
    }

    public void setLitIdLitigio(String litIdLitigio) {
        this.litIdLitigio = litIdLitigio;
    }


    @Column(name="com_secuencia", nullable=false)
    public long getComSecuencia() {
        return this.comSecuencia;
    }

    public void setComSecuencia(long comSecuencia) {
        this.comSecuencia = comSecuencia;
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
        if ( !(other instanceof M4sllCompromisosId) ) return false;
        M4sllCompromisosId castOther = ( M4sllCompromisosId ) other;

        return ( (this.getTcoIdTpCompromiso()==castOther.getTcoIdTpCompromiso()) || ( this.getTcoIdTpCompromiso()!=null && castOther.getTcoIdTpCompromiso()!=null && this.getTcoIdTpCompromiso().equals(castOther.getTcoIdTpCompromiso()) ) )
               && ( (this.getLitIdLitigio()==castOther.getLitIdLitigio()) || ( this.getLitIdLitigio()!=null && castOther.getLitIdLitigio()!=null && this.getLitIdLitigio().equals(castOther.getLitIdLitigio()) ) )
               && (this.getComSecuencia()==castOther.getComSecuencia())
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getTcoIdTpCompromiso() == null ? 0 : this.getTcoIdTpCompromiso().hashCode() );
        result = 37 * result + ( getLitIdLitigio() == null ? 0 : this.getLitIdLitigio().hashCode() );
        result = 37 * result + (int) this.getComSecuencia();
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


