package com.heb.operations.cps.controller;

import com.heb.enterprise.spellcheck.service.SpellCheckService;
import com.heb.jaf.security.Role;
import com.heb.jaf.security.UserInfo;
import com.heb.jaf.util.Constants;
import com.heb.jaf.vo.VendorOrg;
import com.heb.operations.business.framework.exeption.CPSBusinessException;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.exeption.CPSSystemException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.services.*;
import com.heb.operations.cps.util.BusinessUtil;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.CPSWebUtil;
import com.heb.operations.ui.framework.servlet.AppContextFunctions;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Superclass of all CPS Struts Actions. 1st, it extends DispatchAction so it
 * enables the dispatcher design pattern for all actions 2nd, it provides
 * utilities such as EJB lookup
 * 
 * @author robhardt
 * 
 */
@Service
public class HEBBaseService {

	private static Logger LOG = Logger.getLogger(HEBBaseService.class);

	private static final String INPUT_FORWARD_KEY = "INPUT_FORWARD_KEY";
	private static final String TO_BE_BYPASSED = "TO_BE_BYPASSED";

	private AppContextFunctions prodAppContextFunctions;
	@Autowired
	private CommonService commonService;
	@Autowired
	private LifeCycleService lifeCycleService;
	@Autowired
	private RolesService rolesService;
	@Autowired
	private AddNewCandidateService addNewCandidateService;
	@Autowired
	private SpellCheckService spellCheckService;
	@Autowired
	private CPSIndexUtilService cpsIndexUtilService;
	@Autowired
	private BatchUpload2Service batchUpload2Service;
	@Autowired
	private CpsIndexService cpsIndexService;
//	/**
//	 * Overriding execute method for all common functionalities including error
//	 * flow.
//	 */
//	@Override
//	public ActionForward execute(ActionMapping mapping, ActionForm actionForm,
//			HttpServletRequest request, HttpServletResponse response)
//			throws Exception {
//		ActionForward forward = null;
//		try {
//			HebBaseInfo form = (HebBaseInfo) actionForm;
//			form.setUserRole(getUserRole());
//			clearOtherFormsInSession(form, request);
//			setForm(request, actionForm);
//			clearMessages(form);
//			clearInputForwardValue(request);
//			forward = super.execute(mapping, actionForm, request, response);
//			// do nothing method from this level, acting as hook method for the
//			// child classes.
//			if (!isToBeBypassed(form) && forward != null) {
//				setCurrentActionForwardPath(forward.getName(), actionForm,
//						request);
//			}
//			return forward;
//		} catch (CPSBusinessException e) {
//			log.fatal("CPSBusinessException:-", e);
//			if (!isInputForwardValueSet(request)) {
//				setErrorPath(actionForm, request);
//			}
//			String inputScreen = handleException(e, (HebBaseInfo) actionForm,
//					request, response);
//			if (inputScreen == null) {
//				return forward;
//			}
//			return mapping.findForward(inputScreen);
//		} catch (CPSSystemException e) {
//			log.fatal("CPSSystemException:-", e);
//			if (!isInputForwardValueSet(request)) {
//				setErrorPath(actionForm, request);
//			}
//			String inputScreen = handleException(e, actionForm, request,
//					response);
//			return mapping.findForward(inputScreen);
//		} catch (Exception e) {
//			log.fatal("Exception:-", e);
//			if (!isInputForwardValueSet(request)) {
//				setErrorPath(actionForm, request);
//			}
//			String inputScreen = handleException(e, actionForm, request,
//					response);
//			if (inputScreen == null) {
//				return forward;
//			}
//			return mapping.findForward(inputScreen);
//		}
//	}

	protected void setViewMode(HebBaseInfo req) {
		req.setViewMode(true);
	}// CPS_VIEW_MODE

	protected void clearViewMode(HebBaseInfo req) {
		req.setViewMode(false);
	}

	protected boolean isViewMode(HebBaseInfo req) {
		return req.isViewMode();
	}

	protected void setModifyMode(HebBaseInfo req) {
		req.setModifyMode(true);
	}// CPS_VIEW_MODE

