package com.heb.operations.cps.util;

/**
 * Interface which contains all constants in web layer.
 */
public interface CPSConstants extends BusinessConstants {
	public static final String CURRENT_FORM_KEY = "CPSForm";
	public static final String EDI_FORM_KEY = "CPSEDIMain";
	public static final String COMMON_EMBEDDED_LOOKUP_FACADE = "CommonEmbeddedLookUpFacade";

	public static final String DWR_MESSAGE_SESSION_KEY = "DWR_MESSAGE_SESSION_KEY";
	public static final String REGISTERED_VENDOR_ROLE = "RVEND";
	public static final String UNREGISTERED_VENDOR_ROLE = "UVEND";
	public static final String VENDOR_CANDIDATE_ABBR = "VENDOR";

	public static final String DEFAULT_ROLE_ABBREVIATION = "ADMIN";
	public static final String EXEC_ACCESS_CODE = "EX";
	/*
	 * Values for the selected functions. The values are used in disabling the
	 * alerady clicked menu entries.
	 */
	public static final short ADD_NEWCANDIDATE = 1;
	public static final short MAANAGE_CANDIDATE = 2;
	public static final short COPY_PRODUCT = 3;
	public static final short ADD_MRT = 4;
	public static final short COPY_CANDIDATE = 5;
	public static final short MANAGE_OWN_BRAND = 7;
	public static final short CPS_ROLES = 8;
	public static final short CPS_BATCH_UPLOAD = 9;
	public static final short CPS_VOLUME_UPLOAD_PROFILE = 10;
	public static final String LIST_OF_FORMS_TO_BE_CLEARED = "LIST_OF_FORMS_TO_BE_CLEARED";

	// Added Constant for Common Directory where Files will be Uploaded
	public static final String FILE_UPLOAD_PATH = "CPSFileUploadPath";
	public static final String STORED_FILE_NM = "storedFileNm";
	public static final String TYPE_DOCUMENT_HD = "typeDocumentHd";

	public static final String ADD_CAND_BDM_TYPEAHEAD_ID = "bdm";
	public static final String ADD_CAND_COMMODITY_TYPEAHEAD_ID = "commodity";
	public static final String ADD_CAND_SUB_COMMODITY_TYPEAHEAD_ID = "subCommodity";
	public static final String ADD_CAND_BRAND_TYPEAHEAD_ID = "brand";
	public static final String ADD_CAND_SUB_BRAND_TYPEAHEAD_ID = "subbrand";
	public static final String ADD_CAND_INGREDIENT_TYPEAHEAD_ID = "ingredient";
	// Excel
	public static final String EMPTY_STRING = "";
	public static final String VALID_HEADER = "Valid Excel Header";
	public static final String INVALID_HEADER = "InValid Excel Header";

