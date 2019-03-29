package com.heb.operations.cps.model;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.ejb.vo.BdmVO;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("serial")
public class ManageCandidate extends HebBaseInfo {

	public static final String FORM_NAME = "ManageCandidate";
	private boolean activateSwitch = false;
	public boolean advSearch;

	private List<BdmVO> allBDMs = null;
	private List<BaseJSFVO> allCommodities = null;
	private List<BaseJSFVO> allPendingAction = null;
	private List<BaseJSFVO> allStatus = null;
	private String applySelected = null;
	private List<BaseJSFVO> applyToSelected = null;
	private String batchCandidate;
	private String clas = null;
	private List<BaseJSFVO> classes = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> commodities = new ArrayList<BaseJSFVO>();
	private String costLink = null;
	private CandidateSearchCriteria criteria = new CandidateSearchCriteria();
	private String direction;
	private String fromDate = null;
	private boolean hidBatchUploadSwitch = false;
	private boolean hidManageMrtSwitch = true;
	private String itemCode = null;
	private String listCost;
	private List<BaseJSFVO> listCosts = null;
	private String lstFilter;
	private String lstValueFilter;
	private String masterPack;
	private List<BaseJSFVO> masterPackDSD = null;
	private List<MrtVO> MRTList = new ArrayList<MrtVO>();
	private boolean ownBrand = false;
	private List<BaseJSFVO> pendingActions = null;
	private String prdDesc;
	private List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();
	private List<PrintFormVO> printFormVOMRTList = new ArrayList<PrintFormVO>();
	private List<BaseJSFVO> prodDescriptions = null;
	private List<BaseJSFVO> prodListCosts = null;
	private String prodPresDate;
	private List<BaseJSFVO> prodPresDates = null;
	private List<BaseJSFVO> prodSources = null;
	private String productCode = null;
	private String productDescription = null;
	private String productId = null;

	private List<SearchResultVO> products = new ArrayList<SearchResultVO>();

	private List<SearchResultVO> productsDisplay = new ArrayList<SearchResultVO>();

	private int productsSize;

	private List<SearchResultVO> productsTemp = new ArrayList<SearchResultVO>();

	private String productType = null;

	private boolean rejectClose = false;

	private String rejectComments;

	private List<String> rejectCommentsProdId = new ArrayList<String>();

	private List<String> rejectCommentsProdIdType = new ArrayList<String>();
	private String rejectMessageComments;
	private String retailLink = null;
	private boolean rx = false;
	private boolean scale = false;
	private String selectedBDMId = null;

	private String selectedCommodityId = null;
	private String selectedPendingAction = null;
	private String selectedSource = null;
	private String selectedStatus = null;
	private String selectedTestScan = null;
	private String shipPack;
	private List<BaseJSFVO> shipPacksWHSE = null;
	private int sortCaseValue = 1;

	private String source;

	public String getScanGun() {
		return scanGun;
	}

	public void setScanGun(String scanGun) {
		this.scanGun = scanGun;
	}

	private String scanGun;
	// for search

	private List<BaseJSFVO> sources = null;

	private String status;

	private HashMap<Integer, Boolean> statusCandidates = new HashMap<Integer, Boolean>();
	private List<BaseJSFVO> statuses = null;
	private List<BaseJSFVO> subCommodities = new ArrayList<BaseJSFVO>();
	private String tabIndex;
	private String temp1;
	private boolean testScanNeeded;
	private List<BaseJSFVO> testScans = null;
	private String testScanStatus;
	private List<BaseJSFVO> testScanStatuses = null;
	private boolean testScanUserSwitch = false;
	private boolean tobacco = false;
	private String toDate = null;
	private List<BaseJSFVO> unitUPCs = null;
	private String upc1 = null;
	private Map<String, UPCVO> upcVOs = new HashMap<String, UPCVO>();
	private boolean validForCandSearch = false;
	private boolean validForResults;
	private String vendorDesc = null;
	private List<BaseJSFVO> vendorDescs = null;
	private String vendorId = null;
	// product attributes for filtering
	private List<BaseJSFVO> vendorIds = null;
	private String vndrDesc;
	private String vndrId;
	private String vndrUnitUpc;
	public ManageCandidate() {
		super();
		setCurrentAppName("Manage Candidate");
		this.criteria = new CandidateSearchCriteria();
		List<SearchResultVO> products = new ArrayList<SearchResultVO>();
		this.setProducts(products);
		this.setProductsTemp(products);
	}

