-----------------------------------------------
-- PROD_DEl
-----------------------------------------------
CREATE TABLE prod_del (
  scn_cd_id DECIMAL(17, 0) NOT NULL,
  prod_id INTEGER NOT NULL,
  itm_id DECIMAL(17, 0) NOT NULL,
  itm_key_typ_cd VARCHAR(5) NOT NULL,
  sals_rcrd_sw VARCHAR(5) NOT NULL,
  inven_sw VARCHAR(5) NOT NULL,
  str_rcpt_sw  VARCHAR(5) NOT NULL,
  lst_recd_dt DATE NOT NULL ,
  new_prod_itm_sw VARCHAR(5) NOT NULL,
  open_po_sw  VARCHAR(5) NOT NULL,
  dscon_mst_dta_sw  VARCHAR(5) NOT NULL,
  cre8_id VARCHAR(20) NOT NULL,
  cre8_ts TIMESTAMP NOT NULL,
  lst_updt_uid VARCHAR(20) NOT NULL,
  lst_updt_ts TIMESTAMP NOT NULL,
  whse_inven_sw VARCHAR(5) NOT NULL,
  lst_bil_dt DATE NOT NULL
);

ALTER TABLE prod_del ADD PRIMARY KEY (scn_cd_id, prod_id, itm_id, itm_key_typ_cd);

-----------------------------------------------
-- ITEM_MASTER
-----------------------------------------------
CREATE TABLE item_master (
  itm_key_typ_cd VARCHAR(5) NOT NULL,
  itm_id DECIMAL(17, 0) NOT NULL,
  item_des VARCHAR(30) NOT NULL,
  dscon_dt DATE NOT NULL,
  DSCON_USR_ID VARCHAR(8) NOT NULL,
  heb_itm_pk INTEGER NOT NULL,
  ordering_upc DECIMAL(17, 0) NOT NULL,
  ADDED_DT DATE NOT NULL,
  ITEM_SIZE_TXT VARCHAR(12) NOT NULL

);

ALTER TABLE item_master ADD PRIMARY KEY (itm_key_typ_cd, itm_id);

-----------------------------------------------
-- WHSE_LOC_ITM
-----------------------------------------------
-- CREATE TABLE whse_loc_itm (
--   itm_key_typ_cd VARCHAR (5) NOT NULL,
--   itm_id DECIMAL(17, 0) NOT NULL,
--   whse_loc_typ_cd VARCHAR(2) NOT NULL,
--   whse_loc_nbr DECIMAL(5, 0) NOT NULL,
--   prch_stat_cd VARCHAR (5) NOT NULL,
--   prch_stat_ts TIMESTAMP NOT NULL,
--   DSTRB_RES_QTY
-- );