	protected void clearModifyMode(HebBaseInfo req) {
		req.setModifyMode(false);
	}

	protected boolean isModifyMode(HebBaseInfo req) {
		return req.isModifyMode();
	}

	protected String getUserRole() {
		Authentication au = SecurityContextHolder.getContext()
				.getAuthentication();
		if (au != null) {
			UserInfo user = (UserInfo) au.getPrincipal();
			if (null != user && !user.getUserRoles().isEmpty()) {
				for (Map.Entry<String, Role> roleUser : user.getUserRoles()
						.entrySet()) {
					if (!Constants.GUEST.equals(roleUser.getValue()
							.getRoleName())) {
						return roleUser.getValue().getRoleName();
					}
				}
			}
		}
		return Constants.GUEST;
	}

	// protected String getUserRole() {
	// Authentication au =
	// SecurityContextHolder.getContext().getAuthentication();
	// if (au != null) {
	// Collection<? extends GrantedAuthority> getAuth = au.getAuthorities();
	// System.out.println("getAuth:" + getAuth);
	// if (null != getAuth && !getAuth.isEmpty()) {
	// Role role = null;
	// for (GrantedAuthority grantedAuthority : getAuth) {
	// role = ((Role) grantedAuthority);
	// System.out.println("role.getRoleName():" + role.getRoleName());
	// if (!"Guest".equalsIgnoreCase(role.getRoleName())) {
	// return role.getRoleName();
	// }
	// }
	// }
	// }
	// return "Guest";
	// }

	// protected UserInfo getUserInfo() {
	// try {
	// HttpServletRequest request = (HttpServletRequest)
	// PolicyContext.getContext(HEBCustomRealmDelegateImpl.WEB_REQUEST_KEY);
	// UserInfo info = (UserInfo)
	// request.getSession(true).getAttribute("com.heb.UserAccountInfo");
	// return info;
	// } catch (PolicyContextException e) {
	// log.fatal("Exception:-", e);
	// }
	//
	// return null;
	// }
	protected UserInfo getUserInfo() {
		Authentication au = SecurityContextHolder.getContext()
				.getAuthentication();
		if (au != null) {
			return (UserInfo) au.getPrincipal();
		}
		return null;
	}

	protected boolean isToBeBypassed(HebBaseInfo baseForm) {
		Boolean boolean1 = (Boolean) baseForm.getCurrentRequest().getAttribute(
				TO_BE_BYPASSED);
		if (null != boolean1 && Boolean.TRUE.equals(boolean1)) {
			return true;
		} else {
			return false;
		}
	}

	protected void setBypass(HttpServletRequest req) {
		req.setAttribute(TO_BE_BYPASSED, Boolean.TRUE);
	}

	protected void clearMessages(HebBaseInfo actionForm) {
		actionForm.setMessages(new ArrayList<CPSMessage>());
	}

	/**
	 * This method is used to clear all other forms while going to another flow.
	 * The method can be overridden at the class level, if any previous form
	 * needs to be retained in any flow.
	 * 
	 * @param baseForm
	 * @param request
	 */
	protected void clearOtherFormsInSession(HebBaseInfo baseForm,
			HttpServletRequest request) {
		// this breaks searches and DWR, can someone email me and explain why it
		// exists?
		// I'm sure we can work something out.
		// uncommenting the code - albin
		try {
			if (request.getRequestURI().endsWith(".do")
					&& !(request.getQueryString().contains("printForm")
							|| request.getQueryString().contains("printMRT") || request
							.getQueryString()
							.contains("PrintFormViewerServlet"))) {// Fix
				// 1331
				List<String> list = CPSWebUtil.getToBeClearedFormList(request);
				HebBaseInfo earlierForm = getForm(request);
				if (null != earlierForm) {
					if (!baseForm.equals(earlierForm)) {
						list.add(earlierForm.getStrutsFormName());
					}
				}
			}
		} catch (Exception e) {
			LOG.info(
					"in HEB base action - clearOtherFormsInSession--> "
							+ e.getMessage(), e);
			LOG.info(((HttpServletRequest) request).getRequestURI());
		}

	}

