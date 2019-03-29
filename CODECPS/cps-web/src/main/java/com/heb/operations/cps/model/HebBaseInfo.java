package com.heb.operations.cps.model;

import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.ClassCommodityVO;
import com.heb.operations.business.framework.vo.CommoditySubCommVO;
import com.heb.operations.cps.util.BusinessConstants;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.CPSSessionVO;
import com.heb.operations.cps.vo.QuestionnarieVO;
import com.heb.operations.cps.vo.WorkRequest;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import javax.security.jacc.PolicyContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * A Struts Form with a few utilities common to all Forms in the CPS application
 * The framework assumes that all CPS forms extend from this one, so unless you
 * have a specific reason not to, please have all new forms extend this one.
 * 
 * @author robhardt
 * 
 */
public abstract class HebBaseInfo implements CPSConstants {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static Logger LOG = Logger.getLogger(HebBaseInfo.class);

	private static final String CPS_SESSION_INFO = "CPS_SESSIOON_INFO";

	private static final List<BaseJSFVO> emptyList = new ArrayList<BaseJSFVO>();

	private WorkRequest userInfo = new WorkRequest();

	private boolean viewMode = false;
	private boolean viewModeImageAttr = false;
	private boolean modifyMode = false;

	private String error;

	private List<BaseJSFVO> bdms;
	private Map<String, ClassCommodityVO> classCommodityMap = new HashMap<String, ClassCommodityVO>();
	private Map<String, CommoditySubCommVO> commoditySubCommMap = new HashMap<String, CommoditySubCommVO>();
	private Map<String, BaseJSFVO> brickMap = new HashMap<String, BaseJSFVO>();

	private boolean login;

	public void setSession(HttpSession session) {
		this.session = session;
	}

	/*
         * Session and request variables which is set from the reset method, so that
         * methods in the form can use the session and request without much effort.
         */
	private HttpSession session;
	private HttpServletRequest currentReq;
	/*
	 * A dummy property as a string to represent a lot of struts tags like
	 * html:select which we use to render the list to form the select box, but
	 * we never use the selected value from the form, probably because we are
	 * using DWR to update the selected value.
	 */
	private String dummyProperty;

	private Map<String, String> pssDeptMap = new HashMap<String, String>();

	/*
	 * Session VO holding all parameters that are in session
	 */
	private CPSSessionVO sessionVO;
	/*
	 * Current App name actually gives the name of the current flow, that is
	 * undergoing...
	 */
	private String currentAppName;
	private String selectedProductId;
	private String selectedProductIdItmTypCd;
	private String selectedMrtLabel;
	private String candidateTypeList;
	private String selectedProdWorkRqstId;
	private String selectedWorkStatus;
	private String selectedProductCandidateId;

	public String getSelectedProdWorkRqstId() {
		return selectedProdWorkRqstId;
	}

	public void setSelectedProdWorkRqstId(String selectedProdWorkRqstId) {
		this.selectedProdWorkRqstId = selectedProdWorkRqstId;
	}

	public String getCandidateTypeList() {
		return candidateTypeList;
	}

	public void setCandidateTypeList(String candidateTypeList) {
		this.candidateTypeList = candidateTypeList;
	}

	public String getSelectedMrtLabel() {
		return selectedMrtLabel;
	}

	public void setSelectedMrtLabel(String selectedMrtLabel) {
		this.selectedMrtLabel = selectedMrtLabel;
	}

	private String userRole;

	private List<BaseJSFVO> productTypes = new ArrayList<BaseJSFVO>();

	private List<BaseJSFVO> yesNoList = null;
	private List<BaseJSFVO> yesNo = null;

	private List<BaseJSFVO> criItemList = null;

	private List<BaseJSFVO> containerList = null;
	private List<BaseJSFVO> incoList = null;

	private List<BaseJSFVO> labelFormats = null; // R2

	public void setCopyProductMode() {
		setSelectedFunction(COPY_PRODUCT);
	}

	public void setManageCandidateMode() {
		setSelectedFunction(MAANAGE_CANDIDATE);
	}

	public void setAddCandidateMode() {
		setSelectedFunction(ADD_NEWCANDIDATE);
	}

