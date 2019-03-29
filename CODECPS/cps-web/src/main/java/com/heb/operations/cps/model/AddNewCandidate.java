package com.heb.operations.cps.model;

import com.heb.jaf.security.UserInfo;
import com.heb.jaf.vo.VendorOrg;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.business.framework.vo.WareHouseVO;
import com.heb.operations.cps.util.*;
import com.heb.operations.cps.vo.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import java.util.*;

public class AddNewCandidate extends HebBaseInfo {

	public static final String FORM_NAME = "AddNewCandidate";

	public static final String NO_DESCRIPTION = "Not Existing -Please Add";

	private static final long serialVersionUID = -3224161512831913187L;

	public static final int TAB_BRICK_ATTR = 2;

	public static final int TAB_EXTEND_ATTR = 1;

	public static final int TAB_IMG_ATTR = 140;

	public static final int TAB_MRT = 120;

	public static final int TAB_NEW_AUTH = 130;

	public static final int TAB_POW = 110;

	public static final int TAB_PROD_UPC = 80;

	// public static final int TAB_AUHT_DIST = 90;

	public static final int TAB_PRODUCT_CLASSIFICATION = 100;

	private String action;

	private List<BaseJSFVO> actionCode;

	private String addressCustomerEmail = "";

	private List<AuditTrailVO> auditTrail = new ArrayList<AuditTrailVO>();

	private String authDeptNo;

	private String authorizeServiceMessage;

	private String authSubDeptNo;

	private String authTypeCode;

	private String batchErrorMessage;

	private String batchErrorSessionId;

	/* Batch Upload */
	private boolean batchErrorStatus;

	private MultipartFile batchUploadFile;

	private boolean brandMandatory = true;

	private boolean buttonViewOverRide = true;

	// candidate
	// types
	private String candidateType = "";

	private Map<String, CaseItemVO> caseItems = new HashMap<String, CaseItemVO>();

	private boolean caseViewOverRide = true;

	private CaseVO caseVO = new CaseVO();

	private List<BaseJSFVO> channels = new ArrayList<BaseJSFVO>();

	private Map<String, CommentsVO> commentsVOs = new HashMap<String, CommentsVO>();

	private List<ConflictStoreVO> conflictStoreVOs = new ArrayList<ConflictStoreVO>();

	private boolean containUpcNew = false;

	private String costGroup;

	private boolean costGroupContainsOne;

	private List<BaseJSFVO> costGroups = new ArrayList<BaseJSFVO>();

	// ////////////////////////////////////
	private Map<String, List<StoreVO>> costGrpStoreMap = new LinkedHashMap<String, List<StoreVO>>();

	private List<BaseJSFVO> costOwners = new ArrayList<BaseJSFVO>();

	private boolean disableWic = false;

	private List<BaseJSFVO> drugAbb;

	private List<BaseJSFVO> drugSchedules;

	private int dynamicExtendAtrrTab;

	private String earlierActionForward;

	private int earlierTabIndex;

	private CaseVO eDcCaseVO = new CaseVO();

	private VendorVO eDcVendorVO = new VendorVO();

	public boolean enableActivateButton;

	private boolean enableActiveButton = false;

	private boolean enableClose;

	private boolean enableTabs = false;

	private ProductVO existingUpcProductVO = new ProductVO();

	private List<BaseJSFVO> graphicsCode;

	private String hidDescription;

	private boolean hidMrtSwitch = false;

	private String hidUpcCheckDigit;

	/* MRT Attributes */
	private String hidUpcValue;

	private MultipartFile  imageUploadFile;

	private List<BaseJSFVO> imgStatLst = new ArrayList<BaseJSFVO>();

	private boolean isActivatedFail = false;

	private boolean isHidBatchUploaded = false;

	private boolean isNormalProduct = true;

	// flag used to disable image attribute tag when view candidate
	private boolean isViewImgAtt;

	private String itemID;

	private List<BaseJSFVO> laborCategoryList = new ArrayList<BaseJSFVO>();

	private String listCost;

	private List<TaxCategoryVO> listQualifyCondition = new ArrayList<TaxCategoryVO>();

	private List<Integer> lstPluGenerates = new ArrayList<Integer>();

	private List<BaseJSFVO> lstRateType = new ArrayList<BaseJSFVO>();

	private List<BaseJSFVO> lstRating = new ArrayList<BaseJSFVO>();
	private boolean matrixMarginClose = false;
	private String maxMargin;
	private String minMargin;
	private boolean modifyProdCand = false;
	private boolean mrtActiveProduct = false;
	private List<MrtVO> MRTList = new ArrayList<MrtVO>();
	private boolean mrtUpcAdded = false;
	private boolean mrtViewMode;
	private MrtVO mrtvo = new MrtVO();
	private String newSubBrand;

	private boolean nonSellable;
	private List<BaseJSFVO> nutrientList = new ArrayList<BaseJSFVO>();
	private boolean packagingViewOverRide = true;
	private List<String> pendingCandidateTypes = new ArrayList<String>();// pending
	private List<String> pendingProdIds;
	private String pluRangeOlds = "";
	private List<POWStatus> powStatus = new ArrayList<POWStatus>();
	private boolean preventUpdateStore = false;
	private boolean printable;
	private List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();
	public boolean product;

	public boolean productCaseOverridden = false;

	private String productDescription;

	private List<SearchResultVO> products = new ArrayList<SearchResultVO>();

	private int productsSize;

	private ProductVO productVO = new ProductVO();

	private List<BaseJSFVO> pseLst = new ArrayList<BaseJSFVO>();

	private List<BaseJSFVO> pssList = new ArrayList<BaseJSFVO>();

	private List<BaseJSFVO> purchaseTimeList = new ArrayList<BaseJSFVO>();

	private boolean rejectClose = false;

	private String rejectComments;

	private List<BaseJSFVO> restrictedSalesAgeLimitList = new ArrayList<BaseJSFVO>();

	private int retail;

	private boolean retailViewOverRide = true;

	private ProductVO savedProductVO = new ProductVO();

	/* to display the scale section */
	private String scaleAttrib;

	private boolean scaleProduct;

	private boolean scaleViewOverRide = true;

	private String scanGun;

	public boolean search;

	private String selectedAttrLabel = ""; // dynamic render open popup

	private String selectedUniqueId = ""; // dynamic render open popup

	private boolean showImport = true;

	private boolean store = false;

	private Map<String, StoreVO> storeVOs = new HashMap<String, StoreVO>();

	private int tabIndex;

	private String taxQualify;

	private boolean testScanNeeded;

	private boolean testScanUserSwitch = false;

	/* Attachment */
	private MultipartFile  theFile;

	private List<BaseJSFVO> tobaccoProdtype;

	private List<BaseJSFVO> topToTops = new ArrayList<BaseJSFVO>();

	private List<BaseJSFVO> unitsOfMeasure;

	private boolean upcAdded = true;// user can be add upc in Edit Mode

	private boolean upcCheck = false;

	private String upcSelect;

	private String upcSubValue;

	private List<BaseJSFVO> upcType;

	private String upcValue;

	private boolean upcValueFromMRT = true;

	private boolean upcViewOverRide = true;

	private UPCVO upcvo;

	private Map<String, UPCVO> upcVOs = new HashMap<String, UPCVO>();

	private boolean validForResults;

	private boolean vendorAndDSD;

	private String vendorId;

	private String vendorListCost;

	private Map<String, Vendor> vendors = new HashMap<String, Vendor>();

	private VendorVO vendorVO = new VendorVO();

	private boolean viewAddInforPage = false;// Additional Information Page

	private boolean viewOnlyProductMRT = false;// identify view MRT Case

	private boolean viewOverRide = false;

	private boolean viewProduct = false;

	/* matrix margin */

	private List<WareHouseVO> wareHouseList = new ArrayList<WareHouseVO>();

	private String wic;

	private List<BaseJSFVO> fdaMenuLabellings = new ArrayList<BaseJSFVO>();
	private String typeDocument;
	private List<BaseJSFVO> docCatList = new ArrayList<BaseJSFVO>();

