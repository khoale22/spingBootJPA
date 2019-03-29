package com.heb.operations.cps.model;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.vo.*;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("serial")
public class ManageEDICandidate extends HebBaseInfo {
	public static final String FORM_NAME = "ManageEDICandidate";
	/** The Constant LOG. */
	private static final Logger LOG = Logger.getLogger(ManageEDICandidate.class);
	private List<EDISearchResultVO> ediSearchResultVOLst = new ArrayList<EDISearchResultVO>();
	private List<EDISearchResultVO> ediSearchResultVOLstTemp = new ArrayList<EDISearchResultVO>();
	private CandidateEDISearchCriteria candidateEDISearchCriteria;
	private List<BaseJSFVO> classes = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> allStatus = null;
	private List<BaseJSFVO> commodities = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> subCommodities = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> allDataSource = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> allAction = new ArrayList<BaseJSFVO>();
	private List<BaseJSFVO> testScans = null;
	private boolean validForResults;
	private boolean haveResults;
	private String productSelectedIds;
	private String currentTab;
	private List<CommentUPCVO> commentUPCVOs = new ArrayList<CommentUPCVO>();
	private List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();
	private List<TestScanVO> testScanVOs = new ArrayList<TestScanVO>();
	private List<MrtVO> MRTList = new ArrayList<MrtVO>();
	private boolean rejectClose = false;
	private String rejectComments;
	private List<PrintFormVO> printFormVOMRTList = new ArrayList<PrintFormVO>();
	private List<EDISearchResultVO> productsTemp = new ArrayList<EDISearchResultVO>();
	private String rejectMessageComments;
	private List<BaseJSFVO> prodDescriptions = null;
	private List<EDISearchResultVO> products = new ArrayList<EDISearchResultVO>();
	private String psWrkActiveFailSelectedId = "";
	private String productDescription = null;
	private boolean testScanUserSwitch = false;
	private Map<String, UPCVO> upcVOs = new HashMap<String, UPCVO>();
	private int productsSize;
	private boolean isVendor = false;
	private List<EDISearchResultVO> listItemToUpdate;
	private String selectedItems;
	private UpcStoreAuthorizationVO upcStoreAuthorization;
	private String psWorkSelectedIds;

	private String filterValues;
	private String itemsResultFilter;

	// current record at GUI

	private int currentRecord = 10;
	private int currentPage = 1;

	private String massUploadProfilesId;
	List<MassUploadVO> lstMassUPloadUpdates = new ArrayList<MassUploadVO>();

	/**
	 * @return the lstMassUPloadUpdates
	 */
	public List<MassUploadVO> getLstMassUPloadUpdates() {
		return lstMassUPloadUpdates;
	}

	/**
	 * @param lstMassUPloadUpdates
	 *            the lstMassUPloadUpdates to set
	 */
	public void setLstMassUPloadUpdates(List<MassUploadVO> lstMassUPloadUpdates) {
		this.lstMassUPloadUpdates = lstMassUPloadUpdates;
	}

	public ManageEDICandidate() {
		super();
		setCurrentAppName("Manage Candidate");
		candidateEDISearchCriteria = new CandidateEDISearchCriteria();
		List<EDISearchResultVO> products = new ArrayList<>();
		setProducts(products);
		setProductsTemp(products);
	}

	public boolean isHaveResults() {
		return haveResults;
	}

	public void setHaveResults(boolean haveResults) {
		this.haveResults = haveResults;
	}

	/**
	 * @return the ediSearchResultVOLst
	 */
	public List<EDISearchResultVO> getEdiSearchResultVOLst() {
		return ediSearchResultVOLst;
	}

	/**
	 * @param ediSearchResultVOLst
	 *            the ediSearchResultVOLst to set
	 */
	public void setEdiSearchResultVOLst(List<EDISearchResultVO> ediSearchResultVOLst) {
		this.ediSearchResultVOLst = ediSearchResultVOLst;
	}

	public List<EDISearchResultVO> getEdiSearchResultVOLstTemp() {
		return ediSearchResultVOLstTemp;
	}

	public void setEdiSearchResultVOLstTemp(List<EDISearchResultVO> ediSearchResultVOLstTemp) {
		this.ediSearchResultVOLstTemp = ediSearchResultVOLstTemp;
	}

	/**
	 * @return the candidateEDISearchCriteria
	 */
	public CandidateEDISearchCriteria getCandidateEDISearchCriteria() {
		return candidateEDISearchCriteria;
	}

	/**
	 * @param candidateEDISearchCriteria
	 *            the candidateEDISearchCriteria to set
	 */
	public void setCandidateEDISearchCriteria(CandidateEDISearchCriteria candidateEDISearchCriteria) {
		this.candidateEDISearchCriteria = candidateEDISearchCriteria;
	}

	@Override
	public String getStrutsFormName() {
		return FORM_NAME;
	}