	public static final String PD_UPC_NO = "PD_UPC_NO";
	public static final String PD_ITEM_DES = "PD_ITEM_DES";
	public static final String PD_ITM_SZ_QTY = "PD_ITM_SZ_QTY";
	public static final String PD_RECIP_SW = "PD_RECIP_SW";
	public static final String PD_UPC_TYP_CD = "PD_UPC_TYP_CD";
	public static final String PD_WHSE_DSD_CD = "PD_WHSE_DSD_CD";
	public static final String PD_SELL_UNIT_QTY = "PD_SELL_UNIT_QTY";
	public static final String PD_UNIT_UOM_TXT = "PD_UNIT_UOM_TXT";
	public static final String PROD_DES_TAG1_ENG = "PROD_DES_TAG1_ENG";
	public static final String PROD_DES_TAG2_ENG = "PROD_DES_TAG2_ENG";
	public static final String FC_DP_DEPT_NO = "FC_DP_DEPT_NO";
	public static final String FC_DP_SUB_DEPT_CD = "FC_DP_SUB_DEPT_CD";
	public static final String PD_OMI_COM_CD = "PD_OMI_COM_CD";
	public static final String PD_OMI_SUB_COM_CD = "PD_OMI_SUB_COM_CD";
	public static final String PC_OMI_BUYER_CD = "PC_OMI_BUYER_CD";
	public static final String PD_PSS_DEPT_NO = "PD_PSS_DEPT_NO";
	public static final String PD_ITM_CAT_CD = "PD_ITM_CAT_CD";
	public static final String VD_STR_PRC_GRP_CD = "VD_STR_PRC_GRP_CD";
	public static final String FC_STORE_NO = "FC_STORE_NO";
	public static final String PD_RETL_HT = "PD_RETL_HT";
	public static final String PD_RETL_LN = "PD_RETL_LN";
	public static final String PD_RETL_WD = "PD_RETL_WD";
	public static final String VD_VEND_NO = "VD_VEND_NO";
	public static final String PD_VEND_PROD_CD_NO = "PD_VEND_PROD_CD_NO";
	public static final String PD_MAST_PK_QTY = "PD_MAST_PK_QTY";
	public static final String PD_LIST_CST = "PD_LIST_CST";
	public static final String PD_CORE_UX4_QTY = "PD_CORE_UX4_QTY";
	public static final String PD_CORE_UNIT_CST = "PD_CORE_UNIT_CST";
	public static final String PD_CORE_CHG_CD = "PD_CORE_CHG_CD";
	public static final String PD_CORE_LINK_CD = "PD_CORE_LINK_CD";
	public static final String PD_CORE_MATRX_SW = "PD_CORE_MATRX_SW";
	public static final String PD_CRIT_ITEM_CD = "PD_CRIT_ITEM_CD";
	public static final String PD_CORE_PREPD_PCT = "PD_CORE_PREPD_PCT";
	public static final String PD_PRFX_XFOR_QTY = "PD_PRFX_XFOR_QTY";
	public static final String PD_PRFX_PRICE_CST = "PD_PRFX_PRICE_CST";
	public static final String PD_CORE_TAG_CD = "PD_CORE_TAG_CD";
	public static final String PD_TAG_SZ_CD = "PD_TAG_SZ_CD";
	public static final String PD_NO_TAG_QTY = "PD_NO_TAG_QTY";
	public static final String PD_CRG_TAX_CD = "PD_CRG_TAX_CD";
	public static final String PD_FD_STAMP_CD = "PD_FD_STAMP_CD";
	public static final String PD_FAM_ONE_CD = "PD_FAM_ONE_CD";
	public static final String PD_FAM_TWO_CD = "PD_FAM_TWO_CD";
	public static final String CST_OWN_ID = "CST_OWN_ID";
	public static final String PROD_BRND_ID = "PROD_BRND_ID";
	public static final String T2T_ID = "T2T_ID";
	public static final String PROD_SUB_BRND_ID = "PROD_SUB_BRND_ID";
	public static final String CNTRY_OF_ORIG_ID = "CNTRY_OF_ORIG_ID";
	public static final String COMMENTS = "COMMENTS";
	public static final String PACKAGING = "PACKAGING";
	public static final String BACK_SLASH = " -- ";
	public static final String LESS_ROW_COUNT = "LessRowCount";
	public static final String NEXT_LINE = "\n";
	public static final String BR = "<BR>";
	public static final String COMMA = ",";
	public static final String SEMI_COLON = ":";
	public static final String MRT = "MRT";
	public static final String NONE_MRT = "None-MRT";
	public static final String COPY_CAND = "copyCandidate";
	public static final String COPY_PROD = "copyProduct";
	public static final String WRONG_XL_FORMAT = "WrongXLFormat";
	public static final String CANDIDATE_REJECT_SUCCESS = "Candidate(s) Rejected Successfully";

	public static final String ACTIVE = "Active";
	public static final String AIP = "AIP";
	public static final String ACTIVATE_SUCCESSFULL = "Activated Successfully";
	public static final String SUBMIT_SUCCESSFULL = "Submitted Successfully";
	public static final String CHECK_TESTSCAN = "Please Test Scan Before Activate.";
	public static final String ADD_NEW_OTHER_INFO = "AddNewOtherInfo";
	public static final String VIEW_MASS_PROFILES = "viewMassProfies";
	public static final String QUESTIONNAIRE = "Questionnaire";
	public static final String SELECTED_CASE_VO = "selectedCaseVO";
	public static final String SELECTED_VENDOR_VO = "selectedVendorVO";

