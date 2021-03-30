

CREATE TABLE public.STD_COUNTRY (
    ID_ORGANIZATION character varying(4) NOT NULL,
    STD_ID_COUNTRY character varying(4) NOT NULL,
    STD_N_COUNTRYBRA character varying(62),
    STD_N_COUNTRYENG character varying(62),
    STD_N_COUNTRYESP character varying(62),
    STD_N_COUNTRYFRA character varying(62),
    STD_N_COUNTRYGEN character varying(62),
    STD_N_COUNTRYGER character varying(62),
    STD_N_COUNTRYITA character varying(62),
    STD_ID_COUNT_GROUP character varying(3),
    STD_ID_NACIONALITY character varying(3),
    STD_N_NACIONALBRA character varying(62),
    STD_N_NACIONALENG character varying(62),
    STD_N_NACIONALESP character varying(62),
    STD_N_NACIONALFRA character varying(62),
    STD_N_NACIONALGEN character varying(62),
    STD_N_NACIONALGER character varying(62),
    STD_N_NACIONALITA character varying(62),
    STD_ID_CURRENCY character varying(3),
    SFR_ID_NATIONALITY character varying(2),
    SSP_ID_NACION_SS character varying(3),
    ID_APPROLE character varying(30),
    ID_SECUSER character varying(30),
    DT_LAST_UPDATE timestamp(0) without time zone,
    STD_ID_COUNT_DIAN smallint
);


ALTER TABLE public.STD_COUNTRY OWNER TO "SLLPE";

--
-- TOC entry 392 (class 1259 OID 33087)
-- Name: STD_GEO_DIV; Type: TABLE; Schema: public; Owner: "SLLPE"
--

CREATE TABLE public.STD_GEO_DIV (
    ID_ORGANIZATION character varying(4) DEFAULT '0000'::character varying NOT NULL,
    STD_ID_COUNTRY character varying(4) NOT NULL,
    STD_ID_GEO_DIV character varying(4) NOT NULL,
    STD_N_GEO_DIVENG character varying(62),
    STD_N_GEO_DIVESP character varying(62),
    STD_N_GEO_DIVFRA character varying(62),
    STD_N_GEO_DIVGER character varying(62),
    STD_N_GEO_DIVBRA character varying(62),
    STD_N_GEO_DIVITA character varying(62),
    STD_N_GEO_DIVGEN character varying(62),
    SME_ID_CURP character varying(2),
    SME_PORC_ILIS numeric(7,4),
    SCB_ID_ZONA_UPC character varying(3),
    SAR_ID_PROV_AFIP character varying(4),
    SME_PORC_IMPUESTO numeric(5,2),
    ID_APPROLE character varying(30),
    SME_CALC_IMP smallint,
    ID_SECUSER character varying(30),
    SME_ID_ESTADO_DIM character varying(4),
    DT_LAST_UPDATE timestamp(0) without time zone
);


ALTER TABLE public.STD_GEO_DIV OWNER TO "SLLPE";

--
-- TOC entry 393 (class 1259 OID 33094)
-- Name: STD_GEO_PLACE; Type: TABLE; Schema: public; Owner: "SLLPE"
--

CREATE TABLE public.STD_GEO_PLACE (
    ID_ORGANIZATION character varying(4) NOT NULL,
    STD_ID_COUNTRY character varying(4) NOT NULL,
    STD_ID_GEO_DIV character varying(4) NOT NULL,
    STD_ID_SUB_GEO_DIV character varying(8) NOT NULL,
    STD_ID_GEO_PLACE character varying(9) NOT NULL,
    STD_N_GEO_PLACENG character varying(62),
    STD_N_GEO_PLACESP character varying(62),
    STD_N_GEO_PLACFRA character varying(62),
    STD_N_GEO_PLACGER character varying(62),
    STD_N_GEO_PLACBRA character varying(62),
    STD_N_GEO_PLACITA character varying(62),
    STD_N_GEO_PLACGEN character varying(62),
    STD_ID_LEGAL_PLACE character varying(9),
    SCB_ID_ZONA_UPC character varying(3),
    ID_APPROLE character varying(30),
    ID_SECUSER character varying(30),
    DT_LAST_UPDATE timestamp(0) without time zone
);


ALTER TABLE public.STD_GEO_PLACE OWNER TO "SLLPE";

--
-- TOC entry 394 (class 1259 OID 33100)
-- Name: STD_PERSON; Type: TABLE; Schema: public; Owner: "SLLPE"
--

