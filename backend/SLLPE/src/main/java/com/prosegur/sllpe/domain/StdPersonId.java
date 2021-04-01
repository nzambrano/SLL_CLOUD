package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * StdPersonId generated by hbm2java
 */
@Embeddable
public class StdPersonId  implements java.io.Serializable {


    private String stdIdPerson;
    private String idOrganization;

    public StdPersonId() {
    }

    public StdPersonId(String stdIdPerson, String idOrganization) {
        this.stdIdPerson = stdIdPerson;
        this.idOrganization = idOrganization;
    }



    @Column(name="std_id_person", nullable=false, length=10)
    public String getStdIdPerson() {
        return this.stdIdPerson;
    }

    public void setStdIdPerson(String stdIdPerson) {
        this.stdIdPerson = stdIdPerson;
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
        if ( !(other instanceof StdPersonId) ) return false;
        StdPersonId castOther = ( StdPersonId ) other;

        return ( (this.getStdIdPerson()==castOther.getStdIdPerson()) || ( this.getStdIdPerson()!=null && castOther.getStdIdPerson()!=null && this.getStdIdPerson().equals(castOther.getStdIdPerson()) ) )
               && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getStdIdPerson() == null ? 0 : this.getStdIdPerson().hashCode() );
        result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
        return result;
    }


}


