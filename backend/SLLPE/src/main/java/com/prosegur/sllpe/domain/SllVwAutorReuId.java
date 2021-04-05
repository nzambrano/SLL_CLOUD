package com.prosegur.sllpe.domain;


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * SllVwAutorReuId generated by hbm2java
 */
@Embeddable
public class SllVwAutorReuId  implements java.io.Serializable {


    /**
    *
    */
    private static final long serialVersionUID = 1L;
    private String mteIdTpEmpleado;
    private String aurAutorReu;
    private String aurCkPrincipal;
    private Long aurSecuencia;
    private String entNmEntidad;
    private String entNroIdentificacion;
    private String litIdLitigio;
    private String tarIdTpAutorReu;
    private String tpeIdTpEntidad;
    private String tpiIdTpIdentificacion;
    private String eciIdCiudadAutor;
    private String mabApellido;
    private String mabNombre;
    private Long mabSecuencia;
    private String pexApellido;
    private String pexNombre;
    private String pexNroDocumento;
    private String stdIdPerson;
    private String stdFamName;
    private String stdNFirstName;
    private String stdSsn;
    private String stdIdLegEnt;
    private String stdNLegEnt;
    private String nombre;
    private Long stdOrHrPeriod;

    public SllVwAutorReuId() {
    }

    public SllVwAutorReuId(String mteIdTpEmpleado, String aurAutorReu, String aurCkPrincipal, Long aurSecuencia, String entNmEntidad, String entNroIdentificacion, String litIdLitigio, String tarIdTpAutorReu, String tpeIdTpEntidad, String tpiIdTpIdentificacion, String eciIdCiudadAutor, String mabApellido, String mabNombre, Long mabSecuencia, String pexApellido, String pexNombre, String pexNroDocumento, String stdIdPerson, String stNFamName, String stdNFirstName, String stdSsn, String stdIdLegEnt, String stdNLegEnt, String nombre, Long stdOrHrPeriod) {
        this.mteIdTpEmpleado = mteIdTpEmpleado;
        this.aurAutorReu = aurAutorReu;
        this.aurCkPrincipal = aurCkPrincipal;
        this.aurSecuencia = aurSecuencia;
        this.entNmEntidad = entNmEntidad;
        this.entNroIdentificacion = entNroIdentificacion;
        this.litIdLitigio = litIdLitigio;
        this.tarIdTpAutorReu = tarIdTpAutorReu;
        this.tpeIdTpEntidad = tpeIdTpEntidad;
        this.tpiIdTpIdentificacion = tpiIdTpIdentificacion;
        this.eciIdCiudadAutor = eciIdCiudadAutor;
        this.mabApellido = mabApellido;
        this.mabNombre = mabNombre;
        this.mabSecuencia = mabSecuencia;
        this.pexApellido = pexApellido;
        this.pexNombre = pexNombre;
        this.pexNroDocumento = pexNroDocumento;
        this.stdIdPerson = stdIdPerson;
        this.stdFamName = stdFamName;
        this.stdNFirstName = stdNFirstName;
        this.stdSsn = stdSsn;
        this.stdIdLegEnt = stdIdLegEnt;
        this.stdNLegEnt = stdNLegEnt;
        this.nombre = nombre;
        this.stdOrHrPeriod = stdOrHrPeriod;
    }



    @Column(name="mte_id_tp_empleado", length=3)
    public String getMteIdTpEmpleado() {
        return this.mteIdTpEmpleado;
    }

    public void setMteIdTpEmpleado(String mteIdTpEmpleado) {
        this.mteIdTpEmpleado = mteIdTpEmpleado;
    }


    @Column(name="aur_autor_reu", length=1)
    public String getAurAutorReu() {
        return this.aurAutorReu;
    }

    public void setAurAutorReu(String aurAutorReu) {
        this.aurAutorReu = aurAutorReu;
    }


    @Column(name="aur_ck_principal", length=1)
    public String getAurCkPrincipal() {
        return this.aurCkPrincipal;
    }

    public void setAurCkPrincipal(String aurCkPrincipal) {
        this.aurCkPrincipal = aurCkPrincipal;
    }


    @Column(name="aur_secuencia")
    public Long getAurSecuencia() {
        return this.aurSecuencia;
    }

    public void setAurSecuencia(Long aurSecuencia) {
        this.aurSecuencia = aurSecuencia;
    }


    @Column(name="ent_nm_entidad", length=254)
    public String getEntNmEntidad() {
        return this.entNmEntidad;
    }

    public void setEntNmEntidad(String entNmEntidad) {
        this.entNmEntidad = entNmEntidad;
    }


    @Column(name="ent_nro_identificacion", length=254)
    public String getEntNroIdentificacion() {
        return this.entNroIdentificacion;
    }

