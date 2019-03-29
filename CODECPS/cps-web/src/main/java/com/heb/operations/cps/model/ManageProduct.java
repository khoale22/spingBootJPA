package com.heb.operations.cps.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.ejb.vo.BdmVO;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.CandidateSearchCriteria;
import com.heb.operations.cps.vo.ProductSearchResultVO;
import com.heb.operations.cps.vo.UPCVO;

public class ManageProduct extends HebBaseInfo {

	public static final String FORM_NAME = "ManageProduct";

	private String activateDate;

	private List<BaseJSFVO> activationDate = null;
	public boolean advSearch;
	private List<BdmVO> allBDMs = null;
	private List<BaseJSFVO> allCommodities = null;
	private List<BaseJSFVO> allPendingAction = null;
	private List<BaseJSFVO> allStatus = null;
	private String applySelected = null;
	private List<BaseJSFVO> applyToSelected = null;
	private String clas = null;
	private List<BaseJSFVO> classes = new ArrayList<BaseJSFVO>();
	private String costLink = null;
	private String direction;
	private String fromDate = null;
	private boolean hidManageMrtSwitch = true;
	private String itemCode = null;
	private String listCost;
	private List<BaseJSFVO> listCosts = null;
	private String masterPack;
	private List<BaseJSFVO> masterPackDSD = null;

	private boolean ownBrand = false;
	private List<BaseJSFVO> pendingActions = null;
	private String prdDesc;
	private CandidateSearchCriteria prodcriteria = new CandidateSearchCriteria();
	private List<BaseJSFVO> prodDescriptions = null;
	private String prodItemCode;
	private List<BaseJSFVO> prodListCosts = null;
	private String prodPresDate;
	private List<BaseJSFVO> prodPresDates = null;
	private List<BaseJSFVO> prodSources = null;
	private String productCode = null;
	private String productDescription = null;
	private String productId = null;

	private List<BaseJSFVO> productItemCode = null;
	private List<ProductSearchResultVO> products = new ArrayList<ProductSearchResultVO>();
	private List<ProductSearchResultVO> productsTemp = new ArrayList<ProductSearchResultVO>();
	private String productType = null;

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

	// for search
	private List<BaseJSFVO> shipPacksWHSE = null;
	private int sortCaseValue = 1;
	private String source;
	private List<BaseJSFVO> sources = null;
	private String status;
	private String temp1;
	private List<BaseJSFVO> testScans = null;
	private String testScanStatus;
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

	private List<BaseJSFVO> commodities = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> subCommodities = new ArrayList<BaseJSFVO>();

	public ManageProduct() {
		super();
		setCurrentAppName("Manage Product");
		prodcriteria = new CandidateSearchCriteria();
		List<ProductSearchResultVO> products = new ArrayList<ProductSearchResultVO>();
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
		upcVOs.put(time, upcvo);
	}

	public String getActivateDate() {
		return activateDate;
	}

	public List<BaseJSFVO> getActivationDate() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				if (CPSHelper.isNotEmpty(resultVO.getActivationDate())) {
					BaseJSFVO b = new BaseJSFVO(resultVO.getActivationDate(), resultVO.getActivationDate());
					if (!list.contains(b)) {
						list.add(b);
					}
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public List<BdmVO> getAllBDMs() {
		return allBDMs;
	}

	public List<BaseJSFVO> getAllCommodities() {
		allCommodities = new ArrayList<BaseJSFVO>();
		allCommodities.add(new BaseJSFVO("4", "--Select--"));
		allCommodities.add(new BaseJSFVO("1", "Athletic Goods"));
		allCommodities.add(new BaseJSFVO("2", "Frozen Fruits"));
		allCommodities.add(new BaseJSFVO("3", "Flowers"));

		return allCommodities;
	}

	public List<BaseJSFVO> getAllPendingAction() {
		allPendingAction = new ArrayList<BaseJSFVO>();
		allPendingAction.add(new BaseJSFVO("2", "--Select--"));
		allPendingAction.add(new BaseJSFVO("1", "Pending Details"));
		allPendingAction.add(new BaseJSFVO("4", "Complete"));
		return allPendingAction;
	}

	public List<BaseJSFVO> getAllStatus() {
		allStatus = new ArrayList<BaseJSFVO>();
		allStatus.add(new BaseJSFVO("103", "Vendor Candidate"));
		allStatus.add(new BaseJSFVO("104", "Deleted"));
		allStatus.add(new BaseJSFVO("105", "Rejected"));
		allStatus.add(new BaseJSFVO("106", "Active"));
		allStatus.add(new BaseJSFVO("107", "Working Candidate"));
		CPSHelper.sortList(allStatus);
		CPSHelper.insertBlankSelect(allStatus);
		return allStatus;
	}

	public String getApplySelected() {
		return applySelected;
	}

	public List<BaseJSFVO> getApplyToSelected() {
		applyToSelected = new ArrayList<BaseJSFVO>();
		applyToSelected.add(new BaseJSFVO("1", "CO - Copy new from Existing Candidate"));
		applyToSelected.add(new BaseJSFVO("2", "CP - Copy new from Existing Product"));
		applyToSelected.add(new BaseJSFVO("3", "RJ - Reject Candidate(s)"));
		applyToSelected.add(new BaseJSFVO("4", "AP - Approve/Accept Candidate(s)"));
		applyToSelected.add(new BaseJSFVO("5", "TS - Test Scan"));
		applyToSelected.add(new BaseJSFVO("6", "TC - Change UPC Type"));
		applyToSelected.add(new BaseJSFVO("7", "UC - Change Unit/Case UPC"));
		applyToSelected.add(new BaseJSFVO("8", "MO - Modify Candidate"));
		return applyToSelected;
	}

	public String getClas() {
		return clas;
	}

	public List<BaseJSFVO> getClasses() {
		return classes;
	}

	public String getCostLink() {
		return costLink;
	}

	public String getDirection() {
		return direction;
	}

	public String getFromDate() {
		return fromDate;
	}

	public String getItemCode() {
		return itemCode;
	}

	public String getListCost() {
		return listCost;
	}

	public List<BaseJSFVO> getListCosts() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getListCost(), resultVO.getListCost());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getMasterPack() {
		return masterPack;
	}