CREATE TABLE WHSE_LOC_ITM
(
    ITM_KEY_TYP_CD VARCHAR(5) DEFAULT '' NOT NULL,
    ITM_ID DECIMAL(17,0) DEFAULT 0 NOT NULL,
    WHSE_LOC_TYP_CD VARCHAR(2) DEFAULT '' NOT NULL,
    WHSE_LOC_NBR INT DEFAULT 0 NOT NULL,
    SCA_CD VARCHAR(5) DEFAULT '' NOT NULL,
    SPLR_ITM_STATUS_CD VARCHAR(5) DEFAULT '' NOT NULL,
    SPLR_STAT_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    SPLR_STAT_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    SPLR_ITM_RSN_CD VARCHAR(5) DEFAULT '' NOT NULL,
    PRCH_STAT_CD VARCHAR(5) DEFAULT '' NOT NULL,
    PRCH_STAT_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    PRCH_STAT_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    DSCON_TRX_SW VARCHAR(1) DEFAULT '' NOT NULL,
    DSCON_DT DATE DEFAULT CURRENT DATE NOT NULL,
    DSCON_RSN_CD VARCHAR(5) DEFAULT '' NOT NULL,
    DSCON_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    DSCON_CMT VARCHAR(50) DEFAULT '' NOT NULL,
    NEW_ITM_RSN_CD VARCHAR(1) DEFAULT '' NOT NULL,
    PO_CMT VARCHAR(30) DEFAULT '' NOT NULL,
    CST_LNK_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    CST_LNK_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    USE_CST_LNK_SW VARCHAR(1) DEFAULT '' NOT NULL,
    CST_LNK_ID INT DEFAULT 0 NOT NULL,
    MFG_ID VARCHAR(20) DEFAULT '' NOT NULL,
    SHP_CS_LN DECIMAL(7,2) DEFAULT 0 NOT NULL,
    SHP_CS_WD DECIMAL(7,2) DEFAULT 0 NOT NULL,
    SHP_CS_HT DECIMAL(7,2) DEFAULT 0 NOT NULL,
    SHP_CU DECIMAL(9,3) DEFAULT 0 NOT NULL,
    SHP_NEST_CU DECIMAL(9,3) DEFAULT 0 NOT NULL,
    SHP_NEST_MAX_QTY INT DEFAULT 0 NOT NULL,
    SHP_WT DECIMAL(9,3) DEFAULT 0 NOT NULL,
    AVG_WT DECIMAL(9,3) DEFAULT 0 NOT NULL,
    PAL_TI INT DEFAULT 0 NOT NULL,
    PAL_TIER INT DEFAULT 0 NOT NULL,
    PAL_QTY INT DEFAULT 0 NOT NULL,
    SHP_INR_PK DECIMAL(5,0) DEFAULT 0 NOT NULL,
    LST_UPDT_DT DATE DEFAULT CURRENT DATE NOT NULL,
    LST_UPDT_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    LST_UPDT_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    SRS_SCOPE_IND VARCHAR(1) DEFAULT '' NOT NULL,
    VAR_WT_SW VARCHAR(1) DEFAULT '' NOT NULL,
    CTCH_WT_SW VARCHAR(1) DEFAULT '' NOT NULL,
    CMPTR_SETUP_IND VARCHAR(1) DEFAULT '' NOT NULL,
    ITM_REMARK_SW VARCHAR(1) DEFAULT '' NOT NULL,
    DALY_HIST_SW VARCHAR(1) DEFAULT '' NOT NULL,
    TRNSFR_AVAIL_SW VARCHAR(1) DEFAULT '' NOT NULL,
    PO_RCMD_SW VARCHAR(1) DEFAULT '' NOT NULL,
    ORD_INRVL_DD INT DEFAULT 0 NOT NULL,
    ORD_QTY_TYP_CD VARCHAR(5) DEFAULT '' NOT NULL,
    ORD_PNT_QTY INT DEFAULT 0 NOT NULL,
    SAFE_STCK_QTY INT DEFAULT 0 NOT NULL,
    FCST_TYP_CD VARCHAR(5) DEFAULT '' NOT NULL,
    SESNL_IND_CD VARCHAR(5) DEFAULT '' NOT NULL,
    VEND_TRGT_SVCLV DECIMAL(5,2) DEFAULT 0 NOT NULL,
    WHSE_TRGT_SVCLV DECIMAL(5,2) DEFAULT 0 NOT NULL,
    CS_UNT_FACTR_1 DECIMAL(9,4) DEFAULT 0 NOT NULL,
    CS_UNT_FACTR_2 DECIMAL(9,4) DEFAULT 0 NOT NULL,
    CS_MVT_PRWK INT DEFAULT 0 NOT NULL,
    CS_MVT_DESEAS_PRWK INT DEFAULT 0 NOT NULL,
    MAD_MVT_QTY DECIMAL(9,3) DEFAULT 0 NOT NULL,
    EXPCT_WKLY_MVT INT DEFAULT 0 NOT NULL,
    FCST_GRP VARCHAR(10) DEFAULT '' NOT NULL,
    CURR_PKSLT VARCHAR(10) DEFAULT '' NOT NULL,
    PAL_STK_LIM_QTY INT DEFAULT 0 NOT NULL,
    BULK_PCK_QTY INT DEFAULT 0 NOT NULL,
    PAL_SZ_CD VARCHAR(5) DEFAULT '' NOT NULL,
    FLR_STK_IND VARCHAR(1) DEFAULT '' NOT NULL,
    MAND_FLW_THRG_SW VARCHAR(1) DEFAULT '' NOT NULL,
    FLW_THRGH_TYP_CD VARCHAR(1) DEFAULT '' NOT NULL,
    PRIOR_AVG_CST DECIMAL(11,4) DEFAULT 0 NOT NULL,
    CURR_AVG_CST DECIMAL(11,4) DEFAULT 0 NOT NULL,
    BIL_CST DECIMAL(11,4) DEFAULT 0 NOT NULL,
    SUGG_BILL_CST DECIMAL(11,4) DEFAULT 0 NOT NULL,
    MVT_PCT_CD VARCHAR(2) DEFAULT '' NOT NULL,
    BILLABLE_QTY INT DEFAULT 0 NOT NULL,
    DAMAGED_QTY INT DEFAULT 0 NOT NULL,
    DSTRB_RES_QTY INT DEFAULT 0 NOT NULL,
    TOT_ON_HAND_QTY INT DEFAULT 0 NOT NULL,
    OFSIT_QTY INT DEFAULT 0 NOT NULL,
    ON_HLD_QTY INT DEFAULT 0 NOT NULL,
    PLUG_QTY INT DEFAULT 0 NOT NULL,
    CYCL_STCK_QTY INT DEFAULT 0 NOT NULL,
    TURN_INVEN_QTY INT DEFAULT 0 NOT NULL,
    PROMO_INVEN_QTY INT DEFAULT 0 NOT NULL,
    FWDBY_INVEN_QTY INT DEFAULT 0 NOT NULL,
    SHP_FROM_TYP_CD VARCHAR(2) DEFAULT '' NOT NULL,
    SHP_FROM_LOC_NBR INT DEFAULT 0 NOT NULL,
    DEAL_ITM_IND VARCHAR(1) DEFAULT '' NOT NULL,
    MAND_FLW_THRU_SW VARCHAR(1) DEFAULT '' NOT NULL,
    FLW_TYP_CD VARCHAR(3) DEFAULT '' NOT NULL,
    ADDED_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    ADDED_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    GNRC_OVRD_CLS DECIMAL(3,0) DEFAULT 0 NOT NULL,
    MAX_SHP_WHSE_QTY INT DEFAULT 99999 NOT NULL,
    OVRD_HEB_SHP_PK_QTY DECIMAL(5,0) DEFAULT 0 NOT NULL,
    REPL_SYS_CD VARCHAR(5) DEFAULT '' NOT NULL,
    CONVEY_SW VARCHAR(1) DEFAULT 'N' NOT NULL,
    BINABLE_SW VARCHAR(1) DEFAULT 'N' NOT NULL,
    MAX_SHP_TO_EDC_QTY INT DEFAULT 0 NOT NULL,
    PO_EVNT_RES_QTY INT DEFAULT 0 NOT NULL,
    ADHOC_RES_QTY INT DEFAULT 0 NOT NULL

);