	private String hiddenKitCost;

	/** The selected option. */
	private String selectedOption;

	/** The selected value. */
	private String selectedValue;

	/** The upc description. */
	private String upcDescription;


	/** The entered value. */
	private String enteredValue;

	/**
	 * @return Gets the value of selectedOption and returns selectedOption
	 */
	public void setSelectedOption(String selectedOption) {
		this.selectedOption = selectedOption;
	}

	/**
	 * Sets the selectedOption
	 */
	public String getSelectedOption() {
		return selectedOption;
	}

	/**
	 * @return Gets the value of selectedValue and returns selectedValue
	 */
	public void setSelectedValue(String selectedValue) {
		this.selectedValue = selectedValue;
	}

	/**
	 * Sets the selectedValue
	 */
	public String getSelectedValue() {
		return selectedValue;
	}

	/**
	 * @return Gets the value of upcDescription and returns upcDescription
	 */
	public void setUpcDescription(String upcDescription) {
		this.upcDescription = upcDescription;
	}

	/**
	 * Sets the upcDescription
	 */
	public String getUpcDescription() {
		return upcDescription;
	}

	/**
	 * @return Gets the value of enteredValue and returns enteredValue
	 */
	public void setEnteredValue(String enteredValue) {
		this.enteredValue = enteredValue;
	}

	/**
	 * Sets the enteredValue
	 */
	public String getEnteredValue() {
		return enteredValue;
	}

	/**
	 * @return the fdaMenuLabellings
	 */
	public List<BaseJSFVO> getFdaMenuLabellings() {
		if (CPSHelper.isEmpty(this.fdaMenuLabellings)) {
			this.fdaMenuLabellings = new ArrayList<BaseJSFVO>();
			this.fdaMenuLabellings.add(new BaseJSFVO("Y", "Yes"));
			this.fdaMenuLabellings.add(new BaseJSFVO("N", "No"));
		}
		return fdaMenuLabellings;
	}

	/**
	 * @param fdaMenuLabellings the fdaMenuLabellings to set
	 */
	public void setFdaMenuLabellings(List<BaseJSFVO> fdaMenuLabellings) {
		this.fdaMenuLabellings = fdaMenuLabellings;
	}

	public AddNewCandidate() {

		this.setCurrentAppName("Add New Candidate");
		// initPOWStatus();
		this.upcvo = new UPCVO();

	}

	public void addCaseItems(CaseItemVO caseItemVO) {
		String time = String.valueOf(System.currentTimeMillis()) + caseItemVO.hashCode();
		caseItemVO.setUniqueId(time);
		this.caseItems.put(time, caseItemVO);
	}

	public void addStoreVOs(StoreVO storeVO) {
		String uniqueId = String.valueOf(System.currentTimeMillis()) + storeVO.hashCode();
		storeVO.setUniqueId(uniqueId);
		this.storeVOs.put(uniqueId, storeVO);
	}

	/**
	 * Adds one UPC VO
	 * 
	 * @param upcvo
	 */
	public void addUpcVOs(UPCVO upcvo) {
		String time = String.valueOf(System.currentTimeMillis()) + upcvo.hashCode();
		upcvo.setUniqueId(time);
		this.upcVOs.put(time, upcvo);
	}

	/**
	 * Adds one UPC VO
	 * 
	 * @param upcvo
	 */
	public void addVendors(Vendor upcvo) {
		String time = String.valueOf(System.currentTimeMillis()) + upcvo.hashCode();
		upcvo.setUniqueId(time);
		this.vendors.put(time, upcvo);
	}

	public void clearButtonViewOverRide() {
		this.buttonViewOverRide = true;
	}

	public void clearCaseItemVOs() {
		this.caseItems.clear();
	}

	public void clearCaseViewOverRide() {
		this.caseViewOverRide = true;
	}

	public void clearPackagingViewOverRide() {
		this.upcViewOverRide = true;
	}

	public void clearRetailViewOverRide() {
		this.upcViewOverRide = true;
	}

	public void clearScaleViewOverRide() {
		this.scaleViewOverRide = true;
	}

	public void clearStoreVOs() {
		this.storeVOs.clear();
	}

	public void clearUpcViewOverRide() {
		this.upcViewOverRide = true;
	}

	public void clearUPCVOs() {
		this.upcVOs.clear();
	}

	public void clearVendors() {
		this.vendors.clear();
	}

	public void clearViewOverRide() {
		this.viewOverRide = false;
	}

	public void clearViewProduct() {
		this.viewProduct = false;
	}

	public String getAction() {
		return this.action;
	}

	public List<BaseJSFVO> getActionCode() {
		return this.actionCode;
	}

	public String getAddressCustomerEmail() {
		return this.addressCustomerEmail;
	}

	public List<AuditTrailVO> getAuditTrail() {
		return this.auditTrail;
	}

	public String getAuthDeptNo() {
		return this.authDeptNo;
	}

	public String getAuthorizeServiceMessage() {
		return this.authorizeServiceMessage;
	}

	public String getAuthSubDeptNo() {
		return this.authSubDeptNo;
	}

	public String getAuthTypeCode() {
		return this.authTypeCode;
	}

	public String getBatchErrorMessage() {
		return this.batchErrorMessage;
	}

	public String getBatchErrorSessionId() {
		return this.batchErrorSessionId;
	}

	public MultipartFile  getBatchUploadFile() {
		return this.batchUploadFile;
	}

	public String getCandidateType() {
		return this.candidateType;
	}

	public Map<String, CaseItemVO> getCaseItems() {
		return this.caseItems;
	}

	public CaseVO getCaseVO() {
		return this.caseVO;
	}

	public List<BaseJSFVO> getChannels() {
		return this.channels;
	}

	public Map<String, CommentsVO> getCommentsVOs() {
		return this.commentsVOs;
	}

	public List<ConflictStoreVO> getConflictStoreVOs() {
		return this.conflictStoreVOs;
	}

	public String getCostGroup() {
		return this.costGroup;
	}

	public List<BaseJSFVO> getCostGroups() {
		return this.costGroups;
	}

	public Map<String, List<StoreVO>> getCostGrpStoreMap() {
		return this.costGrpStoreMap;
	}

	public List<BaseJSFVO> getCostOwners() {
		return this.costOwners;
	}

	// 958 enhancement
	public String getDefaultSubDept() {
		String defaultSubDept = "";
		String dept = "";
		String subDept = "";
		if (CPSHelper.isNotEmpty(getProductVO()) && CPSHelper.isNotEmpty(getProductVO().getClassificationVO()) && CPSHelper.isNotEmpty(getProductVO().getClassificationVO().getCommodity())) {
			if (null != getClassCommodityVO(getProductVO().getClassificationVO().getCommodity())) {
				dept = getClassCommodityVO(getProductVO().getClassificationVO().getCommodity()).getDeptId();
				subDept = getClassCommodityVO(getProductVO().getClassificationVO().getCommodity()).getSubDeptId();
			}
		}
		if (CPSHelper.isNotEmpty(dept) && CPSHelper.isNotEmpty(subDept)) {
			if (dept.length() < 2) {
				dept = "0" + dept;
			}
			defaultSubDept = dept + subDept;
		}
		return defaultSubDept;
	}

	public List<BaseJSFVO> getDrugAbb() {
		return this.drugAbb;
	}

	public List<BaseJSFVO> getDrugSchedules() {
		return this.drugSchedules;
	}

	public int getDynamicExtendAtrrTab() {
		return this.dynamicExtendAtrrTab;
	}

	public String getEarlierActionForward() {
		return this.earlierActionForward;
	}

	public int getEarlierTabIndex() {
		return this.earlierTabIndex;
	}

	/**
	 * @return the eDcCaseVO
	 */
	public CaseVO geteDcCaseVO() {
		return eDcCaseVO;
	}

	/**
	 * @return the eDcVendorVO
	 */
	public VendorVO geteDcVendorVO() {
		return eDcVendorVO;
	}