	/**
	 * Do nothing method, acts as a hook to be overridden from the child class.
	 * The template method is the execute method. To set the error flow from the
	 * child class level. To set it from the method level we can use
	 * setInputForwardValue method.
	 * 
	 * @param form
	 * @param request
	 */
	protected void setErrorPath(HebBaseInfo form, HttpServletRequest request) {
	}

	/**
	 * Do nothing method, acts as a hook to be overridden from the child class.
	 * The template method is the execute method. To store the earlier path.
	 * 
	 * @param currentActionForwardPath
	 * @param form
	 * @param request
	 */
//	protected void setCurrentActionForwardPath(String currentActionForwardPath,
//			ActionForm form, HttpServletRequest request) {
//	}

	/**
	 * Handles business exception. Saves the message from the exception to the
	 * request which is to be rendered by the error page.
	 * 
	 * @param busEx
	 * @param baseForm
	 * @param request
	 * @param response
	 * @return
	 */
	protected String handleException(CPSBusinessException busEx,
			HebBaseInfo baseForm, HttpServletRequest request,
			HttpServletResponse response) {
		baseForm.setMessages(busEx.getMessages());
		return getInputForwardValue(request);
	}
	/**
	 * Handles System exception.
	 *
	 * @param exception
	 * @param actionForm
	 * @param request
	 * @param response
	 * @return
	 */
	protected String handleException(CPSSystemException exception,
									 HebBaseInfo actionForm, HttpServletRequest request,
									 HttpServletResponse response) {
		List<CPSMessage> list = new ArrayList<CPSMessage>();
		list.add(exception.getCPSMessage());
		actionForm.setMessages(list);
		return getInputForwardValue(request);

	}
	/**
	 * Saving messages to the request sorted in the order of severity.
	 * 
	 * @param baseForm
	 * @param list
	 */
	protected synchronized void saveMessages(HebBaseInfo baseForm,
			List<CPSMessage> list) {
		List<CPSMessage> addedMessages = new ArrayList<CPSMessage>();
		List<CPSMessage> msgs = baseForm.getMessages();
		if (null != msgs) {
			addedMessages.addAll(msgs);
		}
		if (null != list) {
			addedMessages.addAll(list);
		}
		Collections.sort(addedMessages);
		baseForm.setMessages(addedMessages);

	}

	/**
	 * Saving a single message to the request.
	 * 
	 * @param baseForm
	 * @param message
	 */
	public synchronized void saveMessage(HebBaseInfo baseForm,
			CPSMessage message) {
		List<CPSMessage> addedMessages = new ArrayList<CPSMessage>();
		// List<CPSMessage> msgs = baseForm.getMessages();
		// if(null != msgs){
		// addedMessages.addAll(msgs);
		// }
		if (null != message) {
			addedMessages.add(message);
		}
		Collections.sort(addedMessages);
		baseForm.setMessages(addedMessages);

	}

	public RolesService getRolesService() {
		return rolesService;
	}

	public void setRolesService(RolesService rolesService) {
		this.rolesService = rolesService;
	}

	public AppContextFunctions getAppContextFunctions() {
		return prodAppContextFunctions;
	}

	@Autowired
	public void setAppContextFunctions(@Qualifier(value = "prodAppContextFunctions") AppContextFunctions prodAppContextFunctions) {
		this.prodAppContextFunctions = prodAppContextFunctions;
	}



	public CommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public AddNewCandidateService getAddNewCandidateService() {
		return addNewCandidateService;
	}

	public void setSpellCheckService(SpellCheckService spellCheckService) {
		this.spellCheckService = spellCheckService;
	}

	public SpellCheckService getSpellCheckService() {
		return spellCheckService;
	}

	public void setAddNewCandidateService(
			AddNewCandidateService addNewCandidateService) {
		this.addNewCandidateService = addNewCandidateService;
	}



	public CPSIndexUtilService getCpsIndexUtilService() {
		return cpsIndexUtilService;
	}