	public void setAddMRTMode() {
		setSelectedFunction(ADD_MRT);
	}

	public void setCopyCandidateMode() {
		setSelectedFunction(COPY_CANDIDATE);
	}

	public void setManageOwnBrandMode() {
		setSelectedFunction(MANAGE_OWN_BRAND);
	}

	public void setCPSRolesMode() {
		setSelectedFunction(CPS_ROLES);
	}

	public void setBatchUploadMode() {
		setSelectedFunction(CPS_BATCH_UPLOAD);
	}

	protected HttpSession getSession() {
		return session;
	}

	public CPSSessionVO getSessionVO() {
		if(session != null) {
			sessionVO = (CPSSessionVO) session.getAttribute(CPS_SESSION_INFO);
			if (null == sessionVO) {
				sessionVO = new CPSSessionVO();
				session.setAttribute(CPS_SESSION_INFO, sessionVO);
			}
		}
		return sessionVO;
	}

	/**
	 * Utility method to get an EJB from JNDI Please note, your EJB should be
	 * declared in the
	 *
	 * @param name
	 * @return
	 * @throws Exception
	 */
	protected Object getEJB(String name) throws Exception {
		// return BeanLocator.getEJB(name);
		return null;
	}

	// /**
	// * get the 'CommonBean' EJB from JNDI
	// * @return
	// * @throws Exception
	// */
	// protected CommonLocal getCommonBean() throws Exception {
	// return (CommonLocal) getEJB(COMMON_BEAN);
	// }
	//
	// /**
	// * get the 'AddNewCandidate' EJB from JNDI
	// * @return
	// * @throws Exception
	// */
	// protected AddNewCandidateLocal getAddNewCandidateBean() throws Exception
	// {
	// return (AddNewCandidateLocal) getEJB(ADD_NEW_CANDIDATE_BEAN);
	// }

	/**
	 * puts the 'currentAppName' prop directly in the request so the JSPs can
	 * access it without having to find the current action form. Puts a new
	 * session VO in session if one is not there.
	 */
//	@Override
//	public void reset(ActionMapping mapping, HttpServletRequest req) {
//		super.reset(mapping, req);
//		session = req.getSession();
//		sessionVO = (CPSSessionVO) session.getAttribute(CPS_SESSION_INFO);
//		if (null == sessionVO) {
//			sessionVO = new CPSSessionVO();
//			session.setAttribute(CPS_SESSION_INFO, sessionVO);
//		}
//		req.setAttribute("currentAppName", currentAppName);
//		currentReq = req;
//	}

	/**
	 * the name of the current app (Add New Candidate, Manage Candidates, etc)
	 * 
	 * @return
	 */
	public String getCurrentAppName() {
		return currentAppName;
	}

	public void setCurrentAppName(String currentAppName) {
		this.currentAppName = currentAppName;

	}

	private List<BaseJSFVO> getBdmsPrivate() {
		return bdms;
	}

	private void setBdmsprivate(List<BaseJSFVO> bdms) {
		this.bdms = bdms;
	}