	/**
	 * @return the validForResults
	 */
	public boolean isValidForResults() {
		return validForResults;
	}

	/**
	 * @param validForResults
	 *            the validForResults to set
	 */
	public void setValidForResults(boolean validForResults) {
		this.validForResults = validForResults;
	}

	public List<BaseJSFVO> getClasses() {
		return classes;
	}

	public void setClasses(List<BaseJSFVO> classes) {
		this.classes = classes;
	}

	public List<BaseJSFVO> getAllStatus() {
		return allStatus;
	}

	public void setAllStatus(List<BaseJSFVO> allStatus) {
		this.allStatus = allStatus;
	}

	public List<BaseJSFVO> getSubCommodities() {
		return subCommodities;
	}

	public void setSubCommodities(List<BaseJSFVO> subCommodities) {
		CPSHelper.sortList(subCommodities);
		this.subCommodities = subCommodities;
	}

	public List<BaseJSFVO> getCommodities() {
		return commodities;
	}

	public void setCommodities(List<BaseJSFVO> commodities) {
		CPSHelper.sortList(commodities);
		this.commodities = commodities;
	}

	public List<BaseJSFVO> getAllDataSource() {
		return allDataSource;
	}

	public void setAllDataSource(List<BaseJSFVO> allDataSource) {
		this.allDataSource = allDataSource;
	}

	public List<BaseJSFVO> getAllAction() {
		return allAction;
	}

	public void setAllAction(List<BaseJSFVO> allAction) {
		this.allAction = allAction;
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

	public void setTestScans(List<BaseJSFVO> testScans) {
		this.testScans = testScans;
	}

	/**
	 * @return the currentTab
	 */
	public String getCurrentTab() {
		return currentTab;
	}

	/**
	 * @param currentTab
	 *            the currentTab to set
	 */
	public void setCurrentTab(String currentTab) {
		this.currentTab = currentTab;
	}

	public String getProductSelectedIds() {
		return productSelectedIds;
	}

	public void setProductSelectedIds(String productSelectedIds) {
		this.productSelectedIds = productSelectedIds;
	}

	public List<CommentUPCVO> getCommentUPCVOs() {
		return commentUPCVOs;
	}

	public void setCommentUPCVOs(List<CommentUPCVO> commentUPCVOs) {
		this.commentUPCVOs = commentUPCVOs;
	}

	public List<PrintFormVO> getPrintFormVOList() {
		return printFormVOList;
	}

	public void setPrintFormVOList(List<PrintFormVO> printFormVOList) {
		this.printFormVOList = printFormVOList;
	}

	public List<MrtVO> getMRTList() {
		return MRTList;
	}

	public void setMRTList(List<MrtVO> list) {
		MRTList = list;
	}

	public boolean isRejectClose() {
		return rejectClose;
	}

	public void setRejectClose(boolean rejectClose) {
		this.rejectClose = rejectClose;
	}

	public String getRejectComments() {
		return rejectComments;
	}

	public void setRejectComments(String rejectComments) {
		this.rejectComments = rejectComments;
	}

	public List<PrintFormVO> getPrintFormVOMRTList() {
		return printFormVOMRTList;
	}

	public void setPrintFormVOMRTList(List<PrintFormVO> printFormVOMRTList) {
		this.printFormVOMRTList = printFormVOMRTList;
	}

	public List<EDISearchResultVO> getProductsTemp() {
		return productsTemp;
	}

	public void setProductsTemp(List<EDISearchResultVO> productsTemp) {
		this.productsTemp = productsTemp;
	}

	public String getRejectMessageComments() {
		return rejectMessageComments;
	}

	public void setRejectMessageComments(String rejectMessageComments) {
		this.rejectMessageComments = rejectMessageComments;
	}

	public List<BaseJSFVO> getProdDescriptions() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		for (EDISearchResultVO resultVO : products) {
			BaseJSFVO baseJSFVO = new BaseJSFVO(resultVO.getDescriptionAndSizeDetailVO().getDescription(), resultVO.getDescriptionAndSizeDetailVO().getDescription());
			if (!list.contains(baseJSFVO)) {
				list.add(baseJSFVO);
			}
		}
		return list;
	}

	public void setProdDescriptions(List<BaseJSFVO> prodDescriptions) {
		this.prodDescriptions = prodDescriptions;
	}

	public List<EDISearchResultVO> getProducts() {
		return products;
	}