	/**
	 * Adds one UPC VO
	 * 
	 * @param upcvo
	 */
	public void addUpcVOs(UPCVO upcvo) {
		String time = String.valueOf(System.currentTimeMillis() + upcvo.hashCode());
		upcvo.setUniqueId(time);
		this.upcVOs.put(time, upcvo);
	}

	public void clearUPCVOs() {
		this.upcVOs.clear();
	}

	public List<BdmVO> getAllBDMs() {
		return this.allBDMs;
	}
	public List<BaseJSFVO> getAllCommodities() {
		allCommodities = new ArrayList<BaseJSFVO>();
		allCommodities.add(new BaseJSFVO("4", "--Select--"));
		allCommodities.add(new BaseJSFVO("1", "Athletic Goods"));
		allCommodities.add(new BaseJSFVO("2", "Frozen Fruits"));
		allCommodities.add(new BaseJSFVO("3", "Flowers"));

		return this.allCommodities;
	}
	public List<BaseJSFVO> getAllPendingAction() {
		this.allPendingAction = new ArrayList<BaseJSFVO>();
		this.allPendingAction.add(new BaseJSFVO("2", "--Select--"));
		this.allPendingAction.add(new BaseJSFVO("1", "Pending Details"));
		this.allPendingAction.add(new BaseJSFVO("4", "Complete"));
		return this.allPendingAction;
	}
	public List<BaseJSFVO> getAllStatus() {
		return this.allStatus;
	}
	public String getApplySelected() {
		return this.applySelected;
	}
	public List<BaseJSFVO> getApplyToSelected() {
		this.applyToSelected = new ArrayList<BaseJSFVO>();
		this.applyToSelected.add(new BaseJSFVO("1", "CO - Copy new from Existing Candidate"));
		this.applyToSelected.add(new BaseJSFVO("2", "CP - Copy new from Existing Product"));
		this.applyToSelected.add(new BaseJSFVO("3", "RJ - Reject Candidate(s)"));
		this.applyToSelected.add(new BaseJSFVO("4", "AP - Approve/Accept Candidate(s)"));
		this.applyToSelected.add(new BaseJSFVO("5", "TS - Test Scan"));
		this.applyToSelected.add(new BaseJSFVO("6", "TC - Change UPC Type"));
		this.applyToSelected.add(new BaseJSFVO("7", "UC - Change Unit/Case UPC"));
		this.applyToSelected.add(new BaseJSFVO("8", "MO - Modify Candidate"));
		return this.applyToSelected;
	}
	public String getBatchCandidate() {
		return batchCandidate;
	}

	public String getClas() {
		return this.clas;
	}

	public List<BaseJSFVO> getClasses() {
		return this.classes;
	}

	public List<BaseJSFVO> getCommodities() {
		return this.commodities;
	}

	public String getCostLink() {
		return this.costLink;
	}

	public CandidateSearchCriteria getCriteria() {
		return this.criteria;
	}

	public String getDirection() {
		return this.direction;
	}

	public String getFromDate() {
		return this.fromDate;
	}

	public String getItemCode() {
		return this.itemCode;
	}

	public String getListCost() {
		return this.listCost;
	}

