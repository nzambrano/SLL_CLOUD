package com.prosegur.sllpe.domain;
// Generated Mar 25, 2021, 1:18:52 PM by Hibernate Tools 5.2.0.Final


import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * M4sllPedidoDetId generated by hbm2java
 */
@Embeddable
public class M4sllPedidoDetId  implements java.io.Serializable {


     private String litIdLitigio;
     private String tpeIdPedido;
     private long pdeSecuencia;
     private String idOrganization;

    public M4sllPedidoDetId() {
    }

    public M4sllPedidoDetId(String litIdLitigio, String tpeIdPedido, long pdeSecuencia, String idOrganization) {
       this.litIdLitigio = litIdLitigio;
       this.tpeIdPedido = tpeIdPedido;
       this.pdeSecuencia = pdeSecuencia;
       this.idOrganization = idOrganization;
    }
   


    @Column(name="lit_id_litigio", nullable=false, length=10)
    public String getLitIdLitigio() {
        return this.litIdLitigio;
    }
    
    public void setLitIdLitigio(String litIdLitigio) {
        this.litIdLitigio = litIdLitigio;
    }


    @Column(name="tpe_id_pedido", nullable=false, length=3)
    public String getTpeIdPedido() {
        return this.tpeIdPedido;
    }
    
    public void setTpeIdPedido(String tpeIdPedido) {
        this.tpeIdPedido = tpeIdPedido;
    }


    @Column(name="pde_secuencia", nullable=false)
    public long getPdeSecuencia() {
        return this.pdeSecuencia;
    }
    
    public void setPdeSecuencia(long pdeSecuencia) {
        this.pdeSecuencia = pdeSecuencia;
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
		 if ( !(other instanceof M4sllPedidoDetId) ) return false;
		 M4sllPedidoDetId castOther = ( M4sllPedidoDetId ) other; 
         
		 return ( (this.getLitIdLitigio()==castOther.getLitIdLitigio()) || ( this.getLitIdLitigio()!=null && castOther.getLitIdLitigio()!=null && this.getLitIdLitigio().equals(castOther.getLitIdLitigio()) ) )
 && ( (this.getTpeIdPedido()==castOther.getTpeIdPedido()) || ( this.getTpeIdPedido()!=null && castOther.getTpeIdPedido()!=null && this.getTpeIdPedido().equals(castOther.getTpeIdPedido()) ) )
 && (this.getPdeSecuencia()==castOther.getPdeSecuencia())
 && ( (this.getIdOrganization()==castOther.getIdOrganization()) || ( this.getIdOrganization()!=null && castOther.getIdOrganization()!=null && this.getIdOrganization().equals(castOther.getIdOrganization()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getLitIdLitigio() == null ? 0 : this.getLitIdLitigio().hashCode() );
         result = 37 * result + ( getTpeIdPedido() == null ? 0 : this.getTpeIdPedido().hashCode() );
         result = 37 * result + (int) this.getPdeSecuencia();
         result = 37 * result + ( getIdOrganization() == null ? 0 : this.getIdOrganization().hashCode() );
         return result;
   }   


}