    public void setEntNroIdentificacion(String entNroIdentificacion) {
        this.entNroIdentificacion = entNroIdentificacion;
    }


    @Column(name="lit_id_litigio", length=10)
    public String getLitIdLitigio() {
        return this.litIdLitigio;
    }

    public void setLitIdLitigio(String litIdLitigio) {
        this.litIdLitigio = litIdLitigio;
    }


    @Column(name="tar_id_tp_autor_reu", length=3)
    public String getTarIdTpAutorReu() {
        return this.tarIdTpAutorReu;
    }

    public void setTarIdTpAutorReu(String tarIdTpAutorReu) {
        this.tarIdTpAutorReu = tarIdTpAutorReu;
    }


    @Column(name="tpe_id_tp_entidad", length=3)
    public String getTpeIdTpEntidad() {
        return this.tpeIdTpEntidad;
    }

    public void setTpeIdTpEntidad(String tpeIdTpEntidad) {
        this.tpeIdTpEntidad = tpeIdTpEntidad;
    }


    @Column(name="tpi_id_tp_identificacion", length=3)
    public String getTpiIdTpIdentificacion() {
        return this.tpiIdTpIdentificacion;
    }

    public void setTpiIdTpIdentificacion(String tpiIdTpIdentificacion) {
        this.tpiIdTpIdentificacion = tpiIdTpIdentificacion;
    }


    @Column(name="eci_id_ciudad_autor", length=3)
    public String getEciIdCiudadAutor() {
        return this.eciIdCiudadAutor;
    }

    public void setEciIdCiudadAutor(String eciIdCiudadAutor) {
        this.eciIdCiudadAutor = eciIdCiudadAutor;
    }


    @Column(name="mab_apellido")
    public String getMabApellido() {
        return this.mabApellido;
    }

    public void setMabApellido(String mabApellido) {
        this.mabApellido = mabApellido;
    }


    @Column(name="mab_nombre")
    public String getMabNombre() {
        return this.mabNombre;
    }

    public void setMabNombre(String mabNombre) {
        this.mabNombre = mabNombre;
    }


    @Column(name="mab_secuencia")
    public Long getMabSecuencia() {
        return this.mabSecuencia;
    }

    public void setMabSecuencia(Long mabSecuencia) {
        this.mabSecuencia = mabSecuencia;
    }


    @Column(name="pex_apellido", length=254)
    public String getPexApellido() {
        return this.pexApellido;
    }

    public void setPexApellido(String pexApellido) {
        this.pexApellido = pexApellido;
    }


    @Column(name="pex_nombre", length=254)
    public String getPexNombre() {
        return this.pexNombre;
    }

    public void setPexNombre(String pexNombre) {
        this.pexNombre = pexNombre;
    }


    @Column(name="pex_nro_documento", length=20)
    public String getPexNroDocumento() {
        return this.pexNroDocumento;
    }

    public void setPexNroDocumento(String pexNroDocumento) {
        this.pexNroDocumento = pexNroDocumento;
    }


    @Column(name="std_id_person", length=10)
    public String getStdIdPerson() {
        return this.stdIdPerson;
    }

    public void setStdIdPerson(String stdIdPerson) {
        this.stdIdPerson = stdIdPerson;
    }


    @Column(name="std_fam_name", length=50)
    public String getStdFamName() {
        return this.stdFamName;
    }

    public void setStdFamName(String stdFamName) {
        this.stdFamName = stdFamName;
    }


    @Column(name="std_n_first_name", length=50)
    public String getStdNFirstName() {
        return this.stdNFirstName;
    }

    public void setStdNFirstName(String stdNFirstName) {
        this.stdNFirstName = stdNFirstName;
    }


    @Column(name="std_ssn", length=20)
    public String getStdSsn() {
        return this.stdSsn;
    }

    public void setStdSsn(String stdSsn) {
        this.stdSsn = stdSsn;
    }


    @Column(name="std_id_leg_ent", length=9)
    public String getStdIdLegEnt() {
        return this.stdIdLegEnt;
    }

    public void setStdIdLegEnt(String stdIdLegEnt) {
        this.stdIdLegEnt = stdIdLegEnt;
    }


    @Column(name="std_n_leg_ent", length=62)
    public String getStdNLegEnt() {
        return this.stdNLegEnt;
    }

    public void setStdNLegEnt(String stdNLegEnt) {
        this.stdNLegEnt = stdNLegEnt;
    }