ALTER TABLE whse_loc_itm ADD PRIMARY KEY (itm_key_typ_cd, itm_id, whse_loc_typ_cd, whse_loc_nbr);

-----------------------------------------------
-- PROD_SCN_CODES
-----------------------------------------------

CREATE TABLE PROD_SCN_CODES
(
    SCN_CD_ID DECIMAL(17,0) NOT NULL,
    PROD_ID INT DEFAULT 0 NOT NULL,
    SCN_TYP_CD CHAR(5) DEFAULT '' NOT NULL,
    PRIM_SCN_CD_SW CHAR(1) DEFAULT '' NOT NULL,
    BNS_SCN_CD_SW CHAR(1) DEFAULT '' NOT NULL,
    SCN_CD_CMT CHAR(30) DEFAULT '' NOT NULL,
    RETL_UNT_LN DECIMAL(7,2) DEFAULT 0 NOT NULL,
    RETL_UNT_WD DECIMAL(7,2) DEFAULT 0 NOT NULL,
    RETL_UNT_HT DECIMAL(7,2) DEFAULT 0 NOT NULL,
    RETL_UNT_WT DECIMAL(9,4) DEFAULT 0 NOT NULL,
    RETL_SELL_SZ_CD_1 CHAR(2) DEFAULT '' NOT NULL,
    RETL_UNT_SELL_SZ_1 DECIMAL(7,2) DEFAULT 0 NOT NULL,
    RETL_SELL_SZ_CD_2 CHAR(2) DEFAULT '' NOT NULL,
    RETL_UNT_SELL_SZ_2 DECIMAL(7,2) DEFAULT 0 NOT NULL,
    SAMP_PROVD_SW CHAR(1) DEFAULT 'N' NOT NULL,
    PRPRC_OFF_PCT DECIMAL(9,4) DEFAULT 0 NOT NULL,
    PROD_SUB_BRND_ID INT DEFAULT 0 NOT NULL,
    FRST_SCN_DT DATE DEFAULT '1600-01-01' NOT NULL,
    LST_SCN_DT DATE DEFAULT '1600-01-01' NOT NULL,
    CONSM_UNT_ID INT DEFAULT 0 NOT NULL,
    TAG_ITM_ID DECIMAL(17,0) DEFAULT 0 NOT NULL,
    TAG_ITM_KEY_TYP_CD CHAR(5) DEFAULT '' NOT NULL,
    TAG_SZ_DES CHAR(6) DEFAULT '' NOT NULL,
    WIC_SW CHAR(1) DEFAULT 'N' NOT NULL,
    LEB_SW CHAR(1) DEFAULT 'N' NOT NULL,
    WIC_APL_ID DECIMAL(17,0) DEFAULT 0 NOT NULL,
    FAM_3_CD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    FAM_4_CD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    DSD_DELD_SW CHAR(1) DEFAULT '' NOT NULL,
    DSD_DEPT_OVRD_SW CHAR(1) DEFAULT '' NOT NULL,
    UPC_ACTV_SW CHAR(1) DEFAULT '' NOT NULL,
    SCALE_SW CHAR(1) DEFAULT '' NOT NULL,
    WIC_UPDT_USR_ID CHAR(8) DEFAULT '' NOT NULL,
    WIC_LST_UPDT_TS TIMESTAMP DEFAULT '1600-01-01-12.00.00.000000' NOT NULL,
    LEB_UPDT_USR_ID CHAR(8) DEFAULT '' NOT NULL,
    LEB_LST_UPDT_TS TIMESTAMP DEFAULT '1600-01-01-12.00.00.000000' NOT NULL,
    CRE8_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CRE8_UID CHAR(8) DEFAULT '' NOT NULL,
    LST_UPDT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LST_UPDT_UID CHAR(8) DEFAULT '' NOT NULL,
    LST_SYS_UPDT_ID INT DEFAULT 0 NOT NULL,
    PSE_GRAMS_WT DECIMAL(9,4) DEFAULT 0 NOT NULL,
    TST_SCN_PRFMD_SW CHAR(1) DEFAULT 'N' NOT NULL,
    DSCON_DT DATE DEFAULT '1600-01-01' NOT NULL,
    PROC_SCN_MAINT_SW CHAR(1) DEFAULT 'Y' NOT NULL

);
ALTER TABLE PROD_SCN_CODES ADD PRIMARY KEY (SCN_CD_ID);