CREATE TABLE public.STD_PERSON (
    ID_ORGANIZATION character varying(4) NOT NULL,
    STD_ID_PERSON character varying(10) NOT NULL,
    STD_N_FAM_NAME_1 character varying(50),
    STD_N_MAIDEN_NAME character varying(50),
    STD_N_FIRST_NAME character varying(50),
    STD_N_USUAL_NAME character varying(50),
    STD_ID_GENDER character varying(1),
    STD_ID_SALUTATION character varying(10),
    STD_DT_BIRTH timestamp(0) without time zone,
    STD_ID_COUNTRY character varying(4),
    STD_ID_GEO_DIV character varying(4),
    STD_ID_SUB_GEO_DIV character varying(8),
    STD_COMMENT character varying(254),
    SSP_ID_PAIS_EMISOR character varying(4),
    SSP_PRIM_APELLIDO character varying(50),
    STD_SSN character varying(20),
    SCO_PHOTO character varying(100),
    SCO_HOME_PAGE character varying(254),
    SSP_ID_TP_DOC character varying(10),
    SFR_N_MAIDEN_NAME character varying(50),
    SFR_NM_BIRTH_PLACE character varying(50),
    STD_ID_GEO_PLACE character varying(9),
    STD_SS_KEY character varying(3),
    STD_SS_NUMBER character varying(16),
    SAR_N_MARRIED_NAME character varying(40),
    SBR_ID_RACA character varying(3),
    SCO_PHOTO_INET character varying(100),
    SGE_ID_ADD_NAME character varying(2),
    SGE_ID_TITEL character varying(3),
    SGE_ID_VSW character varying(3),
    SGE_N_NAME_COMPL character varying(254),
    SUK_MAIDEN_NAME character varying(50),
    SUK_OTHER_FORENAME character varying(50),
    SUK_PREVIOUS_SURNA character varying(50),
    SUS_DEATH_DATE timestamp(0) without time zone,
    SCO_SMOKER smallint,
    SCO_GB_NAME character varying(254),
    SCO_ID_REGION character varying(9),
    SAR_EXPEDIDO character varying(62),
    SUS_VETERAN smallint,
    SUS_ID_VET_DIS_TY character varying(2),
    SUS_ID_VETERAN_WHE character varying(3),
    SUS_ID_ETHNICITY character varying(3),
    SAR_DT_DEFUNCION timestamp(0) without time zone,
    SCB_DIG_VER character varying(1),
    SME_NUM_SS character varying(62),
    SAR_CUIL character varying(16),
    SCL_RUT character varying(16),
    SME_RFC character varying(16),
    SME_CURP character varying(20),
    SBR_CPF character varying(20),
    SMX_IMSS character varying(12),
    CMX_APELLIDO_PATERNO_IMSS character varying(50),
    CMX_APELLIDO_MATERNO_IMSS character varying(50),
    CMX_NOMBRE_IMSS character varying(50),
    ID_APPROLE character varying(30),
    ID_SECUSER character varying(30),
    DT_LAST_UPDATE timestamp(0) without time zone,
    CFR_LOCALIDAD_NAC character varying(100),
    STD_ID_COUNTRY_PADRE character varying(4),
    STD_ID_COUNTRY_MADRE character varying(4),
    CCO_NEC_HABI character varying(1),
    PLCO_HIDDEN_BY_DATA_PROTECTION character varying(1) DEFAULT 0,
    PLCO_DATE_4_HIDDEN_DATA_PROTEC timestamp(0) without time zone,
    SCO_GB_LEGAL character varying(50),
    PLCO_ID_ORGANIZATION character varying(4)
);


ALTER TABLE public.STD_PERSON OWNER TO "SLLPE";

--
-- TOC entry 395 (class 1259 OID 33107)
-- Name: STD_SUB_GEO_DIV; Type: TABLE; Schema: public; Owner: "SLLPE"
--

CREATE TABLE public.STD_SUB_GEO_DIV (
    ID_ORGANIZATION character varying(4) NOT NULL,
    STD_ID_COUNTRY character varying(4) NOT NULL,
    STD_ID_GEO_DIV character varying(4) NOT NULL,
    STD_ID_SUB_GEO_DIV character varying(8) NOT NULL,
    STD_N_SUB_GEO_ENG character varying(62),
    STD_N_SUB_GEO_ESP character varying(62),
    STD_N_SUB_GEO_FRA character varying(62),
    STD_N_SUB_GEO_GER character varying(62),
    STD_N_SUB_GEO_BRA character varying(62),
    STD_N_SUB_GEO_ITA character varying(62),
    STD_N_SUB_GEO_GEN character varying(62),
    ID_APPROLE character varying(30),
    SAR_ID_PROV_AFIP character varying(4),
    ID_SECUSER character varying(30),
    SCB_ID_ZONA_UPC character varying(3),
    DT_LAST_UPDATE timestamp(0) without time zone,
    SME_ID_ZONA_EC character varying(2)
);