	public static final String CPS_MANAGE_MAIN = "CPSManageMain";
	public static final String EDI_MANAGE_MAIN = "EDICandidateSearch";
	public static final String CPS_MANAGE_PRODUCT = "CPSManageProduct";
	public static final String CPS_PRODUCT_SEARCH = "CPSProductSearch";
	public static final String PROD_FILTER_RESULTS = "ProdFilterResults";

	public static final String VENDOR_CANDIDATE_STATUS = "Vendor Candidate";
	public static final String REJECTED = "Rejected";
	public static final String WORKING_CANDIDATE_STATUS = "Working Candidate";
	public static final String ACTIVATION_FAILED_STATUS = "Activation Failed";
	public static final String ACTIVATION_VALIDATE_RETAIL = "Please input Retail values and Retail values must be greater than 0.";

	public static final String CANDIDATES_FOUND = " Candidates Found";
	public static final String CANDIDATE_FOUND = " Candidate Found";
	public static final String PRODUCTS_FOUND = " Products Found";
	public static final String PRODUCT_FOUND = " Product Found";
	public static final String TRUE_STRING = "true";
	public static final String WORKING = "Working";
	public static final String DELETED = "Deleted";
	public static final String REJECT_COMMENTS = "RejectComments";
	public static final String PRINTFORMLINKS_AJAX = "PrintFormLinksAjax";
	public static final String REJECTCOMMENTS_AJAX = "RejectCommentsAjax";
	public static final String TESTSCAN_AJAX = "TestScanAjax";
	public static final String DOWN = "down";
	public static final String MULTIPLE = "Multiple";
	public static final String FILTER_RESULTS = "FilterResults";
	public static final String TEST_SCAN = "TestScan";
	public static final String SAVED_SUCCESSFULLY = "Saved Successfully.";
	public static final String MY_MESSAGE = "myMessage";
	public static final String CANDIDATES = "Candidate(s) ";
	public static final String VENDOR_REJECT = "VendorReject";

	public static final String CHANNEL_DSD = "DSD";
	public static final String CHANNEL_WHS = "WHS";
	public static final String CHANNEL_BOTH = "BOTH";
	public static final String CHANNEL_DSD_CODE = "D";
	public static final String CHANNEL_WHS_CODE = "V";

	public static final String MODIFY = "modify";
	public static final String CURRENT_APP_NAME = "currentAppName";
	public static final String CANDIDATE_SAVE_SUCCESS = "Candidate Saved Successfully.";
	public static final String CANDIDATE_SAVE_SUCCESS_WITHOUT_BRICK = "Candidate Saved Successfully but Brick is unable to store until UPC is entered without ITUPC type.";
	public static final String AUTHORIZE_SERVICE_ERROR = "Service Error While Authorzing";
	public static final String ZERO_STRING = "0";
	public static final String CANDIDATE_SUBMITTED = "Candidate submitted";
	public static final String CANDIDATES_SUBMITTED = "Candidate(s) submitted";
	public static final String COMMENTS_SAVED_SUCCESSFULLY = "Comments Saved Successfully.";
	public static final String CANDIDATES_ACTIVATED_SUCCESSFULLY = "Candidate(s) Activated Successfully";
	public static final String CANDIDATES_SUBMITTED_SUCCESSFULLY = "Batch Upload Candidate(s) Submitted Successfully.\nThe Candidates Will Be Activated Once The Mainframe Job Runs.";
	public static final String SERVICE_ERROR = "Service Error";
	public static final String CANDIDATE_SAVED_SUCCESSFULLY = "Candidate Saved Successfully.";
	public static final String MODIFY_CANDIDATE = "Modify Candidate";
	public static final String MODIFY_PRODUCT = "Modify Product";
	public static final String MODIFY_MRT = "Modify MRT";
	public static final String VIEW_PRODUCT = "View Product";
	public static final String VIEW_MRT = "View MRT";
	public static final String ADDNEW_CANDIDATE = "Add New Candidate";
	public static final String VIEW_CANDIDATE = "View Candidate";
	public static final String COPPY_CANDIDATE = "Copy Candidate";
	public static final String COPPY_PRODUCT = "Copy Product";
	public static final String SET_UP_MRT = "Set Up MRT";
	public static final String CANDIDATE_REJECTED = "Candidate Rejected";
	public static final String ACTIVATED_TITLE = "Activated List of Products";
	public static final String SUBMITTED_TITLE = "Submitted List of Products";
	public static final String CHECK_CANDIDATES_BATCHUPLOAD_ACTIVEDFAIL = "Please Select Candidates Having The Same Status. (Activation Failed Or  Working)";
	// R2
	public static final String FACTORY_LIST = "factoryList";
	public static final String ALERT_CANDIDATE = "Please Save Candidate Before Save Comments.";
	public static final String UNUSED = "unused";