	public List<BaseJSFVO> getMasterPackDSD() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getMasterPack(), resultVO.getMasterPack());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getPrdDesc() {
		return prdDesc;
	}

	public CandidateSearchCriteria getProdcriteria() {
		return prodcriteria;
	}

	public List<BaseJSFVO> getProdDescriptions() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO baseJSFVO = new BaseJSFVO(resultVO.getProductDesc(), resultVO.getProductDesc());
				if (!list.contains(baseJSFVO)) {
					list.add(baseJSFVO);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getProdItemCode() {
		return prodItemCode;
	}

	public List<BaseJSFVO> getProdListCosts() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getListCost(), resultVO.getListCost());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getProdPresDate() {
		return prodPresDate;
	}

	public List<BaseJSFVO> getProdPresDates() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getPressDate(), resultVO.getPressDate());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public List<BaseJSFVO> getProdSources() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getSource(), resultVO.getSource());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getProductCode() {
		return productCode;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public String getProductId() {
		return productId;
	}

	public List<BaseJSFVO> getProductItemCode() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				if (CPSHelper.isNotEmpty(resultVO.getItemCode())) {
					BaseJSFVO b = new BaseJSFVO(resultVO.getItemCode(), resultVO.getItemCode());
					if (!list.contains(b)) {
						list.add(b);
					}
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public List<ProductSearchResultVO> getProducts() {
		return products;
	}

	public List<ProductSearchResultVO> getProductsTemp() {
		return productsTemp;
	}

	public String getProductType() {
		return productType;
	}

	public String getRetailLink() {
		return retailLink;
	}

	public String getSelectedBDMId() {
		return selectedBDMId;
	}

	public String getSelectedCommodityId() {
		return selectedCommodityId;
	}

	public String getSelectedPendingAction() {
		return selectedPendingAction;
	}

	public String getSelectedSource() {
		return selectedSource;
	}

	public String getSelectedStatus() {
		return selectedStatus;
	}

	public String getSelectedTestScan() {
		return selectedTestScan;
	}

	public String getShipPack() {
		return shipPack;
	}

	public List<BaseJSFVO> getShipPacksWHSE() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getShipPack(), resultVO.getShipPack());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public int getSortCaseValue() {
		return sortCaseValue;
	}

	public String getSource() {
		return source;
	}

	public List<BaseJSFVO> getSources() {
		sources = new ArrayList<BaseJSFVO>();
		sources.add(new BaseJSFVO("1", "Incomplete"));
		sources.add(new BaseJSFVO("2", "Complete"));
		sources.add(new BaseJSFVO("3", "Overriden"));
		CPSHelper.sortList(sources);
		CPSHelper.insertBlankSelect(sources);
		return sources;
	}

	public String getStatus() {
		return status;
	}

	@Override
	public String getStrutsFormName() {
		return FORM_NAME;
	}

	public String getTemp1() {
		return temp1;
	}

	public List<BaseJSFVO> getTestScans() {
		testScans = new ArrayList<BaseJSFVO>();
		testScans.add(new BaseJSFVO("1", "Incomplete"));
		testScans.add(new BaseJSFVO("2", "Not Required"));
		testScans.add(new BaseJSFVO("3", "Complete"));
		testScans.add(new BaseJSFVO("4", "Overridden"));
		CPSHelper.sortList(testScans);
		return testScans;
	}

	public String getTestScanStatus() {
		return testScanStatus;
	}

	public String getToDate() {
		return toDate;
	}

	// prod list attrbutes for search...
	public List<BaseJSFVO> getUnitUPCs() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				if (CPSHelper.isNotEmpty(resultVO.getUnitUPC())) {
					BaseJSFVO b = new BaseJSFVO(resultVO.getUnitUPC(), resultVO.getUnitUPC());
					if (!list.contains(b)) {
						list.add(b);
					}
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getUpc1() {
		return upc1;
	}

	public String getVendorDesc() {
		return vendorDesc;
	}

	public List<BaseJSFVO> getVendorDescs() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				if (CPSHelper.isNotEmpty(resultVO.getVendorDesc())) {
					BaseJSFVO b = new BaseJSFVO(resultVO.getVendorDesc(), resultVO.getVendorDesc());
					if (!list.contains(b)) {
						list.add(b);
					}
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getVendorId() {
		return vendorId;
	}

	public List<BaseJSFVO> getVendorIds() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			for (ProductSearchResultVO resultVO : products) {
				BaseJSFVO b = new BaseJSFVO(resultVO.getVendorId(), resultVO.getVendorId());
				if (!list.contains(b)) {
					list.add(b);
				}
			}
		} catch (Exception e) {
		}
		return list;
	}

	public String getVndrDesc() {
		return vndrDesc;
	}

	public String getVndrId() {
		return vndrId;
	}

	public String getVndrUnitUpc() {
		return vndrUnitUpc;
	}

	public boolean isAdvSearch() {
		return advSearch;
	}

	public boolean isHidManageMrtSwitch() {
		return hidManageMrtSwitch;
	}

	public boolean isOwnBrand() {
		return ownBrand;
	}

	public boolean isRx() {
		return rx;
	}

	public boolean isScale() {
		return scale;
	}

	public boolean isTobacco() {
		return tobacco;
	}

	public boolean isValidForCandSearch() {
		return validForCandSearch;
	}

	/**
	 * @return the validForResults
	 */
	public boolean isValidForResults() {
		return validForResults;
	}

	public void setActivateDate(String activateDate) {
		this.activateDate = activateDate;
	}

	public void setActivationDate(List<BaseJSFVO> activationDate) {
		this.activationDate = activationDate;
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

	public void setClas(String clas) {
		this.clas = clas;
	}

	public void setClasses(List<BaseJSFVO> classes) {
		this.classes = classes;
	}

	public void setCostLink(String costLink) {
		this.costLink = costLink;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
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

	public void setMasterPack(String masterPack) {
		this.masterPack = masterPack;
	}

	public void setMasterPackDSD(List<BaseJSFVO> shipPacksDSD) {
		this.masterPackDSD = shipPacksDSD;
	}

	public void setOwnBrand(boolean ownBrand) {
		this.ownBrand = ownBrand;
	}

	public void setPrdDesc(String prdDesc) {
		this.prdDesc = prdDesc;
	}

	public void setProdcriteria(CandidateSearchCriteria prodcriteria) {
		this.prodcriteria = prodcriteria;
	}

	public void setProdDescriptions(List<BaseJSFVO> prodDescriptions) {
		this.prodDescriptions = prodDescriptions;
	}

	public void setProdItemCode(String prodItemCode) {
		this.prodItemCode = prodItemCode;
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

	public void setProductItemCode(List<BaseJSFVO> productItemCode) {
		this.productItemCode = productItemCode;
	}

	public void setProducts(List<ProductSearchResultVO> products) {
		this.products = products;
	}

	public void setProductsTemp(List<ProductSearchResultVO> productsTemp) {
		this.productsTemp = productsTemp;
	}

	public void setProductType(String productType) {
		this.productType = productType;
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

	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}

	public void setTestScans(List<BaseJSFVO> testScans) {
		this.testScans = testScans;
	}

	public void setTestScanStatus(String testScanStatus) {
		this.testScanStatus = testScanStatus;
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

	/**
	 * @return the commodities
	 */
	public List<BaseJSFVO> getCommodities() {
		return commodities;
	}

	/**
	 * @param commodities
	 *            the commodities to set
	 */
	public void setCommodities(List<BaseJSFVO> commodities) {
		CPSHelper.sortList(commodities);
		this.commodities = commodities;
	}

	/**
	 * @return the subCommodities
	 */
	public List<BaseJSFVO> getSubCommodities() {
		return subCommodities;
	}

	/**
	 * @param subCommodities
	 *            the subCommodities to set
	 */
	public void setSubCommodities(List<BaseJSFVO> subCommodities) {
		CPSHelper.sortList(subCommodities);
		this.subCommodities = subCommodities;
	}
}