	public void setCpsIndexUtilService(CPSIndexUtilService cpsIndexUtilService) {
		this.cpsIndexUtilService = cpsIndexUtilService;
	}


	public LifeCycleService getLifeCycleService() {
		return lifeCycleService;
	}

	public void setLifeCycleService(LifeCycleService lifeCycleService) {
		this.lifeCycleService = lifeCycleService;
	}

	public BatchUpload2Service getBatchUpload2Service() {
		return batchUpload2Service;
	}

	public void setBatchUpload2Service(BatchUpload2Service batchUpload2Service) {
		this.batchUpload2Service = batchUpload2Service;
	}

	public CpsIndexService getCpsIndexService() {
		return cpsIndexService;
	}

	public void setCpsIndexService(CpsIndexService cpsIndexService) {
		this.cpsIndexService = cpsIndexService;
	}
	/**
	 * This takes the current action form and puts it directly in the request
	 * object as 'CPSForm' so JSPs can access its properties without being
	 * inside a 'form' tag
	 *
	 * @param req
	 * @param af
	 */
	protected void setForm(HttpServletRequest req, HebBaseInfo af) {
		req.getSession().setAttribute(CPSConstants.CURRENT_FORM_KEY, af);
		if (af instanceof HebBaseInfo) {
			req.getSession().setAttribute(
					((HebBaseInfo) af).getStrutsFormName(), af);
		}
	}

	protected HebBaseInfo getForm(HttpServletRequest req) {
		return (HebBaseInfo) req.getSession().getAttribute(CPSConstants.CURRENT_FORM_KEY);
	}

	protected String handleException(Exception exception, HebBaseInfo baseForm,
			HttpServletRequest request, HttpServletResponse response) {
		throw new RuntimeException("Form type "
				+ baseForm.getClass().getName() + " not supported..");
	}

	/**
	 * Setting the input forward page from each flow. While using dispatch
	 * action, it is quite difficult to implement the input path. This is a
	 * dynamic way to achieve this. Any dispatched method can set the respective
	 * input path using this method. The string value should match a forward
	 * name configured in the struts config. Also this can be overridden at each
	 * child action to represent a common behaviour for all methods in mapping
	 * the input path
	 * 
	 * @param request
	 * @param value
	 */
	protected void setInputForwardValue(HttpServletRequest request, String value) {
		request.setAttribute(INPUT_FORWARD_KEY, value);
	}

	protected void clearInputForwardValue(HttpServletRequest request) {
		request.removeAttribute(INPUT_FORWARD_KEY);
	}

	protected boolean isInputForwardValueSet(HttpServletRequest request) {
		if (null != getInputForwardValue(request)
				&& !"".equals(getInputForwardValue(request))) {
			return true;
		}
		return false;
	}

	/**
	 * Getter method for the dynamic input path.
	 * 
	 * @param request
	 * @return
	 */
	protected String getInputForwardValue(HttpServletRequest request) {
		return (String) request.getAttribute(INPUT_FORWARD_KEY);
	}



	protected void cacheAutoCompleterResults(HttpServletRequest req,
			String[][] res, String uniqueId) {
		if ((res != null) && (res.length > 0)) {
			Map<String, Map<String, String>> cache = getCachedIdNameLookupMap(req);
			Map<String, String> uidCache = cache.get(uniqueId);
			if (uidCache == null) {
				uidCache = new HashMap<String, String>();
				cache.put(uniqueId, uidCache);
			}
			for (int i = 0; i < res.length; i++) {
				uidCache.put(res[i][0], res[i][1]);
			}
		}
	}

	protected void cacheAutoCompleterResults(HttpServletRequest req,
			List<BaseJSFVO> res, String uniqueId) {
		if ((res != null) && (res.size() > 0)) {
			Map<String, Map<String, String>> cache = getCachedIdNameLookupMap(req);
			if (cache != null) {
				Map<String, String> uidCache = cache.get(uniqueId);
				if (uidCache == null) {
					uidCache = new HashMap<String, String>();
					cache.put(uniqueId, uidCache);
				}
				for (BaseJSFVO baseJSFVO : res) {
					uidCache.put(baseJSFVO.getId(), baseJSFVO.getName());
				}
			}
		}
	}