	public static final String ALL = "ALL";
	// remote files
	public static final String CPS_CLUSTER_PEERS = "CPSClusterPeers";
	public static final String CPS_PKI_PASSPHRASE = "CPSPKIPassphrase";
	public static final String CPS_PKI_REMOTE_USER = "CPSPKIRemoteUser";
	public static final String CPS_PKI_PRIVATE_KEY = "CPSPKIPrivateKeyFile";
	// session
	public static final String CPS_PRODUCT_ID_SESSION = "CPSProductId";
	public static final String CPS_CANDIDATE_TYPE_SESSION = "CPSCandidateType";
	// max file size
	public static final long MAX_SIZE = 8;

	public static final String COMENT_PRINTFORMMRT_GREATERTHAN_25UNITUPC = "More than 25 unit UPC's exist for this MRT.Please view candidate for UPCs.";
	public static final int weightListCost = 30;
	public static final int weightDSD_StoreListCost = 104;

	// Fix tax flag error
	public static final String VENDOR_LOGIN_COFIRM = "vendorLoginCorfirm";
	public static final String DRP = "7";
	public static final String RRP = "9";
	public static final String CURRENT_MODE_APP_NAME = "currentModeAppName";
	public static final String CPS = "CPS";
	public static final String EDI = "EDI";
	public static final String CPS_PRODUCT = "CPS_PRODUCT";
	// Action Search
	public static final String SEARCH_ACTION_BLANK_ID = "1";
	public static final String SEARCH_ACTION_ADD_ID = "2";
	public static final String SEARCH_ACTION_CHANGE_ID = "3";
	public static final String SEARCH_ACTION_DISCONTINUE_ID = "4";
	public static final String SEARCH_ACTION_ACTIVEPRODUCTS_ID = "5";
	public static final String SEARCH_ACTION_BLANK_VALUE = "";
	public static final String SEARCH_ACTION_ADD_VALUE = "Add";
	public static final String SEARCH_ACTION_CHANGE_VALUE = "Change";
	public static final String SEARCH_ACTION_DISCONTINUE_VALUE = "Discontinue";
	public static final String SEARCH_ACTION_ACTIVEPRODUCTS_VALUE = "Active Products";
	// Data source
	public static final String SEARCH_DATASOURCE_ALL_ID = "0";
	public static final String SEARCH_DATASOURCE_ALL_VALUE = "--Select--";
	public static final String SEARCH_DATASOURCE_SINGLEENTRY_ID = "1";
	public static final String SEARCH_DATASOURCE_SINGLEENTRY_VALUE = "Single Entry";
	public static final String SEARCH_DATASOURCE_BATCHUPLOAD_ID = "2";
	public static final String SEARCH_DATASOURCE_BATCHUPLOAD_VALUE = "Batch Upload";
	public static final String SEARCH_DATASOURCE_EDI_ID = "3";
	public static final String SEARCH_DATASOURCE_EDI_VALUE = "EDI";
	public static final String REDIRECT_FORM = "redirectForm";
	public static final int ITEM_CATEGORY_RESOURCE = 242;

	public static final String CPS_CRITERIA_SESSION = "criteriaSearch";
	public static final String MODIFY_VALUE = "MODIFY_VALUE";
	public static final String EDI_CURRENT_TAB = "EDI_CURRENT_TAB";
	public static final String PRESENT_BTS = "PRESENT_BTS";