-----------------------------------------------
-- PROD_MASTER
-----------------------------------------------
CREATE TABLE PRODUCT_MASTER
(
    PROD_ID INT NOT NULL,
    PROD_ENG_DES VARCHAR(30)  NOT NULL,
    PROD_SPNSH_DES VARCHAR(30) NOT NULL,
    PROD_TYP_CD VARCHAR(5) NOT NULL,
    PD_OMI_COM_CLS_CD DECIMAL(3,0) NOT NULL,
    PD_OMI_COM_CD DECIMAL(5,0) NOT NULL,
    PD_OMI_SUB_COM_CD DECIMAL(5,0) NOT NULL,
    IMS_COM_CD DECIMAL(5,0) NOT NULL,
    IMS_SUB_COM_CD VARCHAR(1) NOT NULL,
    GRMGN_PCT DECIMAL(7,4) NOT NULL,
    SALS_RSTR_CD VARCHAR(5) NOT NULL,
    BDM_CD VARCHAR(5) NOT NULL,
    LBL_LANG_TXT VARCHAR(10) NOT NULL,
    RETL_GRP_NBR DECIMAL(5,0) NOT NULL,
    STR_DEPT_NBR VARCHAR(5),
    STR_SUB_DEPT_ID VARCHAR(5),
    RETL_LINK_CD DECIMAL(7,0) NOT NULL,
    PSS_DEPT_1 INT NOT NULL,
    OB_SUB_BRND_ID INT NOT NULL,
    PROD_BRND_ID INT NOT NULL,
    FRST_SCN_DT DATE NOT NULL,
    LST_SCN_DT DATE NOT NULL,
    GBB_SW VARCHAR(1) NOT NULL,
    KVIL_SW VARCHAR(1) NOT NULL,
    NBB_SW VARCHAR(1) NOT NULL,
    OPP_SW VARCHAR(1) NOT NULL,
    LEB_SW VARCHAR(1) NOT NULL,
    SENS_SW VARCHAR(1) NOT NULL,
    MGN_SW VARCHAR(1) NOT NULL,
    TAG_ITM_ID DECIMAL(17,0) NOT NULL,
    TAG_ITM_KEY_TYP_CD VARCHAR(5) NOT NULL,
    PROD_SZ_TXT VARCHAR(12) NOT NULL,
    RC_IM_QTY_REQ_FLAG VARCHAR(1) NOT NULL,
    RC_IM_PRC_REQ_FLAG VARCHAR(1) NOT NULL,
    PROD_PRIM_SCN_ID DECIMAL(17,0) NOT NULL,
    CRE8_TS TIMESTAMP NOT NULL,
    CRE8_UID VARCHAR(8) NOT NULL,
    LST_UPDT_TS TIMESTAMP NOT NULL,
    LST_UPDT_UID VARCHAR(8) NOT NULL,
    LST_SYS_UPDT_ID INT NOT NULL,
    MKT_CD VARCHAR(5) NOT NULL,
    LST_PUB_TS TIMESTAMP,
    LST_PUB_UID VARCHAR(8),
    SUBSCR_PROD_SW VARCHAR(1) NOT NULL,
    PROD_TEMP_CNTL_CD VARCHAR(5),
    GIFT_MSG_REQ_SW VARCHAR(1) NOT NULL,
    SUBSCR_STRT_DT DATE NOT NULL,
    SUBSCR_END_DT DATE NOT NULL,
    TAX_QUAL_CD VARCHAR(10),
);
ALTER TABLE PRODUCT_MASTER ADD PRIMARY KEY (PROD_ID);

-----------------------------------------------
-- PROD_ITEM
-----------------------------------------------
CREATE TABLE PROD_ITEM
(
    ITM_KEY_TYP_CD VARCHAR(5) NOT NULL,
    ITM_ID DECIMAL(17,0) NOT NULL,
    PROD_ID INT NOT NULL,
    RETL_PACK_QTY INT NOT NULL,
    CRE8_TS TIMESTAMP NOT NULL,
    CRE8_UID VARCHAR(8) NOT NULL,
);
ALTER TABLE PROD_ITEM ADD PRIMARY KEY(itm_key_typ_cd, itm_id,PROD_ID);

-----------------------------------------------
-- PD_UPC
-----------------------------------------------
CREATE TABLE PD_UPC (
	PD_UPC_NO DECIMAL(13, 0) NOT NULL,
	PD_ITEM_NO DECIMAL(7, 0) NOT NULL,
	PD_RETAIL_GROUP_NO DECIMAL(3, 0) NOT NULL,
	LST_UPDT_UID VARCHAR(20) NOT NULL
);
ALTER TABLE PD_UPC ADD PRIMARY KEY(PD_UPC_NO);

-----------------------------------------------
-- PD_ASSOCIATED_UPC
-----------------------------------------------

CREATE TABLE PD_ASSOCIATED_UPC
(
    PD_ASSOC_UPC_NO DECIMAL(13,0) NOT NULL,
    PD_UPC_NO DECIMAL(13,0) NOT NULL,
    LST_UPDT_UID VARCHAR(20) NOT NULL,
);
ALTER TABLE PD_ASSOCIATED_UPC ADD PRIMARY KEY(PD_ASSOC_UPC_NO);

-----------------------------------------------
-- PD_SHIPPER
-----------------------------------------------

CREATE TABLE PD_SHIPPER
(
    PD_UPC_NO DECIMAL(13,0) NOT NULL,
    PD_SHPR_UPC_NO DECIMAL(13,0) NOT NULL,
    PD_SHPR_QTY DECIMAL(5,0) NOT NULL,
    PD_SHPR_TYP_CD VARCHAR(1) NOT NULL,
    LST_UPDT_UID VARCHAR(20) NOT NULL,
);

ALTER TABLE PD_SHIPPER ADD PRIMARY KEY(PD_UPC_NO,PD_SHPR_UPC_NO);