	public ProductVO getExistingUpcProductVO() {
		return this.existingUpcProductVO;
	}

	private List<VendorLocationVO> getFilteredList(List<VendorLocationVO> total, List<VendorLocationVO> sessionList) {
		List<VendorLocationVO> result = new ArrayList<VendorLocationVO>();
		if (sessionList != null) {
			for (VendorLocationVO item : sessionList) {
				for (VendorLocationVO cacheItem : total) {
					if (cacheItem.getVendorId().equals(item.getVendorId())) {
						result.add(item);
					}
				}
			}
		}
		return result;
	}

	public List<BaseJSFVO> getGraphicsCode() {
		return this.graphicsCode;
	}

	public String getHidDescription() {
		return this.hidDescription;
	}

	public String getHidUpcCheckDigit() {
		return this.hidUpcCheckDigit;
	}

	public String getHidUpcValue() {
		return this.hidUpcValue;
	}

	/**
	 * @return the imageUploadFile
	 */
	public MultipartFile  getImageUploadFile() {
		return this.imageUploadFile;
	}

	/**
	 * @return the imgStatLst
	 */
	public List<BaseJSFVO> getImgStatLst() {
		if (CPSHelper.isEmpty(this.imgStatLst)) {
			this.imgStatLst = new ArrayList<BaseJSFVO>();
			this.imgStatLst.add(new BaseJSFVO("", "--Select--"));
			this.imgStatLst.add(new BaseJSFVO("N", "For Review"));
			this.imgStatLst.add(new BaseJSFVO("Y", "Approved"));
			this.imgStatLst.add(new BaseJSFVO("R", "Rejected"));
		}
		return this.imgStatLst;
	}

	public String getItemID() {
		return this.itemID;
	}

	public List<BaseJSFVO> getLaborCategoryList() {
		CPSHelper.insertBlankSelect(this.laborCategoryList);
		if (this.laborCategoryList.size() < 2) {
			String categoryCode = "";
			for (int i = 1; i < 100; i++) {
				if (CPSHelper.getStringValue(i).length() < 2) {
					categoryCode = "0" + CPSHelper.getStringValue(i);
				} else {
					categoryCode = CPSHelper.getStringValue(i);
				}
				this.laborCategoryList.add(new BaseJSFVO(categoryCode, categoryCode));
			}
		}
		return this.laborCategoryList;
	}

	public String getListCost() {
		return this.listCost;
	}

	public List<TaxCategoryVO> getListQualifyCondition() {
		try {
			List<TaxCategoryVO> listResult = CommonBridge.getCommonServiceInstance().getQualifyingCondition();
			this.listQualifyCondition = listResult;
		} catch (Exception e) {

		}
		return listQualifyCondition;
	}

	/**
	 * @return the lstPluGenerates
	 */
	public List<Integer> getLstPluGenerates() {
		return this.lstPluGenerates;
	}

	/**
	 * @return the lstRateType
	 */
	public List<BaseJSFVO> getLstRateType() {
		return this.lstRateType;
	}

	/**
	 * @return the lstRating
	 */
	public List<BaseJSFVO> getLstRating() {
		return this.lstRating;
	}

	public String getMaxMargin() {
		return this.maxMargin;
	}

	public String getMinMargin() {
		return this.minMargin;
	}

	public List<MrtVO> getMRTList() {
		return this.MRTList;
	}

	public MrtVO getMrtvo() {
		return this.mrtvo;
	}

	public String getNewSubBrand() {
		return this.newSubBrand;
	}

	public List<BaseJSFVO> getNutrientList() {
		return this.nutrientList;
	}

	public List<String> getPendingCandidateTypes() {
		return this.pendingCandidateTypes;
	}

	public List<String> getPendingProdIds() {
		return this.pendingProdIds;
	}

	/**
	 * @return the pluRangeOlds
	 */
	public String getPluRangeOlds() {
		return this.pluRangeOlds;
	}

	public List<POWStatus> getPowStatus() {
		return this.powStatus;
	}

	public List<PrintFormVO> getPrintFormVOList() {
		return this.printFormVOList;
	}

	public String getProductDescription() {
		return this.productDescription;
	}

	public List<SearchResultVO> getProducts() {
		return this.products;
	}

	public int getProductsSize() {
		return this.productsSize;
	}

	public ProductVO getProductVO() {
		return this.productVO;
	}

	public List<BaseJSFVO> getPseLst() {
		if (CPSHelper.isEmpty(this.pseLst)) {
			this.pseLst = new ArrayList<BaseJSFVO>();
			this.pseLst.add(new BaseJSFVO("", "--Select--"));
			this.pseLst.add(new BaseJSFVO("N", "NO PSE"));
			this.pseLst.add(new BaseJSFVO("S", "PSE Solid"));
			this.pseLst.add(new BaseJSFVO("L", "PSE Non-Solid"));
		}
		return this.pseLst;
	}

	public List<BaseJSFVO> getPssList() {
		return this.pssList;
	}

	public List<BaseJSFVO> getPurchaseTimeList() {
		return this.purchaseTimeList;
	}

	public String getRejectComments() {
		return this.rejectComments;
	}

	public List<BaseJSFVO> getRestrictedSalesAgeLimitList() {
		return this.restrictedSalesAgeLimitList;
	}

	public int getRetail() {
		return this.retail;
	}

	public ProductVO getSavedProductVO() {
		return this.savedProductVO;
	}

	public String getScaleAttrib() {
		return this.scaleAttrib;
	}

	public String getScanGun() {
		return this.scanGun;
	}

	/**
	 * @return the selectedAttrLabel
	 */
	public String getSelectedAttrLabel() {
		return this.selectedAttrLabel;
	}

	/**
	 * @return the selectedUniqueId
	 */
	public String getSelectedUniqueId() {
		return this.selectedUniqueId;
	}

	public StoreVO getStoreVO(String uniqueId) {
		return storeVOs.get(uniqueId);
	}

	public Map<String, StoreVO> getStoreVOMap() {
		return this.storeVOs;
	}

	public List<StoreVO> getStoreVOs() {
		List<StoreVO> list = new ArrayList<StoreVO>();
		list.addAll(this.storeVOs.values());
		Collections.sort(list, new Comparator<StoreVO>() {
			public int compare(StoreVO storeVO1, StoreVO storeVO2) {
				if (CPSHelper.isNumeric(storeVO1.getCostGroup()) && CPSHelper.isNumeric(storeVO2.getCostGroup())) {
					return Integer.valueOf(storeVO1.getCostGroup()).compareTo(Integer.valueOf(storeVO2.getCostGroup()));
				}
				return 0;
			}
		});
		return list;
	}

	@Override
	public String getStrutsFormName() {

		return FORM_NAME;
	}

	public int getTabIndex() {
		return this.tabIndex;
	}

	public String getTaxQualify() {
		return taxQualify;
	}

	public MultipartFile  getTheFile() {
		return this.theFile;
	}

	public List<BaseJSFVO> getTobaccoProdtype() {
		return this.tobaccoProdtype;
	}

	public List<BaseJSFVO> getTopToTops() {
		return this.topToTops;
	}

	public List<BaseJSFVO> getUnitsOfMeasure() {
		return this.unitsOfMeasure;
	}

	/**
	 * @return the upcSelect
	 */
	public String getUpcSelect() {
		return this.upcSelect;
	}

	public String getUpcSubValue() {
		return this.upcSubValue;
	}

	public List<BaseJSFVO> getUpcType() {
		return this.upcType;
	}

	public String getUpcValue() {
		return this.upcValue;
	}

	public UPCVO getUpcvo() {
		return this.upcvo;
	}

	public List<UPCVO> getUpcVOs() {
		List<UPCVO> list = new ArrayList<UPCVO>();
		list.addAll(this.upcVOs.values());
		return list;
	}

	public UPCVO getUpcVOs(String uniqueId) {
		return this.upcVOs.get(uniqueId);
	}

	public String getVendorId() {
		return this.vendorId;
	}