	public static final String BACK_TO_SEARCH_EDI = "BackToSearchEDI";
	public static final String BACK_TO_SEARCH_CPS = "BackToSearchCPS";
	public static final String BACK_TO_SEARCH_CPS_PROD = "BackToSearchCPSProduct";
	public static final String MASS_UPLOAD_VOs = "allMassUploadProfiles";
	public static final String SEARCH_NUMBER_VIEW_SESSION = "SEARCH_NUMBER_VIEW_SESSION";
	public static final String SEARCH_TOTAL_DATA_SESSION = "SEARCH_TOTAL_DATA_SESSION";
	public static final String SEARCH_TOTAL_PAGE_SESSION = "SEARCH_TOTAL_PAGE_SESSION";
	public static final String SEARCH__PAGE_CURRENT_SESSION = "SEARCH__PAGE_CURRENT_SESSION";
	public static final String NUMBER_SET_DEFAULT = "10";
	public static final String IN_UNIT = " in";
	public static final String LB_UNIT = " lb";
	public static final String TITLE_PRINSUMARY = "TITLE_PRINSUMARY";
	public static final short TITLE_PRINSUMARY_FONT_HEIGHT = 16;
	public static final String USER_PRINSUMARY = "USER_PRINSUMARY";
	public static final short USER_PRINSUMARY_PRINSUMARY_FONT_HEIGHT = 11;
	public static final String FILTER_PRINSUMARY = "FILTER_PRINSUMARY";
	public static final short FILTER_PRINSUMARY_FONT_HEIGHT = 11;
	public static final String HEADER_VENDOR_PRINSUMARY = "HEADER_VENDOR_PRINSUMARY";
	public static final String HEADER_HEB_PRINSUMARY = "HEADER_HEB_PRINSUMARY";
	public static final String HEADER_PRODUCT_AUDIT_PRINSUMARY = "HEADER_PRODUCT_AUDIT_PRINSUMARY";
	public static final short HEADER_PRINSUMARY_FONT_HEIGHT = 12;
	public static final String HEADER_SMALL_PRINSUMARY = "HEADER_SMALL_PRINSUMARY";
	public static final short HEADER_SAMLL_PRINSUMARY_PRINSUMARY_FONT_HEIGHT = 10;
	public static final String HEADER_GRID_PRINSUMARY = "HEADER_GRID_PRINSUMARY";
	public static final short HEADER_GRID_PRINSUMARY_PRINSUMARY_FONT_HEIGHT = 8;
	public static final String GRID_DATA_PRINSUMARY = "GRID_DATA_PRINSUMARY";
	public static final short GRID_DATA_PRINSUMARY_PRINSUMARY_FONT_HEIGHT = 8;
	public static final String PRINSUMARY_UNDERLINE = "______________________________________________";
	public static final String PRINSUMARY_PRODUCT_SET_UP_STATUS_SUMMARY = "PRODUCT SET UP - STATUS SUMMARY";
	public static final String PRINSUMARY_VENDOR_SIGNATURE = "Vendor Signature: ";
	public static final String PRINSUMARY_DATE = "Date: ";
	public static final String PRINSUMARY_BDM_SIGNATURE = "BDM Signature: ";
	public static final String PRINSUMARY_FITLER = "Filters Applied:";
	public static final String PRINSUMARY_VENDOR_FIELDS = "Vendor fields";
	public static final String PRINSUMARY_HEB_FIELDS = "H-E-B Fields";
	public static final String PRINSUMARY_PRODUCT_AUDIT_DETAILS_FIELDS = "Product Audit Details";
	public static final String PRINSUMARY_HEB_DATA = "PRINSUMARY_HEB_DATA";
	public static final String PRINSUMARY_HEB_DATA_ALIGN_RIGHT = "PRINSUMARY_HEB_DATA_ALIGN_RIGHT";
	public static final String PRINSUMARY_HEB_DATA_CURRENCY_RIGHT = "PRINSUMARY_HEB_DATA_CURRENCY_RIGHT";
	public static final String PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT = "PRINSUMARY_HEB_DATA_CURRENCY_TWO_RIGHT";
	public static final String PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT = "PRINSUMARY_HEB_DATA_PECENTAGE_RIGHT";
	// column
	public static final String PRINSUMARY_COLUMN_VENDOR_NAME = "Vendor # and Name";
	public static final String PRINSUMARY_COLUMN_SELLINGUNIT_UPC = "Selling Unit UPC * including the check digit";
	public static final String PRINSUMARY_COLUMN_DESCRIPTION = "Product Description *";
	public static final String PRINSUMARY_COLUMN_SELLINGUNIT_SIZE = "Selling Unit Size*";
	public static final String PRINSUMARY_COLUMN_UOM = "Unit of Measure UOM *";
	public static final String PRINSUMARY_COLUMN_SUB_COMMODITY = "Sub Commodity # and Name";
	public static final String PRINSUMARY_COLUMN_STYLE = "Style #";
	public static final String PRINSUMARY_COLUMN_MODEL = "Model #";
	public static final String PRINSUMARY_COLUMN_COLOR = "Color";
	public static final String PRINSUMARY_COLUMN_BRAND = "Brand *";
	public static final String PRINSUMARY_COLUMN_PACKING = "Packaging *";
	public static final String PRINSUMARY_COLUMN_RARING_TYPE_RATING = "Rating type - Rating";
	public static final String PRINSUMARY_COLUMN_RATING = "Rating";
	public static final String PRINSUMARY_COLUMN_CASE_UPC = "Case UPC including the check digit *";
	public static final String PRINSUMARY_COLUMN_MASTER_PACK = "Master pack *";
	public static final String PRINSUMARY_COLUMN_SHIP_PACK = "Ship pack *";
	public static final String PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS = "Max Shelf Life Days";
	public static final String PRINSUMARY_COLUMN_COST_LINK_UPC = "Cost link UPC";
	public static final String PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN = "Country of Origin *";
	public static final String PRINSUMARY_COLUMN_LIST_COST = "List Cost *";
	public static final String PRINSUMARY_COLUMN_UNIT_COST = "Unit Cost";
	public static final String PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL = "Suggested unit retail *";
	public static final String PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL = "Preprice Unit Retail";
	// HebApprovedSellingPrice
	public static final String PRINSUMARY_COLUMN_RETAIL = "Retail";
	public static final String PRINSUMARY_COLUMN_PENNY_PROFIT = "Penny profit";
	public static final String PRINSUMARY_COLUMN_PERCENT_MARGIN = "% of Margin";
	public static final String PRINSUMARY_COLUMN_RETAIL_LINK_UPC = "Retail Link Code";
	public static final String PRINSUMARY_COLUMN_ITEM_CODE = "Item Code";
	public static final String PRINSUMARY_COLUMN_RETAIL_LINK_UPC_CANDIDATE = "Retail Link UPC";
	public static final String PRINSUMARY_COLUMN_SEASONALITY = "Seasonality";
	public static final String PRINSUMARY_COLUMN_SEASONALITY_YEAR = "Seasonality Year";
	// Code Date
	public static final String PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS = "Inbound Specification Days";
	public static final String PRINSUMARY_COLUMN_REACTION_DAYS = "Reaction Days";
	public static final String PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS = "Guarantee to Store Days";
	// columnHebAttributeCase
	public static final String PRINSUMARY_COLUMN_SHIP_CANCEL_DATE = "Ship Cancel Date (mm/dd/yyyy)";
	public static final String PRINSUMARY_COLUMN_PO_DATE = "PO Date in HEB DC (mm/dd/yyyy)";
	public static final String PRINSUMARY_COLUMN_ORD_QTY = "Ord. Qty in Selling Units";
	public static final String PRINSUMARY_COLUMN_HEB_ITEM_CODE = "HEB item code";
	// new Attribute
	public static final String PRINSUMARY_COLUMN_SOURCE_METHOD = "Source Method Type";
	public static final String PRINSUMARY_COLUMN_STATUS = "Product Status";
	public static final String PRINSUMARY_COLUMN_TESTSCAN = "Test scan";
	public static final String PRINSUMARY_COLUMN_ID_OF_USER = "User Name";
	public static final String PRINSUMARY_COLUMN_BDM = "BDM";
	public static final String PRINSUMARY_COLUMN_CODE_DATE = "Code Date";
	public static final String PRINSUMARY_COLUMN_SUB_DEPT_NAME = "Sub-dept and Name";
	public static final String PRINSUMARY_COLUMN_PSS_DEPT = "Pss Dept";
	public static final String PRINSUMARY_COLUMN_EMPTY = "";
	public static final String MODIFY_PLU_REJECT_VALUE = "MODIFY_PLU_REJECT_VALUE";
	// image and attribute
	public static final String DISPLAY_NAME = "DISPLAY_NAME";
	public static final String ROMANCE_COPY = "ROMANCE_COPY";
	public static final String IMG_EXPECTED = "IMG_EXPECTED";
	public static final String GET_DATA_TABLE_INFOR = "getDataTableInfor";
	public static final String SINGLE_POPUP = "singlePopup";
	public static final String GET_DTA_MULTI_VAL_LIST = "getDtaMultiValList";
	public static final String EDIT = "Edit";
	public static final String IMAGE_POP_UP = "imagesPopup";
	public static final String IMAGE_ATTR_BASIC_AJAX = "ImageAndAttrBasicAjax";