	public List<BaseJSFVO> getListCosts() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getListCost(), resultVO.getListCost());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	/**
	 * @return the lstFilter
	 */
	public String getLstFilter() {
		return this.lstFilter;
	}

	/**
	 * @return the lstValueFilter
	 */
	public String getLstValueFilter() {
		return this.lstValueFilter;
	}

	public String getMasterPack() {
		return this.masterPack;
	}

	public List<BaseJSFVO> getMasterPackDSD() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getMasterPack(), resultVO.getMasterPack());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	public List<MrtVO> getMRTList() {
		return this.MRTList;
	}

	public String getPrdDesc() {
		return this.prdDesc;
	}

	public List<PrintFormVO> getPrintFormVOList() {
		return this.printFormVOList;
	}

	public List<PrintFormVO> getPrintFormVOMRTList() {
		return this.printFormVOMRTList;
	}

	public List<BaseJSFVO> getProdDescriptions() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO baseJSFVO = new BaseJSFVO(resultVO.getProdDescription(), resultVO.getProdDescription());
			if (!list.contains(baseJSFVO)) {
				list.add(baseJSFVO);
			}
		}
		return list;
	}

	public List<BaseJSFVO> getProdListCosts() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getListCost(), resultVO.getListCost());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	public String getProdPresDate() {
		return this.prodPresDate;
	}

	public List<BaseJSFVO> getProdPresDates() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getPressDate(), resultVO.getPressDate());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	public List<BaseJSFVO> getProdSources() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getSource(), resultVO.getSource());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	public String getProductCode() {
		return this.productCode;
	}

	public String getProductDescription() {
		return this.productDescription;
	}

	public String getProductId() {
		return this.productId;
	}

	public List<SearchResultVO> getProducts() {
		return this.products;
	}

	public List<SearchResultVO> getProductsDisplay() {
		return this.productsDisplay;
	}

	public int getProductsSize() {
		return this.productsSize;
	}

	public List<SearchResultVO> getProductsTemp() {
		return this.productsTemp;
	}

	public String getProductType() {
		return this.productType;
	}

	public String getRejectComments() {
		return this.rejectComments;
	}

	public List<String> getRejectCommentsProdId() {
		return this.rejectCommentsProdId;
	}

	public List<String> getRejectCommentsProdIdType() {
		return this.rejectCommentsProdIdType;
	}

	public String getRejectMessageComments() {
		return this.rejectMessageComments;
	}

	public String getRetailLink() {
		return this.retailLink;
	}

	public String getSelectedBDMId() {
		return this.selectedBDMId;
	}

	public String getSelectedCommodityId() {
		return this.selectedCommodityId;
	}

	public String getSelectedPendingAction() {
		return this.selectedPendingAction;
	}

	public String getSelectedSource() {
		return this.selectedSource;
	}

	public String getSelectedStatus() {
		return this.selectedStatus;
	}

	public String getSelectedTestScan() {
		return this.selectedTestScan;
	}

	public String getShipPack() {
		return this.shipPack;
	}

	public List<BaseJSFVO> getShipPacksWHSE() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getShipPack(), resultVO.getShipPack());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	public int getSortCaseValue() {
		return this.sortCaseValue;
	}

	public String getSource() {
		return this.source;
	}

	public List<BaseJSFVO> getSources() {
		this.sources = new ArrayList<BaseJSFVO>();
		this.sources.add(new BaseJSFVO("1", "Incomplete"));
		this.sources.add(new BaseJSFVO("2", "Complete"));
		this.sources.add(new BaseJSFVO("3", "Overriden"));
		CPSHelper.sortList(this.sources);
		CPSHelper.insertBlankSelect(this.sources);
		return this.sources;
	}

	public String getStatus() {
		return this.status;
	}

	public HashMap<Integer, Boolean> getStatusCandidates() {
		return this.statusCandidates;
	}

	public List<BaseJSFVO> getStatuses() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			BaseJSFVO b = new BaseJSFVO(resultVO.getWorkStatusCode(), resultVO.getWorkStatusDesc());
			if (!list.contains(b)) {
				list.add(b);
			}
		}
		return list;
	}

	@Override
	public String getStrutsFormName() {
		return FORM_NAME;
	}

	public List<BaseJSFVO> getSubCommodities() {
		return this.subCommodities;
	}

	public String getTabIndex() {
		return this.tabIndex;
	}

	public String getTemp1() {
		return this.temp1;
	}

	public List<BaseJSFVO> getTestScans() {
		this.testScans = new ArrayList<BaseJSFVO>();
		this.testScans.add(new BaseJSFVO("1", "Incomplete"));
		this.testScans.add(new BaseJSFVO("2", "Not Required"));
		this.testScans.add(new BaseJSFVO("3", "Complete"));
		this.testScans.add(new BaseJSFVO("4", "Overridden"));
		CPSHelper.sortList(this.testScans);
		return this.testScans;
	}

	public String getTestScanStatus() {
		return this.testScanStatus;
	}

	public List<BaseJSFVO> getTestScanStatuses() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			if (CPSHelper.isNotEmpty(resultVO.getTestScanStatus())) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getTestScanStatus(), resultVO.getTestScanStatus());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		}
		return list;
	}

	public String getToDate() {
		return this.toDate;
	}

	// prod list attrbutes for search...
	public List<BaseJSFVO> getUnitUPCs() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			if (CPSHelper.isNotEmpty(resultVO.getUnitUPC())) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getUnitUPC(), resultVO.getUnitUPC());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		}
		return list;
	}

	public String getUpc1() {
		return this.upc1;
	}

	public List<UPCVO> getUpcVOs() {
		List<UPCVO> list = new ArrayList<UPCVO>();
		list.addAll(this.upcVOs.values());
		return list;
	}

	public UPCVO getUpcVOs(String uniqueId) {
		return this.upcVOs.get(uniqueId);
	}

	/*
	 * public List<BaseJSFVO> getPendingActions() { int i=0; List<BaseJSFVO>
	 * list = new ArrayList<BaseJSFVO>(); for(ResultVO resultVO : products){
	 * list.add(new
	 * BaseJSFVO(resultVO.getPendingAction(),resultVO.getPendingAction())); }
	 * return list; } public void setPendingActions(List<BaseJSFVO>
	 * pendingActions) { this.pendingActions = pendingActions; }
	 */
	public String getVendorDesc() {
		return this.vendorDesc;
	}

	public List<BaseJSFVO> getVendorDescs() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			if (CPSHelper.isNotEmpty(resultVO.getVendorDesc())) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getVendorDesc(), resultVO.getVendorDesc());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		}
		return list;
	}

	public String getVendorId() {
		return this.vendorId;
	}

	public List<BaseJSFVO> getVendorIds() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (SearchResultVO resultVO : this.products) {
			if (CPSHelper.isNotEmpty(resultVO.getVendorId())) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getVendorId(), resultVO.getVendorId());
				if (!list.contains(b)) {
					list.add(b);
				}
			}

		}
		return list;
	}

	public String getVndrDesc() {
		return this.vndrDesc;
	}

	public String getVndrId() {
		return this.vndrId;
	}

	public String getVndrUnitUpc() {
		return this.vndrUnitUpc;
	}

	public boolean isActivateSwitch() {
		return this.activateSwitch;
	}

	public boolean isAdvSearch() {
		return this.advSearch;
	}

	public boolean isHidBatchUploadSwitch() {
		return this.hidBatchUploadSwitch;
	}

	public boolean isHidManageMrtSwitch() {
		return this.hidManageMrtSwitch;
	}

	public boolean isOwnBrand() {
		return this.ownBrand;
	}

	public boolean isRejectClose() {
		return this.rejectClose;
	}

	public boolean isRx() {
		return this.rx;
	}

	public boolean isScale() {
		return this.scale;
	}

	public boolean isTestScanNeeded() {
		return this.testScanNeeded;
	}

	public boolean isTestScanUserSwitch() {
		return this.testScanUserSwitch;
	}

	public boolean isTobacco() {
		return this.tobacco;
	}

	public boolean isValidForCandSearch() {
		return this.validForCandSearch;
	}

	/**
	 * @return the validForResults
	 */
	public boolean isValidForResults() {
		return this.validForResults;
	}

	public boolean isVendor() {
		String userRole = getUserRole();
		return (CPSConstants.UNREGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole) || CPSConstants.REGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole));
	}

	/**
	 * removes the upcVO
	 * 
	 * @param key
	 */
	public UPCVO removeUPCVO(String key) {
		return this.upcVOs.remove(key);
	}

