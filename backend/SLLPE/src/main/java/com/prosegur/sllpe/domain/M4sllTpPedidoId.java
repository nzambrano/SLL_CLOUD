package com.prosegur.sllpe.domain;
// Generated 25 mar. 2021 15:58:57 by Hibernate Tools 5.2.0.Final


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllTpPedidoId generated by hbm2java
 */
@Embeddable
public class M4sllTpPedidoId  implements java.io.Serializable {


     private String tpeIdPedido;
     private String idOrganization;

    public M4sllTpPedidoId() {
    }

    public M4sllTpPedidoId(String tpeIdPedido, String idOrganization) {
       this.tpeIdPedido = tpeIdPedido;
       this.idOrganization = idOrganization;
    }
   


    @Column(name="tpe_id_pedido", unique=true, nullable=false, length=3)
    public String getTpeIdPedido() {
        return this.tpeIdPedido;
    }
    
    public void setTpeIdPedido(String tpeIdPedido) {
        this.tpeIdPedido = tpeIdPedido;
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
		 if ( !(other instanceof M4sllTpPedidoId) ) return false;
		 M4sllTpPedidoId castOther = ( M4sllTpPedidoId ) other; 
         
		 return ( (this.getTpeIdPedido()==castOther.getTpeIdPedido()) || ( this.getTpeIdPedido()!=null && castOther.getTpeIdPedido()!=null && this.getTpeIdPedido().equals(castOther.getTpeIdPedido()) ) )
 && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getTpeIdPedido() == null ? 0 : this.getTpeIdPedido().hashCode() );
         result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
         return result;
   }   


}