-----------------------------------------------
-- PROD_DEL_CNTL_PARM
-----------------------------------------------
 CREATE TABLE PROD_DEL_CNTL_PARM
(
    SYS_GEND_ID INT NOT NULL,
    SEQ_NBR DECIMAL(5,0) NOT NULL,
    PARM_NM VARCHAR (30) NOT NULL,
    PARM_VAL_TXT VARCHAR (50) NOT NULL,
    PRTY_NBR INT NOT NULL,
    ACTV_SW VARCHAR(1) NOT NULL
);
ALTER TABLE PROD_DEL_CNTL_PARM ADD PRIMARY KEY(sys_gend_id,seq_nbr);

-----------------------------------------------
-- PROD_DEL_EXCP_RULE
-----------------------------------------------
CREATE TABLE PROD_DEL_EXCP_RULE
(
    SYS_GEND_ID INT NOT NULL,
    SEQ_NBR DECIMAL(5,0) NOT NULL,
    EXCP_SEQ_NBR INT NOT NULL,
    PARM_VAL_TXT VARCHAR (50) NOT NULL,
    PRTY_NBR INT NOT NULL,
    EXCP_ATTR_VAL_TXT VARCHAR(18) NOT NULL,
    EXCP_ATTR_NM VARCHAR (20) NOT NULL,
    ACTV_SW VARCHAR(1) NOT NULL,
    NEV_DEL_SW VARCHAR(1) NOT NULL
);
ALTER TABLE PROD_DEL_EXCP_RULE ADD PRIMARY KEY(sys_gend_id,seq_nbr, excp_seq_nbr);


-----------------------------------------------
-- STR_DEPT
-----------------------------------------------

CREATE TABLE STR_DEPT
(
    STR_DEPT_NBR VARCHAR(5) NOT NULL,
    STR_SUB_DEPT_ID VARCHAR(5) NOT NULL,
    DEPT_NM VARCHAR(30) NOT NULL,
    DEPT_ABB VARCHAR(6) NOT NULL,
    REPT_GRP_CD INT NOT NULL,
    GRPRFT_LO_PCT DECIMAL(7,4) NOT NULL,
    GRPRFT_HI_PCT DECIMAL(7,4) NOT NULL,
    SHRNK_LO_PCT DECIMAL(7,4) NOT NULL,
    SHRNK_HI_PCT DECIMAL(7,4) NOT NULL,
    LST_UPDT_USR_ID VARCHAR(8) NOT NULL,
    LST_UPDT_TS TIMESTAMP NOT NULL,
    ORG_ID INT NOT NULL
);

ALTER TABLE STR_DEPT ADD  PRIMARY KEY (STR_DEPT_NBR, STR_SUB_DEPT_ID);


-----------------------------------------------
-- PD_CLASS_COMMODITY
-----------------------------------------------
CREATE TABLE PD_CLASS_COMMODITY
(
    PD_OMI_COM_CLS_CD DECIMAL(3,0) NOT NULL,
    PD_OMI_COM_CD DECIMAL(5,0) NOT NULL,
    PD_OMI_COM_DES VARCHAR(30),
    PD_OMI_DIR_CD DECIMAL(3,0),
    PD_APPR_QA_CD VARCHAR(1),
    PD_NIELS_CD DECIMAL(5,0),
    PC_CLS_COM_ACTV_CD VARCHAR(1),
    PD_PSS_DEPT_NO DECIMAL(3,0),
    LOG_COUNTER DECIMAL(15,0),
    BDM_CD VARCHAR(5),
    IMS_COM_CD DECIMAL(3,0),
    ALLOW_MULT_VEND_SW VARCHAR(1),
    ENFORCE_PACK_SZ_SW VARCHAR(1),
    DFLT_SALS_RSTR_CD VARCHAR(5),
    ECOMM_BUS_MGR_ID VARCHAR(20),
    DFLT_SUBSCR_PD_SW VARCHAR(1),
    BDA_UID VARCHAR(20),
    DFLT_TMPLT_ID VARCHAR(20),
    MAX_CUST_ORD_QTY INT,
    CRE8_ID VARCHAR(20),
    CRE8_TS TIMESTAMP,
    LST_UPDT_UID VARCHAR(20),
    LST_UPDT_TS TIMESTAMP
);

ALTER TABLE PD_CLASS_COMMODITY ADD PRIMARY KEY (PD_OMI_COM_CLS_CD, PD_OMI_COM_CD);

