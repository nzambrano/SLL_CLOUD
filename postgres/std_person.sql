-- Table: public.STD_PERSON

-- DROP TABLE public.STD_PERSON;

CREATE TABLE public.STD_PERSON
(
    ID_ORGANIZATION character varying(4) COLLATE pg_catalog.default NOT NULL,
    STD_ID_PERSON character varying(10) COLLATE pg_catalog.default NOT NULL,
    STD_N_FAM_NAME_1 character varying(50) COLLATE pg_catalog.default,
    STD_N_MAIDEN_NAME character varying(50) COLLATE pg_catalog.default,
    STD_N_FIRST_NAME character varying(50) COLLATE pg_catalog.default,
    STD_N_USUAL_NAME character varying(50) COLLATE pg_catalog.default,
    STD_ID_GENDER character varying(1) COLLATE pg_catalog.default,
    STD_ID_SALUTATION character varying(10) COLLATE pg_catalog.default,
    STD_DT_BIRTH timestamp(0) without time zone,
    STD_ID_COUNTRY character varying(4) COLLATE pg_catalog.default,
    STD_ID_GEO_DIV character varying(4) COLLATE pg_catalog.default,
    STD_ID_SUB_GEO_DIV character varying(8) COLLATE pg_catalog.default,
    STD_COMMENT character varying(254) COLLATE pg_catalog.default,
    SSP_ID_PAIS_EMISOR character varying(4) COLLATE pg_catalog.default,
    SSP_PRIM_APELLIDO character varying(50) COLLATE pg_catalog.default,
    STD_SSN character varying(20) COLLATE pg_catalog.default,
    SCO_PHOTO character varying(100) COLLATE pg_catalog.default,
    SCO_HOME_PAGE character varying(254) COLLATE pg_catalog.default,
    SSP_ID_TP_DOC character varying(10) COLLATE pg_catalog.default,
    SFR_N_MAIDEN_NAME character varying(50) COLLATE pg_catalog.default,
    SFR_NM_BIRTH_PLACE character varying(50) COLLATE pg_catalog.default,
    STD_ID_GEO_PLACE character varying(9) COLLATE pg_catalog.default,
    STD_SS_KEY character varying(3) COLLATE pg_catalog.default,
    STD_SS_NUMBER character varying(16) COLLATE pg_catalog.default,
    SAR_N_MARRIED_NAME character varying(40) COLLATE pg_catalog.default,
    SBR_ID_RACA character varying(3) COLLATE pg_catalog.default,
    SCO_PHOTO_INET character varying(100) COLLATE pg_catalog.default,
    SGE_ID_ADD_NAME character varying(2) COLLATE pg_catalog.default,
    SGE_ID_TITEL character varying(3) COLLATE pg_catalog.default,
    SGE_ID_VSW character varying(3) COLLATE pg_catalog.default,
    SGE_N_NAME_COMPL character varying(254) COLLATE pg_catalog.default,
    SUK_MAIDEN_NAME character varying(50) COLLATE pg_catalog.default,
    SUK_OTHER_FORENAME character varying(50) COLLATE pg_catalog.default,
    SUK_PREVIOUS_SURNA character varying(50) COLLATE pg_catalog.default,
    SUS_DEATH_DATE timestamp(0) without time zone,
    SCO_SMOKER smallint,
    SCO_GB_NAME character varying(254) COLLATE pg_catalog.default,
    SCO_ID_REGION character varying(9) COLLATE pg_catalog.default,
    SAR_EXPEDIDO character varying(62) COLLATE pg_catalog.default,
    SUS_VETERAN smallint,
    SUS_ID_VET_DIS_TY character varying(2) COLLATE pg_catalog.default,
    SUS_ID_VETERAN_WHE character varying(3) COLLATE pg_catalog.default,
    SUS_ID_ETHNICITY character varying(3) COLLATE pg_catalog.default,
    SAR_DT_DEFUNCION timestamp(0) without time zone,
    SCB_DIG_VER character varying(1) COLLATE pg_catalog.default,
    SME_NUM_SS character varying(62) COLLATE pg_catalog.default,
    SAR_CUIL character varying(16) COLLATE pg_catalog.default,
    SCL_RUT character varying(16) COLLATE pg_catalog.default,
    SME_RFC character varying(16) COLLATE pg_catalog.default,
    SME_CURP character varying(20) COLLATE pg_catalog.default,
    SBR_CPF character varying(20) COLLATE pg_catalog.default,
    SMX_IMSS character varying(12) COLLATE pg_catalog.default,
    CMX_APELLIDO_PATERNO_IMSS character varying(50) COLLATE pg_catalog.default,
    CMX_APELLIDO_MATERNO_IMSS character varying(50) COLLATE pg_catalog.default,
    CMX_NOMBRE_IMSS character varying(50) COLLATE pg_catalog.default,
    ID_APPROLE character varying(30) COLLATE pg_catalog.default,
    ID_SECUSER character varying(30) COLLATE pg_catalog.default,
    DT_LAST_UPDATE timestamp(0) without time zone,
    CFR_LOCALIDAD_NAC character varying(100) COLLATE pg_catalog.default,
    STD_ID_COUNTRY_PADRE character varying(4) COLLATE pg_catalog.default,
    STD_ID_COUNTRY_MADRE character varying(4) COLLATE pg_catalog.default,
    CCO_NEC_HABI character varying(1) COLLATE pg_catalog.default,
    PLCO_HIDDEN_BY_DATA_PROTECTION character varying(1) COLLATE pg_catalog.default DEFAULT 0,
    PLCO_DATE_4_HIDDEN_DATA_PROTEC timestamp(0) without time zone,
    SCO_GB_LEGAL character varying(50) COLLATE pg_catalog.default,
    PLCO_ID_ORGANIZATION character varying(4) COLLATE pg_catalog.default,
    CONSTRAINT PK_PERSON PRIMARY KEY (STD_ID_PERSON, ID_ORGANIZATION)
)