	// get vendorList from Map
	public List<VendorLocationVO> getVendorList(String chnlVal) throws CPSGeneralException {
		Map<String, List<VendorLocationVO>> vendMap = (Map<String, List<VendorLocationVO>>) getSession().getAttribute("vendorMap");
		if (vendMap == null) {
			vendMap = updateVendorMap();
		}
		List<VendorLocationVO> sessionList = new ArrayList<VendorLocationVO>();
		if (CHANNEL_DSD.equalsIgnoreCase(chnlVal)) {
			sessionList = vendMap.get("dsdLst");
		} else if (CHANNEL_WHS.equalsIgnoreCase(chnlVal)) {
			sessionList = vendMap.get("whsLst");
		} else {
			if (null != vendMap.get("dsdLst")) {
				sessionList.addAll(vendMap.get("dsdLst"));
			}
			if (null != vendMap.get("whsLst")) {
				sessionList.addAll(vendMap.get("whsLst"));
			}
		}
		return sessionList;
	}

	/*
	 * public Map<String, UPCVO> getUpcVOs() { return upcVOs; }
	 */

	public String getVendorListCost() {
		return this.vendorListCost;
	}

	public Map<String, Vendor> getVendors() {
		return this.vendors;
	}

	public VendorVO getVendorVO() {
		return this.vendorVO;
	}

	public List<WareHouseVO> getWareHouseList() {
		return this.wareHouseList;
	}

	public int getWareHouseListSize() {
		int returnValue = 0;
		if (CPSHelper.isNotEmpty(this.wareHouseList)) {
			returnValue = this.wareHouseList.size();
		}
		return returnValue;
	}

	public String getWic() {
		return this.wic;
	}

	public boolean isActivatedFail() {
		return this.isActivatedFail;
	}

	public boolean isBatchErrorStatus() {
		return this.batchErrorStatus;
	}

	public boolean isBrandMandatory() {
		if (CPSHelper.checkEqualValue(this.getProductVO().getClassificationVO().getMerchandizeType(), "9") || "Coupon".equalsIgnoreCase(this.getProductVO().getClassificationVO().getMerchandizeName())) {
			this.brandMandatory = false;
		}
		return this.brandMandatory;
	}

	public boolean isButtonViewOverRide() {
		return this.buttonViewOverRide;
	}

	public boolean isCaseViewOverRide() {
		return this.caseViewOverRide;
	}

	/**
	 * @return the containUpcNew
	 */
	public boolean isContainUpcNew() {
		return this.containUpcNew;
	}

	public boolean isCostGroupContainsOne() {
		return this.costGroupContainsOne;
	}

	public boolean isDisableWic() {
		return this.disableWic;
	}

	// Fix 1307
	public boolean isEligibleToModify() {
		boolean eligible = true;
		if (isVendor()) {
			WorkRequest wrkRqst = null;
			// Vendors cannot modify working candidate
			if (this.isHidMrtSwitch()) {
				wrkRqst = this.getMrtvo().getWorkRequest();
			} else {
				wrkRqst = this.getProductVO().getWorkRequest();
			}
			if (CPSHelper.isNotEmpty(wrkRqst)) {
				String status = wrkRqst.getWorkStatusCode();
				if ("107".equals(status)) {
					eligible = false;
				}
			}
		}

		return eligible;
	}

	public boolean isEnableActivateButton() {
		if (this.getProductVO() != null) {
			this.enableActivateButton = this.isNewUPC() || this.isNewCase();
		}
		return this.enableActivateButton;
	}

	public boolean isEnableActiveButton() {
		return this.enableActiveButton;
	}

	public boolean isEnableClose() {
		return this.enableClose;
	}

	public boolean isEnableTabs() {
		return this.enableTabs;
	}

	public boolean isHidBatchUploaded() {
		return this.isHidBatchUploaded;
	}

	public boolean isHidMrtSwitch() {
		return this.hidMrtSwitch;
	}

	public boolean isHoldingPendingCandidateType() {
		return (getPendingCandidateTypes() != null && !getPendingCandidateTypes().isEmpty());
	}

	public boolean isHoldingPendingProdIds() {
		return (getPendingProdIds() != null && !getPendingProdIds().isEmpty());
	}

	public boolean isMatrixMarginClose() {
		return this.matrixMarginClose;
	}

	public boolean isModifyProdCand() {
		return this.modifyProdCand;
	}

	public boolean isMrtActiveProduct() {
		return this.mrtActiveProduct;
	}

	public boolean isMrtUpcAdded() {
		return mrtUpcAdded;
	}

	public boolean isMrtViewMode() {
		return this.mrtViewMode;
	}

	private boolean isNewCase() {
		List<CaseVO> caseVos = this.getProductVO().getCaseVOs();
		boolean isNew = false;
		if (CPSHelper.isNotEmpty(caseVos)) {
			for (CaseVO caseVO : caseVos) {
				if (caseVO.getNewDataSw() == 'Y') {
					isNew = true;
				} else {
					isNew = this.isNewVendor(caseVO.getVendorVOs());
				}
				if (isNew) {
					break;
				}
			}
		}
		return isNew;
	}

	private boolean isNewUPC() {
		List<UPCVO> upcs = this.getProductVO().getUpcVO();
		for (UPCVO upcvo : upcs) {
			if (upcvo.getNewDataSw() == 'Y') {
				return true;
			}
		}
		return false;
	}

	private boolean isNewVendor(List<VendorVO> vendors) {
		if (CPSHelper.isNotEmpty(vendors)) {
			for (VendorVO vendorVO : vendors) {
				if (vendorVO.getNewDataSw() == 'Y') {
					return true;
				}
			}
		}
		return false;
	}

	public boolean isNonSellable() {
		String productType = "";
		this.nonSellable = false;
		if (this.getProductVO() != null && this.getProductVO().getClassificationVO() != null && this.getProductVO().getClassificationVO().getProductType() != null) {
			productType = CPSHelper.getTrimmedValue(this.getProductVO().getClassificationVO().getProductType());
		}
		if ("SPLY".equalsIgnoreCase(productType)) {
			this.nonSellable = true;
		}
		return this.nonSellable;
	}

	public boolean isNormalProduct() {
		return this.isNormalProduct;
	}

	public boolean isPackagingViewOverRide() {
		return this.packagingViewOverRide;
	}

	/**
	 * @return the preventUpdateStore
	 */
	public boolean isPreventUpdateStore() {
		return this.preventUpdateStore;
	}

	public boolean isPrintable() {
		return this.printable;
	}

	public boolean isProduct() {
		return this.product;
	}

	public boolean isProductCaseOverridden() {
		return this.productCaseOverridden;
	}

	public boolean isRejectClose() {
		return this.rejectClose;
	}

	public boolean isRetailViewOverRide() {
		return this.retailViewOverRide;
	}

	public boolean isScaleProduct() {
		this.scaleProduct = false;
		boolean flag = true;
		if (this.getProductVO() != null) {
			List<UPCVO> upcs = getProductVO().getUpcVO();
			if (null != upcs && !upcs.isEmpty()) {
				for (UPCVO upcvo : upcs) {
					if (upcvo.getNewDataSw() == 'Y') {
						if (!CPSHelper.checkEqualValue(upcvo.getUpcType(), "PLU") || !upcvo.getUnitUpc().startsWith("002")) {
							this.scaleProduct = false;
							flag = false;
							return this.scaleProduct;
						}
					} else {
						flag = false;
					}
				}
			} else {
				flag = false;
			}
			if (flag) {
				this.scaleProduct = true;
			}

		}
		return this.scaleProduct;
	}

	public boolean isScaleViewOverRide() {
		return this.scaleViewOverRide;
	}

	public boolean isSearch() {
		return this.search;
	}

	public boolean isShowImport() {
		return this.showImport;
	}

	public boolean isStore() {
		return this.store;
	}