	public void setProducts(List<EDISearchResultVO> products) {
		this.products = products;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	/**
	 * @param testScanVOs
	 *            the testScanVOs to set
	 */
	public void setTestScanVOs(List<TestScanVO> testScanVOs) {
		this.testScanVOs = testScanVOs;
	}

	/**
	 * @return the testScanVOs
	 */
	public List<TestScanVO> getTestScanVOs() {
		return testScanVOs;
	}

	/**
	 * @param testScanUserSwitch
	 *            the testScanUserSwitch to set
	 */
	public void setTestScanUserSwitch(boolean testScanUserSwitch) {
		this.testScanUserSwitch = testScanUserSwitch;
	}

	/**
	 * @return the testScanUserSwitch
	 */
	public boolean isTestScanUserSwitch() {
		return testScanUserSwitch;
	}

	/**
	 * Adds one UPC VO
	 *
	 * @param upcvo
	 */
	public void addUpcVOs(UPCVO upcvo) {
		String time = String.valueOf(System.currentTimeMillis()) + upcvo.hashCode();
		upcvo.setUniqueId(time);
		upcVOs.put(time, upcvo);
	}

	/**
	 * @param productsSize
	 *            the productsSize to set
	 */
	public void setProductsSize(int productsSize) {
		this.productsSize = productsSize;
	}

	/**
	 * @return the productsSize
	 */
	public int getProductsSize() {
		return productsSize;
	}

	public UPCVO getUpcVOs(String uniqueId) {
		return upcVOs.get(uniqueId);
	}

	public void clearUPCVOs() {
		this.upcVOs.clear();
	}

	public List<UPCVO> getUpcVOs() {
		List<UPCVO> list = new ArrayList<UPCVO>();
		list.addAll(upcVOs.values());
		return list;
	}

	/**
	 * removes the upcVO
	 *
	 * @param key
	 */
	public UPCVO removeUPCVO(String key) {
		return upcVOs.remove(key);
	}

	/**
	 * @return the isVendor
	 */
	public boolean getIsVendor() {
		String userRole = getUserRole();
		return (CPSConstants.UNREGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole) || CPSConstants.REGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole));
	}

	public List<EDISearchResultVO> getListItemToUpdate() {
		return listItemToUpdate;
	}

	public void setListItemToUpdate(List<EDISearchResultVO> listItemToUpdate) {
		this.listItemToUpdate = listItemToUpdate;
	}

	/**
	 * @return the selectedItems
	 */
	public String getSelectedItems() {
		return selectedItems;
	}

	/**
	 * @param selectedItems
	 *            the selectedItems to set
	 */
	public void setSelectedItems(String selectedItems) {
		this.selectedItems = selectedItems;
	}

	/**
	 * @return the upcStoreAuthorization
	 */
	public UpcStoreAuthorizationVO getUpcStoreAuthorization() {
		return upcStoreAuthorization;
	}

	/**
	 * @param upcStoreAuthorization
	 *            the upcStoreAuthorization to set
	 */
	public void setUpcStoreAuthorization(UpcStoreAuthorizationVO upcStoreAuthorization) {
		this.upcStoreAuthorization = upcStoreAuthorization;
	}

	/**
	 * @return the currentRecord
	 */
	public int getCurrentRecord() {
		return currentRecord;
	}

	/**
	 * @param currentRecord
	 *            the currentRecord to set
	 */
	public void setCurrentRecord(int currentRecord) {
		this.currentRecord = currentRecord;
	}

	/**
	 * @return the currentPage
	 */
	public int getCurrentPage() {
		return currentPage;
	}

	/**
	 * @param currentPage
	 *            the currentPage to set
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	/**
	 * @return the psWorkSelectedIds
	 */
	public String getPsWorkSelectedIds() {
		return psWorkSelectedIds;
	}

	/**
	 * @param psWorkSelectedIds
	 *            the psWorkSelectedIds to set
	 */
	public void setPsWorkSelectedIds(String psWorkSelectedIds) {
		this.psWorkSelectedIds = psWorkSelectedIds;
	}

	/**
	 * @return the filterValues
	 */
	public String getFilterValues() {
		return filterValues;
	}

	/**
	 * @param filterValues
	 *            the filterValues to set
	 */
	public void setFilterValues(String filterValues) {
		this.filterValues = filterValues;
	}

	/**
	 * @return the itemsResultFilter
	 */
	public String getItemsResultFilter() {
		return itemsResultFilter;
	}

	/**
	 * @param itemsResultFilter
	 *            the itemsResultFilter to set
	 */
	public void setItemsResultFilter(String itemsResultFilter) {
		this.itemsResultFilter = itemsResultFilter;
	}

	public String getPsWrkActiveFailSelectedId() {
		return psWrkActiveFailSelectedId;
	}

	public void setPsWrkActiveFailSelectedId(String psWrkActiveFailSelectedId) {
		this.psWrkActiveFailSelectedId = psWrkActiveFailSelectedId;
	}

	/**
	 * @param massUploadProfilesId
	 *            the massUploadProfilesId to set
	 */
	public void setMassUploadProfilesId(String massUploadProfilesId) {
		this.massUploadProfilesId = massUploadProfilesId;
	}

	/**
	 * @return the massUploadProfilesId
	 */
	public String getMassUploadProfilesId() {
		return massUploadProfilesId;
	}

}