	public static final String ERROR_READ_EXCEL = "Error while reading excel: ";
	public static final String ERR_MESS = "ErrorMessage";
	public static final String CPS_SCALEATTR_MECHTENZ_SESSION = "mechtenz";
	public static final String CHANNEL_WHSDSD = "WHS(DSDeDC)";

	/** The Constant ACTIVATION_SUCCESS. */
	public static final String ACTIVATION_SUCCESS = "ActivationSuccess";

	/** The Constant SINGLE_ACTIVATION. */
	public static final String SINGLE_ACTIVATION = "SingleActivation";

	/** The Constant NO_DESCRIPTION. */
	public static final String NO_DESCRIPTION = "Not Existing -Please Add";

	/** The Constant IS_MRT. */
	public static final String IS_MRT = "isMRT";

	/** The constants error fetching product. */
	public static final String ERROR_FETCHING_PROD = "Error fetching product";

	/** the constants json data parameter. */
	public static final String JSON_DATA = "jsonData";

	public static final String CHARACTER_DOLLAR = "$";

	/** The Constant CPSHELP. */
	public static final String CPSHELP = "CPSHelp";

	public static final String MARGIN_PENNY_BLANK = "% Margin and Penny profit are blank.";

	public static final String ACTIVATED_WORK_IDS = "ACTIVATED_WORK_IDS";
	public static final String CHECK_ACTIVED_FAIL = "CHECK_ACTIVED_FAIL";
	public static final String MESSAGETITLE = "MessageTitles";