//	@Override
//	public void reset(ActionMapping mapping, HttpServletRequest req) {
//		super.reset(mapping, req);
//		this.criteria.setMrtSwitchCheck(false);
//	}

	public void setActivateSwitch(boolean activateSwitch) {
		this.activateSwitch = activateSwitch;
	}

	public void setAdvSearch(boolean advSearch) {
		this.advSearch = advSearch;
	}

	public void setAllBDMs(List<BdmVO> allBDMs) {
		this.allBDMs = allBDMs;
	}

	public void setAllCommodities(List<BaseJSFVO> allCommodities) {
		this.allCommodities = allCommodities;
	}

	public void setAllPendingAction(List<BaseJSFVO> allPendingAction) {
		this.allPendingAction = allPendingAction;
	}

	public void setAllStatus(List<BaseJSFVO> allStatus) {
		this.allStatus = allStatus;
	}

	public void setApplySelected(String applySelected) {
		this.applySelected = applySelected;
	}

	public void setApplyToSelected(List<BaseJSFVO> applyToSelected) {
		this.applyToSelected = applyToSelected;
	}

	public void setBatchCandidate(String batchCandidate) {
		this.batchCandidate = batchCandidate;
	}

	public void setClas(String clas) {
		this.clas = clas;
	}

	public void setClasses(List<BaseJSFVO> classes) {
		this.classes = classes;
	}

	public void setCommodities(List<BaseJSFVO> commodities) {
		CPSHelper.sortList(commodities);
		this.commodities = commodities;
	}

	public void setCostLink(String costLink) {
		this.costLink = costLink;
	}

	public void setCriteria(CandidateSearchCriteria criteria) {
		this.criteria = criteria;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public void setHidBatchUploadSwitch(boolean hidBatchUploadSwitch) {
		this.hidBatchUploadSwitch = hidBatchUploadSwitch;
	}

	public void setHidManageMrtSwitch(boolean hidManageMrtSwitch) {
		this.hidManageMrtSwitch = hidManageMrtSwitch;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public void setListCost(String listCost) {
		this.listCost = listCost;
	}

	public void setListCosts(List<BaseJSFVO> listCosts) {
		this.listCosts = listCosts;
	}

	/**
	 * @param lstFilter
	 *            the lstFilter to set
	 */
	public void setLstFilter(String lstFilter) {
		this.lstFilter = lstFilter;
	}

	/**
	 * @param lstValueFilter
	 *            the lstValueFilter to set
	 */
	public void setLstValueFilter(String lstValueFilter) {
		this.lstValueFilter = lstValueFilter;
	}

	public void setMasterPack(String masterPack) {
		this.masterPack = masterPack;
	}

	public void setMasterPackDSD(List<BaseJSFVO> shipPacksDSD) {
		this.masterPackDSD = shipPacksDSD;
	}

	public void setMRTList(List<MrtVO> list) {
		this.MRTList = list;
	}

	public void setOwnBrand(boolean ownBrand) {
		this.ownBrand = ownBrand;
	}

	public void setPrdDesc(String prdDesc) {
		this.prdDesc = prdDesc;
	}

	public void setPrintFormVOList(List<PrintFormVO> printFormVOList) {
		this.printFormVOList = printFormVOList;
	}

	public void setPrintFormVOMRTList(List<PrintFormVO> printFormVOMRTList) {
		this.printFormVOMRTList = printFormVOMRTList;
	}

	public void setProdDescriptions(List<BaseJSFVO> prodDescriptions) {
		this.prodDescriptions = prodDescriptions;
	}

	public void setProdListCosts(List<BaseJSFVO> prodListCosts) {
		this.prodListCosts = prodListCosts;
	}

	public void setProdPresDate(String prodPresDate) {
		this.prodPresDate = prodPresDate;
	}

	public void setProdPresDates(List<BaseJSFVO> prodPresDates) {
		this.prodPresDates = prodPresDates;
	}

	public void setProdSources(List<BaseJSFVO> prodSources) {
		this.prodSources = prodSources;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public void setProducts(List<SearchResultVO> products) {
		this.products = products;
	}

	public void setProductsDisplay(List<SearchResultVO> productsDisplay) {
		this.productsDisplay = productsDisplay;
	}

	public void setProductsSize(int productsSize) {
		this.productsSize = productsSize;
	}

	public void setProductsTemp(List<SearchResultVO> productsTemp) {
		this.productsTemp = productsTemp;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public void setRejectClose(boolean rejectClose) {
		this.rejectClose = rejectClose;
	}

	public void setRejectComments(String rejectComments) {
		this.rejectComments = rejectComments;
	}

	public void setRejectCommentsProdId(List<String> rejectCommentsProdId) {
		this.rejectCommentsProdId = rejectCommentsProdId;
	}

	public void setRejectCommentsProdIdType(List<String> rejectCommentsProdIdType) {
		this.rejectCommentsProdIdType = rejectCommentsProdIdType;
	}

	public void setRejectMessageComments(String rejectMessageComments) {
		this.rejectMessageComments = rejectMessageComments;
	}

	public void setRetailLink(String retailLink) {
		this.retailLink = retailLink;
	}

	public void setRx(boolean rx) {
		this.rx = rx;
	}

	public void setScale(boolean scale) {
		this.scale = scale;
	}

	public void setSelectedBDMId(String selectedBDMId) {
		this.selectedBDMId = selectedBDMId;
	}

	public void setSelectedCommodityId(String selectedCommodityId) {
		this.selectedCommodityId = selectedCommodityId;
	}

	public void setSelectedPendingAction(String selectedPendingAction) {
		this.selectedPendingAction = selectedPendingAction;
	}

	public void setSelectedSource(String selectedSource) {
		this.selectedSource = selectedSource;
	}

	public void setSelectedStatus(String selectedStatus) {
		this.selectedStatus = selectedStatus;
	}

	public void setSelectedTestScan(String selectedTestScan) {
		this.selectedTestScan = selectedTestScan;
	}

	public void setShipPack(String shipPack) {
		this.shipPack = shipPack;
	}

	public void setShipPacksWHSE(List<BaseJSFVO> shipPacksWHSE) {
		this.shipPacksWHSE = shipPacksWHSE;
	}

	public void setSortCaseValue(int sortCaseValue) {
		this.sortCaseValue = sortCaseValue;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public void setSources(List<BaseJSFVO> sources) {
		this.sources = sources;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setStatusCandidates(HashMap<Integer, Boolean> statusCandidates) {
		this.statusCandidates = statusCandidates;
	}

	public void setStatuses(List<BaseJSFVO> statuses) {
		this.statuses = statuses;
	}

	public void setSubCommodities(List<BaseJSFVO> subCommodities) {
		CPSHelper.sortList(subCommodities);
		this.subCommodities = subCommodities;
	}

	public void setTabIndex(String tabIndex) {
		this.tabIndex = tabIndex;
	}

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}

	public void setTestScanNeeded(boolean testScanNeeded) {
		this.testScanNeeded = testScanNeeded;
	}

	public void setTestScans(List<BaseJSFVO> testScans) {
		this.testScans = testScans;
	}

	public void setTestScanStatus(String testScanStatus) {
		this.testScanStatus = testScanStatus;
	}

	public void setTestScanStatuses(List<BaseJSFVO> testScanStatuses) {
		this.testScanStatuses = testScanStatuses;
	}

	public void setTestScanUserSwitch(boolean testScanUserSwitch) {
		this.testScanUserSwitch = testScanUserSwitch;
	}

	public void setTobacco(boolean tobacco) {
		this.tobacco = tobacco;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public void setUnitUPCs(List<BaseJSFVO> unitUPCs) {
		this.unitUPCs = unitUPCs;
	}

	public void setUpc1(String upc1) {
		this.upc1 = upc1;
	}

	public void setValidForCandSearch(boolean validForCandSearch) {
		this.validForCandSearch = validForCandSearch;
	}

	/**
	 * @param validForResults
	 *            the validForResults to set
	 */
	public void setValidForResults(boolean validForResults) {
		this.validForResults = validForResults;
	}

	public void setVendorDesc(String vendorDesc) {
		this.vendorDesc = vendorDesc;
	}

	public void setVendorDescs(List<BaseJSFVO> vendorDescs) {
		this.vendorDescs = vendorDescs;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}

	public void setVendorIds(List<BaseJSFVO> vendorIds) {
		this.vendorIds = vendorIds;
	}

	public void setVndrDesc(String vndrDesc) {
		this.vndrDesc = vndrDesc;
	}

	public void setVndrId(String vndrId) {
		this.vndrId = vndrId;
	}

	public void setVndrUnitUpc(String vndrUnitUpc) {
		this.vndrUnitUpc = vndrUnitUpc;
	}

}
