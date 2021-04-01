
package com.prosegur.sllpe.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.prosegur.sllpe.domain.M4sllCpeCejpjC;
import com.prosegur.sllpe.domain.M4sllCpeCejpjCId;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface M4sllCpeCejpjCRepository extends JpaRepository<M4sllCpeCejpjC, M4sllCpeCejpjCId> {
    @Query(
        value = "select * from sll.m4sll_cpe_cejpj_c where lit_id_litigio = :lit_id_litigio",
        nativeQuery = true
    )
    public List<M4sllCpeCejpjC> findM4sllCpeCejpjCByLitIdLitigio(@Param("lit_id_litigio") String lit_id_litigio);
}