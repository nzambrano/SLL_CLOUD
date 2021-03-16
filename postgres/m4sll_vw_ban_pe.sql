-- View: sll.m4sll_vw_ban_pe

-- DROP VIEW sll.m4sll_vw_ban_pe;

CREATE OR REPLACE VIEW sll.m4sll_vw_ban_pe
 AS
 SELECT l.id_organization,
    l.lit_id_litigio,
    l.lit_nro_proceso,
    l.lit_valor_total,
    l.lit_bpo,
    l.reu,
    l.autor,
    l.tri_nm_tribunal,
    l.tst_nm_tp_status,
    l.tpl_nm_tp_litigio,
    l.tsd_nm_tp_status_det
   FROM ( SELECT l_1.id_organization,
            l_1.lit_id_litigio,
            l_1.lit_nro_proceso,
            l_1.lit_valor_total,
            l_1.lit_bpo,
            ((((((( SELECT string_agg(m4peex.ent_nm_entidad::text, ','::text ORDER BY m4aure.lit_id_litigio, m4peex.ent_nro_identificacion) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN sll.m4sll_entidades m4peex ON m4aure.id_organization::text = m4peex.id_organization::text AND m4aure.aur_autor_reu::text = 'R'::text AND m4peex.ent_nro_identificacion::text = m4aure.ent_nro_identificacion::text
                  WHERE m4peex.id_organization::text = l_1.id_organization::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text)) || ' '::text) || (( SELECT string_agg(slen.std_n_leg_ent::text, ' | '::text ORDER BY m4aure.lit_id_litigio, m4aure.std_id_leg_ent) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN std_leg_ent slen ON m4aure.id_organization::text = slen.id_organization::text AND m4aure.aur_autor_reu::text = 'R'::text AND slen.std_id_leg_ent::text = m4aure.std_id_leg_ent::text
                  WHERE slen.id_organization::text = l_1.id_organization::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text))) || ' '::text) || (( SELECT string_agg(m4pe.pex_nombre::text, ' | '::text ORDER BY m4aure.lit_id_litigio, m4pe.pex_nro_documento) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN sll.m4sll_persona_ext m4pe ON m4pe.id_organization::text = m4aure.id_organization::text AND m4aure.aur_autor_reu::text = 'R'::text AND m4pe.pex_nro_documento::text = m4aure.pex_nro_documento::text
                  WHERE m4pe.id_organization::text = '0050'::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text))) || ' '::text) || (( SELECT string_agg((stdp.std_n_first_name::text || ' '::text) || stdp.std_n_fam_name_1::text, ' | '::text ORDER BY m4aure.lit_id_litigio, stdp.std_id_person) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN std_person stdp ON stdp.std_id_country::text = '7'::text AND m4aure.aur_autor_reu::text = 'R'::text AND stdp.std_id_person::text = m4aure.std_id_person::text
                  WHERE stdp.id_organization::text = '0000'::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text)) AS reu,
            ((((((( SELECT string_agg(m4peex.ent_nm_entidad::text, ','::text ORDER BY m4aure.lit_id_litigio, m4peex.ent_nro_identificacion) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN sll.m4sll_entidades m4peex ON m4aure.id_organization::text = m4peex.id_organization::text AND m4aure.aur_autor_reu::text = 'A'::text AND m4peex.ent_nro_identificacion::text = m4aure.ent_nro_identificacion::text
                  WHERE m4peex.id_organization::text = l_1.id_organization::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text)) || ' '::text) || (( SELECT string_agg(slen.std_n_leg_ent::text, ' | '::text ORDER BY m4aure.lit_id_litigio, m4aure.std_id_leg_ent) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN std_leg_ent slen ON m4aure.id_organization::text = slen.id_organization::text AND m4aure.aur_autor_reu::text = 'A'::text AND slen.std_id_leg_ent::text = m4aure.std_id_leg_ent::text
                  WHERE slen.id_organization::text = l_1.id_organization::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text))) || ' '::text) || (( SELECT string_agg(m4pe.pex_nombre::text, ' | '::text ORDER BY m4aure.lit_id_litigio, m4pe.pex_nro_documento) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN sll.m4sll_persona_ext m4pe ON m4pe.id_organization::text = m4aure.id_organization::text AND m4aure.aur_autor_reu::text = 'A'::text AND m4pe.pex_nro_documento::text = m4aure.pex_nro_documento::text
                  WHERE m4pe.id_organization::text = '0050'::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text))) || ' '::text) || (( SELECT string_agg((stdp.std_n_first_name::text || ' '::text) || stdp.std_n_fam_name_1::text, ' | '::text ORDER BY m4aure.lit_id_litigio, stdp.std_id_person) AS nombre
                   FROM sll.m4sll_autor_reu m4aure
                     JOIN std_person stdp ON stdp.std_id_country::text = '7'::text AND m4aure.aur_autor_reu::text = 'A'::text AND stdp.std_id_person::text = m4aure.std_id_person::text
                  WHERE stdp.id_organization::text = '0000'::text AND m4aure.lit_id_litigio::text = l_1.lit_id_litigio::text)) AS autor,
            ( SELECT t.tri_nm_tribunal
                   FROM sll.m4sll_fases f
                     JOIN ( SELECT m4sll_fases.lit_id_litigio,
                            min(m4sll_fases.fas_secuencia) AS fasemin
                           FROM sll.m4sll_fases
                          WHERE m4sll_fases.id_organization::text = '0050'::text
                          GROUP BY m4sll_fases.lit_id_litigio) minf ON minf.fasemin = f.fas_secuencia AND minf.lit_id_litigio::text = f.lit_id_litigio::text
                     JOIN sll.m4sll_tribunales t ON t.id_organization::text = '0050'::text AND t.id_organization::text = f.id_organization::text AND t.tri_id_tribunal::text = f.tri_id_tribunal::text
                  WHERE f.id_organization::text = '0050'::text AND f.lit_id_litigio::text = l_1.lit_id_litigio::text) AS tri_nm_tribunal,
            st.tst_nm_tp_status,
            tl.tpl_nm_tp_litigio,
            std.tsd_nm_tp_status_det
           FROM sll.m4sll_litigios l_1
             LEFT JOIN sll.m4sll_tp_status st ON st.tst_id_tp_status::text = l_1.tst_id_tp_status::text AND l_1.id_organization::text = st.id_organization::text
             LEFT JOIN sll.m4sll_tp_sta_det std ON std.tpl_id_tp_litigio::text = l_1.tpl_id_tp_litigio::text AND std.tsd_id_tp_sta_det::text = l_1.tsd_id_tp_sta_det::text AND l_1.id_organization::text = std.id_organization::text
             LEFT JOIN sll.m4sll_tp_litigios tl ON tl.tpl_id_tp_litigio::text = l_1.tpl_id_tp_litigio::text AND l_1.id_organization::text = tl.id_organization::text
          WHERE l_1.id_organization::text = '0050'::text) l
  WHERE l.id_organization::text = '0050'::text;

ALTER TABLE sll.m4sll_vw_ban_pe
    OWNER TO "SLLPE";

