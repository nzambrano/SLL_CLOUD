PGDMP     	             	        y            SLL    13.1 (Debian 13.1-1.pgdg100+1)    13.1    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    SLL    DATABASE     Y   CREATE DATABASE "SLL" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
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
       SLL         heap    SLL    false    4            �            1259    16455    databasechangelog    TABLE     Y  CREATE TABLE public.databasechangelog (
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
       public          SLLPE    false            %          0    24572    M4SLL_ABOHON_NJ 
   TABLE DATA           �   COPY "SLL"."M4SLL_ABOHON_NJ" ("ID_ORGANIZATION", "ANJ_SECUENCIA", "MAB_SECUENCIA", "ANJ_OBSERVACION", "ANJ_MONTO", "ANJ_DT_START", "ANJ_DT_END", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    206   ��      &          0    24578    M4SLL_ASIENTOS_C 
   TABLE DATA           N  COPY "SLL"."M4SLL_ASIENTOS_C" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ORIGEN", "GRUPO", "LOTE", "DESCRIP", "STATUS", "ASIENTO", "CANT_ASIENTO", "CREATION_DATE", "ID_APPROLE2", "ID_SECUSER2", "DT_LAST_UPDATE2", "XX_FUN", "XX_EST", "XX_ERROR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    207   Ӹ      '          0    24584    M4SLL_ASIENTOS_D 
   TABLE DATA           �  COPY "SLL"."M4SLL_ASIENTOS_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ASD_SECUENCIA", "ORIGEN", "GRUPO", "LOTE", "MONEDA", "FCREA", "UCREA", "CATEGORIA", "CTACBLE", "EMPRESA", "RENGLON", "FECCONT", "PAIS", "DIVISION", "DEPTO", "ACTIV", "VALDB", "VALCR", "FGRAB", "HGRAB", "STATUS", "TCIDEA", "SCIDEA", "NCIDEA", "DLOTE", "IMPDB", "IMPCR", "TASACON", "FCONMON", "NOMASIEN", "DASIEN", "HISTORICO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    208   �      )          0    24593    M4SLL_AUTOR_REU 
   TABLE DATA           B  COPY "SLL"."M4SLL_AUTOR_REU" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "STD_OR_HR_PERIOD", "MAB_SECUENCIA", "MTE_ID_TP_EMPLEADO", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "TPE_ID_TP_ENTIDAD", "AUR_CK_SUBSIDIARIO", "AUR_CK_SOLIDARIO", "AUR_MONTO_INDEMNIZACION", "AUR_CAUSA_DESVINCULACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "ECI_ID_CIUDAD") FROM stdin;
    SLL          SLL    false    210   �      -          0    24617    M4SLL_AUTOR_REU_1 
   TABLE DATA           �  COPY "SLL"."M4SLL_AUTOR_REU_1" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    214   *�      *          0    24599    M4SLL_AUTOR_REU_BKP 
   TABLE DATA           !  COPY "SLL"."M4SLL_AUTOR_REU_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPE_ID_TP_ENTIDAD", "AUR_CK_SUBSIDIARIO", "AUR_CK_SOLIDARIO", "AUR_MONTO_INDEMNIZACION", "AUR_CAUSA_DESVINCULACION", "MTE_ID_TP_EMPLEADO", "MAB_SECUENCIA") FROM stdin;
    SLL          SLL    false    211   G�      +          0    24605    M4SLL_AUTOR_REU_PRUEBA_GABY 
   TABLE DATA           =  COPY "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "STD_OR_HR_PERIOD", "MAB_SECUENCIA", "MTE_ID_TP_EMPLEADO", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "TPE_ID_TP_ENTIDAD", "AUR_CK_SUBSIDIARIO", "AUR_CK_SOLIDARIO", "AUR_MONTO_INDEMNIZACION", "AUR_CAUSA_DESVINCULACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    212   d�      ,          0    24611    M4SLL_AUTOR_REU_QA 
   TABLE DATA           �  COPY "SLL"."M4SLL_AUTOR_REU_QA" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "TAR_ID_TP_AUTOR_REU", "AUR_AUTOR_REU", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "PEX_NRO_DOCUMENTO", "STD_ID_LEG_ENT", "STD_ID_PERSON", "AUR_EMAIL", "AUR_NOMBRE_ABOGADO", "AUR_TELEFONO", "AUR_OBSERVACIONES", "AUR_CK_PRINCIPAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPE_ID_TP_ENTIDAD") FROM stdin;
    SLL          SLL    false    213   ��      .          0    24623    M4SLL_AUT_REU_DOC 
   TABLE DATA           �   COPY "SLL"."M4SLL_AUT_REU_DOC" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARD_SECUENCIA", "ARD_URL_DOCUMENTO", "ARD_FECHA_DOCUMENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    215   ��      (          0    24590    M4SLL_AU_REU_ANALI 
   TABLE DATA           �   COPY "SLL"."M4SLL_AU_REU_ANALI" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARA_SECUENCIA", "ARA_CENTRO_COSTO", "ARA_SEGMENTO", "ARA_DIVISION", "STD_ID_LEG_ENT", "ARA_REGION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    209   ��      /          0    24629    M4SLL_CASUIS_CTAS 
   TABLE DATA           �   COPY "SLL"."M4SLL_CASUIS_CTAS" ("ID_ORGANIZATION", "CCU_CASO", "CCU_NRO_ASIENTO", "CCU_DEBE_HABER", "CCU_CUENTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    216   ع      0          0    24632    M4SLL_CASUIS_CTAS_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_CASUIS_CTAS_PRUEBA_GABY" ("ID_ORGANIZATION", "CCU_CASO", "CCU_NRO_ASIENTO", "CCU_DEBE_HABER", "CCU_CUENTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    217   ��      1          0    24635    M4SLL_CCB_RAMAJUDC 
   TABLE DATA           >  COPY "SLL"."M4SLL_CCB_RAMAJUDC" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    218   �      2          0    24641    M4SLL_CCB_RAMAJUDC_10 
   TABLE DATA           A  COPY "SLL"."M4SLL_CCB_RAMAJUDC_10" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    219   /�      3          0    24647    M4SLL_CCB_RAMAJUDC_20 
   TABLE DATA           A  COPY "SLL"."M4SLL_CCB_RAMAJUDC_20" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    220   L�      4          0    24653    M4SLL_CCB_RAMAJUDD 
   TABLE DATA           #  COPY "SLL"."M4SLL_CCB_RAMAJUDD" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    221   i�      7          0    24671    M4SLL_CCB_RAMAJUDD2 
   TABLE DATA           $  COPY "SLL"."M4SLL_CCB_RAMAJUDD2" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    224   ��      5          0    24659    M4SLL_CCB_RAMAJUDD_10 
   TABLE DATA           &  COPY "SLL"."M4SLL_CCB_RAMAJUDD_10" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    222   ��      6          0    24665    M4SLL_CCB_RAMAJUDD_1000 
   TABLE DATA           (  COPY "SLL"."M4SLL_CCB_RAMAJUDD_1000" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    223   ��      8          0    24677    M4SLL_CCB_RAMAJUDD_20 
   TABLE DATA           &  COPY "SLL"."M4SLL_CCB_RAMAJUDD_20" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    225   ݺ      9          0    24683    M4SLL_CCB_RJCC_BKP 
   TABLE DATA           >  COPY "SLL"."M4SLL_CCB_RJCC_BKP" ("ID_ORGANIZATION", "RJC_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJC_DESPACHO", "RJC_PONENTE", "RJC_TIPO", "RJC_CLASE", "RJC_RECURSO", "RJC_UBICACION_EXPEDIENTE", "RJC_DEMANDANTE", "RJC_DEMANDADO", "RJC_CONTENIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    226   ��      :          0    24689    M4SLL_CCB_RJCD_BKP 
   TABLE DATA           #  COPY "SLL"."M4SLL_CCB_RJCD_BKP" ("ID_ORGANIZATION", "RJD_SECUENCIA", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "RJD_DT_ACTUALIZACION", "RJD_ACTUACION", "RJD_ANOTACION", "RJD_DT_INICIO_TERMINO", "RJD_DT_FIN_TERMINO", "RJD_DT_REGISTRO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    227   �      <          0    24698    M4SLL_CIERRES_MENS 
   TABLE DATA           �   COPY "SLL"."M4SLL_CIERRES_MENS" ("ID_ORGANIZATION", "CIM_ANIO", "CIM_MES", "MTC_ID_TAREA", "MEE_ID_EST_EJECUCION", "MET_ID_EST_TAREA", "CIM_DT_EJECUCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    229   4�      ;          0    24695    M4SLL_CIERRE_MENSUAL 
   TABLE DATA           b   COPY "SLL"."M4SLL_CIERRE_MENSUAL" ("CIM_ANIO", "CIM_MES", "ID_TAREA", "ESTADO_TAREA") FROM stdin;
    SLL          SLL    false    228   Q�      =          0    24701    M4SLL_CLIENTES_OMB 
   TABLE DATA           �   COPY "SLL"."M4SLL_CLIENTES_OMB" ("ID_ORGANIZATION", "CLO_ID_CLIENTE", "CLO_NM_CLIENTE", "CLO_DT_START", "CLO_DT_END", "CLO_ID_APP_ROLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    230   n�      >          0    24704    M4SLL_CLIENTES_ROL 
   TABLE DATA           �   COPY "SLL"."M4SLL_CLIENTES_ROL" ("ID_ORGANIZATION", "CLO_ID_CLIENTE", "CLR_ID_ROLE", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    231   ��      C          0    24729    M4SLL_COMPROMISOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_COMPROMISOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TCO_ID_TP_COMPROMISO", "COM_SECUENCIA", "MAB_SECUENCIA", "TFA_ID_TP_FASE", "COR_ID_COMP_RESULTADO", "COM_FECHA", "COM_OBSERVACION", "COE_ID_COMP_ESTADO", "COM_DT_END", "COM_RESPONSABLE", "COM_DT_INICIO", "COM_ACTUACION", "COM_NOTAS", "COM_DT_INICIO_TERMINO", "COM_DT_FIN_TERMINO", "COM_DT_REGISTRO", "COM_URL_DOCUMENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COM_NM_DOCUMENTO", "COM_SECUENCIAL") FROM stdin;
    SLL          SLL    false    236   ��      D          0    24735    M4SLL_COMPROMISOS_BKP 
   TABLE DATA           �  COPY "SLL"."M4SLL_COMPROMISOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TCO_ID_TP_COMPROMISO", "COM_SECUENCIA", "TFA_ID_TP_FASE", "COR_ID_COMP_RESULTADO", "COM_FECHA", "COM_OBSERVACION", "COE_ID_COMP_ESTADO", "COM_DT_END", "COM_RESPONSABLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COM_DT_INICIO", "COM_ACTUACION", "COM_NOTAS", "COM_DT_INICIO_TERMINO", "COM_DT_FIN_TERMINO", "COM_DT_REGISTRO", "COM_URL_DOCUMENTO", "MAB_SECUENCIA") FROM stdin;
    SLL          SLL    false    237   Ż      ?          0    24707    M4SLL_COMP_DETALLE 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_DETALLE" ("ID_ORGANIZATION", "COM_SECUENCIA", "LIT_ID_LITIGIO", "COE_ID_COMP_ESTADO", "COR_ID_COMP_RESULTADO", "COD_FECHA", "COD_OBSERVACION", "COD_SECUENCIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    232   �      @          0    24713    M4SLL_COMP_DOC 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_DOC" ("ID_ORGANIZATION", "TCO_ID_TP_COMPROMISO", "LIT_ID_LITIGIO", "COD_SECUENCIA", "COM_SECUENCIA", "COD_URL_DOCUMENTO", "COD_FECHA_DOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    233   ��      A          0    24719    M4SLL_COMP_ESTADOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_ESTADOS" ("ID_ORGANIZATION", "COE_ID_COMP_ESTADO", "COE_NM_COMP_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COE_DT_START", "COE_DT_END") FROM stdin;
    SLL          SLL    false    234   �      B          0    24724    M4SLL_COMP_RESULTA 
   TABLE DATA           �   COPY "SLL"."M4SLL_COMP_RESULTA" ("ID_ORGANIZATION", "COR_ID_COMP_RESULTADO", "COR_NM_COMP_RESULTADO", "TCO_ID_TP_COMPROMISO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "COR_DT_START", "COR_DT_END") FROM stdin;
    SLL          SLL    false    235   9�      E          0    24741    M4SLL_CONVERSION 
   TABLE DATA           �   COPY "SLL"."M4SLL_CONVERSION" ("ID_ORGANIZATION", "CON_REFERENCIA", "CON_VALOR_CONVERTIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    238   V�      F          0    24747    M4SLL_COTIZACION 
   TABLE DATA           �   COPY "SLL"."M4SLL_COTIZACION" ("ID_ORGANIZATION", "COT_ANIO", "COT_MES", "COT_COTIZACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    239   s�      G          0    24750    M4SLL_CPE_CEJPJ_C 
   TABLE DATA           (  COPY "SLL"."M4SLL_CPE_CEJPJ_C" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "FAS_NRO_RADICACION", "CCC_DEMANDANTE", "CCC_DEMANDADO", "CCC_ORGANO", "CCC_DISTRITO", "CCC_JUEZ", "CCC_FECHA_INICIO", "CCC_PROCESO", "CCC_ESPECIALIDAD", "CCC_MATERIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    240   ��      H          0    24756    M4SLL_CPE_CEJPJ_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_CPE_CEJPJ_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "CCD_ID_SECUENCIA", "CCD_SUMILLA_SEGUIMIENTO", "CCD_FECHA_SEGUIMIENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    241   ��      I          0    24762    M4SLL_CTRL_ERRORES 
   TABLE DATA           �   COPY "SLL"."M4SLL_CTRL_ERRORES" ("ID_ORGANIZATION", "CTE_USUARIO", "CTE_FECHA", "CTE_MODULO", "CTE_DESCRIPCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    242   ʼ      J          0    24768    M4SLL_CUADRANTE 
   TABLE DATA           �  COPY "SLL"."M4SLL_CUADRANTE" ("ID_ORGANIZATION", "ORDINAL_10_PK", "ARG_CSP_COD_EMPR", "ARG_CSP_NOM_EMPR", "ARG_CSP_SSN", "ARG_CSP_ID_HR", "ARG_CSP_OR_HR_PER", "ARG_CSP_N_FIRST_NAME", "ARG_CSP_COD_ACT", "ARG_CSP_COD_DELEG", "ARG_CSP_NOM_DELEG", "ARG_CSP_ANNO_MES", "ARG_CSP_FEC_MOBRA", "ARG_CSP_COD_CLI", "ARG_CSP_NOM_CLI", "ARG_CSP_COD_SER", "ARG_CSP_NOM_SER", "ARG_CSP_FI_SERVI", "ARG_CSP_HORA_FI_SERVI", "ARG_CSP_FF_SERVI", "ARG_CSP_HORA_FF_SERVI", "ARG_CSP_HORAS_NOCT", "ARG_CSP_HORAS_DIUR", "ARG_CSP_FIN_FEST", "ARG_CSP_ARMA", "ARG_CSP_DIA_SEMANA", "ARG_CSP_FESTIVO", "CUA_CK_CLIENTE", "CUA_CK_OBJETIVO", "CUA_CK_GT_HORAS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    243   �      K          0    24774    M4SLL_CUADRANTE_LOG 
   TABLE DATA           �   COPY "SLL"."M4SLL_CUADRANTE_LOG" ("ID_ORGANIZATION", "CLG_SQLCOD_ERROR", "CLG_SQLMSG_ERROR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    244   �      L          0    24780    M4SLL_DATOS_WF 
   TABLE DATA           �   COPY "SLL"."M4SLL_DATOS_WF" ("ID_ORGANIZATION", "ID_BPC", "MODULO", "ID_MODULE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    245   !�      M          0    24783    M4SLL_DESTINATARIO 
   TABLE DATA           �   COPY "SLL"."M4SLL_DESTINATARIO" ("ID_ORGANIZATION", "DES_ID_DESTINATARIO", "DES_NM_DESTINATARIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    246   >�      Q          0    24802    M4SLL_DOCPAG 
   TABLE DATA           �  COPY "SLL"."M4SLL_DOCPAG" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "DCP_SECUENCIA", "DCP_DESCRIPCION", "DCP_FEC_CRE", "DCP_NRO_SOLICITUD", "DCP_APROB_ABOGADO_INT", "DCP_APROB_BACK_OFFICE", "DCP_APROB_GERENCIAL", "DCP_STATUS", "DCP_NRO_IDENTIFICACION", "DCP_DESTINATARIO", "DCP_TIPO_CUENTA", "DCP_NRO_CUENTA_DES", "DCP_EMAIL_DEST", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "DCP_DESTINATARI1") FROM stdin;
    SLL          SLL    false    250   [�      N          0    24786    M4SLL_DOC_LITIGIOS 
   TABLE DATA           ?  COPY "SLL"."M4SLL_DOC_LITIGIOS" ("ID_ORGANIZATION", "DOL_SECUENCIA", "LIT_ID_LITIGIO", "TDL_ID_TP_DOC_LITIGIO", "DOL_FECHA", "DOL_OBSERVACION", "DOL_URL_DOC_LIT", "DOO_ID_DOC_ORIGEN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TFA_ID_TP_FASE", "DOL_CK_ASOCIA_FASE", "DOL_NOMBRE", "DOL_DT_NOTIFICACION") FROM stdin;
    SLL          SLL    false    247   x�      O          0    24793    M4SLL_DOC_LITIGIOS_BKP 
   TABLE DATA             COPY "SLL"."M4SLL_DOC_LITIGIOS_BKP" ("ID_ORGANIZATION", "DOL_SECUENCIA", "LIT_ID_LITIGIO", "TDL_ID_TP_DOC_LITIGIO", "DOL_FECHA", "DOL_OBSERVACION", "DOL_URL_DOC_LIT", "DOO_ID_DOC_ORIGEN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TFA_ID_TP_FASE", "DOL_CK_ASOCIA_FASE") FROM stdin;
    SLL          SLL    false    248   ��      P          0    24799    M4SLL_DOC_ORIGENES 
   TABLE DATA           �   COPY "SLL"."M4SLL_DOC_ORIGENES" ("ID_ORGANIZATION", "DOO_ID_DOC_ORIGEN", "DOO_NM_DOC_ORIGEN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    249   ��      R          0    24808    M4SLL_ENTIDADES 
   TABLE DATA           2  COPY "SLL"."M4SLL_ENTIDADES" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "ENT_ID_ENTIDAD", "ENT_NM_ENTIDAD", "TPE_ID_TP_ENTIDAD", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "ENT_DT_END", "ENT_DT_START", "ENT_TP_EMPLEADO", "ENT_ID_NEGOCIO") FROM stdin;
    SLL          SLL    false    251   Ͻ      S          0    24816    M4SLL_ENTIDADES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_ENTIDADES_BKP" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "ENT_NRO_IDENTIFICACION", "ENT_ID_ENTIDAD", "ENT_NM_ENTIDAD", "TPE_ID_TP_ENTIDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    252   �      T          0    24822    M4SLL_ESP_CIUDADES 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_CIUDADES" ("ID_ORGANIZATION", "ECI_ID_CIUDAD", "ECI_NM_CIUDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    253   	�      U          0    24825    M4SLL_ESP_DELEGACI 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_DELEGACI" ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "EDE_NM_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    254   &�      V          0    24828    M4SLL_ESP_DELEGACI_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY" ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "EDE_NM_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    255   C�      W          0    24831    M4SLL_ESP_LIT_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESP_LIT_PROV" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "ELP_ANIO", "ELP_MES", "ELP_VALOR_PROVISION", "ELP_PORCENTAJE_PROV", "LIT_VALOR_PED_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    256   `�      Y          0    24839    M4SLL_ESTUDIO_JUR 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESTUDIO_JUR" ("ID_ORGANIZATION", "EJU_ID_EST_JURIDICO", "EJU_NM_EST_JURIDICO", "EJU_EMAIL", "EJU_TEL_OFICINA", "EJU_TEL_MOVIL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "EJU_DT_END", "EJU_DT_START") FROM stdin;
    SLL          SLL    false    258   }�      Z          0    24847    M4SLL_ESTUDIO_JUR_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_ESTUDIO_JUR_BKP" ("ID_ORGANIZATION", "EJU_ID_EST_JURIDICO", "EJU_NM_EST_JURIDICO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "EJU_EMAIL", "EJU_TEL_OFICINA", "EJU_TEL_MOVIL") FROM stdin;
    SLL          SLL    false    259   ��      X          0    24834    M4SLL_EST_JUR_SUB 
   TABLE DATA           �   COPY "SLL"."M4SLL_EST_JUR_SUB" ("ID_ORGANIZATION", "EJU_ID_EST_JURIDICO", "EJS_ID_EST_JUR_SUB", "EJS_NM_EST_JUR_SUB", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "EJS_DT_START", "EJS_DT_END") FROM stdin;
    SLL          SLL    false    257   ��      [          0    24853    M4SLL_EXEC_RP_LITIGIO 
   TABLE DATA           P   COPY "SLL"."M4SLL_EXEC_RP_LITIGIO" ("USUARIO", "SQL", "FECHA_HORA") FROM stdin;
    SLL          SLL    false    260   Ծ      \          0    24859    M4SLL_EXP_PED 
   TABLE DATA           c   COPY "SLL"."M4SLL_EXP_PED" ("LIT_ID_LEGADO", "LIT_VALOR_TOTAL", "LIT_VALOR_PED_TOTAL") FROM stdin;
    SLL          SLL    false    261   �      ]          0    24862    M4SLL_FASES 
   TABLE DATA           �  COPY "SLL"."M4SLL_FASES" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAS_ID_FASE_ESTADO", "FAR_ID_FASE_RESULTADO", "FAS_FECHA", "FAS_OBSERVACION", "FAS_DT_CITACION", "FAS_NRO_RADICACION", "TRI_ID_TRIBUNAL", "FAS_JUEZ", "FAS_VALOR_CONDENA", "FAS_VALOR_HONORARIOS", "FAS_PORC_CONDENA", "FAS_PORC_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "FAS_CHK_ROBOT", "FAS_SECUENCIA", "FAS_NUM_JUZGADO", "FAS_FECHA_COND", "FAS_FECHA_HON", "FAS_OBS_HON", "FAS_DT_IMPACTO", "FAS_HORA") FROM stdin;
    SLL          SLL    false    262   �      ^          0    24868    M4SLL_FASES_BKP 
   TABLE DATA           �  COPY "SLL"."M4SLL_FASES_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAS_ID_FASE_ESTADO", "FAR_ID_FASE_RESULTADO", "FAS_FECHA", "FAS_OBSERVACION", "FAS_DT_CITACION", "FAS_NRO_RADICACION", "TRI_ID_TRIBUNAL", "FAS_JUEZ", "FAS_VALOR_CONDENA", "FAS_VALOR_HONORARIOS", "FAS_PORC_CONDENA", "FAS_PORC_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "FAS_CHK_ROBOT", "FAS_SECUENCIA") FROM stdin;
    SLL          SLL    false    263   +�      _          0    24874    M4SLL_FASES_DOC 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_DOC" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAD_SECUENCIA", "FAD_URL_DOCUMENTO", "FAS_FECHA_DOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    264   H�      `          0    24880    M4SLL_FASES_ESTADO 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_ESTADO" ("ID_ORGANIZATION", "FAS_ID_FASE_ESTADO", "FAS_NM_FASE_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "FAS_DT_START", "FAS_DT_END") FROM stdin;
    SLL          SLL    false    265   e�      a          0    24885    M4SLL_FASES_PROV 
   TABLE DATA           H  COPY "SLL"."M4SLL_FASES_PROV" ("ID_ORGANIZATION", "FAP_SECUENCIA", "LIT_ID_LITIGIO", "FAP_DT_IMPACTO", "FAP_FECHA", "FAP_VALOR_CONDENA", "FAP_VALOR_HONORARIOS", "FAP_PORC_CONDENA", "FAP_PORC_HONORARIOS", "FAP_FECHA_COND", "FAP_FECHA_HON", "FAP_OBS_COND", "FAP_OBS_HON", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    266   ��      b          0    24891    M4SLL_FASES_PROV_BKP 
   TABLE DATA           ^  COPY "SLL"."M4SLL_FASES_PROV_BKP" ("ID_ORGANIZATION", "FAP_SECUENCIA", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAP_DT_IMPACTO", "FAP_FECHA", "FAP_VALOR_CONDENA", "FAP_VALOR_HONORARIOS", "FAP_PORC_CONDENA", "FAP_PORC_HONORARIOS", "FAP_FECHA_COND", "FAP_FECHA_HON", "FAP_OBS_COND", "FAP_OBS_HON", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    267   ��      c          0    24897    M4SLL_FASES_RESULT 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_RESULT" ("ID_ORGANIZATION", "FAR_ID_FASE_RESULTADO", "TFA_ID_TP_FASE", "FAR_NM_FASE_RESULTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "FAR_DT_START", "FAR_DT_END") FROM stdin;
    SLL          SLL    false    268   ��      d          0    24902    M4SLL_FASES_RESULT_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_FASES_RESULT_BKP" ("ID_ORGANIZATION", "FAR_ID_FASE_RESULTADO", "TFA_ID_TP_FASE", "FAR_NM_FASE_RESULTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    269   ٿ      e          0    24905    M4SLL_HIS_DET_PROV 
   TABLE DATA           	  COPY "SLL"."M4SLL_HIS_DET_PROV" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "MDP_ID_DET_PROVISION", "HDP_DT_PERIODO", "HDP_VALOR", "HDP_PORC_PROV", "HDP_MONTO_A_PROVISIONAR", "HDP_MONTO_PAGADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    270   ��      f          0    24908    M4SLL_INI_PARAM_CALC_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_INI_PARAM_CALC_PROV" ("IPAR_SECUENCIA", "ID_ORGANIZATION", "IPAR_PROCESO", "IPAR_NOMBRE", "IPAR_DESC", "IPAR_VAL_NUMBER", "IPAR_VAL_DATE", "IPAR_VAL_CHAR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    271   �      i          0    24920    M4SLL_INT_GL_TRXS 
   TABLE DATA           �  COPY "SLL"."M4SLL_INT_GL_TRXS" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "RENGLON", "EMPRESA", "FECCONT", "MONEDA", "FCREA", "UCREA", "CATEGORIA", "CTACBLE", "PAIS", "DIVISION", "DEPTO", "ACTIV", "VALDB", "VALCR", "FGRAB", "HGRAB", "STATUS", "TCIDEA", "SCIDEA", "NCIDEA", "DLOTE", "IMPDB", "IMPCR", "TASACON", "FCONMON", "NOMASIEN", "DASIEN", "DLINEA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    274   0�      j          0    24926    M4SLL_INT_GL_TRXS_PRUEBA_GABY 
   TABLE DATA           �  COPY "SLL"."M4SLL_INT_GL_TRXS_PRUEBA_GABY" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "RENGLON", "EMPRESA", "FECCONT", "MONEDA", "FCREA", "UCREA", "CATEGORIA", "CTACBLE", "PAIS", "DIVISION", "DEPTO", "ACTIV", "VALDB", "VALCR", "FGRAB", "HGRAB", "STATUS", "TCIDEA", "SCIDEA", "NCIDEA", "DLOTE", "IMPDB", "IMPCR", "TASACON", "FCONMON", "NOMASIEN", "DASIEN", "DLINEA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    275   M�      g          0    24914    M4SLL_INT_GL_TRX_L 
   TABLE DATA           !  COPY "SLL"."M4SLL_INT_GL_TRX_L" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "LIT_ID_LITIGIO", "DESCRIP", "STATUS", "ASIENTO", "CANT_ASIENTO", "CREATION_DATE", "ID_APPROLE2", "ID_SECUSER2", "DT_LAST_UPDATE2", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "IGT_IMPORTE_LOTE") FROM stdin;
    SLL          SLL    false    272   j�      h          0    24917    M4SLL_INT_GL_TRX_L_PRUEBA_GABY 
   TABLE DATA           -  COPY "SLL"."M4SLL_INT_GL_TRX_L_PRUEBA_GABY" ("ID_ORGANIZATION", "ORIGEN", "GRUPO", "LOTE", "LIT_ID_LITIGIO", "DESCRIP", "STATUS", "ASIENTO", "CANT_ASIENTO", "CREATION_DATE", "ID_APPROLE2", "ID_SECUSER2", "DT_LAST_UPDATE2", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "IGT_IMPORTE_LOTE") FROM stdin;
    SLL          SLL    false    273   ��      k          0    24932    M4SLL_INT_LIST_LITIGIOS 
   TABLE DATA           D   COPY "SLL"."M4SLL_INT_LIST_LITIGIOS" ("LIT_ID_LITIGIO") FROM stdin;
    SLL          SLL    false    276   ��      m          0    24941    M4SLL_INT_PAGO_NOM 
   TABLE DATA           �  COPY "SLL"."M4SLL_INT_PAGO_NOM" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PNO_LOTE", "TPA_ID_PAGO", "PNO_VALOR", "PNO_FECHA", "STD_ID_PERSON", "STD_ID_LEG_ENT", "PNO_PRINCIPAL_S_N", "PNO_INTERESES", "PNO_SALARIO_DIA", "PNO_COTIZACION", "SSP_ID_CABEC_TC1", "PNO_CUENTA_ABONO", "PNO_CODIGO_IBAN", "PNO_OTRAS_CUENTAS", "PNO_BENEFICIARIO", "IPN_IMPORTE_BRUTO", "IPN_DESCUENTOS_S_S", "LIT_NRO_PROCESO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "STD_OR_HR_PERIOD", "PNO_F_FIN_SANCION", "PNO_F_INI_SANCION", "PNO_APLICA_SAL_DIA", "PNO_F_REINCORP", "PNO_ADJ_VIDA_LAB", "PNO_F_IMP_HASTA", "PNO_F_IMP_DESDE", "PNO_RECON_DERECHO", "IPN_DESC_IRPF", "PNO_F_ENV_NOM", "IPN_F_TRANSF", "IPN_RET_JUDICIAL", "IPN_IMP_TRANSF", "PNO_NRO_C_JUZ", "PNO_F_VENCIMIENTO", "PNO_ANT_RECONOCIDA", "PNO_DIAS_SANCIONA", "IPN_APLI_SAN_S_N", "IPN_LETRA_JUZGADO", "IPN_COD_IBAN_GENE", "IPN_NRO_EXP", "TPA_NM_PAGO", "PNO_NETO_S_N") FROM stdin;
    SLL          SLL    false    278   ��      l          0    24935    M4SLL_INT_PAG_NO_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_INT_PAG_NO_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "MCO_ID_CONCEPTO", "PND_FECHA_DESDE", "PND_FECHA_HASTA", "PND_IMPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MCO_NM_CONCEPTO") FROM stdin;
    SLL          SLL    false    277   ��      p          0    24959    M4SLL_LITIGIOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_LITIGIOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MCA_ID_CODIGO_ALTERNO", "MRI_ID_RIESGO", "MMA_ID_MATERIA", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS", "LIT_PREVISION", "LIT_PROVISION", "LIT_IMPORTE_TRANSF", "LIT_DESCUENTOS_S_S_TOTAL", "LIT_IMPORTE_BRUTO_TOTAL", "LIT_RETENCION_JUDICIAL_TOTAL", "LIT_DESCUENTOS_IRPF_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_CK_CALC_PROV") FROM stdin;
    SLL          SLL    false    281   ��      q          0    24965    M4SLL_LITIGIOS_BKP 
   TABLE DATA              COPY "SLL"."M4SLL_LITIGIOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL") FROM stdin;
    SLL          SLL    false    282   �      r          0    24971    M4SLL_LITIGIOS_BKP_COL 
   TABLE DATA           $  COPY "SLL"."M4SLL_LITIGIOS_BKP_COL" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "MMA_ID_MATERIA", "MRI_ID_RIESGO", "MCA_ID_CODIGO_ALTERNO", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS") FROM stdin;
    SLL          SLL    false    283   5�      s          0    24977    M4SLL_LITIGIOS_GGA 
   TABLE DATA           �  COPY "SLL"."M4SLL_LITIGIOS_GGA" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MCA_ID_CODIGO_ALTERNO", "MRI_ID_RIESGO", "MMA_ID_MATERIA", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS", "LIT_PREVISION", "LIT_PROVISION", "LIT_IMPORTE_TRANSF", "LIT_DESCUENTOS_S_S_TOTAL", "LIT_IMPORTE_BRUTO_TOTAL", "LIT_RETENCION_JUDICIAL_TOTAL", "LIT_DESCUENTOS_IRPF_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    284   R�      t          0    24983    M4SLL_LITIGIOS_HIS 
   TABLE DATA           �   COPY "SLL"."M4SLL_LITIGIOS_HIS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIH_SECUENCIA", "LIH_COLUM_ALTERADA", "LIH_FECHA_ALTERADA", "LIH_ID_OLD", "LIH_ID_NUEVO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    285   o�      u          0    24986    M4SLL_LITIGIOS_PRUEBA_GABY 
   TABLE DATA           �  COPY "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MCA_ID_CODIGO_ALTERNO", "MRI_ID_RIESGO", "MMA_ID_MATERIA", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "LIT_DT_ACTUALIZACION", "LIT_USER_ACTUALIZACION", "LIT_CENTRO_COSTO", "LIT_DIVISION", "LIT_REGION", "LIT_NUMERO_EJECUCION", "LIT_VALOR_PED_TOTAL", "MAB_SECUENCIA", "LIT_UBICACION_FISICA", "LIT_SECUENCIA", "LIT_CORPORATIVO_S_N", "LIT_SUBROGADO_S_N", "LIT_PORCENTAJE_PROBABILIDAD", "LIT_SUSTENTACION", "LIT_FLEX_CONDENA", "LIT_FLEX_HONORARIOS", "LIT_PREVISION", "LIT_PROVISION", "LIT_IMPORTE_TRANSF", "LIT_DESCUENTOS_S_S_TOTAL", "LIT_IMPORTE_BRUTO_TOTAL", "LIT_RETENCION_JUDICIAL_TOTAL", "LIT_DESCUENTOS_IRPF_TOTAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_PORC_PROVISION") FROM stdin;
    SLL          SLL    false    286   ��      v          0    24992    M4SLL_LITIGOS_BKP 
   TABLE DATA           T  COPY "SLL"."M4SLL_LITIGOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "NEG_ID_NEGOCIO", "EJS_ID_EST_JUR_SUB", "TPL_ID_TP_LITIGIO", "LIT_NRO_PROCESO", "LIT_DESCRIPCION", "LIT_BPO", "LIT_FECHA_INICIO", "LIT_FECHA_NOTIFICACION", "LIT_USR_REGISTRA", "LIT_FECHA_PRESENTACION", "LIT_HORA_PRESENTACION", "LIT_FECHA_CIERRE", "LIT_ACUERDO", "LIT_RELEVANTE", "LIT_HON_CONTADOR", "LIT_HON_JURIDICO", "LIT_OBSERVACIONES", "TRI_ID_TRIBUNAL", "TRE_ID_RECURRENCIA", "EJU_ID_EST_JURIDICO", "TFA_ID_TP_FASE", "TST_ID_TP_STATUS", "TSD_ID_TP_STA_DET", "TMO_ID_TP_MOTIVO", "STD_ID_COUNTRY", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "LIT_ABOGADO_RESPONSABLE", "LIT_VALOR_TOTAL", "LIT_CK_AVAL", "LIT_CK_MINUTA", "STD_ID_GEO_PLACE", "TRC_ID_TP_RECLAMO", "TFL_ID_TP_FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_ID_LEGADO", "LIT_JUEZ", "LIT_PAZ_Y_SVC") FROM stdin;
    SLL          SLL    false    287   ��      n          0    24947    M4SLL_LIT_HECHOS 
   TABLE DATA           
  COPY "SLL"."M4SLL_LIT_HECHOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIH_SECUENCIA", "LIH_HECHO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIH_DT_INICIAL", "LIH_DT_FINAL", "LIH_SALARIO_PERIODO", "LIH_CK_AFILIACION_SINDICATO", "LIH_DESC_SINDICATO") FROM stdin;
    SLL          SLL    false    279   ��      o          0    24953    M4SLL_LIT_HECHOS_BKP 
   TABLE DATA             COPY "SLL"."M4SLL_LIT_HECHOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIH_SECUENCIA", "LIH_HECHO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIH_DT_INICIAL", "LIH_DT_FINAL", "LIH_SALARIO_PERIODO", "LIH_CK_AFILIACION_SINDICATO", "LIH_DESC_SINDICATO") FROM stdin;
    SLL          SLL    false    280   ��      w          0    24998    M4SLL_LIT_SEGUIMIE 
   TABLE DATA           �   COPY "SLL"."M4SLL_LIT_SEGUIMIE" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIS_SECUENCIA", "LIS_SEGUIMIENTO", "STD_ID_PERSON", "LIS_FECHA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    288    �      x          0    25004    M4SLL_LIT_VINCULAD 
   TABLE DATA           �   COPY "SLL"."M4SLL_LIT_VINCULAD" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "LIV_SECUENCIA", "LIV_ID_LITIGIO", "LIV_OBSERVACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    289   �      ~          0    25025    M4SLL_MATRIZ_PREDI 
   TABLE DATA           >  COPY "SLL"."M4SLL_MATRIZ_PREDI" ("ID_ORGANIZATION", "MPR_ANIO", "MPR_MES", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "MPR_VALOR_TOTAL", "MPR_VALOR_PED_TOTAL", "MPR_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    295   :�      y          0    25010    M4SLL_MATRIZ_PRE_C 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_C" ("ID_ORGANIZATION", "MPC_SECUENCIA", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    290   W�      z          0    25013    M4SLL_MATRIZ_PRE_C_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_C_BKP" ("ID_ORGANIZATION", "MPC_SECUENCIA", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    291   t�      {          0    25016    M4SLL_MATRIZ_PRE_C_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" ("ID_ORGANIZATION", "MPC_SECUENCIA", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    292   ��      |          0    25019    M4SLL_MATRIZ_PRE_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_D" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "MPD_VALOR_TOTAL", "MPD_VALOR_PED_TOTAL", "MPD_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    293   ��      }          0    25022    M4SLL_MATRIZ_PRE_D_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_D_BKP" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "MPD_VALOR_TOTAL", "MPD_VALOR_PED_TOTAL", "MPD_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    294   ��                0    25028    M4SLL_MATRIZ_PRE_D_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "MPD_VALOR_TOTAL", "MPD_VALOR_PED_TOTAL", "MPD_CANTIDAD_EXPEDIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    296   ��      �          0    25031    M4SLL_MATRIZ_PRE_PARAM 
   TABLE DATA           y   COPY "SLL"."M4SLL_MATRIZ_PRE_PARAM" ("MPP_ID_ORDEN", "MPP_PARAM_CAMPO", "MPP_CAMPO_DESAGRUPAR", "MPP_WHERE") FROM stdin;
    SLL          SLL    false    297   �      �          0    25037    M4SLL_MEDIO_PAGOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MEDIO_PAGOS" ("ID_ORGANIZATION", "MEP_ID_MEDIO_PAGO", "MEP_NM_MEDIO_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MEP_DT_START", "MEP_DT_END") FROM stdin;
    SLL          SLL    false    298   "�      �          0    25042    M4SLL_MODULO_ROL 
   TABLE DATA           �   COPY "SLL"."M4SLL_MODULO_ROL" ("ID_ORGANIZATION", "MOR_SECUENCIA", "MTM_ID_MODULO", "MRA_ID_ROL_ACTOR", "MOR_CAMPO", "MOR_TABLA", "MOR_FUNCION", "MOR_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    299   ?�      �          0    25061    M4SLL_MTO_COD_ALT 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_COD_ALT" ("ID_ORGANIZATION", "MCA_ID_CODIGO_ALTERNO", "MCA_NM_CODIGO_ALTERNO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MCA_DT_END", "MCA_DT_START") FROM stdin;
    SLL          SLL    false    302   \�      �          0    25066    M4SLL_MTO_COD_ALT_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_COD_ALT_BKP" ("ID_ORGANIZATION", "MCA_ID_CODIGO_ALTERNO", "MCA_NM_CODIGO_ALTERNO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    303   y�      �          0    25069    M4SLL_MTO_CONCEPTO 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_CONCEPTO" ("ID_ORGANIZATION", "MCO_ID_CONCEPTO", "MCO_NM_CONCEPTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    304   ��      �          0    25075    M4SLL_MTO_DET_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_DET_PROV" ("ID_ORGANIZATION", "MDP_ID_DET_PROVISION", "MDP_NM_DET_PROVISION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MDP_CUENTA_DEBE", "MDP_CUENTA_HABER", "MDP_DT_START", "MDP_DT_END") FROM stdin;
    SLL          SLL    false    305   ��      �          0    25080    M4SLL_MTO_DET_PROV_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_DET_PROV_BKP" ("ID_ORGANIZATION", "MDP_ID_DET_PROVISION", "MDP_NM_DET_PROVISION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MDP_CUENTA_DEBE", "MDP_CUENTA_HABER") FROM stdin;
    SLL          SLL    false    306   ��      �          0    25083    M4SLL_MTO_EMP_ORG 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_EMP_ORG" ("ID_ORGANIZATION", "STD_ID_LEG_ENT", "ORG_ID", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MEO_DT_START", "MEO_DT_END") FROM stdin;
    SLL          SLL    false    307   ��      �          0    25088    M4SLL_MTO_ESTADOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_ESTADOS" ("ID_ORGANIZATION", "MOR_ESTADO", "MTE_NM_ESTADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    308   
�      �          0    25094    M4SLL_MTO_EST_EJE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_EST_EJE" ("ID_ORGANIZATION", "MEE_ID_EST_EJECUCION", "MEE_NM_EST_EJECUCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    309   '�      �          0    25097    M4SLL_MTO_EST_TARE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_EST_TARE" ("ID_ORGANIZATION", "MET_ID_EST_TAREA", "MET_NM_EST_TAREA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    310   D�      �          0    25100    M4SLL_MTO_FUNCION 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_FUNCION" ("ID_ORGANIZATION", "MOR_FUNCION", "MTF_NM_FUNCION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    311   a�      �          0    25106    M4SLL_MTO_MATERIA 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_MATERIA" ("ID_ORGANIZATION", "MMA_ID_MATERIA", "MMA_NM_MATERIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MMA_DT_START", "MMA_DT_END") FROM stdin;
    SLL          SLL    false    312   ~�      �          0    25111    M4SLL_MTO_MODULOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_MODULOS" ("ID_ORGANIZATION", "MTM_ID_MODULO", "MTM_NM_MODULO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MTM_ID_MOD_PADRE") FROM stdin;
    SLL          SLL    false    313   ��      �          0    25114    M4SLL_MTO_PEDIDO_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_PEDIDO_D" ("ID_ORGANIZATION", "MPD_ID_PEDIDO_DETALLE", "MPD_NM_PEDIDO_DETALLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "MPD_DT_START", "MPD_DT_END", "MPD_PAGO_NOMINA_DET_S_N") FROM stdin;
    SLL          SLL    false    314   ��      �          0    25119    M4SLL_MTO_RIESGOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_RIESGOS" ("ID_ORGANIZATION", "MRI_ID_RIESGO", "MRI_NM_RIESGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MRI_DT_START", "MRI_DT_END") FROM stdin;
    SLL          SLL    false    315   ��      �          0    25124    M4SLL_MTO_RIESGOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_RIESGOS_BKP" ("ID_ORGANIZATION", "MRI_ID_RIESGO", "MRI_NM_RIESGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    316   ��      �          0    25127    M4SLL_MTO_ROL_ACTO 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_ROL_ACTO" ("ID_ORGANIZATION", "MRA_ID_ROL_ACTOR", "MRA_NM_ROL_ACTOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    317   �      �          0    25130    M4SLL_MTO_SEG_INTE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_SEG_INTE" ("ID_ORGANIZATION", "ID_APP_ROLE", "MSI_SECUENCIA", "MSI_DT_START", "MSI_DT_END", "MSI_COLUMNA", "MSI_TABLA", "MSI_VALOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MTM_ID_MODULO") FROM stdin;
    SLL          SLL    false    318   ,�      �          0    25136    M4SLL_MTO_TAR_CIE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_TAR_CIE" ("ID_ORGANIZATION", "MTC_ID_TAREA", "MTC_NM_TAREA", "MTC_NM_PROCEDIMIENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    319   I�      �          0    25142    M4SLL_MTO_TP_EMPLE 
   TABLE DATA           �   COPY "SLL"."M4SLL_MTO_TP_EMPLE" ("ID_ORGANIZATION", "MTE_ID_TP_EMPLEADO", "MTE_NM_TP_EMPLEADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MTE_DT_START", "MTE_DT_END") FROM stdin;
    SLL          SLL    false    320   f�      �          0    25048    M4SLL_MT_ABOGADOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_MT_ABOGADOS" ("ID_ORGANIZATION", "MAB_SECUENCIA", "MAB_NOMBRE", "MAB_APELLIDO", "MAB_EMAIL", "MAB_CHK_INT", "STD_ID_PERSON", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "MAB_DT_END", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MAB_DT_START", "MAB_N_CEDULA", "MAB_N_TARJ_PROF", "MAB_TELEFONO", "MAB_CELULAR", "MAB_DOMICILIO", "MAB_EMPRESA", "MAB_NIT", "MAB_DT_INICIO_CONTRATO", "MAB_DT_FIN_CONTRATO", "MAB_TIPO_VINCULACION", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE") FROM stdin;
    SLL          SLL    false    300   ��      �          0    25055    M4SLL_MT_ABOGADOS_BKP 
   TABLE DATA             COPY "SLL"."M4SLL_MT_ABOGADOS_BKP" ("ID_ORGANIZATION", "MAB_SECUENCIA", "MAB_NOMBRE", "MAB_APELLIDO", "MAB_EMAIL", "MAB_CHK_INT", "STD_ID_PERSON", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "STD_ID_LEG_ENT", "MAB_DT_END", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    301   ��      �          0    25147    M4SLL_MT_ST_RE_PRO 
   TABLE DATA           �   COPY "SLL"."M4SLL_MT_ST_RE_PRO" ("ID_ORGANIZATION", "MSR_ID_STATUS_REPORTE", "MSR_NM_STATUS_REPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MSR_DT_START", "MSR_DT_END") FROM stdin;
    SLL          SLL    false    321   ��      �          0    25152    M4SLL_NEGOCIOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "NEG_NM_NEGOCIO", "LIT_CENTRO_COSTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "NEG_DIVISION") FROM stdin;
    SLL          SLL    false    322   ��      �          0    25155    M4SLL_NEGOCIOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS_BKP" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "NEG_NM_NEGOCIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "LIT_CENTRO_COSTO") FROM stdin;
    SLL          SLL    false    323   ��      �          0    25158    M4SLL_NEGOCIOS_PRUEBA_GABY 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "NEG_NM_NEGOCIO", "LIT_CENTRO_COSTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    324   �      �          0    25161    M4SLL_NEGOCIOS_ROL 
   TABLE DATA           �   COPY "SLL"."M4SLL_NEGOCIOS_ROL" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO", "ID_APP_ROLE", "SNR_CHK_SELECT", "SNR_CHK_INSERT", "SNR_CHK_UPDATE", "SNR_CHK_DELETE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    325   1�      �          0    25164    M4SLL_PAGOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_PAGOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "TSP_ID_SALIDA_PAGO", "DCP_SECUENCIA", "MEP_ID_MEDIO_PAGO", "STP_ID_STATUS_PAGO", "TPA_ID_PAGO", "PAG_VALOR", "PAG_FEC_EST", "PAG_FEC_VTO", "PAG_FEC_APR", "PAG_FEC_ERP", "PAG_FEC_PAG", "PAG_DESCRIPCION", "PAG_DOCUMENTO", "PAG_COMBINACION", "PAG_CK_COMB", "PAG_CK_RECUPERADO", "PAG_CK_SOLICITADO", "PAG_FECHA", "PAG_COMPROBANTE", "PAG_NRO_IDENTIFICACION", "PAG_TIPO_CUENTA_DESTNO", "PAG_NRO_CUENTA_DESTINO", "PAG_DESTINATARIO", "PAG_EMAIL_DESTINATARIO", "PAG_NRO_SOLICITUD", "PAG_CODIGO_IBAN", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "PAG_DESCRIPCION_DOC") FROM stdin;
    SLL          SLL    false    326   N�      �          0    25170    M4SLL_PAGOS_BKP 
   TABLE DATA           �  COPY "SLL"."M4SLL_PAGOS_BKP" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "TSP_ID_SALIDA_PAGO", "DCP_SECUENCIA", "MEP_ID_MEDIO_PAGO", "STP_ID_STATUS_PAGO", "TPA_ID_PAGO", "PAG_VALOR", "PAG_FEC_EST", "PAG_FEC_VTO", "PAG_FEC_APR", "PAG_FEC_ERP", "PAG_FEC_PAG", "PAG_DESCRIPCION", "PAG_DOCUMENTO", "PAG_COMBINACION", "PAG_CK_COMB", "PAG_CK_RECUPERADO", "PAG_CK_SOLICITADO", "PAG_FECHA", "PAG_COMPROBANTE", "PAG_NRO_IDENTIFICACION", "PAG_TIPO_CUENTA_DESTNO", "PAG_NRO_CUENTA_DESTINO", "PAG_DESTINATARIO", "PAG_EMAIL_DESTINATARIO", "PAG_NRO_SOLICITUD", "PAG_CODIGO_IBAN", "PAG_DESCRIPCION_DOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    327   k�      �          0    25182    M4SLL_PAGOS_NOMINA 
   TABLE DATA           �  COPY "SLL"."M4SLL_PAGOS_NOMINA" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PNO_LOTE", "TPA_ID_PAGO", "PNO_VALOR", "PNO_FECHA", "PNO_FECHA_VENCIMIENTO", "PNO_PRINCIPAL_S_N", "PNO_INTERESES", "PNO_ANTIGUEDAD_RECONOCIDA", "PNO_FECHA_IMPUTACION_DESDE", "PNO_FECHA_IMPUTACION_HASTA", "PNO_ADJUNTA_VIDA_LABORAL", "PNO_FECHA_REINCORPORACION", "PNO_APLICA_SAL_DIA_HASTA_RES_R", "PNO_SALARIO_DIA", "PNO_FECHA_INICIO_SANCION", "PNO_FECHA_FIN_SANCION", "PNO_DIAS_SANCIONADO", "PNO_COTIZACION", "SSP_ID_CABEC_TC1", "PNO_RECONOCIMIENTO_DERECHO", "PNO_CUENTA_ABONO", "PNO_CODIGO_IBAN", "PNO_OTRAS_CUENTAS", "PNO_NRO_CUENTA_JUZGADO", "PNO_BENEFICIARIO", "IPN_IMPORTE_TRANSFERIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "IPN_RETENCION_JUDICIAL", "IPN_IMPORTE_BRUTO", "IPN_DESCUENTOS_S_S", "IPN_DESCUENTOS_IRPF", "IPN_FECHA_TRANSFERENCIA", "PNO_FECHA_ENVIO_NOMINA", "PNO_APLI_SANCION_S_N", "PNO_LETRA_JUZGADO", "PNO_COD_IBAN_GENE", "PNO_NRO_EXP", "PNO_NETO_S_N") FROM stdin;
    SLL          SLL    false    329   ��      �          0    25176    M4SLL_PAGOS_NOM_D 
   TABLE DATA           �   COPY "SLL"."M4SLL_PAGOS_NOM_D" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "MCO_ID_CONCEPTO", "PND_FECHA_DESDE", "PND_FECHA_HASTA", "PND_IMPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "MCO_NM_CONCEPTO") FROM stdin;
    SLL          SLL    false    328   ��      �          0    25188    M4SLL_PAGOS_TRN 
   TABLE DATA           �   COPY "SLL"."M4SLL_PAGOS_TRN" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "PAG_SECUENCIA", "STP_ID_STATUS_PAGO", "NROCBTE", "NRODOC", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    330   ��      �          0    25191    M4SLL_PARAMETRICA 
   TABLE DATA           �   COPY "SLL"."M4SLL_PARAMETRICA" ("ID_ORGANIZATION", "PAR_SECUENCIA", "PAR_NM_CORTO", "PAR_NM_LARGO", "PAR_VAL_NUMBER", "PAR_VAL_DATE", "PAR_VAL_CHAR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    331   ��      �          0    25197    M4SLL_PARAM_USR 
   TABLE DATA           g   COPY "SLL"."M4SLL_PARAM_USR" ("USUARIO", "PAGINA", "FILTRO", "JSON", "CONSULTA", "ACCION") FROM stdin;
    SLL          SLL    false    332   ��      �          0    25209    M4SLL_PEDIDOS 
   TABLE DATA             COPY "SLL"."M4SLL_PEDIDOS" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "PED_SECUENCIA", "PED_VALOR", "PED_OBSERVACION", "PED_SUB_PEDIDO", "PED_PRINCIPAL_S_N", "PED_PERIODO", "PED_VALOR_RECARGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    334   �      �          0    25215    M4SLL_PEDIDOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_PEDIDOS_BKP" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "PED_SECUENCIA", "PED_VALOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "PED_OBSERVACION", "PED_SUB_PEDIDO", "PED_PRINCIPAL_S_N") FROM stdin;
    SLL          SLL    false    335   6�      �          0    25221    M4SLL_PEDIDOS_PRUEBA_GABY 
   TABLE DATA             COPY "SLL"."M4SLL_PEDIDOS_PRUEBA_GABY" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "PED_SECUENCIA", "PED_VALOR", "PED_OBSERVACION", "PED_SUB_PEDIDO", "PED_PRINCIPAL_S_N", "PED_PERIODO", "PED_VALOR_RECARGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    336   S�      �          0    25203    M4SLL_PEDIDO_DET 
   TABLE DATA           �   COPY "SLL"."M4SLL_PEDIDO_DET" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPE_ID_PEDIDO", "PDE_SECUENCIA", "MPD_ID_PEDIDO_DETALLE", "PDE_OBSERRVACION", "CLO_ID_CLIENTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    333   p�      �          0    25227    M4SLL_PERSONA_EXT 
   TABLE DATA           !  COPY "SLL"."M4SLL_PERSONA_EXT" ("ID_ORGANIZATION", "PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "PEX_ID_PERSONA_EXT", "PEX_NOMBRE", "PEX_APELLIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "PEX_DT_END", "PEX_DT_START", "PEX_NEGOCIO", "PEX_EMPRESA", "PEX_TP_EMPLEADO") FROM stdin;
    SLL          SLL    false    337   ��      �          0    25235    M4SLL_PERSONA_EXT_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_PERSONA_EXT_BKP" ("ID_ORGANIZATION", "PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "PEX_ID_PERSONA_EXT", "PEX_NOMBRE", "PEX_APELLIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    338   ��      �          0    25241    M4SLL_PERSONA_EXT_QA 
   TABLE DATA           �   COPY "SLL"."M4SLL_PERSONA_EXT_QA" ("ID_ORGANIZATION", "PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "PEX_ID_PERSONA_EXT", "PEX_NOMBRE", "PEX_APELLIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    339   ��      �          0    25247    M4SLL_PROV_ABOGADO 
   TABLE DATA           �   COPY "SLL"."M4SLL_PROV_ABOGADO" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "MAB_SECUENCIA", "PRA_SECUENCIA", "PRA_MONTO", "PRA_PORC_PROV_MES", "PRA_MONTO_PROV", "PRA_DT_ALTA", "PRA_OBSERVACIONES", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    340   ��      �          0    25250    M4SLL_REGION 
   TABLE DATA           �   COPY "SLL"."M4SLL_REGION" ("ID_ORGANIZATION", "REG_SECUENCIA", "REG_ID_REGION", "STD_ID_GEO_DIV", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "NEG_ID_NEGOCIO", "STD_ID_LEG_ENT") FROM stdin;
    SLL          SLL    false    341   �      �          0    25259    M4SLL_ROLES_USRS 
   TABLE DATA           �   COPY "SLL"."M4SLL_ROLES_USRS" ("ID_ORGANIZATION", "ID_APP_ROLE", "TPR_ID_TP_ROL", "EJU_ID_EST_JURIDICO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    344   �      �          0    25253    M4SLL_ROL_ACT_ROLE 
   TABLE DATA           �   COPY "SLL"."M4SLL_ROL_ACT_ROLE" ("ID_ORGANIZATION", "MRA_ID_ROL_ACTOR", "ID_APP_ROLE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    342   ;�      �          0    25256    M4SLL_ROL_APROBS 
   TABLE DATA           �   COPY "SLL"."M4SLL_ROL_APROBS" ("ID_ORGANIZATION", "ID_APP_ROLE", "ROA_VAL_MINIMO", "ROA_VAL_MAXIMO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    343   X�      �          0    25262    M4SLL_RP_CB_LITIGI 
   TABLE DATA           �  COPY "SLL"."M4SLL_RP_CB_LITIGI" ("ID_ORGANIZATION", "RCL_MES", "RCL_ANIO", "RCL_CARPET_ID", "RCL_NO", "RCL_MONTO_PREV_CAUSAS_M1", "RCL_MONTO_PREV_HONORARIOS_M1", "RCL_CARPET_CARATULA", "RCL_ESTJUI_DESCRIPCION", "RCL_MONTO_CAUSA", "RCL_PREVISION_CONDENA", "RCL_FEC_DE_ALTA_PREV_CONDENA", "RCL_MONTO_PREVISIONADO_CAUSA", "RCL_VARIACION_CAUSA", "RCL_OBSERVACIONES", "RCL_HONORIOS_Y_COSTAS", "RCL_PROVISION_HONORARIOS", "RCL_FEC_DE_ALTA_PREV_HONORARIO", "RCL_MONTO_PREV_HONORARIOS", "RCL_VARIACION_HONORARIOS", "RCL_OBSERV_HONORARIOS", "RCL_JURISDICCION", "RCL_JUZGADO", "RCL_CARPET_FECESTIMTERMINACION", "RCL_CONTIN_DESCRIPCION", "RCL_FECHAMONTO", "RCL_CLISEC_DESCRIPCION", "RCL_TIPO_CARPETA", "RCL_MONTOART", "RCL_ART", "RCL_LETRADOCONTRAPARTE", "RCL_ULTIMOMONTO", "RCL_ABOGADO", "RCL_PROBALIDAD", "RCL_FLEX_CONDENA", "RCL_FLEX_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    345   u�      �          0    25268    M4SLL_RP_ES_FICHER 
   TABLE DATA           U  COPY "SLL"."M4SLL_RP_ES_FICHER" ("ID_ORGANIZATION", "REFE", "USUARIO", "EMPRESA", "IDNEGOCIO", "NEGOCIO", "IDDELEGACION", "DELEGACION", "ZONALAB", "DEMANDANTE", "NIF", "CODIGO", "ANALITICA", "EMP", "CTA", "DLG", "DIV", "CECO", "TIPO_DEMANDANTE", "PERSONAL", "FECHA_ALTA", "PROV_S_N", "IMPORTE_PROVISION", "IMPORTE_PREVISTO", "TOTAL_COSTE", "IDASUNTO", "ASUNTO", "IDSUBASUNTO", "SUBASUNTO", "FECHA_DESPIDO_DEMANDA", "FECHA_CONCILIACION", "IDRESULTADO_CONCILIACION", "RESULTADO_CONCILIACION", "FECHA_JUZGADO", "NRO_AUTOS", "IDRESULTADO", "RESULTADO", "TRIB_SUPERIOR_FECHA", "IDTRIB_SUPERIOR_RESULTADO", "TRIB_SUPERIOR_RESULTADO", "TRIB_SUPREMO_FECHA", "IDTRIB_SUPREMO_RESULTADO", "TRIB_SUPREMO_RESULTADO", "FECHA_ESTADO", "IDESTADO_FINAL", "ESTADO_FINAL", "IDABOGADO", "ABOGADO", "OBSERVACIONES", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    346   ��      �          0    25274    M4SLL_RP_ES_LITIGI 
   TABLE DATA             COPY "SLL"."M4SLL_RP_ES_LITIGI" ("ID_ORGANIZATION", "REL_USUARIO", "REL_SECUENCIA", "REL_ID_LITIGIO", "REL_ID_LEGADO", "REL_EMPRESA", "REL_NEGOCIO", "REL_CIUDAD", "REL_DELEGACION", "REL_ZONA_LABORAL", "REL_DEMANDANTE", "REL_DEMANDANTE_NIF", "REL_DEMANDANTE_LEGAJO", "REL_COMBINACION_ANALITICA", "REL_TIPO_DEMANDANTE", "REL_TIPO_PERSONA", "REL_FECHA_ALTA", "REL_IMPORTE_PREVISTO", "REL_ASUNTO", "REL_ASUNTOS_SECUNDARIOS", "REL_SUBASUNTO", "REL_FECHA_DEMANDA", "REL_NRO_AUTO", "REL_FECHA_CONCILIACION", "REL_FASE_RESUL_CON", "REL_FECHA_JUZGADO", "REL_RESULTADO_JUZGADO", "REL_FECHA_TRIBUNAL_SUPERIOR", "REL_RESULTADO_TRI_SUPERIOR", "REL_FECHA_TRIBUNAL_SUPREMO", "REL_RESULTADO_TRI_SUPREMO", "REL_COSTO_TOTAL", "REL_FECHA_ESTADO", "REL_ESTADO_CIERRE", "REL_ABOGADO_RESPONSABLE", "REL_OBSERVACION", "REL_SUBASUNTOS_SECUNDARIOS", "REL_FECHA_NOTIFICACION", "REL_VALOR_RECARGO", "REL_FECHA_CIERRE", "REL_MATERIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "REL_FECHA_ACTUALIZACION", "REL_EMP_LIT", "REL_EST_FINAL", "REL_CLIENTE") FROM stdin;
    SLL          SLL    false    347   ��      �          0    25280    M4SLL_RP_ES_PROVIS 
   TABLE DATA             COPY "SLL"."M4SLL_RP_ES_PROVIS" ("ID_ORGANIZATION", "REL_USUARIO", "REL_SECUENCIA", "REL_ID_LITIGIO", "REL_EMPRESA", "REL_NEGOCIO", "REL_CIUDAD", "REL_DELEGACION", "REL_ZONA_LABORAL", "REL_DEMANDANTE", "REL_DEMANDANTE_NIF", "REL_DEMANDANTE_LEGAJO", "REL_COMBINACION_ANALITICA", "REL_ID_REGION", "REL_TIPO_DEMANDANTE", "REL_TIPO_PERSONA", "REL_FECHA_ALTA", "REL_IMPORTE_PREVISTO", "REL_ASUNTO", "REL_ASUNTOS_SECUNDARIOS", "REL_SUBASUNTO", "REL_FECHA_DEMANDA", "REL_NRO_AUTO", "REL_FECHA_CONCILIACION", "REL_FASE_RESUL_CON", "REL_FECHA_JUZGADO", "REL_RESULTADO_JUZGADO", "REL_FECHA_TRIBUNAL_SUPERIOR", "REL_RESULTADO_TRI_SUPERIOR", "REL_FECHA_TRIBUNAL_SUPREMO", "REL_RESULTADO_TRI_SUPREMO", "REL_COSTO_TOTAL", "REL_FECHA_ESTADO", "REL_ESTADO_CIERRE", "REL_ABOGADO_RESPONSABLE", "REL_OBSERVACION", "REL_SUBASUNTOS_SECUNDARIOS", "REL_FECHA_NOTIFICACION", "REL_VALOR_RECARGO", "REL_FECHA_CIERRE", "REL_MATERIA", "REL_ID_DIVISION", "REL_IMPORTE_PROVISION", "REL_ID_LEG_ENT", "REL_ID_LEGADO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    348   ��      �          0    25286    M4SLL_SEGURIDAD 
   TABLE DATA           �   COPY "SLL"."M4SLL_SEGURIDAD" ("ID_ORGANIZATION", "ID_APP_ROLE", "SS_SECUENCIAL", "SS_SQL", "SS_CHK_SELECT", "SS_CHK_UPDATE", "SS_CHK_INSERT", "SS_CHK_DELETE", "SS_CHK_CLIENTE_OBM", "SS_CHK_DTI", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    349   ��      �          0    25295    M4SLL_SEGURIDAD2 
   TABLE DATA           �   COPY "SLL"."M4SLL_SEGURIDAD2" ("ID_ORGANIZATION", "ID_APP_ROLE", "SS_SECUENCIAL", "SS_SQL", "SS_CHK_SELECT", "SS_CHK_UPDATE", "SS_CHK_INSERT", "SS_CHK_DELETE", "SS_CHK_CLIENTE_OBM", "SS_CHK_DTI", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    351   �      �          0    25292    M4SLL_SEGURIDAD_VI 
   TABLE DATA           �   COPY "SLL"."M4SLL_SEGURIDAD_VI" ("ID_ORGANIZATION", "ID_APP_ROLE", "SSV_ID_MODULO", "SSV_CHK_VER", "SSV_CHK_GUARDAR", "SSV_CHK_MODIFICAR", "SSV_CHK_ELIMINAR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    350   #�      �          0    25301    M4SLL_SGD_CONFIG 
   TABLE DATA           u  COPY "SLL"."M4SLL_SGD_CONFIG" ("ID_ORGANIZATION", "SGDC_CONTEXT", "SGDC_ENDPOINT", "SGDC_MAIN_CLASS", "SGDC_TOKEN_SECURITY", "SGDC_COUNTRY", "SGDC_METHOD_GET_DO", "SGCD_METHOD_DEL_DOCUMENTS", "SGDC_METHOD_OBTAIN_DOCUMENT", "SGDC_METHOD_SAVE_DOCUMENT", "SGDC_ATTRIBUTES", "SGDC_VAL_ATTRIBUTES", "SGDC_TP_DOCUMENTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    352   @�      �          0    25307    M4SLL_STATUS_PAGOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_STATUS_PAGOS" ("ID_ORGANIZATION", "STP_ID_STATUS_PAGO", "STP_NM_STATUS_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    353   ]�      �          0    25310    M4SLL_ST_REPO_PROV 
   TABLE DATA           �   COPY "SLL"."M4SLL_ST_REPO_PROV" ("ID_ORGANIZATION", "SSR_PERIODO", "MSR_ID_STATUS_REPORTE", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "SRP_APROBACION_G", "SRP_APROBACION_D") FROM stdin;
    SLL          SLL    false    354   z�      �          0    25313    M4SLL_TOTHONJ 
   TABLE DATA           �   COPY "SLL"."M4SLL_TOTHONJ" ("ID_ORGANIZATION", "TNJ_ANIO", "TNJ_MES", "MAB_SECUENCIA", "TNJ_MONTO_A", "TNJ_MONTO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    355   ��      �          0    25316    M4SLL_TOTPEDHIS 
   TABLE DATA           �  COPY "SLL"."M4SLL_TOTPEDHIS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPH_MES", "TPH_ANIO", "TPE_ID_PEDIDO", "STD_ID_LEG_ENT", "EJU_ID_EST_JURIDICO", "TPH_AUTOR", "TPH_REU", "LIT_NRO_PROCESO", "TRI_ID_TRIBUNAL", "TPH_VALOR_DEMANDA", "TPH_VALOR_DEM_INTERES", "TPH_VALOR_DEM_COR_MON", "TPH_VALOR_DEM_ACT", "TPH_VAL_RIESGO", "TPH_VALOR_PROVISION", "TPH_PAGOS", "TST_ID_TP_STATUS", "TPH_VAL_HON_JURIDICO", "TPH_VAL_PREMIO_JURIDICO", "TPH_VAL_TOTAL_HON_JUR", "TPH_AUTOR_RUN", "TPH_AUTOR_CAUSAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPH_VALOR_CONDENA", "TPH_PORC_PROV_CONDENA", "TPH_VALOR_PROV_CONDENA", "TPH_VALOR_HON", "TPH_PORC_PROV_HON", "TPH_VALOR_PROV_HON") FROM stdin;
    SLL          SLL    false    356   ��      �          0    25322    M4SLL_TP_AUTOR_REU 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_AUTOR_REU" ("ID_ORGANIZATION", "TAR_ID_TP_AUTOR_REU", "TAR_NM_TP_AUTOR_REU", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TAR_DT_START", "TAR_DT_END") FROM stdin;
    SLL          SLL    false    357   ��      �          0    25327    M4SLL_TP_AUTOR_REU_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_AUTOR_REU_BKP" ("ID_ORGANIZATION", "TAR_ID_TP_AUTOR_REU", "TAR_NM_TP_AUTOR_REU", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    358   ��      �          0    25330    M4SLL_TP_COMPROMIS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_COMPROMIS" ("ID_ORGANIZATION", "TCO_ID_TP_COMPROMISO", "TPL_ID_TP_LITIGIO", "TCO_NM_TP_COMPROMISO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TCO_DT_VALIDEZ", "TCO_DT_START", "TCO_DT_END") FROM stdin;
    SLL          SLL    false    359   �      �          0    25335    M4SLL_TP_COMPROMIS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_COMPROMIS_BKP" ("ID_ORGANIZATION", "TCO_ID_TP_COMPROMISO", "TPL_ID_TP_LITIGIO", "TCO_NM_TP_COMPROMISO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TCO_DT_VALIDEZ") FROM stdin;
    SLL          SLL    false    360   (�      �          0    25338    M4SLL_TP_DOC_LITIG 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_DOC_LITIG" ("ID_ORGANIZATION", "TDL_ID_TP_DOC_LITIGIO", "TDL_NM_TP_DOC_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TDL_DT_END", "TDL_DT_START") FROM stdin;
    SLL          SLL    false    361   E�      �          0    25343    M4SLL_TP_DOC_LITIG_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_DOC_LITIG_BKP" ("ID_ORGANIZATION", "TDL_ID_TP_DOC_LITIGIO", "TDL_NM_TP_DOC_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    362   b�      �          0    25346    M4SLL_TP_ENTIDADES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_ENTIDADES" ("ID_ORGANIZATION", "TPE_ID_TP_ENTIDAD", "TPE_NM_TP_ENTIDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TPE_DT_START", "TPE_DT_END") FROM stdin;
    SLL          SLL    false    363   �      �          0    25351    M4SLL_TP_ENTIDADES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_ENTIDADES_BKP" ("ID_ORGANIZATION", "TPE_ID_TP_ENTIDAD", "TPE_NM_TP_ENTIDAD", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    364   ��      �          0    25354    M4SLL_TP_FALTAS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_FALTAS" ("ID_ORGANIZATION", "TFL_ID_TP_FALTA", "TFL_NM_TP__FALTA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TFL_DT_START", "TFL_DT_END") FROM stdin;
    SLL          SLL    false    365   ��      �          0    25359    M4SLL_TP_FASES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_FASES" ("ID_ORGANIZATION", "TFA_ID_TP_FASE", "TFA_NM_TP_FASE", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TFA_DT_START", "TFA_DT_END") FROM stdin;
    SLL          SLL    false    366   ��      �          0    25364    M4SLL_TP_FASES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_FASES_BKP" ("ID_ORGANIZATION", "TFA_ID_TP_FASE", "TFA_NM_TP_FASE", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    367   ��      �          0    25367    M4SLL_TP_IDENTIFIC 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_IDENTIFIC" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "TPI_NM_TP_IDENTIFICACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPI_DT_START", "TPI_DT_END") FROM stdin;
    SLL          SLL    false    368   �      �          0    25372    M4SLL_TP_IDENTIFIC_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_IDENTIFIC_BKP" ("ID_ORGANIZATION", "TPI_ID_TP_IDENTIFICACION", "TPI_NM_TP_IDENTIFICACION", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    369   -�      �          0    25375    M4SLL_TP_LITIGIOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_LITIGIOS" ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPL_NM_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_DT_START", "TPL_DT_END") FROM stdin;
    SLL          SLL    false    370   J�      �          0    25380    M4SLL_TP_LITIGIOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_LITIGIOS_BKP" ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPL_NM_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    371   g�      �          0    25383    M4SLL_TP_MOTIVO 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_MOTIVO" ("ID_ORGANIZATION", "TMO_ID_TP_MOTIVO", "TMO_NM_TP_MOTIVO", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TMO_DT_START", "TMO_DT_END") FROM stdin;
    SLL          SLL    false    372   ��      �          0    25388    M4SLL_TP_PAGOS 
   TABLE DATA           (  COPY "SLL"."M4SLL_TP_PAGOS" ("ID_ORGANIZATION", "TPA_ID_PAGO", "TPA_NM_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPA_NUMERO_CUENTA", "TPL_ID_TP_LITIGIO", "TPA_VENDOR_ID", "TPA_VENDOR_SITE_ID", "VENDOR_NAME", "TPA_NOMINA_S_N", "TPA_CONCEPTO", "TPA_DT_START", "TPA_DT_END") FROM stdin;
    SLL          SLL    false    373   ��      �          0    25396    M4SLL_TP_PAGOS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_PAGOS_BKP" ("ID_ORGANIZATION", "TPA_ID_PAGO", "TPA_NM_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPA_NUMERO_CUENTA", "TPL_ID_TP_LITIGIO", "TPA_VENDOR_ID", "TPA_VENDOR_SITE_ID", "VENDOR_NAME") FROM stdin;
    SLL          SLL    false    374   ��      �          0    25402    M4SLL_TP_PEDIDO 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_PEDIDO" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "TPE_NM_PEDIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TPE_PROVISIONA_S_N", "TPE_DT_END", "TPE_DT_START") FROM stdin;
    SLL          SLL    false    375   ��      �          0    25406    M4SLL_TP_PEDIDO_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_PEDIDO_BKP" ("ID_ORGANIZATION", "TPE_ID_PEDIDO", "TPE_NM_PEDIDO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO") FROM stdin;
    SLL          SLL    false    376   ��      �          0    25409    M4SLL_TP_RECLAMOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_RECLAMOS" ("ID_ORGANIZATION", "TRC_ID_TP_RECLAMO", "TRC_NM_TP_RECLAMO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "TRC_DT_START", "TRC_DT_END") FROM stdin;
    SLL          SLL    false    377   �      �          0    25414    M4SLL_TP_RECURREN 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_RECURREN" ("ID_ORGANIZATION", "TRE_ID_RECURRENCIA", "TRE_NM_RECURRENCIA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TRE_DT_START", "TRE_DT_END") FROM stdin;
    SLL          SLL    false    378   2�      �          0    25419    M4SLL_TP_ROLES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_ROLES" ("ID_ORGANIZATION", "TPR_ID_TP_ROL", "TPR_NM_TP_ROL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPR_DT_START", "TPR_DT_END") FROM stdin;
    SLL          SLL    false    379   O�      �          0    25424    M4SLL_TP_SALIDA_PA 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_SALIDA_PA" ("ID_ORGANIZATION", "TSP_ID_SALIDA_PAGO", "TSP_NM_SALIDA_PAGO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TSP_DT_START", "TSP_DT_END") FROM stdin;
    SLL          SLL    false    380   l�      �          0    25434    M4SLL_TP_STATUS 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_STATUS" ("ID_ORGANIZATION", "TST_ID_TP_STATUS", "TPL_ID_TP_LITIGIO", "TST_NM_TP_STATUS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TST_DT_START", "TST_DT_END") FROM stdin;
    SLL          SLL    false    382   ��      �          0    25439    M4SLL_TP_STATUS_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_STATUS_BKP" ("ID_ORGANIZATION", "TST_ID_TP_STATUS", "TPL_ID_TP_LITIGIO", "TST_NM_TP_STATUS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    383   ��      �          0    25429    M4SLL_TP_STA_DET 
   TABLE DATA           �   COPY "SLL"."M4SLL_TP_STA_DET" ("ID_ORGANIZATION", "TSD_ID_TP_STA_DET", "TSD_NM_TP_STATUS_DET", "TPL_ID_TP_LITIGIO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TSD_DT_START", "TSD_DT_END") FROM stdin;
    SLL          SLL    false    381   ��      �          0    25442    M4SLL_TRIBUNALES 
   TABLE DATA           �   COPY "SLL"."M4SLL_TRIBUNALES" ("ID_ORGANIZATION", "TRI_ID_TRIBUNAL", "TRI_NM_TRIBUNAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE", "TRI_DT_START", "TRI_DT_END") FROM stdin;
    SLL          SLL    false    384   ��      �          0    25447    M4SLL_TRIBUNALES_BKP 
   TABLE DATA           �   COPY "SLL"."M4SLL_TRIBUNALES_BKP" ("ID_ORGANIZATION", "TRI_ID_TRIBUNAL", "TRI_NM_TRIBUNAL", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "TPL_ID_TP_LITIGIO", "STD_ID_SUB_GEO_DIV", "STD_ID_GEO_PLACE") FROM stdin;
    SLL          SLL    false    385   ��      �          0    25450    M4SLL_VAL_EC_LIT 
   TABLE DATA           �  COPY "SLL"."M4SLL_VAL_EC_LIT" ("ID_ORGANIZATION", "VEL_SECUENCIA", "LIT_ID_LITIGIO", "VEL_VALOR_CONDENA", "VEL_PORC_PROV_CONDENA", "VEL_IMP_PROV_CONDENA", "VEL_VALOR_FINAL_CONDENA", "VEL_DT_IMPACTO_COND", "VEL_OBS_CONDENA", "VEL_VAL_HONORARIOS", "VEL_PORC_PROV_HONORARIOS", "VEL_IMP_PROV_HONORARIOS", "VEL_DT_IMPACTO_HONO", "VEL_OBS_HONORARIOS", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    386   �      �          0    25456    M4SLL_VAL_LITIGIOS 
   TABLE DATA           �  COPY "SLL"."M4SLL_VAL_LITIGIOS" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "VAL_SECUENCIA", "TPE_ID_PEDIDO", "VAL_FECHA", "PED_VALOR", "VAL_PED", "VAL_PED_INT", "VAL_PED_COR", "VAL_PED_ACT", "VAL_PROV", "VAL_PROV_INT", "VAL_PROV_COR", "VAL_PROV_ACT", "VAL_FECHA_BASE", "VAL_AGREGADO_POR", "VAL_RIESGO", "VAL_RIESGO_JUST", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE", "VAL_POR_PROV") FROM stdin;
    SLL          SLL    false    387   7�      �          0    25462    M4SLL_WKF_ESTADOS 
   TABLE DATA           �   COPY "SLL"."M4SLL_WKF_ESTADOS" ("ID_ORGANIZATION", "WKE_ID_ESTADO", "WKE_NM_ESTADO", "WKE_DT_START", "WKE_DT_END", "WKE_PLAZO", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    388   T�      �          0    25465    M4SLL_WKF_ROL_ESTA 
   TABLE DATA           �   COPY "SLL"."M4SLL_WKF_ROL_ESTA" ("ID_ORGANIZATION", "WKE_ID_ESTADO", "MRA_ID_ROL_ACTOR", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    389   q�      �          0    25468    M4SLL_WKF_TAR_ESTA 
   TABLE DATA           �   COPY "SLL"."M4SLL_WKF_TAR_ESTA" ("ID_ORGANIZATION", "WTE_SECUENCIA", "WKE_ID_ESTADO", "WTE_ESTADO_SIGUIENTE", "WTE_NM_TAREA", "ID_APPROLE", "ID_SECUSER", "DT_LAST_UPDATE") FROM stdin;
    SLL          SLL    false    390   ��      !          0    16455    databasechangelog 
   TABLE DATA           �   COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
    public          SLLPE    false    202   ��                 0    16450    databasechangeloglock 
   TABLE DATA           R   COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
    public          SLLPE    false    201   ��      #          0    16463    jhi_persistent_audit_event 
   TABLE DATA           a   COPY public.jhi_persistent_audit_event (event_id, principal, event_date, event_type) FROM stdin;
    public          SLLPE    false    204   �      $          0    16468    jhi_persistent_audit_evt_data 
   TABLE DATA           N   COPY public.jhi_persistent_audit_evt_data (event_id, name, value) FROM stdin;
    public          SLLPE    false    205   0�      �           0    0    sequence_generator    SEQUENCE SET     D   SELECT pg_catalog.setval('public.sequence_generator', 1050, false);
          public          SLLPE    false    203            �           2606    25482 :   M4SLL_AUTOR_REU_PRUEBA_GABY M4SLL_AUTOR_REU_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_AUTOR_REU_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA");
 g   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_AUTOR_REU_PRUEBA_GABY_PK";
       SLL            SLL    false    212    212    212            �           2606    25540 =   M4SLL_ESP_DELEGACI_PRUEBA_GABY M4SLL_ESP_DELEGACI_PRU_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_ESP_DELEGACI_PRU_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD");
 j   ALTER TABLE ONLY "SLL"."M4SLL_ESP_DELEGACI_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_ESP_DELEGACI_PRU_GABY_PK";
       SLL            SLL    false    255    255    255            �           2606    25560 6   M4SLL_INI_PARAM_CALC_PROV M4SLL_INI_PARAM_CALC_PROV_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV"
    ADD CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_PK" PRIMARY KEY ("IPAR_SECUENCIA");
 c   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV" DROP CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_PK";
       SLL            SLL    false    271            �           2606    25562 6   M4SLL_INI_PARAM_CALC_PROV M4SLL_INI_PARAM_CALC_PROV_UK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV"
    ADD CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_UK" UNIQUE ("ID_ORGANIZATION", "IPAR_PROCESO", "IPAR_NOMBRE");
 c   ALTER TABLE ONLY "SLL"."M4SLL_INI_PARAM_CALC_PROV" DROP CONSTRAINT "M4SLL_INI_PARAM_CALC_PROV_UK";
       SLL            SLL    false    271    271    271            �           2606    25568 2   M4SLL_INT_LIST_LITIGIOS M4SLL_INT_LIST_LITIGIOS_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_LIST_LITIGIOS"
    ADD CONSTRAINT "M4SLL_INT_LIST_LITIGIOS_PK" PRIMARY KEY ("LIT_ID_LITIGIO");
 _   ALTER TABLE ONLY "SLL"."M4SLL_INT_LIST_LITIGIOS" DROP CONSTRAINT "M4SLL_INT_LIST_LITIGIOS_PK";
       SLL            SLL    false    276            �           2606    25580 8   M4SLL_LITIGIOS_PRUEBA_GABY M4SLL_LITIGIOS_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_LITIGIOS_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "LIT_ID_LITIGIO");
 e   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_LITIGIOS_PRUEBA_GABY_PK";
       SLL            SLL    false    286    286                       2606    25588 =   M4SLL_MATRIZ_PRE_C_PRUEBA_GABY M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK" UNIQUE ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL");
 j   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK";
       SLL            SLL    false    292    292    292    292    292    292    292                       2606    25596 =   M4SLL_MATRIZ_PRE_D_PRUEBA_GABY M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK" UNIQUE ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA");
 j   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK";
       SLL            SLL    false    296    296    296    296                       2606    25598 0   M4SLL_MATRIZ_PRE_PARAM M4SLL_MATRIZ_PRE_PARAM_PK 
   CONSTRAINT     }   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_PARAM"
    ADD CONSTRAINT "M4SLL_MATRIZ_PRE_PARAM_PK" PRIMARY KEY ("MPP_ID_ORDEN");
 ]   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_PARAM" DROP CONSTRAINT "M4SLL_MATRIZ_PRE_PARAM_PK";
       SLL            SLL    false    297            :           2606    25642 8   M4SLL_NEGOCIOS_PRUEBA_GABY M4SLL_NEGOCIOS_PRUEBA_GABY_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY"
    ADD CONSTRAINT "M4SLL_NEGOCIOS_PRUEBA_GABY_PK" PRIMARY KEY ("ID_ORGANIZATION", "NEG_ID_NEGOCIO");
 e   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_PRUEBA_GABY" DROP CONSTRAINT "M4SLL_NEGOCIOS_PRUEBA_GABY_PK";
       SLL            SLL    false    324    324            H           2606    25656 "   M4SLL_PARAM_USR M4SLL_PARAM_USR_PK 
   CONSTRAINT     t   ALTER TABLE ONLY "SLL"."M4SLL_PARAM_USR"
    ADD CONSTRAINT "M4SLL_PARAM_USR_PK" PRIMARY KEY ("USUARIO", "ACCION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_PARAM_USR" DROP CONSTRAINT "M4SLL_PARAM_USR_PK";
       SLL            SLL    false    332    332            N           2606    25662 6   M4SLL_PEDIDOS_PRUEBA_GABY M4SLL_PEDIDOS_PRUEBA_GABY_PK 
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
       SLL            SLL    false    251    251    251            r           2606    25698 "   M4SLL_TP_COMPROMIS PK1805231410220 
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
       SLL            SLL    false    373    373            >           2606    25646    M4SLL_PAGOS PK1805231555313 
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
       SLL            SLL    false    239    239    239            �           2606    25576    M4SLL_LITIGIOS PK1812101138140 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS"
    ADD CONSTRAINT "PK1812101138140" PRIMARY KEY ("LIT_ID_LITIGIO", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS" DROP CONSTRAINT "PK1812101138140";
       SLL            SLL    false    281    281            v           2606    25702 "   M4SLL_TP_ENTIDADES PK1812101138141 
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
       SLL            SLL    false    372    372            D           2606    25652     M4SLL_PAGOS_TRN PK18121011381417 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_TRN"
    ADD CONSTRAINT "PK18121011381417" PRIMARY KEY ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_TRN" DROP CONSTRAINT "PK18121011381417";
       SLL            SLL    false    330    330    330            h           2606    25688 #   M4SLL_STATUS_PAGOS PK18121011381418 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_STATUS_PAGOS"
    ADD CONSTRAINT "PK18121011381418" PRIMARY KEY ("STP_ID_STATUS_PAGO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_STATUS_PAGOS" DROP CONSTRAINT "PK18121011381418";
       SLL            SLL    false    353    353            �           2606    25716     M4SLL_TP_PEDIDO PK18121011381419 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_PEDIDO"
    ADD CONSTRAINT "PK18121011381419" PRIMARY KEY ("TPE_ID_PEDIDO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_TP_PEDIDO" DROP CONSTRAINT "PK18121011381419";
       SLL            SLL    false    375    375            L           2606    25660    M4SLL_PEDIDOS PK1812101138142 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDOS"
    ADD CONSTRAINT "PK1812101138142" PRIMARY KEY ("TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 J   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDOS" DROP CONSTRAINT "PK1812101138142";
       SLL            SLL    false    334    334    334            �           2606    25528 #   M4SLL_DOC_LITIGIOS PK18121011381420 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_DOC_LITIGIOS"
    ADD CONSTRAINT "PK18121011381420" PRIMARY KEY ("DOL_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_DOC_LITIGIOS" DROP CONSTRAINT "PK18121011381420";
       SLL            SLL    false    247    247    247            |           2606    25708 #   M4SLL_TP_IDENTIFIC PK18121011381422 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_IDENTIFIC"
    ADD CONSTRAINT "PK18121011381422" PRIMARY KEY ("TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_TP_IDENTIFIC" DROP CONSTRAINT "PK18121011381422";
       SLL            SLL    false    368    368            �           2606    25728     M4SLL_TP_STATUS PK18121011381423 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_STATUS"
    ADD CONSTRAINT "PK18121011381423" PRIMARY KEY ("TST_ID_TP_STATUS", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_TP_STATUS" DROP CONSTRAINT "PK18121011381423";
       SLL            SLL    false    382    382            t           2606    25700 #   M4SLL_TP_DOC_LITIG PK18121011381424 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_DOC_LITIG"
    ADD CONSTRAINT "PK18121011381424" PRIMARY KEY ("TDL_ID_TP_DOC_LITIGIO", "ID_ORGANIZATION");
 P   ALTER TABLE ONLY "SLL"."M4SLL_TP_DOC_LITIG" DROP CONSTRAINT "PK18121011381424";
       SLL            SLL    false    361    361            P           2606    25664 !   M4SLL_PERSONA_EXT PK1812101138143 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PERSONA_EXT"
    ADD CONSTRAINT "PK1812101138143" PRIMARY KEY ("PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_PERSONA_EXT" DROP CONSTRAINT "PK1812101138143";
       SLL            SLL    false    337    337    337            p           2606    25696 "   M4SLL_TP_AUTOR_REU PK1812101138144 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_AUTOR_REU"
    ADD CONSTRAINT "PK1812101138144" PRIMARY KEY ("TAR_ID_TP_AUTOR_REU", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_TP_AUTOR_REU" DROP CONSTRAINT "PK1812101138144";
       SLL            SLL    false    357    357            ~           2606    25710 !   M4SLL_TP_LITIGIOS PK1812101138145 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_LITIGIOS"
    ADD CONSTRAINT "PK1812101138145" PRIMARY KEY ("TPL_ID_TP_LITIGIO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_TP_LITIGIOS" DROP CONSTRAINT "PK1812101138145";
       SLL            SLL    false    370    370                       2606    25600 !   M4SLL_MEDIO_PAGOS PK1812101138146 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MEDIO_PAGOS"
    ADD CONSTRAINT "PK1812101138146" PRIMARY KEY ("MEP_ID_MEDIO_PAGO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MEDIO_PAGOS" DROP CONSTRAINT "PK1812101138146";
       SLL            SLL    false    298    298            �           2606    25480    M4SLL_AUTOR_REU PK1812101138147 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU"
    ADD CONSTRAINT "PK1812101138147" PRIMARY KEY ("AUR_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_AUTOR_REU" DROP CONSTRAINT "PK1812101138147";
       SLL            SLL    false    210    210    210            J           2606    25658     M4SLL_PEDIDO_DET PK1812101138148 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDO_DET"
    ADD CONSTRAINT "PK1812101138148" PRIMARY KEY ("LIT_ID_LITIGIO", "TPE_ID_PEDIDO", "PDE_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_PEDIDO_DET" DROP CONSTRAINT "PK1812101138148";
       SLL            SLL    false    333    333    333    333            �           2606    25478 "   M4SLL_AU_REU_ANALI PK1812101138149 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_AU_REU_ANALI"
    ADD CONSTRAINT "PK1812101138149" PRIMARY KEY ("LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARA_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_AU_REU_ANALI" DROP CONSTRAINT "PK1812101138149";
       SLL            SLL    false    209    209    209    209            z           2606    25706    M4SLL_TP_FASES PK1812101538050 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_FASES"
    ADD CONSTRAINT "PK1812101538050" PRIMARY KEY ("TFA_ID_TP_FASE", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_TP_FASES" DROP CONSTRAINT "PK1812101538050";
       SLL            SLL    false    366    366            �           2606    25578 "   M4SLL_LITIGIOS_HIS PK1812110929540 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_HIS"
    ADD CONSTRAINT "PK1812110929540" PRIMARY KEY ("LIT_ID_LITIGIO", "LIH_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_LITIGIOS_HIS" DROP CONSTRAINT "PK1812110929540";
       SLL            SLL    false    285    285    285            n           2606    25694    M4SLL_TOTPEDHIS PK1901021404160 
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
       SLL            SLL    false    235    235            �           2606    25582 "   M4SLL_LIT_SEGUIMIE PK1901041650550 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LIT_SEGUIMIE"
    ADD CONSTRAINT "PK1901041650550" PRIMARY KEY ("LIT_ID_LITIGIO", "LIS_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_LIT_SEGUIMIE" DROP CONSTRAINT "PK1901041650550";
       SLL            SLL    false    288    288    288            X           2606    25672     M4SLL_ROLES_USRS PK1901091148510 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ROLES_USRS"
    ADD CONSTRAINT "PK1901091148510" PRIMARY KEY ("ID_APP_ROLE", "TPR_ID_TP_ROL", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_ROLES_USRS" DROP CONSTRAINT "PK1901091148510";
       SLL            SLL    false    344    344    344            �           2606    25722    M4SLL_TP_ROLES PK1901091148511 
   CONSTRAINT        ALTER TABLE ONLY "SLL"."M4SLL_TP_ROLES"
    ADD CONSTRAINT "PK1901091148511" PRIMARY KEY ("TPR_ID_TP_ROL", "ID_ORGANIZATION");
 K   ALTER TABLE ONLY "SLL"."M4SLL_TP_ROLES" DROP CONSTRAINT "PK1901091148511";
       SLL            SLL    false    379    379            V           2606    25670     M4SLL_ROL_APROBS PK1901091506010 
   CONSTRAINT        ALTER TABLE ONLY "SLL"."M4SLL_ROL_APROBS"
    ADD CONSTRAINT "PK1901091506010" PRIMARY KEY ("ID_APP_ROLE", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_ROL_APROBS" DROP CONSTRAINT "PK1901091506010";
       SLL            SLL    false    343    343            �           2606    25544 !   M4SLL_EST_JUR_SUB PK1901241529580 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_EST_JUR_SUB"
    ADD CONSTRAINT "PK1901241529580" PRIMARY KEY ("EJU_ID_EST_JURIDICO", "EJS_ID_EST_JUR_SUB", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_EST_JUR_SUB" DROP CONSTRAINT "PK1901241529580";
       SLL            SLL    false    257    257    257            x           2606    25704    M4SLL_TP_FALTAS PK1902071553540 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_FALTAS"
    ADD CONSTRAINT "PK1902071553540" PRIMARY KEY ("TFL_ID_TP_FALTA", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_TP_FALTAS" DROP CONSTRAINT "PK1902071553540";
       SLL            SLL    false    365    365            �           2606    25718 !   M4SLL_TP_RECLAMOS PK1902071553541 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TP_RECLAMOS"
    ADD CONSTRAINT "PK1902071553541" PRIMARY KEY ("TRC_ID_TP_RECLAMO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_TP_RECLAMOS" DROP CONSTRAINT "PK1902071553541";
       SLL            SLL    false    377    377            8           2606    25640    M4SLL_NEGOCIOS PK1902131322280 
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
       SLL            SLL    false    264    264    264    264                        2606    25584 "   M4SLL_LIT_VINCULAD PK1904041344150 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LIT_VINCULAD"
    ADD CONSTRAINT "PK1904041344150" PRIMARY KEY ("LIT_ID_LITIGIO", "LIV_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_LIT_VINCULAD" DROP CONSTRAINT "PK1904041344150";
       SLL            SLL    false    289    289    289            �           2606    25574     M4SLL_LIT_HECHOS PK1904111011150 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_LIT_HECHOS"
    ADD CONSTRAINT "PK1904111011150" PRIMARY KEY ("LIT_ID_LITIGIO", "LIH_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_LIT_HECHOS" DROP CONSTRAINT "PK1904111011150";
       SLL            SLL    false    279    279    279                       2606    25604 !   M4SLL_MT_ABOGADOS PK1905031255481 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MT_ABOGADOS"
    ADD CONSTRAINT "PK1905031255481" PRIMARY KEY ("MAB_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MT_ABOGADOS" DROP CONSTRAINT "PK1905031255481";
       SLL            SLL    false    300    300                       2606    25606 !   M4SLL_MTO_COD_ALT PK1905031530580 
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
       SLL            SLL    false    254    254    254            *           2606    25626 "   M4SLL_MTO_PEDIDO_D PK1905091455510 
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
       SLL            SLL    false    221    221    221            R           2606    25666 "   M4SLL_PROV_ABOGADO PK1905100932212 
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
       SLL            SLL    false    380    380            4           2606    25636 "   M4SLL_MTO_TP_EMPLE PK1907221131090 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TP_EMPLE"
    ADD CONSTRAINT "PK1907221131090" PRIMARY KEY ("MTE_ID_TP_EMPLEADO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TP_EMPLE" DROP CONSTRAINT "PK1907221131090";
       SLL            SLL    false    320    320            &           2606    25622 !   M4SLL_MTO_MATERIA PK1907241608520 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MATERIA"
    ADD CONSTRAINT "PK1907241608520" PRIMARY KEY ("MMA_ID_MATERIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MATERIA" DROP CONSTRAINT "PK1907241608520";
       SLL            SLL    false    312    312            ^           2606    25678 "   M4SLL_RP_ES_LITIGI PK1907261552030 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_LITIGI"
    ADD CONSTRAINT "PK1907261552030" PRIMARY KEY ("REL_USUARIO", "REL_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_LITIGI" DROP CONSTRAINT "PK1907261552030";
       SLL            SLL    false    347    347    347            Z           2606    25674 "   M4SLL_RP_CB_LITIGI PK1907261615320 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_CB_LITIGI"
    ADD CONSTRAINT "PK1907261615320" PRIMARY KEY ("RCL_MES", "RCL_ANIO", "RCL_CARPET_ID", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_CB_LITIGI" DROP CONSTRAINT "PK1907261615320";
       SLL            SLL    false    345    345    345    345            �           2606    25572 "   M4SLL_INT_PAGO_NOM PK1907291718440 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAGO_NOM"
    ADD CONSTRAINT "PK1907291718440" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAGO_NOM" DROP CONSTRAINT "PK1907291718440";
       SLL            SLL    false    278    278    278            ,           2606    25628 !   M4SLL_MTO_RIESGOS PK1907301130500 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_RIESGOS"
    ADD CONSTRAINT "PK1907301130500" PRIMARY KEY ("MRI_ID_RIESGO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_RIESGOS" DROP CONSTRAINT "PK1907301130500";
       SLL            SLL    false    315    315            �           2606    25522    M4SLL_CUADRANTE PK1908061519450 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CUADRANTE"
    ADD CONSTRAINT "PK1908061519450" PRIMARY KEY ("ORDINAL_10_PK", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_CUADRANTE" DROP CONSTRAINT "PK1908061519450";
       SLL            SLL    false    243    243                       2606    25610 "   M4SLL_MTO_DET_PROV PK1908121633200 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_DET_PROV"
    ADD CONSTRAINT "PK1908121633200" PRIMARY KEY ("MDP_ID_DET_PROVISION", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_DET_PROV" DROP CONSTRAINT "PK1908121633200";
       SLL            SLL    false    305    305            �           2606    25558 "   M4SLL_HIS_DET_PROV PK1908121633201 
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
       SLL            SLL    false    231    231    231                       2606    25612 !   M4SLL_MTO_EMP_ORG PK1909121232290 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EMP_ORG"
    ADD CONSTRAINT "PK1909121232290" PRIMARY KEY ("STD_ID_LEG_ENT", "ORG_ID", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EMP_ORG" DROP CONSTRAINT "PK1909121232290";
       SLL            SLL    false    307    307    307            6           2606    25638 "   M4SLL_MT_ST_RE_PRO PK1909161051300 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MT_ST_RE_PRO"
    ADD CONSTRAINT "PK1909161051300" PRIMARY KEY ("MSR_ID_STATUS_REPORTE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MT_ST_RE_PRO" DROP CONSTRAINT "PK1909161051300";
       SLL            SLL    false    321    321            j           2606    25690 "   M4SLL_ST_REPO_PROV PK1909161051301 
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
       SLL            SLL    false    208    208    208    208    208            
           2606    25594 "   M4SLL_MATRIZ_PREDI PK1910101723320 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PREDI"
    ADD CONSTRAINT "PK1910101723320" PRIMARY KEY ("MPR_ANIO", "MPR_MES", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PREDI" DROP CONSTRAINT "PK1910101723320";
       SLL            SLL    false    295    295    295    295    295                       2606    25592 "   M4SLL_MATRIZ_PRE_D PK1910111308480 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D"
    ADD CONSTRAINT "PK1910111308480" PRIMARY KEY ("MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_D" DROP CONSTRAINT "PK1910111308480";
       SLL            SLL    false    293    293    293    293                       2606    25586 "   M4SLL_MATRIZ_PRE_C PK1910111308481 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C"
    ADD CONSTRAINT "PK1910111308481" PRIMARY KEY ("MPC_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C" DROP CONSTRAINT "PK1910111308481";
       SLL            SLL    false    290    290            B           2606    25650 "   M4SLL_PAGOS_NOMINA PK1910311755372 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOMINA"
    ADD CONSTRAINT "PK1910311755372" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOMINA" DROP CONSTRAINT "PK1910311755372";
       SLL            SLL    false    329    329    329            �           2606    25542 "   M4SLL_ESP_LIT_PROV PK1911041402250 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ESP_LIT_PROV"
    ADD CONSTRAINT "PK1911041402250" PRIMARY KEY ("LIT_ID_LITIGIO", "ELP_ANIO", "ELP_MES", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_ESP_LIT_PROV" DROP CONSTRAINT "PK1911041402250";
       SLL            SLL    false    256    256    256    256                       2606    25608 "   M4SLL_MTO_CONCEPTO PK1911081214540 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_CONCEPTO"
    ADD CONSTRAINT "PK1911081214540" PRIMARY KEY ("MCO_ID_CONCEPTO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_CONCEPTO" DROP CONSTRAINT "PK1911081214540";
       SLL            SLL    false    304    304            @           2606    25648 !   M4SLL_PAGOS_NOM_D PK1911131129410 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOM_D"
    ADD CONSTRAINT "PK1911131129410" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_PAGOS_NOM_D" DROP CONSTRAINT "PK1911131129410";
       SLL            SLL    false    328    328    328    328            �           2606    25570 "   M4SLL_INT_PAG_NO_D PK1911131129411 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAG_NO_D"
    ADD CONSTRAINT "PK1911131129411" PRIMARY KEY ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_INT_PAG_NO_D" DROP CONSTRAINT "PK1911131129411";
       SLL            SLL    false    277    277    277    277            �           2606    25566 !   M4SLL_INT_GL_TRXS PK1911141648350 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_INT_GL_TRXS"
    ADD CONSTRAINT "PK1911141648350" PRIMARY KEY ("ORIGEN", "GRUPO", "LOTE", "RENGLON", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_INT_GL_TRXS" DROP CONSTRAINT "PK1911141648350";
       SLL            SLL    false    274    274    274    274    274            �           2606    25564 "   M4SLL_INT_GL_TRX_L PK1911141648351 
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
       SLL            SLL    false    238    238    238            F           2606    25654 !   M4SLL_PARAMETRICA PK1911201027060 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_PARAMETRICA"
    ADD CONSTRAINT "PK1911201027060" PRIMARY KEY ("PAR_SECUENCIA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_PARAMETRICA" DROP CONSTRAINT "PK1911201027060";
       SLL            SLL    false    331    331            `           2606    25680 "   M4SLL_RP_ES_PROVIS PK1911201647210 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_PROVIS"
    ADD CONSTRAINT "PK1911201647210" PRIMARY KEY ("REL_USUARIO", "REL_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_PROVIS" DROP CONSTRAINT "PK1911201647210";
       SLL            SLL    false    348    348    348            \           2606    25676 "   M4SLL_RP_ES_FICHER PK1912101750530 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_FICHER"
    ADD CONSTRAINT "PK1912101750530" PRIMARY KEY ("REFE", "USUARIO", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_RP_ES_FICHER" DROP CONSTRAINT "PK1912101750530";
       SLL            SLL    false    346    346    346            <           2606    25644 "   M4SLL_NEGOCIOS_ROL PK1912231250370 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_ROL"
    ADD CONSTRAINT "PK1912231250370" PRIMARY KEY ("NEG_ID_NEGOCIO", "ID_APP_ROLE", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_NEGOCIOS_ROL" DROP CONSTRAINT "PK1912231250370";
       SLL            SLL    false    325    325    325            "           2606    25618 "   M4SLL_MTO_EST_TARE PK1912271205370 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_TARE"
    ADD CONSTRAINT "PK1912271205370" PRIMARY KEY ("MET_ID_EST_TAREA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_TARE" DROP CONSTRAINT "PK1912271205370";
       SLL            SLL    false    310    310            2           2606    25634 !   M4SLL_MTO_TAR_CIE PK1912271205371 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TAR_CIE"
    ADD CONSTRAINT "PK1912271205371" PRIMARY KEY ("MTC_ID_TAREA", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_TAR_CIE" DROP CONSTRAINT "PK1912271205371";
       SLL            SLL    false    319    319                        2606    25616 !   M4SLL_MTO_EST_EJE PK1912271205372 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_EJE"
    ADD CONSTRAINT "PK1912271205372" PRIMARY KEY ("MEE_ID_EST_EJECUCION", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_EST_EJE" DROP CONSTRAINT "PK1912271205372";
       SLL            SLL    false    309    309            �           2606    25496 "   M4SLL_CIERRES_MENS PK1912271205373 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_CIERRES_MENS"
    ADD CONSTRAINT "PK1912271205373" PRIMARY KEY ("CIM_ANIO", "CIM_MES", "MTC_ID_TAREA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_CIERRES_MENS" DROP CONSTRAINT "PK1912271205373";
       SLL            SLL    false    229    229    229    229            b           2606    25682    M4SLL_SEGURIDAD PK1912301210170 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_SEGURIDAD"
    ADD CONSTRAINT "PK1912301210170" PRIMARY KEY ("ID_APP_ROLE", "SS_SECUENCIAL", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_SEGURIDAD" DROP CONSTRAINT "PK1912301210170";
       SLL            SLL    false    349    349    349            d           2606    25684 "   M4SLL_SEGURIDAD_VI PK2001151711500 
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
       SLL            SLL    false    227    227    227            0           2606    25632 "   M4SLL_MTO_SEG_INTE PK2006221525030 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_SEG_INTE"
    ADD CONSTRAINT "PK2006221525030" PRIMARY KEY ("ID_APP_ROLE", "MSI_SECUENCIA", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_SEG_INTE" DROP CONSTRAINT "PK2006221525030";
       SLL            SLL    false    318    318    318            �           2606    25736 !   M4SLL_WKF_ESTADOS PK2006221525031 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_WKF_ESTADOS"
    ADD CONSTRAINT "PK2006221525031" PRIMARY KEY ("WKE_ID_ESTADO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_WKF_ESTADOS" DROP CONSTRAINT "PK2006221525031";
       SLL            SLL    false    388    388            (           2606    25624 !   M4SLL_MTO_MODULOS PK2006221525032 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MODULOS"
    ADD CONSTRAINT "PK2006221525032" PRIMARY KEY ("MTM_ID_MODULO", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_MODULOS" DROP CONSTRAINT "PK2006221525032";
       SLL            SLL    false    313    313                       2606    25602     M4SLL_MODULO_ROL PK2006221525033 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MODULO_ROL"
    ADD CONSTRAINT "PK2006221525033" PRIMARY KEY ("MOR_SECUENCIA", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_MODULO_ROL" DROP CONSTRAINT "PK2006221525033";
       SLL            SLL    false    299    299            T           2606    25668 "   M4SLL_ROL_ACT_ROLE PK2006221525034 
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
       SLL            SLL    false    390    390            .           2606    25630 "   M4SLL_MTO_ROL_ACTO PK2006221525037 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_ROL_ACTO"
    ADD CONSTRAINT "PK2006221525037" PRIMARY KEY ("MRA_ID_ROL_ACTOR", "ID_ORGANIZATION");
 O   ALTER TABLE ONLY "SLL"."M4SLL_MTO_ROL_ACTO" DROP CONSTRAINT "PK2006221525037";
       SLL            SLL    false    317    317            �           2606    25472    M4SLL_ABOHON_NJ PK2011041824350 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_ABOHON_NJ"
    ADD CONSTRAINT "PK2011041824350" PRIMARY KEY ("ANJ_SECUENCIA", "ID_ORGANIZATION");
 L   ALTER TABLE ONLY "SLL"."M4SLL_ABOHON_NJ" DROP CONSTRAINT "PK2011041824350";
       SLL            SLL    false    206    206            l           2606    25692    M4SLL_TOTHONJ PK2011091911480 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_TOTHONJ"
    ADD CONSTRAINT "PK2011091911480" PRIMARY KEY ("TNJ_ANIO", "TNJ_MES", "MAB_SECUENCIA", "ID_ORGANIZATION");
 J   ALTER TABLE ONLY "SLL"."M4SLL_TOTHONJ" DROP CONSTRAINT "PK2011091911480";
       SLL            SLL    false    355    355    355    355            �           2606    25554     M4SLL_FASES_PROV PK2011111629350 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_FASES_PROV"
    ADD CONSTRAINT "PK2011111629350" PRIMARY KEY ("FAP_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_FASES_PROV" DROP CONSTRAINT "PK2011111629350";
       SLL            SLL    false    266    266    266            $           2606    25620 !   M4SLL_MTO_FUNCION PK2011160939420 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MTO_FUNCION"
    ADD CONSTRAINT "PK2011160939420" PRIMARY KEY ("MOR_FUNCION", "ID_ORGANIZATION");
 N   ALTER TABLE ONLY "SLL"."M4SLL_MTO_FUNCION" DROP CONSTRAINT "PK2011160939420";
       SLL            SLL    false    311    311                       2606    25614 !   M4SLL_MTO_ESTADOS PK2011161141410 
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
       SLL            SLL    false    241    241    241            f           2606    25686     M4SLL_SGD_CONFIG PK2012141927230 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_SGD_CONFIG"
    ADD CONSTRAINT "PK2012141927230" PRIMARY KEY ("SGDC_CONTEXT", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_SGD_CONFIG" DROP CONSTRAINT "PK2012141927230";
       SLL            SLL    false    352    352            �           2606    25732     M4SLL_VAL_EC_LIT PK2102051253490 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_VAL_EC_LIT"
    ADD CONSTRAINT "PK2102051253490" PRIMARY KEY ("VEL_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION");
 M   ALTER TABLE ONLY "SLL"."M4SLL_VAL_EC_LIT" DROP CONSTRAINT "PK2102051253490";
       SLL            SLL    false    386    386    386                       2606    25590 =   M4SLL_MATRIZ_PRE_C_PRUEBA_GABY PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK 
   CONSTRAINT     �   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY"
    ADD CONSTRAINT "PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK" PRIMARY KEY ("ID_ORGANIZATION", "MPC_SECUENCIA");
 j   ALTER TABLE ONLY "SLL"."M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" DROP CONSTRAINT "PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK";
       SLL            SLL    false    292    292            �           2606    16454 0   databasechangeloglock databasechangeloglock_pkey 
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
       public            SLLPE    false    205    205            �           1259    16473    idx_persistent_audit_event    INDEX     r   CREATE INDEX idx_persistent_audit_event ON public.jhi_persistent_audit_event USING btree (principal, event_date);
 .   DROP INDEX public.idx_persistent_audit_event;
       public            SLLPE    false    204    204            �           1259    16474    idx_persistent_audit_evt_data    INDEX     k   CREATE INDEX idx_persistent_audit_evt_data ON public.jhi_persistent_audit_evt_data USING btree (event_id);
 1   DROP INDEX public.idx_persistent_audit_evt_data;
       public            SLLPE    false    205            �           2606    16475 8   jhi_persistent_audit_evt_data fk_evt_pers_audit_evt_data    FK CONSTRAINT     �   ALTER TABLE ONLY public.jhi_persistent_audit_evt_data
    ADD CONSTRAINT fk_evt_pers_audit_evt_data FOREIGN KEY (event_id) REFERENCES public.jhi_persistent_audit_event(event_id);
 b   ALTER TABLE ONLY public.jhi_persistent_audit_evt_data DROP CONSTRAINT fk_evt_pers_audit_evt_data;
       public          SLLPE    false    204    205    3723            %      x������ � �      &      x������ � �      '      x������ � �      )      x������ � �      -      x������ � �      *      x������ � �      +      x������ � �      ,      x������ � �      .      x������ � �      (      x������ � �      /      x������ � �      0      x������ � �      1      x������ � �      2      x������ � �      3      x������ � �      4      x������ � �      7      x������ � �      5      x������ � �      6      x������ � �      8      x������ � �      9      x������ � �      :      x������ � �      <      x������ � �      ;      x������ � �      =      x������ � �      >      x������ � �      C      x������ � �      D      x������ � �      ?      x������ � �      @      x������ � �      A      x������ � �      B      x������ � �      E      x������ � �      F      x������ � �      G      x������ � �      H      x������ � �      I      x������ � �      J      x������ � �      K      x������ � �      L      x������ � �      M      x������ � �      Q      x������ � �      N      x������ � �      O      x������ � �      P      x������ � �      R      x������ � �      S      x������ � �      T      x������ � �      U      x������ � �      V      x������ � �      W      x������ � �      Y      x������ � �      Z      x������ � �      X      x������ � �      [      x������ � �      \      x������ � �      ]      x������ � �      ^      x������ � �      _      x������ � �      `      x������ � �      a      x������ � �      b      x������ � �      c      x������ � �      d      x������ � �      e      x������ � �      f      x������ � �      i      x������ � �      j      x������ � �      g      x������ � �      h      x������ � �      k      x������ � �      m      x������ � �      l      x������ � �      p      x������ � �      q      x������ � �      r      x������ � �      s      x������ � �      t      x������ � �      u      x������ � �      v      x������ � �      n      x������ � �      o      x������ � �      w      x������ � �      x      x������ � �      ~      x������ � �      y      x������ � �      z      x������ � �      {      x������ � �      |      x������ � �      }      x������ � �            x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      !   3  x���_k�0ş�O�0c��i��i�ad0{B�\kF5�C���s������!�},ݺ��Y������l�V�R��U=�H鼋N5�3Kh޵b��aJRJG��9�e�(��O�f�G$FZV��a5�� Jc��L��r�L �6[���d�����A��!��
ͧ(�&�_V�L0�\t���Y����s�̰�f�	�i�U�f���p"�=qΔn �=�%�B���>J��.J���8�S"J����ڗ�Z�ϰ�=����[إ�ǐ��+��ne���gs�$� ��Q             x�3�L��"�=... U�      #      x������ � �      $      x������ � �     