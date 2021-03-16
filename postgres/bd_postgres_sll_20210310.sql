PGDMP     7    9    
    
        y            SLL    13.1 (Debian 13.1-1.pgdg100+1)    13.1 &              0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16384    SLL    DATABASE     Y   CREATE DATABASE "SLL" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE "SLL";
                SLL    false                        2615    16480    SLL    SCHEMA        CREATE SCHEMA "SLL";
    DROP SCHEMA "SLL";
                SLL    false            �            1259    24572    M4SLL_ABOHON_NJ    TABLE     �  CREATE TABLE "SLL"."M4SLL_ABOHON_NJ" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ANJ_SECUENCIA" bigint NOT NULL,
    "MAB_SECUENCIA" bigint,
    "ANJ_OBSERVACION" character varying(1000),
    "ANJ_MONTO" numeric(18,4),
    "ANJ_DT_START" timestamp(0) without time zone,
    "ANJ_DT_END" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 $   DROP TABLE "SLL"."M4SLL_ABOHON_NJ";
       SLL         heap    SLL    false    4            �            1259    24578    M4SLL_ASIENTOS_C    TABLE     o  CREATE TABLE "SLL"."M4SLL_ASIENTOS_C" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PAG_SECUENCIA" bigint NOT NULL,
    "HDP_DT_PERIODO" timestamp(0) without time zone NOT NULL,
    "ORIGEN" character varying(20),
    "GRUPO" bigint,
    "LOTE" bigint,
    "DESCRIP" character varying(30),
    "STATUS" character varying(10),
    "ASIENTO" bigint,
    "CANT_ASIENTO" integer,
    "CREATION_DATE" timestamp(0) without time zone,
    "ID_APPROLE2" character varying(30),
    "ID_SECUSER2" character varying(30),
    "DT_LAST_UPDATE2" timestamp(0) without time zone,
    "XX_FUN" character varying(100),
    "XX_EST" character varying(30),
    "XX_ERROR" character varying(2000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_ASIENTOS_C";
       SLL         heap    SLL    false    4            �            1259    24584    M4SLL_ASIENTOS_D    TABLE     �  CREATE TABLE "SLL"."M4SLL_ASIENTOS_D" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PAG_SECUENCIA" bigint NOT NULL,
    "HDP_DT_PERIODO" timestamp(0) without time zone NOT NULL,
    "ASD_SECUENCIA" bigint NOT NULL,
    "ORIGEN" character varying(20),
    "GRUPO" numeric(10,2),
    "LOTE" bigint,
    "MONEDA" character varying(15),
    "FCREA" character varying(10),
    "UCREA" character varying(15),
    "CATEGORIA" character varying(25),
    "CTACBLE" character varying(250),
    "EMPRESA" character varying(3),
    "RENGLON" bigint,
    "FECCONT" character varying(10),
    "PAIS" character varying(2),
    "DIVISION" character varying(4),
    "DEPTO" character varying(4),
    "ACTIV" character varying(1),
    "VALDB" character varying(20),
    "VALCR" character varying(20),
    "FGRAB" character varying(10),
    "HGRAB" character varying(8),
    "STATUS" character varying(30),
    "TCIDEA" character varying(4),
    "SCIDEA" character varying(4),
    "NCIDEA" character varying(15),
    "DLOTE" character varying(30),
    "IMPDB" character varying(20),
    "IMPCR" character varying(20),
    "TASACON" character varying(20),
    "FCONMON" character varying(10),
    "NOMASIEN" character varying(60),
    "DASIEN" character varying(60),
    "HISTORICO" character varying(512),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_ASIENTOS_D";
       SLL         heap    SLL    false    4            �            1259    24593    M4SLL_AUTOR_REU    TABLE     �  CREATE TABLE "SLL"."M4SLL_AUTOR_REU" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "AUR_SECUENCIA" bigint NOT NULL,
    "STD_OR_HR_PERIOD" bigint,
    "MAB_SECUENCIA" bigint,
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "TAR_ID_TP_AUTOR_REU" character varying(3),
    "AUR_AUTOR_REU" character varying(1),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "ENT_NRO_IDENTIFICACION" character varying(254),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "STD_ID_LEG_ENT" character varying(9),
    "STD_ID_PERSON" character varying(10),
    "AUR_EMAIL" character varying(1000),
    "AUR_NOMBRE_ABOGADO" character varying(1000),
    "AUR_TELEFONO" numeric(18,4),
    "AUR_OBSERVACIONES" character varying(1000),
    "AUR_CK_PRINCIPAL" character varying(1),
    "TPE_ID_TP_ENTIDAD" character varying(3),
    "AUR_CK_SUBSIDIARIO" character varying(1),
    "AUR_CK_SOLIDARIO" character varying(1),
    "AUR_MONTO_INDEMNIZACION" numeric(14,4),
    "AUR_CAUSA_DESVINCULACION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "ECI_ID_CIUDAD" character varying(3)
);
 $   DROP TABLE "SLL"."M4SLL_AUTOR_REU";
       SLL         heap    SLL    false    4            �            1259    24617    M4SLL_AUTOR_REU_1    TABLE     H  CREATE TABLE "SLL"."M4SLL_AUTOR_REU_1" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "AUR_SECUENCIA" bigint,
    "TAR_ID_TP_AUTOR_REU" character varying(3),
    "AUR_AUTOR_REU" character varying(1),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "ENT_NRO_IDENTIFICACION" character varying(254),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "STD_ID_LEG_ENT" character varying(9),
    "STD_ID_PERSON" character varying(10),
    "AUR_EMAIL" character varying(1000),
    "AUR_NOMBRE_ABOGADO" character varying(1000),
    "AUR_TELEFONO" numeric(18,4),
    "AUR_OBSERVACIONES" character varying(1000),
    "AUR_CK_PRINCIPAL" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_AUTOR_REU_1";
       SLL         heap    SLL    false    4            �            1259    24599    M4SLL_AUTOR_REU_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_AUTOR_REU_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "AUR_SECUENCIA" bigint,
    "TAR_ID_TP_AUTOR_REU" character varying(3),
    "AUR_AUTOR_REU" character varying(1),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "ENT_NRO_IDENTIFICACION" character varying(254),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "STD_ID_LEG_ENT" character varying(9),
    "STD_ID_PERSON" character varying(10),
    "AUR_EMAIL" character varying(1000),
    "AUR_NOMBRE_ABOGADO" character varying(1000),
    "AUR_TELEFONO" numeric(18,4),
    "AUR_OBSERVACIONES" character varying(1000),
    "AUR_CK_PRINCIPAL" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPE_ID_TP_ENTIDAD" character varying(3),
    "AUR_CK_SUBSIDIARIO" character varying(1),
    "AUR_CK_SOLIDARIO" character varying(1),
    "AUR_MONTO_INDEMNIZACION" numeric(14,4),
    "AUR_CAUSA_DESVINCULACION" character varying(254),
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "MAB_SECUENCIA" bigint
);
 (   DROP TABLE "SLL"."M4SLL_AUTOR_REU_BKP";
       SLL         heap    SLL    false    4            �            1259    24605    M4SLL_AUTOR_REU_PRUEBA_GABY    TABLE     �  CREATE TABLE "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "AUR_SECUENCIA" bigint NOT NULL,
    "STD_OR_HR_PERIOD" bigint,
    "MAB_SECUENCIA" bigint,
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "TAR_ID_TP_AUTOR_REU" character varying(3),
    "AUR_AUTOR_REU" character varying(1),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "ENT_NRO_IDENTIFICACION" character varying(254),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "STD_ID_LEG_ENT" character varying(9),
    "STD_ID_PERSON" character varying(10),
    "AUR_EMAIL" character varying(1000),
    "AUR_NOMBRE_ABOGADO" character varying(1000),
    "AUR_TELEFONO" numeric(18,4),
    "AUR_OBSERVACIONES" character varying(1000),
    "AUR_CK_PRINCIPAL" character varying(1),
    "TPE_ID_TP_ENTIDAD" character varying(3),
    "AUR_CK_SUBSIDIARIO" character varying(1),
    "AUR_CK_SOLIDARIO" character varying(1),
    "AUR_MONTO_INDEMNIZACION" numeric(14,4),
    "AUR_CAUSA_DESVINCULACION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 0   DROP TABLE "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY";
       SLL         heap    SLL    false    4            �            1259    24611    M4SLL_AUTOR_REU_QA    TABLE     w  CREATE TABLE "SLL"."M4SLL_AUTOR_REU_QA" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "AUR_SECUENCIA" bigint,
    "TAR_ID_TP_AUTOR_REU" character varying(3),
    "AUR_AUTOR_REU" character varying(1),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "ENT_NRO_IDENTIFICACION" character varying(254),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "STD_ID_LEG_ENT" character varying(9),
    "STD_ID_PERSON" character varying(10),
    "AUR_EMAIL" character varying(1000),
    "AUR_NOMBRE_ABOGADO" character varying(1000),
    "AUR_TELEFONO" numeric(18,4),
    "AUR_OBSERVACIONES" character varying(1000),
    "AUR_CK_PRINCIPAL" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPE_ID_TP_ENTIDAD" character varying(3)
);
 '   DROP TABLE "SLL"."M4SLL_AUTOR_REU_QA";
       SLL         heap    SLL    false    4            �            1259    24623    M4SLL_AUT_REU_DOC    TABLE     �  CREATE TABLE "SLL"."M4SLL_AUT_REU_DOC" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "AUR_SECUENCIA" bigint NOT NULL,
    "ARD_SECUENCIA" bigint NOT NULL,
    "ARD_URL_DOCUMENTO" character varying(1000),
    "ARD_FECHA_DOCUMENTO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_AUT_REU_DOC";
       SLL         heap    SLL    false    4            �            1259    24590    M4SLL_AU_REU_ANALI    TABLE     :  CREATE TABLE "SLL"."M4SLL_AU_REU_ANALI" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "AUR_SECUENCIA" bigint NOT NULL,
    "ARA_SECUENCIA" bigint NOT NULL,
    "ARA_CENTRO_COSTO" character varying(30),
    "ARA_SEGMENTO" character varying(30),
    "ARA_DIVISION" character varying(30),
    "STD_ID_LEG_ENT" character varying(9),
    "ARA_REGION" character varying(30),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_AU_REU_ANALI";
       SLL         heap    SLL    false    4            �            1259    24629    M4SLL_CASUIS_CTAS    TABLE     �  CREATE TABLE "SLL"."M4SLL_CASUIS_CTAS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "CCU_CASO" character varying(2) NOT NULL,
    "CCU_NRO_ASIENTO" character varying(2) NOT NULL,
    "CCU_DEBE_HABER" character varying(1),
    "CCU_CUENTA" character varying(10),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_CASUIS_CTAS";
       SLL         heap    SLL    false    4            �            1259    24632    M4SLL_CASUIS_CTAS_PRUEBA_GABY    TABLE     �  CREATE TABLE "SLL"."M4SLL_CASUIS_CTAS_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4),
    "CCU_CASO" character varying(2),
    "CCU_NRO_ASIENTO" character varying(2),
    "CCU_DEBE_HABER" character varying(1),
    "CCU_CUENTA" character varying(10),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 2   DROP TABLE "SLL"."M4SLL_CASUIS_CTAS_PRUEBA_GABY";
       SLL         heap    SLL    false    4            �            1259    24635    M4SLL_CCB_RAMAJUDC    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDC" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "RJC_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "FAS_NRO_RADICACION" character varying(30),
    "RJC_DESPACHO" character varying(254),
    "RJC_PONENTE" character varying(254),
    "RJC_TIPO" character varying(254),
    "RJC_CLASE" character varying(254),
    "RJC_RECURSO" character varying(254),
    "RJC_UBICACION_EXPEDIENTE" character varying(254),
    "RJC_DEMANDANTE" character varying(1000),
    "RJC_DEMANDADO" character varying(1000),
    "RJC_CONTENIDO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDC";
       SLL         heap    SLL    false    4            �            1259    24641    M4SLL_CCB_RAMAJUDC_10    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDC_10" (
    "ID_ORGANIZATION" character varying(4),
    "RJC_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "FAS_NRO_RADICACION" character varying(30),
    "RJC_DESPACHO" character varying(254),
    "RJC_PONENTE" character varying(254),
    "RJC_TIPO" character varying(254),
    "RJC_CLASE" character varying(254),
    "RJC_RECURSO" character varying(254),
    "RJC_UBICACION_EXPEDIENTE" character varying(254),
    "RJC_DEMANDANTE" character varying(1000),
    "RJC_DEMANDADO" character varying(1000),
    "RJC_CONTENIDO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDC_10";
       SLL         heap    SLL    false    4            �            1259    24647    M4SLL_CCB_RAMAJUDC_20    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDC_20" (
    "ID_ORGANIZATION" character varying(4),
    "RJC_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "FAS_NRO_RADICACION" character varying(30),
    "RJC_DESPACHO" character varying(254),
    "RJC_PONENTE" character varying(254),
    "RJC_TIPO" character varying(254),
    "RJC_CLASE" character varying(254),
    "RJC_RECURSO" character varying(254),
    "RJC_UBICACION_EXPEDIENTE" character varying(254),
    "RJC_DEMANDANTE" character varying(1000),
    "RJC_DEMANDADO" character varying(1000),
    "RJC_CONTENIDO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDC_20";
       SLL         heap    SLL    false    4            �            1259    24653    M4SLL_CCB_RAMAJUDD    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDD" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "RJD_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "FAS_NRO_RADICACION" character varying(30),
    "RJD_DT_ACTUALIZACION" timestamp(0) without time zone,
    "RJD_ACTUACION" character varying(1000),
    "RJD_ANOTACION" character varying(1000),
    "RJD_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "RJD_DT_FIN_TERMINO" timestamp(0) without time zone,
    "RJD_DT_REGISTRO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDD";
       SLL         heap    SLL    false    4            �            1259    24671    M4SLL_CCB_RAMAJUDD2    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDD2" (
    "ID_ORGANIZATION" character varying(4),
    "RJD_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "FAS_NRO_RADICACION" character varying(30),
    "RJD_DT_ACTUALIZACION" timestamp(0) without time zone,
    "RJD_ACTUACION" character varying(1000),
    "RJD_ANOTACION" character varying(1000),
    "RJD_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "RJD_DT_FIN_TERMINO" timestamp(0) without time zone,
    "RJD_DT_REGISTRO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 (   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDD2";
       SLL         heap    SLL    false    4            �            1259    24659    M4SLL_CCB_RAMAJUDD_10    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDD_10" (
    "ID_ORGANIZATION" character varying(4),
    "RJD_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "FAS_NRO_RADICACION" character varying(30),
    "RJD_DT_ACTUALIZACION" timestamp(0) without time zone,
    "RJD_ACTUACION" character varying(1000),
    "RJD_ANOTACION" character varying(1000),
    "RJD_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "RJD_DT_FIN_TERMINO" timestamp(0) without time zone,
    "RJD_DT_REGISTRO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDD_10";
       SLL         heap    SLL    false    4            �            1259    24665    M4SLL_CCB_RAMAJUDD_1000    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDD_1000" (
    "ID_ORGANIZATION" character varying(4),
    "RJD_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "FAS_NRO_RADICACION" character varying(30),
    "RJD_DT_ACTUALIZACION" timestamp(0) without time zone,
    "RJD_ACTUACION" character varying(1000),
    "RJD_ANOTACION" character varying(1000),
    "RJD_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "RJD_DT_FIN_TERMINO" timestamp(0) without time zone,
    "RJD_DT_REGISTRO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 ,   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDD_1000";
       SLL         heap    SLL    false    4            �            1259    24677    M4SLL_CCB_RAMAJUDD_20    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RAMAJUDD_20" (
    "ID_ORGANIZATION" character varying(4),
    "RJD_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "FAS_NRO_RADICACION" character varying(30),
    "RJD_DT_ACTUALIZACION" timestamp(0) without time zone,
    "RJD_ACTUACION" character varying(1000),
    "RJD_ANOTACION" character varying(1000),
    "RJD_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "RJD_DT_FIN_TERMINO" timestamp(0) without time zone,
    "RJD_DT_REGISTRO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_CCB_RAMAJUDD_20";
       SLL         heap    SLL    false    4            �            1259    24683    M4SLL_CCB_RJCC_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RJCC_BKP" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "RJC_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "FAS_NRO_RADICACION" character varying(30),
    "RJC_DESPACHO" character varying(254),
    "RJC_PONENTE" character varying(254),
    "RJC_TIPO" character varying(254),
    "RJC_CLASE" character varying(254),
    "RJC_RECURSO" character varying(254),
    "RJC_UBICACION_EXPEDIENTE" character varying(254),
    "RJC_DEMANDANTE" character varying(1000),
    "RJC_DEMANDADO" character varying(1000),
    "RJC_CONTENIDO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CCB_RJCC_BKP";
       SLL         heap    SLL    false    4            �            1259    24689    M4SLL_CCB_RJCD_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_CCB_RJCD_BKP" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "RJD_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "FAS_NRO_RADICACION" character varying(30),
    "RJD_DT_ACTUALIZACION" timestamp(0) without time zone,
    "RJD_ACTUACION" character varying(1000),
    "RJD_ANOTACION" character varying(1000),
    "RJD_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "RJD_DT_FIN_TERMINO" timestamp(0) without time zone,
    "RJD_DT_REGISTRO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CCB_RJCD_BKP";
       SLL         heap    SLL    false    4            �            1259    24698    M4SLL_CIERRES_MENS    TABLE       CREATE TABLE "SLL"."M4SLL_CIERRES_MENS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "CIM_ANIO" character varying(4) NOT NULL,
    "CIM_MES" character varying(2) NOT NULL,
    "MTC_ID_TAREA" character varying(3) NOT NULL,
    "MEE_ID_EST_EJECUCION" character varying(3),
    "MET_ID_EST_TAREA" character varying(3),
    "CIM_DT_EJECUCION" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CIERRES_MENS";
       SLL         heap    SLL    false    4            �            1259    24695    M4SLL_CIERRE_MENSUAL    TABLE     �   CREATE TABLE "SLL"."M4SLL_CIERRE_MENSUAL" (
    "CIM_ANIO" character varying(4),
    "CIM_MES" character varying(2),
    "ID_TAREA" character varying(3),
    "ESTADO_TAREA" character varying(1)
);
 )   DROP TABLE "SLL"."M4SLL_CIERRE_MENSUAL";
       SLL         heap    SLL    false    4            �            1259    24701    M4SLL_CLIENTES_OMB    TABLE     �  CREATE TABLE "SLL"."M4SLL_CLIENTES_OMB" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "CLO_ID_CLIENTE" character varying(3) NOT NULL,
    "CLO_NM_CLIENTE" character varying(100),
    "CLO_DT_START" timestamp(0) without time zone,
    "CLO_DT_END" timestamp(0) without time zone,
    "CLO_ID_APP_ROLE" character varying(50),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CLIENTES_OMB";
       SLL         heap    SLL    false    4            �            1259    24704    M4SLL_CLIENTES_ROL    TABLE     �  CREATE TABLE "SLL"."M4SLL_CLIENTES_ROL" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "CLO_ID_CLIENTE" character varying(3) NOT NULL,
    "CLR_ID_ROLE" character varying(255) NOT NULL,
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(10),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CLIENTES_ROL";
       SLL         heap    SLL    false    4            �            1259    24729    M4SLL_COMPROMISOS    TABLE     �  CREATE TABLE "SLL"."M4SLL_COMPROMISOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TCO_ID_TP_COMPROMISO" character varying(3) NOT NULL,
    "COM_SECUENCIA" bigint NOT NULL,
    "MAB_SECUENCIA" bigint,
    "TFA_ID_TP_FASE" character varying(3),
    "COR_ID_COMP_RESULTADO" character varying(3),
    "COM_FECHA" timestamp(0) without time zone,
    "COM_OBSERVACION" character varying(1000),
    "COE_ID_COMP_ESTADO" character varying(3),
    "COM_DT_END" timestamp(0) without time zone,
    "COM_RESPONSABLE" character varying(30),
    "COM_DT_INICIO" timestamp(0) without time zone,
    "COM_ACTUACION" character varying(1000),
    "COM_NOTAS" character varying(254),
    "COM_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "COM_DT_FIN_TERMINO" timestamp(0) without time zone,
    "COM_DT_REGISTRO" timestamp(0) without time zone,
    "COM_URL_DOCUMENTO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "COM_NM_DOCUMENTO" character varying(2000),
    "COM_SECUENCIAL" bigint
);
 &   DROP TABLE "SLL"."M4SLL_COMPROMISOS";
       SLL         heap    SLL    false    4            �            1259    24735    M4SLL_COMPROMISOS_BKP    TABLE     "  CREATE TABLE "SLL"."M4SLL_COMPROMISOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "TCO_ID_TP_COMPROMISO" character varying(3),
    "COM_SECUENCIA" bigint,
    "TFA_ID_TP_FASE" character varying(3),
    "COR_ID_COMP_RESULTADO" character varying(3),
    "COM_FECHA" timestamp(0) without time zone,
    "COM_OBSERVACION" character varying(1000),
    "COE_ID_COMP_ESTADO" character varying(3),
    "COM_DT_END" timestamp(0) without time zone,
    "COM_RESPONSABLE" character varying(30),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "COM_DT_INICIO" timestamp(0) without time zone,
    "COM_ACTUACION" character varying(254),
    "COM_NOTAS" character varying(254),
    "COM_DT_INICIO_TERMINO" timestamp(0) without time zone,
    "COM_DT_FIN_TERMINO" timestamp(0) without time zone,
    "COM_DT_REGISTRO" timestamp(0) without time zone,
    "COM_URL_DOCUMENTO" character varying(1000),
    "MAB_SECUENCIA" bigint
);
 *   DROP TABLE "SLL"."M4SLL_COMPROMISOS_BKP";
       SLL         heap    SLL    false    4            �            1259    24707    M4SLL_COMP_DETALLE    TABLE     .  CREATE TABLE "SLL"."M4SLL_COMP_DETALLE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "COM_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "COE_ID_COMP_ESTADO" character varying(3) NOT NULL,
    "COR_ID_COMP_RESULTADO" character varying(3) NOT NULL,
    "COD_FECHA" timestamp(0) without time zone,
    "COD_OBSERVACION" character varying(1000),
    "COD_SECUENCIA" bigint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_COMP_DETALLE";
       SLL         heap    SLL    false    4            �            1259    24713    M4SLL_COMP_DOC    TABLE        CREATE TABLE "SLL"."M4SLL_COMP_DOC" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TCO_ID_TP_COMPROMISO" character varying(3) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "COD_SECUENCIA" bigint NOT NULL,
    "COM_SECUENCIA" bigint NOT NULL,
    "COD_URL_DOCUMENTO" character varying(1000),
    "COD_FECHA_DOC" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 #   DROP TABLE "SLL"."M4SLL_COMP_DOC";
       SLL         heap    SLL    false    4            �            1259    24719    M4SLL_COMP_ESTADOS    TABLE     K  CREATE TABLE "SLL"."M4SLL_COMP_ESTADOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "COE_ID_COMP_ESTADO" character varying(3) NOT NULL,
    "COE_NM_COMP_ESTADO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "COE_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "COE_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_COMP_ESTADOS";
       SLL         heap    SLL    false    4            �            1259    24724    M4SLL_COMP_RESULTA    TABLE     �  CREATE TABLE "SLL"."M4SLL_COMP_RESULTA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "COR_ID_COMP_RESULTADO" character varying(3) NOT NULL,
    "COR_NM_COMP_RESULTADO" character varying(254),
    "TCO_ID_TP_COMPROMISO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "COR_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "COR_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_COMP_RESULTA";
       SLL         heap    SLL    false    4            �            1259    24741    M4SLL_CONVERSION    TABLE     V  CREATE TABLE "SLL"."M4SLL_CONVERSION" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "CON_REFERENCIA" character varying(254) NOT NULL,
    "CON_VALOR_CONVERTIDO" character varying(254) NOT NULL,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_CONVERSION";
       SLL         heap    SLL    false    4            �            1259    24747    M4SLL_COTIZACION    TABLE     G  CREATE TABLE "SLL"."M4SLL_COTIZACION" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "COT_ANIO" bigint NOT NULL,
    "COT_MES" bigint NOT NULL,
    "COT_COTIZACION" numeric(18,2),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_COTIZACION";
       SLL         heap    SLL    false    4            �            1259    24750    M4SLL_CPE_CEJPJ_C    TABLE     �  CREATE TABLE "SLL"."M4SLL_CPE_CEJPJ_C" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "FAS_NRO_RADICACION" character varying(30),
    "CCC_DEMANDANTE" character varying(4000),
    "CCC_DEMANDADO" character varying(4000),
    "CCC_ORGANO" character varying(254),
    "CCC_DISTRITO" character varying(254),
    "CCC_JUEZ" character varying(254),
    "CCC_FECHA_INICIO" timestamp(0) without time zone,
    "CCC_PROCESO" character varying(254),
    "CCC_ESPECIALIDAD" character varying(254),
    "CCC_MATERIA" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_CPE_CEJPJ_C";
       SLL         heap    SLL    false    4            �            1259    24756    M4SLL_CPE_CEJPJ_D    TABLE     �  CREATE TABLE "SLL"."M4SLL_CPE_CEJPJ_D" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "CCD_ID_SECUENCIA" bigint NOT NULL,
    "CCD_SUMILLA_SEGUIMIENTO" character varying(4000),
    "CCD_FECHA_SEGUIMIENTO" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_CPE_CEJPJ_D";
       SLL         heap    SLL    false    4            �            1259    24762    M4SLL_CTRL_ERRORES    TABLE     �  CREATE TABLE "SLL"."M4SLL_CTRL_ERRORES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "CTE_USUARIO" character varying(10) NOT NULL,
    "CTE_FECHA" timestamp(0) without time zone NOT NULL,
    "CTE_MODULO" character varying(254),
    "CTE_DESCRIPCION" text,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_CTRL_ERRORES";
       SLL         heap    SLL    false    4            �            1259    24768    M4SLL_CUADRANTE    TABLE       CREATE TABLE "SLL"."M4SLL_CUADRANTE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ORDINAL_10_PK" bigint NOT NULL,
    "ARG_CSP_COD_EMPR" character varying(254),
    "ARG_CSP_NOM_EMPR" character varying(254),
    "ARG_CSP_SSN" character varying(254),
    "ARG_CSP_ID_HR" character varying(254),
    "ARG_CSP_OR_HR_PER" smallint,
    "ARG_CSP_N_FIRST_NAME" character varying(254),
    "ARG_CSP_COD_ACT" character varying(254),
    "ARG_CSP_COD_DELEG" character varying(254),
    "ARG_CSP_NOM_DELEG" character varying(254),
    "ARG_CSP_ANNO_MES" character varying(254),
    "ARG_CSP_FEC_MOBRA" timestamp(0) without time zone,
    "ARG_CSP_COD_CLI" character varying(254),
    "ARG_CSP_NOM_CLI" character varying(254),
    "ARG_CSP_COD_SER" character varying(254),
    "ARG_CSP_NOM_SER" character varying(254),
    "ARG_CSP_FI_SERVI" timestamp(0) without time zone,
    "ARG_CSP_HORA_FI_SERVI" character varying(254),
    "ARG_CSP_FF_SERVI" timestamp(0) without time zone,
    "ARG_CSP_HORA_FF_SERVI" character varying(254),
    "ARG_CSP_HORAS_NOCT" character varying(254),
    "ARG_CSP_HORAS_DIUR" character varying(254),
    "ARG_CSP_FIN_FEST" character varying(254),
    "ARG_CSP_ARMA" character varying(254),
    "ARG_CSP_DIA_SEMANA" character varying(254),
    "ARG_CSP_FESTIVO" character varying(254),
    "CUA_CK_CLIENTE" smallint,
    "CUA_CK_OBJETIVO" smallint,
    "CUA_CK_GT_HORAS" smallint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 $   DROP TABLE "SLL"."M4SLL_CUADRANTE";
       SLL         heap    SLL    false    4            �            1259    24774    M4SLL_CUADRANTE_LOG    TABLE     6  CREATE TABLE "SLL"."M4SLL_CUADRANTE_LOG" (
    "ID_ORGANIZATION" character varying(4),
    "CLG_SQLCOD_ERROR" double precision,
    "CLG_SQLMSG_ERROR" character varying(500),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 (   DROP TABLE "SLL"."M4SLL_CUADRANTE_LOG";
       SLL         heap    SLL    false    4            �            1259    24780    M4SLL_DATOS_WF    TABLE     l  CREATE TABLE "SLL"."M4SLL_DATOS_WF" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ID_BPC" character varying(10) NOT NULL,
    "MODULO" character varying(10) NOT NULL,
    "ID_MODULE" character varying(10) NOT NULL,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 #   DROP TABLE "SLL"."M4SLL_DATOS_WF";
       SLL         heap    SLL    false    4            �            1259    24783    M4SLL_DESTINATARIO    TABLE     Q  CREATE TABLE "SLL"."M4SLL_DESTINATARIO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "DES_ID_DESTINATARIO" character varying(3) NOT NULL,
    "DES_NM_DESTINATARIO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_DESTINATARIO";
       SLL         heap    SLL    false    4            �            1259    24802    M4SLL_DOCPAG    TABLE     �  CREATE TABLE "SLL"."M4SLL_DOCPAG" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "DCP_SECUENCIA" bigint NOT NULL,
    "DCP_DESCRIPCION" character varying(2000),
    "DCP_FEC_CRE" timestamp(0) without time zone,
    "DCP_NRO_SOLICITUD" bigint,
    "DCP_APROB_ABOGADO_INT" character varying(254),
    "DCP_APROB_BACK_OFFICE" character varying(254),
    "DCP_APROB_GERENCIAL" character varying(254),
    "DCP_STATUS" smallint,
    "DCP_NRO_IDENTIFICACION" character varying(254),
    "DCP_DESTINATARIO" character varying(2000),
    "DCP_TIPO_CUENTA" character varying(254),
    "DCP_NRO_CUENTA_DES" character varying(254),
    "DCP_EMAIL_DEST" character varying(2000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "DCP_DESTINATARI1" character varying(2000)
);
 !   DROP TABLE "SLL"."M4SLL_DOCPAG";
       SLL         heap    SLL    false    4            �            1259    24786    M4SLL_DOC_LITIGIOS    TABLE     
  CREATE TABLE "SLL"."M4SLL_DOC_LITIGIOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "DOL_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TDL_ID_TP_DOC_LITIGIO" character varying(3),
    "DOL_FECHA" timestamp(0) without time zone,
    "DOL_OBSERVACION" character varying(1000),
    "DOL_URL_DOC_LIT" character varying(1000),
    "DOO_ID_DOC_ORIGEN" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TFA_ID_TP_FASE" character varying(3),
    "DOL_CK_ASOCIA_FASE" character varying(1) DEFAULT 'N'::character varying,
    "DOL_NOMBRE" character varying(254),
    "DOL_DT_NOTIFICACION" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_DOC_LITIGIOS";
       SLL         heap    SLL    false    4            �            1259    24793    M4SLL_DOC_LITIGIOS_BKP    TABLE     q  CREATE TABLE "SLL"."M4SLL_DOC_LITIGIOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "DOL_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "TDL_ID_TP_DOC_LITIGIO" character varying(3),
    "DOL_FECHA" timestamp(0) without time zone,
    "DOL_OBSERVACION" character varying(1000),
    "DOL_URL_DOC_LIT" character varying(1000),
    "DOO_ID_DOC_ORIGEN" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TFA_ID_TP_FASE" character varying(3),
    "DOL_CK_ASOCIA_FASE" character varying(1)
);
 +   DROP TABLE "SLL"."M4SLL_DOC_LITIGIOS_BKP";
       SLL         heap    SLL    false    4            �            1259    24799    M4SLL_DOC_ORIGENES    TABLE     M  CREATE TABLE "SLL"."M4SLL_DOC_ORIGENES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "DOO_ID_DOC_ORIGEN" character varying(3) NOT NULL,
    "DOO_NM_DOC_ORIGEN" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_DOC_ORIGENES";
       SLL         heap    SLL    false    4            �            1259    24808    M4SLL_ENTIDADES    TABLE     h  CREATE TABLE "SLL"."M4SLL_ENTIDADES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPI_ID_TP_IDENTIFICACION" character varying(3) NOT NULL,
    "ENT_NRO_IDENTIFICACION" character varying(254) NOT NULL,
    "ENT_ID_ENTIDAD" character varying(3),
    "ENT_NM_ENTIDAD" character varying(254),
    "TPE_ID_TP_ENTIDAD" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "ENT_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "ENT_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "ENT_TP_EMPLEADO" character varying(10),
    "ENT_ID_NEGOCIO" character varying(10)
);
 $   DROP TABLE "SLL"."M4SLL_ENTIDADES";
       SLL         heap    SLL    false    4            �            1259    24816    M4SLL_ENTIDADES_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_ENTIDADES_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "ENT_NRO_IDENTIFICACION" character varying(254),
    "ENT_ID_ENTIDAD" character varying(3),
    "ENT_NM_ENTIDAD" character varying(254),
    "TPE_ID_TP_ENTIDAD" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3)
);
 (   DROP TABLE "SLL"."M4SLL_ENTIDADES_BKP";
       SLL         heap    SLL    false    4            �            1259    24822    M4SLL_ESP_CIUDADES    TABLE     E  CREATE TABLE "SLL"."M4SLL_ESP_CIUDADES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ECI_ID_CIUDAD" character varying(3) NOT NULL,
    "ECI_NM_CIUDAD" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_ESP_CIUDADES";
       SLL         heap    SLL    false    4            �            1259    24825    M4SLL_ESP_DELEGACI    TABLE     �  CREATE TABLE "SLL"."M4SLL_ESP_DELEGACI" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "EDE_ID_DELEGACION" character varying(3) NOT NULL,
    "ECI_ID_CIUDAD" character varying(3) NOT NULL,
    "EDE_NM_DELEGACION" character varying(254),
    "EDE_ZONA_RRLL" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_ESP_DELEGACI";
       SLL         heap    SLL    false    4            �            1259    24828    M4SLL_ESP_DELEGACI_PRUEBA_GABY    TABLE     �  CREATE TABLE "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "EDE_ID_DELEGACION" character varying(3) NOT NULL,
    "ECI_ID_CIUDAD" character varying(3) NOT NULL,
    "EDE_NM_DELEGACION" character varying(254),
    "EDE_ZONA_RRLL" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 3   DROP TABLE "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY";
       SLL         heap    SLL    false    4                        1259    24831    M4SLL_ESP_LIT_PROV    TABLE     �  CREATE TABLE "SLL"."M4SLL_ESP_LIT_PROV" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "ELP_ANIO" character varying(4) NOT NULL,
    "ELP_MES" character varying(2) NOT NULL,
    "ELP_VALOR_PROVISION" numeric(18,4),
    "ELP_PORCENTAJE_PROV" numeric(18,4),
    "LIT_VALOR_PED_TOTAL" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_ESP_LIT_PROV";
       SLL         heap    SLL    false    4                       1259    24839    M4SLL_ESTUDIO_JUR    TABLE     �  CREATE TABLE "SLL"."M4SLL_ESTUDIO_JUR" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "EJU_ID_EST_JURIDICO" bigint NOT NULL,
    "EJU_NM_EST_JURIDICO" character varying(254),
    "EJU_EMAIL" character varying(254),
    "EJU_TEL_OFICINA" character varying(30),
    "EJU_TEL_MOVIL" character varying(30),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "EJU_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "EJU_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_ESTUDIO_JUR";
       SLL         heap    SLL    false    4                       1259    24847    M4SLL_ESTUDIO_JUR_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_ESTUDIO_JUR_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "EJU_ID_EST_JURIDICO" character varying(3),
    "EJU_NM_EST_JURIDICO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "EJU_EMAIL" character varying(254),
    "EJU_TEL_OFICINA" character varying(30),
    "EJU_TEL_MOVIL" character varying(30)
);
 *   DROP TABLE "SLL"."M4SLL_ESTUDIO_JUR_BKP";
       SLL         heap    SLL    false    4                       1259    24834    M4SLL_EST_JUR_SUB    TABLE     u  CREATE TABLE "SLL"."M4SLL_EST_JUR_SUB" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "EJU_ID_EST_JURIDICO" bigint NOT NULL,
    "EJS_ID_EST_JUR_SUB" character varying(3) NOT NULL,
    "EJS_NM_EST_JUR_SUB" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "EJS_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "EJS_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_EST_JUR_SUB";
       SLL         heap    SLL    false    4                       1259    24853    M4SLL_EXEC_RP_LITIGIO    TABLE     �   CREATE TABLE "SLL"."M4SLL_EXEC_RP_LITIGIO" (
    "USUARIO" character varying(100),
    "SQL" text,
    "FECHA_HORA" timestamp(6) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_EXEC_RP_LITIGIO";
       SLL         heap    SLL    false    4                       1259    24859    M4SLL_EXP_PED    TABLE     �   CREATE TABLE "SLL"."M4SLL_EXP_PED" (
    "LIT_ID_LEGADO" character varying(10),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_VALOR_PED_TOTAL" numeric(18,4)
);
 "   DROP TABLE "SLL"."M4SLL_EXP_PED";
       SLL         heap    SLL    false    4                       1259    24862    M4SLL_FASES    TABLE     �  CREATE TABLE "SLL"."M4SLL_FASES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TFA_ID_TP_FASE" character varying(3) NOT NULL,
    "FAS_ID_FASE_ESTADO" character varying(3),
    "FAR_ID_FASE_RESULTADO" character varying(3),
    "FAS_FECHA" timestamp(0) without time zone,
    "FAS_OBSERVACION" character varying(1000),
    "FAS_DT_CITACION" timestamp(0) without time zone,
    "FAS_NRO_RADICACION" character varying(30),
    "TRI_ID_TRIBUNAL" character varying(3),
    "FAS_JUEZ" character varying(254),
    "FAS_VALOR_CONDENA" numeric(18,4),
    "FAS_VALOR_HONORARIOS" numeric(14,4),
    "FAS_PORC_CONDENA" smallint,
    "FAS_PORC_HONORARIOS" smallint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "FAS_CHK_ROBOT" character varying(1),
    "FAS_SECUENCIA" bigint,
    "FAS_NUM_JUZGADO" character varying(10),
    "FAS_FECHA_COND" timestamp(0) without time zone,
    "FAS_FECHA_HON" timestamp(0) without time zone,
    "FAS_OBS_HON" character varying(1000),
    "FAS_DT_IMPACTO" timestamp(0) without time zone,
    "FAS_HORA" character varying(5)
);
     DROP TABLE "SLL"."M4SLL_FASES";
       SLL         heap    SLL    false    4                       1259    24868    M4SLL_FASES_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_FASES_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "TFA_ID_TP_FASE" character varying(3),
    "FAS_ID_FASE_ESTADO" character varying(3),
    "FAR_ID_FASE_RESULTADO" character varying(3),
    "FAS_FECHA" timestamp(0) without time zone,
    "FAS_OBSERVACION" character varying(1000),
    "FAS_DT_CITACION" timestamp(0) without time zone,
    "FAS_NRO_RADICACION" character varying(30),
    "TRI_ID_TRIBUNAL" character varying(3),
    "FAS_JUEZ" character varying(254),
    "FAS_VALOR_CONDENA" numeric(18,4),
    "FAS_VALOR_HONORARIOS" numeric(14,4),
    "FAS_PORC_CONDENA" smallint,
    "FAS_PORC_HONORARIOS" smallint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "FAS_CHK_ROBOT" character varying(1),
    "FAS_SECUENCIA" bigint
);
 $   DROP TABLE "SLL"."M4SLL_FASES_BKP";
       SLL         heap    SLL    false    4                       1259    24874    M4SLL_FASES_DOC    TABLE     �  CREATE TABLE "SLL"."M4SLL_FASES_DOC" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TFA_ID_TP_FASE" character varying(3) NOT NULL,
    "FAD_SECUENCIA" bigint NOT NULL,
    "FAD_URL_DOCUMENTO" character varying(1000),
    "FAS_FECHA_DOC" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 $   DROP TABLE "SLL"."M4SLL_FASES_DOC";
       SLL         heap    SLL    false    4            	           1259    24880    M4SLL_FASES_ESTADO    TABLE     y  CREATE TABLE "SLL"."M4SLL_FASES_ESTADO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "FAS_ID_FASE_ESTADO" character varying(3) NOT NULL,
    "FAS_NM_FASE_ESTADO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "FAS_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "FAS_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_FASES_ESTADO";
       SLL         heap    SLL    false    4            
           1259    24885    M4SLL_FASES_PROV    TABLE       CREATE TABLE "SLL"."M4SLL_FASES_PROV" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "FAP_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "FAP_DT_IMPACTO" timestamp(0) without time zone,
    "FAP_FECHA" timestamp(0) without time zone,
    "FAP_VALOR_CONDENA" numeric(18,4),
    "FAP_VALOR_HONORARIOS" numeric(18,4),
    "FAP_PORC_CONDENA" numeric(18,4),
    "FAP_PORC_HONORARIOS" numeric(18,4),
    "FAP_FECHA_COND" timestamp(0) without time zone,
    "FAP_FECHA_HON" timestamp(0) without time zone,
    "FAP_OBS_COND" character varying(1000),
    "FAP_OBS_HON" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_FASES_PROV";
       SLL         heap    SLL    false    4                       1259    24891    M4SLL_FASES_PROV_BKP    TABLE       CREATE TABLE "SLL"."M4SLL_FASES_PROV_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "FAP_SECUENCIA" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "TFA_ID_TP_FASE" character varying(3),
    "FAP_DT_IMPACTO" timestamp(0) without time zone,
    "FAP_FECHA" timestamp(0) without time zone,
    "FAP_VALOR_CONDENA" numeric(14,4),
    "FAP_VALOR_HONORARIOS" numeric(14,4),
    "FAP_PORC_CONDENA" smallint,
    "FAP_PORC_HONORARIOS" smallint,
    "FAP_FECHA_COND" timestamp(0) without time zone,
    "FAP_FECHA_HON" timestamp(0) without time zone,
    "FAP_OBS_COND" character varying(1000),
    "FAP_OBS_HON" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 )   DROP TABLE "SLL"."M4SLL_FASES_PROV_BKP";
       SLL         heap    SLL    false    4                       1259    24897    M4SLL_FASES_RESULT    TABLE     �  CREATE TABLE "SLL"."M4SLL_FASES_RESULT" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "FAR_ID_FASE_RESULTADO" character varying(3) NOT NULL,
    "TFA_ID_TP_FASE" character varying(3),
    "FAR_NM_FASE_RESULTADO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "FAR_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "FAR_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_FASES_RESULT";
       SLL         heap    SLL    false    4                       1259    24902    M4SLL_FASES_RESULT_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_FASES_RESULT_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "FAR_ID_FASE_RESULTADO" character varying(3),
    "TFA_ID_TP_FASE" character varying(3),
    "FAR_NM_FASE_RESULTADO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3)
);
 +   DROP TABLE "SLL"."M4SLL_FASES_RESULT_BKP";
       SLL         heap    SLL    false    4                       1259    24905    M4SLL_HIS_DET_PROV    TABLE     W  CREATE TABLE "SLL"."M4SLL_HIS_DET_PROV" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TFA_ID_TP_FASE" character varying(3) NOT NULL,
    "MDP_ID_DET_PROVISION" character varying(3) NOT NULL,
    "HDP_DT_PERIODO" timestamp(0) without time zone NOT NULL,
    "HDP_VALOR" numeric(14,4),
    "HDP_PORC_PROV" smallint,
    "HDP_MONTO_A_PROVISIONAR" numeric(14,4),
    "HDP_MONTO_PAGADO" numeric(14,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_HIS_DET_PROV";
       SLL         heap    SLL    false    4                       1259    24908    M4SLL_INI_PARAM_CALC_PROV    TABLE       CREATE TABLE "SLL"."M4SLL_INI_PARAM_CALC_PROV" (
    "IPAR_SECUENCIA" bigint NOT NULL,
    "ID_ORGANIZATION" character varying(4),
    "IPAR_PROCESO" character varying(100),
    "IPAR_NOMBRE" character varying(30),
    "IPAR_DESC" character varying(500),
    "IPAR_VAL_NUMBER" bigint,
    "IPAR_VAL_DATE" timestamp(0) without time zone,
    "IPAR_VAL_CHAR" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 .   DROP TABLE "SLL"."M4SLL_INI_PARAM_CALC_PROV";
       SLL         heap    SLL    false    4                       1259    24920    M4SLL_INT_GL_TRXS    TABLE     .  CREATE TABLE "SLL"."M4SLL_INT_GL_TRXS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ORIGEN" character varying(20) NOT NULL,
    "GRUPO" bigint NOT NULL,
    "LOTE" bigint NOT NULL,
    "RENGLON" bigint NOT NULL,
    "EMPRESA" character varying(3),
    "FECCONT" character varying(10),
    "MONEDA" character varying(15),
    "FCREA" character varying(10),
    "UCREA" character varying(15),
    "CATEGORIA" character varying(25),
    "CTACBLE" character varying(250),
    "PAIS" character varying(2),
    "DIVISION" character varying(4),
    "DEPTO" character varying(4),
    "ACTIV" character varying(1),
    "VALDB" character varying(20),
    "VALCR" character varying(20),
    "FGRAB" character varying(10),
    "HGRAB" character varying(8),
    "STATUS" character varying(30),
    "TCIDEA" character varying(4),
    "SCIDEA" character varying(4),
    "NCIDEA" character varying(15),
    "DLOTE" character varying(30),
    "IMPDB" character varying(20),
    "IMPCR" character varying(20),
    "TASACON" character varying(20),
    "FCONMON" character varying(10),
    "NOMASIEN" character varying(60),
    "DASIEN" character varying(60),
    "DLINEA" character varying(50),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_INT_GL_TRXS";
       SLL         heap    SLL    false    4                       1259    24926    M4SLL_INT_GL_TRXS_PRUEBA_GABY    TABLE       CREATE TABLE "SLL"."M4SLL_INT_GL_TRXS_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4),
    "ORIGEN" character varying(20),
    "GRUPO" bigint,
    "LOTE" bigint,
    "RENGLON" bigint,
    "EMPRESA" character varying(3),
    "FECCONT" character varying(10),
    "MONEDA" character varying(15),
    "FCREA" character varying(10),
    "UCREA" character varying(15),
    "CATEGORIA" character varying(25),
    "CTACBLE" character varying(250),
    "PAIS" character varying(2),
    "DIVISION" character varying(4),
    "DEPTO" character varying(4),
    "ACTIV" character varying(1),
    "VALDB" character varying(20),
    "VALCR" character varying(20),
    "FGRAB" character varying(10),
    "HGRAB" character varying(8),
    "STATUS" character varying(30),
    "TCIDEA" character varying(4),
    "SCIDEA" character varying(4),
    "NCIDEA" character varying(15),
    "DLOTE" character varying(30),
    "IMPDB" character varying(20),
    "IMPCR" character varying(20),
    "TASACON" character varying(20),
    "FCONMON" character varying(10),
    "NOMASIEN" character varying(60),
    "DASIEN" character varying(60),
    "DLINEA" character varying(50),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 2   DROP TABLE "SLL"."M4SLL_INT_GL_TRXS_PRUEBA_GABY";
       SLL         heap    SLL    false    4                       1259    24914    M4SLL_INT_GL_TRX_L    TABLE     �  CREATE TABLE "SLL"."M4SLL_INT_GL_TRX_L" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ORIGEN" character varying(20) NOT NULL,
    "GRUPO" bigint NOT NULL,
    "LOTE" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10),
    "DESCRIP" character varying(30),
    "STATUS" character varying(10),
    "ASIENTO" bigint,
    "CANT_ASIENTO" integer,
    "CREATION_DATE" timestamp(0) without time zone,
    "ID_APPROLE2" character varying(30),
    "ID_SECUSER2" character varying(30),
    "DT_LAST_UPDATE2" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "IGT_IMPORTE_LOTE" numeric(18,4)
);
 '   DROP TABLE "SLL"."M4SLL_INT_GL_TRX_L";
       SLL         heap    SLL    false    4                       1259    24917    M4SLL_INT_GL_TRX_L_PRUEBA_GABY    TABLE     �  CREATE TABLE "SLL"."M4SLL_INT_GL_TRX_L_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4),
    "ORIGEN" character varying(20),
    "GRUPO" bigint,
    "LOTE" bigint,
    "LIT_ID_LITIGIO" character varying(10),
    "DESCRIP" character varying(30),
    "STATUS" character varying(10),
    "ASIENTO" bigint,
    "CANT_ASIENTO" integer,
    "CREATION_DATE" timestamp(0) without time zone,
    "ID_APPROLE2" character varying(30),
    "ID_SECUSER2" character varying(30),
    "DT_LAST_UPDATE2" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "IGT_IMPORTE_LOTE" numeric(18,4)
);
 3   DROP TABLE "SLL"."M4SLL_INT_GL_TRX_L_PRUEBA_GABY";
       SLL         heap    SLL    false    4                       1259    24932    M4SLL_INT_LIST_LITIGIOS    TABLE     f   CREATE TABLE "SLL"."M4SLL_INT_LIST_LITIGIOS" (
    "LIT_ID_LITIGIO" character varying(10) NOT NULL
);
 ,   DROP TABLE "SLL"."M4SLL_INT_LIST_LITIGIOS";
       SLL         heap    SLL    false    4                       1259    24941    M4SLL_INT_PAGO_NOM    TABLE     {  CREATE TABLE "SLL"."M4SLL_INT_PAGO_NOM" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PNO_SECUENCIA" bigint NOT NULL,
    "PNO_LOTE" bigint,
    "TPA_ID_PAGO" character varying(3),
    "PNO_VALOR" numeric(18,4),
    "PNO_FECHA" timestamp(0) without time zone,
    "STD_ID_PERSON" character varying(10),
    "STD_ID_LEG_ENT" character varying(9),
    "PNO_PRINCIPAL_S_N" character varying(1),
    "PNO_INTERESES" numeric(18,4),
    "PNO_SALARIO_DIA" numeric(18,4),
    "PNO_COTIZACION" character varying(30),
    "SSP_ID_CABEC_TC1" character varying(15),
    "PNO_CUENTA_ABONO" character varying(30),
    "PNO_CODIGO_IBAN" character varying(30),
    "PNO_OTRAS_CUENTAS" character varying(30),
    "PNO_BENEFICIARIO" character varying(254),
    "IPN_IMPORTE_BRUTO" numeric(18,4),
    "IPN_DESCUENTOS_S_S" numeric(18,4),
    "LIT_NRO_PROCESO" character varying(100),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "STD_OR_HR_PERIOD" bigint,
    "PNO_F_FIN_SANCION" timestamp(0) without time zone,
    "PNO_F_INI_SANCION" timestamp(0) without time zone,
    "PNO_APLICA_SAL_DIA" character varying(1),
    "PNO_F_REINCORP" timestamp(0) without time zone,
    "PNO_ADJ_VIDA_LAB" character varying(1),
    "PNO_F_IMP_HASTA" timestamp(0) without time zone,
    "PNO_F_IMP_DESDE" timestamp(0) without time zone,
    "PNO_RECON_DERECHO" character varying(1),
    "IPN_DESC_IRPF" numeric(18,4),
    "PNO_F_ENV_NOM" timestamp(0) without time zone,
    "IPN_F_TRANSF" timestamp(0) without time zone,
    "IPN_RET_JUDICIAL" numeric(18,4),
    "IPN_IMP_TRANSF" numeric(18,4),
    "PNO_NRO_C_JUZ" character varying(30),
    "PNO_F_VENCIMIENTO" timestamp(0) without time zone,
    "PNO_ANT_RECONOCIDA" timestamp(0) without time zone,
    "PNO_DIAS_SANCIONA" bigint,
    "IPN_APLI_SAN_S_N" character varying(1),
    "IPN_LETRA_JUZGADO" character varying(30),
    "IPN_COD_IBAN_GENE" character varying(30),
    "IPN_NRO_EXP" character varying(30),
    "TPA_NM_PAGO" character varying(254),
    "PNO_NETO_S_N" character varying(1)
);
 '   DROP TABLE "SLL"."M4SLL_INT_PAGO_NOM";
       SLL         heap    SLL    false    4                       1259    24935    M4SLL_INT_PAG_NO_D    TABLE     N  CREATE TABLE "SLL"."M4SLL_INT_PAG_NO_D" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PNO_SECUENCIA" bigint NOT NULL,
    "PND_SECUENCIA" bigint NOT NULL,
    "MCO_ID_CONCEPTO" character varying(10),
    "PND_FECHA_DESDE" timestamp(0) without time zone,
    "PND_FECHA_HASTA" timestamp(0) without time zone,
    "PND_IMPORTE" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MCO_NM_CONCEPTO" character varying(1000)
);
 '   DROP TABLE "SLL"."M4SLL_INT_PAG_NO_D";
       SLL         heap    SLL    false    4                       1259    24959    M4SLL_LITIGIOS    TABLE     �  CREATE TABLE "SLL"."M4SLL_LITIGIOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "MCA_ID_CODIGO_ALTERNO" character varying(3),
    "MRI_ID_RIESGO" character varying(3),
    "MMA_ID_MATERIA" character varying(3),
    "NEG_ID_NEGOCIO" character varying(3),
    "EJS_ID_EST_JUR_SUB" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "LIT_NRO_PROCESO" character varying(100),
    "LIT_DESCRIPCION" character varying(254),
    "LIT_BPO" character varying(254),
    "LIT_FECHA_INICIO" timestamp(0) without time zone,
    "LIT_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "LIT_USR_REGISTRA" character varying(30),
    "LIT_FECHA_PRESENTACION" timestamp(0) without time zone,
    "LIT_HORA_PRESENTACION" timestamp(0) without time zone,
    "LIT_FECHA_CIERRE" timestamp(0) without time zone,
    "LIT_ACUERDO" character varying(1),
    "LIT_RELEVANTE" character varying(1),
    "LIT_HON_CONTADOR" numeric(18,4),
    "LIT_HON_JURIDICO" numeric(18,4),
    "LIT_OBSERVACIONES" character varying(1000),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRE_ID_RECURRENCIA" character varying(3),
    "EJU_ID_EST_JURIDICO" bigint,
    "TFA_ID_TP_FASE" character varying(3),
    "TST_ID_TP_STATUS" character varying(3),
    "TSD_ID_TP_STA_DET" character varying(3),
    "TMO_ID_TP_MOTIVO" character varying(3),
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "LIT_ABOGADO_RESPONSABLE" character varying(30),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_CK_AVAL" character varying(1),
    "LIT_CK_MINUTA" character varying(1),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRC_ID_TP_RECLAMO" character varying(3),
    "TFL_ID_TP_FALTA" character varying(3),
    "LIT_ID_LEGADO" character varying(10),
    "LIT_JUEZ" character varying(60),
    "LIT_PAZ_Y_SVC" character varying(1),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "LIT_DT_ACTUALIZACION" timestamp(0) without time zone,
    "LIT_USER_ACTUALIZACION" character varying(30),
    "LIT_CENTRO_COSTO" character varying(30),
    "LIT_DIVISION" character varying(30),
    "LIT_REGION" character varying(30),
    "LIT_NUMERO_EJECUCION" character varying(30),
    "LIT_VALOR_PED_TOTAL" numeric(18,4),
    "MAB_SECUENCIA" bigint,
    "LIT_UBICACION_FISICA" character varying(254),
    "LIT_SECUENCIA" bigint,
    "LIT_CORPORATIVO_S_N" character varying(1),
    "LIT_SUBROGADO_S_N" character varying(1),
    "LIT_PORCENTAJE_PROBABILIDAD" smallint,
    "LIT_SUSTENTACION" character varying(1000),
    "LIT_FLEX_CONDENA" character varying(254),
    "LIT_FLEX_HONORARIOS" character varying(254),
    "LIT_PREVISION" numeric(14,4),
    "LIT_PROVISION" numeric(18,4),
    "LIT_IMPORTE_TRANSF" numeric(18,4),
    "LIT_DESCUENTOS_S_S_TOTAL" numeric(18,4),
    "LIT_IMPORTE_BRUTO_TOTAL" numeric(18,4),
    "LIT_RETENCION_JUDICIAL_TOTAL" numeric(18,4),
    "LIT_DESCUENTOS_IRPF_TOTAL" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIT_CK_CALC_PROV" character varying(1)
);
 #   DROP TABLE "SLL"."M4SLL_LITIGIOS";
       SLL         heap    SLL    false    4                       1259    24965    M4SLL_LITIGIOS_BKP    TABLE     r	  CREATE TABLE "SLL"."M4SLL_LITIGIOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "NEG_ID_NEGOCIO" character varying(3),
    "EJS_ID_EST_JUR_SUB" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "LIT_NRO_PROCESO" character varying(100),
    "LIT_DESCRIPCION" character varying(254),
    "LIT_BPO" character varying(254),
    "LIT_FECHA_INICIO" timestamp(0) without time zone,
    "LIT_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "LIT_USR_REGISTRA" character varying(30),
    "LIT_FECHA_PRESENTACION" timestamp(0) without time zone,
    "LIT_HORA_PRESENTACION" timestamp(0) without time zone,
    "LIT_FECHA_CIERRE" timestamp(0) without time zone,
    "LIT_ACUERDO" character varying(1),
    "LIT_RELEVANTE" character varying(1),
    "LIT_HON_CONTADOR" numeric(18,4),
    "LIT_HON_JURIDICO" numeric(18,4),
    "LIT_OBSERVACIONES" character varying(1000),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRE_ID_RECURRENCIA" character varying(3),
    "EJU_ID_EST_JURIDICO" character varying(3),
    "TFA_ID_TP_FASE" character varying(3),
    "TST_ID_TP_STATUS" character varying(3),
    "TSD_ID_TP_STA_DET" character varying(3),
    "TMO_ID_TP_MOTIVO" character varying(3),
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "LIT_ABOGADO_RESPONSABLE" character varying(30),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_CK_AVAL" character varying(1),
    "LIT_CK_MINUTA" character varying(1),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRC_ID_TP_RECLAMO" character varying(3),
    "TFL_ID_TP_FALTA" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIT_ID_LEGADO" character varying(10),
    "LIT_JUEZ" character varying(60),
    "LIT_PAZ_Y_SVC" character varying(1),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "LIT_DT_ACTUALIZACION" timestamp(0) without time zone,
    "LIT_USER_ACTUALIZACION" character varying(30),
    "LIT_CENTRO_COSTO" character varying(30),
    "LIT_DIVISION" character varying(30),
    "LIT_REGION" character varying(30),
    "LIT_NUMERO_EJECUCION" character varying(30),
    "LIT_VALOR_PED_TOTAL" numeric(18,4)
);
 '   DROP TABLE "SLL"."M4SLL_LITIGIOS_BKP";
       SLL         heap    SLL    false    4                       1259    24971    M4SLL_LITIGIOS_BKP_COL    TABLE     �  CREATE TABLE "SLL"."M4SLL_LITIGIOS_BKP_COL" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "NEG_ID_NEGOCIO" character varying(3),
    "EJS_ID_EST_JUR_SUB" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "LIT_NRO_PROCESO" character varying(100),
    "LIT_DESCRIPCION" character varying(254),
    "LIT_BPO" character varying(254),
    "LIT_FECHA_INICIO" timestamp(0) without time zone,
    "LIT_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "LIT_USR_REGISTRA" character varying(30),
    "LIT_FECHA_PRESENTACION" timestamp(0) without time zone,
    "LIT_HORA_PRESENTACION" timestamp(0) without time zone,
    "LIT_FECHA_CIERRE" timestamp(0) without time zone,
    "LIT_ACUERDO" character varying(1),
    "LIT_RELEVANTE" character varying(1),
    "LIT_HON_CONTADOR" numeric(18,4),
    "LIT_HON_JURIDICO" numeric(18,4),
    "LIT_OBSERVACIONES" character varying(1000),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRE_ID_RECURRENCIA" character varying(3),
    "EJU_ID_EST_JURIDICO" character varying(3),
    "TFA_ID_TP_FASE" character varying(3),
    "TST_ID_TP_STATUS" character varying(3),
    "TSD_ID_TP_STA_DET" character varying(3),
    "TMO_ID_TP_MOTIVO" character varying(3),
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "LIT_ABOGADO_RESPONSABLE" character varying(30),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_CK_AVAL" character varying(1),
    "LIT_CK_MINUTA" character varying(1),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRC_ID_TP_RECLAMO" character varying(3),
    "TFL_ID_TP_FALTA" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIT_ID_LEGADO" character varying(10),
    "LIT_JUEZ" character varying(60),
    "LIT_PAZ_Y_SVC" character varying(1),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "LIT_DT_ACTUALIZACION" timestamp(0) without time zone,
    "LIT_USER_ACTUALIZACION" character varying(30),
    "LIT_CENTRO_COSTO" character varying(30),
    "LIT_DIVISION" character varying(30),
    "LIT_REGION" character varying(30),
    "LIT_NUMERO_EJECUCION" character varying(30),
    "LIT_VALOR_PED_TOTAL" numeric(18,4),
    "MAB_SECUENCIA" bigint,
    "LIT_UBICACION_FISICA" character varying(254),
    "LIT_SECUENCIA" bigint,
    "LIT_CORPORATIVO_S_N" character varying(1),
    "LIT_SUBROGADO_S_N" character varying(1),
    "MMA_ID_MATERIA" character varying(3),
    "MRI_ID_RIESGO" character varying(3),
    "MCA_ID_CODIGO_ALTERNO" character varying(3),
    "LIT_PORCENTAJE_PROBABILIDAD" smallint,
    "LIT_SUSTENTACION" character varying(1000),
    "LIT_FLEX_CONDENA" character varying(254),
    "LIT_FLEX_HONORARIOS" character varying(254)
);
 +   DROP TABLE "SLL"."M4SLL_LITIGIOS_BKP_COL";
       SLL         heap    SLL    false    4                       1259    24977    M4SLL_LITIGIOS_GGA    TABLE     �  CREATE TABLE "SLL"."M4SLL_LITIGIOS_GGA" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "MCA_ID_CODIGO_ALTERNO" character varying(3),
    "MRI_ID_RIESGO" character varying(3),
    "MMA_ID_MATERIA" character varying(3),
    "NEG_ID_NEGOCIO" character varying(3),
    "EJS_ID_EST_JUR_SUB" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "LIT_NRO_PROCESO" character varying(100),
    "LIT_DESCRIPCION" character varying(254),
    "LIT_BPO" character varying(254),
    "LIT_FECHA_INICIO" timestamp(0) without time zone,
    "LIT_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "LIT_USR_REGISTRA" character varying(30),
    "LIT_FECHA_PRESENTACION" timestamp(0) without time zone,
    "LIT_HORA_PRESENTACION" timestamp(0) without time zone,
    "LIT_FECHA_CIERRE" timestamp(0) without time zone,
    "LIT_ACUERDO" character varying(1),
    "LIT_RELEVANTE" character varying(1),
    "LIT_HON_CONTADOR" numeric(18,4),
    "LIT_HON_JURIDICO" numeric(18,4),
    "LIT_OBSERVACIONES" character varying(1000),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRE_ID_RECURRENCIA" character varying(3),
    "EJU_ID_EST_JURIDICO" bigint,
    "TFA_ID_TP_FASE" character varying(3),
    "TST_ID_TP_STATUS" character varying(3),
    "TSD_ID_TP_STA_DET" character varying(3),
    "TMO_ID_TP_MOTIVO" character varying(3),
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "LIT_ABOGADO_RESPONSABLE" character varying(30),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_CK_AVAL" character varying(1),
    "LIT_CK_MINUTA" character varying(1),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRC_ID_TP_RECLAMO" character varying(3),
    "TFL_ID_TP_FALTA" character varying(3),
    "LIT_ID_LEGADO" character varying(10),
    "LIT_JUEZ" character varying(60),
    "LIT_PAZ_Y_SVC" character varying(1),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "LIT_DT_ACTUALIZACION" timestamp(0) without time zone,
    "LIT_USER_ACTUALIZACION" character varying(30),
    "LIT_CENTRO_COSTO" character varying(30),
    "LIT_DIVISION" character varying(30),
    "LIT_REGION" character varying(30),
    "LIT_NUMERO_EJECUCION" character varying(30),
    "LIT_VALOR_PED_TOTAL" numeric(18,4),
    "MAB_SECUENCIA" bigint,
    "LIT_UBICACION_FISICA" character varying(254),
    "LIT_SECUENCIA" bigint,
    "LIT_CORPORATIVO_S_N" character varying(1),
    "LIT_SUBROGADO_S_N" character varying(1),
    "LIT_PORCENTAJE_PROBABILIDAD" smallint,
    "LIT_SUSTENTACION" character varying(1000),
    "LIT_FLEX_CONDENA" character varying(254),
    "LIT_FLEX_HONORARIOS" character varying(254),
    "LIT_PREVISION" numeric(14,4),
    "LIT_PROVISION" numeric(18,4),
    "LIT_IMPORTE_TRANSF" numeric(18,4),
    "LIT_DESCUENTOS_S_S_TOTAL" numeric(18,4),
    "LIT_IMPORTE_BRUTO_TOTAL" numeric(18,4),
    "LIT_RETENCION_JUDICIAL_TOTAL" numeric(18,4),
    "LIT_DESCUENTOS_IRPF_TOTAL" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_LITIGIOS_GGA";
       SLL         heap    SLL    false    4                       1259    24983    M4SLL_LITIGIOS_HIS    TABLE     �  CREATE TABLE "SLL"."M4SLL_LITIGIOS_HIS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "LIH_SECUENCIA" bigint NOT NULL,
    "LIH_COLUM_ALTERADA" character varying(30),
    "LIH_FECHA_ALTERADA" timestamp(0) without time zone,
    "LIH_ID_OLD" character varying(3),
    "LIH_ID_NUEVO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_LITIGIOS_HIS";
       SLL         heap    SLL    false    4                       1259    24986    M4SLL_LITIGIOS_PRUEBA_GABY    TABLE     �  CREATE TABLE "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "MCA_ID_CODIGO_ALTERNO" character varying(3),
    "MRI_ID_RIESGO" character varying(3),
    "MMA_ID_MATERIA" character varying(3),
    "NEG_ID_NEGOCIO" character varying(3),
    "EJS_ID_EST_JUR_SUB" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "LIT_NRO_PROCESO" character varying(100),
    "LIT_DESCRIPCION" character varying(254),
    "LIT_BPO" character varying(254),
    "LIT_FECHA_INICIO" timestamp(0) without time zone,
    "LIT_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "LIT_USR_REGISTRA" character varying(30),
    "LIT_FECHA_PRESENTACION" timestamp(0) without time zone,
    "LIT_HORA_PRESENTACION" timestamp(0) without time zone,
    "LIT_FECHA_CIERRE" timestamp(0) without time zone,
    "LIT_ACUERDO" character varying(1),
    "LIT_RELEVANTE" character varying(1),
    "LIT_HON_CONTADOR" numeric(18,4),
    "LIT_HON_JURIDICO" numeric(18,4),
    "LIT_OBSERVACIONES" character varying(1000),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRE_ID_RECURRENCIA" character varying(3),
    "EJU_ID_EST_JURIDICO" bigint,
    "TFA_ID_TP_FASE" character varying(3),
    "TST_ID_TP_STATUS" character varying(3),
    "TSD_ID_TP_STA_DET" character varying(3),
    "TMO_ID_TP_MOTIVO" character varying(3),
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "LIT_ABOGADO_RESPONSABLE" character varying(30),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_CK_AVAL" character varying(1),
    "LIT_CK_MINUTA" character varying(1),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRC_ID_TP_RECLAMO" character varying(3),
    "TFL_ID_TP_FALTA" character varying(3),
    "LIT_ID_LEGADO" character varying(10),
    "LIT_JUEZ" character varying(60),
    "LIT_PAZ_Y_SVC" character varying(1),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "LIT_DT_ACTUALIZACION" timestamp(0) without time zone,
    "LIT_USER_ACTUALIZACION" character varying(30),
    "LIT_CENTRO_COSTO" character varying(30),
    "LIT_DIVISION" character varying(30),
    "LIT_REGION" character varying(30),
    "LIT_NUMERO_EJECUCION" character varying(30),
    "LIT_VALOR_PED_TOTAL" numeric(18,4),
    "MAB_SECUENCIA" bigint,
    "LIT_UBICACION_FISICA" character varying(254),
    "LIT_SECUENCIA" bigint,
    "LIT_CORPORATIVO_S_N" character varying(1),
    "LIT_SUBROGADO_S_N" character varying(1),
    "LIT_PORCENTAJE_PROBABILIDAD" smallint,
    "LIT_SUSTENTACION" character varying(1000),
    "LIT_FLEX_CONDENA" character varying(254),
    "LIT_FLEX_HONORARIOS" character varying(254),
    "LIT_PREVISION" numeric(14,4),
    "LIT_PROVISION" numeric(18,4),
    "LIT_IMPORTE_TRANSF" numeric(18,4),
    "LIT_DESCUENTOS_S_S_TOTAL" numeric(18,4),
    "LIT_IMPORTE_BRUTO_TOTAL" numeric(18,4),
    "LIT_RETENCION_JUDICIAL_TOTAL" numeric(18,4),
    "LIT_DESCUENTOS_IRPF_TOTAL" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIT_PORC_PROVISION" numeric(8,4)
);
 /   DROP TABLE "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY";
       SLL         heap    SLL    false    4                       1259    24992    M4SLL_LITIGOS_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_LITIGOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "NEG_ID_NEGOCIO" character varying(3),
    "EJS_ID_EST_JUR_SUB" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "LIT_NRO_PROCESO" character varying(100),
    "LIT_DESCRIPCION" character varying(254),
    "LIT_BPO" character varying(254),
    "LIT_FECHA_INICIO" timestamp(0) without time zone,
    "LIT_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "LIT_USR_REGISTRA" character varying(30),
    "LIT_FECHA_PRESENTACION" timestamp(0) without time zone,
    "LIT_HORA_PRESENTACION" timestamp(0) without time zone,
    "LIT_FECHA_CIERRE" timestamp(0) without time zone,
    "LIT_ACUERDO" character varying(1),
    "LIT_RELEVANTE" character varying(1),
    "LIT_HON_CONTADOR" numeric(18,4),
    "LIT_HON_JURIDICO" numeric(18,4),
    "LIT_OBSERVACIONES" character varying(1000),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRE_ID_RECURRENCIA" character varying(3),
    "EJU_ID_EST_JURIDICO" character varying(3),
    "TFA_ID_TP_FASE" character varying(3),
    "TST_ID_TP_STATUS" character varying(3),
    "TSD_ID_TP_STA_DET" character varying(3),
    "TMO_ID_TP_MOTIVO" character varying(3),
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "LIT_ABOGADO_RESPONSABLE" character varying(30),
    "LIT_VALOR_TOTAL" numeric(18,4),
    "LIT_CK_AVAL" character varying(1),
    "LIT_CK_MINUTA" character varying(1),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRC_ID_TP_RECLAMO" character varying(3),
    "TFL_ID_TP_FALTA" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIT_ID_LEGADO" character varying(10),
    "LIT_JUEZ" character varying(60),
    "LIT_PAZ_Y_SVC" character varying(1)
);
 &   DROP TABLE "SLL"."M4SLL_LITIGOS_BKP";
       SLL         heap    SLL    false    4                       1259    24947    M4SLL_LIT_HECHOS    TABLE     a  CREATE TABLE "SLL"."M4SLL_LIT_HECHOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "LIH_SECUENCIA" bigint NOT NULL,
    "LIH_HECHO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIH_DT_INICIAL" timestamp(0) without time zone,
    "LIH_DT_FINAL" timestamp(0) without time zone,
    "LIH_SALARIO_PERIODO" numeric(14,4),
    "LIH_CK_AFILIACION_SINDICATO" character varying(1),
    "LIH_DESC_SINDICATO" character varying(254)
);
 %   DROP TABLE "SLL"."M4SLL_LIT_HECHOS";
       SLL         heap    SLL    false    4                       1259    24953    M4SLL_LIT_HECHOS_BKP    TABLE     J  CREATE TABLE "SLL"."M4SLL_LIT_HECHOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "LIH_SECUENCIA" bigint,
    "LIH_HECHO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIH_DT_INICIAL" timestamp(0) without time zone,
    "LIH_DT_FINAL" timestamp(0) without time zone,
    "LIH_SALARIO_PERIODO" numeric(14,4),
    "LIH_CK_AFILIACION_SINDICATO" character varying(1),
    "LIH_DESC_SINDICATO" character varying(254)
);
 )   DROP TABLE "SLL"."M4SLL_LIT_HECHOS_BKP";
       SLL         heap    SLL    false    4                        1259    24998    M4SLL_LIT_SEGUIMIE    TABLE     �  CREATE TABLE "SLL"."M4SLL_LIT_SEGUIMIE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "LIS_SECUENCIA" bigint NOT NULL,
    "LIS_SEGUIMIENTO" character varying(1000),
    "STD_ID_PERSON" character varying(10),
    "LIS_FECHA" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_LIT_SEGUIMIE";
       SLL         heap    SLL    false    4            !           1259    25004    M4SLL_LIT_VINCULAD    TABLE     �  CREATE TABLE "SLL"."M4SLL_LIT_VINCULAD" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "LIV_SECUENCIA" bigint NOT NULL,
    "LIV_ID_LITIGIO" character varying(10),
    "LIV_OBSERVACION" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_LIT_VINCULAD";
       SLL         heap    SLL    false    4            '           1259    25025    M4SLL_MATRIZ_PREDI    TABLE     �  CREATE TABLE "SLL"."M4SLL_MATRIZ_PREDI" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MPR_ANIO" character varying(4) NOT NULL,
    "MPR_MES" character varying(2) NOT NULL,
    "TPL_ID_TP_LITIGIO" character varying(3) NOT NULL,
    "TPE_ID_PEDIDO" character varying(3) NOT NULL,
    "NEG_ID_NEGOCIO" character varying(3),
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "EDE_ID_DELEGACION" character varying(3),
    "EDE_ZONA_RRLL" character varying(3),
    "MPR_VALOR_TOTAL" numeric(14,4),
    "MPR_VALOR_PED_TOTAL" numeric(14,4),
    "MPR_CANTIDAD_EXPEDIENTE" bigint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_MATRIZ_PREDI";
       SLL         heap    SLL    false    4            "           1259    25010    M4SLL_MATRIZ_PRE_C    TABLE       CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_C" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MPC_SECUENCIA" bigint NOT NULL,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPE_ID_PEDIDO" character varying(3),
    "NEG_ID_NEGOCIO" character varying(3),
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "EDE_ID_DELEGACION" character varying(3),
    "EDE_ZONA_RRLL" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_C";
       SLL         heap    SLL    false    4            #           1259    25013    M4SLL_MATRIZ_PRE_C_BKP    TABLE       CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_C_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "MPC_SECUENCIA" bigint,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPE_ID_PEDIDO" character varying(3),
    "NEG_ID_NEGOCIO" character varying(3),
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "EDE_ID_DELEGACION" character varying(3),
    "EDE_ZONA_RRLL" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 +   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_C_BKP";
       SLL         heap    SLL    false    4            $           1259    25016    M4SLL_MATRIZ_PRE_C_PRUEBA_GABY    TABLE     !  CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MPC_SECUENCIA" bigint NOT NULL,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPE_ID_PEDIDO" character varying(3),
    "NEG_ID_NEGOCIO" character varying(3),
    "MTE_ID_TP_EMPLEADO" character varying(3),
    "EDE_ID_DELEGACION" character varying(3),
    "EDE_ZONA_RRLL" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 3   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY";
       SLL         heap    SLL    false    4            %           1259    25019    M4SLL_MATRIZ_PRE_D    TABLE     �  CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_D" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MPD_ANIO" character varying(4) NOT NULL,
    "MPD_MES" character varying(2) NOT NULL,
    "MPC_SECUENCIA" bigint NOT NULL,
    "MPD_VALOR_TOTAL" numeric(14,4),
    "MPD_VALOR_PED_TOTAL" numeric(14,4),
    "MPD_CANTIDAD_EXPEDIENTE" bigint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_D";
       SLL         heap    SLL    false    4            &           1259    25022    M4SLL_MATRIZ_PRE_D_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_D_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "MPD_ANIO" character varying(4),
    "MPD_MES" character varying(2),
    "MPC_SECUENCIA" bigint,
    "MPD_VALOR_TOTAL" numeric(14,4),
    "MPD_VALOR_PED_TOTAL" numeric(14,4),
    "MPD_CANTIDAD_EXPEDIENTE" bigint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 +   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_D_BKP";
       SLL         heap    SLL    false    4            (           1259    25028    M4SLL_MATRIZ_PRE_D_PRUEBA_GABY    TABLE     �  CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4),
    "MPD_ANIO" character varying(4),
    "MPD_MES" character varying(2),
    "MPC_SECUENCIA" bigint,
    "MPD_VALOR_TOTAL" numeric(14,4),
    "MPD_VALOR_PED_TOTAL" numeric(14,4),
    "MPD_CANTIDAD_EXPEDIENTE" bigint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 3   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY";
       SLL         heap    SLL    false    4            )           1259    25031    M4SLL_MATRIZ_PRE_PARAM    TABLE     �   CREATE TABLE "SLL"."M4SLL_MATRIZ_PRE_PARAM" (
    "MPP_ID_ORDEN" smallint NOT NULL,
    "MPP_PARAM_CAMPO" character varying(50),
    "MPP_CAMPO_DESAGRUPAR" character varying(100),
    "MPP_WHERE" character varying(2000)
);
 +   DROP TABLE "SLL"."M4SLL_MATRIZ_PRE_PARAM";
       SLL         heap    SLL    false    4            *           1259    25037    M4SLL_MEDIO_PAGOS    TABLE     H  CREATE TABLE "SLL"."M4SLL_MEDIO_PAGOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MEP_ID_MEDIO_PAGO" character varying(3) NOT NULL,
    "MEP_NM_MEDIO_PAGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MEP_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MEP_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_MEDIO_PAGOS";
       SLL         heap    SLL    false    4            +           1259    25042    M4SLL_MODULO_ROL    TABLE     �  CREATE TABLE "SLL"."M4SLL_MODULO_ROL" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MOR_SECUENCIA" bigint NOT NULL,
    "MTM_ID_MODULO" bigint,
    "MRA_ID_ROL_ACTOR" bigint,
    "MOR_CAMPO" character varying(254),
    "MOR_TABLA" character varying(254),
    "MOR_FUNCION" character varying(3),
    "MOR_ESTADO" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_MODULO_ROL";
       SLL         heap    SLL    false    4            .           1259    25061    M4SLL_MTO_COD_ALT    TABLE     P  CREATE TABLE "SLL"."M4SLL_MTO_COD_ALT" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MCA_ID_CODIGO_ALTERNO" character varying(3) NOT NULL,
    "MCA_NM_CODIGO_ALTERNO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MCA_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MCA_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_MTO_COD_ALT";
       SLL         heap    SLL    false    4            /           1259    25066    M4SLL_MTO_COD_ALT_BKP    TABLE     F  CREATE TABLE "SLL"."M4SLL_MTO_COD_ALT_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "MCA_ID_CODIGO_ALTERNO" character varying(3),
    "MCA_NM_CODIGO_ALTERNO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_MTO_COD_ALT_BKP";
       SLL         heap    SLL    false    4            0           1259    25069    M4SLL_MTO_CONCEPTO    TABLE     K  CREATE TABLE "SLL"."M4SLL_MTO_CONCEPTO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MCO_ID_CONCEPTO" character varying(10) NOT NULL,
    "MCO_NM_CONCEPTO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_MTO_CONCEPTO";
       SLL         heap    SLL    false    4            1           1259    25075    M4SLL_MTO_DET_PROV    TABLE     �  CREATE TABLE "SLL"."M4SLL_MTO_DET_PROV" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MDP_ID_DET_PROVISION" character varying(3) NOT NULL,
    "MDP_NM_DET_PROVISION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MDP_CUENTA_DEBE" character varying(30),
    "MDP_CUENTA_HABER" character varying(30),
    "MDP_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MDP_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_MTO_DET_PROV";
       SLL         heap    SLL    false    4            2           1259    25080    M4SLL_MTO_DET_PROV_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_MTO_DET_PROV_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "MDP_ID_DET_PROVISION" character varying(3),
    "MDP_NM_DET_PROVISION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MDP_CUENTA_DEBE" character varying(30),
    "MDP_CUENTA_HABER" character varying(30)
);
 +   DROP TABLE "SLL"."M4SLL_MTO_DET_PROV_BKP";
       SLL         heap    SLL    false    4            3           1259    25083    M4SLL_MTO_EMP_ORG    TABLE     B  CREATE TABLE "SLL"."M4SLL_MTO_EMP_ORG" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "STD_ID_LEG_ENT" character varying(9) NOT NULL,
    "ORG_ID" character varying(13) NOT NULL,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MEO_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MEO_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_MTO_EMP_ORG";
       SLL         heap    SLL    false    4            4           1259    25088    M4SLL_MTO_ESTADOS    TABLE     B  CREATE TABLE "SLL"."M4SLL_MTO_ESTADOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MOR_ESTADO" character varying(1) NOT NULL,
    "MTE_NM_ESTADO" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_MTO_ESTADOS";
       SLL         heap    SLL    false    4            5           1259    25094    M4SLL_MTO_EST_EJE    TABLE     R  CREATE TABLE "SLL"."M4SLL_MTO_EST_EJE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MEE_ID_EST_EJECUCION" character varying(3) NOT NULL,
    "MEE_NM_EST_EJECUCION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_MTO_EST_EJE";
       SLL         heap    SLL    false    4            6           1259    25097    M4SLL_MTO_EST_TARE    TABLE     K  CREATE TABLE "SLL"."M4SLL_MTO_EST_TARE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MET_ID_EST_TAREA" character varying(3) NOT NULL,
    "MET_NM_EST_TAREA" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_MTO_EST_TARE";
       SLL         heap    SLL    false    4            7           1259    25100    M4SLL_MTO_FUNCION    TABLE     D  CREATE TABLE "SLL"."M4SLL_MTO_FUNCION" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MOR_FUNCION" character varying(3) NOT NULL,
    "MTF_NM_FUNCION" character varying(2000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_MTO_FUNCION";
       SLL         heap    SLL    false    4            8           1259    25106    M4SLL_MTO_MATERIA    TABLE     B  CREATE TABLE "SLL"."M4SLL_MTO_MATERIA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MMA_ID_MATERIA" character varying(3) NOT NULL,
    "MMA_NM_MATERIA" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MMA_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MMA_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_MTO_MATERIA";
       SLL         heap    SLL    false    4            9           1259    25111    M4SLL_MTO_MODULOS    TABLE     U  CREATE TABLE "SLL"."M4SLL_MTO_MODULOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MTM_ID_MODULO" bigint NOT NULL,
    "MTM_NM_MODULO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MTM_ID_MOD_PADRE" bigint
);
 &   DROP TABLE "SLL"."M4SLL_MTO_MODULOS";
       SLL         heap    SLL    false    4            :           1259    25114    M4SLL_MTO_PEDIDO_D    TABLE     �  CREATE TABLE "SLL"."M4SLL_MTO_PEDIDO_D" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MPD_ID_PEDIDO_DETALLE" character varying(3) NOT NULL,
    "MPD_NM_PEDIDO_DETALLE" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "MPD_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MPD_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MPD_PAGO_NOMINA_DET_S_N" character varying(1)
);
 '   DROP TABLE "SLL"."M4SLL_MTO_PEDIDO_D";
       SLL         heap    SLL    false    4            ;           1259    25119    M4SLL_MTO_RIESGOS    TABLE     @  CREATE TABLE "SLL"."M4SLL_MTO_RIESGOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MRI_ID_RIESGO" character varying(3) NOT NULL,
    "MRI_NM_RIESGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MRI_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MRI_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_MTO_RIESGOS";
       SLL         heap    SLL    false    4            <           1259    25124    M4SLL_MTO_RIESGOS_BKP    TABLE     6  CREATE TABLE "SLL"."M4SLL_MTO_RIESGOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "MRI_ID_RIESGO" character varying(3),
    "MRI_NM_RIESGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_MTO_RIESGOS_BKP";
       SLL         heap    SLL    false    4            =           1259    25127    M4SLL_MTO_ROL_ACTO    TABLE     =  CREATE TABLE "SLL"."M4SLL_MTO_ROL_ACTO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MRA_ID_ROL_ACTOR" bigint NOT NULL,
    "MRA_NM_ROL_ACTOR" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_MTO_ROL_ACTO";
       SLL         heap    SLL    false    4            >           1259    25130    M4SLL_MTO_SEG_INTE    TABLE     7  CREATE TABLE "SLL"."M4SLL_MTO_SEG_INTE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ID_APP_ROLE" character varying(30) NOT NULL,
    "MSI_SECUENCIA" bigint NOT NULL,
    "MSI_DT_START" timestamp(0) without time zone,
    "MSI_DT_END" timestamp(0) without time zone,
    "MSI_COLUMNA" character varying(254),
    "MSI_TABLA" character varying(254),
    "MSI_VALOR" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MTM_ID_MODULO" bigint
);
 '   DROP TABLE "SLL"."M4SLL_MTO_SEG_INTE";
       SLL         heap    SLL    false    4            ?           1259    25136    M4SLL_MTO_TAR_CIE    TABLE     v  CREATE TABLE "SLL"."M4SLL_MTO_TAR_CIE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MTC_ID_TAREA" character varying(3) NOT NULL,
    "MTC_NM_TAREA" character varying(254),
    "MTC_NM_PROCEDIMIENTO" character varying(2000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_MTO_TAR_CIE";
       SLL         heap    SLL    false    4            @           1259    25142    M4SLL_MTO_TP_EMPLE    TABLE     K  CREATE TABLE "SLL"."M4SLL_MTO_TP_EMPLE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MTE_ID_TP_EMPLEADO" character varying(3) NOT NULL,
    "MTE_NM_TP_EMPLEADO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MTE_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MTE_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_MTO_TP_EMPLE";
       SLL         heap    SLL    false    4            ,           1259    25048    M4SLL_MT_ABOGADOS    TABLE     :  CREATE TABLE "SLL"."M4SLL_MT_ABOGADOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MAB_SECUENCIA" bigint NOT NULL,
    "MAB_NOMBRE" character varying(255),
    "MAB_APELLIDO" character varying(255),
    "MAB_EMAIL" character varying(255),
    "MAB_CHK_INT" character varying(1),
    "STD_ID_PERSON" character varying(10),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "MAB_DT_END" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MAB_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MAB_N_CEDULA" character varying(100),
    "MAB_N_TARJ_PROF" character varying(100),
    "MAB_TELEFONO" character varying(50),
    "MAB_CELULAR" character varying(50),
    "MAB_DOMICILIO" character varying(254),
    "MAB_EMPRESA" character varying(254),
    "MAB_NIT" character varying(100),
    "MAB_DT_INICIO_CONTRATO" timestamp(0) without time zone,
    "MAB_DT_FIN_CONTRATO" timestamp(0) without time zone,
    "MAB_TIPO_VINCULACION" character varying(254),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "STD_ID_GEO_PLACE" character varying(9)
);
 &   DROP TABLE "SLL"."M4SLL_MT_ABOGADOS";
       SLL         heap    SLL    false    4            -           1259    25055    M4SLL_MT_ABOGADOS_BKP    TABLE       CREATE TABLE "SLL"."M4SLL_MT_ABOGADOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "MAB_SECUENCIA" bigint,
    "MAB_NOMBRE" character varying(255),
    "MAB_APELLIDO" character varying(255),
    "MAB_EMAIL" character varying(255),
    "MAB_CHK_INT" character varying(1),
    "STD_ID_PERSON" character varying(10),
    "EDE_ID_DELEGACION" character varying(3),
    "ECI_ID_CIUDAD" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "MAB_DT_END" timestamp(0) without time zone,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_MT_ABOGADOS_BKP";
       SLL         heap    SLL    false    4            A           1259    25147    M4SLL_MT_ST_RE_PRO    TABLE     Q  CREATE TABLE "SLL"."M4SLL_MT_ST_RE_PRO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MSR_ID_STATUS_REPORTE" character varying(3) NOT NULL,
    "MSR_NM_STATUS_REPORTE" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MSR_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "MSR_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_MT_ST_RE_PRO";
       SLL         heap    SLL    false    4            B           1259    25152    M4SLL_NEGOCIOS    TABLE     �  CREATE TABLE "SLL"."M4SLL_NEGOCIOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "NEG_ID_NEGOCIO" character varying(3) NOT NULL,
    "NEG_NM_NEGOCIO" character varying(254),
    "LIT_CENTRO_COSTO" character varying(30),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "NEG_DIVISION" character varying(4)
);
 #   DROP TABLE "SLL"."M4SLL_NEGOCIOS";
       SLL         heap    SLL    false    4            C           1259    25155    M4SLL_NEGOCIOS_BKP    TABLE     c  CREATE TABLE "SLL"."M4SLL_NEGOCIOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "NEG_ID_NEGOCIO" character varying(3),
    "NEG_NM_NEGOCIO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "LIT_CENTRO_COSTO" character varying(30)
);
 '   DROP TABLE "SLL"."M4SLL_NEGOCIOS_BKP";
       SLL         heap    SLL    false    4            D           1259    25158    M4SLL_NEGOCIOS_PRUEBA_GABY    TABLE     }  CREATE TABLE "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "NEG_ID_NEGOCIO" character varying(3) NOT NULL,
    "NEG_NM_NEGOCIO" character varying(254),
    "LIT_CENTRO_COSTO" character varying(30),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 /   DROP TABLE "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY";
       SLL         heap    SLL    false    4            E           1259    25161    M4SLL_NEGOCIOS_ROL    TABLE     �  CREATE TABLE "SLL"."M4SLL_NEGOCIOS_ROL" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "NEG_ID_NEGOCIO" character varying(3) NOT NULL,
    "ID_APP_ROLE" character varying(50) NOT NULL,
    "SNR_CHK_SELECT" character varying(1),
    "SNR_CHK_INSERT" character varying(1),
    "SNR_CHK_UPDATE" character varying(1),
    "SNR_CHK_DELETE" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_NEGOCIOS_ROL";
       SLL         heap    SLL    false    4            F           1259    25164    M4SLL_PAGOS    TABLE       CREATE TABLE "SLL"."M4SLL_PAGOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PAG_SECUENCIA" bigint NOT NULL,
    "TSP_ID_SALIDA_PAGO" character varying(3),
    "DCP_SECUENCIA" bigint,
    "MEP_ID_MEDIO_PAGO" character varying(3),
    "STP_ID_STATUS_PAGO" character varying(3),
    "TPA_ID_PAGO" character varying(3),
    "PAG_VALOR" numeric(18,2),
    "PAG_FEC_EST" timestamp(0) without time zone,
    "PAG_FEC_VTO" timestamp(0) without time zone,
    "PAG_FEC_APR" timestamp(0) without time zone,
    "PAG_FEC_ERP" timestamp(0) without time zone,
    "PAG_FEC_PAG" timestamp(0) without time zone,
    "PAG_DESCRIPCION" character varying(1000),
    "PAG_DOCUMENTO" character varying(254),
    "PAG_COMBINACION" character varying(254),
    "PAG_CK_COMB" bigint,
    "PAG_CK_RECUPERADO" character varying(1),
    "PAG_CK_SOLICITADO" character varying(1),
    "PAG_FECHA" timestamp(0) without time zone,
    "PAG_COMPROBANTE" character varying(2000),
    "PAG_NRO_IDENTIFICACION" character varying(254),
    "PAG_TIPO_CUENTA_DESTNO" character varying(254),
    "PAG_NRO_CUENTA_DESTINO" character varying(254),
    "PAG_DESTINATARIO" character varying(2000),
    "PAG_EMAIL_DESTINATARIO" character varying(254),
    "PAG_NRO_SOLICITUD" bigint,
    "PAG_CODIGO_IBAN" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "PAG_DESCRIPCION_DOC" character varying(1000)
);
     DROP TABLE "SLL"."M4SLL_PAGOS";
       SLL         heap    SLL    false    4            G           1259    25170    M4SLL_PAGOS_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_PAGOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "LIT_ID_LITIGIO" character varying(10),
    "PAG_SECUENCIA" bigint,
    "TSP_ID_SALIDA_PAGO" character varying(3),
    "DCP_SECUENCIA" bigint,
    "MEP_ID_MEDIO_PAGO" character varying(3),
    "STP_ID_STATUS_PAGO" character varying(3),
    "TPA_ID_PAGO" character varying(3),
    "PAG_VALOR" numeric(18,2),
    "PAG_FEC_EST" timestamp(0) without time zone,
    "PAG_FEC_VTO" timestamp(0) without time zone,
    "PAG_FEC_APR" timestamp(0) without time zone,
    "PAG_FEC_ERP" timestamp(0) without time zone,
    "PAG_FEC_PAG" timestamp(0) without time zone,
    "PAG_DESCRIPCION" character varying(1000),
    "PAG_DOCUMENTO" character varying(254),
    "PAG_COMBINACION" character varying(254),
    "PAG_CK_COMB" bigint,
    "PAG_CK_RECUPERADO" character varying(1),
    "PAG_CK_SOLICITADO" character varying(1),
    "PAG_FECHA" timestamp(0) without time zone,
    "PAG_COMPROBANTE" character varying(2000),
    "PAG_NRO_IDENTIFICACION" character varying(254),
    "PAG_TIPO_CUENTA_DESTNO" character varying(254),
    "PAG_NRO_CUENTA_DESTINO" character varying(254),
    "PAG_DESTINATARIO" character varying(2000),
    "PAG_EMAIL_DESTINATARIO" character varying(254),
    "PAG_NRO_SOLICITUD" bigint,
    "PAG_CODIGO_IBAN" character varying(254),
    "PAG_DESCRIPCION_DOC" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 $   DROP TABLE "SLL"."M4SLL_PAGOS_BKP";
       SLL         heap    SLL    false    4            I           1259    25182    M4SLL_PAGOS_NOMINA    TABLE     :  CREATE TABLE "SLL"."M4SLL_PAGOS_NOMINA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PNO_SECUENCIA" bigint NOT NULL,
    "PNO_LOTE" bigint,
    "TPA_ID_PAGO" character varying(3),
    "PNO_VALOR" numeric(18,4),
    "PNO_FECHA" timestamp(0) without time zone,
    "PNO_FECHA_VENCIMIENTO" timestamp(0) without time zone,
    "PNO_PRINCIPAL_S_N" character varying(1),
    "PNO_INTERESES" numeric(18,4),
    "PNO_ANTIGUEDAD_RECONOCIDA" timestamp(0) without time zone,
    "PNO_FECHA_IMPUTACION_DESDE" timestamp(0) without time zone,
    "PNO_FECHA_IMPUTACION_HASTA" timestamp(0) without time zone,
    "PNO_ADJUNTA_VIDA_LABORAL" character varying(1),
    "PNO_FECHA_REINCORPORACION" timestamp(0) without time zone,
    "PNO_APLICA_SAL_DIA_HASTA_RES_R" character varying(1),
    "PNO_SALARIO_DIA" numeric(18,4),
    "PNO_FECHA_INICIO_SANCION" timestamp(0) without time zone,
    "PNO_FECHA_FIN_SANCION" timestamp(0) without time zone,
    "PNO_DIAS_SANCIONADO" bigint,
    "PNO_COTIZACION" character varying(30),
    "SSP_ID_CABEC_TC1" character varying(15),
    "PNO_RECONOCIMIENTO_DERECHO" character varying(1),
    "PNO_CUENTA_ABONO" character varying(30),
    "PNO_CODIGO_IBAN" character varying(30),
    "PNO_OTRAS_CUENTAS" character varying(30),
    "PNO_NRO_CUENTA_JUZGADO" character varying(30),
    "PNO_BENEFICIARIO" character varying(254),
    "IPN_IMPORTE_TRANSFERIDO" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "IPN_RETENCION_JUDICIAL" numeric(18,4),
    "IPN_IMPORTE_BRUTO" numeric(18,4),
    "IPN_DESCUENTOS_S_S" numeric(18,4),
    "IPN_DESCUENTOS_IRPF" numeric(18,4),
    "IPN_FECHA_TRANSFERENCIA" timestamp(0) without time zone,
    "PNO_FECHA_ENVIO_NOMINA" timestamp(0) without time zone,
    "PNO_APLI_SANCION_S_N" character varying(1),
    "PNO_LETRA_JUZGADO" character varying(30),
    "PNO_COD_IBAN_GENE" character varying(30),
    "PNO_NRO_EXP" character varying(30),
    "PNO_NETO_S_N" character varying(1)
);
 '   DROP TABLE "SLL"."M4SLL_PAGOS_NOMINA";
       SLL         heap    SLL    false    4            H           1259    25176    M4SLL_PAGOS_NOM_D    TABLE     M  CREATE TABLE "SLL"."M4SLL_PAGOS_NOM_D" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PNO_SECUENCIA" bigint NOT NULL,
    "PND_SECUENCIA" bigint NOT NULL,
    "MCO_ID_CONCEPTO" character varying(10),
    "PND_FECHA_DESDE" timestamp(0) without time zone,
    "PND_FECHA_HASTA" timestamp(0) without time zone,
    "PND_IMPORTE" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "MCO_NM_CONCEPTO" character varying(1000)
);
 &   DROP TABLE "SLL"."M4SLL_PAGOS_NOM_D";
       SLL         heap    SLL    false    4            J           1259    25188    M4SLL_PAGOS_TRN    TABLE     �  CREATE TABLE "SLL"."M4SLL_PAGOS_TRN" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PAG_SECUENCIA" bigint NOT NULL,
    "STP_ID_STATUS_PAGO" character varying(3),
    "NROCBTE" character varying(30),
    "NRODOC" character varying(30),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 $   DROP TABLE "SLL"."M4SLL_PAGOS_TRN";
       SLL         heap    SLL    false    4            K           1259    25191    M4SLL_PARAMETRICA    TABLE     �  CREATE TABLE "SLL"."M4SLL_PARAMETRICA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "PAR_SECUENCIA" bigint NOT NULL,
    "PAR_NM_CORTO" character varying(10),
    "PAR_NM_LARGO" character varying(2000),
    "PAR_VAL_NUMBER" bigint,
    "PAR_VAL_DATE" timestamp(0) without time zone,
    "PAR_VAL_CHAR" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_PARAMETRICA";
       SLL         heap    SLL    false    4            L           1259    25197    M4SLL_PARAM_USR    TABLE       CREATE TABLE "SLL"."M4SLL_PARAM_USR" (
    "USUARIO" character varying(30) NOT NULL,
    "PAGINA" double precision,
    "FILTRO" character varying(1000),
    "JSON" character varying(1000),
    "CONSULTA" text,
    "ACCION" character varying(100) NOT NULL
);
 $   DROP TABLE "SLL"."M4SLL_PARAM_USR";
       SLL         heap    SLL    false    4            N           1259    25209    M4SLL_PEDIDOS    TABLE     f  CREATE TABLE "SLL"."M4SLL_PEDIDOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPE_ID_PEDIDO" character varying(3) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PED_SECUENCIA" bigint,
    "PED_VALOR" numeric(18,4),
    "PED_OBSERVACION" character varying(254),
    "PED_SUB_PEDIDO" character varying(254),
    "PED_PRINCIPAL_S_N" character varying(1),
    "PED_PERIODO" timestamp(0) without time zone,
    "PED_VALOR_RECARGO" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 "   DROP TABLE "SLL"."M4SLL_PEDIDOS";
       SLL         heap    SLL    false    4            O           1259    25215    M4SLL_PEDIDOS_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_PEDIDOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPE_ID_PEDIDO" character varying(3),
    "LIT_ID_LITIGIO" character varying(10),
    "PED_SECUENCIA" bigint,
    "PED_VALOR" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "PED_OBSERVACION" character varying(254),
    "PED_SUB_PEDIDO" character varying(254),
    "PED_PRINCIPAL_S_N" character varying(1)
);
 &   DROP TABLE "SLL"."M4SLL_PEDIDOS_BKP";
       SLL         heap    SLL    false    4            P           1259    25221    M4SLL_PEDIDOS_PRUEBA_GABY    TABLE     r  CREATE TABLE "SLL"."M4SLL_PEDIDOS_PRUEBA_GABY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPE_ID_PEDIDO" character varying(3) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "PED_SECUENCIA" bigint,
    "PED_VALOR" numeric(18,4),
    "PED_OBSERVACION" character varying(254),
    "PED_SUB_PEDIDO" character varying(254),
    "PED_PRINCIPAL_S_N" character varying(1),
    "PED_PERIODO" timestamp(0) without time zone,
    "PED_VALOR_RECARGO" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 .   DROP TABLE "SLL"."M4SLL_PEDIDOS_PRUEBA_GABY";
       SLL         heap    SLL    false    4            M           1259    25203    M4SLL_PEDIDO_DET    TABLE     �  CREATE TABLE "SLL"."M4SLL_PEDIDO_DET" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TPE_ID_PEDIDO" character varying(3) NOT NULL,
    "PDE_SECUENCIA" bigint NOT NULL,
    "MPD_ID_PEDIDO_DETALLE" character varying(3),
    "PDE_OBSERRVACION" character varying(2000),
    "CLO_ID_CLIENTE" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_PEDIDO_DET";
       SLL         heap    SLL    false    4            Q           1259    25227    M4SLL_PERSONA_EXT    TABLE     [  CREATE TABLE "SLL"."M4SLL_PERSONA_EXT" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "PEX_NRO_DOCUMENTO" character varying(20) NOT NULL,
    "TPI_ID_TP_IDENTIFICACION" character varying(3) NOT NULL,
    "PEX_ID_PERSONA_EXT" character varying(9),
    "PEX_NOMBRE" character varying(254),
    "PEX_APELLIDO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "PEX_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "PEX_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "PEX_NEGOCIO" character varying(255),
    "PEX_EMPRESA" character varying(255),
    "PEX_TP_EMPLEADO" character varying(10)
);
 &   DROP TABLE "SLL"."M4SLL_PERSONA_EXT";
       SLL         heap    SLL    false    4            R           1259    25235    M4SLL_PERSONA_EXT_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_PERSONA_EXT_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "PEX_ID_PERSONA_EXT" character varying(9),
    "PEX_NOMBRE" character varying(254),
    "PEX_APELLIDO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_PERSONA_EXT_BKP";
       SLL         heap    SLL    false    4            S           1259    25241    M4SLL_PERSONA_EXT_QA    TABLE     �  CREATE TABLE "SLL"."M4SLL_PERSONA_EXT_QA" (
    "ID_ORGANIZATION" character varying(4),
    "PEX_NRO_DOCUMENTO" character varying(20),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "PEX_ID_PERSONA_EXT" character varying(9),
    "PEX_NOMBRE" character varying(254),
    "PEX_APELLIDO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 )   DROP TABLE "SLL"."M4SLL_PERSONA_EXT_QA";
       SLL         heap    SLL    false    4            T           1259    25247    M4SLL_PROV_ABOGADO    TABLE     0  CREATE TABLE "SLL"."M4SLL_PROV_ABOGADO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "MAB_SECUENCIA" bigint NOT NULL,
    "PRA_SECUENCIA" bigint NOT NULL,
    "PRA_MONTO" numeric(18,4),
    "PRA_PORC_PROV_MES" numeric(5,2),
    "PRA_MONTO_PROV" numeric(18,4),
    "PRA_DT_ALTA" timestamp(0) without time zone,
    "PRA_OBSERVACIONES" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_PROV_ABOGADO";
       SLL         heap    SLL    false    4            U           1259    25250    M4SLL_REGION    TABLE     �  CREATE TABLE "SLL"."M4SLL_REGION" (
    "ID_ORGANIZATION" character varying(4),
    "REG_SECUENCIA" bigint,
    "REG_ID_REGION" character varying(30),
    "STD_ID_GEO_DIV" character varying(8),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "STD_ID_GEO_PLACE" character varying(9),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "NEG_ID_NEGOCIO" character varying(3),
    "STD_ID_LEG_ENT" character varying(9)
);
 !   DROP TABLE "SLL"."M4SLL_REGION";
       SLL         heap    SLL    false    4            X           1259    25259    M4SLL_ROLES_USRS    TABLE     k  CREATE TABLE "SLL"."M4SLL_ROLES_USRS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ID_APP_ROLE" character varying(30) NOT NULL,
    "TPR_ID_TP_ROL" bigint NOT NULL,
    "EJU_ID_EST_JURIDICO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_ROLES_USRS";
       SLL         heap    SLL    false    4            V           1259    25253    M4SLL_ROL_ACT_ROLE    TABLE     @  CREATE TABLE "SLL"."M4SLL_ROL_ACT_ROLE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "MRA_ID_ROL_ACTOR" bigint NOT NULL,
    "ID_APP_ROLE" character varying(30) NOT NULL,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_ROL_ACT_ROLE";
       SLL         heap    SLL    false    4            W           1259    25256    M4SLL_ROL_APROBS    TABLE     ^  CREATE TABLE "SLL"."M4SLL_ROL_APROBS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ID_APP_ROLE" character varying(30) NOT NULL,
    "ROA_VAL_MINIMO" numeric(18,4),
    "ROA_VAL_MAXIMO" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_ROL_APROBS";
       SLL         heap    SLL    false    4            Y           1259    25262    M4SLL_RP_CB_LITIGI    TABLE     N  CREATE TABLE "SLL"."M4SLL_RP_CB_LITIGI" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "RCL_MES" smallint NOT NULL,
    "RCL_ANIO" smallint NOT NULL,
    "RCL_CARPET_ID" character varying(10) NOT NULL,
    "RCL_NO" character varying(10),
    "RCL_MONTO_PREV_CAUSAS_M1" numeric(14,4),
    "RCL_MONTO_PREV_HONORARIOS_M1" numeric(14,4),
    "RCL_CARPET_CARATULA" character varying(254),
    "RCL_ESTJUI_DESCRIPCION" character varying(254),
    "RCL_MONTO_CAUSA" numeric(14,4),
    "RCL_PREVISION_CONDENA" smallint,
    "RCL_FEC_DE_ALTA_PREV_CONDENA" timestamp(0) without time zone,
    "RCL_MONTO_PREVISIONADO_CAUSA" numeric(14,4),
    "RCL_VARIACION_CAUSA" numeric(14,4),
    "RCL_OBSERVACIONES" character varying(254),
    "RCL_HONORIOS_Y_COSTAS" numeric(14,4),
    "RCL_PROVISION_HONORARIOS" smallint,
    "RCL_FEC_DE_ALTA_PREV_HONORARIO" timestamp(0) without time zone,
    "RCL_MONTO_PREV_HONORARIOS" numeric(14,4),
    "RCL_VARIACION_HONORARIOS" numeric(14,4),
    "RCL_OBSERV_HONORARIOS" character varying(254),
    "RCL_JURISDICCION" character varying(254),
    "RCL_JUZGADO" character varying(254),
    "RCL_CARPET_FECESTIMTERMINACION" character varying(10),
    "RCL_CONTIN_DESCRIPCION" character varying(254),
    "RCL_FECHAMONTO" timestamp(0) without time zone,
    "RCL_CLISEC_DESCRIPCION" character varying(254),
    "RCL_TIPO_CARPETA" character varying(254),
    "RCL_MONTOART" character varying(10),
    "RCL_ART" character varying(10),
    "RCL_LETRADOCONTRAPARTE" character varying(254),
    "RCL_ULTIMOMONTO" numeric(14,4),
    "RCL_ABOGADO" character varying(254),
    "RCL_PROBALIDAD" character varying(60),
    "RCL_FLEX_CONDENA" character varying(254),
    "RCL_FLEX_HONORARIOS" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_RP_CB_LITIGI";
       SLL         heap    SLL    false    4            Z           1259    25268    M4SLL_RP_ES_FICHER    TABLE     �  CREATE TABLE "SLL"."M4SLL_RP_ES_FICHER" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "REFE" character varying(100) NOT NULL,
    "USUARIO" character varying(100) NOT NULL,
    "EMPRESA" character varying(100),
    "IDNEGOCIO" character varying(100),
    "NEGOCIO" character varying(100),
    "IDDELEGACION" character varying(100),
    "DELEGACION" character varying(100),
    "ZONALAB" character varying(100),
    "DEMANDANTE" character varying(100),
    "NIF" character varying(100),
    "CODIGO" character varying(100),
    "ANALITICA" character varying(100),
    "EMP" character varying(100),
    "CTA" character varying(100),
    "DLG" character varying(100),
    "DIV" character varying(100),
    "CECO" character varying(100),
    "TIPO_DEMANDANTE" character varying(100),
    "PERSONAL" character varying(100),
    "FECHA_ALTA" character varying(100),
    "PROV_S_N" character varying(100),
    "IMPORTE_PROVISION" character varying(100),
    "IMPORTE_PREVISTO" character varying(100),
    "TOTAL_COSTE" character varying(100),
    "IDASUNTO" character varying(100),
    "ASUNTO" character varying(100),
    "IDSUBASUNTO" character varying(100),
    "SUBASUNTO" character varying(100),
    "FECHA_DESPIDO_DEMANDA" character varying(100),
    "FECHA_CONCILIACION" character varying(100),
    "IDRESULTADO_CONCILIACION" character varying(100),
    "RESULTADO_CONCILIACION" character varying(100),
    "FECHA_JUZGADO" character varying(100),
    "NRO_AUTOS" character varying(100),
    "IDRESULTADO" character varying(100),
    "RESULTADO" character varying(100),
    "TRIB_SUPERIOR_FECHA" character varying(100),
    "IDTRIB_SUPERIOR_RESULTADO" character varying(100),
    "TRIB_SUPERIOR_RESULTADO" character varying(100),
    "TRIB_SUPREMO_FECHA" character varying(100),
    "IDTRIB_SUPREMO_RESULTADO" character varying(100),
    "TRIB_SUPREMO_RESULTADO" character varying(100),
    "FECHA_ESTADO" character varying(100),
    "IDESTADO_FINAL" character varying(100),
    "ESTADO_FINAL" character varying(100),
    "IDABOGADO" character varying(100),
    "ABOGADO" character varying(100),
    "OBSERVACIONES" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_RP_ES_FICHER";
       SLL         heap    SLL    false    4            [           1259    25274    M4SLL_RP_ES_LITIGI    TABLE     c	  CREATE TABLE "SLL"."M4SLL_RP_ES_LITIGI" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "REL_USUARIO" character varying(50) NOT NULL,
    "REL_SECUENCIA" bigint NOT NULL,
    "REL_ID_LITIGIO" character varying(20),
    "REL_ID_LEGADO" character varying(20),
    "REL_EMPRESA" character varying(255),
    "REL_NEGOCIO" character varying(255),
    "REL_CIUDAD" character varying(255),
    "REL_DELEGACION" character varying(255),
    "REL_ZONA_LABORAL" character varying(255),
    "REL_DEMANDANTE" character varying(255),
    "REL_DEMANDANTE_NIF" character varying(20),
    "REL_DEMANDANTE_LEGAJO" character varying(10),
    "REL_COMBINACION_ANALITICA" character varying(255),
    "REL_TIPO_DEMANDANTE" character varying(20),
    "REL_TIPO_PERSONA" character varying(200),
    "REL_FECHA_ALTA" timestamp(0) without time zone,
    "REL_IMPORTE_PREVISTO" numeric(18,4),
    "REL_ASUNTO" character varying(1000),
    "REL_ASUNTOS_SECUNDARIOS" character varying(1000),
    "REL_SUBASUNTO" character varying(1000),
    "REL_FECHA_DEMANDA" timestamp(0) without time zone,
    "REL_NRO_AUTO" character varying(255),
    "REL_FECHA_CONCILIACION" timestamp(0) without time zone,
    "REL_FASE_RESUL_CON" character varying(255),
    "REL_FECHA_JUZGADO" timestamp(0) without time zone,
    "REL_RESULTADO_JUZGADO" character varying(255),
    "REL_FECHA_TRIBUNAL_SUPERIOR" timestamp(0) without time zone,
    "REL_RESULTADO_TRI_SUPERIOR" character varying(255),
    "REL_FECHA_TRIBUNAL_SUPREMO" timestamp(0) without time zone,
    "REL_RESULTADO_TRI_SUPREMO" character varying(255),
    "REL_COSTO_TOTAL" numeric(18,4),
    "REL_FECHA_ESTADO" timestamp(0) without time zone,
    "REL_ESTADO_CIERRE" character varying(200),
    "REL_ABOGADO_RESPONSABLE" character varying(255),
    "REL_OBSERVACION" character varying(1000),
    "REL_SUBASUNTOS_SECUNDARIOS" character varying(1000),
    "REL_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "REL_VALOR_RECARGO" numeric(18,4),
    "REL_FECHA_CIERRE" timestamp(0) without time zone,
    "REL_MATERIA" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "REL_FECHA_ACTUALIZACION" timestamp(0) without time zone,
    "REL_EMP_LIT" character varying(255),
    "REL_EST_FINAL" character varying(254),
    "REL_CLIENTE" character varying(1000)
);
 '   DROP TABLE "SLL"."M4SLL_RP_ES_LITIGI";
       SLL         heap    SLL    false    4            \           1259    25280    M4SLL_RP_ES_PROVIS    TABLE     S	  CREATE TABLE "SLL"."M4SLL_RP_ES_PROVIS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "REL_USUARIO" character varying(50) NOT NULL,
    "REL_SECUENCIA" bigint NOT NULL,
    "REL_ID_LITIGIO" character varying(20),
    "REL_EMPRESA" character varying(255),
    "REL_NEGOCIO" character varying(255),
    "REL_CIUDAD" character varying(255),
    "REL_DELEGACION" character varying(255),
    "REL_ZONA_LABORAL" character varying(255),
    "REL_DEMANDANTE" character varying(255),
    "REL_DEMANDANTE_NIF" character varying(20),
    "REL_DEMANDANTE_LEGAJO" character varying(10),
    "REL_COMBINACION_ANALITICA" character varying(255),
    "REL_ID_REGION" character varying(10),
    "REL_TIPO_DEMANDANTE" character varying(20),
    "REL_TIPO_PERSONA" character varying(200),
    "REL_FECHA_ALTA" timestamp(0) without time zone,
    "REL_IMPORTE_PREVISTO" numeric(18,4),
    "REL_ASUNTO" character varying(1000),
    "REL_ASUNTOS_SECUNDARIOS" character varying(1000),
    "REL_SUBASUNTO" character varying(1000),
    "REL_FECHA_DEMANDA" timestamp(0) without time zone,
    "REL_NRO_AUTO" character varying(255),
    "REL_FECHA_CONCILIACION" timestamp(0) without time zone,
    "REL_FASE_RESUL_CON" character varying(255),
    "REL_FECHA_JUZGADO" timestamp(0) without time zone,
    "REL_RESULTADO_JUZGADO" character varying(255),
    "REL_FECHA_TRIBUNAL_SUPERIOR" timestamp(0) without time zone,
    "REL_RESULTADO_TRI_SUPERIOR" character varying(255),
    "REL_FECHA_TRIBUNAL_SUPREMO" timestamp(0) without time zone,
    "REL_RESULTADO_TRI_SUPREMO" character varying(255),
    "REL_COSTO_TOTAL" numeric(18,4),
    "REL_FECHA_ESTADO" timestamp(0) without time zone,
    "REL_ESTADO_CIERRE" character varying(200),
    "REL_ABOGADO_RESPONSABLE" character varying(255),
    "REL_OBSERVACION" character varying(1000),
    "REL_SUBASUNTOS_SECUNDARIOS" character varying(1000),
    "REL_FECHA_NOTIFICACION" timestamp(0) without time zone,
    "REL_VALOR_RECARGO" numeric(18,4),
    "REL_FECHA_CIERRE" timestamp(0) without time zone,
    "REL_MATERIA" character varying(1000),
    "REL_ID_DIVISION" character varying(10),
    "REL_IMPORTE_PROVISION" numeric(18,4),
    "REL_ID_LEG_ENT" character varying(10),
    "REL_ID_LEGADO" character varying(20),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_RP_ES_PROVIS";
       SLL         heap    SLL    false    4            ]           1259    25286    M4SLL_SEGURIDAD    TABLE     K  CREATE TABLE "SLL"."M4SLL_SEGURIDAD" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ID_APP_ROLE" character varying(50) NOT NULL,
    "SS_SECUENCIAL" bigint NOT NULL,
    "SS_SQL" text,
    "SS_CHK_SELECT" character varying(1),
    "SS_CHK_UPDATE" character varying(1),
    "SS_CHK_INSERT" character varying(1),
    "SS_CHK_DELETE" character varying(1),
    "SS_CHK_CLIENTE_OBM" character varying(1),
    "SS_CHK_DTI" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 $   DROP TABLE "SLL"."M4SLL_SEGURIDAD";
       SLL         heap    SLL    false    4            _           1259    25295    M4SLL_SEGURIDAD2    TABLE     1  CREATE TABLE "SLL"."M4SLL_SEGURIDAD2" (
    "ID_ORGANIZATION" character varying(4),
    "ID_APP_ROLE" character varying(50),
    "SS_SECUENCIAL" bigint,
    "SS_SQL" text,
    "SS_CHK_SELECT" character varying(1),
    "SS_CHK_UPDATE" character varying(1),
    "SS_CHK_INSERT" character varying(1),
    "SS_CHK_DELETE" character varying(1),
    "SS_CHK_CLIENTE_OBM" character varying(1),
    "SS_CHK_DTI" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_SEGURIDAD2";
       SLL         heap    SLL    false    4            ^           1259    25292    M4SLL_SEGURIDAD_VI    TABLE     �  CREATE TABLE "SLL"."M4SLL_SEGURIDAD_VI" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "ID_APP_ROLE" character varying(50) NOT NULL,
    "SSV_ID_MODULO" character varying(254) NOT NULL,
    "SSV_CHK_VER" character varying(1),
    "SSV_CHK_GUARDAR" character varying(1),
    "SSV_CHK_MODIFICAR" character varying(1),
    "SSV_CHK_ELIMINAR" character varying(1),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_SEGURIDAD_VI";
       SLL         heap    SLL    false    4            `           1259    25301    M4SLL_SGD_CONFIG    TABLE     :  CREATE TABLE "SLL"."M4SLL_SGD_CONFIG" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "SGDC_CONTEXT" character varying(300) NOT NULL,
    "SGDC_ENDPOINT" character varying(300),
    "SGDC_MAIN_CLASS" character varying(300),
    "SGDC_TOKEN_SECURITY" character varying(300),
    "SGDC_COUNTRY" character varying(300),
    "SGDC_METHOD_GET_DO" character varying(300),
    "SGCD_METHOD_DEL_DOCUMENTS" character varying(300),
    "SGDC_METHOD_OBTAIN_DOCUMENT" character varying(300),
    "SGDC_METHOD_SAVE_DOCUMENT" character varying(300),
    "SGDC_ATTRIBUTES" character varying(300),
    "SGDC_VAL_ATTRIBUTES" character varying(300),
    "SGDC_TP_DOCUMENTO" character varying(300),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_SGD_CONFIG";
       SLL         heap    SLL    false    4            a           1259    25307    M4SLL_STATUS_PAGOS    TABLE     O  CREATE TABLE "SLL"."M4SLL_STATUS_PAGOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "STP_ID_STATUS_PAGO" character varying(3) NOT NULL,
    "STP_NM_STATUS_PAGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_STATUS_PAGOS";
       SLL         heap    SLL    false    4            b           1259    25310    M4SLL_ST_REPO_PROV    TABLE     �  CREATE TABLE "SLL"."M4SLL_ST_REPO_PROV" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "SSR_PERIODO" timestamp(0) without time zone NOT NULL,
    "MSR_ID_STATUS_REPORTE" character varying(3) NOT NULL,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "SRP_APROBACION_G" character varying(1),
    "SRP_APROBACION_D" character varying(1)
);
 '   DROP TABLE "SLL"."M4SLL_ST_REPO_PROV";
       SLL         heap    SLL    false    4            c           1259    25313    M4SLL_TOTHONJ    TABLE     �  CREATE TABLE "SLL"."M4SLL_TOTHONJ" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TNJ_ANIO" smallint NOT NULL,
    "TNJ_MES" smallint NOT NULL,
    "MAB_SECUENCIA" bigint NOT NULL,
    "TNJ_MONTO_A" numeric(18,4),
    "TNJ_MONTO" numeric(18,4),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 "   DROP TABLE "SLL"."M4SLL_TOTHONJ";
       SLL         heap    SLL    false    4            d           1259    25316    M4SLL_TOTPEDHIS    TABLE     �  CREATE TABLE "SLL"."M4SLL_TOTPEDHIS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "TPH_MES" smallint NOT NULL,
    "TPH_ANIO" smallint NOT NULL,
    "TPE_ID_PEDIDO" character varying(3),
    "STD_ID_LEG_ENT" character varying(9),
    "EJU_ID_EST_JURIDICO" character varying(3),
    "TPH_AUTOR" character varying(1000),
    "TPH_REU" character varying(1000),
    "LIT_NRO_PROCESO" character varying(100),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TPH_VALOR_DEMANDA" numeric(18,4),
    "TPH_VALOR_DEM_INTERES" numeric(18,4),
    "TPH_VALOR_DEM_COR_MON" numeric(18,4),
    "TPH_VALOR_DEM_ACT" numeric(18,4),
    "TPH_VAL_RIESGO" numeric(18,4),
    "TPH_VALOR_PROVISION" numeric(18,4),
    "TPH_PAGOS" numeric(18,4),
    "TST_ID_TP_STATUS" character varying(3),
    "TPH_VAL_HON_JURIDICO" numeric(18,4),
    "TPH_VAL_PREMIO_JURIDICO" numeric(18,4),
    "TPH_VAL_TOTAL_HON_JUR" numeric(18,4),
    "TPH_AUTOR_RUN" character varying(1000),
    "TPH_AUTOR_CAUSAL" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPH_VALOR_CONDENA" numeric(18,4),
    "TPH_PORC_PROV_CONDENA" numeric(5,2),
    "TPH_VALOR_PROV_CONDENA" numeric(18,4),
    "TPH_VALOR_HON" numeric(18,4),
    "TPH_PORC_PROV_HON" numeric(5,2),
    "TPH_VALOR_PROV_HON" numeric(18,4)
);
 $   DROP TABLE "SLL"."M4SLL_TOTPEDHIS";
       SLL         heap    SLL    false    4            e           1259    25322    M4SLL_TP_AUTOR_REU    TABLE     M  CREATE TABLE "SLL"."M4SLL_TP_AUTOR_REU" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TAR_ID_TP_AUTOR_REU" character varying(3) NOT NULL,
    "TAR_NM_TP_AUTOR_REU" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TAR_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TAR_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_TP_AUTOR_REU";
       SLL         heap    SLL    false    4            f           1259    25327    M4SLL_TP_AUTOR_REU_BKP    TABLE     C  CREATE TABLE "SLL"."M4SLL_TP_AUTOR_REU_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TAR_ID_TP_AUTOR_REU" character varying(3),
    "TAR_NM_TP_AUTOR_REU" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 +   DROP TABLE "SLL"."M4SLL_TP_AUTOR_REU_BKP";
       SLL         heap    SLL    false    4            g           1259    25330    M4SLL_TP_COMPROMIS    TABLE     �  CREATE TABLE "SLL"."M4SLL_TP_COMPROMIS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TCO_ID_TP_COMPROMISO" character varying(3) NOT NULL,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TCO_NM_TP_COMPROMISO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TCO_DT_VALIDEZ" smallint,
    "TCO_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TCO_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_TP_COMPROMIS";
       SLL         heap    SLL    false    4            h           1259    25335    M4SLL_TP_COMPROMIS_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_TP_COMPROMIS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TCO_ID_TP_COMPROMISO" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TCO_NM_TP_COMPROMISO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TCO_DT_VALIDEZ" smallint
);
 +   DROP TABLE "SLL"."M4SLL_TP_COMPROMIS_BKP";
       SLL         heap    SLL    false    4            i           1259    25338    M4SLL_TP_DOC_LITIG    TABLE       CREATE TABLE "SLL"."M4SLL_TP_DOC_LITIG" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TDL_ID_TP_DOC_LITIGIO" character varying(3) NOT NULL,
    "TDL_NM_TP_DOC_LITIGIO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TDL_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TDL_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_TP_DOC_LITIG";
       SLL         heap    SLL    false    4            j           1259    25343    M4SLL_TP_DOC_LITIG_BKP    TABLE     u  CREATE TABLE "SLL"."M4SLL_TP_DOC_LITIG_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TDL_ID_TP_DOC_LITIGIO" character varying(3),
    "TDL_NM_TP_DOC_LITIGIO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3)
);
 +   DROP TABLE "SLL"."M4SLL_TP_DOC_LITIG_BKP";
       SLL         heap    SLL    false    4            k           1259    25346    M4SLL_TP_ENTIDADES    TABLE     w  CREATE TABLE "SLL"."M4SLL_TP_ENTIDADES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPE_ID_TP_ENTIDAD" character varying(3) NOT NULL,
    "TPE_NM_TP_ENTIDAD" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPE_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TPE_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_TP_ENTIDADES";
       SLL         heap    SLL    false    4            l           1259    25351    M4SLL_TP_ENTIDADES_BKP    TABLE     m  CREATE TABLE "SLL"."M4SLL_TP_ENTIDADES_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPE_ID_TP_ENTIDAD" character varying(3),
    "TPE_NM_TP_ENTIDAD" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3)
);
 +   DROP TABLE "SLL"."M4SLL_TP_ENTIDADES_BKP";
       SLL         heap    SLL    false    4            m           1259    25354    M4SLL_TP_FALTAS    TABLE     q  CREATE TABLE "SLL"."M4SLL_TP_FALTAS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TFL_ID_TP_FALTA" character varying(3) NOT NULL,
    "TFL_NM_TP__FALTA" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TFL_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TFL_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 $   DROP TABLE "SLL"."M4SLL_TP_FALTAS";
       SLL         heap    SLL    false    4            n           1259    25359    M4SLL_TP_FASES    TABLE     m  CREATE TABLE "SLL"."M4SLL_TP_FASES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TFA_ID_TP_FASE" character varying(3) NOT NULL,
    "TFA_NM_TP_FASE" character varying(254),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TFA_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TFA_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 #   DROP TABLE "SLL"."M4SLL_TP_FASES";
       SLL         heap    SLL    false    4            o           1259    25364    M4SLL_TP_FASES_BKP    TABLE     c  CREATE TABLE "SLL"."M4SLL_TP_FASES_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TFA_ID_TP_FASE" character varying(3),
    "TFA_NM_TP_FASE" character varying(254),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_TP_FASES_BKP";
       SLL         heap    SLL    false    4            p           1259    25367    M4SLL_TP_IDENTIFIC    TABLE     W  CREATE TABLE "SLL"."M4SLL_TP_IDENTIFIC" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPI_ID_TP_IDENTIFICACION" character varying(3) NOT NULL,
    "TPI_NM_TP_IDENTIFICACION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPI_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TPI_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_TP_IDENTIFIC";
       SLL         heap    SLL    false    4            q           1259    25372    M4SLL_TP_IDENTIFIC_BKP    TABLE     M  CREATE TABLE "SLL"."M4SLL_TP_IDENTIFIC_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPI_ID_TP_IDENTIFICACION" character varying(3),
    "TPI_NM_TP_IDENTIFICACION" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 +   DROP TABLE "SLL"."M4SLL_TP_IDENTIFIC_BKP";
       SLL         heap    SLL    false    4            r           1259    25375    M4SLL_TP_LITIGIOS    TABLE     H  CREATE TABLE "SLL"."M4SLL_TP_LITIGIOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPL_ID_TP_LITIGIO" character varying(3) NOT NULL,
    "TPL_NM_TP_LITIGIO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TPL_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_TP_LITIGIOS";
       SLL         heap    SLL    false    4            s           1259    25380    M4SLL_TP_LITIGIOS_BKP    TABLE     >  CREATE TABLE "SLL"."M4SLL_TP_LITIGIOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPL_NM_TP_LITIGIO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 *   DROP TABLE "SLL"."M4SLL_TP_LITIGIOS_BKP";
       SLL         heap    SLL    false    4            t           1259    25383    M4SLL_TP_MOTIVO    TABLE     r  CREATE TABLE "SLL"."M4SLL_TP_MOTIVO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TMO_ID_TP_MOTIVO" character varying(3) NOT NULL,
    "TMO_NM_TP_MOTIVO" character varying(254),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TMO_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TMO_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 $   DROP TABLE "SLL"."M4SLL_TP_MOTIVO";
       SLL         heap    SLL    false    4            u           1259    25388    M4SLL_TP_PAGOS    TABLE     o  CREATE TABLE "SLL"."M4SLL_TP_PAGOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPA_ID_PAGO" character varying(3) NOT NULL,
    "TPA_NM_PAGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPA_NUMERO_CUENTA" character varying(30),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPA_VENDOR_ID" character varying(15),
    "TPA_VENDOR_SITE_ID" character varying(15),
    "VENDOR_NAME" character varying(240),
    "TPA_NOMINA_S_N" character varying(1),
    "TPA_CONCEPTO" character varying(1),
    "TPA_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TPA_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 #   DROP TABLE "SLL"."M4SLL_TP_PAGOS";
       SLL         heap    SLL    false    4            v           1259    25396    M4SLL_TP_PAGOS_BKP    TABLE       CREATE TABLE "SLL"."M4SLL_TP_PAGOS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPA_ID_PAGO" character varying(3),
    "TPA_NM_PAGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPA_NUMERO_CUENTA" character varying(30),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPA_VENDOR_ID" character varying(15),
    "TPA_VENDOR_SITE_ID" character varying(15),
    "VENDOR_NAME" character varying(240)
);
 '   DROP TABLE "SLL"."M4SLL_TP_PAGOS_BKP";
       SLL         heap    SLL    false    4            w           1259    25402    M4SLL_TP_PEDIDO    TABLE     O  CREATE TABLE "SLL"."M4SLL_TP_PEDIDO" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPE_ID_PEDIDO" character varying(3) NOT NULL,
    "TPE_NM_PEDIDO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TPE_PROVISIONA_S_N" character varying(1),
    "TPE_DT_END" timestamp(0) without time zone,
    "TPE_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 $   DROP TABLE "SLL"."M4SLL_TP_PEDIDO";
       SLL         heap    SLL    false    4            x           1259    25406    M4SLL_TP_PEDIDO_BKP    TABLE     b  CREATE TABLE "SLL"."M4SLL_TP_PEDIDO_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TPE_ID_PEDIDO" character varying(3),
    "TPE_NM_PEDIDO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3)
);
 (   DROP TABLE "SLL"."M4SLL_TP_PEDIDO_BKP";
       SLL         heap    SLL    false    4            y           1259    25409    M4SLL_TP_RECLAMOS    TABLE     v  CREATE TABLE "SLL"."M4SLL_TP_RECLAMOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TRC_ID_TP_RECLAMO" character varying(3) NOT NULL,
    "TRC_NM_TP_RECLAMO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TRC_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TRC_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_TP_RECLAMOS";
       SLL         heap    SLL    false    4            z           1259    25414    M4SLL_TP_RECURREN    TABLE     J  CREATE TABLE "SLL"."M4SLL_TP_RECURREN" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TRE_ID_RECURRENCIA" character varying(3) NOT NULL,
    "TRE_NM_RECURRENCIA" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TRE_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TRE_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 &   DROP TABLE "SLL"."M4SLL_TP_RECURREN";
       SLL         heap    SLL    false    4            {           1259    25419    M4SLL_TP_ROLES    TABLE     /  CREATE TABLE "SLL"."M4SLL_TP_ROLES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TPR_ID_TP_ROL" bigint NOT NULL,
    "TPR_NM_TP_ROL" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPR_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TPR_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 #   DROP TABLE "SLL"."M4SLL_TP_ROLES";
       SLL         heap    SLL    false    4            |           1259    25424    M4SLL_TP_SALIDA_PA    TABLE     K  CREATE TABLE "SLL"."M4SLL_TP_SALIDA_PA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TSP_ID_SALIDA_PAGO" character varying(3) NOT NULL,
    "TSP_NM_SALIDA_PAGO" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TSP_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TSP_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 '   DROP TABLE "SLL"."M4SLL_TP_SALIDA_PA";
       SLL         heap    SLL    false    4            ~           1259    25434    M4SLL_TP_STATUS    TABLE     r  CREATE TABLE "SLL"."M4SLL_TP_STATUS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TST_ID_TP_STATUS" character varying(3) NOT NULL,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TST_NM_TP_STATUS" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TST_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TST_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 $   DROP TABLE "SLL"."M4SLL_TP_STATUS";
       SLL         heap    SLL    false    4                       1259    25439    M4SLL_TP_STATUS_BKP    TABLE     h  CREATE TABLE "SLL"."M4SLL_TP_STATUS_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TST_ID_TP_STATUS" character varying(3),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "TST_NM_TP_STATUS" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 (   DROP TABLE "SLL"."M4SLL_TP_STATUS_BKP";
       SLL         heap    SLL    false    4            }           1259    25429    M4SLL_TP_STA_DET    TABLE     x  CREATE TABLE "SLL"."M4SLL_TP_STA_DET" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TSD_ID_TP_STA_DET" character varying(3) NOT NULL,
    "TSD_NM_TP_STATUS_DET" character varying(254),
    "TPL_ID_TP_LITIGIO" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TSD_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TSD_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 %   DROP TABLE "SLL"."M4SLL_TP_STA_DET";
       SLL         heap    SLL    false    4            �           1259    25442    M4SLL_TRIBUNALES    TABLE     �  CREATE TABLE "SLL"."M4SLL_TRIBUNALES" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "TRI_ID_TRIBUNAL" character varying(3) NOT NULL,
    "TRI_NM_TRIBUNAL" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "STD_ID_GEO_PLACE" character varying(9),
    "TRI_DT_START" timestamp(0) without time zone DEFAULT to_date('1800-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text),
    "TRI_DT_END" timestamp(0) without time zone DEFAULT to_date('4000-01-01 00:00:00'::text, 'YYYY-MM-DD HH24:MI:SS'::text)
);
 %   DROP TABLE "SLL"."M4SLL_TRIBUNALES";
       SLL         heap    SLL    false    4            �           1259    25447    M4SLL_TRIBUNALES_BKP    TABLE     �  CREATE TABLE "SLL"."M4SLL_TRIBUNALES_BKP" (
    "ID_ORGANIZATION" character varying(4),
    "TRI_ID_TRIBUNAL" character varying(3),
    "TRI_NM_TRIBUNAL" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "TPL_ID_TP_LITIGIO" character varying(3),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "STD_ID_GEO_PLACE" character varying(9)
);
 )   DROP TABLE "SLL"."M4SLL_TRIBUNALES_BKP";
       SLL         heap    SLL    false    4            �           1259    25450    M4SLL_VAL_EC_LIT    TABLE     ?  CREATE TABLE "SLL"."M4SLL_VAL_EC_LIT" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "VEL_SECUENCIA" bigint NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "VEL_VALOR_CONDENA" numeric(18,4),
    "VEL_PORC_PROV_CONDENA" numeric(18,4),
    "VEL_IMP_PROV_CONDENA" numeric(18,4),
    "VEL_VALOR_FINAL_CONDENA" numeric(18,4),
    "VEL_DT_IMPACTO_COND" timestamp(0) without time zone,
    "VEL_OBS_CONDENA" character varying(1000),
    "VEL_VAL_HONORARIOS" numeric(18,4),
    "VEL_PORC_PROV_HONORARIOS" numeric(18,4),
    "VEL_IMP_PROV_HONORARIOS" numeric(18,4),
    "VEL_DT_IMPACTO_HONO" timestamp(0) without time zone,
    "VEL_OBS_HONORARIOS" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 %   DROP TABLE "SLL"."M4SLL_VAL_EC_LIT";
       SLL         heap    SLL    false    4            �           1259    25456    M4SLL_VAL_LITIGIOS    TABLE     �  CREATE TABLE "SLL"."M4SLL_VAL_LITIGIOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "LIT_ID_LITIGIO" character varying(10) NOT NULL,
    "VAL_SECUENCIA" bigint NOT NULL,
    "TPE_ID_PEDIDO" character varying(3) NOT NULL,
    "VAL_FECHA" timestamp(0) without time zone,
    "PED_VALOR" numeric(18,4),
    "VAL_PED" numeric(18,4),
    "VAL_PED_INT" numeric(18,4),
    "VAL_PED_COR" numeric(18,4),
    "VAL_PED_ACT" numeric(18,4),
    "VAL_PROV" numeric(18,4),
    "VAL_PROV_INT" numeric(18,4),
    "VAL_PROV_COR" numeric(18,4),
    "VAL_PROV_ACT" numeric(18,4),
    "VAL_FECHA_BASE" timestamp(0) without time zone,
    "VAL_AGREGADO_POR" smallint,
    "VAL_RIESGO" numeric(18,4),
    "VAL_RIESGO_JUST" character varying(1000),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "VAL_POR_PROV" numeric(18,4)
);
 '   DROP TABLE "SLL"."M4SLL_VAL_LITIGIOS";
       SLL         heap    SLL    false    4            �           1259    25462    M4SLL_WKF_ESTADOS    TABLE     �  CREATE TABLE "SLL"."M4SLL_WKF_ESTADOS" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "WKE_ID_ESTADO" bigint NOT NULL,
    "WKE_NM_ESTADO" character varying(254),
    "WKE_DT_START" timestamp(0) without time zone,
    "WKE_DT_END" timestamp(0) without time zone,
    "WKE_PLAZO" smallint,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 &   DROP TABLE "SLL"."M4SLL_WKF_ESTADOS";
       SLL         heap    SLL    false    4            �           1259    25465    M4SLL_WKF_ROL_ESTA    TABLE     3  CREATE TABLE "SLL"."M4SLL_WKF_ROL_ESTA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "WKE_ID_ESTADO" bigint NOT NULL,
    "MRA_ID_ROL_ACTOR" bigint NOT NULL,
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_WKF_ROL_ESTA";
       SLL         heap    SLL    false    4            �           1259    25468    M4SLL_WKF_TAR_ESTA    TABLE     u  CREATE TABLE "SLL"."M4SLL_WKF_TAR_ESTA" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "WTE_SECUENCIA" bigint NOT NULL,
    "WKE_ID_ESTADO" bigint,
    "WTE_ESTADO_SIGUIENTE" bigint,
    "WTE_NM_TAREA" character varying(254),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 '   DROP TABLE "SLL"."M4SLL_WKF_TAR_ESTA";
       SLL         heap    SLL    false    4            �           1259    33081    STD_COUNTRY    TABLE     �  CREATE TABLE public."STD_COUNTRY" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "STD_ID_COUNTRY" character varying(4) NOT NULL,
    "STD_N_COUNTRYBRA" character varying(62),
    "STD_N_COUNTRYENG" character varying(62),
    "STD_N_COUNTRYESP" character varying(62),
    "STD_N_COUNTRYFRA" character varying(62),
    "STD_N_COUNTRYGEN" character varying(62),
    "STD_N_COUNTRYGER" character varying(62),
    "STD_N_COUNTRYITA" character varying(62),
    "STD_ID_COUNT_GROUP" character varying(3),
    "STD_ID_NACIONALITY" character varying(3),
    "STD_N_NACIONALBRA" character varying(62),
    "STD_N_NACIONALENG" character varying(62),
    "STD_N_NACIONALESP" character varying(62),
    "STD_N_NACIONALFRA" character varying(62),
    "STD_N_NACIONALGEN" character varying(62),
    "STD_N_NACIONALGER" character varying(62),
    "STD_N_NACIONALITA" character varying(62),
    "STD_ID_CURRENCY" character varying(3),
    "SFR_ID_NATIONALITY" character varying(2),
    "SSP_ID_NACION_SS" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "STD_ID_COUNT_DIAN" smallint
);
 !   DROP TABLE public."STD_COUNTRY";
       public         heap    SLL    false            �           1259    33087    STD_GEO_DIV    TABLE     �  CREATE TABLE public."STD_GEO_DIV" (
    "ID_ORGANIZATION" character varying(4) DEFAULT '0000'::character varying NOT NULL,
    "STD_ID_COUNTRY" character varying(4) NOT NULL,
    "STD_ID_GEO_DIV" character varying(4) NOT NULL,
    "STD_N_GEO_DIVENG" character varying(62),
    "STD_N_GEO_DIVESP" character varying(62),
    "STD_N_GEO_DIVFRA" character varying(62),
    "STD_N_GEO_DIVGER" character varying(62),
    "STD_N_GEO_DIVBRA" character varying(62),
    "STD_N_GEO_DIVITA" character varying(62),
    "STD_N_GEO_DIVGEN" character varying(62),
    "SME_ID_CURP" character varying(2),
    "SME_PORC_ILIS" numeric(7,4),
    "SCB_ID_ZONA_UPC" character varying(3),
    "SAR_ID_PROV_AFIP" character varying(4),
    "SME_PORC_IMPUESTO" numeric(5,2),
    "ID_APPROLE" character varying(30),
    "SME_CALC_IMP" smallint,
    "ID_SECUSER" character varying(30),
    "SME_ID_ESTADO_DIM" character varying(4),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 !   DROP TABLE public."STD_GEO_DIV";
       public         heap    SLL    false            �           1259    33094    STD_GEO_PLACE    TABLE     \  CREATE TABLE public."STD_GEO_PLACE" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "STD_ID_COUNTRY" character varying(4) NOT NULL,
    "STD_ID_GEO_DIV" character varying(4) NOT NULL,
    "STD_ID_SUB_GEO_DIV" character varying(8) NOT NULL,
    "STD_ID_GEO_PLACE" character varying(9) NOT NULL,
    "STD_N_GEO_PLACENG" character varying(62),
    "STD_N_GEO_PLACESP" character varying(62),
    "STD_N_GEO_PLACFRA" character varying(62),
    "STD_N_GEO_PLACGER" character varying(62),
    "STD_N_GEO_PLACBRA" character varying(62),
    "STD_N_GEO_PLACITA" character varying(62),
    "STD_N_GEO_PLACGEN" character varying(62),
    "STD_ID_LEGAL_PLACE" character varying(9),
    "SCB_ID_ZONA_UPC" character varying(3),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone
);
 #   DROP TABLE public."STD_GEO_PLACE";
       public         heap    SLL    false            �           1259    33100 
   STD_PERSON    TABLE     �  CREATE TABLE public."STD_PERSON" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "STD_ID_PERSON" character varying(10) NOT NULL,
    "STD_N_FAM_NAME_1" character varying(50),
    "STD_N_MAIDEN_NAME" character varying(50),
    "STD_N_FIRST_NAME" character varying(50),
    "STD_N_USUAL_NAME" character varying(50),
    "STD_ID_GENDER" character varying(1),
    "STD_ID_SALUTATION" character varying(10),
    "STD_DT_BIRTH" timestamp(0) without time zone,
    "STD_ID_COUNTRY" character varying(4),
    "STD_ID_GEO_DIV" character varying(4),
    "STD_ID_SUB_GEO_DIV" character varying(8),
    "STD_COMMENT" character varying(254),
    "SSP_ID_PAIS_EMISOR" character varying(4),
    "SSP_PRIM_APELLIDO" character varying(50),
    "STD_SSN" character varying(20),
    "SCO_PHOTO" character varying(100),
    "SCO_HOME_PAGE" character varying(254),
    "SSP_ID_TP_DOC" character varying(10),
    "SFR_N_MAIDEN_NAME" character varying(50),
    "SFR_NM_BIRTH_PLACE" character varying(50),
    "STD_ID_GEO_PLACE" character varying(9),
    "STD_SS_KEY" character varying(3),
    "STD_SS_NUMBER" character varying(16),
    "SAR_N_MARRIED_NAME" character varying(40),
    "SBR_ID_RACA" character varying(3),
    "SCO_PHOTO_INET" character varying(100),
    "SGE_ID_ADD_NAME" character varying(2),
    "SGE_ID_TITEL" character varying(3),
    "SGE_ID_VSW" character varying(3),
    "SGE_N_NAME_COMPL" character varying(254),
    "SUK_MAIDEN_NAME" character varying(50),
    "SUK_OTHER_FORENAME" character varying(50),
    "SUK_PREVIOUS_SURNA" character varying(50),
    "SUS_DEATH_DATE" timestamp(0) without time zone,
    "SCO_SMOKER" smallint,
    "SCO_GB_NAME" character varying(254),
    "SCO_ID_REGION" character varying(9),
    "SAR_EXPEDIDO" character varying(62),
    "SUS_VETERAN" smallint,
    "SUS_ID_VET_DIS_TY" character varying(2),
    "SUS_ID_VETERAN_WHE" character varying(3),
    "SUS_ID_ETHNICITY" character varying(3),
    "SAR_DT_DEFUNCION" timestamp(0) without time zone,
    "SCB_DIG_VER" character varying(1),
    "SME_NUM_SS" character varying(62),
    "SAR_CUIL" character varying(16),
    "SCL_RUT" character varying(16),
    "SME_RFC" character varying(16),
    "SME_CURP" character varying(20),
    "SBR_CPF" character varying(20),
    "SMX_IMSS" character varying(12),
    "CMX_APELLIDO_PATERNO_IMSS" character varying(50),
    "CMX_APELLIDO_MATERNO_IMSS" character varying(50),
    "CMX_NOMBRE_IMSS" character varying(50),
    "ID_APPROLE" character varying(30),
    "ID_SECUSER" character varying(30),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "CFR_LOCALIDAD_NAC" character varying(100),
    "STD_ID_COUNTRY_PADRE" character varying(4),
    "STD_ID_COUNTRY_MADRE" character varying(4),
    "CCO_NEC_HABI" character varying(1),
    "PLCO_HIDDEN_BY_DATA_PROTECTION" character varying(1) DEFAULT 0,
    "PLCO_DATE_4_HIDDEN_DATA_PROTEC" timestamp(0) without time zone,
    "SCO_GB_LEGAL" character varying(50),
    "PLCO_ID_ORGANIZATION" character varying(4)
);
     DROP TABLE public."STD_PERSON";
       public         heap    SLL    false            �           1259    33107    STD_SUB_GEO_DIV    TABLE     Q  CREATE TABLE public."STD_SUB_GEO_DIV" (
    "ID_ORGANIZATION" character varying(4) NOT NULL,
    "STD_ID_COUNTRY" character varying(4) NOT NULL,
    "STD_ID_GEO_DIV" character varying(4) NOT NULL,
    "STD_ID_SUB_GEO_DIV" character varying(8) NOT NULL,
    "STD_N_SUB_GEO_ENG" character varying(62),
    "STD_N_SUB_GEO_ESP" character varying(62),
    "STD_N_SUB_GEO_FRA" character varying(62),
    "STD_N_SUB_GEO_GER" character varying(62),
    "STD_N_SUB_GEO_BRA" character varying(62),
    "STD_N_SUB_GEO_ITA" character varying(62),
    "STD_N_SUB_GEO_GEN" character varying(62),
    "ID_APPROLE" character varying(30),
    "SAR_ID_PROV_AFIP" character varying(4),
    "ID_SECUSER" character varying(30),
    "SCB_ID_ZONA_UPC" character varying(3),
    "DT_LAST_UPDATE" timestamp(0) without time zone,
    "SME_ID_ZONA_EC" character varying(2)
);
 %   DROP TABLE public."STD_SUB_GEO_DIV";
       public         heap    SLL    false            �            1259    16455    databasechangelog    TABLE     Y  CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);
 %   DROP TABLE public.databasechangelog;
       public         heap    SLLPE    false            �            1259    16450    databasechangeloglock    TABLE     �   CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);
 )   DROP TABLE public.databasechangeloglock;
       public         heap    SLLPE    false            �            1259    16463    jhi_persistent_audit_event    TABLE     �   CREATE TABLE public.jhi_persistent_audit_event (
    event_id bigint NOT NULL,
    principal character varying(50) NOT NULL,
    event_date timestamp without time zone,
    event_type character varying(255)
);
 .   DROP TABLE public.jhi_persistent_audit_event;
       public         heap    SLLPE    false            �            1259    16468    jhi_persistent_audit_evt_data    TABLE     �   CREATE TABLE public.jhi_persistent_audit_evt_data (
    event_id bigint NOT NULL,
    name character varying(150) NOT NULL,
    value character varying(255)
);
 1   DROP TABLE public.jhi_persistent_audit_evt_data;
       public         heap    SLLPE    false            �            1259    16461    sequence_generator    SEQUENCE        CREATE SEQUENCE public.sequence_generator
    START WITH 1050
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sequence_generator;
       public          SLLPE    false            S          0    24572    M4SLL_ABOHON_NJ 
   TABLE DATA           �   COPY "SLL"."M4SLL_ABOHON_NJ" ("ID_ORGANIZATION", "ANJ_SECUENCIA", "MAB_SECUENCIA", "ANJ_OBSERVACION", "ANJ_MONTO", "ANJ_DT_START", "ANJ_DT_END", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    206   c�      T          0    24578    M4SLL_ASIENTOS_C 
   TABLE DATA           N  COPY "SLL"."M4SLL_ASIENTOS_C" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ORIGEN", "GRUPO", "LOTE", "DESCRIP", "STATUS", "ASIENTO", "CANT_ASIENTO", "CREATION_DATE", "ID_APPROLE2", "ID_SECUSER2", "DT_LAST_UPDATE2", "XX_FUN", "XX_EST", "XX_ERROR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    207   ��      U          0    24584    M4SLL_ASIENTOS_D 
   TABLE DATA           �  COPY "SLL"."M4SLL_ASIENTOS_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ASD_SECUENCIA", "ORIGEN", "GRUPO", "LOTE", "MONEDA", "FCREA", "UCREA", "CATEGORIA", "CTACBLE", "EMPRESA", "RENGLON", "FECCONT", "PAIS", "DIVISION", "DEPTO", "ACTIV", "VALDB", "VALCR", "FGRAB", "HGRAB", "STATUS", "TCIDEA", "SCIDEA", "NCIDEA", "DLOTE", "IMPDB", "IMPCR", "TASACON", "FCONMON", "NOMASIEN", "DASIEN", "HISTORICO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    208   ��      W          0    24593    M4SLL_AUTOR_REU 
   TABLE DATA           B  COPY "SLL"."M4SLL_AUTOR_REU" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "STD_OR_HR_PERIOD", "MAB_SECUENCIA", "MTE_ID_TP_EMPLEADO", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "TPE_ID_TP_ENTIDAD", "AUR_CK_SUBSIDIARIO", "AUR_CK_SOLIDARIO", "AUR_MONTO_INDEMNIZACION", "AUR_CAUSA_DESVINCULACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "ECI_ID_CIUDAD") FROM stdin;
    SLL          SLL    false    210   ��      [          0    24617    M4SLL_AUTOR_REU_1 
   TABLE DATA           �  COPY "SLL"."M4SLL_AUTOR_REU_1" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    214   ��      X          0    24599    M4SLL_AUTOR_REU_BKP 
   TABLE DATA           !  COPY "SLL"."M4SLL_AUTOR_REU_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPE_ID_TP_ENTIDAD", "AUR_CK_SUBSIDIARIO", "AUR_CK_SOLIDARIO", "AUR_MONTO_INDEMNIZACION", "AUR_CAUSA_DESVINCULACION", "MTE_ID_TP_EMPLEADO", "MAB_SECUENCIA") FROM stdin;
    SLL          SLL    false    211   ��      Y          0    24605    M4SLL_AUTOR_REU_PRUEBA_GABY 
   TABLE DATA           =  COPY "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "STD_OR_HR_PERIOD", "MAB_SECUENCIA", "MTE_ID_TP_EMPLEADO", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "TPE_ID_TP_ENTIDAD", "AUR_CK_SUBSIDIARIO", "AUR_CK_SOLIDARIO", "AUR_MONTO_INDEMNIZACION", "AUR_CAUSA_DESVINCULACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    212   �      Z          0    24611    M4SLL_AUTOR_REU_QA 
   TABLE DATA           �  COPY "SLL"."M4SLL_AUTOR_REU_QA" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPE_ID_TP_ENTIDAD") FROM stdin;
    SLL          SLL    false    213   .�      \          0    24623    M4SLL_AUT_REU_DOC 
   TABLE DATA           �   COPY "SLL"."M4SLL_AUT_REU_DOC" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARD_SECUENCIA", "ARD_URL_DOCUMENTO", "ARD_FECHA_DOCUMENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    215   K�      V          0    24590    M4SLL_AU_REU_ANALI 
   TABLE DATA           �   COPY "SLL"."M4SLL_AU_REU_ANALI" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARA_SECUENCIA", "ARA_CENTRO_COSTO", "ARA_SEGMENTO", "ARA_DIVISION", "STD_ID_LEG_ENT", "ARA_REGION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    209   h�      ]          0    24629    M4SLL_CASUIS_CTAS 
   TABLE DATA           �   COPY "SLL"."M4SLL_CASUIS_CTAS" ("ID_ORGANIZATION", "CCU_CASO", "CCU_NRO_ASIENTO", "CCU_DEBE_HABER", "CCU_CUENTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    216   ��      ^          0    24632    M4SLL_CASUIS_CTAS_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_CASUIS_CTAS_PRUEBA_GABY" ("ID_ORGANIZATION", "CCU_CASO", "CCU_NRO_ASIENTO", "CCU_DEBE_HABER", "CCU_CUENTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    217   ��      _          0    24635    M4SLL_CCB_RAMAJUDC 
   TABLE DATA           >  COPY "SLL"."M4SLL_CCB_RAMAJUDC" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    218   ��      `          0    24641    M4SLL_CCB_RAMAJUDC_10 
   TABLE DATA           A  COPY "SLL"."M4SLL_CCB_RAMAJUDC_10" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    219   ��      a          0    24647    M4SLL_CCB_RAMAJUDC_20 
   TABLE DATA           A  COPY "SLL"."M4SLL_CCB_RAMAJUDC_20" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    220   ��      b          0    24653    M4SLL_CCB_RAMAJUDD 
   TABLE DATA           #  COPY "SLL"."M4SLL_CCB_RAMAJUDD" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    221   �      e          0    24671    M4SLL_CCB_RAMAJUDD2 
   TABLE DATA           $  COPY "SLL"."M4SLL_CCB_RAMAJUDD2" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    224   3�      c          0    24659    M4SLL_CCB_RAMAJUDD_10 
   TABLE DATA           &  COPY "SLL"."M4SLL_CCB_RAMAJUDD_10" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    222   P�      d          0    24665    M4SLL_CCB_RAMAJUDD_1000 
   TABLE DATA           (  COPY "SLL"."M4SLL_CCB_RAMAJUDD_1000" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    223   m�      f          0    24677    M4SLL_CCB_RAMAJUDD_20 
   TABLE DATA           &  COPY "SLL"."M4SLL_CCB_RAMAJUDD_20" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    225   ��      g          0    24683    M4SLL_CCB_RJCC_BKP 
   TABLE DATA           >  COPY "SLL"."M4SLL_CCB_RJCC_BKP" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    226   ��      h          0    24689    M4SLL_CCB_RJCD_BKP 
   TABLE DATA           #  COPY "SLL"."M4SLL_CCB_RJCD_BKP" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    227   ��      j          0    24698    M4SLL_CIERRES_MENS 
   TABLE DATA           �   COPY "SLL"."M4SLL_CIERRES_MENS" ("ID_ORGANIZATION", "CIM_ANIO", "CIM_MES", "MTC_ID_TAREA", "MEE_ID_EST_EJECUCION", "MET_ID_EST_TAREA", "CIM_DT_EJECUCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    229   ��      i          0    24695    M4SLL_CIERRE_MENSUAL 
   TABLE DATA           b   COPY "SLL"."M4SLL_CIERRE_MENSUAL" ("CIM_ANIO", "CIM_MES", "ID_TAREA", "ESTADO_TAREA") FROM stdin;
    SLL          SLL    false    228   ��      k          0    24701    M4SLL_CLIENTES_OMB 
   TABLE DATA           �   COPY "SLL"."M4SLL_CLIENTES_OMB" ("ID_ORGANIZATION", "CLO_ID_CLIENTE", "CLO_NM_CLIENTE", "CLO_DT_START", "CLO_DT_END", "CLO_ID_APP_ROLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    230   �      l          0    24704    M4SLL_CLIENTES_ROL 
   TABLE DATA           �   COPY "SLL"."M4SLL_CLIENTES_ROL" ("ID_ORGANIZATION", "CLO_ID_CLIENTE", "CLR_ID_ROLE", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    231   8�      q          0    24729    M4SLL_COMPROMISOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_COMPROMISOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TCO_ID_TP_COMPROMISO", "COM_SECUENCIA", "MAB_SECUENCIA", "TFA_ID_TP_FASE", "COR_ID_COMP_RESULTADO", "COM_FECHA", "COM_OBSERVACION", "COE_ID_COMP_ESTADO", "COM_DT_END", "COM_RESPONSABLE", "COM_DT_INICIO", "COM_ACTUACION", "COM_NOTAS", "COM_DT_INICIO_TERMINO", "COM_DT_FIN_TERMINO", "COM_DT_REGISTRO", "COM_URL_DOCUMENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COM_NM_DOCUMENTO", "COM_SECUENCIAL") FROM stdin;
    SLL          SLL    false    236   U�      r          0    24735    M4SLL_COMPROMISOS_BKP 
   TABLE DATA           �  COPY "SLL"."M4SLL_COMPROMISOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TCO_ID_TP_COMPROMISO", "COM_SECUENCIA", "TFA_ID_TP_FASE", "COR_ID_COMP_RESULTADO", "COM_FECHA", "COM_OBSERVACION", "COE_ID_COMP_ESTADO", "COM_DT_END", "COM_RESPONSABLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COM_DT_INICIO", "COM_ACTUACION", "COM_NOTAS", "COM_DT_INICIO_TERMINO", "COM_DT_FIN_TERMINO", "COM_DT_REGISTRO", "COM_URL_DOCUMENTO", "MAB_SECUENCIA") FROM stdin;
    SLL          SLL    false    237   r�      m          0    24707    M4SLL_COMP_DETALLE 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_DETALLE" ("ID_ORGANIZATION", "COM_SECUENCIA", "LIT_ID_LITIGIO", "COE_ID_COMP_ESTADO", "COR_ID_COMP_RESULTADO", "COD_FECHA", "COD_OBSERVACION", "COD_SECUENCIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    232   ��      n          0    24713    M4SLL_COMP_DOC 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_DOC" ("ID_ORGANIZATION", "TCO_ID_TP_COMPROMISO", "LIT_ID_LITIGIO", "COD_SECUENCIA", "COM_SECUENCIA", "COD_URL_DOCUMENTO", "COD_FECHA_DOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    233   ��      o          0    24719    M4SLL_COMP_ESTADOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_ESTADOS" ("ID_ORGANIZATION", "COE_ID_COMP_ESTADO", "COE_NM_COMP_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COE_DT_START", "COE_DT_END") FROM stdin;
    SLL          SLL    false    234   ��      p          0    24724    M4SLL_COMP_RESULTA 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_RESULTA" ("ID_ORGANIZATION", "COR_ID_COMP_RESULTADO", "COR_NM_COMP_RESULTADO", "TCO_ID_TP_COMPROMISO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COR_DT_START", "COR_DT_END") FROM stdin;
    SLL          SLL    false    235   ��      s          0    24741    M4SLL_CONVERSION 
   TABLE DATA           �   COPY "SLL"."M4SLL_CONVERSION" ("ID_ORGANIZATION", "CON_REFERENCIA", "CON_VALOR_CONVERTIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    238   �      t          0    24747    M4SLL_COTIZACION 
   TABLE DATA           �   COPY "SLL"."M4SLL_COTIZACION" ("ID_ORGANIZATION", "COT_ANIO", "COT_MES", "COT_COTIZACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    239    �      u          0    24750    M4SLL_CPE_CEJPJ_C 
   TABLE DATA           (  COPY "SLL"."M4SLL_CPE_CEJPJ_C" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "CCC_DEMANDANTE", "CCC_DEMANDADO", "CCC_ORGANO", "CCC_DISTRITO", "CCC_JUEZ", "CCC_FECHA_INICIO", "CCC_PROCESO", "CCC_ESPECIALIDAD", "CCC_MATERIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    240   =�      v          0    24756    M4SLL_CPE_CEJPJ_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_CPE_CEJPJ_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "CCD_ID_SECUENCIA", "CCD_SUMILLA_SEGUIMIENTO", "CCD_FECHA_SEGUIMIENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    241   Z�      w          0    24762    M4SLL_CTRL_ERRORES 
   TABLE DATA           �   COPY "SLL"."M4SLL_CTRL_ERRORES" ("ID_ORGANIZATION", "CTE_USUARIO", "CTE_FECHA", "CTE_MODULO", "CTE_DESCRIPCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    242   w�      x          0    24768    M4SLL_CUADRANTE 
   TABLE DATA           �  COPY "SLL"."M4SLL_CUADRANTE" ("ID_ORGANIZATION", "ORDINAL_10_PK", "ARG_CSP_COD_EMPR", "ARG_CSP_NOM_EMPR", "ARG_CSP_SSN", "ARG_CSP_ID_HR", "ARG_CSP_OR_HR_PER", "ARG_CSP_N_FIRST_NAME", "ARG_CSP_COD_ACT", "ARG_CSP_COD_DELEG", "ARG_CSP_NOM_DELEG", "ARG_CSP_ANNO_MES", "ARG_CSP_FEC_MOBRA", "ARG_CSP_COD_CLI", "ARG_CSP_NOM_CLI", "ARG_CSP_COD_SER", "ARG_CSP_NOM_SER", "ARG_CSP_FI_SERVI", "ARG_CSP_HORA_FI_SERVI", "ARG_CSP_FF_SERVI", "ARG_CSP_HORA_FF_SERVI", "ARG_CSP_HORAS_NOCT", "ARG_CSP_HORAS_DIUR", "ARG_CSP_FIN_FEST", "ARG_CSP_ARMA", "ARG_CSP_DIA_SEMANA", "ARG_CSP_FESTIVO", "CUA_CK_CLIENTE", "CUA_CK_OBJETIVO", "CUA_CK_GT_HORAS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    243   ��      y          0    24774    M4SLL_CUADRANTE_LOG 
   TABLE DATA           �   COPY "SLL"."M4SLL_CUADRANTE_LOG" ("ID_ORGANIZATION", "CLG_SQLCOD_ERROR", "CLG_SQLMSG_ERROR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    244   ��      z          0    24780    M4SLL_DATOS_WF 
   TABLE DATA           �   COPY "SLL"."M4SLL_DATOS_WF" ("ID_ORGANIZATION", "ID_BPC", "MODULO", "ID_MODULE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    245   ��      {          0    24783    M4SLL_DESTINATARIO 
   TABLE DATA           �   COPY "SLL"."M4SLL_DESTINATARIO" ("ID_ORGANIZATION", "DES_ID_DESTINATARIO", "DES_NM_DESTINATARIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    246   ��                0    24802    M4SLL_DOCPAG 
   TABLE DATA           �  COPY "SLL"."M4SLL_DOCPAG" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "DCP_SECUENCIA", "DCP_DESCRIPCION", "DCP_FEC_CRE", "DCP_NRO_SOLICITUD", "DCP_APROB_ABOGADO_INT", "DCP_APROB_BACK_OFFICE", "DCP_APROB_GERENCIAL", "DCP_STATUS", "DCP_NRO_IDENTIFICACION", "DCP_DESTINATARIO", "DCP_TIPO_CUENTA", "DCP_NRO_CUENTA_DES", "DCP_EMAIL_DEST", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "DCP_DESTINATARI1") FROM stdin;
    SLL          SLL    false    250   �      |          0    24786    M4SLL_DOC_LITIGIOS 
   TABLE DATA           ?  COPY "SLL"."M4SLL_DOC_LITIGIOS" ("ID_ORGANIZATION", "DOL_SECUENCIA", "LIT_ID_LITIGIO", "TDL_ID_TP_DOC_LITIGIO", "DOL_FECHA", "DOL_OBSERVACION", "DOL_URL_DOC_LIT", "DOO_ID_DOC_ORIGEN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TFA_ID_TP_FASE", "DOL_CK_ASOCIA_FASE", "DOL_NOMBRE", "DOL_DT_NOTIFICACION") FROM stdin;
    SLL          SLL    false    247   %�      }          0    24793    M4SLL_DOC_LITIGIOS_BKP 
   TABLE DATA             COPY "SLL"."M4SLL_DOC_LITIGIOS_BKP" ("ID_ORGANIZATION", "DOL_SECUENCIA", "LIT_ID_LITIGIO", "TDL_ID_TP_DOC_LITIGIO", "DOL_FECHA", "DOL_OBSERVACION", "DOL_URL_DOC_LIT", "DOO_ID_DOC_ORIGEN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TFA_ID_TP_FASE", "DOL_CK_ASOCIA_FASE") FROM stdin;
    SLL          SLL    false    248   B�      ~          0    24799    M4SLL_DOC_ORIGENES 
   TABLE DATA           �   COPY "SLL"."M4SLL_DOC_ORIGENES" ("ID_ORGANIZATION", "DOO_ID_DOC_ORIGEN", "DOO_NM_DOC_ORIGEN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    249   _�      �          0    24808    M4SLL_ENTIDADES 
   TABLE DATA           2  COPY "SLL"."M4SLL_ENTIDADES" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "ENT_ID_ENTIDAD", "ENT_NM_ENTIDAD", "TPE_ID_TP_ENTIDAD", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "ENT_DT_END", "ENT_DT_START", "ENT_TP_EMPLEADO", "ENT_ID_NEGOCIO") FROM stdin;
    SLL          SLL    false    251   |�      �          0    24816    M4SLL_ENTIDADES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_ENTIDADES_BKP" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "ENT_ID_ENTIDAD", "ENT_NM_ENTIDAD", "TPE_ID_TP_ENTIDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    252   ��      �          0    24822    M4SLL_ESP_CIUDADES 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_CIUDADES" ("ID_ORGANIZATION", "ECI_ID_CIUDAD", "ECI_NM_CIUDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    253   ��      �          0    24825    M4SLL_ESP_DELEGACI 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_DELEGACI" ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "EDE_NM_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    254   ��      �          0    24828    M4SLL_ESP_DELEGACI_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY" ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "EDE_NM_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    255   ��      �          0    24831    M4SLL_ESP_LIT_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_LIT_PROV" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "ELP_ANIO", "ELP_MES", "ELP_VALOR_PROVISION", "ELP_PORCENTAJE_PROV", "LIT_VALOR_PED_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    256   �      �          0    24839    M4SLL_ESTUDIO_JUR 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESTUDIO_JUR" ("ID_ORGANIZATION", "EJU_ID_EST_JURIDICO", "EJU_NM_EST_JURIDICO", "EJU_EMAIL", "EJU_TEL_OFICINA", "EJU_TEL_MOVIL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "EJU_DT_END", "EJU_DT_START") FROM stdin;
    SLL          SLL    false    258   *�      �          0    24847    M4SLL_ESTUDIO_JUR_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESTUDIO_JUR_BKP" ("ID_ORGANIZATION", "EJU_ID_EST_JURIDICO", "EJU_NM_EST_JURIDICO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "EJU_EMAIL", "EJU_TEL_OFICINA", "EJU_TEL_MOVIL") FROM stdin;
    SLL          SLL    false    259   G�      �          0    24834    M4SLL_EST_JUR_SUB 
   TABLE DATA           �   COPY "SLL"."M4SLL_EST_JUR_SUB" ("ID_ORGANIZATION", "EJU_ID_EST_JURIDICO", "EJS_ID_EST_JUR_SUB", "EJS_NM_EST_JUR_SUB", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "EJS_DT_START", "EJS_DT_END") FROM stdin;
    SLL          SLL    false    257   d�      �          0    24853    M4SLL_EXEC_RP_LITIGIO 
   TABLE DATA           P   COPY "SLL"."M4SLL_EXEC_RP_LITIGIO" ("USUARIO", "SQL", "FECHA_HORA") FROM stdin;
    SLL          SLL    false    260   ��      �          0    24859    M4SLL_EXP_PED 
   TABLE DATA           c   COPY "SLL"."M4SLL_EXP_PED" ("LIT_ID_LEGADO", "LIT_VALOR_TOTAL", "LIT_VALOR_PED_TOTAL") FROM stdin;
    SLL          SLL    false    261   ��      �          0    24862    M4SLL_FASES 
   TABLE DATA           �  COPY "SLL"."M4SLL_FASES" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAS_ID_FASE_ESTADO", "FAR_ID_FASE_RESULTADO", "FAS_FECHA", "FAS_OBSERVACION", "FAS_DT_CITACION", "FAS_NRO_RADICACION", "TRI_ID_TRIBUNAL", "FAS_JUEZ", "FAS_VALOR_CONDENA", "FAS_VALOR_HONORARIOS", "FAS_PORC_CONDENA", "FAS_PORC_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "FAS_CHK_ROBOT", "FAS_SECUENCIA", "FAS_NUM_JUZGADO", "FAS_FECHA_COND", "FAS_FECHA_HON", "FAS_OBS_HON", "FAS_DT_IMPACTO", "FAS_HORA") FROM stdin;
    SLL          SLL    false    262   ��      �          0    24868    M4SLL_FASES_BKP 
   TABLE DATA           �  COPY "SLL"."M4SLL_FASES_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAS_ID_FASE_ESTADO", "FAR_ID_FASE_RESULTADO", "FAS_FECHA", "FAS_OBSERVACION", "FAS_DT_CITACION", "FAS_NRO_RADICACION", "TRI_ID_TRIBUNAL", "FAS_JUEZ", "FAS_VALOR_CONDENA", "FAS_VALOR_HONORARIOS", "FAS_PORC_CONDENA", "FAS_PORC_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "FAS_CHK_ROBOT", "FAS_SECUENCIA") FROM stdin;
    SLL          SLL    false    263   ��      �          0    24874    M4SLL_FASES_DOC 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_DOC" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAD_SECUENCIA", "FAD_URL_DOCUMENTO", "FAS_FECHA_DOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    264   ��      �          0    24880    M4SLL_FASES_ESTADO 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_ESTADO" ("ID_ORGANIZATION", "FAS_ID_FASE_ESTADO", "FAS_NM_FASE_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "FAS_DT_START", "FAS_DT_END") FROM stdin;
    SLL          SLL    false    265   �      �          0    24885    M4SLL_FASES_PROV 
   TABLE DATA           H  COPY "SLL"."M4SLL_FASES_PROV" ("ID_ORGANIZATION", "FAP_SECUENCIA", "LIT_ID_LITIGIO", "FAP_DT_IMPACTO", "FAP_FECHA", "FAP_VALOR_CONDENA", "FAP_VALOR_HONORARIOS", "FAP_PORC_CONDENA", "FAP_PORC_HONORARIOS", "FAP_FECHA_COND", "FAP_FECHA_HON", "FAP_OBS_COND", "FAP_OBS_HON", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    266   /�      �          0    24891    M4SLL_FASES_PROV_BKP 
   TABLE DATA           ^  COPY "SLL"."M4SLL_FASES_PROV_BKP" ("ID_ORGANIZATION", "FAP_SECUENCIA", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAP_DT_IMPACTO", "FAP_FECHA", "FAP_VALOR_CONDENA", "FAP_VALOR_HONORARIOS", "FAP_PORC_CONDENA", "FAP_PORC_HONORARIOS", "FAP_FECHA_COND", "FAP_FECHA_HON", "FAP_OBS_COND", "FAP_OBS_HON", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    267   L�      �          0    24897    M4SLL_FASES_RESULT 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_RESULT" ("ID_ORGANIZATION", "FAR_ID_FASE_RESULTADO", "TFA_ID_TP_FASE", "FAR_NM_FASE_RESULTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "FAR_DT_START", "FAR_DT_END") FROM stdin;
    SLL          SLL    false    268   i�      �          0    24902    M4SLL_FASES_RESULT_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_RESULT_BKP" ("ID_ORGANIZATION", "FAR_ID_FASE_RESULTADO", "TFA_ID_TP_FASE", "FAR_NM_FASE_RESULTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    269   ��      �          0    24905    M4SLL_HIS_DET_PROV 
   TABLE DATA           	  COPY "SLL"."M4SLL_HIS_DET_PROV" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "MDP_ID_DET_PROVISION", "HDP_DT_PERIODO", "HDP_VALOR", "HDP_PORC_PROV", "HDP_MONTO_A_PROVISIONAR", "HDP_MONTO_PAGADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    270   ��      �          0    24908    M4SLL_INI_PARAM_CALC_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_INI_PARAM_CALC_PROV" ("IPAR_SECUENCIA", "ID_ORGANIZATION", "IPAR_PROCESO", "IPAR_NOMBRE", "IPAR_DESC", "IPAR_VAL_NUMBER", "IPAR_VAL_DATE", "IPAR_VAL_CHAR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    271   ��      �          0    24920    M4SLL_INT_GL_TRXS 
   TABLE DATA           �  COPY "SLL"."M4SLL_INT_GL_TRXS" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "RENGLON", "EMPRESA", "FECCONT", "MONEDA", "FCREA", "UCREA", "CATEGORIA", "CTACBLE", "PAIS", "DIVISION", "DEPTO", "ACTIV", "VALDB", "VALCR", "FGRAB", "HGRAB", "STATUS", "TCIDEA", "SCIDEA", "NCIDEA", "DLOTE", "IMPDB", "IMPCR", "TASACON", "FCONMON", "NOMASIEN", "DASIEN", "DLINEA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    274   ��      �          0    24926    M4SLL_INT_GL_TRXS_PRUEBA_GABY 
   TABLE DATA           �  COPY "SLL"."M4SLL_INT_GL_TRXS_PRUEBA_GABY" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "RENGLON", "EMPRESA", "FECCONT", "MONEDA", "FCREA", "UCREA", "CATEGORIA", "CTACBLE", "PAIS", "DIVISION", "DEPTO", "ACTIV", "VALDB", "VALCR", "FGRAB", "HGRAB", "STATUS", "TCIDEA", "SCIDEA", "NCIDEA", "DLOTE", "IMPDB", "IMPCR", "TASACON", "FCONMON", "NOMASIEN", "DASIEN", "DLINEA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    275   ��      �          0    24914    M4SLL_INT_GL_TRX_L 
   TABLE DATA           !  COPY "SLL"."M4SLL_INT_GL_TRX_L" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "LIT_ID_LITIGIO", "DESCRIP", "STATUS", "ASIENTO", "CANT_ASIENTO", "CREATION_DATE", "ID_APPROLE2", "ID_SECUSER2", "DT_LAST_UPDATE2", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "IGT_IMPORTE_LOTE") FROM stdin;
    SLL          SLL    false    272   �      �          0    24917    M4SLL_INT_GL_TRX_L_PRUEBA_GABY 
   TABLE DATA           -  COPY "SLL"."M4SLL_INT_GL_TRX_L_PRUEBA_GABY" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "LIT_ID_LITIGIO", "DESCRIP", "STATUS", "ASIENTO", "CANT_ASIENTO", "CREATION_DATE", "ID_APPROLE2", "ID_SECUSER2", "DT_LAST_UPDATE2", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "IGT_IMPORTE_LOTE") FROM stdin;
    SLL          SLL    false    273   4�      �          0    24932    M4SLL_INT_LIST_LITIGIOS 
   TABLE DATA           D   COPY "SLL"."M4SLL_INT_LIST_LITIGIOS" ("LIT_ID_LITIGIO") FROM stdin;
    SLL          SLL    false    276   Q�      �          0    24941    M4SLL_INT_PAGO_NOM 
   TABLE DATA           �  COPY "SLL"."M4SLL_INT_PAGO_NOM" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PNO_LOTE", "TPA_ID_PAGO", "PNO_VALOR", "PNO_FECHA", "STD_ID_PERSON", "STD_ID_LEG_ENT", "PNO_PRINCIPAL_S_N", "PNO_INTERESES", "PNO_SALARIO_DIA", "PNO_COTIZACION", "SSP_ID_CABEC_TC1", "PNO_CUENTA_ABONO", "PNO_CODIGO_IBAN", "PNO_OTRAS_CUENTAS", "PNO_BENEFICIARIO", "IPN_IMPORTE_BRUTO", "IPN_DESCUENTOS_S_S", "LIT_NRO_PROCESO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "STD_OR_HR_PERIOD", "PNO_F_FIN_SANCION", "PNO_F_INI_SANCION", "PNO_APLICA_SAL_DIA", "PNO_F_REINCORP", "PNO_ADJ_VIDA_LAB", "PNO_F_IMP_HASTA", "PNO_F_IMP_DESDE", "PNO_RECON_DERECHO", "IPN_DESC_IRPF", "PNO_F_ENV_NOM", "IPN_F_TRANSF", "IPN_RET_JUDICIAL", "IPN_IMP_TRANSF", "PNO_NRO_C_JUZ", "PNO_F_VENCIMIENTO", "PNO_ANT_RECONOCIDA", "PNO_DIAS_SANCIONA", "IPN_APLI_SAN_S_N", "IPN_LETRA_JUZGADO", "IPN_COD_IBAN_GENE", "IPN_NRO_EXP", "TPA_NM_PAGO", "PNO_NETO_S_N") FROM stdin;
    SLL          SLL    false    278   n�      �          0    24935    M4SLL_INT_PAG_NO_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_INT_PAG_NO_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "MCO_ID_CONCEPTO", "PND_FECHA_DESDE", "PND_FECHA_HASTA", "PND_IMPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MCO_NM_CONCEPTO") FROM stdin;
    SLL          SLL    false    277   ��      �          0    24959    M4SLL_LITIGIOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_LITIGIOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MCA_ID_CODIGO_ALTERNO", "MRI_ID_RIESGO", "MMA_ID_MATERIA", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS", "LIT_PREVISION", "LIT_PROVISION", "LIT_IMPORTE_TRANSF", "LIT_DESCUENTOS_S_S_TOTAL", "LIT_IMPORTE_BRUTO_TOTAL", "LIT_RETENCION_JUDICIAL_TOTAL", "LIT_DESCUENTOS_IRPF_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_CK_CALC_PROV") FROM stdin;
    SLL          SLL    false    281   ��      �          0    24965    M4SLL_LITIGIOS_BKP 
   TABLE DATA              COPY "SLL"."M4SLL_LITIGIOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL") FROM stdin;
    SLL          SLL    false    282   OK      �          0    24971    M4SLL_LITIGIOS_BKP_COL 
   TABLE DATA           $  COPY "SLL"."M4SLL_LITIGIOS_BKP_COL" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "MMA_ID_MATERIA", "MRI_ID_RIESGO", "MCA_ID_CODIGO_ALTERNO", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS") FROM stdin;
    SLL          SLL    false    283   lK      �          0    24977    M4SLL_LITIGIOS_GGA 
   TABLE DATA           �  COPY "SLL"."M4SLL_LITIGIOS_GGA" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MCA_ID_CODIGO_ALTERNO", "MRI_ID_RIESGO", "MMA_ID_MATERIA", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS", "LIT_PREVISION", "LIT_PROVISION", "LIT_IMPORTE_TRANSF", "LIT_DESCUENTOS_S_S_TOTAL", "LIT_IMPORTE_BRUTO_TOTAL", "LIT_RETENCION_JUDICIAL_TOTAL", "LIT_DESCUENTOS_IRPF_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    284   �K      �          0    24983    M4SLL_LITIGIOS_HIS 
   TABLE DATA           �   COPY "SLL"."M4SLL_LITIGIOS_HIS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIH_SECUENCIA", "LIH_COLUM_ALTERADA", "LIH_FECHA_ALTERADA", "LIH_ID_OLD", "LIH_ID_NUEVO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    285   �K      �          0    24986    M4SLL_LITIGIOS_PRUEBA_GABY 
   TABLE DATA           �  COPY "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MCA_ID_CODIGO_ALTERNO", "MRI_ID_RIESGO", "MMA_ID_MATERIA", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS", "LIT_PREVISION", "LIT_PROVISION", "LIT_IMPORTE_TRANSF", "LIT_DESCUENTOS_S_S_TOTAL", "LIT_IMPORTE_BRUTO_TOTAL", "LIT_RETENCION_JUDICIAL_TOTAL", "LIT_DESCUENTOS_IRPF_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_PORC_PROVISION") FROM stdin;
    SLL          SLL    false    286   �K      �          0    24992    M4SLL_LITIGOS_BKP 
   TABLE DATA           T  COPY "SLL"."M4SLL_LITIGOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC") FROM stdin;
    SLL          SLL    false    287   �K      �          0    24947    M4SLL_LIT_HECHOS 
   TABLE DATA           
  COPY "SLL"."M4SLL_LIT_HECHOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIH_SECUENCIA", "LIH_HECHO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIH_DT_INICIAL", "LIH_DT_FINAL", "LIH_SALARIO_PERIODO", "LIH_CK_AFILIACION_SINDICATO", "LIH_DESC_SINDICATO") FROM stdin;
    SLL          SLL    false    279   �K      �          0    24953    M4SLL_LIT_HECHOS_BKP 
   TABLE DATA             COPY "SLL"."M4SLL_LIT_HECHOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIH_SECUENCIA", "LIH_HECHO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIH_DT_INICIAL", "LIH_DT_FINAL", "LIH_SALARIO_PERIODO", "LIH_CK_AFILIACION_SINDICATO", "LIH_DESC_SINDICATO") FROM stdin;
    SLL          SLL    false    280   L      �          0    24998    M4SLL_LIT_SEGUIMIE 
   TABLE DATA           �   COPY "SLL"."M4SLL_LIT_SEGUIMIE" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIS_SECUENCIA", "LIS_SEGUIMIENTO", "STD_ID_PERSON", "LIS_FECHA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    288   7L      �          0    25004    M4SLL_LIT_VINCULAD 
   TABLE DATA           �   COPY "SLL"."M4SLL_LIT_VINCULAD" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIV_SECUENCIA", "LIV_ID_LITIGIO", "LIV_OBSERVACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    289   TL      �          0    25025    M4SLL_MATRIZ_PREDI 
   TABLE DATA           >  COPY "SLL"."M4SLL_MATRIZ_PREDI" ("ID_ORGANIZATION", "MPR_ANIO", "MPR_MES", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "MPR_VALOR_TOTAL", "MPR_VALOR_PED_TOTAL", "MPR_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    295   qL      �          0    25010    M4SLL_MATRIZ_PRE_C 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_C" ("ID_ORGANIZATION", "MPC_SECUENCIA", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    290   �L      �          0    25013    M4SLL_MATRIZ_PRE_C_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_C_BKP" ("ID_ORGANIZATION", "MPC_SECUENCIA", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    291   �L      �          0    25016    M4SLL_MATRIZ_PRE_C_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" ("ID_ORGANIZATION", "MPC_SECUENCIA", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    292   �L      �          0    25019    M4SLL_MATRIZ_PRE_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_D" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "MPD_VALOR_TOTAL", "MPD_VALOR_PED_TOTAL", "MPD_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    293   �L      �          0    25022    M4SLL_MATRIZ_PRE_D_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_D_BKP" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "MPD_VALOR_TOTAL", "MPD_VALOR_PED_TOTAL", "MPD_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    294   M      �          0    25028    M4SLL_MATRIZ_PRE_D_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "MPD_VALOR_TOTAL", "MPD_VALOR_PED_TOTAL", "MPD_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    296   M      �          0    25031    M4SLL_MATRIZ_PRE_PARAM 
   TABLE DATA           y   COPY "SLL"."M4SLL_MATRIZ_PRE_PARAM" ("MPP_ID_ORDEN", "MPP_PARAM_CAMPO", "MPP_CAMPO_DESAGRUPAR", "MPP_WHERE") FROM stdin;
    SLL          SLL    false    297   <M      �          0    25037    M4SLL_MEDIO_PAGOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MEDIO_PAGOS" ("ID_ORGANIZATION", "MEP_ID_MEDIO_PAGO", "MEP_NM_MEDIO_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MEP_DT_START", "MEP_DT_END") FROM stdin;
    SLL          SLL    false    298   YM      �          0    25042    M4SLL_MODULO_ROL 
   TABLE DATA           �   COPY "SLL"."M4SLL_MODULO_ROL" ("ID_ORGANIZATION", "MOR_SECUENCIA", "MTM_ID_MODULO", "MRA_ID_ROL_ACTOR", "MOR_CAMPO", "MOR_TABLA", "MOR_FUNCION", "MOR_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    299   vM      �          0    25061    M4SLL_MTO_COD_ALT 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_COD_ALT" ("ID_ORGANIZATION", "MCA_ID_CODIGO_ALTERNO", "MCA_NM_CODIGO_ALTERNO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MCA_DT_END", "MCA_DT_START") FROM stdin;
    SLL          SLL    false    302   �M      �          0    25066    M4SLL_MTO_COD_ALT_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_COD_ALT_BKP" ("ID_ORGANIZATION", "MCA_ID_CODIGO_ALTERNO", "MCA_NM_CODIGO_ALTERNO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    303   �M      �          0    25069    M4SLL_MTO_CONCEPTO 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_CONCEPTO" ("ID_ORGANIZATION", "MCO_ID_CONCEPTO", "MCO_NM_CONCEPTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    304   �M      �          0    25075    M4SLL_MTO_DET_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_DET_PROV" ("ID_ORGANIZATION", "MDP_ID_DET_PROVISION", "MDP_NM_DET_PROVISION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MDP_CUENTA_DEBE", "MDP_CUENTA_HABER", "MDP_DT_START", "MDP_DT_END") FROM stdin;
    SLL          SLL    false    305   �M      �          0    25080    M4SLL_MTO_DET_PROV_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_DET_PROV_BKP" ("ID_ORGANIZATION", "MDP_ID_DET_PROVISION", "MDP_NM_DET_PROVISION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MDP_CUENTA_DEBE", "MDP_CUENTA_HABER") FROM stdin;
    SLL          SLL    false    306   N      �          0    25083    M4SLL_MTO_EMP_ORG 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_EMP_ORG" ("ID_ORGANIZATION", "STD_ID_LEG_ENT", "ORG_ID", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MEO_DT_START", "MEO_DT_END") FROM stdin;
    SLL          SLL    false    307   $N      �          0    25088    M4SLL_MTO_ESTADOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_ESTADOS" ("ID_ORGANIZATION", "MOR_ESTADO", "MTE_NM_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    308   AN      �          0    25094    M4SLL_MTO_EST_EJE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_EST_EJE" ("ID_ORGANIZATION", "MEE_ID_EST_EJECUCION", "MEE_NM_EST_EJECUCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    309   ^N      �          0    25097    M4SLL_MTO_EST_TARE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_EST_TARE" ("ID_ORGANIZATION", "MET_ID_EST_TAREA", "MET_NM_EST_TAREA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    310   {N      �          0    25100    M4SLL_MTO_FUNCION 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_FUNCION" ("ID_ORGANIZATION", "MOR_FUNCION", "MTF_NM_FUNCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    311   �N      �          0    25106    M4SLL_MTO_MATERIA 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_MATERIA" ("ID_ORGANIZATION", "MMA_ID_MATERIA", "MMA_NM_MATERIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MMA_DT_START", "MMA_DT_END") FROM stdin;
    SLL          SLL    false    312   �N      �          0    25111    M4SLL_MTO_MODULOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_MODULOS" ("ID_ORGANIZATION", "MTM_ID_MODULO", "MTM_NM_MODULO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MTM_ID_MOD_PADRE") FROM stdin;
    SLL          SLL    false    313   �N      �          0    25114    M4SLL_MTO_PEDIDO_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_PEDIDO_D" ("ID_ORGANIZATION", "MPD_ID_PEDIDO_DETALLE", "MPD_NM_PEDIDO_DETALLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "MPD_DT_START", "MPD_DT_END", "MPD_PAGO_NOMINA_DET_S_N") FROM stdin;
    SLL          SLL    false    314   �N      �          0    25119    M4SLL_MTO_RIESGOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_RIESGOS" ("ID_ORGANIZATION", "MRI_ID_RIESGO", "MRI_NM_RIESGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MRI_DT_START", "MRI_DT_END") FROM stdin;
    SLL          SLL    false    315   O      �          0    25124    M4SLL_MTO_RIESGOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_RIESGOS_BKP" ("ID_ORGANIZATION", "MRI_ID_RIESGO", "MRI_NM_RIESGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    316   )O      �          0    25127    M4SLL_MTO_ROL_ACTO 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_ROL_ACTO" ("ID_ORGANIZATION", "MRA_ID_ROL_ACTOR", "MRA_NM_ROL_ACTOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    317   FO      �          0    25130    M4SLL_MTO_SEG_INTE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_SEG_INTE" ("ID_ORGANIZATION", "ID_APP_ROLE", "MSI_SECUENCIA", "MSI_DT_START", "MSI_DT_END", "MSI_COLUMNA", "MSI_TABLA", "MSI_VALOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MTM_ID_MODULO") FROM stdin;
    SLL          SLL    false    318   cO      �          0    25136    M4SLL_MTO_TAR_CIE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_TAR_CIE" ("ID_ORGANIZATION", "MTC_ID_TAREA", "MTC_NM_TAREA", "MTC_NM_PROCEDIMIENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    319   �O      �          0    25142    M4SLL_MTO_TP_EMPLE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_TP_EMPLE" ("ID_ORGANIZATION", "MTE_ID_TP_EMPLEADO", "MTE_NM_TP_EMPLEADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MTE_DT_START", "MTE_DT_END") FROM stdin;
    SLL          SLL    false    320   �O      �          0    25048    M4SLL_MT_ABOGADOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_MT_ABOGADOS" ("ID_ORGANIZATION", "MAB_SECUENCIA", "MAB_NOMBRE", "MAB_APELLIDO", "MAB_EMAIL", "MAB_CHK_INT", "STD_ID_PERSON", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "MAB_DT_END", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MAB_DT_START", "MAB_N_CEDULA", "MAB_N_TARJ_PROF", "MAB_TELEFONO", "MAB_CELULAR", "MAB_DOMICILIO", "MAB_EMPRESA", "MAB_NIT", "MAB_DT_INICIO_CONTRATO", "MAB_DT_FIN_CONTRATO", "MAB_TIPO_VINCULACION", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE") FROM stdin;
    SLL          SLL    false    300   �O      �          0    25055    M4SLL_MT_ABOGADOS_BKP 
   TABLE DATA             COPY "SLL"."M4SLL_MT_ABOGADOS_BKP" ("ID_ORGANIZATION", "MAB_SECUENCIA", "MAB_NOMBRE", "MAB_APELLIDO", "MAB_EMAIL", "MAB_CHK_INT", "STD_ID_PERSON", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "MAB_DT_END", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    301   �O      �          0    25147    M4SLL_MT_ST_RE_PRO 
   TABLE DATA           �   COPY "SLL"."M4SLL_MT_ST_RE_PRO" ("ID_ORGANIZATION", "MSR_ID_STATUS_REPORTE", "MSR_NM_STATUS_REPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MSR_DT_START", "MSR_DT_END") FROM stdin;
    SLL          SLL    false    321   �O      �          0    25152    M4SLL_NEGOCIOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "NEG_NM_NEGOCIO", "LIT_CENTRO_COSTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "NEG_DIVISION") FROM stdin;
    SLL          SLL    false    322   P      �          0    25155    M4SLL_NEGOCIOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS_BKP" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "NEG_NM_NEGOCIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_CENTRO_COSTO") FROM stdin;
    SLL          SLL    false    323   .P      �          0    25158    M4SLL_NEGOCIOS_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "NEG_NM_NEGOCIO", "LIT_CENTRO_COSTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    324   KP      �          0    25161    M4SLL_NEGOCIOS_ROL 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS_ROL" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "ID_APP_ROLE", "SNR_CHK_SELECT", "SNR_CHK_INSERT", "SNR_CHK_UPDATE", "SNR_CHK_DELETE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    325   hP      �          0    25164    M4SLL_PAGOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_PAGOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "TSP_ID_SALIDA_PAGO", "DCP_SECUENCIA", "MEP_ID_MEDIO_PAGO", "STP_ID_STATUS_PAGO", "TPA_ID_PAGO", "PAG_VALOR", "PAG_FEC_EST", "PAG_FEC_VTO", "PAG_FEC_APR", "PAG_FEC_ERP", "PAG_FEC_PAG", "PAG_DESCRIPCION", "PAG_DOCUMENTO", "PAG_COMBINACION", "PAG_CK_COMB", "PAG_CK_RECUPERADO", "PAG_CK_SOLICITADO", "PAG_FECHA", "PAG_COMPROBANTE", "PAG_NRO_IDENTIFICACION", "PAG_TIPO_CUENTA_DESTNO", "PAG_NRO_CUENTA_DESTINO", "PAG_DESTINATARIO", "PAG_EMAIL_DESTINATARIO", "PAG_NRO_SOLICITUD", "PAG_CODIGO_IBAN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "PAG_DESCRIPCION_DOC") FROM stdin;
    SLL          SLL    false    326   �P      �          0    25170    M4SLL_PAGOS_BKP 
   TABLE DATA           �  COPY "SLL"."M4SLL_PAGOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "TSP_ID_SALIDA_PAGO", "DCP_SECUENCIA", "MEP_ID_MEDIO_PAGO", "STP_ID_STATUS_PAGO", "TPA_ID_PAGO", "PAG_VALOR", "PAG_FEC_EST", "PAG_FEC_VTO", "PAG_FEC_APR", "PAG_FEC_ERP", "PAG_FEC_PAG", "PAG_DESCRIPCION", "PAG_DOCUMENTO", "PAG_COMBINACION", "PAG_CK_COMB", "PAG_CK_RECUPERADO", "PAG_CK_SOLICITADO", "PAG_FECHA", "PAG_COMPROBANTE", "PAG_NRO_IDENTIFICACION", "PAG_TIPO_CUENTA_DESTNO", "PAG_NRO_CUENTA_DESTINO", "PAG_DESTINATARIO", "PAG_EMAIL_DESTINATARIO", "PAG_NRO_SOLICITUD", "PAG_CODIGO_IBAN", "PAG_DESCRIPCION_DOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    327   �P      �          0    25182    M4SLL_PAGOS_NOMINA 
   TABLE DATA           �  COPY "SLL"."M4SLL_PAGOS_NOMINA" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PNO_LOTE", "TPA_ID_PAGO", "PNO_VALOR", "PNO_FECHA", "PNO_FECHA_VENCIMIENTO", "PNO_PRINCIPAL_S_N", "PNO_INTERESES", "PNO_ANTIGUEDAD_RECONOCIDA", "PNO_FECHA_IMPUTACION_DESDE", "PNO_FECHA_IMPUTACION_HASTA", "PNO_ADJUNTA_VIDA_LABORAL", "PNO_FECHA_REINCORPORACION", "PNO_APLICA_SAL_DIA_HASTA_RES_R", "PNO_SALARIO_DIA", "PNO_FECHA_INICIO_SANCION", "PNO_FECHA_FIN_SANCION", "PNO_DIAS_SANCIONADO", "PNO_COTIZACION", "SSP_ID_CABEC_TC1", "PNO_RECONOCIMIENTO_DERECHO", "PNO_CUENTA_ABONO", "PNO_CODIGO_IBAN", "PNO_OTRAS_CUENTAS", "PNO_NRO_CUENTA_JUZGADO", "PNO_BENEFICIARIO", "IPN_IMPORTE_TRANSFERIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "IPN_RETENCION_JUDICIAL", "IPN_IMPORTE_BRUTO", "IPN_DESCUENTOS_S_S", "IPN_DESCUENTOS_IRPF", "IPN_FECHA_TRANSFERENCIA", "PNO_FECHA_ENVIO_NOMINA", "PNO_APLI_SANCION_S_N", "PNO_LETRA_JUZGADO", "PNO_COD_IBAN_GENE", "PNO_NRO_EXP", "PNO_NETO_S_N") FROM stdin;
    SLL          SLL    false    329   �P      �          0    25176    M4SLL_PAGOS_NOM_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_PAGOS_NOM_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "MCO_ID_CONCEPTO", "PND_FECHA_DESDE", "PND_FECHA_HASTA", "PND_IMPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MCO_NM_CONCEPTO") FROM stdin;
    SLL          SLL    false    328   �P      �          0    25188    M4SLL_PAGOS_TRN 
   TABLE DATA           �   COPY "SLL"."M4SLL_PAGOS_TRN" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "STP_ID_STATUS_PAGO", "NROCBTE", "NRODOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    330   �P      �          0    25191    M4SLL_PARAMETRICA 
   TABLE DATA           �   COPY "SLL"."M4SLL_PARAMETRICA" ("ID_ORGANIZATION", "PAR_SECUENCIA", "PAR_NM_CORTO", "PAR_NM_LARGO", "PAR_VAL_NUMBER", "PAR_VAL_DATE", "PAR_VAL_CHAR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    331   Q      �          0    25197    M4SLL_PARAM_USR 
   TABLE DATA           g   COPY "SLL"."M4SLL_PARAM_USR" ("USUARIO", "PAGINA", "FILTRO", "JSON", "CONSULTA", "ACCION") FROM stdin;
    SLL          SLL    false    332   3Q      �          0    25209    M4SLL_PEDIDOS 
   TABLE DATA             COPY "SLL"."M4SLL_PEDIDOS" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "PED_SECUENCIA", "PED_VALOR", "PED_OBSERVACION", "PED_SUB_PEDIDO", "PED_PRINCIPAL_S_N", "PED_PERIODO", "PED_VALOR_RECARGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    334   PQ      �          0    25215    M4SLL_PEDIDOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_PEDIDOS_BKP" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "PED_SECUENCIA", "PED_VALOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "PED_OBSERVACION", "PED_SUB_PEDIDO", "PED_PRINCIPAL_S_N") FROM stdin;
    SLL          SLL    false    335   mQ      �          0    25221    M4SLL_PEDIDOS_PRUEBA_GABY 
   TABLE DATA             COPY "SLL"."M4SLL_PEDIDOS_PRUEBA_GABY" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "PED_SECUENCIA", "PED_VALOR", "PED_OBSERVACION", "PED_SUB_PEDIDO", "PED_PRINCIPAL_S_N", "PED_PERIODO", "PED_VALOR_RECARGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    336   �Q      �          0    25203    M4SLL_PEDIDO_DET 
   TABLE DATA           �   COPY "SLL"."M4SLL_PEDIDO_DET" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPE_ID_PEDIDO", "PDE_SECUENCIA", "MPD_ID_PEDIDO_DETALLE", "PDE_OBSERRVACION", "CLO_ID_CLIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    333   �Q      �          0    25227    M4SLL_PERSONA_EXT 
   TABLE DATA           !  COPY "SLL"."M4SLL_PERSONA_EXT" ("ID_ORGANIZATION", "PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "PEX_ID_PERSONA_EXT", "PEX_NOMBRE", "PEX_APELLIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "PEX_DT_END", "PEX_DT_START", "PEX_NEGOCIO", "PEX_EMPRESA", "PEX_TP_EMPLEADO") FROM stdin;
    SLL          SLL    false    337   �Q      �          0    25235    M4SLL_PERSONA_EXT_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_PERSONA_EXT_BKP" ("ID_ORGANIZATION", "PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "PEX_ID_PERSONA_EXT", "PEX_NOMBRE", "PEX_APELLIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    338   �Q      �          0    25241    M4SLL_PERSONA_EXT_QA 
   TABLE DATA           �   COPY "SLL"."M4SLL_PERSONA_EXT_QA" ("ID_ORGANIZATION", "PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "PEX_ID_PERSONA_EXT", "PEX_NOMBRE", "PEX_APELLIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    339   �Q      �          0    25247    M4SLL_PROV_ABOGADO 
   TABLE DATA           �   COPY "SLL"."M4SLL_PROV_ABOGADO" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MAB_SECUENCIA", "PRA_SECUENCIA", "PRA_MONTO", "PRA_PORC_PROV_MES", "PRA_MONTO_PROV", "PRA_DT_ALTA", "PRA_OBSERVACIONES", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    340   R      �          0    25250    M4SLL_REGION 
   TABLE DATA           �   COPY "SLL"."M4SLL_REGION" ("ID_ORGANIZATION", "REG_SECUENCIA", "REG_ID_REGION", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "NEG_ID_NEGOCIO", "STD_ID_LEG_ENT") FROM stdin;
    SLL          SLL    false    341   8R      �          0    25259    M4SLL_ROLES_USRS 
   TABLE DATA           �   COPY "SLL"."M4SLL_ROLES_USRS" ("ID_ORGANIZATION", "ID_APP_ROLE", "TPR_ID_TP_ROL", "EJU_ID_EST_JURIDICO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    344   UR      �          0    25253    M4SLL_ROL_ACT_ROLE 
   TABLE DATA           �   COPY "SLL"."M4SLL_ROL_ACT_ROLE" ("ID_ORGANIZATION", "MRA_ID_ROL_ACTOR", "ID_APP_ROLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    342   rR      �          0    25256    M4SLL_ROL_APROBS 
   TABLE DATA           �   COPY "SLL"."M4SLL_ROL_APROBS" ("ID_ORGANIZATION", "ID_APP_ROLE", "ROA_VAL_MINIMO", "ROA_VAL_MAXIMO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    343   �R      �          0    25262    M4SLL_RP_CB_LITIGI 
   TABLE DATA           �  COPY "SLL"."M4SLL_RP_CB_LITIGI" ("ID_ORGANIZATION", "RCL_MES", "RCL_ANIO", "RCL_CARPET_ID", "RCL_NO", "RCL_MONTO_PREV_CAUSAS_M1", "RCL_MONTO_PREV_HONORARIOS_M1", "RCL_CARPET_CARATULA", "RCL_ESTJUI_DESCRIPCION", "RCL_MONTO_CAUSA", "RCL_PREVISION_CONDENA", "RCL_FEC_DE_ALTA_PREV_CONDENA", "RCL_MONTO_PREVISIONADO_CAUSA", "RCL_VARIACION_CAUSA", "RCL_OBSERVACIONES", "RCL_HONORIOS_Y_COSTAS", "RCL_PROVISION_HONORARIOS", "RCL_FEC_DE_ALTA_PREV_HONORARIO", "RCL_MONTO_PREV_HONORARIOS", "RCL_VARIACION_HONORARIOS", "RCL_OBSERV_HONORARIOS", "RCL_JURISDICCION", "RCL_JUZGADO", "RCL_CARPET_FECESTIMTERMINACION", "RCL_CONTIN_DESCRIPCION", "RCL_FECHAMONTO", "RCL_CLISEC_DESCRIPCION", "RCL_TIPO_CARPETA", "RCL_MONTOART", "RCL_ART", "RCL_LETRADOCONTRAPARTE", "RCL_ULTIMOMONTO", "RCL_ABOGADO", "RCL_PROBALIDAD", "RCL_FLEX_CONDENA", "RCL_FLEX_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    345   �R      �          0    25268    M4SLL_RP_ES_FICHER 
   TABLE DATA           U  COPY "SLL"."M4SLL_RP_ES_FICHER" ("ID_ORGANIZATION", "REFE", "USUARIO", "EMPRESA", "IDNEGOCIO", "NEGOCIO", "IDDELEGACION", "DELEGACION", "ZONALAB", "DEMANDANTE", "NIF", "CODIGO", "ANALITICA", "EMP", "CTA", "DLG", "DIV", "CECO", "TIPO_DEMANDANTE", "PERSONAL", "FECHA_ALTA", "PROV_S_N", "IMPORTE_PROVISION", "IMPORTE_PREVISTO", "TOTAL_COSTE", "IDASUNTO", "ASUNTO", "IDSUBASUNTO", "SUBASUNTO", "FECHA_DESPIDO_DEMANDA", "FECHA_CONCILIACION", "IDRESULTADO_CONCILIACION", "RESULTADO_CONCILIACION", "FECHA_JUZGADO", "NRO_AUTOS", "IDRESULTADO", "RESULTADO", "TRIB_SUPERIOR_FECHA", "IDTRIB_SUPERIOR_RESULTADO", "TRIB_SUPERIOR_RESULTADO", "TRIB_SUPREMO_FECHA", "IDTRIB_SUPREMO_RESULTADO", "TRIB_SUPREMO_RESULTADO", "FECHA_ESTADO", "IDESTADO_FINAL", "ESTADO_FINAL", "IDABOGADO", "ABOGADO", "OBSERVACIONES", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    346   �R      �          0    25274    M4SLL_RP_ES_LITIGI 
   TABLE DATA             COPY "SLL"."M4SLL_RP_ES_LITIGI" ("ID_ORGANIZATION", "REL_USUARIO", "REL_SECUENCIA", "REL_ID_LITIGIO", "REL_ID_LEGADO", "REL_EMPRESA", "REL_NEGOCIO", "REL_CIUDAD", "REL_DELEGACION", "REL_ZONA_LABORAL", "REL_DEMANDANTE", "REL_DEMANDANTE_NIF", "REL_DEMANDANTE_LEGAJO", "REL_COMBINACION_ANALITICA", "REL_TIPO_DEMANDANTE", "REL_TIPO_PERSONA", "REL_FECHA_ALTA", "REL_IMPORTE_PREVISTO", "REL_ASUNTO", "REL_ASUNTOS_SECUNDARIOS", "REL_SUBASUNTO", "REL_FECHA_DEMANDA", "REL_NRO_AUTO", "REL_FECHA_CONCILIACION", "REL_FASE_RESUL_CON", "REL_FECHA_JUZGADO", "REL_RESULTADO_JUZGADO", "REL_FECHA_TRIBUNAL_SUPERIOR", "REL_RESULTADO_TRI_SUPERIOR", "REL_FECHA_TRIBUNAL_SUPREMO", "REL_RESULTADO_TRI_SUPREMO", "REL_COSTO_TOTAL", "REL_FECHA_ESTADO", "REL_ESTADO_CIERRE", "REL_ABOGADO_RESPONSABLE", "REL_OBSERVACION", "REL_SUBASUNTOS_SECUNDARIOS", "REL_FECHA_NOTIFICACION", "REL_VALOR_RECARGO", "REL_FECHA_CIERRE", "REL_MATERIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "REL_FECHA_ACTUALIZACION", "REL_EMP_LIT", "REL_EST_FINAL", "REL_CLIENTE") FROM stdin;
    SLL          SLL    false    347   �R      �          0    25280    M4SLL_RP_ES_PROVIS 
   TABLE DATA             COPY "SLL"."M4SLL_RP_ES_PROVIS" ("ID_ORGANIZATION", "REL_USUARIO", "REL_SECUENCIA", "REL_ID_LITIGIO", "REL_EMPRESA", "REL_NEGOCIO", "REL_CIUDAD", "REL_DELEGACION", "REL_ZONA_LABORAL", "REL_DEMANDANTE", "REL_DEMANDANTE_NIF", "REL_DEMANDANTE_LEGAJO", "REL_COMBINACION_ANALITICA", "REL_ID_REGION", "REL_TIPO_DEMANDANTE", "REL_TIPO_PERSONA", "REL_FECHA_ALTA", "REL_IMPORTE_PREVISTO", "REL_ASUNTO", "REL_ASUNTOS_SECUNDARIOS", "REL_SUBASUNTO", "REL_FECHA_DEMANDA", "REL_NRO_AUTO", "REL_FECHA_CONCILIACION", "REL_FASE_RESUL_CON", "REL_FECHA_JUZGADO", "REL_RESULTADO_JUZGADO", "REL_FECHA_TRIBUNAL_SUPERIOR", "REL_RESULTADO_TRI_SUPERIOR", "REL_FECHA_TRIBUNAL_SUPREMO", "REL_RESULTADO_TRI_SUPREMO", "REL_COSTO_TOTAL", "REL_FECHA_ESTADO", "REL_ESTADO_CIERRE", "REL_ABOGADO_RESPONSABLE", "REL_OBSERVACION", "REL_SUBASUNTOS_SECUNDARIOS", "REL_FECHA_NOTIFICACION", "REL_VALOR_RECARGO", "REL_FECHA_CIERRE", "REL_MATERIA", "REL_ID_DIVISION", "REL_IMPORTE_PROVISION", "REL_ID_LEG_ENT", "REL_ID_LEGADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    348   S      �          0    25286    M4SLL_SEGURIDAD 
   TABLE DATA           �   COPY "SLL"."M4SLL_SEGURIDAD" ("ID_ORGANIZATION", "ID_APP_ROLE", "SS_SECUENCIAL", "SS_SQL", "SS_CHK_SELECT", "SS_CHK_UPDATE", "SS_CHK_INSERT", "SS_CHK_DELETE", "SS_CHK_CLIENTE_OBM", "SS_CHK_DTI", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    349    S      �          0    25295    M4SLL_SEGURIDAD2 
   TABLE DATA           �   COPY "SLL"."M4SLL_SEGURIDAD2" ("ID_ORGANIZATION", "ID_APP_ROLE", "SS_SECUENCIAL", "SS_SQL", "SS_CHK_SELECT", "SS_CHK_UPDATE", "SS_CHK_INSERT", "SS_CHK_DELETE", "SS_CHK_CLIENTE_OBM", "SS_CHK_DTI", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    351   =S      �          0    25292    M4SLL_SEGURIDAD_VI 
   TABLE DATA           �   COPY "SLL"."M4SLL_SEGURIDAD_VI" ("ID_ORGANIZATION", "ID_APP_ROLE", "SSV_ID_MODULO", "SSV_CHK_VER", "SSV_CHK_GUARDAR", "SSV_CHK_MODIFICAR", "SSV_CHK_ELIMINAR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    350   ZS      �          0    25301    M4SLL_SGD_CONFIG 
   TABLE DATA           u  COPY "SLL"."M4SLL_SGD_CONFIG" ("ID_ORGANIZATION", "SGDC_CONTEXT", "SGDC_ENDPOINT", "SGDC_MAIN_CLASS", "SGDC_TOKEN_SECURITY", "SGDC_COUNTRY", "SGDC_METHOD_GET_DO", "SGCD_METHOD_DEL_DOCUMENTS", "SGDC_METHOD_OBTAIN_DOCUMENT", "SGDC_METHOD_SAVE_DOCUMENT", "SGDC_ATTRIBUTES", "SGDC_VAL_ATTRIBUTES", "SGDC_TP_DOCUMENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    352   wS      �          0    25307    M4SLL_STATUS_PAGOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_STATUS_PAGOS" ("ID_ORGANIZATION", "STP_ID_STATUS_PAGO", "STP_NM_STATUS_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    353   �S      �          0    25310    M4SLL_ST_REPO_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_ST_REPO_PROV" ("ID_ORGANIZATION", "SSR_PERIODO", "MSR_ID_STATUS_REPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "SRP_APROBACION_G", "SRP_APROBACION_D") FROM stdin;
    SLL          SLL    false    354   �S      �          0    25313    M4SLL_TOTHONJ 
   TABLE DATA           �   COPY "SLL"."M4SLL_TOTHONJ" ("ID_ORGANIZATION", "TNJ_ANIO", "TNJ_MES", "MAB_SECUENCIA", "TNJ_MONTO_A", "TNJ_MONTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    355   �S      �          0    25316    M4SLL_TOTPEDHIS 
   TABLE DATA           �  COPY "SLL"."M4SLL_TOTPEDHIS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPH_MES", "TPH_ANIO", "TPE_ID_PEDIDO", "STD_ID_LEG_ENT", "EJU_ID_EST_JURIDICO", "TPH_AUTOR", "TPH_REU", "LIT_NRO_PROCESO", "TRI_ID_TRIBUNAL", "TPH_VALOR_DEMANDA", "TPH_VALOR_DEM_INTERES", "TPH_VALOR_DEM_COR_MON", "TPH_VALOR_DEM_ACT", "TPH_VAL_RIESGO", "TPH_VALOR_PROVISION", "TPH_PAGOS", "TST_ID_TP_STATUS", "TPH_VAL_HON_JURIDICO", "TPH_VAL_PREMIO_JURIDICO", "TPH_VAL_TOTAL_HON_JUR", "TPH_AUTOR_RUN", "TPH_AUTOR_CAUSAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPH_VALOR_CONDENA", "TPH_PORC_PROV_CONDENA", "TPH_VALOR_PROV_CONDENA", "TPH_VALOR_HON", "TPH_PORC_PROV_HON", "TPH_VALOR_PROV_HON") FROM stdin;
    SLL          SLL    false    356   �S      �          0    25322    M4SLL_TP_AUTOR_REU 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_AUTOR_REU" ("ID_ORGANIZATION", "TAR_ID_TP_AUTOR_REU", "TAR_NM_TP_AUTOR_REU", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TAR_DT_START", "TAR_DT_END") FROM stdin;
    SLL          SLL    false    357   T      �          0    25327    M4SLL_TP_AUTOR_REU_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_AUTOR_REU_BKP" ("ID_ORGANIZATION", "TAR_ID_TP_AUTOR_REU", "TAR_NM_TP_AUTOR_REU", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    358   %T      �          0    25330    M4SLL_TP_COMPROMIS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_COMPROMIS" ("ID_ORGANIZATION", "TCO_ID_TP_COMPROMISO", "TPL_ID_TP_LITIGIO", "TCO_NM_TP_COMPROMISO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TCO_DT_VALIDEZ", "TCO_DT_START", "TCO_DT_END") FROM stdin;
    SLL          SLL    false    359   BT      �          0    25335    M4SLL_TP_COMPROMIS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_COMPROMIS_BKP" ("ID_ORGANIZATION", "TCO_ID_TP_COMPROMISO", "TPL_ID_TP_LITIGIO", "TCO_NM_TP_COMPROMISO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TCO_DT_VALIDEZ") FROM stdin;
    SLL          SLL    false    360   _T      �          0    25338    M4SLL_TP_DOC_LITIG 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_DOC_LITIG" ("ID_ORGANIZATION", "TDL_ID_TP_DOC_LITIGIO", "TDL_NM_TP_DOC_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TDL_DT_END", "TDL_DT_START") FROM stdin;
    SLL          SLL    false    361   |T      �          0    25343    M4SLL_TP_DOC_LITIG_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_DOC_LITIG_BKP" ("ID_ORGANIZATION", "TDL_ID_TP_DOC_LITIGIO", "TDL_NM_TP_DOC_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    362   �T      �          0    25346    M4SLL_TP_ENTIDADES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_ENTIDADES" ("ID_ORGANIZATION", "TPE_ID_TP_ENTIDAD", "TPE_NM_TP_ENTIDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TPE_DT_START", "TPE_DT_END") FROM stdin;
    SLL          SLL    false    363   �T      �          0    25351    M4SLL_TP_ENTIDADES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_ENTIDADES_BKP" ("ID_ORGANIZATION", "TPE_ID_TP_ENTIDAD", "TPE_NM_TP_ENTIDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    364   �T      �          0    25354    M4SLL_TP_FALTAS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_FALTAS" ("ID_ORGANIZATION", "TFL_ID_TP_FALTA", "TFL_NM_TP__FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TFL_DT_START", "TFL_DT_END") FROM stdin;
    SLL          SLL    false    365   �T      �          0    25359    M4SLL_TP_FASES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_FASES" ("ID_ORGANIZATION", "TFA_ID_TP_FASE", "TFA_NM_TP_FASE", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TFA_DT_START", "TFA_DT_END") FROM stdin;
    SLL          SLL    false    366   U      �          0    25364    M4SLL_TP_FASES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_FASES_BKP" ("ID_ORGANIZATION", "TFA_ID_TP_FASE", "TFA_NM_TP_FASE", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    367   *U      �          0    25367    M4SLL_TP_IDENTIFIC 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_IDENTIFIC" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "TPI_NM_TP_IDENTIFICACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPI_DT_START", "TPI_DT_END") FROM stdin;
    SLL          SLL    false    368   GU      �          0    25372    M4SLL_TP_IDENTIFIC_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_IDENTIFIC_BKP" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "TPI_NM_TP_IDENTIFICACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    369   dU      �          0    25375    M4SLL_TP_LITIGIOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_LITIGIOS" ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPL_NM_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_DT_START", "TPL_DT_END") FROM stdin;
    SLL          SLL    false    370   �U      �          0    25380    M4SLL_TP_LITIGIOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_LITIGIOS_BKP" ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPL_NM_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    371   �U      �          0    25383    M4SLL_TP_MOTIVO 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_MOTIVO" ("ID_ORGANIZATION", "TMO_ID_TP_MOTIVO", "TMO_NM_TP_MOTIVO", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TMO_DT_START", "TMO_DT_END") FROM stdin;
    SLL          SLL    false    372   �U      �          0    25388    M4SLL_TP_PAGOS 
   TABLE DATA           (  COPY "SLL"."M4SLL_TP_PAGOS" ("ID_ORGANIZATION", "TPA_ID_PAGO", "TPA_NM_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPA_NUMERO_CUENTA", "TPL_ID_TP_LITIGIO", "TPA_VENDOR_ID", "TPA_VENDOR_SITE_ID", "VENDOR_NAME", "TPA_NOMINA_S_N", "TPA_CONCEPTO", "TPA_DT_START", "TPA_DT_END") FROM stdin;
    SLL          SLL    false    373   �U      �          0    25396    M4SLL_TP_PAGOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_PAGOS_BKP" ("ID_ORGANIZATION", "TPA_ID_PAGO", "TPA_NM_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPA_NUMERO_CUENTA", "TPL_ID_TP_LITIGIO", "TPA_VENDOR_ID", "TPA_VENDOR_SITE_ID", "VENDOR_NAME") FROM stdin;
    SLL          SLL    false    374   �U      �          0    25402    M4SLL_TP_PEDIDO 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_PEDIDO" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "TPE_NM_PEDIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TPE_PROVISIONA_S_N", "TPE_DT_END", "TPE_DT_START") FROM stdin;
    SLL          SLL    false    375   V      �          0    25406    M4SLL_TP_PEDIDO_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_PEDIDO_BKP" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "TPE_NM_PEDIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    376   /V      �          0    25409    M4SLL_TP_RECLAMOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_RECLAMOS" ("ID_ORGANIZATION", "TRC_ID_TP_RECLAMO", "TRC_NM_TP_RECLAMO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TRC_DT_START", "TRC_DT_END") FROM stdin;
    SLL          SLL    false    377   LV      �          0    25414    M4SLL_TP_RECURREN 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_RECURREN" ("ID_ORGANIZATION", "TRE_ID_RECURRENCIA", "TRE_NM_RECURRENCIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TRE_DT_START", "TRE_DT_END") FROM stdin;
    SLL          SLL    false    378   iV                 0    25419    M4SLL_TP_ROLES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_ROLES" ("ID_ORGANIZATION", "TPR_ID_TP_ROL", "TPR_NM_TP_ROL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPR_DT_START", "TPR_DT_END") FROM stdin;
    SLL          SLL    false    379   �V                0    25424    M4SLL_TP_SALIDA_PA 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_SALIDA_PA" ("ID_ORGANIZATION", "TSP_ID_SALIDA_PAGO", "TSP_NM_SALIDA_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TSP_DT_START", "TSP_DT_END") FROM stdin;
    SLL          SLL    false    380   �V                0    25434    M4SLL_TP_STATUS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_STATUS" ("ID_ORGANIZATION", "TST_ID_TP_STATUS", "TPL_ID_TP_LITIGIO", "TST_NM_TP_STATUS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TST_DT_START", "TST_DT_END") FROM stdin;
    SLL          SLL    false    382   �V                0    25439    M4SLL_TP_STATUS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_STATUS_BKP" ("ID_ORGANIZATION", "TST_ID_TP_STATUS", "TPL_ID_TP_LITIGIO", "TST_NM_TP_STATUS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    383   �V                0    25429    M4SLL_TP_STA_DET 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_STA_DET" ("ID_ORGANIZATION", "TSD_ID_TP_STA_DET", "TSD_NM_TP_STATUS_DET", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TSD_DT_START", "TSD_DT_END") FROM stdin;
    SLL          SLL    false    381   �V                0    25442    M4SLL_TRIBUNALES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TRIBUNALES" ("ID_ORGANIZATION", "TRI_ID_TRIBUNAL", "TRI_NM_TRIBUNAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "TRI_DT_START", "TRI_DT_END") FROM stdin;
    SLL          SLL    false    384   W                0    25447    M4SLL_TRIBUNALES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TRIBUNALES_BKP" ("ID_ORGANIZATION", "TRI_ID_TRIBUNAL", "TRI_NM_TRIBUNAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE") FROM stdin;
    SLL          SLL    false    385   4W                0    25450    M4SLL_VAL_EC_LIT 
   TABLE DATA           �  COPY "SLL"."M4SLL_VAL_EC_LIT" ("ID_ORGANIZATION", "VEL_SECUENCIA", "LIT_ID_LITIGIO", "VEL_VALOR_CONDENA", "VEL_PORC_PROV_CONDENA", "VEL_IMP_PROV_CONDENA", "VEL_VALOR_FINAL_CONDENA", "VEL_DT_IMPACTO_COND", "VEL_OBS_CONDENA", "VEL_VAL_HONORARIOS", "VEL_PORC_PROV_HONORARIOS", "VEL_IMP_PROV_HONORARIOS", "VEL_DT_IMPACTO_HONO", "VEL_OBS_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    386   QW                0    25456    M4SLL_VAL_LITIGIOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_VAL_LITIGIOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "VAL_SECUENCIA", "TPE_ID_PEDIDO", "VAL_FECHA", "PED_VALOR", "VAL_PED", "VAL_PED_INT", "VAL_PED_COR", "VAL_PED_ACT", "VAL_PROV", "VAL_PROV_INT", "VAL_PROV_COR", "VAL_PROV_ACT", "VAL_FECHA_BASE", "VAL_AGREGADO_POR", "VAL_RIESGO", "VAL_RIESGO_JUST", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "VAL_POR_PROV") FROM stdin;
    SLL          SLL    false    387   nW      	          0    25462    M4SLL_WKF_ESTADOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_WKF_ESTADOS" ("ID_ORGANIZATION", "WKE_ID_ESTADO", "WKE_NM_ESTADO", "WKE_DT_START", "WKE_DT_END", "WKE_PLAZO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    388   �W      
          0    25465    M4SLL_WKF_ROL_ESTA 
   TABLE DATA           �   COPY "SLL"."M4SLL_WKF_ROL_ESTA" ("ID_ORGANIZATION", "WKE_ID_ESTADO", "MRA_ID_ROL_ACTOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    389   �W                0    25468    M4SLL_WKF_TAR_ESTA 
   TABLE DATA           �   COPY "SLL"."M4SLL_WKF_TAR_ESTA" ("ID_ORGANIZATION", "WTE_SECUENCIA", "WKE_ID_ESTADO", "WTE_ESTADO_SIGUIENTE", "WTE_NM_TAREA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    390   �W                0    33081    STD_COUNTRY 
   TABLE DATA             COPY public."STD_COUNTRY" ("ID_ORGANIZATION", "STD_ID_COUNTRY", "STD_N_COUNTRYBRA", "STD_N_COUNTRYENG", "STD_N_COUNTRYESP", "STD_N_COUNTRYFRA", "STD_N_COUNTRYGEN", "STD_N_COUNTRYGER", "STD_N_COUNTRYITA", "STD_ID_COUNT_GROUP", "STD_ID_NACIONALITY", "STD_N_NACIONALBRA", "STD_N_NACIONALENG", "STD_N_NACIONALESP", "STD_N_NACIONALFRA", "STD_N_NACIONALGEN", "STD_N_NACIONALGER", "STD_N_NACIONALITA", "STD_ID_CURRENCY", "SFR_ID_NATIONALITY", "SSP_ID_NACION_SS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "STD_ID_COUNT_DIAN") FROM stdin;
    public          SLL    false    391   �W                0    33087    STD_GEO_DIV 
   TABLE DATA           �  COPY public."STD_GEO_DIV" ("ID_ORGANIZATION", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_N_GEO_DIVENG", "STD_N_GEO_DIVESP", "STD_N_GEO_DIVFRA", "STD_N_GEO_DIVGER", "STD_N_GEO_DIVBRA", "STD_N_GEO_DIVITA", "STD_N_GEO_DIVGEN", "SME_ID_CURP", "SME_PORC_ILIS", "SCB_ID_ZONA_UPC", "SAR_ID_PROV_AFIP", "SME_PORC_IMPUESTO", "ID_APPROLE", "SME_CALC_IMP", "ID_SECUSER", "SME_ID_ESTADO_DIM", "DT_LAST_UPDATE") FROM stdin;
    public          SLL    false    392   ��                0    33094    STD_GEO_PLACE 
   TABLE DATA           t  COPY public."STD_GEO_PLACE" ("ID_ORGANIZATION", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "STD_N_GEO_PLACENG", "STD_N_GEO_PLACESP", "STD_N_GEO_PLACFRA", "STD_N_GEO_PLACGER", "STD_N_GEO_PLACBRA", "STD_N_GEO_PLACITA", "STD_N_GEO_PLACGEN", "STD_ID_LEGAL_PLACE", "SCB_ID_ZONA_UPC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    public          SLL    false    393   �                0    33100 
   STD_PERSON 
   TABLE DATA           �  COPY public."STD_PERSON" ("ID_ORGANIZATION", "STD_ID_PERSON", "STD_N_FAM_NAME_1", "STD_N_MAIDEN_NAME", "STD_N_FIRST_NAME", "STD_N_USUAL_NAME", "STD_ID_GENDER", "STD_ID_SALUTATION", "STD_DT_BIRTH", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_COMMENT", "SSP_ID_PAIS_EMISOR", "SSP_PRIM_APELLIDO", "STD_SSN", "SCO_PHOTO", "SCO_HOME_PAGE", "SSP_ID_TP_DOC", "SFR_N_MAIDEN_NAME", "SFR_NM_BIRTH_PLACE", "STD_ID_GEO_PLACE", "STD_SS_KEY", "STD_SS_NUMBER", "SAR_N_MARRIED_NAME", "SBR_ID_RACA", "SCO_PHOTO_INET", "SGE_ID_ADD_NAME", "SGE_ID_TITEL", "SGE_ID_VSW", "SGE_N_NAME_COMPL", "SUK_MAIDEN_NAME", "SUK_OTHER_FORENAME", "SUK_PREVIOUS_SURNA", "SUS_DEATH_DATE", "SCO_SMOKER", "SCO_GB_NAME", "SCO_ID_REGION", "SAR_EXPEDIDO", "SUS_VETERAN", "SUS_ID_VET_DIS_TY", "SUS_ID_VETERAN_WHE", "SUS_ID_ETHNICITY", "SAR_DT_DEFUNCION", "SCB_DIG_VER", "SME_NUM_SS", "SAR_CUIL", "SCL_RUT", "SME_RFC", "SME_CURP", "SBR_CPF", "SMX_IMSS", "CMX_APELLIDO_PATERNO_IMSS", "CMX_APELLIDO_MATERNO_IMSS", "CMX_NOMBRE_IMSS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "CFR_LOCALIDAD_NAC", "STD_ID_COUNTRY_PADRE", "STD_ID_COUNTRY_MADRE", "CCO_NEC_HABI", "PLCO_HIDDEN_BY_DATA_PROTECTION", "PLCO_DATE_4_HIDDEN_DATA_PROTEC", "SCO_GB_LEGAL", "PLCO_ID_ORGANIZATION") FROM stdin;
    public          SLL    false    394   2�                0    33107    STD_SUB_GEO_DIV 
   TABLE DATA           r  COPY public."STD_SUB_GEO_DIV" ("ID_ORGANIZATION", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_N_SUB_GEO_ENG", "STD_N_SUB_GEO_ESP", "STD_N_SUB_GEO_FRA", "STD_N_SUB_GEO_GER", "STD_N_SUB_GEO_BRA", "STD_N_SUB_GEO_ITA", "STD_N_SUB_GEO_GEN", "ID_APPROLE", "SAR_ID_PROV_AFIP", "ID_SECUSER", "SCB_ID_ZONA_UPC", "DT_LAST_UPDATE", "SME_ID_ZONA_EC") FROM stdin;
    public          SLL    false    395   O�      O          0    16455    databasechangelog 
   TABLE DATA           �   COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
    public          SLLPE    false    202   l�      N          0    16450    databasechangeloglock 
   TABLE DATA           R   COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
    public          SLLPE    false    201   ��      Q          0    16463    jhi_persistent_audit_event 
   TABLE DATA           a   COPY public.jhi_persistent_audit_event (event_id, principal, event_date, event_type) FROM stdin;
    public          SLLPE    false    204   ��      R          0    16468    jhi_persistent_audit_evt_data 
   TABLE DATA           N   COPY public.jhi_persistent_audit_evt_data (event_id, name, value) FROM stdin;
    public          SLLPE    false    205   ��                 0    0    sequence_generator    SEQUENCE SET     D   SELECT pg_catalog.setval('public.sequence_generator', 1050, false);
          public          SLLPE    false    203            �           2606    25482 :   M4SLL_AUTOR_REU_PRUEBA_GABY M4SLL_AUTOR_REU_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_AUTOR_REU_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA");
 g   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_AUTOR_REU_PRUEBA_GABY_PK";
       SLL            SLL    false    212    212    212            �           2606    25540 =   M4SLL_ESP_DELEGACI_PRUEBA_GABY M4SLL_ESP_DELEGACI_PRU_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_ESP_DELEGACI_PRU_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD");
 j   ALTER TABLE ONLY "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_ESP_DELEGACI_PRU_GABY_PK";
       SLL            SLL    false    255    255    255                       2606    25560 6   M4SLL_INI_PARAM_CALC_PROV M4SLL_INI_PARAM_CALC_PROV_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV"
    ADD CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_PK" PRIMARY KEY ("IPAR_SECUENCIA");
 c   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV" DROP CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_PK";
       SLL            SLL    false    271                       2606    25562 6   M4SLL_INI_PARAM_CALC_PROV M4SLL_INI_PARAM_CALC_PROV_UK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV"
    ADD CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_UK" UNIQUE ("ID_ORGANIZATION", "IPAR_PROCESO", "IPAR_NOMBRE");
 c   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV" DROP CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_UK";
       SLL            SLL    false    271    271    271                       2606    25568 2   M4SLL_INT_LIST_LITIGIOS M4SLL_INT_LIST_LITIGIOS_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_LIST_LITIGIOS"
    ADD CONSTRAINT "M4SLL_INT_LIST_LITIGIOS_PK" PRIMARY KEY ("LIT_ID_LITIGIO");
 _   ALTER TABLE ONLY "SLL"."M4SLL_INT_LIST_LITIGIOS" DROP CONSTRAINT "M4SLL_INT_LIST_LITIGIOS_PK";
       SLL            SLL    false    276                       2606    25580 8   M4SLL_LITIGIOS_PRUEBA_GABY M4SLL_LITIGIOS_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_LITIGIOS_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "LIT_ID_LITIGIO");
 e   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_LITIGIOS_PRUEBA_GABY_PK";
       SLL            SLL    false    286    286                       2606    25588 =   M4SLL_MATRIZ_PRE_C_PRUEBA_GABY M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK" UNIQUE ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL");
 j   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK";
       SLL            SLL    false    292    292    292    292    292    292    292            '           2606    25596 =   M4SLL_MATRIZ_PRE_D_PRUEBA_GABY M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK" UNIQUE ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA");
 j   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK";
       SLL            SLL    false    296    296    296    296            )           2606    25598 0   M4SLL_MATRIZ_PRE_PARAM M4SLL_MATRIZ_PRE_PARAM_PK 
   CONSTRAINT     }   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_PARAM"
    ADD CONSTRAINT "M4SLL_MATRIZ_PRE_PARAM_PK" PRIMARY KEY ("MPP_ID_ORDEN");
 ]   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_PARAM" DROP CONSTRAINT "M4SLL_MATRIZ_PRE_PARAM_PK";
       SLL            SLL    false    297            U           2606    25642 8   M4SLL_NEGOCIOS_PRUEBA_GABY M4SLL_NEGOCIOS_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_NEGOCIOS_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "NEG_ID_NEGOCIO");
 e   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_NEGOCIOS_PRUEBA_GABY_PK";
       SLL            SLL    false    324    324            c           2606    25656 "   M4SLL_PARAM_USR M4SLL_PARAM_USR_PK 
   CONSTRAINT     t   ALTER TABLE ONLY "SLL"."M4SLL_PARAM_USR"
    ADD CONSTRAINT "M4SLL_PARAM_USR_PK" PRIMARY KEY ("USUARIO", "ACCION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_PARAM_USR" DROP CONSTRAINT "M4SLL_PARAM_USR_PK";
       SLL            SLL    false    332    332            i           2606    25662 6   M4SLL_PEDIDOS_PRUEBA_GABY M4SLL_PEDIDOS_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDOS_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_PEDIDOS_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPE_ID_PEDIDO");
 c   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDOS_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_PEDIDOS_PRUEBA_GABY_PK";
       SLL            SLL    false    336    336    336            �           2606    25730     M4SLL_TRIBUNALES PK1805231029190 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TRIBUNALES"
    ADD CONSTRAINT "PK1805231029190" PRIMARY KEY ("TRI_ID_TRIBUNAL", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_TRIBUNALES" DROP CONSTRAINT "PK1805231029190";
       SLL            SLL    false    384    384            �           2606    25534    M4SLL_ENTIDADES PK1805231243390 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ENTIDADES"
    ADD CONSTRAINT "PK1805231243390" PRIMARY KEY ("ENT_NRO_IDENTIFICACION", "TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_ENTIDADES" DROP CONSTRAINT "PK1805231243390";
       SLL            SLL    false    251    251    251            �           2606    25698 "   M4SLL_TP_COMPROMIS PK1805231410220 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_COMPROMIS"
    ADD CONSTRAINT "PK1805231410220" PRIMARY KEY ("TCO_ID_TP_COMPROMISO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_TP_COMPROMIS" DROP CONSTRAINT "PK1805231410220";
       SLL            SLL    false    359    359            �           2606    25510 !   M4SLL_COMPROMISOS PK1805231410221 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_COMPROMISOS"
    ADD CONSTRAINT "PK1805231410221" PRIMARY KEY ("TCO_ID_TP_COMPROMISO", "LIT_ID_LITIGIO", "COM_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_COMPROMISOS" DROP CONSTRAINT "PK1805231410221";
       SLL            SLL    false    236    236    236    236            �           2606    25714    M4SLL_TP_PAGOS PK1805231555310 
   CONSTRAINT     }   ALTER TABLE ONLY "SLL"."M4SLL_TP_PAGOS"
    ADD CONSTRAINT "PK1805231555310" PRIMARY KEY ("TPA_ID_PAGO", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_TP_PAGOS" DROP CONSTRAINT "PK1805231555310";
       SLL            SLL    false    373    373            Y           2606    25646    M4SLL_PAGOS PK1805231555313 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS"
    ADD CONSTRAINT "PK1805231555313" PRIMARY KEY ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "ID_ORGANIZATION");
 H   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS" DROP CONSTRAINT "PK1805231555313";
       SLL            SLL    false    326    326    326            �           2606    25526 "   M4SLL_DESTINATARIO PK1805231555314 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_DESTINATARIO"
    ADD CONSTRAINT "PK1805231555314" PRIMARY KEY ("DES_ID_DESTINATARIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_DESTINATARIO" DROP CONSTRAINT "PK1805231555314";
       SLL            SLL    false    246    246            �           2606    25532    M4SLL_DOCPAG PK1805241632110 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_DOCPAG"
    ADD CONSTRAINT "PK1805241632110" PRIMARY KEY ("LIT_ID_LITIGIO", "DCP_SECUENCIA", "ID_ORGANIZATION");
 I   ALTER TABLE ONLY "SLL"."M4SLL_DOCPAG" DROP CONSTRAINT "PK1805241632110";
       SLL            SLL    false    250    250    250            �           2606    25514     M4SLL_COTIZACION PK1805281516260 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_COTIZACION"
    ADD CONSTRAINT "PK1805281516260" PRIMARY KEY ("COT_ANIO", "COT_MES", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_COTIZACION" DROP CONSTRAINT "PK1805281516260";
       SLL            SLL    false    239    239    239                       2606    25576    M4SLL_LITIGIOS PK1812101138140 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS"
    ADD CONSTRAINT "PK1812101138140" PRIMARY KEY ("LIT_ID_LITIGIO", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS" DROP CONSTRAINT "PK1812101138140";
       SLL            SLL    false    281    281            �           2606    25702 "   M4SLL_TP_ENTIDADES PK1812101138141 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_ENTIDADES"
    ADD CONSTRAINT "PK1812101138141" PRIMARY KEY ("TPE_ID_TP_ENTIDAD", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_TP_ENTIDADES" DROP CONSTRAINT "PK1812101138141";
       SLL            SLL    false    363    363            �           2606    25726 !   M4SLL_TP_STA_DET PK18121011381410 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_STA_DET"
    ADD CONSTRAINT "PK18121011381410" PRIMARY KEY ("TSD_ID_TP_STA_DET", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_TP_STA_DET" DROP CONSTRAINT "PK18121011381410";
       SLL            SLL    false    381    381            �           2606    25484 "   M4SLL_AUT_REU_DOC PK18121011381411 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AUT_REU_DOC"
    ADD CONSTRAINT "PK18121011381411" PRIMARY KEY ("LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARD_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_AUT_REU_DOC" DROP CONSTRAINT "PK18121011381411";
       SLL            SLL    false    215    215    215    215            �           2606    25504    M4SLL_COMP_DOC PK18121011381412 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_COMP_DOC"
    ADD CONSTRAINT "PK18121011381412" PRIMARY KEY ("TCO_ID_TP_COMPROMISO", "LIT_ID_LITIGIO", "COD_SECUENCIA", "COM_SECUENCIA", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_COMP_DOC" DROP CONSTRAINT "PK18121011381412";
       SLL            SLL    false    233    233    233    233    233            �           2606    25546 "   M4SLL_ESTUDIO_JUR PK18121011381413 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESTUDIO_JUR"
    ADD CONSTRAINT "PK18121011381413" PRIMARY KEY ("EJU_ID_EST_JURIDICO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ESTUDIO_JUR" DROP CONSTRAINT "PK18121011381413";
       SLL            SLL    false    258    258            �           2606    25734 #   M4SLL_VAL_LITIGIOS PK18121011381414 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_VAL_LITIGIOS"
    ADD CONSTRAINT "PK18121011381414" PRIMARY KEY ("LIT_ID_LITIGIO", "VAL_SECUENCIA", "TPE_ID_PEDIDO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_VAL_LITIGIOS" DROP CONSTRAINT "PK18121011381414";
       SLL            SLL    false    387    387    387    387            �           2606    25720 "   M4SLL_TP_RECURREN PK18121011381415 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_RECURREN"
    ADD CONSTRAINT "PK18121011381415" PRIMARY KEY ("TRE_ID_RECURRENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_TP_RECURREN" DROP CONSTRAINT "PK18121011381415";
       SLL            SLL    false    378    378            �           2606    25712     M4SLL_TP_MOTIVO PK18121011381416 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_MOTIVO"
    ADD CONSTRAINT "PK18121011381416" PRIMARY KEY ("TMO_ID_TP_MOTIVO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_TP_MOTIVO" DROP CONSTRAINT "PK18121011381416";
       SLL            SLL    false    372    372            _           2606    25652     M4SLL_PAGOS_TRN PK18121011381417 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_TRN"
    ADD CONSTRAINT "PK18121011381417" PRIMARY KEY ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_TRN" DROP CONSTRAINT "PK18121011381417";
       SLL            SLL    false    330    330    330            �           2606    25688 #   M4SLL_STATUS_PAGOS PK18121011381418 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_STATUS_PAGOS"
    ADD CONSTRAINT "PK18121011381418" PRIMARY KEY ("STP_ID_STATUS_PAGO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_STATUS_PAGOS" DROP CONSTRAINT "PK18121011381418";
       SLL            SLL    false    353    353            �           2606    25716     M4SLL_TP_PEDIDO PK18121011381419 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_PEDIDO"
    ADD CONSTRAINT "PK18121011381419" PRIMARY KEY ("TPE_ID_PEDIDO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_TP_PEDIDO" DROP CONSTRAINT "PK18121011381419";
       SLL            SLL    false    375    375            g           2606    25660    M4SLL_PEDIDOS PK1812101138142 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDOS"
    ADD CONSTRAINT "PK1812101138142" PRIMARY KEY ("TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 J   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDOS" DROP CONSTRAINT "PK1812101138142";
       SLL            SLL    false    334    334    334            �           2606    25528 #   M4SLL_DOC_LITIGIOS PK18121011381420 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_DOC_LITIGIOS"
    ADD CONSTRAINT "PK18121011381420" PRIMARY KEY ("DOL_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_DOC_LITIGIOS" DROP CONSTRAINT "PK18121011381420";
       SLL            SLL    false    247    247    247            �           2606    25708 #   M4SLL_TP_IDENTIFIC PK18121011381422 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_IDENTIFIC"
    ADD CONSTRAINT "PK18121011381422" PRIMARY KEY ("TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_TP_IDENTIFIC" DROP CONSTRAINT "PK18121011381422";
       SLL            SLL    false    368    368            �           2606    25728     M4SLL_TP_STATUS PK18121011381423 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_STATUS"
    ADD CONSTRAINT "PK18121011381423" PRIMARY KEY ("TST_ID_TP_STATUS", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_TP_STATUS" DROP CONSTRAINT "PK18121011381423";
       SLL            SLL    false    382    382            �           2606    25700 #   M4SLL_TP_DOC_LITIG PK18121011381424 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_DOC_LITIG"
    ADD CONSTRAINT "PK18121011381424" PRIMARY KEY ("TDL_ID_TP_DOC_LITIGIO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_TP_DOC_LITIG" DROP CONSTRAINT "PK18121011381424";
       SLL            SLL    false    361    361            k           2606    25664 !   M4SLL_PERSONA_EXT PK1812101138143 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PERSONA_EXT"
    ADD CONSTRAINT "PK1812101138143" PRIMARY KEY ("PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_PERSONA_EXT" DROP CONSTRAINT "PK1812101138143";
       SLL            SLL    false    337    337    337            �           2606    25696 "   M4SLL_TP_AUTOR_REU PK1812101138144 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_AUTOR_REU"
    ADD CONSTRAINT "PK1812101138144" PRIMARY KEY ("TAR_ID_TP_AUTOR_REU", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_TP_AUTOR_REU" DROP CONSTRAINT "PK1812101138144";
       SLL            SLL    false    357    357            �           2606    25710 !   M4SLL_TP_LITIGIOS PK1812101138145 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_LITIGIOS"
    ADD CONSTRAINT "PK1812101138145" PRIMARY KEY ("TPL_ID_TP_LITIGIO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_TP_LITIGIOS" DROP CONSTRAINT "PK1812101138145";
       SLL            SLL    false    370    370            +           2606    25600 !   M4SLL_MEDIO_PAGOS PK1812101138146 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MEDIO_PAGOS"
    ADD CONSTRAINT "PK1812101138146" PRIMARY KEY ("MEP_ID_MEDIO_PAGO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MEDIO_PAGOS" DROP CONSTRAINT "PK1812101138146";
       SLL            SLL    false    298    298            �           2606    25480    M4SLL_AUTOR_REU PK1812101138147 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU"
    ADD CONSTRAINT "PK1812101138147" PRIMARY KEY ("AUR_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU" DROP CONSTRAINT "PK1812101138147";
       SLL            SLL    false    210    210    210            e           2606    25658     M4SLL_PEDIDO_DET PK1812101138148 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDO_DET"
    ADD CONSTRAINT "PK1812101138148" PRIMARY KEY ("LIT_ID_LITIGIO", "TPE_ID_PEDIDO", "PDE_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDO_DET" DROP CONSTRAINT "PK1812101138148";
       SLL            SLL    false    333    333    333    333            �           2606    25478 "   M4SLL_AU_REU_ANALI PK1812101138149 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AU_REU_ANALI"
    ADD CONSTRAINT "PK1812101138149" PRIMARY KEY ("LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARA_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_AU_REU_ANALI" DROP CONSTRAINT "PK1812101138149";
       SLL            SLL    false    209    209    209    209            �           2606    25706    M4SLL_TP_FASES PK1812101538050 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_FASES"
    ADD CONSTRAINT "PK1812101538050" PRIMARY KEY ("TFA_ID_TP_FASE", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_TP_FASES" DROP CONSTRAINT "PK1812101538050";
       SLL            SLL    false    366    366                       2606    25578 "   M4SLL_LITIGIOS_HIS PK1812110929540 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_HIS"
    ADD CONSTRAINT "PK1812110929540" PRIMARY KEY ("LIT_ID_LITIGIO", "LIH_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_HIS" DROP CONSTRAINT "PK1812110929540";
       SLL            SLL    false    285    285    285            �           2606    25694    M4SLL_TOTPEDHIS PK1901021404160 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TOTPEDHIS"
    ADD CONSTRAINT "PK1901021404160" PRIMARY KEY ("LIT_ID_LITIGIO", "TPH_MES", "TPH_ANIO", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_TOTPEDHIS" DROP CONSTRAINT "PK1901021404160";
       SLL            SLL    false    356    356    356    356            �           2606    25530 "   M4SLL_DOC_ORIGENES PK1901041401261 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_DOC_ORIGENES"
    ADD CONSTRAINT "PK1901041401261" PRIMARY KEY ("DOO_ID_DOC_ORIGEN", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_DOC_ORIGENES" DROP CONSTRAINT "PK1901041401261";
       SLL            SLL    false    249    249            �           2606    25506 "   M4SLL_COMP_ESTADOS PK1901041401262 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_COMP_ESTADOS"
    ADD CONSTRAINT "PK1901041401262" PRIMARY KEY ("COE_ID_COMP_ESTADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_COMP_ESTADOS" DROP CONSTRAINT "PK1901041401262";
       SLL            SLL    false    234    234            �           2606    25502 "   M4SLL_COMP_DETALLE PK1901041401263 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_COMP_DETALLE"
    ADD CONSTRAINT "PK1901041401263" PRIMARY KEY ("COM_SECUENCIA", "LIT_ID_LITIGIO", "COE_ID_COMP_ESTADO", "COR_ID_COMP_RESULTADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_COMP_DETALLE" DROP CONSTRAINT "PK1901041401263";
       SLL            SLL    false    232    232    232    232    232            �           2606    25508 "   M4SLL_COMP_RESULTA PK1901041401264 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_COMP_RESULTA"
    ADD CONSTRAINT "PK1901041401264" PRIMARY KEY ("COR_ID_COMP_RESULTADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_COMP_RESULTA" DROP CONSTRAINT "PK1901041401264";
       SLL            SLL    false    235    235                       2606    25582 "   M4SLL_LIT_SEGUIMIE PK1901041650550 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LIT_SEGUIMIE"
    ADD CONSTRAINT "PK1901041650550" PRIMARY KEY ("LIT_ID_LITIGIO", "LIS_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_LIT_SEGUIMIE" DROP CONSTRAINT "PK1901041650550";
       SLL            SLL    false    288    288    288            s           2606    25672     M4SLL_ROLES_USRS PK1901091148510 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ROLES_USRS"
    ADD CONSTRAINT "PK1901091148510" PRIMARY KEY ("ID_APP_ROLE", "TPR_ID_TP_ROL", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_ROLES_USRS" DROP CONSTRAINT "PK1901091148510";
       SLL            SLL    false    344    344    344            �           2606    25722    M4SLL_TP_ROLES PK1901091148511 
   CONSTRAINT        ALTER TABLE ONLY "SLL"."M4SLL_TP_ROLES"
    ADD CONSTRAINT "PK1901091148511" PRIMARY KEY ("TPR_ID_TP_ROL", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_TP_ROLES" DROP CONSTRAINT "PK1901091148511";
       SLL            SLL    false    379    379            q           2606    25670     M4SLL_ROL_APROBS PK1901091506010 
   CONSTRAINT        ALTER TABLE ONLY "SLL"."M4SLL_ROL_APROBS"
    ADD CONSTRAINT "PK1901091506010" PRIMARY KEY ("ID_APP_ROLE", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_ROL_APROBS" DROP CONSTRAINT "PK1901091506010";
       SLL            SLL    false    343    343            �           2606    25544 !   M4SLL_EST_JUR_SUB PK1901241529580 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_EST_JUR_SUB"
    ADD CONSTRAINT "PK1901241529580" PRIMARY KEY ("EJU_ID_EST_JURIDICO", "EJS_ID_EST_JUR_SUB", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_EST_JUR_SUB" DROP CONSTRAINT "PK1901241529580";
       SLL            SLL    false    257    257    257            �           2606    25704    M4SLL_TP_FALTAS PK1902071553540 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_FALTAS"
    ADD CONSTRAINT "PK1902071553540" PRIMARY KEY ("TFL_ID_TP_FALTA", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_TP_FALTAS" DROP CONSTRAINT "PK1902071553540";
       SLL            SLL    false    365    365            �           2606    25718 !   M4SLL_TP_RECLAMOS PK1902071553541 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_RECLAMOS"
    ADD CONSTRAINT "PK1902071553541" PRIMARY KEY ("TRC_ID_TP_RECLAMO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_TP_RECLAMOS" DROP CONSTRAINT "PK1902071553541";
       SLL            SLL    false    377    377            S           2606    25640    M4SLL_NEGOCIOS PK1902131322280 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS"
    ADD CONSTRAINT "PK1902131322280" PRIMARY KEY ("NEG_ID_NEGOCIO", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS" DROP CONSTRAINT "PK1902131322280";
       SLL            SLL    false    322    322            �           2606    25556 "   M4SLL_FASES_RESULT PK1903121315170 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_FASES_RESULT"
    ADD CONSTRAINT "PK1903121315170" PRIMARY KEY ("FAR_ID_FASE_RESULTADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_FASES_RESULT" DROP CONSTRAINT "PK1903121315170";
       SLL            SLL    false    268    268            �           2606    25548    M4SLL_FASES PK1903121315171 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_FASES"
    ADD CONSTRAINT "PK1903121315171" PRIMARY KEY ("LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "ID_ORGANIZATION");
 H   ALTER TABLE ONLY "SLL"."M4SLL_FASES" DROP CONSTRAINT "PK1903121315171";
       SLL            SLL    false    262    262    262            �           2606    25552 "   M4SLL_FASES_ESTADO PK1903121315172 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_FASES_ESTADO"
    ADD CONSTRAINT "PK1903121315172" PRIMARY KEY ("FAS_ID_FASE_ESTADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_FASES_ESTADO" DROP CONSTRAINT "PK1903121315172";
       SLL            SLL    false    265    265            �           2606    25550    M4SLL_FASES_DOC PK1903121315173 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_FASES_DOC"
    ADD CONSTRAINT "PK1903121315173" PRIMARY KEY ("LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAD_SECUENCIA", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_FASES_DOC" DROP CONSTRAINT "PK1903121315173";
       SLL            SLL    false    264    264    264    264                       2606    25584 "   M4SLL_LIT_VINCULAD PK1904041344150 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LIT_VINCULAD"
    ADD CONSTRAINT "PK1904041344150" PRIMARY KEY ("LIT_ID_LITIGIO", "LIV_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_LIT_VINCULAD" DROP CONSTRAINT "PK1904041344150";
       SLL            SLL    false    289    289    289                       2606    25574     M4SLL_LIT_HECHOS PK1904111011150 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LIT_HECHOS"
    ADD CONSTRAINT "PK1904111011150" PRIMARY KEY ("LIT_ID_LITIGIO", "LIH_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_LIT_HECHOS" DROP CONSTRAINT "PK1904111011150";
       SLL            SLL    false    279    279    279            /           2606    25604 !   M4SLL_MT_ABOGADOS PK1905031255481 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MT_ABOGADOS"
    ADD CONSTRAINT "PK1905031255481" PRIMARY KEY ("MAB_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MT_ABOGADOS" DROP CONSTRAINT "PK1905031255481";
       SLL            SLL    false    300    300            1           2606    25606 !   M4SLL_MTO_COD_ALT PK1905031530580 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_COD_ALT"
    ADD CONSTRAINT "PK1905031530580" PRIMARY KEY ("MCA_ID_CODIGO_ALTERNO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_COD_ALT" DROP CONSTRAINT "PK1905031530580";
       SLL            SLL    false    302    302            �           2606    25536 "   M4SLL_ESP_CIUDADES PK1905081629510 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESP_CIUDADES"
    ADD CONSTRAINT "PK1905081629510" PRIMARY KEY ("ECI_ID_CIUDAD", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ESP_CIUDADES" DROP CONSTRAINT "PK1905081629510";
       SLL            SLL    false    253    253            �           2606    25538 "   M4SLL_ESP_DELEGACI PK1905081629512 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESP_DELEGACI"
    ADD CONSTRAINT "PK1905081629512" PRIMARY KEY ("EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ESP_DELEGACI" DROP CONSTRAINT "PK1905081629512";
       SLL            SLL    false    254    254    254            E           2606    25626 "   M4SLL_MTO_PEDIDO_D PK1905091455510 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_PEDIDO_D"
    ADD CONSTRAINT "PK1905091455510" PRIMARY KEY ("MPD_ID_PEDIDO_DETALLE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_PEDIDO_D" DROP CONSTRAINT "PK1905091455510";
       SLL            SLL    false    314    314            �           2606    25488 "   M4SLL_CCB_RAMAJUDC PK1905100932210 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RAMAJUDC"
    ADD CONSTRAINT "PK1905100932210" PRIMARY KEY ("RJC_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RAMAJUDC" DROP CONSTRAINT "PK1905100932210";
       SLL            SLL    false    218    218    218            �           2606    25490 "   M4SLL_CCB_RAMAJUDD PK1905100932211 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RAMAJUDD"
    ADD CONSTRAINT "PK1905100932211" PRIMARY KEY ("RJD_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RAMAJUDD" DROP CONSTRAINT "PK1905100932211";
       SLL            SLL    false    221    221    221            m           2606    25666 "   M4SLL_PROV_ABOGADO PK1905100932212 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PROV_ABOGADO"
    ADD CONSTRAINT "PK1905100932212" PRIMARY KEY ("LIT_ID_LITIGIO", "MAB_SECUENCIA", "PRA_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_PROV_ABOGADO" DROP CONSTRAINT "PK1905100932212";
       SLL            SLL    false    340    340    340    340            �           2606    25520 "   M4SLL_CTRL_ERRORES PK1906241115300 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CTRL_ERRORES"
    ADD CONSTRAINT "PK1906241115300" PRIMARY KEY ("CTE_USUARIO", "CTE_FECHA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CTRL_ERRORES" DROP CONSTRAINT "PK1906241115300";
       SLL            SLL    false    242    242    242            �           2606    25724 "   M4SLL_TP_SALIDA_PA PK1907161218340 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_SALIDA_PA"
    ADD CONSTRAINT "PK1907161218340" PRIMARY KEY ("TSP_ID_SALIDA_PAGO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_TP_SALIDA_PA" DROP CONSTRAINT "PK1907161218340";
       SLL            SLL    false    380    380            O           2606    25636 "   M4SLL_MTO_TP_EMPLE PK1907221131090 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TP_EMPLE"
    ADD CONSTRAINT "PK1907221131090" PRIMARY KEY ("MTE_ID_TP_EMPLEADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TP_EMPLE" DROP CONSTRAINT "PK1907221131090";
       SLL            SLL    false    320    320            A           2606    25622 !   M4SLL_MTO_MATERIA PK1907241608520 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MATERIA"
    ADD CONSTRAINT "PK1907241608520" PRIMARY KEY ("MMA_ID_MATERIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MATERIA" DROP CONSTRAINT "PK1907241608520";
       SLL            SLL    false    312    312            y           2606    25678 "   M4SLL_RP_ES_LITIGI PK1907261552030 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_LITIGI"
    ADD CONSTRAINT "PK1907261552030" PRIMARY KEY ("REL_USUARIO", "REL_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_LITIGI" DROP CONSTRAINT "PK1907261552030";
       SLL            SLL    false    347    347    347            u           2606    25674 "   M4SLL_RP_CB_LITIGI PK1907261615320 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_CB_LITIGI"
    ADD CONSTRAINT "PK1907261615320" PRIMARY KEY ("RCL_MES", "RCL_ANIO", "RCL_CARPET_ID", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_CB_LITIGI" DROP CONSTRAINT "PK1907261615320";
       SLL            SLL    false    345    345    345    345                       2606    25572 "   M4SLL_INT_PAGO_NOM PK1907291718440 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAGO_NOM"
    ADD CONSTRAINT "PK1907291718440" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAGO_NOM" DROP CONSTRAINT "PK1907291718440";
       SLL            SLL    false    278    278    278            G           2606    25628 !   M4SLL_MTO_RIESGOS PK1907301130500 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_RIESGOS"
    ADD CONSTRAINT "PK1907301130500" PRIMARY KEY ("MRI_ID_RIESGO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_RIESGOS" DROP CONSTRAINT "PK1907301130500";
       SLL            SLL    false    315    315            �           2606    25522    M4SLL_CUADRANTE PK1908061519450 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CUADRANTE"
    ADD CONSTRAINT "PK1908061519450" PRIMARY KEY ("ORDINAL_10_PK", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_CUADRANTE" DROP CONSTRAINT "PK1908061519450";
       SLL            SLL    false    243    243            5           2606    25610 "   M4SLL_MTO_DET_PROV PK1908121633200 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_DET_PROV"
    ADD CONSTRAINT "PK1908121633200" PRIMARY KEY ("MDP_ID_DET_PROVISION", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_DET_PROV" DROP CONSTRAINT "PK1908121633200";
       SLL            SLL    false    305    305                       2606    25558 "   M4SLL_HIS_DET_PROV PK1908121633201 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_HIS_DET_PROV"
    ADD CONSTRAINT "PK1908121633201" PRIMARY KEY ("LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "MDP_ID_DET_PROVISION", "HDP_DT_PERIODO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_HIS_DET_PROV" DROP CONSTRAINT "PK1908121633201";
       SLL            SLL    false    270    270    270    270    270            �           2606    25498 "   M4SLL_CLIENTES_OMB PK1908261544270 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CLIENTES_OMB"
    ADD CONSTRAINT "PK1908261544270" PRIMARY KEY ("CLO_ID_CLIENTE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CLIENTES_OMB" DROP CONSTRAINT "PK1908261544270";
       SLL            SLL    false    230    230            �           2606    25524    M4SLL_DATOS_WF PK1908261618440 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_DATOS_WF"
    ADD CONSTRAINT "PK1908261618440" PRIMARY KEY ("ID_BPC", "MODULO", "ID_MODULE", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_DATOS_WF" DROP CONSTRAINT "PK1908261618440";
       SLL            SLL    false    245    245    245    245            �           2606    25500 "   M4SLL_CLIENTES_ROL PK1909091116410 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CLIENTES_ROL"
    ADD CONSTRAINT "PK1909091116410" PRIMARY KEY ("CLO_ID_CLIENTE", "CLR_ID_ROLE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CLIENTES_ROL" DROP CONSTRAINT "PK1909091116410";
       SLL            SLL    false    231    231    231            7           2606    25612 !   M4SLL_MTO_EMP_ORG PK1909121232290 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EMP_ORG"
    ADD CONSTRAINT "PK1909121232290" PRIMARY KEY ("STD_ID_LEG_ENT", "ORG_ID", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EMP_ORG" DROP CONSTRAINT "PK1909121232290";
       SLL            SLL    false    307    307    307            Q           2606    25638 "   M4SLL_MT_ST_RE_PRO PK1909161051300 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MT_ST_RE_PRO"
    ADD CONSTRAINT "PK1909161051300" PRIMARY KEY ("MSR_ID_STATUS_REPORTE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MT_ST_RE_PRO" DROP CONSTRAINT "PK1909161051300";
       SLL            SLL    false    321    321            �           2606    25690 "   M4SLL_ST_REPO_PROV PK1909161051301 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ST_REPO_PROV"
    ADD CONSTRAINT "PK1909161051301" PRIMARY KEY ("SSR_PERIODO", "MSR_ID_STATUS_REPORTE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ST_REPO_PROV" DROP CONSTRAINT "PK1909161051301";
       SLL            SLL    false    354    354    354            �           2606    25474     M4SLL_ASIENTOS_C PK1909190913290 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ASIENTOS_C"
    ADD CONSTRAINT "PK1909190913290" PRIMARY KEY ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_ASIENTOS_C" DROP CONSTRAINT "PK1909190913290";
       SLL            SLL    false    207    207    207    207            �           2606    25476     M4SLL_ASIENTOS_D PK1909190936290 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ASIENTOS_D"
    ADD CONSTRAINT "PK1909190936290" PRIMARY KEY ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ASD_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_ASIENTOS_D" DROP CONSTRAINT "PK1909190936290";
       SLL            SLL    false    208    208    208    208    208            %           2606    25594 "   M4SLL_MATRIZ_PREDI PK1910101723320 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PREDI"
    ADD CONSTRAINT "PK1910101723320" PRIMARY KEY ("MPR_ANIO", "MPR_MES", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PREDI" DROP CONSTRAINT "PK1910101723320";
       SLL            SLL    false    295    295    295    295    295            #           2606    25592 "   M4SLL_MATRIZ_PRE_D PK1910111308480 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D"
    ADD CONSTRAINT "PK1910111308480" PRIMARY KEY ("MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D" DROP CONSTRAINT "PK1910111308480";
       SLL            SLL    false    293    293    293    293                       2606    25586 "   M4SLL_MATRIZ_PRE_C PK1910111308481 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C"
    ADD CONSTRAINT "PK1910111308481" PRIMARY KEY ("MPC_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C" DROP CONSTRAINT "PK1910111308481";
       SLL            SLL    false    290    290            ]           2606    25650 "   M4SLL_PAGOS_NOMINA PK1910311755372 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOMINA"
    ADD CONSTRAINT "PK1910311755372" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOMINA" DROP CONSTRAINT "PK1910311755372";
       SLL            SLL    false    329    329    329            �           2606    25542 "   M4SLL_ESP_LIT_PROV PK1911041402250 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESP_LIT_PROV"
    ADD CONSTRAINT "PK1911041402250" PRIMARY KEY ("LIT_ID_LITIGIO", "ELP_ANIO", "ELP_MES", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ESP_LIT_PROV" DROP CONSTRAINT "PK1911041402250";
       SLL            SLL    false    256    256    256    256            3           2606    25608 "   M4SLL_MTO_CONCEPTO PK1911081214540 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_CONCEPTO"
    ADD CONSTRAINT "PK1911081214540" PRIMARY KEY ("MCO_ID_CONCEPTO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_CONCEPTO" DROP CONSTRAINT "PK1911081214540";
       SLL            SLL    false    304    304            [           2606    25648 !   M4SLL_PAGOS_NOM_D PK1911131129410 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOM_D"
    ADD CONSTRAINT "PK1911131129410" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOM_D" DROP CONSTRAINT "PK1911131129410";
       SLL            SLL    false    328    328    328    328                       2606    25570 "   M4SLL_INT_PAG_NO_D PK1911131129411 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAG_NO_D"
    ADD CONSTRAINT "PK1911131129411" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAG_NO_D" DROP CONSTRAINT "PK1911131129411";
       SLL            SLL    false    277    277    277    277            	           2606    25566 !   M4SLL_INT_GL_TRXS PK1911141648350 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_GL_TRXS"
    ADD CONSTRAINT "PK1911141648350" PRIMARY KEY ("ORIGEN", "GRUPO", "LOTE", "RENGLON", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_INT_GL_TRXS" DROP CONSTRAINT "PK1911141648350";
       SLL            SLL    false    274    274    274    274    274                       2606    25564 "   M4SLL_INT_GL_TRX_L PK1911141648351 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_GL_TRX_L"
    ADD CONSTRAINT "PK1911141648351" PRIMARY KEY ("ORIGEN", "GRUPO", "LOTE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_INT_GL_TRX_L" DROP CONSTRAINT "PK1911141648351";
       SLL            SLL    false    272    272    272    272            �           2606    25486 !   M4SLL_CASUIS_CTAS PK1911141709510 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CASUIS_CTAS"
    ADD CONSTRAINT "PK1911141709510" PRIMARY KEY ("CCU_CASO", "CCU_NRO_ASIENTO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_CASUIS_CTAS" DROP CONSTRAINT "PK1911141709510";
       SLL            SLL    false    216    216    216            �           2606    25512     M4SLL_CONVERSION PK1911150935200 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CONVERSION"
    ADD CONSTRAINT "PK1911150935200" PRIMARY KEY ("CON_REFERENCIA", "CON_VALOR_CONVERTIDO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_CONVERSION" DROP CONSTRAINT "PK1911150935200";
       SLL            SLL    false    238    238    238            a           2606    25654 !   M4SLL_PARAMETRICA PK1911201027060 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PARAMETRICA"
    ADD CONSTRAINT "PK1911201027060" PRIMARY KEY ("PAR_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_PARAMETRICA" DROP CONSTRAINT "PK1911201027060";
       SLL            SLL    false    331    331            {           2606    25680 "   M4SLL_RP_ES_PROVIS PK1911201647210 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_PROVIS"
    ADD CONSTRAINT "PK1911201647210" PRIMARY KEY ("REL_USUARIO", "REL_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_PROVIS" DROP CONSTRAINT "PK1911201647210";
       SLL            SLL    false    348    348    348            w           2606    25676 "   M4SLL_RP_ES_FICHER PK1912101750530 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_FICHER"
    ADD CONSTRAINT "PK1912101750530" PRIMARY KEY ("REFE", "USUARIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_FICHER" DROP CONSTRAINT "PK1912101750530";
       SLL            SLL    false    346    346    346            W           2606    25644 "   M4SLL_NEGOCIOS_ROL PK1912231250370 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_ROL"
    ADD CONSTRAINT "PK1912231250370" PRIMARY KEY ("NEG_ID_NEGOCIO", "ID_APP_ROLE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_ROL" DROP CONSTRAINT "PK1912231250370";
       SLL            SLL    false    325    325    325            =           2606    25618 "   M4SLL_MTO_EST_TARE PK1912271205370 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_TARE"
    ADD CONSTRAINT "PK1912271205370" PRIMARY KEY ("MET_ID_EST_TAREA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_TARE" DROP CONSTRAINT "PK1912271205370";
       SLL            SLL    false    310    310            M           2606    25634 !   M4SLL_MTO_TAR_CIE PK1912271205371 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TAR_CIE"
    ADD CONSTRAINT "PK1912271205371" PRIMARY KEY ("MTC_ID_TAREA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TAR_CIE" DROP CONSTRAINT "PK1912271205371";
       SLL            SLL    false    319    319            ;           2606    25616 !   M4SLL_MTO_EST_EJE PK1912271205372 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_EJE"
    ADD CONSTRAINT "PK1912271205372" PRIMARY KEY ("MEE_ID_EST_EJECUCION", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_EJE" DROP CONSTRAINT "PK1912271205372";
       SLL            SLL    false    309    309            �           2606    25496 "   M4SLL_CIERRES_MENS PK1912271205373 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CIERRES_MENS"
    ADD CONSTRAINT "PK1912271205373" PRIMARY KEY ("CIM_ANIO", "CIM_MES", "MTC_ID_TAREA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CIERRES_MENS" DROP CONSTRAINT "PK1912271205373";
       SLL            SLL    false    229    229    229    229            }           2606    25682    M4SLL_SEGURIDAD PK1912301210170 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_SEGURIDAD"
    ADD CONSTRAINT "PK1912301210170" PRIMARY KEY ("ID_APP_ROLE", "SS_SECUENCIAL", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_SEGURIDAD" DROP CONSTRAINT "PK1912301210170";
       SLL            SLL    false    349    349    349                       2606    25684 "   M4SLL_SEGURIDAD_VI PK2001151711500 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_SEGURIDAD_VI"
    ADD CONSTRAINT "PK2001151711500" PRIMARY KEY ("ID_APP_ROLE", "SSV_ID_MODULO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_SEGURIDAD_VI" DROP CONSTRAINT "PK2001151711500";
       SLL            SLL    false    350    350    350            �           2606    25492 "   M4SLL_CCB_RJCC_BKP PK2001281715260 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RJCC_BKP"
    ADD CONSTRAINT "PK2001281715260" PRIMARY KEY ("RJC_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RJCC_BKP" DROP CONSTRAINT "PK2001281715260";
       SLL            SLL    false    226    226    226            �           2606    25494 "   M4SLL_CCB_RJCD_BKP PK2001281715261 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RJCD_BKP"
    ADD CONSTRAINT "PK2001281715261" PRIMARY KEY ("RJD_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CCB_RJCD_BKP" DROP CONSTRAINT "PK2001281715261";
       SLL            SLL    false    227    227    227            K           2606    25632 "   M4SLL_MTO_SEG_INTE PK2006221525030 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_SEG_INTE"
    ADD CONSTRAINT "PK2006221525030" PRIMARY KEY ("ID_APP_ROLE", "MSI_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_SEG_INTE" DROP CONSTRAINT "PK2006221525030";
       SLL            SLL    false    318    318    318            �           2606    25736 !   M4SLL_WKF_ESTADOS PK2006221525031 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_WKF_ESTADOS"
    ADD CONSTRAINT "PK2006221525031" PRIMARY KEY ("WKE_ID_ESTADO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_WKF_ESTADOS" DROP CONSTRAINT "PK2006221525031";
       SLL            SLL    false    388    388            C           2606    25624 !   M4SLL_MTO_MODULOS PK2006221525032 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MODULOS"
    ADD CONSTRAINT "PK2006221525032" PRIMARY KEY ("MTM_ID_MODULO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MODULOS" DROP CONSTRAINT "PK2006221525032";
       SLL            SLL    false    313    313            -           2606    25602     M4SLL_MODULO_ROL PK2006221525033 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MODULO_ROL"
    ADD CONSTRAINT "PK2006221525033" PRIMARY KEY ("MOR_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_MODULO_ROL" DROP CONSTRAINT "PK2006221525033";
       SLL            SLL    false    299    299            o           2606    25668 "   M4SLL_ROL_ACT_ROLE PK2006221525034 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ROL_ACT_ROLE"
    ADD CONSTRAINT "PK2006221525034" PRIMARY KEY ("MRA_ID_ROL_ACTOR", "ID_APP_ROLE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ROL_ACT_ROLE" DROP CONSTRAINT "PK2006221525034";
       SLL            SLL    false    342    342    342            �           2606    25738 "   M4SLL_WKF_ROL_ESTA PK2006221525035 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_WKF_ROL_ESTA"
    ADD CONSTRAINT "PK2006221525035" PRIMARY KEY ("WKE_ID_ESTADO", "MRA_ID_ROL_ACTOR", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_WKF_ROL_ESTA" DROP CONSTRAINT "PK2006221525035";
       SLL            SLL    false    389    389    389            �           2606    25740 "   M4SLL_WKF_TAR_ESTA PK2006221525036 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_WKF_TAR_ESTA"
    ADD CONSTRAINT "PK2006221525036" PRIMARY KEY ("WTE_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_WKF_TAR_ESTA" DROP CONSTRAINT "PK2006221525036";
       SLL            SLL    false    390    390            I           2606    25630 "   M4SLL_MTO_ROL_ACTO PK2006221525037 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_ROL_ACTO"
    ADD CONSTRAINT "PK2006221525037" PRIMARY KEY ("MRA_ID_ROL_ACTOR", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_ROL_ACTO" DROP CONSTRAINT "PK2006221525037";
       SLL            SLL    false    317    317            �           2606    25472    M4SLL_ABOHON_NJ PK2011041824350 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ABOHON_NJ"
    ADD CONSTRAINT "PK2011041824350" PRIMARY KEY ("ANJ_SECUENCIA", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_ABOHON_NJ" DROP CONSTRAINT "PK2011041824350";
       SLL            SLL    false    206    206            �           2606    25692    M4SLL_TOTHONJ PK2011091911480 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TOTHONJ"
    ADD CONSTRAINT "PK2011091911480" PRIMARY KEY ("TNJ_ANIO", "TNJ_MES", "MAB_SECUENCIA", "ID_ORGANIZATION");
 J   ALTER TABLE ONLY "SLL"."M4SLL_TOTHONJ" DROP CONSTRAINT "PK2011091911480";
       SLL            SLL    false    355    355    355    355            �           2606    25554     M4SLL_FASES_PROV PK2011111629350 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_FASES_PROV"
    ADD CONSTRAINT "PK2011111629350" PRIMARY KEY ("FAP_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_FASES_PROV" DROP CONSTRAINT "PK2011111629350";
       SLL            SLL    false    266    266    266            ?           2606    25620 !   M4SLL_MTO_FUNCION PK2011160939420 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_FUNCION"
    ADD CONSTRAINT "PK2011160939420" PRIMARY KEY ("MOR_FUNCION", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_FUNCION" DROP CONSTRAINT "PK2011160939420";
       SLL            SLL    false    311    311            9           2606    25614 !   M4SLL_MTO_ESTADOS PK2011161141410 
   CONSTRAINT        ALTER TABLE ONLY "SLL"."M4SLL_MTO_ESTADOS"
    ADD CONSTRAINT "PK2011161141410" PRIMARY KEY ("MOR_ESTADO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_ESTADOS" DROP CONSTRAINT "PK2011161141410";
       SLL            SLL    false    308    308            �           2606    25516 !   M4SLL_CPE_CEJPJ_C PK2011181849030 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CPE_CEJPJ_C"
    ADD CONSTRAINT "PK2011181849030" PRIMARY KEY ("LIT_ID_LITIGIO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_CPE_CEJPJ_C" DROP CONSTRAINT "PK2011181849030";
       SLL            SLL    false    240    240            �           2606    25518 !   M4SLL_CPE_CEJPJ_D PK2011181849031 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CPE_CEJPJ_D"
    ADD CONSTRAINT "PK2011181849031" PRIMARY KEY ("LIT_ID_LITIGIO", "CCD_ID_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_CPE_CEJPJ_D" DROP CONSTRAINT "PK2011181849031";
       SLL            SLL    false    241    241    241            �           2606    25686     M4SLL_SGD_CONFIG PK2012141927230 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_SGD_CONFIG"
    ADD CONSTRAINT "PK2012141927230" PRIMARY KEY ("SGDC_CONTEXT", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_SGD_CONFIG" DROP CONSTRAINT "PK2012141927230";
       SLL            SLL    false    352    352            �           2606    25732     M4SLL_VAL_EC_LIT PK2102051253490 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_VAL_EC_LIT"
    ADD CONSTRAINT "PK2102051253490" PRIMARY KEY ("VEL_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_VAL_EC_LIT" DROP CONSTRAINT "PK2102051253490";
       SLL            SLL    false    386    386    386            !           2606    25590 =   M4SLL_MATRIZ_PRE_C_PRUEBA_GABY PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY"
    ADD CONSTRAINT "PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK" PRIMARY KEY ("ID_ORGANIZATION", "MPC_SECUENCIA");
 j   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" DROP CONSTRAINT "PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK";
       SLL            SLL    false    292    292            �           2606    33123    STD_COUNTRY PK_COUNTRY 
   CONSTRAINT     y   ALTER TABLE ONLY public."STD_COUNTRY"
    ADD CONSTRAINT "PK_COUNTRY" PRIMARY KEY ("STD_ID_COUNTRY", "ID_ORGANIZATION");
 D   ALTER TABLE ONLY public."STD_COUNTRY" DROP CONSTRAINT "PK_COUNTRY";
       public            SLL    false    391    391            �           2606    33125    STD_GEO_DIV PK_GEO_DIV 
   CONSTRAINT     �   ALTER TABLE ONLY public."STD_GEO_DIV"
    ADD CONSTRAINT "PK_GEO_DIV" PRIMARY KEY ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "ID_ORGANIZATION");
 D   ALTER TABLE ONLY public."STD_GEO_DIV" DROP CONSTRAINT "PK_GEO_DIV";
       public            SLL    false    392    392    392            �           2606    33127    STD_GEO_PLACE PK_GEO_PLACE 
   CONSTRAINT     �   ALTER TABLE ONLY public."STD_GEO_PLACE"
    ADD CONSTRAINT "PK_GEO_PLACE" PRIMARY KEY ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "ID_ORGANIZATION");
 H   ALTER TABLE ONLY public."STD_GEO_PLACE" DROP CONSTRAINT "PK_GEO_PLACE";
       public            SLL    false    393    393    393    393    393            �           2606    33129    STD_PERSON PK_PERSON 
   CONSTRAINT     v   ALTER TABLE ONLY public."STD_PERSON"
    ADD CONSTRAINT "PK_PERSON" PRIMARY KEY ("STD_ID_PERSON", "ID_ORGANIZATION");
 B   ALTER TABLE ONLY public."STD_PERSON" DROP CONSTRAINT "PK_PERSON";
       public            SLL    false    394    394            �           2606    33131    STD_SUB_GEO_DIV PK_SUB_GEO_DIV 
   CONSTRAINT     �   ALTER TABLE ONLY public."STD_SUB_GEO_DIV"
    ADD CONSTRAINT "PK_SUB_GEO_DIV" PRIMARY KEY ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY public."STD_SUB_GEO_DIV" DROP CONSTRAINT "PK_SUB_GEO_DIV";
       public            SLL    false    395    395    395    395            �           2606    16454 0   databasechangeloglock databasechangeloglock_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.databasechangeloglock DROP CONSTRAINT databasechangeloglock_pkey;
       public            SLLPE    false    201            �           2606    16467 :   jhi_persistent_audit_event jhi_persistent_audit_event_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.jhi_persistent_audit_event
    ADD CONSTRAINT jhi_persistent_audit_event_pkey PRIMARY KEY (event_id);
 d   ALTER TABLE ONLY public.jhi_persistent_audit_event DROP CONSTRAINT jhi_persistent_audit_event_pkey;
       public            SLLPE    false    204            �           2606    16472 @   jhi_persistent_audit_evt_data jhi_persistent_audit_evt_data_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.jhi_persistent_audit_evt_data
    ADD CONSTRAINT jhi_persistent_audit_evt_data_pkey PRIMARY KEY (event_id, name);
 j   ALTER TABLE ONLY public.jhi_persistent_audit_evt_data DROP CONSTRAINT jhi_persistent_audit_evt_data_pkey;
       public            SLLPE    false    205    205            �           1259    33113    IDX_COUNTRY    INDEX     m   CREATE UNIQUE INDEX "IDX_COUNTRY" ON public."STD_COUNTRY" USING btree ("STD_ID_COUNTRY", "ID_ORGANIZATION");
 !   DROP INDEX public."IDX_COUNTRY";
       public            SLL    false    391    391            �           1259    33114    IDX_GEO_DIV    INDEX        CREATE UNIQUE INDEX "IDX_GEO_DIV" ON public."STD_GEO_DIV" USING btree ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "ID_ORGANIZATION");
 !   DROP INDEX public."IDX_GEO_DIV";
       public            SLL    false    392    392    392            �           1259    33115    IDX_GEO_PLACE    INDEX     �   CREATE UNIQUE INDEX "IDX_GEO_PLACE" ON public."STD_GEO_PLACE" USING btree ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "ID_ORGANIZATION");
 #   DROP INDEX public."IDX_GEO_PLACE";
       public            SLL    false    393    393    393    393    393            �           1259    33119    IDX_PERSON_FK11    INDEX     Y   CREATE INDEX "IDX_PERSON_FK11" ON public."STD_PERSON" USING btree ("STD_ID_SALUTATION");
 %   DROP INDEX public."IDX_PERSON_FK11";
       public            SLL    false    394            �           1259    33118    IDX_PERSON_FK21    INDEX     V   CREATE INDEX "IDX_PERSON_FK21" ON public."STD_PERSON" USING btree ("STD_ID_COUNTRY");
 %   DROP INDEX public."IDX_PERSON_FK21";
       public            SLL    false    394            �           1259    33117    IDX_PERSON_FK31    INDEX     h   CREATE INDEX "IDX_PERSON_FK31" ON public."STD_PERSON" USING btree ("STD_ID_GEO_DIV", "STD_ID_COUNTRY");
 %   DROP INDEX public."IDX_PERSON_FK31";
       public            SLL    false    394    394            �           1259    33116    IDX_PERSON_FK41    INDEX     ~   CREATE INDEX "IDX_PERSON_FK41" ON public."STD_PERSON" USING btree ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV");
 %   DROP INDEX public."IDX_PERSON_FK41";
       public            SLL    false    394    394    394            �           1259    33120    IDX_PK_PERSON    INDEX     m   CREATE UNIQUE INDEX "IDX_PK_PERSON" ON public."STD_PERSON" USING btree ("STD_ID_PERSON", "ID_ORGANIZATION");
 #   DROP INDEX public."IDX_PK_PERSON";
       public            SLL    false    394    394            �           1259    33121    IDX_PK_SUB_GEO_DIV    INDEX     �   CREATE UNIQUE INDEX "IDX_PK_SUB_GEO_DIV" ON public."STD_SUB_GEO_DIV" USING btree ("STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "ID_ORGANIZATION");
 (   DROP INDEX public."IDX_PK_SUB_GEO_DIV";
       public            SLL    false    395    395    395    395            �           1259    16473    idx_persistent_audit_event    INDEX     r   CREATE INDEX idx_persistent_audit_event ON public.jhi_persistent_audit_event USING btree (principal, event_date);
 .   DROP INDEX public.idx_persistent_audit_event;
       public            SLLPE    false    204    204            �           1259    16474    idx_persistent_audit_evt_data    INDEX     k   CREATE INDEX idx_persistent_audit_evt_data ON public.jhi_persistent_audit_evt_data USING btree (event_id);
 1   DROP INDEX public.idx_persistent_audit_evt_data;
       public            SLLPE    false    205            �           2606    16475 8   jhi_persistent_audit_evt_data fk_evt_pers_audit_evt_data    FK CONSTRAINT     �   ALTER TABLE ONLY public.jhi_persistent_audit_evt_data
    ADD CONSTRAINT fk_evt_pers_audit_evt_data FOREIGN KEY (event_id) REFERENCES public.jhi_persistent_audit_event(event_id);
 b   ALTER TABLE ONLY public.jhi_persistent_audit_evt_data DROP CONSTRAINT fk_evt_pers_audit_evt_data;
       public          SLLPE    false    3750    205    204            S      x������ � �      T      x������ � �      U      x������ � �      W      x������ � �      [      x������ � �      X      x������ � �      Y      x������ � �      Z      x������ � �      \      x������ � �      V      x������ � �      ]      x������ � �      ^      x������ � �      _      x������ � �      `      x������ � �      a      x������ � �      b      x������ � �      e      x������ � �      c      x������ � �      d      x������ � �      f      x������ � �      g      x������ � �      h      x������ � �      j      x������ � �      i      x������ � �      k      x������ � �      l      x������ � �      q      x������ � �      r      x������ � �      m      x������ � �      n      x������ � �      o      x������ � �      p      x������ � �      s      x������ � �      t      x������ � �      u      x������ � �      v      x������ � �      w      x������ � �      x      x������ � �      y      x������ � �      z      x������ � �      {      x������ � �            x������ � �      |      x������ � �      }      x������ � �      ~      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x��}[�$9r�s���w��y���lOk��̎<���]�� I�d���ߛ�*2y��d&�s�-4V�'OUT}'ȸ��f7����?W������1�.���1���������x��0��s�Ν��&�����"��R�3��-��{�����?�^~����Li�Iq���?�����r��/�����_���ۯ������_����v\��1>�������a�x_s���Bǟ�ʽc
FP���)�\�����ό|@O٤�y.Ӿ�Q��>W�?�?�F> ����O���������_���ǟ���?��%=�����N;��;{,�]�����ģ��K��Y��%�S6���c�u0�J��v�V�����I�}���4�(l�����}0����>|�}��9���υt���)Ŕ(�����{'��Q����_��T�Ʈ�w�]ݟ;��Gf_6��W���Pw �C�{��Ϟ��?{��r�i�9}�������?��߿~���j��˿}�oC��w�J_;�w���C�� �<���%|?P�￉�Χp� �G�՜���9j�]��v��+�*��ȇ����:A��藺�.X-��B���5wx��Op�8�����u:�]��CLǰ�����㇦^����L'�>����������^��o/�����~���K�_����?cR�Hrkm�{���d����.�a��2�czr�x���,�$����$KT���K~�"��/޳�'ᾰ����F� ۀ,�ꗓ@2���a k'�0�'�٭��~��Û|���]���k�,�~��Y9�`|���EЦ�ش�AnZ�|g3���x�Wx�9w�8������g�,��"*-?��F��s�f�����peL�]��R�OFBKe�R�
�Űpa>��0䜉�oW��}�Y+���q~2l��X�n�!Ku���33��Y���$��
�dN��7U������}�:HE����Q]º?ҽ�J�����6ap��oI�?�?��w�\e�]�Ƥ��YfPhi��^��?�0��Y}��A�~xAg� ��O���9t�Q�&����]}�c�t��s	%��U���VYػA�*i��FY)Z杵���q����>��DP��/�"_}��P�`P:qGQ�%��ļ�HM��pȠhÓA	 gw�Z*��}�08�a�D�(!q�P��^|xú��5�����ܔ��s/�:�ɬd?;�ȓ8��S,�1D�C��h�.�u�"�h%+��Q��<!��E���铔����z�.��8�4�a�)�Jw�kqs�"c=k;ː�J�y�2�F\�=�`�{�ߐk�K8�A	_/���=�e��|���J�r�4�MۘY����|� $�<�̽ܿ��.B�'�3�����{2(ڭ_�'t�S���@w�X%=3<+���C[�@�����g]BU|ޏ�	��k=�eȯۻ��k��CٸՊ��!��?�ӆ>�_zw�ě)}�RM�������l��0"�P�e��Kk��$L���x��,�!UD���ʛօG��<BB�%.�/��i�$Dև�!�PxL0�W��>I��K<��~@��i��d{�9���1�,�;�c�!��t��ۓ	%N��J\;-�*!��0�'�]�IV�Kb��+�Hx�����<ѫ`�V���#�':���E���2Na8�Ƞ�!�P�µ�K��#g���a���p�?�0=9����J+$ڃdBH�5��.B="X��!ꝨD��z6�z!\p��@B�:�3���5�S�f+�J�zD�z8�u�C�ܢ��V[�>��RF5���(�­��p��ő(��G�Zm���{�ѧ��]�!W��*$������N�/��Ul���&�vڗ*5�oh�܋���iB�N� ��h��(R�5I[���>����c�I!ġ�h���	�.v�и�J�����l���[�k�Lq�,j�_��{Z ����ܫ=�cj�K?� �k�S^��'�^����wL��d��V�$b�>�'<�������O1j� �/�1��;��b��6�)��=�%��%8�h�̶�xqŦ�4�dYo5��A�H-�_��g�7�:�Qө�K��_�F7%���'Kp�潑ؼ{� #�D�%��X���\��^�a��Uw!ث����N�����y
�}:���Is�u��}(�e�F�BP�e��w`lb�m��=�Z��y������U�n�s+[l�i�q�L�0��.M��vxQ���#L6��Nx�&M�x���G��Z�9�M�����Y�����CH(�r�"��rÊQJ�F�eB	����`����!�TioF��AtI1_��`��*�r��P�ͩ1���@��V��\XJ��;���C�(�3�"c#[����67��ծ���e���KB�����T��eF���D}��Ɇ��a��2��ϼx��1=/��\G C���2Z�*X�[�ז�!��Q^:w�%ؾY|���`9���'c3�[|��R�*����v$j:�p/�Lq�.�^3�
�l�z�����^ѥ$�!��E�t��`��xV��CPP��.t��^>6O_�(��BW�츍r�7��\أM�Vs.7^�ȩ�b�޼PZ�ŕ�4����wr�،�Fs�����3�u�d�\pL�׍��2�XRn���!Q���):���<)m�	$Ji�ض��y�>�]����'��`7�Ū${Gyq��Pb�S�~�����P�t�:�����N&����o�+��n��8����A���O�(�Y!� ��.�E�s�E�{��%BlwC�*��M��y�Z�e�ԗɖ$��`�8�ȾӇ�
pi�ہ>��N�$�B��c_�!mtI!��А%q��ڢ�X��e�9i�Y9$��&�$~ܩȒ&�v�!�&m� �?SfKK�1���Ұ笄U^,9�W�W#�*��*�C�9�J��ʑ����Tj5�z���t�?�hʌ�>�i8fQ��X����b�ؾfG�&���<�(�]�ۇ�*��W�����ݺ�gL�r�4��0Nǰ�u=�7S�t��܏��@ҋ!.��n��a���ߎ����m���@2�����o����y��D���:A �P�3�&�6��k 궮�(CS��C|����{�dm/���]���
>cZ����3- 뵠���W�o�����m�����>yYdb����lH��f3�\c� ���gc'j?�P,�įE��al�A�`�-K��8���G�-�c3E��������8����`�&���l�3J�4"���4"�Џ/�������K�Z3k�aj�Fw�õ�D6��F�oV b�*H��/q�P]�*�~�X둔��ӫHD�K)/�A��ӵ���� ��n4�$��Lf{�a���	���5*��[�R��6�"��	0��s�;;��oDp��vD��~6����y�B��:�2Ԯ-S��Յ��7(�׍o?�����m�P�^���2\���M'l��}}�!��C�9��{�V��0_j�x2�lLp�^����I_l�*��-�$����<j������>��F���<j`>��C�'ҵ`��K� ����kF-]$s���+`�_l�&�;�ʾ�+|����C-��Q6Εxϖ��\_l�*��Mp�^��}�Y ��{�Dپ��������=�P����t|�����1�g�+\�9z�K>�A�2z��� awH�Qq������Bz˚��؆�ˍ��l[�q;e�O�U;^���lF���<���p��PM�;k5 �I/}Ѩ���,�<�¨��?��q�P��.���;��6�n�B���X��Z��J�ti�˚�v��֌BB�n�5܌�te6N��ka����b]�v354��fMd�1(��5n3x}.4~�����q3���ې��Z<$jZ��U�'uw��Br˥    ���o,_�^P,R-��ys⛣h�C��(-@�J"���AJG4�=s7
eN.�d���r9D�Rb��b��	nL��Y�2���وaX�0*����4�!iY^��"�7����a+t2��nr y#��8$U>A?=T��Lb��Ћ��FA�I�M�$����� bc���	�D0S�Z�uKJ�X��ޖ�� �yC�3Q���j[!6�	�jն�py�h���$(C������2�ϐPȪ�p�m�1�tZ$�Y�#益+������4�i��_=�9�x>���v��3��A�tٝh�.w�.R��c����9a?ƨ�F:�@�/_8���{��g+����zמD��"FD�v���A~����9fhn��<��-�	!~~�Ut�`��rq��&$��P-�0��#�<U��6��[+��&�4��	��.T�^�W��ʘ�}�0�����Z�jZS�Hx}�B�L�!,��3z����5���B��^���̗�d���7�"���wEl�fPĢ��E�&�fPĪ)�/����!w� ��@ǯ͙EW�V�cI���V�9�*-z�KK�6�f�~y�qyoC!�+4��v���$
�8������g:Ux�Us4t~F����MϢ�d#tO�@��B�Y�_��0$ք��]t��+�u���o4[��7m�72�.G�CHX;R�웬�:��9.n�h�T�!�fD�h�<�yk�(�s�v�5���l�&�b�s}q��'oC�xߌO��'�;��
`u��X�!�����t�I:_c+�i"�h,3��-��wQJ]��7͇�L�%jR=�V �dh���S���l +���+�Z�	��!L�أ6$��Y�i�2�R�	8q�U���9�J$�VW���`��%DXFB��g?ߏ�C��ö�	m��2|yS�؞���Q1qF��X�b/[m�H����롫�kXm\�H>�Of�mն���#��ܗ/*�����(�ڍ�g2�x��=6�}z���K�րJή1����/���$��
�@������:�q�Ɩ�:�P��+	�t<��c�"�̣[���)W��!��)�� ~X�ȅ]�i�]^��#}�ݨ�=b��|0ϲw��TD
�Ca<W�k�ڸ���o�f��snc����Ѧ?� �[��1�P]62�mQ��{B�}['���1aW|����������0�Y|j/;�q���]��ݧ2�Ǳղĺr\�ԙ������y wkVꐙ�L�/�^�T�:�bY
��("��X��X����ڕ����I���2�ء��y�5�5��	��x)���Nܜ[x0��N�|t��݅k���_k�Do�=��1�c�aM�H�D��@�$����;{f���24�Nz=r��l~*���q�)N�$�^gJz���n]�F�n�p���2iң&Z ��,�81[5�������;�� z
@��4_�G��1 ���}�	r+�hm��͕����*�!8
/B�0u�!�� �ۡq�h��(�9/��K\fy�U}��m����w'0n�m!$&cS�y�!n�<��N
�+S(-Լ�ж�I6]е=�0j�@ɜ]��n�iP�W�� U���j�rz��X��o]�N=R�R��Y�'��S'�2�S+�뀞�nf���P���g;L	�X;��d��w��A���P��#W�^t��L� �M��lB2��;[oi��{�Q�7�9sqMР�F����T��Y�f�u�f��g>���/���M�:[B�\���v��W.(s��	@������c�t�"�� Ǳ�l�N4c��b���\�50���9�]�{9҄��*�.��x���ѽ���0r�!�Yy��=`�_�vuW��r��P��(�0f�����������u�n�u&NδKG:���-R��aV��G�j��Ip/�]z�{	T�9�W�<��WXo����U�2>��T�*1ڈ����ϙ�yC�3�I_ �Uꈯ#}� �Ӿ� � �� _b��:�c=�Fw���Bx��*����Ko̞i.b�2:�zf�V�SAe���'�yq�{�U����)�+��#^��X����������ۋ��3^�R���p�,u@����iB����7k7�PjI^����*qMu4]�,|@���w/��6����M,ǔ���]��4��v�+N�.|D_�4�#�W�{���X�r���܄�/���
C0e���J��h���^w`���y�����)��<�p�tp#����L�3�$u˓eX����h�cB�\�tRl�5�Ȍ���7P6��"����hL��̚	t��ѯ2��m��TA�3x��K�����.dzb�؁��)�D�(��C=x3%���y�B$3ˢ�kz���y���^�UQ��p]HD���Z�B �d�1��?>R����и�H�KT�9Ŝ�΋� ��Uȉ���\ 
z�W?>z���3�IX� S	ŗ�EW?u|�o��6q�t���DV�,���������Z��T�Q��/+��{ղ�F�\sFŠ۷��:N�4�P:��|�A"�I�:�q�\Eɹi�Q����}`�_W9��Mu��H)W�k��j��J�[b��~�U�O�[��8��R�S���%� h=֭�L�1{�N�#���\@h��!���Ԉ���)#ݝ¦�4UHC+��8������>�B��S9	5��Q'��p��!q��q�#]G3P�g�5o�0,�z�rg ��*=�� ��1��<�3��Z�	�ܛX*?n�C��ˍd�;��>ࠤ����Z�p�S�Q��#\šEk?;Pa����������s�����aϥM�f2̙��H@c���^�zA���%d1�����^��)��z��+]�X��yI�f�sTD<����(�\�����.ѪP�тF�<�W�x]?P�S��^w��E<ŷ��ny��y��"\���ۤ	��W�P���w�g�] ���:�g`�(�]�LS�=�ۂ�Һ6xT��t\�+k6p�ܳ�j88o�=�!���u�A��v1�]D�|��c��G����8�ִB=��>-����&c$V��ɑu꯼��Y+�i��,T�	��JX�''ޱ�7��Ē�k/�N���L��E���'�]-M`��9��^�
�H�]�;�[�;؟��B�4��@B	5��<ˮ��DRW����`��mO$�XD;i�Lfƕ�]��>�0����	�X����]���+�ٿ����S���Hݔ���(t�-�	�?��8����$|,����Mc���C�`'��P0�*<زy>"F7]���s���GVt^ R���J��[&+�x��I���7aqZ�B�ʱ��v Ēї��Bl��Ap΋���5���l��
� H�0��\ayi~���\��� ^��	!�pQ�Y�4��2@ؘ��ABK�j��2M��*��x��4c�$�0R����]�H����	���~(fΠ�UF��b�ň$Az�D8 f�A��)�!(�M@?�J�rXF-$���	�N��/������]��*j 7�lI6��|��-@�ڽt=��G�����v��Զ�'�\�Y�T����rZ�"����pd*N�$N�LWo �-qh^���EW��N}�i�Lb�윦I�X*�u	+k����q��!i&�@�	@s��zRz��k�15xZq7#_1�L%H�3--Y&$"�\1���?>��"��x�jdj7�4
�v��L�$�^z�*�d�tL�w�vO��E�T�ܐ���ȳ0����U���)�4�6�u�r��������lM	����5	�w@�˼W�$Ӹk�B�!��o��J���0�fN�Ӄʖ�)���y�9RhY4�����挩3�ŗ;���!�pk���ҜmmV�-��̘�q�����,�EY��P�U���pU9��r��������Vm�����.���JbH� :=��&��$�j[�q���    �M�P���R �?6B��+ۗ�xe{�u��27�ЂkdGv��]�=���w���ɡ�#�E0
SJ :Gm���r�{���~`��[|ph>��J;'A�g��AD�(���ǀ!��hVaxjphp��1Ă��VD���>�p D�T�+d@��o!�W�f0��=lXp��9��f�f�1/	i�2CB/4,�d�4�TQa�q<tv �\�nzP,t��nIh�@]|��;߈p�Rܻ"�yW�J?����F\��x�h��ݤ}���m�C�_�-��S�XV"жd劰"��U���b"�b.�0�K�9�P�h>a%�l��c.��1�`��ہ���y3�]������a8����aKu�a$��.�1�P�Fn�HJS��j��fy�w~|�_�C�t:�.�t~ťH`��y���mxӺ��e��O�|�>�F�%c�Ə�O�D��;333�`��>�3N��8�Uf��I���	F����0ǧ~��

c���q��H�d`s�-ȃE���o�3�yl~�[��
�lN����Q�'���t�q�jL�޼G��Aa�v3�G=X=@#����=Ń5�	S|�j��(�T7�0�2׸�9<�D�7���n�s	�'�VٿT���)�� k]7�O�h1N�3}]��� b�z{lT-Id��x��c "=� gԁf�x�6S�0�4$��V�[���d@��y�X&; X8��<5I���V�s ��� �8�u n[*���= �7��;/p�p�>�Q���3�Ym����pel�����k|���a�jS'R��s>�E|�M]��K6��O4�oc��W�aq����ٯ�r���1�KS̃��9sb��h���d��!��%Y׀��X��i@.�cy[���b�S���Jl>?�es���?>H�"��c ��������?>��O�f��/�������S��Z$�?��v��W�� ��@
_���%v�>|��ˇ����x�\ȸ]��9�~?�O?���?��ӧۯ��~�ۏ�������������r׾/n��t� ƚ:A\/\�> �Rğ���?�^~�����A��0�}���a3c ��ʴ�G�����e[o�J�c���p�bČ�	B��9��M�aOꚴ�e�~|Ъ�$�'����WS��|�;��be۲���	��}�N��i�G9��p#��T��Z,I!Z���
PC���ad0��5,�k�U�Ԇ���̛K�X�!�zHد/ _�Hz}P*T���~�I���_����R��W�������hK��~�/��;��R��sU)����7�����)ӈc�/-�h"nVꒈ$Ga4W���S��I�S����N��\��Kƽ��Ǖ9s �x����
�Q�k�����y}�>�
C�
���L�Y���^�B�8�5M����H.V�	�ç�V����Ry��c냔-�۪�	mJ{�zm���Z��%A4(W��}� �6�K˸����*ˣ�/�ay������=ķG^��s���#�І짺�B=v+)?d{�1��C�a2�'.ñ=`*���y��`eI��A�-_�40�3�I�ܯ	�����R�����y�B���^��a��qX��0,�毛O���׽s�h����h�0�I����;7� ���%|�ۗ���4�-�߲s�=��K�c*iФé4�J:����">�_+��ݸ.ԃ`��%���E��c�$���D�P����"�j�u�����ᨽ>�v8j.���vv���$��7�'.Ʊ��щzH�e�
�	����3�@�M;B��� �6tBB��"a�*���ߢq¦�݇:���Ӽ'���6�O*e[;��o;�&�g��N$���ۂ�'�B���7���P�5f�}����X�f��z]� "�S���y� _��Ll��>Hf�)����mV��p��:5�vg��!�?�#M[���oc5[v�O�&�4��G2/�m�g0#�ª-�p򧔃�Y`w�j
����]�-�5$�(>M�]{.�����A�p3�ΦG���w�岍=�kP�,���"�A\�,"`���e.�=s^�&bzH��C�K}�lrt9I�.]f�Z�����޹��W҉�5�82\B������*k��3X�L("�f�)`�+�+\ߴQB��N�c�f��ǮWEEcU��ٽ�|���R>/F��;�a1Ț�%�����؊�ˬʗ	?�̒�UUs�$]���:�$�x+y��Z�E{$ʬ+}GFd9�o�߆�����rcc"���*K�p�F@o�S�am0�m�1�����&�D�)Ē):�x�%=b��9ŏ�)\��8!���������7��S�Ea�Ћ�����'�8�sg��Gu�7�~�2/���D��;4��؉�����;���O3[��.��f6b�	��EÜ��!��3�v�s�gY�O�t
�Ƕ�T�$yC�j���I��w�����6��"%_�D��%���==Dj�򺞿-O��!��'���z�l)ӵfhj�b��Y��0l���$�~|�G��^��M��M� l�3�8�5���2���wB�"�R��I���
B;�h���BU��f��p����Tٹ6�J XtD�1˃4۞���
����)Ft�-; ��S��Y_ǪU��d+���l�n��	�;��b�h9T吗�*78��$�N�R!w�ȴ�~�gW������;���T����%��8�g���jh�T*����1�P�qM�֜�]��t�Sz�h��=�����D�R�q��9�n��l�䖝-�?:[D.���S-�bCv[)~�$J6xّ��p�j^�fI�L���L��)9���Ήv�a��qH�U�AR�d�\�#{ ��'���A���!������֪��w3�� Z�����W�_�ǂb�l��z�[��݆�6-g##@������aL����Ȝ<�X��cI�Kj�(�R��^{��������k�6e��H���y��j"�o�[g�]�z�q�0�g����~�|�Q>���A=Ԭ>�Ŵ&TK�Tw��o�a栿]|��0%$�T1�Ƣg�
m����E�w���;���rE�Uj+�ЅH�競|�ͳ�/�^*q�'��Je���P!����2�"��T�K#$�\��K"�bkR��Ӳ�U�-��!��疿ғU$��^��4��x�rk��O�����Z��D��8`�zZw{e�~����A<�u?te�u�؊��b3���)�5D�΁����|�Y /�:0������;"�)W��p��~\2q���9�2�6���rn�i���%�6}��r�����fo<o�7�q��,H�͍Q1�Z6'��;di�"�k�0��$��֫�
:?Bڑi���kہvzo�k�@��7Bp!�"��ƐAoƢd	��A�z\*yDt��"f�"GF[A� �/ג���p˺��.�H��ά�V�f>�qBjSi���uK
�f�����NBy�]$+ڮ�KRS�g�:Y����3�ƜQH�9�J��>�+���*�7{��_ҚxY��ё�{W�m<\��#����N�n�O3V ��Bj��
�᱀~�	cl�C2`��.������6�4��I�
[�I�ó�@I�s�xxDe\���&AK�����/ˑ/_~�W�i�2���z��KH͖�������ک`�\�vlɗ͕�3.�H ���p(���<�wI� "��=�6��� "A�B�/��[�;��>r�#���$�B��df��T*��~�Al�	��8�K6-��ڟ�H5醒s���7Go3���j(�(0p�=H��G�ڷW�mKzƅ�v륌Zw�xX�p�e@E�Г�[�!���J�-�uR�F6f��A��|���C(�v�:ϗ�x��){��~f��]��{	�ʞz�@M��!��Ct�ҙ�f�SAc�������6W�x�m��"X�J��x{`@+���'DVKjuS3�)���qK�����U{|��    �F�j��j�^f��g��*�$��E��� X'��JG�ѭ���F�f�%+02���p�Q?���G3���I��= �'n���I�f4�H=8y�ǵ8�m�z����?��'�B��7���^�	<��j�9�^H��Vh]1���~R�z!H�~2Ñj����(�UԔ��h�R���)�^�m��V��m��6�c%� �X�-�����o�Qۑ<q��)��+�z����)�搫��	a��"5 �T)�A��l	�9�o�d^���g�+�0�^(-_��S�Z)�
+[��$^(=1BT�1���0}��>��Q�B�����a6��'�vUn.ʱ+��I�b����Az�3���\�Eҗ����@Z�֡D�0b���n�d�dr��tO��=y�E9��""�^�gW�XZ�q\�%1�q�w�#��G[�Z-���Ʌ�����H�ۛ�9y����mGB�&�@�F!�����Z���Q��$�#dXo ��ɷz.��*�k+�^�*@�z7!�%h�S�T�h!c��
z馉gv}{�Y�Ř*6�r	y+�"�\M�=����ܧ��Y׎��)��.��]S��W$� ?���T?$v�*�5�'7G��=woW��f�����c.#z��2z�=~EN��ƪؠ�Kc�����֡@��2�������	�!��#�J:�{τ����9��V�$<#����!���ԍ{�Pf�/d���zÿ2�o��`����7CH�F@5F`{�I}�޸�bL��_qWE���x�4q�k�
����'�B�y.�*���XX�f#��fm�T�&�5x��-�t�ɤF�j��3R�Lb�8�b�&Q��v<H�;��ŉ�,���Dθ�sL�ء�s�WL� ��I�ZWr�p�J�;¹�M�4\ߤ:B0�4���9�IjGo=�B��?|<�r��rUK�>�=c׌I��8wE���^��(�X.0��ރ@���/�x�Ā�`����?)�L;pS2�mCU<�VO^���BXߋ���;��yC�~�4��_'���cӧ�8!�����!\�塡A4(y��*|���y�T�R�eS��TY�Z�MTƮ�@���'����?$���p����n;@�!��5 �&4)/C�}���vv�eh���p#	�{���>�g����8�H6c�j��r֫1�g���j�� e����UJ�S;���1���]z�qk<�ZB�)-���������5���/�P�6zw���^�T�	7��\����
=<�Ib�lOZ⨽Mixlӌ��M�����v�ĖÐ�gcHj�c�[���9��tJF��S%�ƥ��]�t#@���O�㉺l���4%O},�Ά�q�0#Y|�g�|�8I��R�!�q�h���T? ��±�y�6/|���;YJ�' �a���_;���nw1"цI�ur.>z��ݏ/�~~����cx�����<��O�	����s��j?��������EZ�l�k��	j�A:��;S�Ї�w�����7I��q���%*g,e/"��RdN�yQOE���0�G���x&`�Ly�M��t�K��n;À��7+ٲ�L~���x,�*���ED��t控n�
�;m�rj��{�����P�m���D�n$��[���B���'�Y�W�
��) ߝ�5���$5~-(�\k���u~�/�S}k�=�o�`ab�5���o�`q�|k��~[KZ��+��,�x�_���s:S�(���O&�AU]A�4�dj�@p�P�]�q��*����%ф�/e&�o3=D�db�w�ɫ.�w0�|;$�r�غ�� `�ص}A�B��̡d� $�*w�Xx��'F�*C�ٳz�)0�.�զs%/�����Yn1�X��Y�t+Bh5��;a0�JD�R�g1V��	 �}+�w��OBh�C��e��^����]+H�.?D�'�d� -Zۉ�?5�i;.(ڎ�R1�Zeg}���D�zOl��m�v�!�W��(��R�w��a�X�SE����4�y�h��6����Uq�m�4����x�m�}��^���RUDB�U(�S(�h��2NH�l5��pn��{�"L���Lݦ�Z�)�-�&��WϺ���om?�cޓ{}����k�bE���t	^4�W�voO��S˹�Km6�[z�>Q9�l{\߼S�	A��I�5hͅ �$B*�
!�p�z�"�C#�6bظ,E�%vNbX���0,�� |}Ĕ��._�>��5�G�J�x��o�ߖ�>�榮�]�+��+w�AB�Y6�u�%�61�KO8`v�,��,�	8�[=����&tg7���}�0T]B�$�������V��ٳRοtB_�������{V�����@FKP|�h�h�YyP��c�A��t�Q�J>����=��A6H(8U��_a��>�D���8��8�5�m���̛�"7C1�`÷��j��3��u�XHX'��&S�Dz���Y��bЩ!5Oa]���g\f�H�k�_?BBC$|++�0=9Q̶����Sk{R��0��A���d��3R�u��,�7��Erol��	�Ċ̔������ b��|df+Gq���2霋�suV��g�Y
&�
�9`	O�3�<�ay{w����oR��V��剤�ί�����1���f�cvb��`��e׵rt�|8�K�6�"���02đ>�����u���fY�ゼ�TXi�"��GQE7��D���Ma�j���������kR�E9?��	(�Z���M�/H��R�3)B�C�d�J��܊������<��p����z��>BSῦ�(N����)j'=�2xi������a
;����1>�n::�f�TC/��f� "��H�Du&�5
b˂U$�wv�$�0��c�f�
��X��m3�U���$n�_�ߌ�r�%�V��kvm~��x�y��S�8~;�Y޽ƄG�i�&U&��s�w�DS5'.�Z+	�K�J]�3(rf9B���^�Sc�u's��E�u�g7K&A�Ēɩ�I�t�^9����!C������0��خ����L�'L;K;w�W.Y�qB��w��.�Ep��}.m��z ��G�J��x?�&r3���)Y��w��3�×+�Q<��3�'b�Q���۝���>�]ݤ���� ����)�_�C�lX4Ͳk2�%��Ғ*����l^�&kF�z��ufn嶣��س!utp���Iu�Y��Bݸrū���4.��^�tͧ�^�[.��`.��<ZB6�9��a�;��D{��!_�K�mLPM�|Wꚙ#5Ңq�ss2�m����e����_خ&��Q� �<rPy�v/����ݑR��#�<�qC�u'�9Fq�m�-#$$�a�+��f����!&T �_Bq�l� ����s���K��!�+*Ƒ6�q����z�M�BR�4��~���*�uO��_r�Q&7�wݒCY��z��[��}Ojት�e�mkm����ډ�"��p`ޗ�Т]�Ȕ���e�T %�=!�ܚ y�5av޷��'��y7K�.[;�T��uht�z(�"wڀ�CG Drl49��c��6���#�R״c(dJ��v��ìB,��p�;^3!��ú��F��� c�ږ
B��&�`�lQc����إ�L�e��}����Hpr��	�bQ��4a���ɭ�\ݡ$��9���a�|�W�@R�<���E�;\���w��{8"!�)UlRSh���*��*��E0Ƴݮ˓㕽~�\��9j�[�Y1��� �8�	G��N�����Ҧl �Wm���;���.�y �?�4tl��຃�Y�n��Pm~�C܅�ű��6qr�Wٛm������ Q�s��nK�0b�i��U�!fD��=�uW]7[ГM��[�zg�Z��%s�?�~(�ו�"��cH%�/4����{��IyHB��j.<t�o@-'��a���Y��cM����v4�����ל����E\kD���S�Y� C��\��H���8F��R2�m�h�4��p �  �U0�D��{p�&��AH(t.)ܱ���-'�f$G.���iR4>H��/����w��ށ$;5~{]���	��q�����Rq$8���	&G0	���jM.�OmV�J�y΂�I.?�����3�5�h���f��p�:�Ԣh�;xl��qD�t/�Q'p�M�؀�c��Rs����1�i�p5�i91Z���	���R��xoW��
��á;�ů�2�w �?M>F/�3�BpU�F�[ٖ9z��v����Z�K]��Nz7~��[Fpb�k���a�㇧�������;ъ��tƸ��x_��1.��^TkzTI�//5�s�(�xJ�!��w]%4`X|JU�n ���4�����es;AI;w7��Y��.�W�6��qÃ�+{�]9���\�s1�h����} �O�z��!yy��r4DQ��kŤI��I_2x�PxrƝqgƛF�ޯ��ʌ@R!3��
�<��'4]1D��/ds˽���$�u*WbL�V�|E�u7g�"���R���!E����b�b�~P"���!��o���l�^P�u�4����{�Hd_9��L�~���O-��G���������/���H24a�ϸ��yv��2�O��ܴɭ������o>��`��󾯁���x����$�,��r��^�r�T��9D	�8�]���TUj�$2�me*_��`(�`�LD���7�y�o7�����)+�o�L�{'H)#�����\TD�knHV�����b0��ǃ�P����
{�5�'4ٗ������]��r�p�����oZ�4j���eK
R��c�|�-�y���1�����w�������G��� |c���M'q��↑AƬ�W�����J H�2/��p��1�+ -�Rx|r{<�7�V&�݉�RSg�&��4<3�Hb��Kf�pՕUR�7W�EY�'f�Tp=�z?�^��|�TVT�=�RYqeD[��j� R������,���8���p^ΟX��@�8ԗ�	�IrS��WJ�\���&~SPl��:ۛ�t�n����3'�Z���t�U���O�K�]Hf
�m\��?�2�Z���F�?�A �_91�>V��|ܷP^z�H�m��,pő_�H0�\�7ʝ>�b���nX��r�ss.t�Ǌ�V�vQ;��>�X9�~��%,٣�l��Kv�~��p
�R/�LbӀ�c�GCo�+3γ��/� "���CG�L5{,����Z���*�wDY�n��u���j�NJ��6�.�(+�h��r�s&G�J*�\e��r{9{n//�|�:+��-`������ 
1^�{�/]]�b#uT��'a]�s�h^�[��}��9�I��3�� �X8ETL~e.��\�s�CZ���T�ol�={F�a�<�-NA^B�CN)(\���F��fB�+��?�W�ԙ��(oH޳����R/�^���q��*�w�cؐ��t�1�ɔXϗ��;e�^N/��Ql����y�j������������Q}�rd�vE|8�.���О�9Y��I]T>E�.W�m_S#+�ς������L��
�ȍ_����������?�l��Q���*`�������R�͂�z�Np��\��r!_F��?�*�0*�!�g��i޻}P!��l}c�*|sӔ
n�
S��L�1�4����p-fM����E�4�!��r͵h��N�9�i�G��PpB��V��.{�9�k�Z�T]��S��*P� Eu�C��v�˩����(|fy�7����^�__b��lCt/�~�N�എ\���<�z�ӷ9Al_��7hӕ���7Mm�r4^���D03��l@���lτ.c����~�v��Z����,��g��C�e4��=��]��8!�n�'+F������s8�n�pG��s��r�*��y�M�B�%Vȴ?��8ܙm�u�ԫ���6Z�[��6b��滌�ɴ\���&bn�FmC��y���(5P*t���kT	�}�n��p1 ��C?�C���Tm�Z���풱�4�o�Wੁ���[Z���z/�pp
1�,u3>;0�#�'<��1t��ٶ{��ǖG�5T7��Q$���Lgx���{&��L#C̦:�M�9�l.�q,1�]}���M&R`6�Ӳ�2�+ޭ�KΡq�Z��%I�@i�nN��m���9�j����nܤO�9Ds銏�Ѽ�2��┻��Ug�(w��$��znF��w���'�z�ԯǞ���C�����67W�{�e��4�����fťn��Rˎbe�S|8C��δl���d�g�G.ar�uB��e6�ZqB�e*�՜O�qC�����=�Ex<�I���%��mk�b�1G:kTБ��c�^չY�S�9�d�\�%��k����8y�qOg�faL��O!��O�*�a?�a
_u�<$OE�r�/]L`U,�}&�s~{UB��R�Vx�X�ũ�^��{-��Ȏ���9��#��p�Ihl+��(�a��a sb3�Ʉ�W�Ѐ�`�:��όh�z���\�m����;��%�f���3��ʖ���Ńd��}��n25PB�Ub<bR۴�0�H�1i�#Hu��r�#^��|n<bdp�PdJY���� ���#m���p(#X,�SCxݠ�0��7�����{�۟� �߮�A���~���tgz6�S(�Q�a
:'ư36Wh�Nq�ҹ����� ��#\��[|Ѥ�����#��6�Ϝ� ��2��n�Q�%paIH�EI� ��>�I���c)����h��ە���@`��X�߅���gl�3I�zNg����3�`!#�mwq��v����Ew��S��
^�U��E�WU�B�̵������%Vb      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �             x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �      	      x������ � �      
      x������ � �            x������ � �            x��]o�H�(���|�V�ZIև�o!����H%)ڕF�Ͳ�eKٲ�5�o5=��X��~h��wf��������>��؞�8RT��e�ջUJ3ΉqN|�8�U�Vk��Q��?sd�l�x���uL��m��x�/��?Eޟ?%�w��2.˞�}�u-ǎB~c�/U.�q=�L|�������%�<d����5Ր�7a�&DnZ���rnŁO=��eVr��2�K���'��'�����p��"������Z�0~��=�l��8!��S]&�5-�UL�D�
��R��6��
>^��3����ʌ�i@!_0��bL"������ҭ�!&|�XejuM�)�v�X63N��$Q�?��CH)�z)�dmp����$ �8o�"nGnǔ���u��B��e ����$�&���#h @���dgqE���%{6�ڼ��!� 礔���u�Gmل��pha7r�O|(�d7"|y?"����n"�2�����aޘ#��po��\�J��X��u�}BT��D��񦲯A�XmP�c6b^&��*↔nm�Yw:����^�}�Z��X�^�Y�^�zDh)]{� ���q����i=���ǆl��C���(TʵqD�jMyw'Uuo��� ��K[�#�ƙL�L(���ޤ� �z�z8gd�0�`{���/�|���{�"�H^�J#oKֽ�e�.��{�A=q��5=jN�����.'M��ؤ�-]�>l�~�r����@��� ��!�fv���g����l'�AqC��܎��cV}e0{�e�����;0�qmgĺfω�N�
ԟ?!��OD/5f�/q�g�E���6��2���`b���O�`������Y�mp�\�7�47C؉�|�O$��l�d�&�y��p�{�ش{�ݵ���3q@�����=E�2=]mʬ���c�՝5DnZ��7sn�e�ǎ;�i�0��!a�i5,���c�Ѻ�7Y��Æ�ɶe��2{���� ���gs�p��4@����>��s��tA7�	e�����%C�	�+<��w]ejPbZ����ͺfx,�����}c����uF�9aI_� ���5���L��"�K]�U�e����!¦�e��^��iv>0�ۃ�:�Г�a/ł��j:�B�I�b�069�o������#o����G�ӂ�(���sJ�*I��,�Jh����
m��k%�AiA$3��"�mW��U�2[:����s������V�H*3N�+ho=��_��bM�r�8V?���|b�CJH� ]�h?����?i�2�G�9�qMv�,�V?�`29�R�,�� ��Ɖ�:r�ī2(�
����m�N6��q��t7�9)%׍mޏ��T�I� �'�P�bG�J.�唸T8�7m4��q����1O-�l���MKV-]+nP��V����!�_(���9߬Ku~�V?y0{�W�!D8h:��Z`Q�+H�u�,�H�!Q�G���7(ǯX�W�W>�����'2��8�t���h�,nҐu��Ֆ��K��MU�"���'�jf[W��-݄Y8	��� Cw#��`�m@�#�y*�fq��3����L�����$��<(��1��8Y%��Z̙X#�5`lR�q�m<�-��F���$'��C�3��&DnZ���p$��tc�2���G$�3�5롵�U=ǭ�^��k��պQ��o�gt�Ļސ���{ee��P�q���봤�A7�0�T�r��6�k���+�2��$W�vf��U� ߬��Jk���OF~WSk��OE"և���Ҁp�.w�)}.Ajd��:@W* W���-*}�1;�L6/ ]���������L���њLX��i�ZPڝ�D����j�,>�����hO�W�"��aɨ�� Ļ�<e��e��z��Zf�,�?RyI���q}��`3ϙ�+c��������+��OH��	I�%�L/^��q����[���%W(�����BA�8Z.Gq���0�U�?)��Ē���w�z1e^ޅʞ�����C�!��k<��L���y�A�U(-Ji��P*^��r��$ W�S����&��t3�QJ~��eh�C\gM�q$hAKT|Q���)�|������Z/�IaK�2i7a�[R�����-����P�6���h?v�	$m�<���1��~����v*9��n�:����cs��Rr�����:*�L(��qj͹�Dg��=ߥ����Nr�8#��ƈ�O�J��t�#�<7Z#�VU��A��\��ՏV�N���[M�'��Mϙ�L(-j�j�L�C����Wl��k�I�q��'*�H[�w-뺲��o0tF��I�ϢRTz��bq�B,�(�0!��iSH]1Zy�f�up��z�C"���'�Z����Bʩ��[d��Lی�l�P*�m���O�I�2��sƔ����Ab�Q�ٶV�jS�_�p��$(�C���$V��=�VcK��h���!e��#���ӆ0=-�j3�z_�W�P�O��۩$3m�ܦe�	뽲��uLj2Hj��&�	�PX�{�����&�g���m^H��i�6:r������G������8�S��5�81@�m$�h�����GzN���@��x$e�j/�M�GQ�=��鮓�{Gq��Ew@��(�2rX�{�/ֵ�c��x��ĵz�)�!r�R��:^56��4c�t�#��B�[�6�B��:��2��OU�ZdWA��1&Έ����-:4�ྟ?qo>��	v-3�l4�u�Nh������,NRCvg���>��JG�z)3���$�4��Kzk'� Z:��Z�!�M�!�k�ܴ�$7�)�7��͞�$��ۘh׏�	
��?�~��Ժ�?z���?:�ݵ�fҾ��4cbў�5DnZ�ڥUϞ����b�=p�^�a��s�R�\�����s�A�%��rh�չa"�z��ݜ{j���=�ؾ�=�}T�|���:��ӳ�s��3��܃�T���=�V���<ݹqQ��{�]�/�܃��^ι>��b�=��煝{��_�^;�����7}��i��܃���s����{��؋:� n��ǹ�+>۹�RG��܃�`��=C�~�=����=��W�s�!�y���{3��q�Ah�8� �H�������C��s�Al/�	z�s��8� L�/��?�I� ��	�
�W?ƈ��Re�_MCݷ�N�G�t�Cw���uD���u�֟8�N?���s�9��Ґ�Yw@���2��8�aB1Tv�n�"}R[8���~�x�~�AEܴ�H��+6�P~'[�V�Ib��֜�v���i8'%qե�A��+��)�'U;U>Bڍ��U��Z̞X}-�8a���S�/l�I�*��ł�QW{R�JG���!z����j������v�q��N�E���䯽/�J�Sذ��+@j��!#~�W�=���q? ����CF���%Ո�v�l���JU�Uv��jb� �����#%�ڳ��xG�.˄rPIn�[����%��!���'�����u����ɒP*��h�h�ڷ��7�Q�r�����h)���W*�Zj.Bb��(�0uLw��[�R`.:�Q�)M?�T�
⢭(�7u���~Z��yȈ����:}Ǚx�B��ϔ39�hk��k!�F���̉����E�z��Br�/N���0�,�	`+q��U2Nv`$�Y�V2Rk�D���n�{��>N �l�=2��mgw��"��f�HG���>��0�~��|��̮U�j�F�zFd�NB9����|j��t|׷{V&������v�t�F�W,�A%�i�Z�6��Q�y�T��v*⦽��T iB�dB9�$7��P#% �}�V?dB9������"�e�83ݞ� ��)��Ē�V���c�6��*�W��\[�-�dҖ5Yg���Ѻ�G�h0J�2�"�UTt���֐:���⤲�m�%�����-��S[+Zq��e$ڿL�S#w��R���B&�p���WƩ	���OW;���S�VmI��
<^��RR&�����j{�U]0�53�[(�m�V]�ӵsN�2�P �A�R�Q�~��;����e��F���    uP?̾l�X�+=v�5@l�BDR��O��v<1T�[(䲆V?���ѳl�M����#)��ubuRA���l0���uu�0�GS��L�2d����"䒿���:-��}�6�����NZ�C���ϟ���G٠$����6a��L��L�"�3���a|fy��s�v0��0�鈡�v����"�7�o��d�4�<�cv����l�{����:MxR�O9�Mws�!�Ɖ�<C�p�p/J���z���4d���H���i��I�S���n�X�|l$�6�h�;b����f;�d�� �NU��|Y/}����{W�M�i�]R�z���?�2�TtpD���d5�T v�Ɉ�6u�"�W_��'���N$yi�������Qby�xC@L��?ĩ�!.�k�� �vH�Ʃ�ZF��s�ю=��)���\�	堢S����Z<��y8ũ�����C2@�	d?���pNJ�Uk`8$Ӂ�`�#��BC���4r�EŮ��PЎn�j0YčX��0Ӷ���1��p��&��L#L�- 2ň�"{�x)E�zA�VLO���0F�%�|��{��`��}7�h�����t�P��h��Rt��O�+��$�������*kO�}u�j+-�k�U�����9T�,`+��}ҪQ�O�A?�X��T!z�`�CwB:����Pe����2���2�K�*uڀ�}��"|��)M�M�kbh��?@�)B::�ex({���1���V?�`2:����G4��Aڞ����R2�Z'�n�m�:�K7�&�oNbb�}̌�#�eN�{q�v0�ď@��3��� b����O,yk�]��j��� ��'⹍�xi;�&`H�'��qm�AF�����R���e�t�J[vOe�`�#���4����j�����V)?Z8��%&���;������梓�V�}G�_Y��AEܴyK�^�oFBp���GHGg���64&Ec�{���P����z�a7����qz=�b��IIg��o��4p��7v_ӎ�����$&?1�֦����(�sn�+ZO yh��M�~�ld����-��i;��ռ&MAmh�~�{��ҖM<m܍���BA\��O���5D[�m����
�Ǎ����Bʩ��6���xIIuo� .:+u��sg����τrPIn�9_�4qYŅ���"� \�X�0R�2�$-�T��}�«bD^R���rګ����l����v�&iG��Wf ���<d�O�G��d[ԁ*N���բ��َ{�O�K�2�3�x �E[H]�|��2�T�M�B�	�Iq/^���(���H#a�R	v�Bտ��H��l8\�b�"Y��u$/�'ý����Fo��cv�8s0�K��
yI�����q�1����L(��}�I�㘍}f�gN�����OXi��N��I�k3-�'Ǣ�~��,2�<���:[dE��ꏱ�'V:⡫�-RVO��5�G46�9)��6/Ie[�.�\;�E'9j5���cg����x~R1T�#��&�J�z���[ȢA�4�����7�Mw��[;�6t�k���秖ܵ��9{���5T�
�Oc<����?	�"n��K6>�W4������j�a6�z�G�rPInڃ"-RţC_�!1�?��"��_�DI��{#�,ܽjo�֪�7��ȟo;Y��UTRn�٢{����75�y��|�
=G�V�E�@R���ysY���~��14��a�@��tYxr��X�H)Y�&�{�WTC7�u�{��'�o��p��h"y�Z��~_i�	`+M��H;�������ULt�=�����R ��#�h#F�Muf_�/�(�:N#-vH��Go����h��#��w�X���$��'��`)�v�DSy��UO@q�JE�t�1�@}����<@�����(�H�c}>�XQ��I�T�I)�K;�Ѧ�s��Y؍���GNt#�#�����D$e�n�::�+�ȏig��PH.G���#��/��c�=fۉ$/��2�7��c������?o*���-<o*N�<�����~�7�^�����s=o*6�?���/�yS���e=o*6T?���?o*�?��b�Ԍ��yS�����7�F��yS�kT���<o*�:���Mž��z�TlZ�e>o*L��R<���3?o*��/�ySa�{��M��k_ϛr�/�yS.�?o�y<��� ��yS��ɟ7�\��ySa~��M�M��7�|^��¶�K|�Tع�գ�y�T����cL�]7�I�"��Y�S�g�9���m��AEܴ.UYj|(1����϶:�%ƺlW�SwF��nB��<d�O�a����ewX���s�Ѹ��HmI+.�$��Jr�6�vl�;ë>�^t��x��k�ߐ�WБ�ϟ��1�N�h�"m����E��}�/җ� '�ڡ���E��|����z��t�{�5Qqj�IЦ�.-�8�f�y,	�"U@�a��	TY<k
����X��+H§tXR�m���#�e6�-=|�/?#��軓xHb��7����c�#㺟���m�7Ր��{��i��������� �����b/�/��pa����b1�o��p��g/���/��p������kM�!��#��C�%�X�P��������7���cjՌW:�9_�JM'3g��S� TT3���_�xW�o�Sn��E o���:��_�%�g�
�&��~Bu����ѹ����|O���Ě��FU����(����~�[�8��>.�)�G�ume|m1<�^��|w��#�eF�׸c9�$g��"9����B�y�v�%A]��8�<��g�c�zt���d���L~��~,��J\&C�ǲ�6�}}p�� ��@�/��E�L��<J1���;�o���;dƻ��F�J���Cf��t�'ͮ�Cv���/pmx�K��|�5(;�;(W���{��(���a2./6z�;��w,�.s�w�-���q��D[�jr��qx^�\L~���.���I�oi�o�1��>�m-O�;�%*Z����3F�5'�]J��W1>�X\=S��N�����%�����!�u-OH��-ﴢ����B($6��|�I!�M���1��q��9��q�	�Mr=:�<o��B�^MCߵ��o�y4{��ѽ��c֜�n���1쫇�(_����)���7��L�g���]G�G��+���Qޭ�Y�:7�3A0�g=実����to���,�Eb��/���3���J?��	N(��� *T&<;�}��������/�j���$Q(�"�y��K��ӝ c�K%��OĚ�_�j����1�)��D�����Lq�gA�)�-����yo��O�0]��2X*v>&ŧ+��.�Ӂ�eo0d��Y���a��F�W�zn�kՃz5S�|�!f娳��7� �*�'�d����XS/�Ƭd6S�kM�[���f�x�"����ڝ`:,�to�+��噯�Xz�ծ�����2_q��c��_����O�`?�+�z_�+�|?�+>��|�x.�g�\�+���W���8��c���<����|9�+.�������W��s��8×b�����|Ņ؏���ޟ���ߟ���ߣ�����W͗a�j��|�ܗ���[�O�8�L��O�Usv�fy�9���-W��\5�m�j��r�ύW՗������/o�Uu��/e�Uu�����xU��ƫ��6^U�������Ϲ�����ϻ���6^U��U�em��>�ƫ�~6^U�{�U�%m�����W��m���w�Uu��P�y	�ھ�5��j�0&���S՝�)t3�^�,�z��+��jv��ӔSۧ)��?SN�řrj�o�I�h�ݔS�a��j=-jʩ�ӔS{����ޔ���6[�(i��ޯV�Տj�wӘ���9���sj/ŞS۷=��?{Nm������9�}�sj�iϩ=�=��������sj/˞S{~{N�e�sj�kϩ�ǞS{n{N�%�sj/��S۟=��_{Nm���=�D��7������h jt�I�c�]g��K�0��g��׹�_�>���0���mXk?�>(���x�޳    �L̀̚X��d8T)p�@��T�>�ǃ�m��0�v�ޟ!���y��7��m�k�cOV{�����4�_�A��?�Z�����6���gPk�Ӡ�ޟA��o�Z�9j��4���Ӡ�~^�Z�e��{1���)�K2׸�ޏq��dƽ��ȗc�k��x@�����7�*ԒR�%����k��V���rP"^)\��v0���ᤄ�Q(�`-�k�^>��5kx�o{Vr�'�Z��v�&%R�M[�`���M�3|A�z��lP�՚�*���أ�����J�^�Y�ھ�J��uV��߳��}�����d�	�J�F����-e�\�蒟��dm�'$k{9!���r`{�ˁ��.��;��u�lM�C �uM1SeL�C�-�h��b�����$8��H �qY�;+D�7,�M|���1��r��x�F�1��1�
�\�r	pi�\���_Aʟ��@�{�CjSi}+BEm��,��z��E�oѝ�е������W�,ᙙ�y��U��t�a�;�v*��|-�w���dV5�2]�PeU|+k�4�Zjf�ki�-C�#�-_d�o1��ӪPfeN!ª�wWD�-J]��U��P�T:ʫ�B-?SѓN�������@I�/{�ҧ�B�����T�$"�
�k�*Hnq�"�
&UBJ��:E�*����i�a�D�X�P�Z�5z�`#�/�m����-��~�7s��v܉yŔR��$.�ң8� ���4��m?�bc_��g�73�����u��K	?Y�u�x˺tz��l7����1�v
� c�ʵHWP��ܺ���� �bm���u6���
�#dݸ�j��RxjM\�+��Dٸ2� �,{�amс#S��Y�c�Ӄ���l�K������j�B6�I �~�S��1�#:�M��f�ЬO�S3�̉w96�}�n�A��R�u���7��s�r�y�u��QY�Y*�eH+נ���Q�I�]-O�@���hm�ц�HEӬc'!��Z�N�ig�q�HYD��K�	 �8̻�,��1Ân�;	��ح.y�/� �"4� �&J����}|q5��(/��� d ���%�G��F�r �u�r�ļnq&Cs>Q4��$�e����P4?��%_�����«;WNR��qk�۳���Te�����;�# �^T<�({�����MoFs���f[i$'��p���S�v��Pn�C%�m|�^D#3���qg��rP7m&�k�ͬ~��B���6��Fr��ܼ�$%>e�TyA>�$���5��P^9nO�g\�C�#��u%X=������0c�0���E[}��JOzT�G���'�uM�*vca$��ao(_�pNJ�Z�q����I�ᮇ�Ga'f���V�\������OY:�$V2:j��!#~�W��ւ��� h�c�!���u��z�F�q���S.J*U=Wٱ2��(	@��<Q>R�늫�����,�A%�յ-���M�[i����6d��̅�L(������&�otm��V����d�_S�4e�@�V�q�Mu��������1�t�^6��Nr�jUUR�:~<d��-�E[QHoZ[�Z��yȈ�����t❫KbOYs�E'9��]K�r���̉��ٗ	��O_X�!�!9�9M��;�⤭�G$>�]3�J#9i�D�f�g��~®���D#-41�kBny�?�YHN�*�c��kU��h����~��|�ϚV���>2�g��L(qӕO������v�ʄrP7]ۮ�Ո���	堒ܴ�J�&�J��:m��Ы�������T�T�.���v&��Jr�*
5R��~�C&����ik	)r]�q�3��
Z���O,yk��a\>�������TЫ�fzQK�rI&mY7d)��x��t���F�:�$����I�����m�!u�;`=�Ie�% �6ޤ���5����KS[+Zq.L�F�K���N���J�Zz���9]���qj�`i��Վ{~���U���B�j�0�0]g��O�A%�iu�٪.���-��֔U;��uN�r�9]��BHmJIGٰ�B�/9 ���c�H?��h�����u��*���������՟z5��xb���PD\�Z��N�G�¥�&h	� )��ubuRA䡯l0��UV�t�z}��9��)�*B.����e���&3��ꡂ_����ߤ�ȒAI.m5#m�>^�����x�1��U8��x��M�u�V�b���<t��P�P��훎۷���B�]�4�<�cv����l�{�������u6��h�.rJ۱.mY7N����a>�S24'�d��֛�Lwt����2��!��`��� �Y������fP��d����f;�d�ԍ����$QR��g�Rp����S���I:m�K�Y����b�$��Jr��ku2YEM#���v2�M][�a�);|��P��D�W[[�d'�r�"&T�'f�t��
C�ѶCR6N-��0*���Nr�*&����x/\�A%�����a-��hݩ�����C2@�����l�sRJ�Z�!�Ġ� ����]���[��Nuo��\���!Y�6j��C�i[>�0�1�*�r{� �Q��|��SdO/�H[/2�LO���0F�%�|��"������'�����t�P��h�F�a��l#�|�+8���*kO�}u�j+-�벰Q�X�s��Y�Vɩ��$�N�~�?�.,uw�:�=I��J ���9��2��̑�1v����_*T0�V�]�����DLi�n�]CSU�JL��I�u-�Cٳ��// ��1�I~��޿ш#����� mO�O)�j���������㻴0�(DL�u�C��#֥�Ȫ{q�v0�ď@��3��� b����O,yk�F��@8��_�D<�/m�Cӄ�� ��qm�AF�����R���e����\�h�Y�NTSO�I)�jͦ�v�E��u�%�e����6W��j��d���$G���A�����W������i�f#��ę���1��P���M��01Z#g�S.}H�Q�?}�����vɬ�MZۆ�z���8'eĵ�]o��l�\�L��ob�OIL~b�M1Yu�Q��r���@���{�4/��Ȋ'� �~��<d�OW�47��Y��-��v�ؤ�m������P]�m��
�5D#�m�.�M�6�p?n���|lRN휳Ib��k=�{qљ��4�:c6���L(�䦝�5IE�}�x�'�s=�bk-�X4��D�e4I}�<~��!F�%%�� ���o�Y�V�Ik�l��b[}E�H���?mA�G���u��_rК%��َ{�O�k�2�d_<ɢ�?�.�N��"n�Z��.#�o@񸉈�ޢÑ��8��(&)�V#k��E���8���Hmyɋ��8�po� .M-��;M��~��@^R�m{�5
����P*��X�?�I�㘍}f�gN�q���OXi��N�~I�k3-�'5W��/]ı��:[d���ꏱ�'V:⡫�-RVO��5�lR7�pNJ��KRY�֤�,��s�I�Z�E���iǄ�,1�5�Vj9��X�G݀܃�@"�Ъ�-�}ӝ8xw�C���O
� ��5ݵ�0�k6!����BA\�i�矾�'�T�M[y����,�� ��HNZ]�Ng0�_=]�@9�$7�	���L5�1��}���IE!'��&J
7�,�Vjo���7��[�?��F�����Z5�uD�7��,؀��#�*���XkB�W8���H��ǲ5y�8�����n�R1�� ���k��*U
��À+t7e��#�H��)qf��ֵ9DV�T�M�B�֙��93խV ��[Zb���U٥x�H9F��'�?]�Ӧ��²;�snf���$G�٦��w����P*�M��Ӧeh����h��
zi�'�1�m>��	ip��4>J��*��;gVb���#&a�(BN�ua�ֹ�W������H>ڥ�6�y�8�k�S�/9h7C�����95��Z�A%�i���iμ�R9^A>��J���/�uL��b��eh\-oy���C�^N+�^�    Y���&������k���h;�a�10�&�Qp���3������w��}�i���Gx��&iU뇍Cz3��ʖ�㸚��ӎ`��Le$�`�暣��	U�;�+��8�X���g9]G��c��'����_PD@��>w<�Hf�*/�Ee4�ܽŚZй��4�@q^b:֜@����<��4At�{��K'3;������
���|c+�giǼ2(>��1�Q�%?���ŷ�����6�]m �����J�.�W�qpА1����5��o�IO����bC�/��eP̵�S��V"�e8W�O8�^l&=>�	*��D
�|��;|�&��~^C񿘀(�4�Nb��b3��g����BE^.�����=o$�/����LzHDy)}(�e��3_�~NcQ@A�K]~�p<@H���%X^�(�0mRu/��@@U�/߇������g�l��sA���+�/LT�	6�4�ȹ� ue�Q�F����^�s�U�;�����O�$�o���-)��_��s����o�,-՘U��]������~c�gع��|h{�aeR�9�K� ˋ߇h�-�k�B�/A]2��	^�b�|�O��p��n�p����F��2S>��	��~$P>���fz;}��O�O�9��)0�7�p���1��5��)U<Ђ��4\,Bڛ1B5�v>��̌qx��"�����?�D���yS��1f�He��s���1_�ϻ��eh��t�s��>����E
��:���DWV��m����7��sh�-���1�3��ܘ�uJ�=�o���EBj��!����|1ņ�O����.��z�c4��m����h=�jB�L7v��<AA,��9w��K�^~���(}BH�~���|zO龜D����!�"�i�A��H��kNLi͊���Ud鴼f���C���������~���R�[����0�#Di�Nś����qw��Eo���.[�6�~/M��A�o�5o�!�9B���s�^�1�kt�
ݚg�L�W���T�E��Z.$*v)�����*QAUZw/"�2J�L��^�R=�����w;��rw���c�{��a�S�9�f2���Ax΂40{>�� &��J	`
<�]!�B���E�K��ۣ:g��Y����^E�bIz"N	�ɕ������B�^���|^)5�+A�0���0�^��z�� ��Hw�@��e#�{���mr��ƁU=�I�c
0ֻ;�і�tτ[t^3��:��C���F4nů|Ax�.nЈ��[u�_�*�5��P��St��9��&|0݉�yrS�rq�nT�qp���'	!�A��5��ɟ�B����3��a��]N߅h���Caqf2���M��a�����R ��0��� b�� �H%|���Yż�!�}p5_vg"1�g�����ƈ��/�Ht(Z"��'��}|�r���ZF.�W7�Gf��ɋ"���V���{;��W:�ne�\|w�kU7�^´D�Y=�.ޗ���F*`a2{�����ݚ���Eʈ6�C�6�.6���.�0��Vb�@����?�_n�I�����I���%�jط����P��X���a��?���%t��y�j%��̤{�[ ]�;���ESZ�i�2҅�=�|����i�Hs��H�-�X�Eҟ��\�J�����8犨|uyU���~7��n-����h��W�$��t#̸<Q-����O�{��*����d�]����_4�)��c��.>�=7�1��t�d�D+fp�`L�w8��N��ppXzn#p.�̈́�&r(�Q�I9xх��=��ʧm��9��Z��z�N.2	��"R�n�'&����P�x�8�^26���s���8�_�4��%? &|E%����;B��pR��9�
��`3����z܇�A�[*��MC�ɏ�����ATI��$�`3��S����O�et5�}p�,��ܔ�xI9���~�*_�Ρ�~�G���b��)t�A�e@��\8�{p���Ax�Yŕ��b�}���͎0��[%ı��\8މhT��+�������/�'?�2}���%���s�^zqf�D��wT�_�C� *�h:�qk�p�a:�&�=��T,oAc��{��ԫ �+�c�Mg����Ϸ��5.�"1�?�� �˔k�I��-�5WTX�_y_����#ԓН.�W��ž��y�����U+��A��w�B�K��.�3V90F��C�rO��Wx�bwT4�D��м;��ǁ���)�<%i8ά���9r�+�*�+��񿂇0�z���B�Ͼnd�=��Z?{��"*�}P�`����3�F��g��}�%�g ���8Xc�/;f��>\�ZK(����@��sh�|/�ح�����<��<�W:0����@t��i�^�-z���_�!$�@2�Ȏ�l�߽�|�ٌ�7�ƻDB�Nĵ! ����f��C���#�4��:iϐ���&��,gV�;M��3]bɞ4]j�)�W�-�D�������D���?�X��R��z�%�όn��T�3��.���yp{;����rl�|H�؃mn��%��E$\�1�|/p��Ov��g�=\d������,�A+��<$,�����)-�Ũr�{Ƀ�OH�꿫�������y�oNc���C"�K{^��޽�~��5L�X�)ᇲǱ��i�0}h���|THt��^�ͮ�E��n�nq�ٺc�U�5O��Ǩ�7�4��e=�����c��a�M�f#����cu�G��Y���b���z�Ę9f�t��F*u�/��s?�*_�}�އ��2�}T'X�eU����`��%��/���cF�4�u��w�%�nqs����Dr����i�"�SG1[s��2�N�{�+�
�b�h��<�D�g#�`;~�} �P�qf��v�k��IG�I�d�أbV]��o��(��?W>^c,|��2H9WZ<L�b,��).E�+qnx�J����'4�a:�"b�����*r��u�ē�ܖ)o̟��̯Dh��\a��S���D6�vB���B��˧��˷A��(zD?S?B^ppE"��g.��~]Y�W� h��	&?������6\��L�	yb&M��i�����Jg~?��n.>����S��z�udx����n��+�r��Ǝś%���[�2F��9�GԇN��C5*I��S!���\|x}+����6�����уXf׷��M)��M��1]j��l��/���
����xy�V�ʧr ��,plR���#G��O�<��Q�i�Ng<!"QN�7��A�)/�0�ˁd7��oû���q�����h�%e�p�A��Vb̜��
���*g�?�-R���!��e%V�gҨ�	w�;����#���#�o�)ߥ�V C�[�DBY> �b9��ji6���2
�p`z+"	?D���`����B;Н�����
�����|����Vܙ@~oɏP�dǕi�N�N�z��~��;6>DE��*C���W����&��ڨ��ߤ�
3��bQ�����F��6��y�)_	&���7��ϒo;������K���p�Yq����"<$��-����*/�T����A^N�������ҝ���\�&�r5��ކW�#�� 
�:^ Ӣ�Ѓ*d���m:ƕO�9�p���I�r��Ss^Ip����*0xE��|+=GJ4%Sp����c�~.�d�A�e0ޟ+�K�2`��~�z���;D��J��V�s܁��i�ͮ���&�XY��*�po��&4���@z��&	)��L������.q�fU
_>�N!��wJ.)��k��8�$<7���D�<�i�w���������N��'ԅ���E��㝘@5�ٺ{��e_(�K	{�J����(ܗ�z�O�ו��bz�p�����}!T>;x��DoKT���^́7e�yc^���2^Gq��Ft���`U�p�K*�'.�g��ϥ7��w��=}n��Ьn>�O) L�6�?    �_�GP�����.��D���{�).Mot��QC\�Xfk��.Q���8���ks�.�Ӭ��sq/����*����Ҏy%(>��bcJ~r�q?��&|��u������<c:�W�z��{�~��(�cDX^
w"����hݳ|�A͞^.�"(���_&:A��V#�e�畻8�$��a�$��q�U`ds|L�;���yH�[5�$\T�'��s�.St� n�s#b�.��Hz_��G���|���L!-��~�"�@�7P�p�!���U]b�h4���ױw�,��~���69�m(LJz�`6o�,��Q+}-\S�-�(ɓ�])��i�*����͸x����-���5y�)��ҙ�)��!֊pƕ�5�i���3�3+FcB�!��("lf��U��yԑ�_�(����Y<������1�c��ң��d�~&�pC���F�A�9#Ÿ�Y�T�y%�yp-dHS����7&������2T>���W��"W?_F%���(�w�w^ϱ?��0��p��N����u���;K�C� ~?��Q�)@,F�����	���CL�*���H$o��C}8��F$�z^=�|�ꇫ�FB�!�[#Tb�b�b�x��x��R�x^�'�ʗ��$���'N�SP�3I�5�����1��X>���y�t����r+�R�퇉<����L������u�	�<����ڴ���a��`�#%��>��I�k/���#͝���`>�6N�ϣ\�;��;��κ�raq�R(@cIF�˧kT��B�*�uq���&4Լ�S��M�} �H�h~���爐�S�.4
��e�{������d<��t���ྤ�A������p'�x�(n�"\�DX��5��fx]b���T)���,�9�L)���*�|�̊��-��b�����P��<�����J}s*��E>��G���a�
�����+��?ts�_�N�p{�:�S�`���G�?���M��'w��ߡ��3ù�?l��AP��p]ɹ��]���'y9W.2Tύ�_�e�i9����%� !�s.(c�[��L��'�сEL�~{KT��eV^����� �W�
T� �Q�>|�Gl���C�D�JC�V�c(�b3�A�c�U���zf�u�_�{uÑ9�3�|�Do247�<�U^��Fج/�ye#f,���;���8�����|	U�:8�W��M|����ꁕP�p�����@�(
��7�_�)-��U9�.�oq�{���
�B,�!�t���En��#D_>Ev�s�t�� �
��{:|���]\7Y��-L�?�4|/�Q�%���~y�=]��~���LQ\���G���~���Ӎ�d��|A"��\J10�b:yz��'X�D�3ҁ���`�"������]>c|�&اx�e��ſ|�C,�/�pt�D�j�t*��8�ꇉN0����5�W!�.9���=�t	��I?��.������p��	0����p��w���w",����w<<o�U^�7�n��.��R��h�=���Uw�ށf�V��#���Ӟ�N�ۉ��	��RḒ��})����J�w(�S�h�K��t:�W�J�'̢Z��tp&�,�BK� ���#�ity��U>�Ve8/o�,�Cry螻��PI/Lx�L�0���*��� ēH����2��0�L|��ИT�h' �徢X9��
,�8&�fGq��T���A�w*ܡĈ׃��Ff�g���ϠE�[4�Pi�Ffe4�3�s�s�34t=I�D!�H�3M�n|ˉ"N�ݩd�G���DMs,���`#@d�5��=��Jt�:�Gb8�v���_f���Ŵ�ʹI��1�y���&����~!�#4mG��u�hW�&3f+�[s+�@��
���:�����k�GыG����@�'����/C�*���.��>BVF���
Z̃��D@��6���МDX��6�zyI�|V����xm�#LbVM!�8�ٚ=~b�����e�T�Ε���_�_��D�Tі��h�����^�)/j�"㍖#��P��AM����N�v���:{fL�G1%�� ��u�g��&�Y�t=�R�$�)�5��Y��1��:(��PŢj�QτD��=�4����+�WΪծVj�h�wo�á�㔍:Nf�ܸ��xl9o=���@��2��~myǨ���<)�#�ޖ��i����v��)(<�cU:WQ�kuܦ��м�s��<��<|MXd�HV�'FB�t�na��U,�p1�ϊ9��M�?.�c#�i��ih@�|Z��)�U/j}�p$(��]X��:��.4���UX�y��ƙ����;�� ���U����km�f<
doF�6,�3���=;�H=i>yS�_k@�gxL�`ߊ��������r��=qِ��֩�M�5�~gh����I�+�	��I��iT�����2.�2������`d2I�S���I:��W��Lp�CONZ)ѤW�t{�%j��`�m�����n�H��1,.\c���,�X$�I�s~��CF�(��WT�q�]px>�:g����0�\�%HN��~�JW��0,ha�����R��O�#_��~�k9��+�u`�1-�E��z=����9y�Z��f�����0/�gc���A#�E�2oU_ï���j>���S���j��i-�/�/E6�<��N��H�/Ue	��vO�����hH/�8u���c�B3|l4�R�����҆���n����}O���J�K�)8��WU���(�0@3H�/{�L&b�~\�7�����4,_t�Ǐ�{����g��:v���..ؙ5����[���t��"�g�QU��+h����Mp|��.5b��0��l|f!z�k�̑s�	�ٱR���ك�,��54��K�s�̄w�m����1��1�����_ի�:/<���Ꮞvq���&�p���4w��w�.����k��b�����SׁZ����Gb\�����w�m�s�wD~碌sч_��8���|�����t��+�M<��f\T�z����^�(v�݁8�6aJ%j����q?�xv4*�p�W���¬=JS� d�~�pqَ*��V����.�1�T�Z.)v�ҳw��Z}�e�產�||,q2F�+l����Uq�{j>Ӿ��� �xn�ø�aؼ߮�z�+�^:�292��,,z���q���%k�Q�x��⓻��k�Z��'AZ&h��͙�'8]��Ϝ@<4Hɸo�����*?3�n�+~C̎ �?8eC����p�t�΍nĉ��v~�����|7;��^W8 ^�w�-���Y0[��_f�l�\/\��3~�+V���"�w>?�-�W��	b�m�W���>ͣ�c�"�^e\�2�Q"�;���b�Bd�D��+�v����|D)�&�	��6�f�%�� ��}�#��yڇ_aŮ	���2���|n��A���`�_q!������4r�t�gxJk"��MY�O�Wxb�la��r}���G#_��T�D���Zb?�x������U0O��d�LU��^�܎�j�I��՛Ѹ2��BZ�I����a����ܾ�N4�q��F=v�W��W�Vj\�q�=Lp�;v�k�@����Q��E��U|������9��}�����{����� !�������߷�7����Q�<�8����[�.^�s  X�&��'��&�ML�8s���Jk4t��*'^aSM���N��l8Tٳ��
�ߋ�<jV�0�Yn�ˆL������+�a�y�Q"�nz���s�S�GT"���Rq��©8�A���.���`$�%��%=���-���O�`c�h����mF�}V���3�<�W�v��V�$1g�P�!�1Am�ѱP*ހr��x*�q�Xj���/$�C���偺p3���{�op~�{`��J�	x��)���[�ze<}���YA�5�2K���&�1���{�V��9�+��8�%�p�8��^9�U̇���^g^ı����r�rY�����    �	�œQ��������ZWt�僓�."��}������7�&����3��B7����V���`���'c�\�T�Rx͹�ω��u����2�/_��br����Y6����K�,�TR�Ղa����Oxa�/�x������}���g����hd�98�����b���'Cd#3��N��+3P���n�W��6ꕓ�o��?��槔s���+��G��Zʍ�@���c"AOÇ��7�~����ЬVN��2��q�}
j����a/V�ME.��[��x� �ײmRJJ�'�-��2h
�pm/�m{G���8����|:~�]L�#F��J�/|���<��Tჸ��iJ0y#�"��O�k�=ϸ�	���g\�*��]:�Zѽ�0�}I~8��oӅY����%&*B>4�`���NN*lR�4��o�o�ᴠG��?C�㣑-_���H�jU����l�_��/@��g��H�{����BԲ��&ņ������ax ��[<��s���ۂ�� �F��=e�U��l����|�#��3*ׅ?3�W��MМ)�A4�eND��!M��u�۸�{�����6��od����3}<_A�Z�(xWf"TX�#h�7�5�߁T����6@��l��ǽcfu\6���N#�GѬ�]�q��M��r���G�"[�)���ju������:!�x��T�\���yXmlx(.��]�A����q^��sn����Q�S�[���E�[�N��D�㮇�:�tu�Η���N��̡���ѧ��?�r)�����ҿ�\FB演���_xc�a���<�w�mP�峉9B�

���&&�^ԟ��D���c��-ؗG�b/_��qX?�� ����|Q"	���+~O�����N� �t�	�
O�AiOr�-���w���e2��M�nϱٰ�,�����I����ۨxWت�/�/�@��Î������˗�kZC<�`x04����3P�N�@o�(�_f��y'���eۨ�}�α{��x�zt,q����5�ш_N���17��������D"���efdH�oK��zv�8���� &�y���gb�O��T;|�Û��u=ԗ�K�nJ�V��Yb��ݪ����F��W$���[������.������M&��╤uT��o5\v*��CIҼ�uai����'�|]���B��&FU\b�{�� ����\&Nѕ	G�Q��XL�_q��nz���|\5��/'��[�͜EK��Cp�a��	ʾ�X�o����5*���x�����z�υ�6�'��1-�t����$�9�Zg�E�]~�o�8<:Ҿp������G�R�72Yq��qb|ǟ���e�!	@���W�EUN���w7�4HY'�Xw ��2N25_ ��Z[�Z���ච�q'~��㱱X�)�'��[x��"ԁx�~W�rt,�Ǟ��Y��+}���i�U�L�拃ax�>�m�� �L���E}��F*��~�7��*����l:�s���y�L�z����\6:w��o[��k¯�Ba�Q��s�U�?΢��#��������wy�o���<G��<�?	(�|��\��~�C�y>>$���G��ï��Ղ9�x?�,nV?߆w��,{r�a�d��qh���� Dg��*N�و�<���,���Ӊ10��0=H���������q����;��8�&�/'���l{�းAD|��.�b[�
�]/���AA���P�O�&f��D
�g��!k�~׊���y�4~��+������Ѷ�w ~�b�xo8��в�K݅��~)������@���IeT�I�V�Ռ�4\,B�8��2���^���ǖ麦XR�^��Ph��(�YJ��⍋��O0<��.C�"G�#��~y�Љ�Yvׄ���Ӣ�C�\�/.MQzhʹ���6�>ⲭټ���[�lq�ծ�<�qƫ!���-��G�ܘ��D�C���w�scW�s��3Z�ȫ��]�dw-������l���y��V������`��-�0�g�e���'bq�Y��3DO<�j|p��kڦ4���q�%�:.xf���n\���W��↺c���7!�����|���Tz�qRAt+ޛ»�[���H�p>w ��ό��آ�y"ȁ?�_�
�*����:x7_�e\��gc���U\��>�
w��*������wX�9��9;5-����Bi8�xg��<hW��i�`��]A�eNl�i�ё@�:�+����M�+�,ʞ��BSڊ�,	J�p/ݮ� 1�n1��_gĆb_>���A��Եjt�xw��_{�=]��'��
�����]kU.�wo��߇��5�ι)��X(��+�+�a�x��mq�8j&E��;�<��`�GQ�y˫`�87���X��'�XQ�@��
�Wk�+���^p,����7�� �`�O�Oo�������ڇЧ�L���r-@)��
u��c���-ΐ?�!�ߤ��=�$���ev��J�_�k����0��P|����H(]�.`|��}p�Vx���Y|w��>cÎ<��[Jޘ�r�o$y,������
~�U�t���|Kg	�9�,�ʽ���}�� �j�:���U8�����^4��I�� k�1�	���Ӈ����ǹQ�B$d�њ���������|m�[�❡_p�/�󍼶�)���o*^\��$��4�f�����V⋮w�H����Ϸ[���&�O1ǀŽ��bQ��� qœqT�̯�?�x�8?���W���P���B�Z=��95�[�|r
�����D6���u�$.e� T�e;�V&��M��L�o,����Ji��P�&N�EUh�"�M��bM&�+^_�6��x/j�M���C��Ӑ�"�a�,��M���@���c1mUNfV�[\%8��h9�♬�_?>V>�l�6�>�~j��.����WW���$I]��� ~��݅�h�|4໧#4�����9LFЭ���x�b[7�^��i6�_H�w���.�����Q_��|�)dVg��.��k-��vaֻ���a,����!���G�jſp�r�O_n�.N
��..(�-��,��=u�%�+�'�"
_�UoU��.�v2���<f���}��X�a|O̾��S5�+}����T�W��S�|�G+���#k"�ۨ������fd�-��;5Q\����|����/w9�� ��3�/E���*l�A{���1����3�F�*c��,_�
B�~�ﮗ��D�07z�ȁ~j��g�����!�*�CP7��Ӈ\��Y����f�ï�&�F�]9�����Q�,��W�w�2J��>�
�|���0�㞛��@�AOI��T$C�`a����0|���_��l���t�x4���x'	��0��?���Mϙ!w��$��ٍ����E���z֧xH��~�5��a�2����q��Z���#��GE��w�w����C����y�!BH�ހh��kBN�˛�pv�Ng����҉i{ӊR����,�΋V���%?c[�eM���.���L�Wx7p�����û���⺴���u|�/R��()}>⊧�U��\���i���Խ_���Iq9�.�c�*D\�������X�y�����I�_�
ߪ�h������\6d�HC�pR�s��Ƴ�<�}@�k10=��Xd`�xS�|�U�������64{�Y�Q>6J�T��V�F���T�E%�E)�¯x�hc[�}����ֹL���&I���6���2,��7����q�^C����ؖ���~�:�؈��He��Y����Q5�t��/�)`��s���"�	զ�%|�=����<����:Ӭ�ᔼ�1�E=�>n>0��f]!j�pfb��[|6x�������ñ��P,�=6J�������W��A��3�3�p�F@*;��+>�=>Ɯx��u�yi�cO�X�U���ϱF0��ϱ��*��p=�v�8���Vç�sR�;1�U�\��%o�9��uNE�T>��    E1Dk�G|��%���I����2F%}�,l	m���.�i����z>J)�3�_aKa�֪���Ϥ������U>x$5L"��>6�U�n�Xn��;_�.�ds�W��Ѭ7*v�.������΅ĺ�=�_��t��D�o	�}�r���k�t�<ju�=�_�sB��?�,.���N{��Ӊ�Ni�Qv'�����f��k��$L�۶�bHҭ�=�އ����e U ���S=<8�eg6��� �)�(�	>OF���0jv�����O(�����a�fd��G�:����:Dw�Wr�}Sn�/^��w���h�v.��^p7v
�L:�j0�;Ly��xw�-����WxH�ֱW�����k�W�9|D�F�U\�^�6w�m���,��x�XT�o���]��z)^����˫�yp�����oK�0����\ػHq��a+ޑ�*�c�xL��sI'^��,<u����y�����!����2r�q�}��Ə]E'�"�x��o\�?,�	%\�7q�)�]�&��#�p�U��:�w�<�������䟀��ͫ�F��	n���>���H<�T>���U:��~�����_6p�5����ͱ��
�+��*D8�������N���gF��<RJc�����З.���-����)^����ŮWp�
���0���#�#c���T:�o��6[�Nx{=]�����>�|��Rh��B�����;TrMw:������#���T[���,q���3��̴D8��	�
��-���S�ʖ��-��P>�"���ÿ���7W$��cx=���>Ў�=W��{a���hW�2� ��\�X�c�+�چ>m�p�}��q8��LzL,�ġs��6�64���}������g�D�L"���|������{m��xEG���WxȎ�LP��\�����C��c��c�n^.���t��j�G�;Ӈ����_Y��e'���Ň�mk0=�e�Gh�F�X$�|΅�l1��$v�S� Y]H%���a9�+޶�>����n����k���c����JW�t*^	c�q�J�l������-k��ʷ�'�k�Y��$gx�&qI�Y~%��rN�^�X�����Sb\�6-���#6���G��q8*�Iת��-o���s�C|�X����F&����n����p�r��f�Ķ�G��05/~#}�0�7�������l9�~�3�M�c^�u͎^j�����§[)ioʰZ�t~??��q<�̉��qP��/o��H�?uS"!uqz8;P�v=5J\�~�ܕ���B��$�t�S�_�����o���+����C�������m��k�Sxы��� �S�Y2��8�OZ�S������O9R]Ů����Y�w���j0���P$)*���v ���C�O�9�$�~�b��Jf�Y˱�qpAz�FU2R.�R5�V:k*�i��$�+�!!��;b��#���ɷ�7w�2��~����NW��Vpљ�=��{�k���V��*}n�I��R?�-=��q ���.��·��z�{����I<��j������&8��W��M�o.�V���a��<�|�.�o]_�l(�FM�b[��m��rF��q�p�<��n��=	��������uj��'��Q��f4���KI0b^� ����J�Ŷ�E٨W�i�/�L���j������Qa.0e-�ڍb?<���i5�T�/��gy�ث���lKVe��پ��7 �6�+�MP�S#��'�%9�����ٵ�+-�U��#�&�7|�=�}�E��$�d��/�O�s�����È���썐1�
�/l��s�r<K���z='�3
/�=R=%��ȣ�ѠF�NٶB5bNG:{�E/���5"�i�zrU��ّ��}ּ�d��~}U8`�����]�����J^��+W4���$��|p���Ҕ�e����ft;�?�d������OnH}�c���`��9�L�b.���t�ڹ|=�g_�>9G̰�WI?	w����K�O+�;��:�uF��
B�C��.}���W~���k�D��y��|�2	�oy��<������4Z&�?LE�O'�6벭����`�%�	��D��h�%���c��籓��gg�_���������<��ɵXp9�G|r��M	X�����w�!i����f�����d4v�u'��i��<A�ȓZm9�_�в�VA>@v6G��غQ(��Y�0}2��G�,�x�'Q��}߆A(wߗ�e��Ra��*�n��B�{?�Q�I�S'Y�CAHr�.U�u�@ͺYW�r�IL4�;(\e퐌�Lz�?�t:�&k��
�EV� 
/`�	��Ӝ����@��h��~��P[�!�#�j_�T�-*�j�X���N��X�k ��44X�h�S>*��j`����y��Ϳ|�v�Z��p��u���|]����}@�ystLD`SP�{DFy}�Q)�P�j	�k��I���foW��%�������w.��� �uEȺ�x(F���ު����t��Cagq\��!����`�Md_4cV���gY�\����~���	���30q[""�"!^�5��R���cW:!2���~���r�y�w���s,��.�#q���n����C�j���ǽV�[�lAI¾���M9����ֱ�2����/C���Q�1����Ӹ��wTFdHڟ��lu��Q�
a~���uv9k\�D���`��C�^��ESH:؄�3�`d6@�v�c�&�=j�ʁ:�ח��]"#�����},����b�1)!���jk�T��[7J)��b�V=�s2ru�}�P��҆���w�d�&�i�l����``�y� ���ӞE6	$�#����˪��,G��	?�2��{@�鬳��C���;�����}f'�<�}'���\��\w�|C�;W�]�{��v׽f���v�9�����Ѳ��;W�1����G��7Z ���uJ�q�A�6��@d��{��1�To�u�q��a�I���ue�r�Aٺ\wP�>��m��t�뺃��q݁��\w��ﺃ�u��p[\w �i�Hl�u�$Zy�ϛ��m�P����uS!�;�������2��bh���Ed�l��_}|�O0x��>�^�v+b��V2���$��ONK����Ӽ��S=3q��z~�����9�vƷQl��8'`
�0Q�f������9���~��l�@;F�LѠ�
�'����)_�: beK�1-Ğ����5��|�@	.���ڽ�ɢ���}�vCM�l�������!n:��!�{����Zk`�jL ��bOb�
����`	����Ґ&wF�hB��3y��D%�KD����ӈ�)��#y-mR�\��� knK���]_d2�bE+F��E�Bs O>'2Y2��~��Dɖ��*��ĚJ�cq)D	��_��+���%� �hj���)$r�=ɴ=Q.F������O�'%9j�K���bD	����2�pǓXSi����	�6�	vr���1D^^��f����d�����N���d|�<�#v);&�Q�Ph>9i�M~kϓ^���S��o��H�4�ԉ�'Q�w<+dG1|y޹�� �7)ݛ���q �����@YA.�aHfV�2��2�_�=)�K&���#VX4�]���T+yaֳ���_�(b./����r�ȧ��C4q �ʒw�~���s�_�W3�Į�Ч�.�����2z�������2����I�uS��8κoe�k����4+�"�Y4�� �F���˜�4n�9�{��7��-q�WT������_,LfO���cJC=�?>�c��%�=ѝY<.Ě�JvN�X�{��	g���7#�WX��'�����Ο�V��r�~����,K6 g$$�~��?���RG4�w�Ъw1��a0wl�D�m>��[{��.?XsZ*t,G��3����/w���x.�(��4`d�w<�Z0�%j���nq��i�dNU�[|���t>��G��/RBT��<)�'�'>��K�'��t�����fF��)'
�	� �  �tT!��j'��EN������g^I�g0���QFi!���@~L�ʢ���p]i2�ȭ��ߜ�Q�X��<�ȗ ����'"�4��1���u!�{#�4L!��=���>F���� "n�4���x2�ÓÄ�[:@|��xػ�'����/�i�1�c�B�9�'�P�I�1eǈ�!J�ȏ��Vu�-Ď5KTdB�d%�1�e)�lIG��)'X8��+�\E�,��r��d���(���
��0�O!F�d�׬����'aٶ��t� v�HZ���?b�2K�ajJ�P{8���o2Y�N���vCͪl��}UH6���e���_�b�9��e.�_c�WZ̜��#��,)�o�JfE~��~ �0�u?�f�v57���F�ٸ�[{~����X���b�o�(<�]ȏOm���2��ۨ�_�Tk����� K��DGwc�N������Y��jP�ߪ��o��wj�x��!xkK@��Is3X��r�$P�&�)z����f&�=P�{ҁv��*�)�́�Ȩ�%Iݎiu1y<��5Ou	q����c�")V��N���L��Yu��'���=%[�z�$&_��ٔ��G� ��%��)���Z�X���k�È�#������z,��?�r@34��z�8���#�"D����7��#}��1�^'�xR���S�B�IR&;N���I.F�,QQˋw<��a�l�-� ��)Ms�'�Suy��8#&��-u"O>m�dߏs1�c���(]�a�f�t�ܳ֜��--jL��fWk�i2�@s�IC��xr#J[�GV�Xr2�\Гϕ��zEө VH�M��On�m5Y�$������K)���w=�J���L�"b���0�d";�M��(%���-T
���PM-yJR�����0DyW9<s��4�O�p�2���z�L������lAr�G�"��0�����0(�(�d���d���n�G�L�z����\�)��Ԋ<sI��9<�D�!X�mG~�O����$�p �K�ۃ {��=��&������WҔ��ܢV���r�n��'��G�ۈ�U� �R��ESa��Г��(&x��<v�(��Ʉ:���R2���;��9�n���4����w���{t���Q� �ͬ����NeC:m����P�0���R�d"5��c�^:%K�Eؓ�Lv�r��Z���ϵ�Џ����&�j2��p6�Г��Z���f��rP]\ȓ��@k�����s Dɖ�F�{�.k��ZF��`�����SpBO2r,���קh@�����T|"���'Ϟ�9�y�Վ=KJ�	=)�*=/\G��)��pA?>g�X΢1���P�1�@�y2���3����5;F|Q,u!?>ʫhOh��V'Q5����1���҄յ�9�w���1���S�k�*�8�~�v`?���h�g�4,�̌�S�����F�P�Tc��kt O�V� ��JyyҐ=W���ň�)
��=)u��4�+B|�����xǓ�4��)|hmF��),ȏ̅|�v�}{���"����le���]��%2B���ْ�4�k}�[g��s���JI� ��~��Tt�(yF��%�G���`A�N�)��p�u�.��U��u'���Q:��M�ʑu��36�`���z�x�f�������R<Z3=Z��`n:\C�~m��V�k���c��k�F�tF�B_�OCқ�'׭��K�f�f��{�@�q�}����������]�:ԁ�F:���
�$��[�E}w/���;�dPE��ѐ�I|?K��#�����LR���;��,v���rS7���.J�����xK��}!�8��\����g>fy���H��4�*�Ś��j`+g�l��Ր��� �l�M�!"�n�Ab>�2B&�L.��#��\k����P����e���S��4�΃&1���%;W��GΞ_�r}��;	ԶԶƒԶȒԶŒ�6oIj?�%��ߒ�6mI�[aI�[cI�[dI��bI꛷$��ʒ��oI꛶$���$���$e��G[�ƶX���-��-X�%i�ߒ46mI����mQ�ۖ6���6��S�����Ͷ�Zc�rb�L�2a8b�H� #Գ6�H�a����#'�#(�n��?Y�꺎���Z΃��q�8�?��A胝�c	���Ъv�rH���U��^��D}��f��u�� 	}�d��S���$E>�0�7�����r���Fv����Z���f?������g�G��~Y�#��_���V2��            x������ � �            x������ � �            x������ � �            x������ � �      O   3  x���_k�0ş�O�0c��i��i�ad0{B�\kF5�C���s������!�},ݺ��Y������l�V�R��U=�H鼋N5�3Kh޵b��aJRJG��9�e�(��O�f�G$FZV��a5�� Jc��L��r�L �6[���d�����A��!��
ͧ(�&�_V�L0�\t���Y����s�̰�f�	�i�U�f���p"�=qΔn �=�%�B���>J��.J���8�S"J����ڗ�Z�ϰ�=����[إ�ǐ��+��ne���gs�$� ��Q      N      x�3�L��"�=... U�      Q      x������ � �      R      x������ � �     