	private List<BaseJSFVO> getCommoditiesprivate() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		list.addAll(classCommodityMap.values());
		return list;
	}

	private List<BaseJSFVO> getSubCommoditiesprivate() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		list.addAll(commoditySubCommMap.values());
		return list;
	}

	private void setSubCommoditiesprivate(List<BaseJSFVO> subCommodities) {
	}

	private List<BaseJSFVO> getBrickprivate() {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		list.addAll(this.brickMap.values());
		return list;
	}

	private Map<String, ClassCommodityVO> getClassCommodityMapprivate() {
		return classCommodityMap;
	}

	private void setClassCommodityMapprivate(
			Map<String, ClassCommodityVO> classCommodityMap) {
		this.classCommodityMap = classCommodityMap;
	}

	public Map<String, CommoditySubCommVO> getCommoditySubCommMap() {
		return commoditySubCommMap;
	}

	public void setCommoditySubCommMap(
			Map<String, CommoditySubCommVO> commoditySubCommMap) {
		this.commoditySubCommMap = commoditySubCommMap;
	}

	public Map<String, BaseJSFVO> getBrickMap() {
		return this.brickMap;
	}

	public void setBrickMap(Map<String, BaseJSFVO> brickMap) {
		this.brickMap = brickMap;
	}

	/**
	 * when the screen has a select box, but there is no data to provide
	 * selections, we want a single selection with id -1, and value '--------'
	 * so the select box will properly render. Any bean-style property of type
	 * java.util.List will work with this method
	 * 
	 * @param name
	 */
	protected void initSelect(String name) {
		List sel = CPSHelper.insertBlankSelect(new ArrayList());
		try {
			BeanUtils.setProperty(this, name, sel);
		} catch (Exception ex) {
			LOG.error("Exception:-", ex);
		}
	}

	/**
	 * @return the yesNoList
	 */
	public List<BaseJSFVO> getYesNoList() {
		if (null == yesNoList) {
			yesNoList = new ArrayList<BaseJSFVO>();
			yesNoList.add(new BaseJSFVO("", "--Select--"));
			yesNoList.add(new BaseJSFVO("Y", "Yes"));
			yesNoList.add(new BaseJSFVO("N", "No"));
		}
		return yesNoList;
	}

	/**
	 * @param yesNoList
	 *            the yesNoList to set
	 */
	public void setYesNoList(List<BaseJSFVO> yesNoList) {
		this.yesNoList = yesNoList;
	}

	public List<BaseJSFVO> getYesNo() {
		if (null == yesNo) {
			yesNo = new ArrayList<BaseJSFVO>();
			yesNo.add(new BaseJSFVO("1", "Yes"));
			yesNo.add(new BaseJSFVO("0", "No"));
		}
		return yesNo;
	}

	public void setYesNo(List<BaseJSFVO> yesNo) {
		this.yesNo = yesNo;
	}

	/**
	 * @return the criItemList
	 */
	public List<BaseJSFVO> getCriItemList() {
		if (null == criItemList) {
			criItemList = new ArrayList<BaseJSFVO>();
			criItemList.add(new BaseJSFVO("", "--Select--"));
			criItemList.add(new BaseJSFVO("N", "Normal"));
			criItemList.add(new BaseJSFVO("S", "Sensitive"));
			criItemList.add(new BaseJSFVO("P", "Profit"));
			criItemList.add(new BaseJSFVO("B", "Business Use Only"));
		}
		return criItemList;
	}

	/**
	 * @param criItemList
	 *            the criItemList to set
	 */
	public void setCriItemList(List<BaseJSFVO> criItemList) {
		this.criItemList = criItemList;
	}

	/**
	 * @return the containerList
	 */
	public List<BaseJSFVO> getContainerList() {
		if (null == containerList) {
			containerList = new ArrayList<BaseJSFVO>();
			containerList.add(new BaseJSFVO("", "--Select--"));
			containerList.add(new BaseJSFVO("CFS", "CFS"));
			containerList.add(new BaseJSFVO("FCL20", "FCL20"));
			containerList.add(new BaseJSFVO("FCL40", "FCL40"));
			containerList.add(new BaseJSFVO("FCL40HQ", "FCL40HQ"));
			containerList.add(new BaseJSFVO("FCL45", "FCL45"));
		}
		return containerList;
	}

	/**
	 * @param containerList
	 *            the to set containerList
	 */
	public void setContainerList(List<BaseJSFVO> containerList) {
		this.containerList = containerList;
	}

	/**
	 * @return the incoList
	 */
	public List<BaseJSFVO> getIncoList() {
		if (null == incoList) {
			incoList = new ArrayList<BaseJSFVO>();
			incoList.add(new BaseJSFVO("", "--Select--"));
			incoList.add(new BaseJSFVO("FOB", "FOB"));
			// incoList.add(new BaseJSFVO("DDP","DDP"));

		}
		return incoList;
	}

	/**
	 * @param incoList
	 *            the incoList to set
	 */
	public void setIncoList(List<BaseJSFVO> incoList) {
		this.incoList = incoList;
	}

	public boolean isLoggedIn() {
		boolean ret = false;
		try {
			HttpServletRequest req = (HttpServletRequest) PolicyContext
					.getContext("javax.servlet.http.HttpServletRequest");
			ret = ((req != null) && (req.getUserPrincipal() != null));
		} catch (Exception ex) {
			LOG.error("Exception:-", ex);
		}
		return ret;
	}

	public int getSelectedFunction() {
		return getSessionVO().getSelectedFunction();
	}

	public void setSelectedFunction(int selectedFunction) {
		getSessionVO().setSelectedFunction(selectedFunction);
	}

	/**
	 * @return the bdms
	 */
	public List<BaseJSFVO> getBdms() {
		List<BaseJSFVO> list = getBdmsPrivate();
		if (list == null) {
			list = emptyList;
		}
		return list;
	}

	/**
	 * @param bdms
	 *            the bdms to set
	 */
	public void setBdms(List<BaseJSFVO> bdms) {
		CPSHelper.sortList(bdms);
		this.setBdmsprivate(bdms);
	}

	/**
	 * @return the commodities
	 */
	public List<BaseJSFVO> getCommodities() {
		return this.getCommoditiesprivate();
	}

	/**
	 * @return the subCommodities
	 */
	public List<BaseJSFVO> getSubCommodities() {
		return this.getSubCommoditiesprivate();
	}

	/**
	 * @return the brick
	 */
	public List<BaseJSFVO> getBricks() {
		return this.getBrickprivate();
	}

	/**
	 * @param bricks
	 *            List<BaseJSFVO>
	 */
	public void setBricks(List<BaseJSFVO> bricks) {
		CPSHelper.sortList(bricks);

	}

	/**
	 * @param subCommodities
	 *            the subCommodities to set
	 */
	public void setSubCommodities(List<BaseJSFVO> subCommodities) {
		CPSHelper.sortList(subCommodities);
		this.setSubCommoditiesprivate(subCommodities);
	}

	public void setMerchandizingTypes(List<BaseJSFVO> merchanTypes) {
		CPSHelper.sortList(merchanTypes);
		this.getSessionVO().setMerchandizingTypes(merchanTypes);
	}

	public List<BaseJSFVO> getMerchandizingTypes() {
		List<BaseJSFVO> list = this.getSessionVO().getMerchandizingTypes();
		if (list == null) {
			list = emptyList;
		}
		return list;
	}

	public HttpServletRequest getCurrentRequest() {
		return currentReq;
	}

	public void setCurrentRequest(HttpServletRequest request){
		this.currentReq = request;
	}

	private List<CPSMessage> list = new ArrayList<CPSMessage>();

	private static final String MESSAGE_KEY = "CPSMESSAGES";

	public List<CPSMessage> getMessages() {
		return list;
	}

	public synchronized void setMessages(List<CPSMessage> messages) {
		list = messages;
	}

	public String getDummyProperty() {
		return dummyProperty;
	}

	public void setDummyProperty(String dummyProperty) {
		this.dummyProperty = dummyProperty;
	}

	public List<BaseJSFVO> getProductTypes() {
		return productTypes;
	}

	public void setProductTypes(List<BaseJSFVO> productTypes) {
		CPSHelper.reverseSortList(productTypes);
		this.productTypes = CPSHelper.insertBlankSelect(productTypes);
	}

	public String getSelectedProductId() {
		return selectedProductId;
	}

	public void setSelectedProductId(String selectedProductId) {
		this.selectedProductId = selectedProductId;
	}

	public Map<String, String> getPssDeptMap() {
		return pssDeptMap;
	}

	public void setPssDeptMap(Map<String, String> pssDeptMap) {
		this.pssDeptMap = pssDeptMap;
	}

	public boolean isErrorFlag() {
		if (getMessages().isEmpty()) {
			return false;
		}
		return true;
	}

	public abstract String getStrutsFormName();

	public boolean isLogin() {
		return login;
	}

	public void setLogin(boolean login) {
		this.login = login;
	}

	public WorkRequest getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(WorkRequest userInfo) {
		this.userInfo = userInfo;
	}

	public Map<String, ClassCommodityVO> getClassCommodityMap() {
		return getClassCommodityMapprivate();
	}

	public BaseJSFVO getClassForCommodity(String commodity) {
		ClassCommodityVO commodityVO = getClassCommodityMap().get(commodity);
		if (null != commodityVO) {
			return new BaseJSFVO(commodityVO.getClassCode(),
					commodityVO.getClassDesc());
		}
		return new BaseJSFVO("", "");
	}

	public ClassCommodityVO getClassCommodityVO(String commodityId) {
		return getClassCommodityMap().get(commodityId);
	}

	public void setClassCommodityMap(
			Map<String, ClassCommodityVO> classCommodityMap) {
		setClassCommodityMapprivate(classCommodityMap);
	}

	public Map<String, CommoditySubCommVO> getcommoditySubMap() {
		return getCommoditySubCommMap();
	}

	public void setcommoditySubMap(
			Map<String, CommoditySubCommVO> commoditySubCommMap) {
		setCommoditySubCommMap(commoditySubCommMap);
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public Set<String> getRoles() {
		return (Set<String>) getSession().getAttribute("com.heb.UserRoles");
	}

	public QuestionnarieVO getQuestionnarieVO() {
		QuestionnarieVO questionnarieVO = getSessionVO().getQuestionnarieVO();
		List<BaseJSFVO> caseList = new ArrayList<BaseJSFVO>();
		if (null == questionnarieVO) {
			questionnarieVO = new QuestionnarieVO();
			getSessionVO().setQuestionnarieVO(questionnarieVO);
		}
		//Sprint-23
		for (BaseJSFVO base : questionnarieVO.getOptionsList()) {
			if (base.getId().equals("12")
					&& (BusinessConstants.REGISTERED_VENDOR_ROLE.equalsIgnoreCase(
							getUserRole()) || BusinessConstants.UNREGISTERED_VENDOR_ROLE
							.equalsIgnoreCase(getUserRole()))) {
				continue;
			} else {
				caseList.add(base);
			}
		}
		questionnarieVO.getOptionsList().clear();
		questionnarieVO.setOptionsList(caseList);
		return questionnarieVO;
	}

	public void clearQuestionaireVO() {
		try {
			getSessionVO().setQuestionnarieVO(new QuestionnarieVO());
		} catch (Exception e) {
			LOG.error("Error clear session:" + e.getMessage(), e);
		}
	}
	public boolean isViewMode() {
		return viewMode;
	}

	public void setViewMode(boolean viewMode) {
		this.viewMode = viewMode;
	}

	public void setModifyMode(boolean modifyMode) {
		this.modifyMode = modifyMode;
	}

	public boolean isModifyMode() {
		return modifyMode;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	// R2 [
	public List<BaseJSFVO> getLabelFormats() {
		return labelFormats;
	}

	public void setLabelFormats(List<BaseJSFVO> labelFormats) {
		labelFormats.add(new BaseJSFVO("", "--Select--"));
		CPSHelper.sortList(labelFormats);
		this.labelFormats = labelFormats;
	}

	// R2 ]
	public void setSelectedWorkStatus(String selectedWorkStatus) {
		this.selectedWorkStatus = selectedWorkStatus;
	}

	public String getSelectedWorkStatus() {
		return selectedWorkStatus;
	}

	public void setSelectedProductCandidateId(String selectedProductCandidateId) {
		this.selectedProductCandidateId = selectedProductCandidateId;
	}

	public String getSelectedProductCandidateId() {
		return selectedProductCandidateId;
	}

	/**
	 * @return the viewModeImageAttr
	 */
	public boolean isViewModeImageAttr() {
		return viewModeImageAttr;
	}

	/**
	 * @param viewModeImageAttr
	 *            the viewModeImageAttr to set
	 */
	public void setViewModeImageAttr(boolean viewModeImageAttr) {
		this.viewModeImageAttr = viewModeImageAttr;
	}

	/**
	 * @return the selectedProductIdItmTypCd
	 */
	public String getSelectedProductIdItmTypCd() {
		return selectedProductIdItmTypCd;
	}

	/**
	 * @param selectedProductIdItmTypCd
	 *            the selectedProductIdItmTypCd to set
	 */
	public void setSelectedProductIdItmTypCd(String selectedProductIdItmTypCd) {
		this.selectedProductIdItmTypCd = selectedProductIdItmTypCd;
	}

	public void setCommodities(List<BaseJSFVO> commodities) {
	}
}