	protected Map<String, Map<String, String>> getCachedIdNameLookupMap(
			HttpServletRequest req) {
		// when search results are returned and the user selects one, only the
		// 'id'
		// is stored in the struts form. This map captures the id -> name
		// relationship for further use
		HttpSession session = req.getSession();
		if (session != null) {
			Map<String, Map<String, String>> searchResultIdToNameMap = (Map<String, Map<String, String>>) session
					.getAttribute("JSON_SEARCH_RESULTS_MAP");

			if (searchResultIdToNameMap == null) {
				searchResultIdToNameMap = new HashMap<String, Map<String, String>>();
				session.setAttribute("JSON_SEARCH_RESULTS_MAP",
						searchResultIdToNameMap);
			}
			return searchResultIdToNameMap;
		}

		return null;

	}
	/**
	 * Gets the lst vendor id.
	 *
	 * @param req
	 *            the req
	 * @return the lst vendor id
	 */
	public List<Integer> getLstVendorId(HttpServletRequest req) {
		List<Integer> lst = new ArrayList<Integer>();
		String userRole = this.getUserRole();
		if (BusinessUtil.isVendor(userRole)) {
			Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) req.getSession()
					.getAttribute("vendorMap");
			if (vendorMap == null || vendorMap.isEmpty()) {
				try {
					vendorMap = getVendorLocationList();
				} catch (CPSGeneralException e) {
					// LOG.fatal(e.getMessage(), e);
				}
			}
			if (CPSHelper.isNotEmpty(vendorMap)) {
				for (Map.Entry<String, List<VendorLocationVO>> entry : vendorMap.entrySet()) {
					for (VendorLocationVO item : entry.getValue()) {
						if (CPSHelper.isNotEmpty(item.getVendorId())) {
							lst.add(NumberUtils.toInt(item.getVendorId()));
						}
					}
				}
			}
		} else {
			lst = null;
		}
		// }
		return lst;
	}
	/**
	 * Gets the vendor location list.
	 *
	 * @return the vendor location list
	 * @throws CPSGeneralException
	 *             the CPS general exception
	 */
	private Map<String, List<VendorLocationVO>> getVendorLocationList() throws CPSGeneralException {
		UserInfo info = getUserInfo();
		Map<String, List<VendorLocationVO>> vendorMap = new HashMap<String, List<VendorLocationVO>>();
		if (null != info) {
			List<VendorOrg> vendorIds = info.getVendorOrgs();
			List<VendorLocationVO> whsList = new ArrayList<VendorLocationVO>();
			List<VendorLocationVO> dsdList = new ArrayList<VendorLocationVO>();
			List<String> vendorIdList = new ArrayList<String>();
			if (null != vendorIds) {
				for (VendorOrg vendorOrg : vendorIds) {
					vendorIdList.add(vendorOrg.getVendorOrgId());

				}
			}
			String vendorId = info.getVendorOrgId();
			if (CPSHelper.isValidNumber(vendorId)) {
				vendorIdList.add(vendorId);
			}
			List<VendorLocationVO> vendList = getAddNewCandidateService().getVendorList(vendorIdList);
			if (CPSHelper.isNotEmpty(vendList)) {
				for (VendorLocationVO vendorLocationVO : vendList) {
					if ("D".equalsIgnoreCase(vendorLocationVO.getVendorLocationType())) {
						dsdList.add(vendorLocationVO);
					} else if ("V".equalsIgnoreCase(vendorLocationVO.getVendorLocationType())) {
						whsList.add(vendorLocationVO);
					}
				}
			}
			if (CPSHelper.isNotEmpty(whsList)) {
				vendorMap.put("whsLst", whsList);
			}
			if (CPSHelper.isNotEmpty(dsdList)) {
				vendorMap.put("dsdLst", dsdList);
			}
		}
		return vendorMap;
	}
}