	/**
	 * 
	 * @return boolean value to indicate if test scan is needed.
	 */
	public boolean isTestScanNeeded() {
		if (isScaleProduct()) {
			return false;
		}

		isVendorAndDSD();

		this.testScanNeeded = true;
		String productType = "";
		// if(!isVendor()){
		if (this.getProductVO() != null && this.getProductVO().getClassificationVO() != null && this.getProductVO().getClassificationVO().getProductType() != null) {
			productType = CPSHelper.getTrimmedValue(this.getProductVO().getClassificationVO().getProductType());
		}
		// No need to do a test scan if it is not a SELLABLE item.
		if ("SPLY".equalsIgnoreCase(productType) || EMPTY_STRING.equalsIgnoreCase(productType)) {
			this.testScanNeeded = false;
		} else {
			List<UPCVO> upcvos = this.getProductVO().getUpcVO();
			/*
			 * if(this.getUpcVOs() == null || this.getUpcVOs().size() == 0){
			 * testScanNeeded = false; } else {
			 */
			if (null == upcvos || upcvos.isEmpty()) {
				// If there is no UPC then no need to do test scan
				this.testScanNeeded = false;
			}
			// Commenting out since test scan is required before saving the
			// candidate
			/*
			 * else { for (UPCVO upcvo : upcvos) { // ONLY type UPC & HEB need
			 * to be test scanned PLU do not // need to be test scanned. if
			 * ("UPC".equalsIgnoreCase(upcvo.getUpcType()) ||
			 * "HEB".equalsIgnoreCase(upcvo.getUpcType())) { // can not do a
			 * test scan if the candidate is not // saved. if (0 ==
			 * upcvo.getSeqNo()) { testScanNeeded = false; break; } } } }
			 */
			/* } */
		}
		if (this.testScanNeeded) {
			List<UPCVO> upcvoList = this.getProductVO().getUpcVO();
			for (UPCVO upcvo : upcvoList) {
				// if ((upcvo.getUpcType().equalsIgnoreCase("UPC") ||
				// upcvo.getUpcType().equalsIgnoreCase("HEB"))
				// && CPSHelper.isEmpty(upcvo.getTestScanUPC())
				// && upcvo.getTestScanOverridenStatus() == 'N') {
				// testScanNeeded = false;
				// break;
				if ("UPC".equalsIgnoreCase(upcvo.getUpcType()) || "HEB".equalsIgnoreCase(upcvo.getUpcType())) {
					// If there is at least one Sellable UPC, for which
					// the test scan is not performed yet, the "TEST
					// SCAN" button should be active.
					if ((upcvo.getTestScanUPC() == null || upcvo.getTestScanUPC().trim().length() == 0) && 'Y' == upcvo.getNewDataSw()) {
						// Not test scan has been performed yet for this
						// UPC.
						this.testScanNeeded = true;
						break;
					} else {
						this.testScanNeeded = false;
					}
					// }else if(CPSHelper.checkEqualValue(upcvo.getUpcType(),
					// "PLU")&&!upcvo.getUnitUpc().startsWith("002")&&'Y'==
					// upcvo.getNewDataSw()){
					// testScanNeeded = true;
					// break;
				} else {
					this.testScanNeeded = false;
				}
			}
		}
		// } else {
		// testScanNeeded = false;
		// }
		return this.testScanNeeded;
	}

	public boolean isTestScanUserSwitch() {
		return this.testScanUserSwitch;
	}

	public boolean isUpcAdded() {
		return this.upcAdded;
	}

	public boolean isUpcCheck() {
		return this.upcCheck;
	}

	public boolean isUpcValueFromMRT() {
		return this.upcValueFromMRT;
	}

	public boolean isUpcViewOverRide() {
		return this.upcViewOverRide;
	}

	public boolean isValidForResults() {
		return this.validForResults;
	}

