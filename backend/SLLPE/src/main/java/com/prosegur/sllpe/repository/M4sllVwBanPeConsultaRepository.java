
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.M4sllVwBanPeConsulta;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.*;

public interface M4sllVwBanPeConsultaRepository  extends JpaRepository<M4sllVwBanPeConsulta, Long>{

    @Query(
        value = "SELECT *                                               " +
                "  FROM sll.m4sll_vw_ban_pe                             " +
                " WHERE lit_id_litigio LIKE %:lit_id_litigio%           " +
                "   AND lit_nro_proceso LIKE %:lit_nro_proceso%         ",
        countQuery = "SELECT count(*)                                   " +
                     "  FROM sll.m4sll_vw_ban_pe                        " +
                     " WHERE lit_id_litigio LIKE %:lit_id_litigio%      " +
                     "   AND lit_nro_proceso LIKE %:lit_nro_proceso%    ",
        nativeQuery = true
      )
	public Page<M4sllVwBanPeConsulta> obtenerM4sllVwBanPeConsulta(Pageable pageable,@Param("lit_id_litigio") String lit_id_litigio, @Param("lit_nro_proceso") String lit_nro_proceso);
}