-----------------------------------------------
-- PD_CLS_COM_SUB_COM
-----------------------------------------------
CREATE TABLE PD_CLS_COM_SUB_COM
(
    PD_OMI_COM_CLS_CD DECIMAL(3,0) NOT NULL,
    PD_OMI_COM_CD DECIMAL(5,0) NOT NULL,
    PD_OMI_SUB_COM_CD DECIMAL(5,0) NOT NULL,
    PD_ITEM_CLASS_CD DECIMAL(3,0) NOT NULL,
    PD_COM_CD DECIMAL(3,0) NOT NULL,
    PD_SUB_COM_CD VARCHAR(1) NOT NULL,
    PD_OMI_COM_DES VARCHAR(30) NOT NULL,
    PC_SUB_COM_ACTV_CD VARCHAR(1) NOT NULL,
    RL_SUB_COM_HGM_PCT DECIMAL(5,1) NOT NULL,
    RL_SUB_COM_LGM_PCT DECIMAL(5,1) NOT NULL,
    PD_LABR_CAT_CD VARCHAR(2) NOT NULL,
    PD_FD_STAMP_CD VARCHAR(1) NOT NULL,
    PD_CRG_TAX_CD VARCHAR(1) NOT NULL,
    LOG_COUNTER DECIMAL(15,0) NOT NULL,
    DFLT_RETL_SELL_CD VARCHAR(2) DEFAULT '' NOT NULL,
    PROD_CAT_ID INT DEFAULT 0 NOT NULL,
    DF_MAX_SHLF_LIF_DD INT DEFAULT 0 NOT NULL,
    DF_INBND_SPCFN_DD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    DF_REACT_DD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    DF_GUARN_TO_STR_DD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    DF_GIFT_MSG_REQ_SW VARCHAR(1) DEFAULT 'N' NOT NULL,
    VERTEX_TAX_CAT_CD VARCHAR(40) DEFAULT '' NOT NULL,
    CRE8_ID VARCHAR(20) DEFAULT '' NOT NULL,
    CRE8_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    LST_UPDT_UID VARCHAR(20) DEFAULT '' NOT NULL,
    LST_UPDT_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    VERTEX_NON_TAX_CD VARCHAR(40) DEFAULT '' NOT NULL
);

ALTER TABLE PD_CLS_COM_SUB_COM ADD PRIMARY KEY (PD_OMI_COM_CLS_CD, PD_OMI_COM_CD, PD_OMI_SUB_COM_CD);

-----------------------------------------------
-- PROD_DEL_EXCP_AUD
-----------------------------------------------

CREATE TABLE PROD_DEL_EXCP_AUD
(
    CRE8_TS TIMESTAMP NOT NULL,
    SYS_GEND_ID INT DEFAULT 0 NOT NULL,
    SEQ_NBR INT DEFAULT 0 NOT NULL,
    EXCP_SEQ_NBR INT DEFAULT 0 NOT NULL,
    ACT_CD VARCHAR(5) DEFAULT '' NOT NULL,
    PARM_VAL_TXT VARCHAR(50) DEFAULT '' NOT NULL,
    PRTY_NBR INT DEFAULT 0 NOT NULL,
    EXCP_ATTR_VAL_TXT VARCHAR(18) DEFAULT '' NOT NULL,
    EXCP_ATTR_NM VARCHAR(20) DEFAULT '' NOT NULL,
    ACTV_SW VARCHAR(1) DEFAULT '' NOT NULL,
    NEV_DEL_SW VARCHAR(1) DEFAULT '' NOT NULL,
    CRE8_ID VARCHAR(20) DEFAULT '' NOT NULL
);
ALTER TABLE PROD_DEL_EXCP_AUD ADD PRIMARY KEY (CRE8_TS);

-----------------------------------------------
-- PROD_DEL_PARM_AUD
-----------------------------------------------

CREATE TABLE PROD_DEL_PARM_AUD
(
    CRE8_TS TIMESTAMP NOT NULL,
    SYS_GEND_ID INT DEFAULT 0 NOT NULL,
    SEQ_NBR INT DEFAULT 0 NOT NULL,
    ACT_CD VARCHAR(5) DEFAULT '' NOT NULL,
    PARM_NM VARCHAR(30) DEFAULT '' NOT NULL,
    PARM_VAL_TXT VARCHAR(50) DEFAULT '' NOT NULL,
    PRTY_NBR INT DEFAULT 0 NOT NULL,
    ACTV_SW VARCHAR(1) DEFAULT '' NOT NULL,
    CRE8_ID VARCHAR(20) DEFAULT '' NOT NULL
);
ALTER TABLE PROD_DEL_PARM_AUD ADD PRIMARY KEY (CRE8_TS);

-----------------------------------------------
-- WHSE_LOC_ITM_EXTN
-----------------------------------------------

CREATE TABLE WHSE_LOC_ITM_EXTN
(
    ITM_KEY_TYP_CD VARCHAR(5) DEFAULT '' NOT NULL,
    ITM_ID DECIMAL(17,0) DEFAULT 0 NOT NULL,
    WHSE_LOC_TYP_CD VARCHAR(2) DEFAULT '' NOT NULL,
    WHSE_LOC_NBR INT DEFAULT 0 NOT NULL,
    IM_LST_RECEIPT_CST DECIMAL(9,4) DEFAULT 0 NOT NULL,
    HI_ACTL_SVC DECIMAL(3,0) DEFAULT 0 NOT NULL,
    HI_DAYS_ORDERED DECIMAL(3,0) DEFAULT 0 NOT NULL,
    HI_DAYS_OUT DECIMAL(3,0) DEFAULT 0 NOT NULL,
    HI_FIRST_RECEIVED DECIMAL(6,0) DEFAULT 0 NOT NULL,
    HI_LST_CST DECIMAL(9,4) DEFAULT 0 NOT NULL,
    HI_LST_CST_CHG_DT DECIMAL(8,0) DEFAULT 0 NOT NULL,
    HI_LAST_RECEIVED DECIMAL(6,0) DEFAULT 0 NOT NULL,
    HI_LST_RECD_PO_NBR DECIMAL(6,0) DEFAULT 0 NOT NULL,
    HI_LAST_SHIPPED_DT INT DEFAULT 0 NOT NULL,
    HI_OLD_LAST_CST DECIMAL(9,4) DEFAULT 0 NOT NULL,
    HI_ON_ORD_FWD_BUY DECIMAL(7,0) DEFAULT 0 NOT NULL,
    HI_ON_ORD_PROMO DECIMAL(7,0) DEFAULT 0 NOT NULL,
    HI_ON_ORD_TOTAL DECIMAL(9,0) DEFAULT 0 NOT NULL,
    HI_ON_ORD_TURN DECIMAL(7,0) DEFAULT 0 NOT NULL,
    HI_QTY_LAST_RECD DECIMAL(7,0) DEFAULT 0 NOT NULL,
    HI_WTD_OOS_DOLLAR DECIMAL(9,2) DEFAULT 0 NOT NULL,
    HI_WTD_OOS_UNIT DECIMAL(5,0) DEFAULT 0 NOT NULL,
);
ALTER TABLE WHSE_LOC_ITM_EXTN ADD PRIMARY KEY (ITM_KEY_TYP_CD, ITM_ID, WHSE_LOC_TYP_CD, WHSE_LOC_NBR);