TABLESPACE pg_default;



GRANT ALL ON TABLE public.STD_PERSON TO "SLL";

GRANT ALL ON TABLE public.STD_PERSON TO "SLLPE";
-- Index: IDX_PERSON_FK11

-- DROP INDEX public.IDX_PERSON_FK11;

CREATE INDEX IDX_PERSON_FK11
    ON public.STD_PERSON USING btree
    (STD_ID_SALUTATION COLLATE pg_catalog.default ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IDX_PERSON_FK21

-- DROP INDEX public.IDX_PERSON_FK21;

CREATE INDEX IDX_PERSON_FK21
    ON public.STD_PERSON USING btree
    (STD_ID_COUNTRY COLLATE pg_catalog.default ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IDX_PERSON_FK31

-- DROP INDEX public.IDX_PERSON_FK31;

CREATE INDEX IDX_PERSON_FK31
    ON public.STD_PERSON USING btree
    (STD_ID_GEO_DIV COLLATE pg_catalog.default ASC NULLS LAST, STD_ID_COUNTRY COLLATE pg_catalog.default ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IDX_PERSON_FK41

-- DROP INDEX public.IDX_PERSON_FK41;

CREATE INDEX IDX_PERSON_FK41
    ON public.STD_PERSON USING btree
    (STD_ID_COUNTRY COLLATE pg_catalog.default ASC NULLS LAST, STD_ID_GEO_DIV COLLATE pg_catalog.default ASC NULLS LAST, STD_ID_SUB_GEO_DIV COLLATE pg_catalog.default ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IDX_PK_PERSON

-- DROP INDEX public.IDX_PK_PERSON;

CREATE UNIQUE INDEX IDX_PK_PERSON
    ON public.STD_PERSON USING btree
    (STD_ID_PERSON COLLATE pg_catalog.default ASC NULLS LAST, ID_ORGANIZATION COLLATE pg_catalog.default ASC NULLS LAST)
    TABLESPACE pg_default;