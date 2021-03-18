package com.prosegur.sllpe.domain;

import java.io.Serializable;
import javax.persistence.*;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "m4sll_vw_ban_pe", schema = "sll")
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY)
public class M4sllVwBanPeConsulta implements Serializable {

  private static final long serialVersionUID = 1L;


  @Column(name = "id_organization")
  private String id_organization;

  @Id
  @Column(name = "lit_id_litigio")
  private String lit_id_litigio;

  @Column(name = "lit_nro_proceso")
  private String lit_nro_proceso;

  @Column(name = "lit_valor_total")
  private String lit_valor_total;

  @Column(name = "lit_bpo")
  private String lit_bpo;

  @Column(name = "reu")
  private String reu;

  @Column(name = "autor")
  private String autor;

  @Column(name = "tri_nm_tribunal")
  private String tri_nm_tribunal;

  @Column(name = "tst_nm_tp_status")
  private String tst_nm_tp_status;

  @Column(name = "tpl_nm_tp_litigio")
  private String tpl_nm_tp_litigio;

  @Column(name = "tsd_nm_tp_status_det")
  private String tsd_nm_tp_status_det;

  ////////////////////////////////////////////////

  // jhipster-needle-entity-add-field - JHipster will add fields here
  public String getId() {
    return lit_id_litigio;
  }

  public void setId(String lit_id_litigio) {
    this.lit_id_litigio = lit_id_litigio;
  }

  ////////////////////////////////////////////////

  public String getIdOrganization() {
    return id_organization;
  }

  public M4sllVwBanPeConsulta id_organization(String id_organization) {
    this.id_organization = id_organization;
    return this;
  }

  public void setIdOrganization(String id_organization) {
    this.id_organization = id_organization;
  }

  ////////////////////////////////////////////////

  public String getLitIdLitigio() {
    return lit_id_litigio;
  }

  public M4sllVwBanPeConsulta lit_id_litigio(String lit_id_litigio) {
    this.lit_id_litigio = lit_id_litigio;
    return this;
  }

  public void setLitIdLitigio(String lit_id_litigio) {
    this.lit_id_litigio = lit_id_litigio;
  }

  ////////////////////////////////////////////////

  public String getLitNroProceso() {
    return lit_nro_proceso;
  }

  public M4sllVwBanPeConsulta lit_nro_proceso(String lit_nro_proceso) {
    this.lit_nro_proceso = lit_nro_proceso;
    return this;
  }

  public void setLitNroProceso(String lit_nro_proceso) {
    this.lit_nro_proceso = lit_nro_proceso;
  }

  ////////////////////////////////////////////////

  public String getLitValorTotal() {
    return lit_valor_total;
  }

  public M4sllVwBanPeConsulta lit_valor_total(String lit_valor_total) {
    this.lit_valor_total = lit_valor_total;
    return this;
  }

  public void setLitValorTotal(String lit_valor_total) {
    this.lit_valor_total = lit_valor_total;
  }

  ////////////////////////////////////////////////

  public String getLitBpo() {
    return lit_bpo;
  }

  public M4sllVwBanPeConsulta lit_bpo(String lit_bpo) {
    this.lit_bpo = lit_bpo;
    return this;
  }

  public void setLitBpo(String lit_bpo) {
    this.lit_bpo = lit_bpo;
  }

  ////////////////////////////////////////////////

  public String getReu() {
    return reu;
  }

  public M4sllVwBanPeConsulta reu(String reu) {
    this.reu = reu;
    return this;
  }

  public void setReu(String reu) {
    this.reu = reu;
  }

  ////////////////////////////////////////////////

  public String getAutor() {
    return autor;
  }

  public M4sllVwBanPeConsulta autor(String autor) {
    this.autor = autor;
    return this;
  }

  public void setAutor(String autor) {
    this.autor = autor;
  }

  ////////////////////////////////////////////////

  public String getTriNmTribunal() {
    return tri_nm_tribunal;
  }

  public M4sllVwBanPeConsulta tri_nm_tribunal(String tri_nm_tribunal) {
    this.tri_nm_tribunal = tri_nm_tribunal;
    return this;
  }

  public void setTriNmTribunal(String tri_nm_tribunal) {
    this.tri_nm_tribunal = tri_nm_tribunal;
  }

  ////////////////////////////////////////////////

  public String getTstNmTpStatus() {
    return tst_nm_tp_status;
  }

  public M4sllVwBanPeConsulta tst_nm_tp_status(String tst_nm_tp_status) {
    this.tst_nm_tp_status = tst_nm_tp_status;
    return this;
  }

  public void setTstNmTpStatus(String tst_nm_tp_status) {
    this.tst_nm_tp_status = tst_nm_tp_status;
  }

  ////////////////////////////////////////////////

  public String getTplNmTpLitigio() {
    return tpl_nm_tp_litigio;
  }

  public M4sllVwBanPeConsulta tpl_nm_tp_litigio(String tpl_nm_tp_litigio) {
    this.tpl_nm_tp_litigio = tpl_nm_tp_litigio;
    return this;
  }

  public void setTplNmTpLitigio(String tpl_nm_tp_litigio) {
    this.tpl_nm_tp_litigio = tpl_nm_tp_litigio;
  }

  ////////////////////////////////////////////////

  public String getTsdNmTpStatusDet() {
    return tsd_nm_tp_status_det;
  }

  public M4sllVwBanPeConsulta tsd_nm_tp_status_det(String tsd_nm_tp_status_det) {
    this.tsd_nm_tp_status_det = tsd_nm_tp_status_det;
    return this;
  }

  public void setTsdNmTpStatusDet(String tsd_nm_tp_status_det) {
    this.tsd_nm_tp_status_det = tsd_nm_tp_status_det;
  }

  ////////////////////////////////////////////////

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof M4sllVwBanPeConsulta)) {
      return false;
    }
    return id_organization != null && id_organization.equals(((M4sllVwBanPeConsulta) o).id_organization);
  }

  @Override
  public int hashCode() {
    return 31;
  }

  @Override
  public String toString() {
      return "M4sllVwBanPeConsulta {id_organization="+ id_organization
                                  + ", lit_id_litigio=" + lit_id_litigio 
                                  + ", lit_nro_proceso=" + lit_nro_proceso 
                                  + ", lit_valor_total=" + lit_valor_total
                                  + ", lit_bpo=" + lit_bpo 
                                  + ", reu=" + reu 
                                  + ", autor=" + autor 
                                  + ", tri_nm_tribunal=" + tri_nm_tribunal 
                                  + ", tst_nm_tp_status=" + tst_nm_tp_status 
                                  + ", tpl_nm_tp_litigio=" + tpl_nm_tp_litigio 
                                  + ", tsd_nm_tp_status_det=" + tsd_nm_tp_status_det 
                                  + "}";
  }
}
