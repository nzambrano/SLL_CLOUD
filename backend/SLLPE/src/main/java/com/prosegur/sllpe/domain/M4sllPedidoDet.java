package com.prosegur.sllpe.domain;
// Generated Mar 25, 2021, 1:18:52 PM by Hibernate Tools 5.2.0.Final


import java.util.Date;
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * M4sllPedidoDet generated by hbm2java
 */
@Entity
@Table(name="m4sll_pedido_det"
    ,schema="sll"
)
public class M4sllPedidoDet  implements java.io.Serializable {


     private M4sllPedidoDetId id;
     private String mpdIdPedidoDetalle;
     private String pdeObserrvacion;
     private String cloIdCliente;
     private String idApprole;
     private String idSecuser;
     private Date dtLastUpdate;

    public M4sllPedidoDet() {
    }

	
    public M4sllPedidoDet(M4sllPedidoDetId id) {
        this.id = id;
    }
    public M4sllPedidoDet(M4sllPedidoDetId id, String mpdIdPedidoDetalle, String pdeObserrvacion, String cloIdCliente, String idApprole, String idSecuser, Date dtLastUpdate) {
       this.id = id;
       this.mpdIdPedidoDetalle = mpdIdPedidoDetalle;
       this.pdeObserrvacion = pdeObserrvacion;
       this.cloIdCliente = cloIdCliente;
       this.idApprole = idApprole;
       this.idSecuser = idSecuser;
       this.dtLastUpdate = dtLastUpdate;
    }
   
     @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="litIdLitigio", column=@Column(name="lit_id_litigio", nullable=false, length=10) ), 
        @AttributeOverride(name="tpeIdPedido", column=@Column(name="tpe_id_pedido", nullable=false, length=3) ), 
        @AttributeOverride(name="pdeSecuencia", column=@Column(name="pde_secuencia", nullable=false) ), 
        @AttributeOverride(name="idOrganization", column=@Column(name="id_organization", nullable=false, length=4) ) } )
    public M4sllPedidoDetId getId() {
        return this.id;
    }
    
    public void setId(M4sllPedidoDetId id) {
        this.id = id;
    }

    
    @Column(name="mpd_id_pedido_detalle", length=3)
    public String getMpdIdPedidoDetalle() {
        return this.mpdIdPedidoDetalle;
    }
    
    public void setMpdIdPedidoDetalle(String mpdIdPedidoDetalle) {
        this.mpdIdPedidoDetalle = mpdIdPedidoDetalle;
    }

    
    @Column(name="pde_obserrvacion", length=2000)
    public String getPdeObserrvacion() {
        return this.pdeObserrvacion;
    }
    
    public void setPdeObserrvacion(String pdeObserrvacion) {
        this.pdeObserrvacion = pdeObserrvacion;
    }

    
    @Column(name="clo_id_cliente", length=3)
    public String getCloIdCliente() {
        return this.cloIdCliente;
    }
    
    public void setCloIdCliente(String cloIdCliente) {
        this.cloIdCliente = cloIdCliente;
    }

    
    @Column(name="id_approle", length=30)
    public String getIdApprole() {
        return this.idApprole;
    }
    
    public void setIdApprole(String idApprole) {
        this.idApprole = idApprole;
    }

    
    @Column(name="id_secuser", length=30)
    public String getIdSecuser() {
        return this.idSecuser;
    }
    
    public void setIdSecuser(String idSecuser) {
        this.idSecuser = idSecuser;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="dt_last_update", length=22)
    public Date getDtLastUpdate() {
        return this.dtLastUpdate;
    }
    
    public void setDtLastUpdate(Date dtLastUpdate) {
        this.dtLastUpdate = dtLastUpdate;
    }




}