	public static final String ERROR_IN_SAVING = " Error in Saving : ";
	public static final String ADDNEW_KIT = "Set Up Kit";
	public static final String MODIFY_KIT = "Modify Kit Candidate";
	public static final String VIEW_KIT_CANDIDATE = "View Kit Candidate";
	public static final String VIEW_KIT_PRODUCT = "View Kit Product";
	public static final String CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION = "showClrsSw";
	
	public static final String CANDIDATE_DELETED_SUCCESS = "Candidate(s) Deleted Successfully";
	public static final String ERROR_DELETE_NOT_SAVED_MRT_CANDIDATE = "Only saved MRT candidate can be deleted";
	public static final String ERROR_DELETE_NOT_SAVED_CANDIDATE = "Only saved candidate can be deleted";

	//sesion
	public static final String CPS_UPLOAD_FILE_SESSION = "CPSUploadFile";
	public static final String CPS_POINTOFSALEVO_FOODSTAMP_SESSION = "foodStamp";
	public static final String CPS_POINTOFSALEVO_DRUGPANEL_SESSION = "drugFactPanel";
	public static final String CPS_POINTOFSALEVO_TAXABLE_SESSION = "taxable";
	public static final String CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION = "qntityRestricted";
	public static final String CPS_POINTOFSALEVO_ABUSIVEVOLATILECHEMICAL_SESSION = "abusiveVolatileChemical";
	public static final String CPS_RETAILVO_WEIGHTFLAG_SESSION = "weightFlag";
	public static final String CPS_POINTOFSALEVO_FSA_SESSION = "fsacd";

	public static final String CPS_SEARCH_RESULTS_SESSION = "productResults";
	public static final String CPS_SEARCH_RESULTS_MAIN_SESSION = "productResultMain";
	public static final String CPS_SEARCH_RESULTS_TEMP_SESSION = "productResultTemp";


	//tab index
	public static final int TAB_BRICK_ATTR = 2;
	public static final int TAB_EXTEND_ATTR = 1;
	public static final int TAB_IMG_ATTR = 140;
	public static final int TAB_MRT = 120;
	public static final int TAB_NEW_AUTH = 130;
	public static final int TAB_POW = 110;
	public static final int TAB_PROD_UPC = 80;

	public static final String REJECTE_MESSAGE_COMMENTS = "rejectMessageComments";
}