-----------------------------------------------
-- BDM
-----------------------------------------------

CREATE TABLE BDM
(
    BDM_CD VARCHAR(5) NOT NULL,
    BDM_FRST_NM VARCHAR(20) DEFAULT '' NOT NULL,
    DBM_LST_NM VARCHAR(20) DEFAULT '' NOT NULL,
    BDM_FULL_NM VARCHAR(30) DEFAULT '' NOT NULL,
    BDM_OMI_NBR DECIMAL(3,0) DEFAULT 0 NOT NULL,
    BDM_IMS_CD VARCHAR(2) DEFAULT '' NOT NULL,
    ACTV_SW VARCHAR(1) DEFAULT '' NOT NULL,
    DIRECTOR_ID INT DEFAULT 0 NOT NULL,
    PRIM_FUNC_CD_1 VARCHAR(10) DEFAULT '' NOT NULL,
    PRIM_FUNC_CD_2 VARCHAR(10) DEFAULT '' NOT NULL,
    PRIM_GRP_NBR_1 INT DEFAULT 0 NOT NULL,
    PRIM_GRP_NBR_2 INT DEFAULT 0 NOT NULL,
    LST_UPDT_TS TIMESTAMP DEFAULT CURRENT TIMESTAMP NOT NULL,
    LST_UPDT_USR_ID VARCHAR(8) DEFAULT '' NOT NULL,
    BDM_EMAIL_ID VARCHAR(50) DEFAULT '' NOT NULL,
    USR_ID VARCHAR(20) DEFAULT '' NOT NULL,
    GL_ACCT_NBR VARCHAR(30) DEFAULT '' NOT NULL
);
ALTER TABLE BDM ADD PRIMARY KEY (BDM_CD);


-----------------------------------------------
-- ITM_NT_DELD_RSN
-----------------------------------------------

CREATE TABLE ITM_NT_DELD_RSN
(
    ITM_NT_DELD_RSN_CD VARCHAR(5) NOT NULL,
    ITM_NT_DELD_RSN_ABB VARCHAR(6) NOT NULL,
    ITM_NT_DELD_RSN_DES VARCHAR(50) NOT NULL,
    USR_INSTN_TXT CHAR(500)
);
ALTER TABLE ITM_NT_DELD_RSN ADD PRIMARY KEY (ITM_NT_DELD_RSN_CD);


-----------------------------------------------
-- MST_DTA_EXTN_ATTR
-----------------------------------------------