ALTER TABLE public.STD_SUB_GEO_DIV OWNER TO "SLLPE";


ALTER TABLE ONLY public.STD_COUNTRY
    ADD CONSTRAINT PK_COUNTRY PRIMARY KEY (STD_ID_COUNTRY, ID_ORGANIZATION);


--
-- TOC entry 3503 (class 2606 OID 33125)
-- Name: STD_GEO_DIV PK_GEO_DIV; Type: CONSTRAINT; Schema: public; Owner: "SLLPE"
--

ALTER TABLE ONLY public.STD_GEO_DIV
    ADD CONSTRAINT PK_GEO_DIV PRIMARY KEY (STD_ID_COUNTRY, STD_ID_GEO_DIV, ID_ORGANIZATION);


--
-- TOC entry 3506 (class 2606 OID 33127)
-- Name: STD_GEO_PLACE PK_GEO_PLACE; Type: CONSTRAINT; Schema: public; Owner: "SLLPE"
--

ALTER TABLE ONLY public.STD_GEO_PLACE
    ADD CONSTRAINT PK_GEO_PLACE PRIMARY KEY (STD_ID_COUNTRY, STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, STD_ID_GEO_PLACE, ID_ORGANIZATION);


--
-- TOC entry 3513 (class 2606 OID 33129)
-- Name: STD_PERSON PK_PERSON; Type: CONSTRAINT; Schema: public; Owner: "SLLPE"
--

ALTER TABLE ONLY public.STD_PERSON
    ADD CONSTRAINT PK_PERSON PRIMARY KEY (STD_ID_PERSON, ID_ORGANIZATION);


--
-- TOC entry 3516 (class 2606 OID 33131)
-- Name: STD_SUB_GEO_DIV PK_SUB_GEO_DIV; Type: CONSTRAINT; Schema: public; Owner: "SLLPE"
--

ALTER TABLE ONLY public.STD_SUB_GEO_DIV
    ADD CONSTRAINT PK_SUB_GEO_DIV PRIMARY KEY (STD_ID_COUNTRY, STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, ID_ORGANIZATION);



CREATE UNIQUE INDEX IDX_COUNTRY ON public.STD_COUNTRY USING btree (STD_ID_COUNTRY, ID_ORGANIZATION);


--
-- TOC entry 3501 (class 1259 OID 33114)
-- Name: IDX_GEO_DIV; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE UNIQUE INDEX IDX_GEO_DIV ON public.STD_GEO_DIV USING btree (STD_ID_COUNTRY, STD_ID_GEO_DIV, ID_ORGANIZATION);


--
-- TOC entry 3504 (class 1259 OID 33115)
-- Name: IDX_GEO_PLACE; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE UNIQUE INDEX IDX_GEO_PLACE ON public.STD_GEO_PLACE USING btree (STD_ID_COUNTRY, STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, STD_ID_GEO_PLACE, ID_ORGANIZATION);


--
-- TOC entry 3507 (class 1259 OID 33119)
-- Name: IDX_PERSON_FK11; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE INDEX IDX_PERSON_FK11 ON public.STD_PERSON USING btree (STD_ID_SALUTATION);


--
-- TOC entry 3508 (class 1259 OID 33118)
-- Name: IDX_PERSON_FK21; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE INDEX IDX_PERSON_FK21 ON public.STD_PERSON USING btree (STD_ID_COUNTRY);


--
-- TOC entry 3509 (class 1259 OID 33117)
-- Name: IDX_PERSON_FK31; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE INDEX IDX_PERSON_FK31 ON public.STD_PERSON USING btree (STD_ID_GEO_DIV, STD_ID_COUNTRY);


--
-- TOC entry 3510 (class 1259 OID 33116)
-- Name: IDX_PERSON_FK41; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE INDEX IDX_PERSON_FK41 ON public.STD_PERSON USING btree (STD_ID_COUNTRY, STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV);


--
-- TOC entry 3511 (class 1259 OID 33120)
-- Name: IDX_PK_PERSON; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE UNIQUE INDEX IDX_PK_PERSON ON public.STD_PERSON USING btree (STD_ID_PERSON, ID_ORGANIZATION);


--
-- TOC entry 3514 (class 1259 OID 33121)
-- Name: IDX_PK_SUB_GEO_DIV; Type: INDEX; Schema: public; Owner: "SLLPE"
--

CREATE UNIQUE INDEX IDX_PK_SUB_GEO_DIV ON public.STD_SUB_GEO_DIV USING btree (STD_ID_COUNTRY, STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, ID_ORGANIZATION);