	public boolean isVendor() {
		String userRole = getUserRole();
		return (CPSConstants.UNREGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole) || CPSConstants.REGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole));
	}

	public boolean isVendorAndDSD() {
		this.vendorAndDSD = false;
		if (isVendor()) {
			if (this.vendorVO != null && CPSConstants.CHANNEL_DSD.equalsIgnoreCase(this.vendorVO.getChannel())) {
				this.vendorAndDSD = true;
			}
		}
		return this.vendorAndDSD;
	}

	public boolean isViewAddInforPage() {
		return this.viewAddInforPage;
	}

	/**
	 * @return the isViewImgAtt
	 */
	public boolean isViewImgAtt() {
		return isViewImgAtt;
	}

	public boolean isViewOnlyProductMRT() {
		return this.viewOnlyProductMRT;
	}

	public boolean isViewOverRide() {
		return this.viewOverRide;
	}

	public boolean isViewProduct() {
		return this.viewProduct;
	}

	public CaseItemVO removeCaseItemVO(String key) {
		return this.caseItems.remove(key);
	}

	/**
	 * removes the upcVO
	 * 
	 * @param key
	 */
	public UPCVO removeUPCVO(String key) {
		return this.upcVOs.remove(key);
	}

	/**
	 * removes the upcVO
	 * 
	 * @param key
	 */
	public Vendor removeVendor(String key) {
		return this.vendors.remove(key);
	}

	public void reset(ServletRequest request) {
		// TO implement html:checkboxes correctly, we needs to implement
		// reset().
		String foodStamp = request.getParameter("productVO.pointOfSaleVO.foodStamp");
		if (foodStamp != null && "true".equals(foodStamp)) {
			this.productVO.getPointOfSaleVO().setFoodStamp(true);
		} else {
			this.productVO.getPointOfSaleVO().setFoodStamp(false);
		}

		String drugFactPanel = request.getParameter("productVO.pointOfSaleVO.drugFactPanel");
		if (drugFactPanel != null && "true".equals(drugFactPanel)) {
			this.productVO.getPointOfSaleVO().setDrugFactPanel(true);
		} else {
			this.productVO.getPointOfSaleVO().setDrugFactPanel(false);
		}

		String taxable = request.getParameter("productVO.pointOfSaleVO.taxable");
		if (taxable != null && "true".equals(taxable)) {
			this.productVO.getPointOfSaleVO().setTaxable(true);
		} else {
			this.productVO.getPointOfSaleVO().setTaxable(false);
		}

		String quantityRestricted = request.getParameter("productVO.pointOfSaleVO.qntityRestricted");
		if (quantityRestricted != null && "true".equals(quantityRestricted)) {
			this.productVO.getPointOfSaleVO().setQntityRestricted(true);
		} else {
			this.productVO.getPointOfSaleVO().setQntityRestricted(false);
		}

		// String abusive =
		// request.getParameter("productVO.pointOfSaleVO.abusiveVolatileChemical");
		// if (abusive != null && "true".equals(abusive)) {
		// this.productVO.getPointOfSaleVO().setAbusiveVolatileChemical(true);
		// } else {
		// this.productVO.getPointOfSaleVO().setAbusiveVolatileChemical(false);
		// }

		String soldByWeight = request.getParameter("productVO.retailVO.weightFlag");
		if (soldByWeight != null && "true".equals(soldByWeight)) {
			this.productVO.getRetailVO().setWeightFlag(true);
		} else {
			this.productVO.getRetailVO().setWeightFlag(false);
		}

		String fsa = request.getParameter("productVO.pointOfSaleVO.fsa");
		if (fsa != null && "true".equals(fsa)) {
			this.productVO.getPointOfSaleVO().setFsa(true);
		} else {
			this.productVO.getPointOfSaleVO().setFsa(false);
		}
		String mechtenz = request.getParameter("productVO.scaleVO.mechTenz");
		if (null != mechtenz && "true".equals(mechtenz)) {
			this.productVO.getScaleVO().setMechTenz(true);
		} else {
			this.productVO.getScaleVO().setMechTenz(false);
		}
		//PIM-1484
		String showClrsSw = request.getParameter("productVO.pointOfSaleVO.showClrsSw");
		if (showClrsSw != null && "true".equals(showClrsSw)) {
			this.productVO.getPointOfSaleVO().setShowClrsSw(true);
		} else {
			this.productVO.getPointOfSaleVO().setShowClrsSw(false);
		}
	}

	public void setAction(String action) {
		this.action = action;
	}

	public void setActionCode(List<BaseJSFVO> actionCode) {
		CPSHelper.sortList(actionCode);
		this.actionCode = CPSHelper.insertBlankSelect(actionCode);
	}

	public void setActivatedFail(boolean isActivatedFail) {
		this.isActivatedFail = isActivatedFail;
	}

	public void setAddressCustomerEmail(String addressCustomerEmail) {
		this.addressCustomerEmail = addressCustomerEmail;
	}

	public void setAuditTrail(List<AuditTrailVO> auditTrail) {
		this.auditTrail = auditTrail;
	}

	public void setAuthDeptNo(String authDeptNo) {
		this.authDeptNo = authDeptNo;
	}

	public void setAuthorizeServiceMessage(String authorizeServiceMessage) {
		this.authorizeServiceMessage = authorizeServiceMessage;
	}

	public void setAuthSubDeptNo(String authSubDeptNo) {
		this.authSubDeptNo = authSubDeptNo;
	}

	public void setAuthTypeCode(String authTypeCode) {
		this.authTypeCode = authTypeCode;
	}

	public void setBatchErrorMessage(String batchErrorMessage) {
		this.batchErrorMessage = batchErrorMessage;
	}

	public void setBatchErrorSessionId(String batchErrorSessionId) {
		this.batchErrorSessionId = batchErrorSessionId;
	}

	public void setBatchErrorStatus(boolean batchErrorStatus) {
		this.batchErrorStatus = batchErrorStatus;
	}

	public void setBatchUploadFile(MultipartFile  batchUploadFile) {
		this.batchUploadFile = batchUploadFile;
	}

	public void setBrandMandatory(boolean brandMandatory) {
		this.brandMandatory = brandMandatory;
	}

	public void setButtonViewOverRide() {
		this.buttonViewOverRide = false;
	}

	public void setCandidateType(String candidateType) {
		this.candidateType = candidateType;
	}

	public void setCaseItems(Map<String, CaseItemVO> caseItems) {
		this.caseItems = caseItems;
	}

	public void setCaseViewOverRide() {
		this.caseViewOverRide = false;
	}

	public void setCaseVO(CaseVO caseVO) {
		this.caseVO = caseVO;
	}

	public void setChannels(List<BaseJSFVO> channels) {
		this.channels = CPSHelper.insertBlankSelect(channels);
	}

	public void setCommentsVOs(Map<String, CommentsVO> commentsVOs) {
		this.commentsVOs = commentsVOs;
	}

	public void setConflictStoreVOs(List<ConflictStoreVO> conflictStoreVOs) {
		this.conflictStoreVOs = conflictStoreVOs;
	}

	/**
	 * @param containUpcNew
	 *            the containUpcNew to set
	 */
	public void setContainUpcNew(boolean containUpcNew) {
		this.containUpcNew = containUpcNew;
	}

	public void setCostGroup(String costGroup) {
		this.costGroup = costGroup;
	}

	public void setCostGroupContainsOne(boolean costGroupContainsOne) {
		this.costGroupContainsOne = costGroupContainsOne;
	}

	public void setCostGroups(List<BaseJSFVO> costGroups) {
		CPSHelper.sortAscList(costGroups);
		BaseJSFVO baseJSFVO = new BaseJSFVO("1", "1");
		if (null != costGroups && costGroups.contains(baseJSFVO)) {
			this.costGroupContainsOne = true;
		}
		this.costGroups = costGroups;
	}

	public void setCostGrpStoreMap(Map<String, List<StoreVO>> costGrpStoreMap) {
		this.costGrpStoreMap = costGrpStoreMap;
	}

	public void setCostOwners(List<BaseJSFVO> costOwners) {
		CPSHelper.sortList(costOwners);
		this.costOwners = costOwners;
	}

	public void setDisableWic(boolean disableWic) {
		this.disableWic = disableWic;
	}

	public void setDrugAbb(List<BaseJSFVO> drugAbb) {
		CPSHelper.sortList(drugAbb);
		this.drugAbb = CPSHelper.insertBlankSelect(drugAbb);
	}

	public void setDrugSchedules(List<BaseJSFVO> drugSchedules) {
		CPSHelper.sortList(drugSchedules);
		this.drugSchedules = CPSHelper.insertBlankSelect(drugSchedules);
	}

	public void setDynamicExtendAtrrTab(int dynamicExtendAtrrTab) {
		this.dynamicExtendAtrrTab = dynamicExtendAtrrTab;
	}

	public void setEarlierActionForward(String earlierActionForward) {
		this.earlierActionForward = earlierActionForward;
	}

	public void setEarlierTabIndex(int earlierTabIndex) {
		this.earlierTabIndex = earlierTabIndex;
	}

	/**
	 * @param eDcCaseVO
	 *            the eDcCaseVO to set
	 */
	public void seteDcCaseVO(CaseVO eDcCaseVO) {
		this.eDcCaseVO = eDcCaseVO;
	}

	/**
	 * @param eDcVendorVO
	 *            the eDcVendorVO to set
	 */
	public void seteDcVendorVO(VendorVO eDcVendorVO) {
		this.eDcVendorVO = eDcVendorVO;
	}

	public void setEnableActivateButton(boolean enableActivateButton) {
		this.enableActivateButton = enableActivateButton;
	}

	public void setEnableActiveButton(boolean enableActiveButton) {
		this.enableActiveButton = enableActiveButton;
	}

	public void setEnableClose(boolean enableClose) {
		this.enableClose = enableClose;
	}

	public void setEnableTabs(boolean enableTabs) {
		this.enableTabs = enableTabs;
	}

	public void setExistingUpcProductVO(ProductVO existingUpcProductVO) {
		this.existingUpcProductVO = existingUpcProductVO;
	}

	public void setGraphicsCode(List<BaseJSFVO> graphicsCode) {
		CPSHelper.sortList(graphicsCode);
		this.graphicsCode = CPSHelper.insertBlankSelect(graphicsCode);
	}

	public void setHidBatchUploaded(boolean isHidBatchUploaded) {
		this.isHidBatchUploaded = isHidBatchUploaded;
	}

	public void setHidDescription(String hidDescription) {
		this.hidDescription = hidDescription;
	}

	public void setHidMrtSwitch(boolean hidMrtSwitch) {
		this.hidMrtSwitch = hidMrtSwitch;
	}

	public void setHidUpcCheckDigit(String hidUpcCheckDigit) {
		this.hidUpcCheckDigit = hidUpcCheckDigit;
	}

	public void setHidUpcValue(String hidUpcValue) {
		this.hidUpcValue = hidUpcValue;
	}

	/**
	 * @param imageUploadFileVal
	 *            the imageUploadFile to set
	 */
	public void setImageUploadFile(MultipartFile  imageUploadFileVal) {
		this.imageUploadFile = imageUploadFileVal;
	}

	/**
	 * @param imgStatLstVal
	 *            the imgStatLst to set
	 */
	public void setImgStatLst(List<BaseJSFVO> imgStatLstVal) {
		this.imgStatLst = imgStatLstVal;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public void setLaborCategoryList(List<BaseJSFVO> laborCategoryList) {
		this.laborCategoryList = laborCategoryList;
	}

	public void setListCost(String listCost) {
		this.listCost = listCost;
	}

	public void setListQualifyCondition(List<TaxCategoryVO> listQualifyCondition) {
		this.listQualifyCondition = listQualifyCondition;
	}

	/**
	 * @param lstPluGenerates
	 *            the lstPluGenerates to set
	 */
	public void setLstPluGenerates(List<Integer> lstPluGenerates) {
		this.lstPluGenerates = lstPluGenerates;
	}

	/**
	 * @param lstRateType
	 *            the lstRateType to set
	 */
	public void setLstRateType(List<BaseJSFVO> lstRateType) {
		this.lstRateType = lstRateType;
	}

	/**
	 * @param lstRating
	 *            the lstRating to set
	 */
	public void setLstRating(List<BaseJSFVO> lstRating) {
		this.lstRating = lstRating;
	}

	public void setMatrixMarginClose(boolean matrixMarginClose) {
		this.matrixMarginClose = matrixMarginClose;
	}

	public void setMaxMargin(String maxMargin) {
		this.maxMargin = maxMargin;
	}

	public void setMinMargin(String minMargin) {
		this.minMargin = minMargin;
	}

	public void setModifyProdCand(boolean modifyProdCand) {
		this.modifyProdCand = modifyProdCand;
	}

	public void setMrtActiveProduct(boolean mrtActiveProduct) {
		this.mrtActiveProduct = mrtActiveProduct;
	}

	public void setMRTList(List<MrtVO> list) {
		this.MRTList = list;
	}

	public void setMrtUpcAdded(boolean mrtUpcAdded) {
		this.mrtUpcAdded = mrtUpcAdded;
	}

	public void setMrtViewMode(boolean mrtViewMode) {
		this.mrtViewMode = mrtViewMode;
	}

	public void setMrtvo(MrtVO mrtvo) {
		this.mrtvo = mrtvo;
	}

	public void setNewSubBrand(String newSubBrand) {
		this.newSubBrand = newSubBrand;
	}

	public void setNonSellable(boolean nonSellable) {
		this.nonSellable = nonSellable;
	}

	public void setNormalProduct(boolean isNormalProduct) {
		this.isNormalProduct = isNormalProduct;
	}

	public void setNutrientList(List<BaseJSFVO> nutrientList) {
		CPSHelper.sortList(nutrientList);
		this.nutrientList = CPSHelper.insertBlankSelect(nutrientList);
	}

	public void setPackagingViewOverRide() {
		this.packagingViewOverRide = false;
	}

	public void setPendingCandidateTypes(List<String> pendingCandidateTypes) {
		this.pendingCandidateTypes = pendingCandidateTypes;
	}

	public void setPendingProdIds(List<String> pendingProdIds) {
		this.pendingProdIds = pendingProdIds;
	}

	/**
	 * @param pluRangeOlds
	 *            the pluRangeOlds to set
	 */
	public void setPluRangeOlds(String pluRangeOlds) {
		this.pluRangeOlds = pluRangeOlds;
	}

	public void setPowStatus(List<POWStatus> powStatus) {
		this.powStatus = powStatus;
	}

	/**
	 * @param preventUpdateStore
	 *            the preventUpdateStore to set
	 */
	public void setPreventUpdateStore(boolean preventUpdateStore) {
		this.preventUpdateStore = preventUpdateStore;
	}

	public void setPrintable(boolean printable) {
		this.printable = printable;
	}

	public void setPrintFormVOList(List<PrintFormVO> printFormVOList) {
		this.printFormVOList = printFormVOList;
	}

	public void setProduct(boolean product) {
		this.product = product;
	}

	public void setProductCaseOverridden(boolean productCaseOverridden) {
		this.productCaseOverridden = productCaseOverridden;
	}

	public void setProductDescription(String productDesct) {
		this.productDescription = productDesct;
	}

	public void setProducts(List<SearchResultVO> products) {
		this.products = products;
	}

	public void setProductsSize(int productsSize) {
		this.productsSize = productsSize;
	}

	public void setProductVO(ProductVO productVO) {
		this.productVO = productVO;
	}

	public void setPseLst(List<BaseJSFVO> pseLst) {
		this.pseLst = pseLst;
	}

	public void setPssList(List<BaseJSFVO> pssList) {
		this.pssList = pssList;
	}

	public void setPurchaseTimeList(List<BaseJSFVO> purchaseTimeList) {
		CPSHelper.sortList(purchaseTimeList);
		this.purchaseTimeList = CPSHelper.insertBlankSelect(purchaseTimeList);
	}

	public void setRejectClose(boolean rejectClose) {
		this.rejectClose = rejectClose;
	}

	public void setRejectComments(String rejectComments) {
		this.rejectComments = rejectComments;
	}

	public void setRestrictedSalesAgeLimitList(List<BaseJSFVO> restrictedSalesAgeLimitList) {
		CPSHelper.sortList(restrictedSalesAgeLimitList);
		this.restrictedSalesAgeLimitList = CPSHelper.insertBlankSelect(restrictedSalesAgeLimitList);
	}

	public void setRetail(int retail) {
		this.retail = retail;
	}

	public void setRetailViewOverRide() {
		this.retailViewOverRide = false;
	}

	public void setSavedProductVO(ProductVO savedProductVO) {
		this.savedProductVO = savedProductVO;
	}

	public void setScaleAttrib(String scaleAttrib) {
		this.scaleAttrib = scaleAttrib;
	}

	public void setScaleProduct(boolean scaleProduct) {
		this.scaleProduct = scaleProduct;
	}

	public void setScaleViewOverRide() {
		String userRole = getUserRole();
		if (BusinessConstants.PIA_ROLE.equalsIgnoreCase(userRole) || BusinessConstants.PIA_LEAD_ROLE.equalsIgnoreCase(userRole) || BusinessConstants.ADMIN_ROLE.equalsIgnoreCase(userRole)
				|| BusinessConstants.SCALE_MAN_ROLE.equalsIgnoreCase(userRole)) {
			this.scaleViewOverRide = false;
		}
	}

	public void setScanGun(String scanGun) {
		this.scanGun = scanGun;
	}

	public void setSearch(boolean search) {
		this.search = search;
	}

	/**
	 * @param selectedAttrLabelVal
	 *            the selectedAttrLabel to set
	 */
	public void setSelectedAttrLabel(String selectedAttrLabelVal) {
		this.selectedAttrLabel = selectedAttrLabelVal;
	}

	/**
	 * @param selectedUniqueIdVal
	 *            the selectedUniqueId to set
	 */
	public void setSelectedUniqueId(String selectedUniqueIdVal) {
		this.selectedUniqueId = selectedUniqueIdVal;
	}

	public void setShowImport(boolean showImport) {
		this.showImport = showImport;
	}

	public void setStore(boolean store) {
		this.store = store;
	}

	public void setStoreVOs(Map<String, StoreVO> storeVOs) {
		this.storeVOs = storeVOs;
	}

	public void setTabIndex(int tabIndex) {
		this.tabIndex = tabIndex;
	}

	public void setTaxQualify(String taxQualify) {
		this.taxQualify = taxQualify;
	}

	public void setTestScanNeeded(boolean isTestScanNeeded) {
		this.testScanNeeded = isTestScanNeeded;
	}

	public void setTestScanUserSwitch(boolean testScanUserSwitch) {
		this.testScanUserSwitch = testScanUserSwitch;
	}

	public void setTheFile(MultipartFile  theFile) {
		this.theFile = theFile;
	}

	public void setTobaccoProdtype(List<BaseJSFVO> tobaccoProdtype) {
		this.tobaccoProdtype = tobaccoProdtype;
	}

	public void setTopToTops(List<BaseJSFVO> topToTops) {
		CPSHelper.sortList(topToTops);
		this.topToTops = topToTops;
	}

	public void setUnitsOfMeasure(List<BaseJSFVO> unitsOfMeasure) {
		this.unitsOfMeasure = unitsOfMeasure;
	}

	public void setUpcAdded(boolean upcAdded) {
		this.upcAdded = upcAdded;
	}

	public void setUpcCheck(boolean upcCheck) {
		this.upcCheck = upcCheck;
	}

	/**
	 * @param upcSelectVal
	 *            the upcSelect to set
	 */
	public void setUpcSelect(String upcSelectVal) {
		this.upcSelect = upcSelectVal;
	}

	public void setUpcSubValue(String upcSubValue) {
		this.upcSubValue = upcSubValue;
	}

	public void setUpcType(List<BaseJSFVO> upcType) {
		this.upcType = upcType;
	}

	public void setUpcValue(String upcValue) {
		this.upcValue = upcValue;
	}

	public void setUpcValueFromMRT(boolean upcValueFromMRT) {
		this.upcValueFromMRT = upcValueFromMRT;
	}

	public void setUpcViewOverRide() {
		this.upcViewOverRide = false;
	}

	public void setUpcvo(UPCVO upcvo) {
		this.upcvo = upcvo;
	}

	public void setUpcVOs(Map<String, UPCVO> upcVOs) {
		this.upcVOs = upcVOs;
	}

	public void setValidForResults(boolean validForResults) {
		this.validForResults = validForResults;
	}

	public void setVendorAndDSD(boolean isVendorAndDSD) {
		this.vendorAndDSD = isVendorAndDSD;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}

	public void setVendorListCost(String vendorListCost) {
		this.vendorListCost = vendorListCost;
	}

	public void setVendors(List<Vendor> vendors) {
		this.vendors.clear();
		for (Vendor vendor : vendors) {
			addVendors(vendor);
		}
	}

	public void setVendors(Map<String, Vendor> vendors) {
		this.vendors = vendors;
	}

	public void setVendorVO(VendorVO vendorVO) {
		this.vendorVO = vendorVO;
	}

	public void setViewAddInforPage(boolean viewAddInforPage) {
		this.viewAddInforPage = viewAddInforPage;
	}

	/**
	 * @param isViewImgAtt
	 *            the isViewImgAtt to set
	 */
	public void setViewImgAtt(boolean isViewImgAtt) {
		this.isViewImgAtt = isViewImgAtt;
	}

	public void setViewOnlyProductMRT(boolean viewOnlyProductMRT) {
		this.viewOnlyProductMRT = viewOnlyProductMRT;
	}

	public void setViewOverRide() {
		this.viewOverRide = true;
	}

	public void setViewProduct() {
		this.viewProduct = true;
	}

	public void setWareHouseList(List<WareHouseVO> wareHouseList) {
		this.wareHouseList = wareHouseList;
	}

	public void setWareHouseListSize(int wareHouseListSize) {
	}

	public void setWic(String wic) {
		this.wic = wic;
	}

	/**
	 * Updates the vendor location list to the default vendor VO in form
	 * 
	 * @param classField
	 * @param comm
	 * @param chnl
	 * @throws CPSGeneralException
	 */
	public void updateVendorList(String deptNo, String subDeptNo, String classField, String comm, String chnl) throws CPSGeneralException {
		if (BusinessUtil.isVendor(getUserRole())) {
			Map<String, List<VendorLocationVO>> vendMap = (Map<String, List<VendorLocationVO>>) getSession().getAttribute("vendorMap");
			if (vendMap == null) {
				vendMap = updateVendorMap();
			}
			if (chnl != null && CHANNEL_DSD_CODE.equalsIgnoreCase(chnl)) {
				List<VendorLocationVO> sessionList = vendMap.get("dsdLst");
				List<VendorLocationVO> total = getSessionVO().getVendorLocationVOs(deptNo, subDeptNo, classField, null, chnl);
				List<VendorLocationVO> filtered = getFilteredList(total, sessionList);
				if (null != filtered && !filtered.isEmpty()) {
					getVendorVO().setVendorLocationList(filtered);
				} else {
					getVendorVO().setVendorLocationList(new ArrayList<VendorLocationVO>());
				}
			} else if (chnl != null && CHANNEL_WHS_CODE.equalsIgnoreCase(chnl)) {
				List<VendorLocationVO> sessionList = vendMap.get("whsLst");
				List<VendorLocationVO> total = getSessionVO().getVendorLocationVOs(null, null, classField, comm, chnl);
				List<VendorLocationVO> filtered = getFilteredList(total, sessionList);
				if (null != filtered && !filtered.isEmpty()) {
					getVendorVO().setVendorLocationList(filtered);
				} else {
					getVendorVO().setVendorLocationList(new ArrayList<VendorLocationVO>());
				}
			} else {
				List<VendorLocationVO> sessionList = new ArrayList<VendorLocationVO>();
				if (null != vendMap.get("dsdLst")) {
					sessionList.addAll(vendMap.get("dsdLst"));
				}
				if (null != vendMap.get("whsLst")) {
					sessionList.addAll(vendMap.get("whsLst"));
				}
				List<VendorLocationVO> total = getSessionVO().getVendorLocationVOs(deptNo, subDeptNo, classField, comm, chnl);
				List<VendorLocationVO> filtered = getFilteredList(total, sessionList);
				if (null != filtered && !filtered.isEmpty()) {
					getVendorVO().setVendorLocationList(filtered);
				} else {
					getVendorVO().setVendorLocationList(new ArrayList<VendorLocationVO>());
				}
			}
		} else {
			getVendorVO().setVendorLocationList(getSessionVO().getVendorLocationVOs(deptNo, subDeptNo, classField, comm, chnl));
		}
	}

	@SuppressWarnings("unchecked")
	private Map<String, List<VendorLocationVO>> updateVendorMap() throws CPSGeneralException {
		UserInfo info = null;
		Authentication au = SecurityContextHolder.getContext().getAuthentication();
		if (au != null) {
			info = (UserInfo) au.getPrincipal();
		}
		Map<String, List<VendorLocationVO>> vendorMap = new HashMap<String, List<VendorLocationVO>>();
		List<String> vendorIdList = new ArrayList<String>();
		if (null != info) {
			List<VendorOrg> vendorIds = info.getVendorOrgs();
			List<VendorLocationVO> whsList = new ArrayList<VendorLocationVO>();
			List<VendorLocationVO> dsdList = new ArrayList<VendorLocationVO>();
			if (null != vendorIds) {
				for (VendorOrg vendorOrg : vendorIds) {
					vendorIdList.add(vendorOrg.getVendorOrgId());
				}
			}

			String vendorId = info.getVendorOrgId();
			if (CPSHelper.isValidNumber(vendorId)) {
				vendorIdList.add(vendorId);
			}
			List<VendorLocationVO> vendList = CommonBridge.getAddNewCandidateServiceInstance().getVendorList(vendorIdList);
			if (null != vendList && !vendList.isEmpty()) {
				for (VendorLocationVO vendorLocationVO : vendList) {
					if ("D".equalsIgnoreCase(vendorLocationVO.getVendorLocationType())) {
						dsdList.add(vendorLocationVO);
					} else if ("V".equalsIgnoreCase(vendorLocationVO.getVendorLocationType())) {
						whsList.add(vendorLocationVO);
					}
				}
			}
			if (null != whsList && !whsList.isEmpty()) {
				vendorMap.put("whsLst", whsList);
			}
			if (null != dsdList && !dsdList.isEmpty()) {
				vendorMap.put("dsdLst", dsdList);
			}
		}
		return vendorMap;
	}

//	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
//		int tab = getTabIndex();
//		ActionErrors errors = new ActionErrors();
//		switch (tab) {
//		case TAB_PRODUCT_CLASSIFICATION:
//			// if( null == getBdm() || getBdm().trim().equals("") ||
//			// "-1".equals(getBdm().trim())){
//			// errors.add("selectedBDMId", new
//			// ActionMessage("CPS.error.noBDM"));
//			// }
//			break;
//		case TAB_PROD_UPC:
//
//			/*
//			 * break; case TAB_AUHT_DIST:
//			 */
//
//			break;
//		default:
//			break;
//		}
//		return errors;
//	}

	/**
	 * @return the typeDocument
	 */
	public String getTypeDocument() {
		return typeDocument;
	}

	/**
	 * @param typeDocument the typeDocument to set
	 */
	public void setTypeDocument(String typeDocument) {
		this.typeDocument = typeDocument;
	}

	/**
	 * @return the docCatList
	 */
	public List<BaseJSFVO> getDocCatList() {
		return docCatList;
	}

	/**
	 * @param docCatList the docCatList to set
	 */
	public void setDocCatList(List<BaseJSFVO> docCatList) {
		this.docCatList = docCatList;
	}

	public String getHiddenKitCost() {
		return hiddenKitCost;
	}

	public void setHiddenKitCost(String hiddenKitCost) {
		this.hiddenKitCost = hiddenKitCost;
	}

}