CREATE TABLE MST_DTA_EXTN_ATTR
(
    ATTR_ID INT NOT NULL,
    KEY_ID DECIMAL(18,0) NOT NULL,
    ITM_PROD_KEY_CD VARCHAR (5) NOT NULL,
    SEQ_NBR DECIMAL(5,0) NOT NULL,
    DTA_SRC_SYS INT NOT NULL,
    ATTR_CD_ID INT,
    ATTR_VAL_TXT VARCHAR(5000),
    ATTR_VAL_NBR DECIMAL(18,4),
    ATTR_VAL_DT DATE,
    ATTR_VAL_TS TIMESTAMP,
    CRE8_UID CHAR(20) DEFAULT '' NOT NULL,
    CRE8_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LST_UPDT_UID CHAR(20) DEFAULT '' NOT NULL,
    LST_UPDT_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
ALTER TABLE MST_DTA_EXTN_ATTR ADD PRIMARY KEY (ATTR_ID, KEY_ID, ITM_PROD_KEY_CD, SEQ_NBR, DTA_SRC_SYS);

-----------------------------------------------
-- SRC_SYSTEM
-----------------------------------------------
CREATE TABLE SRC_SYSTEM
(
    SRC_SYSTEM_ID INT NOT NULL,
    SRC_SYSTEM_ABB VARCHAR(5) DEFAULT '' NOT NULL,
    SRC_SYSTEM_DES VARCHAR(50) DEFAULT '' NOT NULL
);
ALTER TABLE SRC_SYSTEM ADD PRIMARY KEY (SRC_SYSTEM_ID);

-----------------------------------------------
-- SL_SCALESCAN
-----------------------------------------------
CREATE TABLE SL_SCALESCAN
(
    UPC_KEY DECIMAL(13,0) NOT NULL,
    MAINT_FUNCTION VARCHAR(1) NOT NULL,
    EFFECTIVE_DATE DATE NOT NULL,
    STRIP_FLAG VARCHAR(1) NOT NULL,
    TARE_SERV_COUNTER DECIMAL(4,3) NOT NULL,
    TARE_PREPACK DECIMAL(4,3) NOT NULL,
    SHELF_LIFE DECIMAL(3,0) NOT NULL,
    EAT_BY_DAYS DECIMAL(3,0) NOT NULL,
    FREEZE_BY_DAYS DECIMAL(3,0) NOT NULL,
    INGR_STATEMENT_NUM DECIMAL(7,0) NOT NULL,
    PD_NTRNT_STMT_NO DECIMAL(7,0) NOT NULL,
    PD_HILITE_PRNT_CD DECIMAL(5,0) NOT NULL,
    PD_SAFE_HAND_CD DECIMAL(5,0) NOT NULL,
    PRODUCT_DESC_LINE1 VARCHAR(50) NOT NULL,
    PRODUCT_DESC_LINE2 VARCHAR(50) NOT NULL,
    SPANISH_DESC_LINE1 VARCHAR(50) NOT NULL,
    SPANISH_DESC_LINE2 VARCHAR(50) NOT NULL,
    SL_LBL_FRMAT_1_CD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    SL_LBL_FRMAT_2_CD DECIMAL(5,0) DEFAULT 0 NOT NULL,
    FRC_TARE_SW CHAR(1) DEFAULT 'N' NOT NULL,
    GRADE_NBR DECIMAL(3,0) DEFAULT 0 NOT NULL,
    NET_WT DECIMAL(9,4) DEFAULT 0 NOT NULL,
    PRC_OVRD_SW CHAR(1) DEFAULT '' NOT NULL,
    PRODUCT_DESC_LINE3 VARCHAR(50) DEFAULT '' NOT NULL,
    PRODUCT_DESC_LINE4 VARCHAR(50) DEFAULT '' NOT NULL,
    SPANISH_DESC_LINE3 VARCHAR(50) DEFAULT '' NOT NULL,
    SPANISH_DESC_LINE4 VARCHAR(50) DEFAULT '' NOT NULL
);
ALTER TABLE SL_SCALESCAN ADD PRIMARY KEY (UPC_KEY);

-----------------------------------------------
-- SL_LABEL_FORMAT
-----------------------------------------------
CREATE TABLE SL_LABEL_FORMAT
(
    SL_LBL_FRMAT_CD DECIMAL(5) NOT NULL,
    SL_LBL_FRMAT_DES VARCHAR(30) NOT NULL
);
ALTER TABLE SL_LABEL_FORMAT ADD PRIMARY KEY(SL_LBL_FRMAT_CD);

-----------------------------------------------
-- SL_SCALESCAN
-----------------------------------------------
CREATE TABLE SL_INGREDIENT
(
    INGREDIENT_CODE CHAR(5) NOT NULL,
    SOI_FLAG CHAR(1) NOT NULL,
    MAINT_FUNCTION CHAR(1) NOT NULL,
    PD_INGRD_EXT_DES CHAR(20) NOT NULL,
    PD_INGRD_CAT_CD DECIMAL(3,0) NOT NULL,
    INGREDIENT_DESC VARCHAR(50) NOT NULL,
);
ALTER TABLE SL_INGREDIENT ADD PRIMARY KEY (INGREDIENT_CODE);

-----------------------------------------------
-- PD_NUTRIENT_RULES
-----------------------------------------------
CREATE TABLE PD_NUTRIENT_RULES
(
    PD_LBL_NTRNT_CD DECIMAL(3,0) NOT NULL,
    PD_NTRNT_BRNG_QTY DECIMAL(5,0) NOT NULL,
    PD_NTRNT_ERNG_QTY DECIMAL(5,0) NOT NULL,
    PD_NTRNT_INCRM_QTY DECIMAL(5,1) NOT NULL,
);
ALTER TABLE PD_NUTRIENT_RULES ADD PRIMARY KEY (PD_LBL_NTRNT_CD, PD_NTRNT_BRNG_QTY);

-----------------------------------------------
-- sl_ingrd_stmt_hdr
-----------------------------------------------

CREATE TABLE SL_INGRD_STMT_HDR
(
    PD_INGRD_STMT_NO DECIMAL(7,0)NOT NULL,
    PD_INGRD_MAINT_DT DATE NOT NULL,
    PD_INGRD_MAINT_SW VARCHAR(1) NOT NULL,
    PD_MAINT_TYP_CD VARCHAR(1) NOT NULL
);
ALTER TABLE SL_INGRD_STMT_HDR ADD PRIMARY KEY (PD_INGRD_STMT_NO);

-----------------------------------------------
-- sl_ingrd_stmt_dtl
-----------------------------------------------

 CREATE TABLE SL_INGRD_STMT_DTL
(
    PD_INGRD_STMT_NO DECIMAL(7,0) NOT NULL,
    PD_INGRD_CD VARCHAR(5) NOT NULL,
    PD_INGRD_PCT DECIMAL(7,4) NOT NULL,
);
ALTER TABLE SL_INGRD_STMT_DTL ADD PRIMARY KEY (PD_INGRD_STMT_NO, PD_INGRD_CD);