    @Column(name="nombre", length=254)
    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }


    @Column(name="std_or_hr_period")
    public Long getStdOrHrPeriod() {
        return this.stdOrHrPeriod;
    }

    public void setStdOrHrPeriod(Long stdOrHrPeriod) {
        this.stdOrHrPeriod = stdOrHrPeriod;
    }


    public boolean equals(Object other) {
        if ( (this == other ) ) return true;
        if ( (other == null ) ) return false;
        if ( !(other instanceof SllVwAutorReuId) ) return false;
        SllVwAutorReuId castOther = ( SllVwAutorReuId ) other;

        return ( (this.getMteIdTpEmpleado()==castOther.getMteIdTpEmpleado()) || ( this.getMteIdTpEmpleado()!=null && castOther.getMteIdTpEmpleado()!=null && this.getMteIdTpEmpleado().equals(castOther.getMteIdTpEmpleado()) ) )
               && ( (this.getAurAutorReu()==castOther.getAurAutorReu()) || ( this.getAurAutorReu()!=null && castOther.getAurAutorReu()!=null && this.getAurAutorReu().equals(castOther.getAurAutorReu()) ) )
               && ( (this.getAurCkPrincipal()==castOther.getAurCkPrincipal()) || ( this.getAurCkPrincipal()!=null && castOther.getAurCkPrincipal()!=null && this.getAurCkPrincipal().equals(castOther.getAurCkPrincipal()) ) )
               && ( (this.getAurSecuencia()==castOther.getAurSecuencia()) || ( this.getAurSecuencia()!=null && castOther.getAurSecuencia()!=null && this.getAurSecuencia().equals(castOther.getAurSecuencia()) ) )
               && ( (this.getEntNmEntidad()==castOther.getEntNmEntidad()) || ( this.getEntNmEntidad()!=null && castOther.getEntNmEntidad()!=null && this.getEntNmEntidad().equals(castOther.getEntNmEntidad()) ) )
               && ( (this.getEntNroIdentificacion()==castOther.getEntNroIdentificacion()) || ( this.getEntNroIdentificacion()!=null && castOther.getEntNroIdentificacion()!=null && this.getEntNroIdentificacion().equals(castOther.getEntNroIdentificacion()) ) )
               && ( (this.getLitIdLitigio()==castOther.getLitIdLitigio()) || ( this.getLitIdLitigio()!=null && castOther.getLitIdLitigio()!=null && this.getLitIdLitigio().equals(castOther.getLitIdLitigio()) ) )
               && ( (this.getTarIdTpAutorReu()==castOther.getTarIdTpAutorReu()) || ( this.getTarIdTpAutorReu()!=null && castOther.getTarIdTpAutorReu()!=null && this.getTarIdTpAutorReu().equals(castOther.getTarIdTpAutorReu()) ) )
               && ( (this.getTpeIdTpEntidad()==castOther.getTpeIdTpEntidad()) || ( this.getTpeIdTpEntidad()!=null && castOther.getTpeIdTpEntidad()!=null && this.getTpeIdTpEntidad().equals(castOther.getTpeIdTpEntidad()) ) )
               && ( (this.getTpiIdTpIdentificacion()==castOther.getTpiIdTpIdentificacion()) || ( this.getTpiIdTpIdentificacion()!=null && castOther.getTpiIdTpIdentificacion()!=null && this.getTpiIdTpIdentificacion().equals(castOther.getTpiIdTpIdentificacion()) ) )
               && ( (this.getEciIdCiudadAutor()==castOther.getEciIdCiudadAutor()) || ( this.getEciIdCiudadAutor()!=null && castOther.getEciIdCiudadAutor()!=null && this.getEciIdCiudadAutor().equals(castOther.getEciIdCiudadAutor()) ) )
               && ( (this.getMabApellido()==castOther.getMabApellido()) || ( this.getMabApellido()!=null && castOther.getMabApellido()!=null && this.getMabApellido().equals(castOther.getMabApellido()) ) )
               && ( (this.getMabNombre()==castOther.getMabNombre()) || ( this.getMabNombre()!=null && castOther.getMabNombre()!=null && this.getMabNombre().equals(castOther.getMabNombre()) ) )
               && ( (this.getMabSecuencia()==castOther.getMabSecuencia()) || ( this.getMabSecuencia()!=null && castOther.getMabSecuencia()!=null && this.getMabSecuencia().equals(castOther.getMabSecuencia()) ) )
               && ( (this.getPexApellido()==castOther.getPexApellido()) || ( this.getPexApellido()!=null && castOther.getPexApellido()!=null && this.getPexApellido().equals(castOther.getPexApellido()) ) )
               && ( (this.getPexNombre()==castOther.getPexNombre()) || ( this.getPexNombre()!=null && castOther.getPexNombre()!=null && this.getPexNombre().equals(castOther.getPexNombre()) ) )
               && ( (this.getPexNroDocumento()==castOther.getPexNroDocumento()) || ( this.getPexNroDocumento()!=null && castOther.getPexNroDocumento()!=null && this.getPexNroDocumento().equals(castOther.getPexNroDocumento()) ) )
               && ( (this.getStdIdPerson()==castOther.getStdIdPerson()) || ( this.getStdIdPerson()!=null && castOther.getStdIdPerson()!=null && this.getStdIdPerson().equals(castOther.getStdIdPerson()) ) )
               && ( (this.getStdFamName()==castOther.getStdFamName()) || ( this.getStdFamName()!=null && castOther.getStdFamName()!=null && this.getStdFamName().equals(castOther.getStdFamName()) ) )
               && ( (this.getStdNFirstName()==castOther.getStdNFirstName()) || ( this.getStdNFirstName()!=null && castOther.getStdNFirstName()!=null && this.getStdNFirstName().equals(castOther.getStdNFirstName()) ) )
               && ( (this.getStdSsn()==castOther.getStdSsn()) || ( this.getStdSsn()!=null && castOther.getStdSsn()!=null && this.getStdSsn().equals(castOther.getStdSsn()) ) )
               && ( (this.getStdIdLegEnt()==castOther.getStdIdLegEnt()) || ( this.getStdIdLegEnt()!=null && castOther.getStdIdLegEnt()!=null && this.getStdIdLegEnt().equals(castOther.getStdIdLegEnt()) ) )
               && ( (this.getStdNLegEnt()==castOther.getStdNLegEnt()) || ( this.getStdNLegEnt()!=null && castOther.getStdNLegEnt()!=null && this.getStdNLegEnt().equals(castOther.getStdNLegEnt()) ) )
               && ( (this.getNombre()==castOther.getNombre()) || ( this.getNombre()!=null && castOther.getNombre()!=null && this.getNombre().equals(castOther.getNombre()) ) )
               && ( (this.getStdOrHrPeriod()==castOther.getStdOrHrPeriod()) || ( this.getStdOrHrPeriod()!=null && castOther.getStdOrHrPeriod()!=null && this.getStdOrHrPeriod().equals(castOther.getStdOrHrPeriod()) ) );
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result + ( getMteIdTpEmpleado() == null ? 0 : this.getMteIdTpEmpleado().hashCode() );
        result = 37 * result + ( getAurAutorReu() == null ? 0 : this.getAurAutorReu().hashCode() );
        result = 37 * result + ( getAurCkPrincipal() == null ? 0 : this.getAurCkPrincipal().hashCode() );
        result = 37 * result + ( getAurSecuencia() == null ? 0 : this.getAurSecuencia().hashCode() );
        result = 37 * result + ( getEntNmEntidad() == null ? 0 : this.getEntNmEntidad().hashCode() );
        result = 37 * result + ( getEntNroIdentificacion() == null ? 0 : this.getEntNroIdentificacion().hashCode() );
        result = 37 * result + ( getLitIdLitigio() == null ? 0 : this.getLitIdLitigio().hashCode() );
        result = 37 * result + ( getTarIdTpAutorReu() == null ? 0 : this.getTarIdTpAutorReu().hashCode() );
        result = 37 * result + ( getTpeIdTpEntidad() == null ? 0 : this.getTpeIdTpEntidad().hashCode() );
        result = 37 * result + ( getTpiIdTpIdentificacion() == null ? 0 : this.getTpiIdTpIdentificacion().hashCode() );
        result = 37 * result + ( getEciIdCiudadAutor() == null ? 0 : this.getEciIdCiudadAutor().hashCode() );
        result = 37 * result + ( getMabApellido() == null ? 0 : this.getMabApellido().hashCode() );
        result = 37 * result + ( getMabNombre() == null ? 0 : this.getMabNombre().hashCode() );
        result = 37 * result + ( getMabSecuencia() == null ? 0 : this.getMabSecuencia().hashCode() );
        result = 37 * result + ( getPexApellido() == null ? 0 : this.getPexApellido().hashCode() );
        result = 37 * result + ( getPexNombre() == null ? 0 : this.getPexNombre().hashCode() );
        result = 37 * result + ( getPexNroDocumento() == null ? 0 : this.getPexNroDocumento().hashCode() );
        result = 37 * result + ( getStdIdPerson() == null ? 0 : this.getStdIdPerson().hashCode() );
        result = 37 * result + ( getStdFamName() == null ? 0 : this.getStdFamName().hashCode() );
        result = 37 * result + ( getStdNFirstName() == null ? 0 : this.getStdNFirstName().hashCode() );
        result = 37 * result + ( getStdSsn() == null ? 0 : this.getStdSsn().hashCode() );
        result = 37 * result + ( getStdIdLegEnt() == null ? 0 : this.getStdIdLegEnt().hashCode() );
        result = 37 * result + ( getStdNLegEnt() == null ? 0 : this.getStdNLegEnt().hashCode() );
        result = 37 * result + ( getNombre() == null ? 0 : this.getNombre().hashCode() );
        result = 37 * result + ( getStdOrHrPeriod() == null ? 0 : this.getStdOrHrPeriod().hashCode() );
        return result;
    }


}


