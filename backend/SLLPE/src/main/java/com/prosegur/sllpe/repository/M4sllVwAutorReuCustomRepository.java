package com.prosegur.sllpe.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import com.prosegur.sllpe.domain.M4sllAutorReuCustom;


public interface M4sllVwAutorReuCustomRepository extends JpaRepository<M4sllAutorReuCustom, Long> {


    /*
    @Query(
        value = "select * from sll.sll_vw_autor_reu  where  lit_id_litigio = :lit_id_litigio",
        nativeQuery = true
    )
    public List<SllVwAutorReu> findAllVwAutorReuByLitigio(@Param("lit_id_litigio") String lit_id_litigio);
    */
    @Query(
        value = "SELECT ar.mte_id_tp_empleado,\r\n" +
                "    ar.aur_autor_reu,\r\n" +
                "    ar.aur_ck_principal,\r\n" +
                "    ar.aur_secuencia,\r\n" +
                "    e.ent_nm_entidad,\r\n" +
                "    e.ent_nro_identificacion,\r\n" +
                "    ar.lit_id_litigio,\r\n" +
                "    ar.tar_id_tp_autor_reu,\r\n" +
                "    ar.tpe_id_tp_entidad,\r\n" +
                "    ar.tpi_id_tp_identificacion,\r\n" +
                "    ar.eci_id_ciudad AS eci_id_ciudad_autor,\r\n" +
                "    abg.mab_apellido,\r\n" +
                "    abg.mab_nombre,\r\n" +
                "    abg.mab_secuencia,\r\n" +
                "    pe.pex_apellido,\r\n" +
                "    pe.pex_nombre,\r\n" +
                "    pe.pex_nro_documento,\r\n" +
                "    p.std_id_person,\r\n" +
                "    p.std_n_fam_name_1 AS std_fam_name,\r\n" +
                "    p.std_n_first_name AS std_first_name,\r\n" +
                "    p.std_ssn,\r\n" +
                "    stdleg.std_id_leg_ent,\r\n" +
                "    stdleg.std_n_leg_ent AS std_leg_ent,\r\n" +
                "    pe.pex_nombre AS nombre,\r\n" +
                "    ar.std_or_hr_period AS std_hr_period\r\n" +
                "   FROM sll.m4sll_autor_reu ar\r\n" +
                "     LEFT JOIN sll.m4sll_entidades e ON e.id_organization  = ar.id_organization AND e.ent_nro_identificacion = ar.ent_nro_identificacion\r\n" +
                "     LEFT JOIN std_leg_ent stdleg ON stdleg.id_organization = ar.id_organization AND stdleg.std_id_leg_ent = ar.std_id_leg_ent\r\n" +
                "     LEFT JOIN std_person p ON p.std_id_person = ar.std_id_person\r\n" +
                "     LEFT JOIN sll.m4sll_persona_ext pe ON pe.id_organization = ar.id_organization AND pe.pex_nro_documento = ar.pex_nro_documento\r\n" +
                "     LEFT JOIN sll.m4sll_mt_abogados abg ON abg.id_organization = ar.id_organization AND abg.mab_secuencia = ar.mab_secuencia\r\n" +
                "  WHERE ar.id_organization = '0050'"
                + "AND LIT_ID_LITIGIO = :lit_id_litigio",
        nativeQuery = true
    )
    public List<M4sllAutorReuCustom> findAllVwAutorReuByLitigio(@Param("lit_id_litigio") String lit_id_litigio);


}
