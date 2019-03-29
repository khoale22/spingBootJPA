package com.heb.operations.cps.controller;

import com.heb.jaf.security.HebLdapUserService;
import com.heb.jaf.security.UserInfo;
import com.heb.jaf.vo.VendorOrg;
import com.heb.operations.business.framework.exeption.*;
import com.heb.operations.business.framework.exeption.CPSMessage.ErrorSeverity;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.ClassCommodityVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.business.framework.vo.WareHouseVO;
import com.heb.operations.cps.database.entities.PsCandidateStat;
import com.heb.operations.cps.ejb.webservice.WarehouseService.GetWarehouseListByVendor_Request.VendorList;
import com.heb.operations.cps.excelExport.CPSExportToExcel;
import com.heb.operations.cps.model.AddNewCandidate;
import com.heb.operations.cps.model.ManageEDICandidate;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.util.*;
import com.heb.operations.cps.vo.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.*;

/**
 * Created by thangdang on 11/6/2017.
 */
@Controller
@SessionAttributes(ManageEDIMainController.MANAGE_CANDIDATE_MODEL_ATTRIBUTE)
@RequestMapping(value = ManageEDIMainController.RELATIVE_PATH_EDI_MAIN_BASE)
public class ManageEDIMainController extends HEBBaseService {
    private static final Logger LOG = Logger
            .getLogger(ManageEDIMainController.class);
    public static final String RELATIVE_PATH_EDI_MAIN_BASE="/protected/cps/manageEDI";
    private static final String RELATIVE_PATH_ROOT_PAGE="/cps/manageEDI/";
    private static final String RELATIVE_PATH_MODULE="modules/";
    private static final String VIEW_MASS_PROFILES = "viewMassProfies";
    private static final String EDI_REJECT_COMMENT="rejectComment_popup";
    private static final String EDI_REJECT_COMMENT_AJAX="rejectComment_popup";
    private static final String EDI_UPCREJECT_COMMENT="upcComment_popup";
    private static final String EDI_UPCREJECT_COMMENT_AJAX="upcComment_popup";
    private static final String EDI_PRINTFORMLINKS_AJAX ="printFormFiles_ajax";
    private static final String EDI_TEST_SCAN="testScan_popup";
    private static final String EDI_TEST_SCAN_AJAX="testScan_popup";
    private static final String AUTHORIZED_STORES="authorizedStore";
    private static final String AUTHORIZED_STORES_AJAX="authorizedStoreAjax";
    private static final String REJECT_DSD_FORM ="rejectDSDDiscontinue";
    public static final String MANAGE_CANDIDATE_MODEL_ATTRIBUTE="manageEDICandidate";
    private static final String RELATIVE_PATH_SEARCH_EDI_CANDIDATE="/searchEDICandidate";
    private static final String RELATIVE_PATH_EDIT_SEARCH_WRAPPER="/ediSearchWrapper";
    private static final String RELATIVE_PATH_KEEP_VALUE_SEARCH="/keepValueSearch";
    private static final String RELATIVE_PATH_MODIFY_SEARCH="/modifySeach";
    private static final String RELATIVE_PATH_GET_SELLING_UPC_SECTION_DETAILS="/getSellingUpcSectionDetails";
    private static final String RELATIVE_PATH_GET_OTHER_ATTRIBUTE="/getOtherAttribute";
    private static final String RELATIVE_PATH_GET_AUTHORIZATION_DISTRIBUTION="/getAuthorizationDistribution";
    private static final String RELATIVE_PATH_GET_COST_AND_DETAIL="/getCostAndRetailDetail";
    private static final String RELATIVE_PATH_GET_DESCRIPTION_AND_SIZE_DETAIL="/getDescriptionAndSizeDetail";
    private static final String RELATIVE_PATH_GET_CASE_PACK_DETAIL="/getCasePackDetail";
    private static final String RELATIVE_PATH_UPDATE_VALUES="/updateValues";
    private static final String RELATIVE_PATH_REJECT_COMMENT="/rejectComment";
    private static final String RELATIVE_PATH_REJECT_COMMENT_AJAX="/rejectCommentAjax";
    private static final String RELATIVE_PATH_UPC_COMMENT="/upcComment";
    private static final String RELATIVE_PATH_UPC_COMMENT_AJAX="/upcCommentAjax";
    private static final String RELATIVE_PATH_PRINT_SUMMARY="/printSummary";
    private static final String RELATIVE_PATH_PRINT_SUMMARY_PROD="/printSummaryProd";
    private static final String RELATIVE_PATH_PRINT_FORM_AJAX="/printFormAjax";
    private static final String RELATIVE_PATH_PRINT_FORM="printForm";
    private static final String RELATIVE_PATH_PRINT_FORM_FILE="printFormFiles";
    private static final String RELATIVE_PATH_TEST_SCANS="testScans";
    private static final String RELATIVE_PATH_TEST_SCANS_AJAX="testScansAjax";
    private static final String RELATIVE_PATH_APPROVE_DSD="approveDSD";
    private static final String RELATIVE_PATH_ACTIVE="activate";
    private static final String RELATIVE_PATH_ACTIVATION_MESSAGE="activationMessage";
    private static final String RELATIVE_PATH_UPDATE_DSD_DISCONTINUE="updateDsdDiscontinue";
    private static final String RELATIVE_PATH_AUTHORIZED_STORE="authorizedStore";
    private static final String RELATIVE_PATH_AUTHORIZED_STORE_AJAX="authorizedStoreAjax";
    private static final String RELATIVE_PATH_REMOVE_REJECTED_CANDIDATE="removeRejectedCandidate";
    private static final String RELATIVE_PATH_REJECT_DSD_AJAX="rejectDSDAjax";
    private static final String RELATIVE_PATH_REJECT_DSD="rejectDSD";
    private static final String RELATIVE_PATH_SAVE_REJECTED_COMMENT_CANDIDATE="saveRejectedCommentCandidate";
    private static final String RELATIVE_PATH_SAVE_TEST_SCAN_CANDIDATE="saveTestScanCandidate";
    private static final String RELATIVE_PATH_VIEW_MASS_UPLOAD_PROFIED="viewMassUpLoadProfied";
    private static final String RELATIVE_PATH_DELETE_MASS_UPLOAD_PROFILIES="deleteMassUploadProfilies";
    private static final String RELATIVE_PATH_UPDATE_MASS_UPLOAD_PROFILIES="updateMassUploadProfilies";
    private static final String RELATIVE_PATH_DELETE_EDI="deleteEdi";
    @Autowired
    HebLdapUserService hebLdapUserService;

    @Override
    protected void setErrorPath(HebBaseInfo form, HttpServletRequest request) {
        super.setErrorPath(form, request);
        if (form instanceof ManageEDICandidate) {
            setInputForwardValue(request, CPSConstants.EDI_MANAGE_MAIN);
        }
    }

    /*
	 * @author thangdang
	 *
	 * @Description
	 *
	 * @Param
	 *
	 * @return
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_SEARCH_EDI_CANDIDATE)
    public ModelAndView searchEDICandidate(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        try {
            setForm(req, manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            setForm(req, manageEDICandidate);
            clearModifyMode(manageEDICandidate);

            if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
                req.getSession().removeAttribute(CPSConstants.REDIRECT_FORM);
            }
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
            // keep list of search criteria
            try {
                populateDataSources(manageEDICandidate, req);
            } catch (Exception e) {
                LOG.error("Error get populateDataSources Exception :"
                        + e.getMessage());
            }
            try{
                populateActions(manageEDICandidate, req);
            } catch (Exception e) {
                LOG.error("Error get populateActions Exception :"
                        + e.getMessage());
            }
            if (CPSHelper.isEmpty(manageEDICandidate.getProductTypes()) || manageEDICandidate.getProductTypes().size() == 1) {
                manageEDICandidate.setProductTypes(getAppContextFunctions()
                        .getProductTypes());
            }
            this.setDataAutoCompltete(manageEDICandidate,req);
            CandidateEDISearchCriteria candSearchCriteria = manageEDICandidate
                    .getCandidateEDISearchCriteria();

            HttpSession obj = req.getSession();
            Authentication auth = SecurityContextHolder.getContext()
                    .getAuthentication();
            UserInfo hebUserDetails = (UserInfo) auth.getPrincipal();
            Map<Integer, String> m = hebUserDetails.getResourceMap();

            manageEDICandidate.getEdiSearchResultVOLst().clear();
            if (CPSHelper.isNotEmpty(candSearchCriteria.getVendorDescription())
                    && CPSHelper.isEmpty(candSearchCriteria.getVendorIDList())) {
                List<Integer> vendorIDList = new ArrayList<Integer>();
                try {
                    Integer vendorID = CPSHelper.getIntegerValue(candSearchCriteria
                            .getVendorDescription());
                    vendorIDList.add(vendorID);
                    VendorList vendorList = new VendorList(null, null, vendorID);
                    List<WareHouseVO> warehouseList = getCommonService()
                            .getWareHouseList(vendorList, null);
                    if (CPSHelper.isNotEmpty(warehouseList)) {
                        String padVendorID = CPSHelper.padZeros(
                                candSearchCriteria.getVendorDescription(), 6);
                        for (WareHouseVO whVo : warehouseList) {
                            vendorIDList.add(CPSHelper.getIntegerValue(whVo
                                    .getWhareHouseid() + padVendorID));
                        }
                    }
                } catch (NumberFormatException num) {
                    // It is not a Vendor ID - go on.
                    LOG.error("It is not a Vendor ID - go on.");
                } catch (CPSSystemException sys) {
                    // Service not up - log & go on.
                    LOG.error("Unable to get Warehouse service", sys);
                } catch (CPSGeneralException gen) {
                    // no warehouses found - could be DSD vendor - go on.
                    LOG.error("Unable to get Warehouse service", gen);
                }
                if (!vendorIDList.isEmpty()) {
                    candSearchCriteria.setVendorIDList(vendorIDList);
                }
            }
            candSearchCriteria.setUserName(getCommonService().getUserName());
            candSearchCriteria.setRole(getUserRole());
            // Albin - other criteria to be added
            List<EDISearchResultVO> results = new ArrayList<EDISearchResultVO>();
            List<EDISearchResultVO> resultTemps = getCommonService()
                    .getEDICandidatesForCriteria(candSearchCriteria);
            if (resultTemps.isEmpty()) {
                manageEDICandidate.setHaveResults(false);
                // Checking for Activation
                saveMessage(manageEDICandidate, new CPSMessage(
                        "No matches found,change criteria", ErrorSeverity.WARNING));
            } else {

                // trungnv improve GUI EDI
                manageEDICandidate.setHaveResults(true);
                if (BusinessUtil.isVendor(getUserRole())) {
                    List<VendorLocationVO> vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
                    List<String> vendorUserIds = null;
                    Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) obj
                            .getAttribute("vendorMap");
                    if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
                        vendorMap = getVendorLocationList();
                    }
                    for (EDISearchResultVO ediSearchResultVO : results) {
                        vendorUserIds = new ArrayList<String>();
                        vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
                        if (ediSearchResultVO.getChannel() != null) {
                            if (("V").equals(ediSearchResultVO.getChannel())) {
                                vendorLocationVOOfUser = vendorMap.get("whsLst");
                            } else if (("D").equals(ediSearchResultVO.getChannel())) {
                                vendorLocationVOOfUser = vendorMap.get("dsdLst");
                            } else {
                                vendorLocationVOOfUser.addAll(vendorMap
                                        .get("whsLst"));
                                vendorLocationVOOfUser.addAll(vendorMap
                                        .get("dsdLst"));
                            }
                            for (VendorLocationVO vendorLocationVO : vendorLocationVOOfUser) {
                                if (CPSHelper.isNotEmpty(vendorLocationVO
                                        .getVendorId())) {
                                    vendorUserIds.add(CPSHelper
                                            .checkVendorNumber(vendorLocationVO
                                                    .getVendorId()));
                                }
                            }
                            if (vendorUserIds.contains(CPSHelper
                                    .checkVendorNumber(ediSearchResultVO
                                            .getPsVendno()))) {
                                results.add(ediSearchResultVO);
                            }
                        }
                    }
                } else {
                    results = resultTemps;
                }
            }
            manageEDICandidate.setManageCandidateMode();
            manageEDICandidate.setValidForResults(true);
            manageEDICandidate.setEdiSearchResultVOLst(results);
            validateAndDisableRowResult(manageEDICandidate, m);
            manageEDICandidate.setEdiSearchResultVOLstTemp(manageEDICandidate
                    .getEdiSearchResultVOLstTemp());
            manageEDICandidate.setCurrentRecord(10);
        /*
		 * keep results in session It used for reject candidate at search page
		 */
            req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION, results);
            req.getSession().setAttribute(CPSConstants.CPS_CRITERIA_SESSION, candSearchCriteria);
		/*
		 * identify search result is not empty and don't execute search by Mrt
		 * Switch
		 *
		 * @author khoapkl
		 */
            req.setAttribute("noData", results != null && !results.isEmpty() ? true
                    : false);
            // keep bdm value after searching
            manageEDICandidate.getCandidateEDISearchCriteria()
                    .setBdmValue(
                            manageEDICandidate.getCandidateEDISearchCriteria()
                                    .getBdmValue());
            manageEDICandidate.setAllStatus(initStatus(getUserRole()));
            manageEDICandidate.setCurrentTab(EDIConstants.SELLING_UPC_TAB);
            // check wherever the row result is disable or not

            // reset result filter
            manageEDICandidate.setFilterValues("");
            manageEDICandidate.setItemsResultFilter("");
        }  catch (CPSBusinessException e) {
            LOG.fatal("CPSBusinessException:-", e);
            if (!isInputForwardValueSet(req)) {
            }
            handleException(e, manageEDICandidate,
                    req, resp);
        } catch (CPSSystemException e) {
            LOG.fatal("CPSSystemException:-", e);
            handleException(e, manageEDICandidate, req, resp);
        }
        catch (Exception e) {
            LOG.fatal("Exception:-", e);
            handleException(e, manageEDICandidate, req, resp);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author thangdang
	 *
	 * @Description
	 *
	 * @Param
	 *
	 * @return
	 */
    @RequestMapping(method = RequestMethod.GET, value = ManageEDIMainController.RELATIVE_PATH_EDIT_SEARCH_WRAPPER)
    public ModelAndView ediSearchWrapper(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        setForm(req, manageEDICandidate);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        req.getSession().setAttribute(CPSConstants.PRESENT_BTS, "2");
        manageEDICandidate.setSession(req.getSession());
        try{
        manageEDICandidate
                .setClasses(getCommonService().getClassesAsBaseJSFVOs());
        } catch (Exception e) {
            LOG.error("Error get getClassesAsBaseJSFVOs Exception :" + e);
        }
        manageEDICandidate.setAllStatus(initStatus(getUserRole()));
        manageEDICandidate.setValidForResults(false);
        manageEDICandidate.setSelectedFunction(HebBaseInfo.MAANAGE_CANDIDATE);
        manageEDICandidate.setManageCandidateMode();
        manageEDICandidate.setValidForResults(true);
        manageEDICandidate.setHaveResults(false);
        HttpSession session = req.getSession();
        manageEDICandidate.getEdiSearchResultVOLst().clear();
        Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
                .getAttribute("vendorMap");
        if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
            vendorMap = getVendorLocationList();
            if (null != vendorMap) {
                session.setAttribute("vendorMap", vendorMap);
            }
        }
        try{
            populateBDMs(manageEDICandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateBDMs Exception :" + e.getMessage());
        }
		/*
		 * Initial commodity and sub-commodity for the first run
		 *
		 * @author khoapkl
		 */
		try{
            populateCommodities(manageEDICandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateCommodities Exception :"
                    + e.getMessage());
        }
        try{
            populateSubCommodities(manageEDICandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateSubCommodities Exception :"
                    + e.getMessage());
        }
        populateDataSources(manageEDICandidate, req);
        populateActions(manageEDICandidate, req);

        manageEDICandidate
                .setCandidateEDISearchCriteria(new CandidateEDISearchCriteria());
        // setcurrenttab
        manageEDICandidate.setCurrentTab(EDIConstants.SELLING_UPC_TAB);
        if (CPSHelper.isEmpty(manageEDICandidate.getProductTypes()) || manageEDICandidate.getProductTypes().size() == 1) {
            manageEDICandidate.setProductTypes(getAppContextFunctions()
                    .getProductTypes());
        }
        // reset result filter
        manageEDICandidate.setFilterValues("");
        manageEDICandidate.setItemsResultFilter("");
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }
    private void setDataAutoCompltete(ManageEDICandidate manageEDICandidate,HttpServletRequest req) throws CPSGeneralException{
        if (CPSHelper.isNotEmpty(manageEDICandidate.getCandidateEDISearchCriteria().getCommodity())) {
            if (!CPSHelper.isNotEmpty(manageEDICandidate.getCandidateEDISearchCriteria().getBdm())) {
                manageEDICandidate.setBdms(this.getCommonService().getBDMForCommodity(manageEDICandidate.getCandidateEDISearchCriteria()
                        .getCommodity()));
            } else {
                try {
                    populateBDMs(manageEDICandidate, req);
                } catch (Exception e) {
                    LOG.error("Error get populateBDMs Exception :" + e.getMessage());
                }
            }
        } else {
            try {
                populateBDMs(manageEDICandidate, req);
            } catch (Exception e) {
                LOG.error("Error get populateBDMs Exception :" + e.getMessage());
            }
        }
        if (CPSHelper.isNotEmpty(manageEDICandidate.getCandidateEDISearchCriteria().getCommodity())) {
            if (!CPSHelper.isNotEmpty(manageEDICandidate.getCandidateEDISearchCriteria().getClassField())) {
                manageEDICandidate.setClasses(this.getCommonService().getClassForCommodity(manageEDICandidate.getCandidateEDISearchCriteria()
                        .getCommodity()));
            } else {
                try {
                    manageEDICandidate
                            .setClasses(getCommonService().getClassesAsBaseJSFVOs());
                } catch (Exception e) {
                    LOG.error("Error get getClassesAsBaseJSFVOs Exception :" + e.getMessage());
                }
            }
        } else {
            try {
                manageEDICandidate
                        .setClasses(getCommonService().getClassesAsBaseJSFVOs());
            } catch (Exception e) {
                LOG.error("Error get getClassesAsBaseJSFVOs Exception :" + e.getMessage());
            }
        }
        if (CPSHelper.isNotEmpty(manageEDICandidate.getCandidateEDISearchCriteria().getBdm())) {
            manageEDICandidate.setCommodities(this.getCommoditiesFromBDM(
                    manageEDICandidate, manageEDICandidate.getCandidateEDISearchCriteria().getBdm()));
        } else {
            try {
                populateCommodities(manageEDICandidate, req);
            } catch (Exception e) {
                LOG.error("Error get populateCommodities Exception :"
                        + e.getMessage());
            }
        }
        if (CPSHelper.isNotEmpty(manageEDICandidate.getCandidateEDISearchCriteria().getCommodity())) {
            manageEDICandidate.setSubCommodities(this.getCommonService()
                    .getSubCommodityByClassAndCommodity(
                            manageEDICandidate.getCandidateEDISearchCriteria().getClassField(),
                            manageEDICandidate.getCandidateEDISearchCriteria().getCommodity()));
        } else {
            try {
                populateSubCommodities(manageEDICandidate, req);
            } catch (Exception e) {
                LOG.error("Error get populateSubCommodities Exception :"
                        + e.getMessage());
            }
        }
    }
    @RequestMapping(method = RequestMethod.GET, value = ManageEDIMainController.RELATIVE_PATH_KEEP_VALUE_SEARCH)
    public ModelAndView keepValueSearch(@ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE)ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);

        String formName = manageEDICandidate.getStrutsFormName();
        ManageEDICandidate cpsEDIManageForm = null;
        if (req.getSession().getAttribute(formName) != null) {
            cpsEDIManageForm = (ManageEDICandidate) req.getSession()
                    .getAttribute(formName);
        } else {
            cpsEDIManageForm = manageEDICandidate;
        }
        setForm(req, cpsEDIManageForm);
        cpsEDIManageForm.setSession(req.getSession());
        if (CPSHelper.isEmpty(cpsEDIManageForm.getCurrentTab())
                || ("null").equalsIgnoreCase(cpsEDIManageForm.getCurrentTab())) {
            cpsEDIManageForm.setCurrentTab("sellingUpctab");
        }
        if (cpsEDIManageForm.getEdiSearchResultVOLst().isEmpty()) {
            cpsEDIManageForm.getEdiSearchResultVOLst().clear();
            cpsEDIManageForm.getEdiSearchResultVOLstTemp().clear();
            if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION) != null) {
                List<EDISearchResultVO> list = (List<EDISearchResultVO>) req
                        .getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION);
                cpsEDIManageForm.setEdiSearchResultVOLst(list);
                cpsEDIManageForm.setEdiSearchResultVOLstTemp(list);
            }
        }
        // fix bug 6621
        try{
            cpsEDIManageForm
                .setClasses(getCommonService().getClassesAsBaseJSFVOs());
        } catch (Exception e) {
            LOG.error("Error get getClassesAsBaseJSFVOs Exception :" + e);
        }
        cpsEDIManageForm.setAllStatus(initStatus(getUserRole()));
        cpsEDIManageForm.setValidForResults(false);
        cpsEDIManageForm.setSelectedFunction(HebBaseInfo.MAANAGE_CANDIDATE);
        cpsEDIManageForm.setManageCandidateMode();
        cpsEDIManageForm.setValidForResults(true);
        cpsEDIManageForm.setHaveResults(true);
        cpsEDIManageForm.setCurrentRecord(10);
        if (CPSHelper.isEmpty(cpsEDIManageForm.getCurrentTab())) {
            if (req.getSession().getAttribute(CPSConstants.EDI_CURRENT_TAB) != null)
                cpsEDIManageForm.setCurrentTab((String) req.getSession()
                        .getAttribute(CPSConstants.EDI_CURRENT_TAB));
        }

        HttpSession session = req.getSession();

        Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
                .getAttribute("vendorMap");
        if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
            vendorMap = getVendorLocationList();
            if (null != vendorMap) {
                session.setAttribute("vendorMap", vendorMap);
            }
        }
        try{
            populateBDMs(cpsEDIManageForm, req);
        } catch (Exception e) {
            LOG.error("Error get populateBDMs Exception :" + e.getMessage());
        }
        try{
            populateCommodities(cpsEDIManageForm, req);
        } catch (Exception e) {
            LOG.error("Error get populateCommodities Exception :"
                    + e.getMessage());
        }
        try{
            populateSubCommodities(cpsEDIManageForm, req);
        } catch (Exception e) {
            LOG.error("Error get populateSubCommodities Exception :"
                    + e.getMessage());
        }
        populateDataSources(cpsEDIManageForm, req);
        populateActions(cpsEDIManageForm, req);
        if (CPSHelper.isEmpty(cpsEDIManageForm.getProductTypes())) {
            cpsEDIManageForm.setProductTypes(getAppContextFunctions()
                    .getProductTypes());
        }

        if (req.getSession().getAttribute(CPSConstants.CPS_CRITERIA_SESSION) != null) {
            CandidateEDISearchCriteria cri = (CandidateEDISearchCriteria) req
                    .getSession().getAttribute(CPSConstants.CPS_CRITERIA_SESSION);
            cpsEDIManageForm.setCandidateEDISearchCriteria(cri);
        }
        // end fix bug 6621

        cpsEDIManageForm.setFilterValues("");
        cpsEDIManageForm.setItemsResultFilter("");

        if (CPSHelper.isEmpty(req.getSession().getAttribute(
                CPSConstants.MODIFY_VALUE))) {
            model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
            return model;
        } else {
            return searchEDICandidate(cpsEDIManageForm, req, resp);
        }
    }
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_MODIFY_SEARCH)
    public ModelAndView modifySeach(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        setForm(req, manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        manageEDICandidate.setCurrentRecord(10);
        manageEDICandidate.setCurrentPage(1);
        // reset result filter
        manageEDICandidate.setFilterValues("");
        manageEDICandidate.setItemsResultFilter("");

        // if search with action is DSD Discontinue
        if (manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                .equals(BusinessConstants.SEARCH_ACTION_DISCONTINUE_ID))
            updateDiscontinue(manageEDICandidate);
        else
            // search with action is New Product Add
            update(manageEDICandidate);
        try{
            manageEDICandidate
                .setClasses(getCommonService().getClassesAsBaseJSFVOs());
        } catch (Exception e) {
            LOG.error("Error get getClassesAsBaseJSFVOs Exception :" + e);
        }
        manageEDICandidate.setAllStatus(initStatus(getUserRole()));
        HttpSession session = req.getSession();
        manageEDICandidate.getEdiSearchResultVOLst().clear();
        manageEDICandidate.setHaveResults(false);
        Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
                .getAttribute("vendorMap");
        if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
            vendorMap = getVendorLocationList();
            if (null != vendorMap) {
                session.setAttribute("vendorMap", vendorMap);
            }
        }
        try {
            populateBDMs(manageEDICandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateBDMs Exception :"
                    + e.getMessage());
        }
		/*
		 * Initial commodity and sub-commodity for the first run
		 *
		 * @author khoapkl
		 */
		try {
            populateCommodities(manageEDICandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateCommodities Exception :"
                    + e.getMessage());
        }
        try {
            populateSubCommodities(manageEDICandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateSubCommodities Exception :"
                    + e.getMessage());
        }
        populateDataSources(manageEDICandidate, req);
        populateActions(manageEDICandidate, req);

        manageEDICandidate.setCurrentTab(EDIConstants.SELLING_UPC_TAB);
        if (CPSHelper.isEmpty(manageEDICandidate.getProductTypes()) || manageEDICandidate.getProductTypes().size() == 1) {
            manageEDICandidate.setProductTypes(getAppContextFunctions()
                    .getProductTypes());
        }
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * getSellingUpcSectionDetails
	 *
	 * @author trungnv
	 */
    @RequestMapping(method = RequestMethod.POST, value = ManageEDIMainController.RELATIVE_PATH_GET_SELLING_UPC_SECTION_DETAILS)
    public ModelAndView getSellingUpcSectionDetails(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate = (ManageEDICandidate)getForm(req);
        //setForm(req, manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        manageEDICandidate.setCurrentPage(1);

        if (manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
            // get data of your tab if it is the first time.
            manageEDICandidate.setCurrentTab(EDIConstants.SELLING_UPC_TAB);
            model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
            return model;
        }

        update(manageEDICandidate);

        getCommonService().getSellingUpcSectionDetails(
                manageEDICandidate.getEdiSearchResultVOLst());
        manageEDICandidate.setEdiSearchResultVOLst(manageEDICandidate
                .getEdiSearchResultVOLst());
        manageEDICandidate.setEdiSearchResultVOLstTemp(manageEDICandidate
                .getEdiSearchResultVOLst());
        manageEDICandidate.setCurrentTab(EDIConstants.SELLING_UPC_TAB);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null) {
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        }
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    private void populateBDMs(ManageEDICandidate candidateMainForm,
                              HttpServletRequest req) throws Exception {
        if (candidateMainForm.getBdms() == null
                || candidateMainForm.getBdms().isEmpty()) {
            List<BaseJSFVO> bdmList = getAppContextFunctions().getBdmList();
            candidateMainForm.setBdms(bdmList);
        }
    }

    /*
	 * Get all commodities from Cache and set value into Commodity combo-box
	 *
	 * @author khoapkl
	 */
    private void populateCommodities(ManageEDICandidate candidateMainForm,
                                     HttpServletRequest req) throws Exception {
        if (candidateMainForm.getCommodities() == null
                || candidateMainForm.getCommodities().isEmpty()) {
            List<BaseJSFVO> commodities = getAppContextFunctions()
                    .getCommodityList();
            candidateMainForm.setCommodities(commodities);
        }
    }

    /*
	 * Get all sub-commodities from Cache and set value into Sub-Commodity
	 * combo-box
	 *
	 * @author khoapkl
	 */
    private void populateSubCommodities(ManageEDICandidate candidateMainForm,
                                        HttpServletRequest req) throws Exception {
        if (candidateMainForm.getSubCommodities() == null
                || candidateMainForm.getSubCommodities().isEmpty()) {
            List<BaseJSFVO> subCommodities = getAppContextFunctions()
                    .getSubCommodityList();
            candidateMainForm.setSubCommodities(subCommodities);
        }
    }

    /*
	 * Init candidate status. It used for search page
	 *
	 * @author khoapkl
	 */
    public List<BaseJSFVO> initStatus(String userRole) {
        List<BaseJSFVO> allStatus = new ArrayList<BaseJSFVO>();
        if (userRole.equals(BusinessConstants.REGISTERED_VENDOR_ROLE)
                || getUserRole().equals(
                BusinessConstants.UNREGISTERED_VENDOR_ROLE)) {
            allStatus.add(new BaseJSFVO(BusinessConstants.VENDOR_CODE,
                    CPSConstants.VENDOR_CANDIDATE_STATUS));
            allStatus
                    .add(new BaseJSFVO(BusinessConstants.REJECT_CODE, CPSConstants.REJECTED));
        }
        allStatus.add(new BaseJSFVO(BusinessConstants.WORKING_CODE,
                CPSConstants.WORKING_CANDIDATE_STATUS));
        // Fix 1229
        allStatus.add(new BaseJSFVO(BusinessConstants.ACTIVATION_FAILURE_CODE,
                CPSConstants.ACTIVATION_FAILED_STATUS));
        // Fix QC-1326
        if (getUserRole().equals(BusinessConstants.ADMIN_ROLE)
                || getUserRole().equals(BusinessConstants.PIA_LEAD_ROLE)) {
            allStatus.add(new BaseJSFVO(BusinessConstants.VENDOR_CODE,
                    CPSConstants.VENDOR_CANDIDATE_STATUS));
        }
        CPSHelper.sortList(allStatus);
        CPSHelper.insertBlankSelect(allStatus);
        return allStatus;
    }

    private Map<String, List<VendorLocationVO>> getVendorLocationList()
            throws CPSGeneralException {
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
            List<VendorLocationVO> vendList = getAddNewCandidateService()
                    .getVendorList(vendorIdList);
            if (CPSHelper.isNotEmpty(vendList)) {
                for (VendorLocationVO vendorLocationVO : vendList) {
                    if ("D".equalsIgnoreCase(vendorLocationVO
                            .getVendorLocationType())) {
                        dsdList.add(vendorLocationVO);
                    } else if ("V".equalsIgnoreCase(vendorLocationVO
                            .getVendorLocationType())) {
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

    private void populateDataSources(ManageEDICandidate candidateMainForm,
                                     HttpServletRequest req) throws Exception {
        if (candidateMainForm.getAllDataSource() == null
                || candidateMainForm.getAllDataSource().isEmpty()) {
            List<BaseJSFVO> allDataSource = new ArrayList<BaseJSFVO>();
            BaseJSFVO dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_DATASOURCE_ALL_ID);
            dataSource.setName(CPSConstants.SEARCH_DATASOURCE_ALL_VALUE);
            allDataSource.add(dataSource);
            dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_DATASOURCE_SINGLEENTRY_ID);
            dataSource
                    .setName(CPSConstants.SEARCH_DATASOURCE_SINGLEENTRY_VALUE);
            allDataSource.add(dataSource);
            dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_DATASOURCE_BATCHUPLOAD_ID);
            dataSource
                    .setName(CPSConstants.SEARCH_DATASOURCE_BATCHUPLOAD_VALUE);
            allDataSource.add(dataSource);
            dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_DATASOURCE_EDI_ID);
            dataSource.setName(CPSConstants.SEARCH_DATASOURCE_EDI_VALUE);
            allDataSource.add(dataSource);
            candidateMainForm.setAllDataSource(allDataSource);
        }
    }

    private void populateActions(ManageEDICandidate candidateMainForm,
                                 HttpServletRequest req) throws Exception {
        if (candidateMainForm.getAllAction() == null
                || candidateMainForm.getAllAction().isEmpty()) {
            List<BaseJSFVO> allAction = new ArrayList<BaseJSFVO>();
            BaseJSFVO dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_ACTION_BLANK_ID);
            dataSource.setName(CPSConstants.SEARCH_ACTION_BLANK_VALUE);
            allAction.add(dataSource);
            dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_ACTION_ADD_ID);
            dataSource.setName(CPSConstants.SEARCH_ACTION_ADD_VALUE);
            allAction.add(dataSource);
            dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_ACTION_CHANGE_ID);
            dataSource.setName(CPSConstants.SEARCH_ACTION_CHANGE_VALUE);
            allAction.add(dataSource);
            dataSource = new BaseJSFVO();
            dataSource.setId(CPSConstants.SEARCH_ACTION_DISCONTINUE_ID);
            dataSource.setName(CPSConstants.SEARCH_ACTION_DISCONTINUE_VALUE);
            allAction.add(dataSource);
            if (!getUserRole().equals(BusinessConstants.SCALE_MAN_ROLE)) {
                dataSource = new BaseJSFVO();
                dataSource.setId(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID);
                dataSource
                        .setName(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_VALUE);
                allAction.add(dataSource);
            }
            candidateMainForm.setAllAction(allAction);
        }
    }

    public List<BaseJSFVO> getBDMForCommodity(String commodityId)
            throws CPSGeneralException {
        return getCommonService().getBDMForCommodity(commodityId);
    }

    public List<BaseJSFVO> getCommoditiesFromBDM(
            ManageEDICandidate candidateMainForm, String bdmId)
            throws CPSGeneralException {

        if (bdmId.isEmpty()) {
            bdmId = CPSConstants.ALL;
        }
        Map<String, ClassCommodityVO> classComMap = null;

        try {
            classComMap = getCommonService().getCommoditiesForBDMFromCache(
                    bdmId);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        if (CPSHelper.isNotEmpty(classComMap)) {
            candidateMainForm.setClassCommodityMap(classComMap);
        }
        List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
        list.addAll(classComMap.values());
        CPSHelper.sortList(list);
        return list;
    }

    @RequestMapping(method = RequestMethod.POST, value = ManageEDIMainController.RELATIVE_PATH_GET_OTHER_ATTRIBUTE)
    public ModelAndView getOtherAttribute(@ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE)ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        try {
            setForm(req, manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            manageEDICandidate.setCurrentPage(1);

            // if search with action is active product than not get data after
            // move tab
            if (manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                    .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
                if (manageEDICandidate.getEdiSearchResultVOLst().get(0)
                        .getOtherAttributeDetailVO().getCodeDateMaxShelfLife() == null)
                    getCommonService().getOtherAttributeDataWithActiveProduct(
                            manageEDICandidate.getEdiSearchResultVOLst(),
                            manageEDICandidate.getCandidateEDISearchCriteria());
            } else {
                update(manageEDICandidate);
                getCommonService().getOtherAttributeData(
                        manageEDICandidate.getEdiSearchResultVOLst());
            }

            manageEDICandidate.setCurrentTab(EDIConstants.OTHER_ATTRIBUTE_TAB);

            req.getSession().setAttribute("listSeasonality",
                    getCommonService().getSeasonality());
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }
    @RequestMapping(method =RequestMethod.POST, value = ManageEDIMainController.RELATIVE_PATH_GET_AUTHORIZATION_DISTRIBUTION)
    public ModelAndView getAuthorizationDistribution(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp){
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            manageEDICandidate.setCurrentPage(1);

            if (!manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                    .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID))
                update(manageEDICandidate);

            manageEDICandidate
                    .setCurrentTab(EDIConstants.AUTHORIZATION_DISTRIBUTION_TAB);
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * get Cost and Retail data
	 *
	 * @author nghianguyen
	 */
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_GET_COST_AND_DETAIL)
    public ModelAndView getCostAndRetailDetail(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            setForm(req, manageEDICandidate);
            manageEDICandidate.setCurrentPage(1);

            // if search with action is active product than not get data after
            // move tab
            if (manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                    .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
                if (manageEDICandidate.getEdiSearchResultVOLst().get(0)
                        .getCostAndRetailDetailVO().getActualRetail() == null) {
                    getCommonService().getCostAndRetailDataWithActiveProduct(
                            manageEDICandidate.getEdiSearchResultVOLst(),
                            manageEDICandidate.getCandidateEDISearchCriteria());
                }
            } else {
                update(manageEDICandidate);
                getCommonService().getCostAndRetailDetailVO(
                        manageEDICandidate.getEdiSearchResultVOLst());
            }
            manageEDICandidate.setCurrentTab(EDIConstants.COST_RETAIL_TAB);
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /**
     * Keep the list of the date to show on select box of search criteria.;
     *
     * @param session the session object
     * @param manageEDICandidate the manageEDICandidate to merge.
     */
    private void keepSearchCriteriaList(HttpSession session, ManageEDICandidate manageEDICandidate){
        ManageEDICandidate manageEDICandidateSession = (ManageEDICandidate)session.getAttribute(ManageEDICandidate.FORM_NAME);
        manageEDICandidate.setEdiSearchResultVOLst(manageEDICandidateSession.getEdiSearchResultVOLst());
        manageEDICandidate.setCandidateEDISearchCriteria(manageEDICandidateSession.getCandidateEDISearchCriteria());
        manageEDICandidate.setClasses(manageEDICandidateSession.getClasses());
        manageEDICandidate.setAllStatus(manageEDICandidateSession.getAllStatus());
        manageEDICandidate.setCommodities(manageEDICandidateSession.getCommodities());
        manageEDICandidate.setSubCommodities(manageEDICandidateSession.getSubCommodities());
        manageEDICandidate.setAllDataSource(manageEDICandidateSession.getAllDataSource());
        manageEDICandidate.setAllAction(manageEDICandidateSession.getAllAction());
        manageEDICandidate.setProductTypes(manageEDICandidateSession.getProductTypes());
        manageEDICandidate.setHaveResults(manageEDICandidateSession.isHaveResults());
        manageEDICandidate.setCurrentTab(manageEDICandidateSession.getCurrentTab());
        manageEDICandidate.setListItemToUpdate(manageEDICandidateSession.getListItemToUpdate());
    }
    /*
	 * @author tuanle get Description And Size Detail
	 */
    @RequestMapping(method = RequestMethod.POST, value = ManageEDIMainController.RELATIVE_PATH_GET_DESCRIPTION_AND_SIZE_DETAIL)
    public ModelAndView getDescriptionAndSizeDetail(ManageEDICandidate manageEDICandidate, HttpServletRequest request, HttpServletResponse resp){
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        try {
            keepSearchCriteriaList(request.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(request.getSession());
            setForm(request, manageEDICandidate);
            manageEDICandidate.setCurrentPage(1);

            // if search with action is active product than not get data after
            // move tab
            if (manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                    .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
                if (manageEDICandidate.getEdiSearchResultVOLst().get(0)
                        .getDescriptionAndSizeDetailVO().getDescription() == null) {
                    getCommonService()
                            .getDescriptionAndSizeDataWithActiveProduct(
                                    manageEDICandidate.getEdiSearchResultVOLst(),
                                    manageEDICandidate
                                            .getCandidateEDISearchCriteria());
                }
            } else {
                update(manageEDICandidate);
                getCommonService().getDescriptionAndSizeDetailData(
                        manageEDICandidate.getEdiSearchResultVOLst());
            }

            manageEDICandidate.setCurrentTab(EDIConstants.DESCRIPTION_SIZE_TAB);
            Object currentMode = request.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                request.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            request.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);

        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;

    }

    /*
	 * @author tuanle get Case Pack Detail
	 */
    @RequestMapping(method = RequestMethod.POST, value = ManageEDIMainController.RELATIVE_PATH_GET_CASE_PACK_DETAIL)
    public ModelAndView getCasePackDetail(ManageEDICandidate manageEDICandidate, HttpServletRequest request, HttpServletResponse resp){
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        try {
            keepSearchCriteriaList(request.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(request.getSession());
            setForm(request, manageEDICandidate);
            manageEDICandidate.setCurrentPage(1);

            // if search with action is active product than not get data after
            // move tab
            if (manageEDICandidate.getCandidateEDISearchCriteria().getActionId()
                    .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
                if (manageEDICandidate.getEdiSearchResultVOLst().get(0)
                        .getCasePackDetailVO().getMasterPackQty() == null) {
                    getCommonService().getCasePackDataWithActiveProduct(
                            manageEDICandidate.getEdiSearchResultVOLst(),
                            manageEDICandidate.getCandidateEDISearchCriteria());
                }
            } else {
                update(manageEDICandidate);
                getCommonService().getCasePackDetailData(
                        manageEDICandidate.getEdiSearchResultVOLst());
            }

            manageEDICandidate.setCurrentTab(EDIConstants.CASE_PACK_TAB);
            Object currentMode = request.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                request.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            request.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;

    }
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_UPDATE_VALUES)
    public ModelAndView updateValues(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        setForm(req, manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        String userRole = getUserRole();
        // selling UPC
        if (!(BusinessUtil.isScaleManager(userRole)
                || BusinessUtil.isAdmin(userRole)
                || BusinessUtil.isPIARole(userRole)
                || BusinessUtil.isPIALead(userRole) || BusinessUtil
                .isVendor(userRole))) {

            saveMessage(manageEDICandidate, new CPSMessage("Invalid role ["
                    + userRole + "] trying to save a candidate",
                    ErrorSeverity.ERROR));
            model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
            return model;
        }

        update(manageEDICandidate);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);

        getCommonService().getSellingUpcSectionDetails(
                manageEDICandidate.getEdiSearchResultVOLst());
        manageEDICandidate.setEdiSearchResultVOLst(manageEDICandidate
                .getEdiSearchResultVOLst());
        manageEDICandidate.setEdiSearchResultVOLstTemp(manageEDICandidate
                .getEdiSearchResultVOLst());
        manageEDICandidate.setCurrentTab(EDIConstants.SELLING_UPC_TAB);

        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;

    }

    /*
	 * @author tuanle
	 *
	 * @Description get data for Reject
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_REJECT_COMMENT)
    public ModelAndView rejectComment(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + EDI_REJECT_COMMENT);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        setForm(req, manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        try {
            manageEDICandidate.getCommentUPCVOs().clear();
            ArrayList<String> productSelectedIds = new ArrayList<String>();
            String resultArray = (String) req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            StringTokenizer stCandidateTypeList = new StringTokenizer(
                    resultArray, CPSConstants.COMMA);
            while (stCandidateTypeList.hasMoreTokens()) {
                productSelectedIds.add(stCandidateTypeList.nextToken());
            }
            List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
            for (String productId : productSelectedIds) {
                for (EDISearchResultVO ediSearchResultVO : manageEDICandidate
                        .getEdiSearchResultVOLst()) {
                    if (productId.equals(ediSearchResultVO.getPsProdId()
                            .toString())) {
                        listEDISearchResultVO.add(ediSearchResultVO);
                    }
                }
            }
            String userRole = getUserRole();
            if (BusinessConstants.ADMIN_ROLE.equalsIgnoreCase(userRole)
                    || BusinessConstants.PIA_LEAD_ROLE
                    .equalsIgnoreCase(userRole)
                    || BusinessConstants.PIA_ROLE.equalsIgnoreCase(userRole)
                    || BusinessConstants.REGISTERED_VENDOR_ROLE
                    .equalsIgnoreCase(userRole)
                    || BusinessConstants.UNREGISTERED_VENDOR_ROLE
                    .equalsIgnoreCase(userRole)) {
                List<CommentUPCVO> listCommentUPCVOs = new ArrayList<CommentUPCVO>();
                listCommentUPCVOs.addAll(getCommonService().getRejectData(
                        listEDISearchResultVO, userRole));
                manageEDICandidate.getCommentUPCVOs().addAll(listCommentUPCVOs);
                if (manageEDICandidate.getCommentUPCVOs().isEmpty()) {
                    CPSMessage message = new CPSMessage(
                            "All UPC's of the selected Candidate have been Rejected",
                            ErrorSeverity.INFO);
                    saveMessage(manageEDICandidate, message);
                }
            } else {
                CPSMessage message = new CPSMessage(
                        "Only PIA or PIA Lead or Admin or Vendor can reject a candidate. Current Role is [ "
                                + userRole + " ]", ErrorSeverity.INFO);
                saveMessage(manageEDICandidate, message);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(manageEDICandidate, new CPSMessage("Error reject",
                    ErrorSeverity.ERROR));

        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author thangdang
	 *
	 * @Description
	 *
	 * @Param
	 *
	 * @return
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_REJECT_COMMENT_AJAX)
    public ModelAndView rejectCommentAjax(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+ RELATIVE_PATH_MODULE + EDI_REJECT_COMMENT_AJAX);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            setForm(req, manageEDICandidate);
            manageEDICandidate.getCommentUPCVOs().clear();
            Object objProductId = req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            String productIdArray = manageEDICandidate.getProductSelectedIds();
            if (objProductId != null)
                req.getSession().removeAttribute(
                        EDIConstants.EDI_PRODUCT_ID_SESSION);
            req.getSession().setAttribute(EDIConstants.EDI_PRODUCT_ID_SESSION,
                    productIdArray);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author tuanle
	 *
	 * @Description get data for Reject Comment
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_UPC_COMMENT)
    public ModelAndView upcComment(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + EDI_UPCREJECT_COMMENT);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            setForm(req, manageEDICandidate);
            manageEDICandidate.getCommentUPCVOs().clear();
            ArrayList<String> productSelectedIds = new ArrayList<String>();
            String resultArray = (String) req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            StringTokenizer stCandidateTypeList = new StringTokenizer(
                    resultArray, CPSConstants.COMMA);
            while (stCandidateTypeList.hasMoreTokens()) {
                productSelectedIds.add(stCandidateTypeList.nextToken());
            }
            List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
            for (String productId : productSelectedIds) {
                for (EDISearchResultVO ediSearchResultVO : manageEDICandidate
                        .getEdiSearchResultVOLst()) {
                    if (productId.equals(ediSearchResultVO.getPsProdId()
                            .toString())) {
                        listEDISearchResultVO.add(ediSearchResultVO);
                    }
                }
            }
            String userRole = getUserRole();
            if (BusinessConstants.ADMIN_ROLE.equalsIgnoreCase(userRole)
                    || BusinessConstants.PIA_LEAD_ROLE
                    .equalsIgnoreCase(userRole)
                    || BusinessConstants.PIA_ROLE.equalsIgnoreCase(userRole)
                    || BusinessConstants.REGISTERED_VENDOR_ROLE
                    .equalsIgnoreCase(userRole)
                    || BusinessConstants.UNREGISTERED_VENDOR_ROLE
                    .equalsIgnoreCase(userRole)) {
                List<CommentUPCVO> listCommentUPCVOs = new ArrayList<CommentUPCVO>();
                listCommentUPCVOs.addAll(getCommonService().getUpcCommentData(
                        listEDISearchResultVO));
                manageEDICandidate.getCommentUPCVOs().addAll(listCommentUPCVOs);
            } else {
                CPSMessage message = new CPSMessage(
                        "Only PIA or PIA Lead or Admin or Vendor can reject comment a candidate. Current Role is [ "
                                + userRole + " ]", ErrorSeverity.INFO);
                saveMessage(manageEDICandidate, message);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author thangdang
	 *
	 * @Description
	 *
	 * @Param
	 *
	 * @return
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_UPC_COMMENT_AJAX)
    public ModelAndView upcCommentAjax(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + EDI_UPCREJECT_COMMENT_AJAX);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            setForm(req, manageEDICandidate);
            manageEDICandidate.getCommentUPCVOs().clear();
            Object objProductId = req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            String productIdArray = manageEDICandidate.getProductSelectedIds();
            if (objProductId != null)
                req.getSession().removeAttribute(
                        EDIConstants.EDI_PRODUCT_ID_SESSION);
            req.getSession().setAttribute(EDIConstants.EDI_PRODUCT_ID_SESSION,
                    productIdArray);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author nhatnguyen
	 *
	 * @Description
	 *
	 * @Param
	 *
	 * @return
	 */
    @RequestMapping(method ={ RequestMethod.GET, RequestMethod.POST}, value = ManageEDIMainController.RELATIVE_PATH_PRINT_SUMMARY)
    public ModelAndView printSummary(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        try {
            setForm(req, manageEDICandidate);
            CPSExportToExcel exportToExcel = new CPSExportToExcel();
            UserInfo userInfo = getUserInfo();
            String userFullName = "";
            userFullName = userInfo.getAttributeValue("givenName") + " "
                    + userInfo.getAttributeValue("sn") + " ["
                    + userInfo.getUid() + "]";
            String printArray = manageEDICandidate.getProductSelectedIds();
            StringTokenizer st = new StringTokenizer(printArray, ",");
            List<Integer> prodIdList = new ArrayList<Integer>();
            List<PrintSumaryProductVO> finalPrintList = new ArrayList<PrintSumaryProductVO>();
            String prodIdNormal = "";
            HttpSession session = req.getSession();
            while (st.hasMoreTokens()) {
                prodIdList.add(Integer.parseInt(st.nextToken()));
            }
            if (prodIdList != null && !prodIdList.isEmpty()) {
                for (Integer productId : prodIdList) {
                    prodIdNormal = prodIdNormal + productId + CPSConstants.COMMA;
                }
                if (CPSHelper.isNotEmpty(prodIdNormal)) {
                    prodIdNormal = prodIdNormal.substring(0,
                            prodIdNormal.lastIndexOf(CPSConstants.COMMA));
                    finalPrintList = getAddNewCandidateService()
                            .getPrintSummaryCandidateNormal(prodIdNormal,
                                    userFullName);
                }
                List<String> columnHeadings = columnHeadingCandidates();
                CandidateEDISearchCriteria candSearchCriteria = manageEDICandidate
                        .getCandidateEDISearchCriteria();
                if (candSearchCriteria.getActionId() != null
                        && !("").equals(candSearchCriteria.getActionId().trim())) {
                    if (!("1").equals(candSearchCriteria.getActionId().trim())) {
                        if (manageEDICandidate.getAllAction() != null
                                && !manageEDICandidate.getAllAction().isEmpty()) {
                            for (BaseJSFVO baseJSFVO : manageEDICandidate
                                    .getAllAction()) {
                                if (baseJSFVO.getId().equals(
                                        candSearchCriteria.getActionId())) {
                                    candSearchCriteria.setActionName(baseJSFVO
                                            .getName());
                                    break;
                                }
                            }
                        }
                    } else {
                        candSearchCriteria.setActionName(null);
                    }
                }
                if (candSearchCriteria.getDataSourse() != null
                        && !("").equals(candSearchCriteria.getDataSourse()
                        .trim())
                        && !("0").equals(candSearchCriteria.getDataSourse()
                        .trim())) {
                    if (manageEDICandidate.getAllDataSource() != null
                            && !manageEDICandidate.getAllDataSource().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getAllDataSource()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getDataSourse())) {
                                candSearchCriteria.setDataSourseName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                if (candSearchCriteria.getTestScanStatus() != null
                        && !("").equals(candSearchCriteria.getTestScanStatus()
                        .trim())) {
                    if (manageEDICandidate.getTestScans() != null
                            && !manageEDICandidate.getTestScans().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getTestScans()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getTestScanStatus())) {
                                candSearchCriteria
                                        .setTestScanStatusName(baseJSFVO
                                                .getName());
                                break;
                            }
                        }
                    }
                }
                if (candSearchCriteria.getStatus() != null
                        && !("").equals(candSearchCriteria.getStatus().trim())) {
                    if (manageEDICandidate.getAllStatus() != null
                            && !manageEDICandidate.getAllStatus().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getAllStatus()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getStatus())) {
                                candSearchCriteria.setStatusName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                if (CPSHelper.isNotEmpty(candSearchCriteria.getProductType())) {
                    if (manageEDICandidate.getProductTypes() != null
                            && !manageEDICandidate.getProductTypes().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getProductTypes()) {
                            if (baseJSFVO.getId() != null
                                    && baseJSFVO
                                    .getId()
                                    .trim()
                                    .equals(candSearchCriteria
                                            .getProductType())) {
                                candSearchCriteria.setProductTypeName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
                        .getAttribute("vendorMap");

                if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
                    vendorMap = getVendorLocationList();
                }
                List<VendorLocationVO> vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
                List<String> vendorUserIds = null;
                if (BusinessUtil.isVendor(getUserRole())) {
                    List<PrintSumaryProductVO> finalPrintListTemp = new ArrayList<PrintSumaryProductVO>();
                    for (PrintSumaryProductVO printSumaryProductVOTemp : finalPrintList) {
                        vendorUserIds = new ArrayList<String>();
                        vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
                        if ("V".equalsIgnoreCase(printSumaryProductVOTemp
                                .getChannel())) {
                            vendorLocationVOOfUser = vendorMap.get("whsLst");
                        } else {
                            if ("D".equalsIgnoreCase(printSumaryProductVOTemp
                                    .getChannel())) {
                                vendorLocationVOOfUser = vendorMap
                                        .get("dsdLst");
                            } else {
                                vendorLocationVOOfUser.addAll(vendorMap
                                        .get("whsLst"));
                                vendorLocationVOOfUser.addAll(vendorMap
                                        .get("dsdLst"));
                            }
                        }
                        for (VendorLocationVO vendorLocationVO : vendorLocationVOOfUser) {
                            if (CPSHelper.isNotEmpty(vendorLocationVO
                                    .getVendorId())) {
                                vendorUserIds.add(CPSHelper
                                        .checkVendorNumber(vendorLocationVO
                                                .getVendorId()));
                            }
                        }
                        if (vendorUserIds != null
                                && vendorUserIds
                                .contains(CPSHelper
                                        .checkVendorNumber(printSumaryProductVOTemp
                                                .getVendorNumber()))) {
                            printSumaryProductVOTemp.setRetail("");
                            printSumaryProductVOTemp.setRetailLinkUPC("");
                            finalPrintListTemp.add(printSumaryProductVOTemp);
                        }
                    }

                    finalPrintList.clear();

                    finalPrintList = finalPrintListTemp;
                }
                exportToExcel.exportToExcelCandidateEDI(columnHeadings,
                        finalPrintList, "PrintSummary", null,
                        candSearchCriteria, resp, req, hebLdapUserService);
            }

        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author thangdang
	 *
	 * @Description
	 *
	 * @Param
	 *
	 * @return
	 */
    @RequestMapping(method = { RequestMethod.GET, RequestMethod.POST}, value = ManageEDIMainController.RELATIVE_PATH_PRINT_SUMMARY_PROD)
    public ModelAndView printSummaryProd(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            CPSExportToExcel exportToExcel = new CPSExportToExcel();
            UserInfo userInfo = getUserInfo();
            String userFullName = "";
            userFullName = userInfo.getAttributeValue("givenName") + " "
                    + userInfo.getAttributeValue("sn") + " ["
                    + userInfo.getUid() + "]";
            String printArray = manageEDICandidate.getProductSelectedIds();
            StringTokenizer st = new StringTokenizer(printArray, ",");
            List<Integer> prodIdList = new ArrayList<Integer>();
            List<PrintSumaryProductVO> finalPrintList = new ArrayList<PrintSumaryProductVO>();
            String prodIdNormal = "";
            HttpSession session = req.getSession();
            while (st.hasMoreTokens()) {
                prodIdList.add(Integer.parseInt(st.nextToken()));
            }
            if (prodIdList != null && !prodIdList.isEmpty()) {
                for (Integer productId : prodIdList) {
                    prodIdNormal = prodIdNormal + productId + CPSConstants.COMMA;
                }
                if (CPSHelper.isNotEmpty(prodIdNormal)) {
                    prodIdNormal = prodIdNormal.substring(0,
                            prodIdNormal.lastIndexOf(CPSConstants.COMMA));
                    finalPrintList = getAddNewCandidateService()
                            .getPrintSummaryProductNormal(prodIdNormal,
                                    userFullName);
                }
                List<String> columnHeadings = columnHeadingProducts();
                CandidateEDISearchCriteria candSearchCriteria = manageEDICandidate
                        .getCandidateEDISearchCriteria();
                if (candSearchCriteria.getActionId() != null
                        && !("").equals(candSearchCriteria.getActionId().trim())
                        && !("1").equals(candSearchCriteria.getActionId()
                        .trim())) {
                    if (manageEDICandidate.getAllAction() != null
                            && !manageEDICandidate.getAllAction().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getAllAction()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getActionId())) {
                                candSearchCriteria.setActionName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                if (candSearchCriteria.getDataSourse() != null
                        && !("").equals(candSearchCriteria.getDataSourse()
                        .trim())
                        && !("0").equals(candSearchCriteria.getDataSourse()
                        .trim())) {
                    if (manageEDICandidate.getAllDataSource() != null
                            && !manageEDICandidate.getAllDataSource().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getAllDataSource()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getDataSourse())) {
                                candSearchCriteria.setDataSourseName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                if (candSearchCriteria.getTestScanStatus() != null
                        && !("").equals(candSearchCriteria.getTestScanStatus()
                        .trim())) {
                    if (manageEDICandidate.getTestScans() != null
                            && !manageEDICandidate.getTestScans().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getTestScans()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getTestScanStatus())) {
                                candSearchCriteria
                                        .setTestScanStatusName(baseJSFVO
                                                .getName());
                                break;
                            }
                        }
                    }
                }
                if (candSearchCriteria.getStatus() != null
                        && !("").equals(candSearchCriteria.getStatus().trim())) {
                    if (manageEDICandidate.getAllStatus() != null
                            && !manageEDICandidate.getAllStatus().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getAllStatus()) {
                            if (baseJSFVO.getId().equals(
                                    candSearchCriteria.getStatus())) {
                                candSearchCriteria.setStatusName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                if (CPSHelper.isNotEmpty(candSearchCriteria.getProductType())) {
                    if (manageEDICandidate.getProductTypes() != null
                            && !manageEDICandidate.getProductTypes().isEmpty()) {
                        for (BaseJSFVO baseJSFVO : manageEDICandidate
                                .getProductTypes()) {
                            if (baseJSFVO.getId() != null
                                    && baseJSFVO
                                    .getId()
                                    .trim()
                                    .equals(candSearchCriteria
                                            .getProductType())) {
                                candSearchCriteria.setProductTypeName(baseJSFVO
                                        .getName());
                                break;
                            }
                        }
                    }
                }
                Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
                        .getAttribute("vendorMap");

                if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
                    vendorMap = getVendorLocationList();
                }
                List<VendorLocationVO> vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
                List<String> vendorUserIds = null;
                if (BusinessUtil.isVendor(getUserRole())) {
                    List<PrintSumaryProductVO> finalPrintListTemp = new ArrayList<PrintSumaryProductVO>();
                    for (PrintSumaryProductVO printSumaryProductVOTemp : finalPrintList) {
                        vendorUserIds = new ArrayList<String>();
                        vendorLocationVOOfUser = new ArrayList<VendorLocationVO>();
                        if ("V".equalsIgnoreCase(printSumaryProductVOTemp
                                .getChannel())) {
                            vendorLocationVOOfUser = vendorMap.get("whsLst");
                        } else {
                            if ("D".equalsIgnoreCase(printSumaryProductVOTemp
                                    .getChannel())) {
                                vendorLocationVOOfUser = vendorMap
                                        .get("dsdLst");
                            } else {
                                vendorLocationVOOfUser.addAll(vendorMap
                                        .get("whsLst"));
                                vendorLocationVOOfUser.addAll(vendorMap
                                        .get("dsdLst"));
                            }
                        }
                        for (VendorLocationVO vendorLocationVO : vendorLocationVOOfUser) {
                            if (CPSHelper.isNotEmpty(vendorLocationVO
                                    .getVendorId())) {
                                vendorUserIds.add(CPSHelper
                                        .checkVendorNumber(vendorLocationVO
                                                .getVendorId()));
                            }
                        }

                        if (vendorUserIds != null
                                && vendorUserIds
                                .contains(CPSHelper
                                        .checkVendorNumber(printSumaryProductVOTemp
                                                .getVendorNumber()))) {
                            printSumaryProductVOTemp.setRetail("");
                            finalPrintListTemp.add(printSumaryProductVOTemp);
                        }
                    }

                    finalPrintList.clear();

                    finalPrintList = finalPrintListTemp;
                }
                exportToExcel.exportToExcelProductEDI(columnHeadings,
                        finalPrintList, "PrintSummary", null,
                        candSearchCriteria, resp, req, hebLdapUserService);
            }

        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author nghianguyen
	 *
	 * @Description Ajax form to call printFormFiles_ajax.jsp
	 *
	 * @return mapping to file printFormFiles_ajax.jsp
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_PRINT_FORM_AJAX)
    public ModelAndView printFormAjax(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + EDI_PRINTFORMLINKS_AJAX);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        try {
            setForm(req, manageEDICandidate);
            String productIdArray = manageEDICandidate.getSelectedProductId();
            if (req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION) != null) {
                req.getSession().removeAttribute(
                        EDIConstants.EDI_PRODUCT_ID_SESSION);
            }
            req.getSession().setAttribute(EDIConstants.EDI_PRODUCT_ID_SESSION,
                    productIdArray);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageEDICandidate);
        return model;
    }

    /*
	 * @author nghianguyen
	 *
	 * @Description Ajax form to call printFormFiles.jsp
	 *
	 * @return mapping to file printFormFiles.jsp
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_PRINT_FORM)
    public ModelAndView printForm(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + RELATIVE_PATH_PRINT_FORM_FILE);
        ProductVO productVO = new ProductVO();
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        if (manageEDICandidate != null ) {
            setForm(req, manageEDICandidate);
        } else {
            ManageEDICandidate af = (ManageEDICandidate) req.getSession().getAttribute(
                    ManageEDICandidate.FORM_NAME);
            setForm(req, af);
        }
        manageEDICandidate.setSession(req.getSession());
        manageEDICandidate.setRejectClose(false);
        manageEDICandidate.setRejectComments(EDIConstants.EMPTY_STRING);
        List<Integer> prodList = new ArrayList<Integer>();
        String printArray = (String) req.getSession().getAttribute(
                EDIConstants.EDI_PRODUCT_ID_SESSION);
        if (CPSHelper.isNotEmpty(printArray)) {
            StringTokenizer st = new StringTokenizer(printArray, ",");
            int productId = 0;
            while (st.hasMoreTokens()) {
                productId = Integer.parseInt(st.nextToken());
                prodList.add(productId);
            }
        }

        manageEDICandidate.getPrintFormVOList().clear();

        List<EDISearchResultVO> results = manageEDICandidate
                .getEdiSearchResultVOLst();

        // Set the form for each product
        for (Integer prodId : prodList) {
            List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();

            PrintFormVO printFormVO = getSelectedVendorDescription(results,
                    prodId);

            if (printFormVO != null && CPSHelper.isNotEmpty(printFormVO.getVendorName())
                    && !EDIConstants.EMPTY_STRING.equalsIgnoreCase(printFormVO
                    .getVendorName())) {
                try {
                    productVO = getAddNewCandidateService().fetchProductPrint(
                            CPSHelper.getStringValue(prodId).trim(),
                            getUserRole(), false);
                } catch (Exception ex) {
                    LOG.error(ex.getMessage(), ex);
                    manageEDICandidate.setRejectClose(true);
                    manageEDICandidate
                            .setRejectMessageComments("No product information for this product ID");
                }

                if (productVO != null) {
                    if (hasNewVendor(productVO)) {
                        CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                        setOneTouchAndSeasons(productVO);
                        if (productVO.getCaseVOs() != null
                                && !productVO.getCaseVOs().isEmpty()) {
                            for (CaseVO caseVO : productVO.getCaseVOs()) {
                                setItemCategoryList(caseVO);
                            }
                        }
                        String validationMsg = validatePrintForm(productVO);

                        validationMsg = validationMsg.replace(
                                EDIConstants.NEXT_LINE,
                                EDIConstants.EMPTY_STRING).trim();

                        setCreateOnProduct(productVO);
                        if (CPSHelper.isEmpty(validationMsg)) {
                            productVO.clearUPCKitVOs();
                            productVO.setUpcKitVOs(this.getAddNewCandidateService().getKitComponents(prodId, false, true));
                            printFormVOList = PrintFormHelper
                                    .copyEDIEntityToEDIEntity(productVO, req
                                                    .getSession().getId() + prodId,
                                            req, resp, getCommonService(),
                                            getAddNewCandidateService(),
                                            hebLdapUserService);

                            // Add the forms to the final List
                            if (CPSHelper.isNotEmpty(printFormVOList)) {
                                int i = 0;
                                for (PrintFormVO prtForm : printFormVOList) {
                                    if (i != 0) {
                                        prtForm.setProductDescription(EDIConstants.EMPTY_STRING);
                                    }
                                    manageEDICandidate.getPrintFormVOList().add(
                                            prtForm);
                                    i++;
                                }
                            }
                        } else {
                            // Before doing the print form, validate it.
                            manageEDICandidate.setRejectClose(true);
                            manageEDICandidate
                                    .setRejectMessageComments(validationMsg);

                        }
                    } else {
                        manageEDICandidate.setRejectClose(true);
                        manageEDICandidate
                                .setRejectMessageComments("Please select candidate having at least one new vendor.");
                    }
                } else {
                    manageEDICandidate.setRejectClose(true);
                    manageEDICandidate
                            .setRejectMessageComments("Please select candidate having at least one new vendor.");
                }
            } else {
                manageEDICandidate.setRejectClose(true);
                manageEDICandidate
                        .setRejectMessageComments("Please select candidate having vendor");
            }
        }

        if (CPSHelper.isNotEmpty(manageEDICandidate.getPrintFormVOMRTList())
                || CPSHelper.isNotEmpty(manageEDICandidate.getPrintFormVOList())) {
            manageEDICandidate.setRejectClose(false);
            manageEDICandidate
                    .setRejectMessageComments(EDIConstants.EMPTY_STRING);
        }

        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    private PrintFormVO getSelectedVendorDescription(
            List<EDISearchResultVO> results, int selectedProductId) {
        PrintFormVO printFormVO = null;
        for (EDISearchResultVO searchResultVO : results) {
            if (selectedProductId == searchResultVO.getPsProdId()) {
                printFormVO = new PrintFormVO();
                printFormVO.setVendorName(searchResultVO.getPsVendName());
                printFormVO.setProductDescription(searchResultVO
                        .getDescriptionAndSizeDetailVO().getDescription());
                break;
            }
        }
        return printFormVO;
    }

    private boolean hasNewVendor(ProductVO productVO) {
        boolean retVal = false;
        List<UPCVO> upcList = productVO.getUpcVO();
        for (UPCVO upcvo : upcList) {
            if (upcvo.getNewDataSw() == 'Y') {
                retVal = true;
                return retVal;
            }
        }
        for (CaseVO caseVO : productVO.getCaseVOs()) {
            for (VendorVO vendorVO : caseVO.getVendorVOs()) {
                if (vendorVO.isEditable()) {
                    retVal = true;
                    break;
                }
            }
        }
        return retVal;
    }

    private void setOneTouchAndSeasons(ProductVO productVO) {
        List<BaseJSFVO> touchTypes = null;
        List<BaseJSFVO> seasons = null;
        if (productVO != null) {
            List<CaseVO> cases = productVO.getCaseVOs();
            if (CPSHelper.isNotEmpty(cases)) {
                for (CaseVO caseVO : cases) {
                    if (caseVO != null) {
                        if (caseVO.getChannel() != null
                                && (("V").equalsIgnoreCase(caseVO.getChannel()) || ("WHS")
                                .equalsIgnoreCase(caseVO.getChannel()))) {
                            if (CPSHelper.isEmpty(caseVO.getTouchTypeList())) {
                                if (touchTypes == null) {
                                    touchTypes = getAppContextFunctions()
                                            .getTouchTypeCodes();
                                }
                                caseVO.setTouchTypeList(touchTypes);
                            }
                        }
                        List<VendorVO> vendors = caseVO.getVendorVOs();
                        if (CPSHelper.isNotEmpty(vendors)) {
                            for (VendorVO vendorVO : vendors) {
                                if (vendorVO != null) {
                                    if (CPSHelper.isEmpty(vendorVO
                                            .getSeasonalityList())) {
                                        if (seasons == null) {
                                            seasons = getAppContextFunctions()
                                                    .getSeasonality();
                                        }
                                        vendorVO.setSeasonalityList(seasons);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private List<BaseJSFVO> setItemCategoryList(CaseVO caseVO) {
        List<BaseJSFVO> itemCategorys = null;
        if (CPSHelper.isEmpty(caseVO.getItemCategoryList())) {
            itemCategorys = getAppContextFunctions().getItemCategory();
            caseVO.setItemCategoryList(itemCategorys);
        }
        return itemCategorys;
    }

    private String validatePrintForm(ProductVO productVO) {
        String submitCheck = "";
        if (isVendor()) {
            submitCheck = SubmitValidator.mandatoryCheck(productVO);
        }
        return submitCheck;
    }

    private boolean isVendor() {
        String userRole = getUserRole();
        return (EDIConstants.UNREGISTERED_VENDOR_ROLE
                .equalsIgnoreCase(userRole) || EDIConstants.REGISTERED_VENDOR_ROLE
                .equalsIgnoreCase(userRole));
    }

    public void setCreateOnProduct(ProductVO productVO) {
        int workrequestId = productVO.getWorkRequest().getWorkIdentifier();
        try {
            List<PsCandidateStat> psCandidateStats = getAddNewCandidateService()
                    .getCandidateStatByworkId(workrequestId);
            if (null != psCandidateStats && !psCandidateStats.isEmpty()) {
                for (PsCandidateStat psCandidateStat : psCandidateStats) {
                    if (CPSHelper.getTrimmedValue(
                            psCandidateStat.getPsStat().getPdSetupStatCd())
                            .equals(BusinessConstants.WORKING_CODE)) {
                        productVO.setCreateOn(psCandidateStat.getId()
                                .getLstUpdtTs());
                        break;
                    } else {
                        productVO.setCreateOn(psCandidateStat.getId()
                                .getLstUpdtTs());
                    }
                }
            }
        } catch (Exception ex) {
            LOG.error(ex.getMessage(), ex);
        }
    }

	/*
	 * @author tuanle
	 *
	 * @Description ActionForward testScans
	 */

    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_TEST_SCANS)
    public ModelAndView testScans(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + EDI_TEST_SCAN);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            setForm(req, manageEDICandidate);
            boolean hasScannableUPC = false;
            manageEDICandidate.clearUPCVOs();
            ArrayList<String> productSelectedIds = new ArrayList<String>();
            String resultArray = (String) req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            StringTokenizer stCandidateTypeList = new StringTokenizer(
                    resultArray, CPSConstants.COMMA);
            while (stCandidateTypeList.hasMoreTokens()) {
                productSelectedIds.add(stCandidateTypeList.nextToken());
            }
            List<UPCVO> upcvoList = new ArrayList<UPCVO>();
            List<UPCVO> upcVO = getCommonService().getTestScanData(
                    productSelectedIds);

            for (UPCVO upcvo : upcVO) {
                upcvo.setUnitUpc(CPSHelper.getPadding(upcvo.getUnitUpc())
                        + CPSHelper.calculateCheckDigit(upcvo.getUnitUpc()));
            }
            upcvoList.addAll(upcVO);

            if (!upcvoList.isEmpty()) {
                hasScannableUPC = true;
            }

            for (UPCVO upcvo1 : upcvoList) {
                if ("UPC".equalsIgnoreCase(upcvo1.getUpcType())
                        || "HEB".equalsIgnoreCase(upcvo1.getUpcType())) {
                    manageEDICandidate.addUpcVOs(upcvo1);
                }
            }
            String userRole = getUserRole();
            if (BusinessConstants.ADMIN_ROLE.equalsIgnoreCase(userRole)
                    || BusinessConstants.PIA_LEAD_ROLE
                    .equalsIgnoreCase(userRole)) {
                manageEDICandidate.setTestScanUserSwitch(true);
            } else {
                manageEDICandidate.setTestScanUserSwitch(false);
            }

            if (manageEDICandidate.getUpcVOs().isEmpty()) {
                if (!hasScannableUPC) {
                    CPSMessage message = new CPSMessage(
                            "All UPC's of the selected Candidate have been Testscaned",
                            ErrorSeverity.INFO);
                    saveMessage(manageEDICandidate, message);
                } else {
                    CPSMessage message = new CPSMessage(
                            "Selected candidate(s) don't have UPC's for Testscan",
                            ErrorSeverity.INFO);
                    saveMessage(manageEDICandidate, message);
                }
            }

        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author tuanle
	 *
	 * @Description get Product Selected Ids
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_TEST_SCANS_AJAX)
    public ModelAndView testScansAjax(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + EDI_TEST_SCAN_AJAX);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            manageEDICandidate.clearUPCVOs();
            Object objProductId = req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            String productIdArray = manageEDICandidate.getProductSelectedIds();
            if (objProductId != null) {
                req.getSession().removeAttribute(
                        EDIConstants.EDI_PRODUCT_ID_SESSION);
            }

            req.getSession().setAttribute(EDIConstants.EDI_PRODUCT_ID_SESSION,
                    productIdArray);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author trungnv
	 *
	 * @Description save value base on current tab
	 *
	 * @Param ManageEDICandidate
	 *
	 * @return void
	 */
    private void update(ManageEDICandidate cpsEDIManageForm) throws Exception {
        int currentTab = 1;
        boolean isSave = false;
        String userRole = getUserRole();
        // selling UPC
        String status = "";
        status = getStatusCodeForUserRole();
        Map<String, String> allStatus = null;
        if (cpsEDIManageForm.getCurrentTab().equals(
                EDIConstants.SELLING_UPC_TAB)) {
            currentTab = 1;

            List<EDISearchResultVO> ediSearchResultLst = cpsEDIManageForm
                    .getEdiSearchResultVOLst();
            List<EDISearchResultVO> ediSearchResultLstTemp = cpsEDIManageForm
                    .getEdiSearchResultVOLstTemp();

            // check whenever have the row to save
            for (EDISearchResultVO searchResultVO : ediSearchResultLst) {
                if (searchResultVO.getSellingUPCDetailVO().isTobeSave()) {
                    isSave = true;
                    break;
                }
            }

            if (isSave) {
                try {
                    getCommonService().updateValues(ediSearchResultLst,
                            currentTab, userRole, getUserInfo().getUserName());
                    saveMessage(cpsEDIManageForm, new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_SUCCESSFULLY,
                            ErrorSeverity.INFO));
                } catch (Exception e) {
                    saveMessage(cpsEDIManageForm, new CPSMessage(
                            CPSConstants.ERROR_IN_SAVING + e.getMessage(),
                            ErrorSeverity.ERROR));
                    LOG.error(e.getMessage(), e);
                }
            }

            try {
                allStatus = getCommonService().getCandidateStatus();
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
                allStatus = null;
            }

            for (EDISearchResultVO searchResultVO : ediSearchResultLst) {
                int ixd = ediSearchResultLst.indexOf(searchResultVO);
                if (searchResultVO.getSellingUPCDetailVO().isTobeSave()
                        && !searchResultVO.getSellingUPCDetailVO()
                        .isSaveSuccess()) {
                    SellingUPCDetailVO sellingUPCDetailVO = ediSearchResultLstTemp
                            .get(ixd).getSellingUPCDetailVO();
                    searchResultVO.getSellingUPCDetailVO().setSubComCode(
                            sellingUPCDetailVO.getSubComCode());
                    searchResultVO.getSellingUPCDetailVO().setSubComName(
                            sellingUPCDetailVO.getSubComName());
                    searchResultVO.getSellingUPCDetailVO().setBdmCode(
                            sellingUPCDetailVO.getBdmCode());
                    searchResultVO.getSellingUPCDetailVO().setBdmCode(
                            sellingUPCDetailVO.getBdmName());
                } else {
                    if (searchResultVO.getSellingUPCDetailVO().isTobeSave()
                            && searchResultVO.getSellingUPCDetailVO()
                            .isSaveSuccess()) {
                        searchResultVO.setStatus(status);
                        if (allStatus != null && !allStatus.isEmpty()) {
                            searchResultVO.setStatusValue(allStatus
                                    .get(searchResultVO.getStatus()));
                        }
                    }

                }
            }

            // reset to init status
            for (EDISearchResultVO searchResultVO : ediSearchResultLst) {
                searchResultVO.getSellingUPCDetailVO().setTobeSave(false);
                searchResultVO.getSellingUPCDetailVO().setSaveSuccess(false);
            }

            cpsEDIManageForm.setEdiSearchResultVOLst(ediSearchResultLst);
            cpsEDIManageForm.setEdiSearchResultVOLstTemp(ediSearchResultLst);
        }
        // Cost And Retail
        if (cpsEDIManageForm.getCurrentTab().equals(
                EDIConstants.COST_RETAIL_TAB)) {
            currentTab = 4;
            updateCostAndRetailTab(cpsEDIManageForm, currentTab);
        }
        // other Attribute
        if (cpsEDIManageForm.getCurrentTab().equals(
                EDIConstants.OTHER_ATTRIBUTE_TAB)) {
            currentTab = 5;
            updateOtherAttributeTab(cpsEDIManageForm, currentTab);
        }
        // description And Size
        if (cpsEDIManageForm.getCurrentTab().equals(
                EDIConstants.DESCRIPTION_SIZE_TAB)) {
            currentTab = 2;
            updateDescriptionAndSizeTab(cpsEDIManageForm, currentTab);
        }
    }

    // save otherAttribute tab
    private void updateOtherAttributeTab(ManageEDICandidate cpsEDIManageForm,
                                         int currentTab) {

        String status = getStatusCodeForUserRole();
        Map<String, String> allStatus = null;
        try {
            if (cpsEDIManageForm.getListItemToUpdate() != null
                    && !cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                getCommonService().updateValues(
                        cpsEDIManageForm.getListItemToUpdate(), currentTab,
                        getUserRole(), getUserInfo().getUserName());
                try {
                    allStatus = getCommonService().getCandidateStatus();
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                    allStatus = null;
                }
                // update items is updated successful to form
                for (EDISearchResultVO eDISearchResultVO : cpsEDIManageForm
                        .getEdiSearchResultVOLst()) {
                    for (EDISearchResultVO itemUpdated : cpsEDIManageForm
                            .getListItemToUpdate()) {
                        if (itemUpdated.getPsItemId() != null
                                && CPSHelper.isNotEmpty(itemUpdated
                                .getPsItemId())) {
                            if (eDISearchResultVO.getPsItemId().equals(
                                    itemUpdated.getPsItemId())) {
                                eDISearchResultVO.setStatus(status);
                                if (allStatus != null && !allStatus.isEmpty()) {
                                    eDISearchResultVO
                                            .setStatusValue(allStatus
                                                    .get(eDISearchResultVO
                                                            .getStatus()));
                                }
                                if (itemUpdated.getOtherAttributeDetailVO()
                                        .getInboundSpecDays() != null)
                                    eDISearchResultVO
                                            .getOtherAttributeDetailVO()
                                            .setInboundSpecDays(
                                                    itemUpdated
                                                            .getOtherAttributeDetailVO()
                                                            .getInboundSpecDays());
                                if (itemUpdated.getOtherAttributeDetailVO()
                                        .getReactionDays() != null)
                                    eDISearchResultVO
                                            .getOtherAttributeDetailVO()
                                            .setReactionDays(
                                                    itemUpdated
                                                            .getOtherAttributeDetailVO()
                                                            .getReactionDays());
                                if (itemUpdated.getOtherAttributeDetailVO()
                                        .getGuaranteeToStoreDays() != null)
                                    eDISearchResultVO
                                            .getOtherAttributeDetailVO()
                                            .setGuaranteeToStoreDays(
                                                    itemUpdated
                                                            .getOtherAttributeDetailVO()
                                                            .getGuaranteeToStoreDays());
                                if (eDISearchResultVO.getPsVendno() != null) {
                                    if (eDISearchResultVO.getPsVendno().equals(
                                            itemUpdated.getPsVendno())
                                            && eDISearchResultVO
                                            .getChannel()
                                            .equalsIgnoreCase(
                                                    itemUpdated
                                                            .getChannel())) {
                                        if (itemUpdated
                                                .getOtherAttributeDetailVO()
                                                .getSeasonalityYear() != null)
                                            eDISearchResultVO
                                                    .getOtherAttributeDetailVO()
                                                    .setSeasonalityYear(
                                                            itemUpdated
                                                                    .getOtherAttributeDetailVO()
                                                                    .getSeasonalityYear());
                                        if (itemUpdated
                                                .getOtherAttributeDetailVO()
                                                .getSeasonality() != null)
                                            eDISearchResultVO
                                                    .getOtherAttributeDetailVO()
                                                    .setSeasonality(
                                                            itemUpdated
                                                                    .getOtherAttributeDetailVO()
                                                                    .getSeasonality());
                                        if (itemUpdated
                                                .getOtherAttributeDetailVO()
                                                .getSeasonalityName() != null)
                                            eDISearchResultVO
                                                    .getOtherAttributeDetailVO()
                                                    .setSeasonalityName(
                                                            itemUpdated
                                                                    .getOtherAttributeDetailVO()
                                                                    .getSeasonalityName());

                                        break;
                                    }
                                }
                            }
                        }

                    }
                }

                CPSMessage message;
                if (!cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_SUCCESSFULLY,
                            ErrorSeverity.INFO);
                } else {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_FAILED,
                            ErrorSeverity.ERROR);
                }

                saveMessage(cpsEDIManageForm, message);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(cpsEDIManageForm,
                    new CPSMessage(CPSConstants.ERROR_IN_SAVING + e.getMessage(),
                            ErrorSeverity.ERROR));
        }

        // reset listItemToUpdate
        cpsEDIManageForm.setListItemToUpdate(null);
    }

    // update data for Cost And Retail Tab
	/*
	 * @author nghianguyen
	 *
	 * @Description update for Cost And retail Tab
	 *
	 * @Param cpsEDIManageForm and current tab = 4
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_APPROVE_DSD)
    public ModelAndView approveDSD(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        setForm(req, manageEDICandidate);
        approveDSDDiscontinue(manageEDICandidate);

        // set current page is selected for grid
        manageEDICandidate.setCurrentPage(1);

        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;

    }

    private void approveDSDDiscontinue(ManageEDICandidate cpsEDIManageForm) {
        try {
            if (cpsEDIManageForm.getListItemToUpdate() != null
                    && !cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                getCommonService().approveDSDDiscontinue(
                        cpsEDIManageForm.getListItemToUpdate(),
                        cpsEDIManageForm.getUserRole());
                getCommonService().approveDSDWS("TRGRCPSA");
                getCommonService().updateDataForDsdDiscontinue(
                        cpsEDIManageForm.getListItemToUpdate());
                for (int i = 0; i < cpsEDIManageForm.getEdiSearchResultVOLst()
                        .size(); i++) {
                    EDISearchResultVO ediSearchResultVO = cpsEDIManageForm
                            .getEdiSearchResultVOLst().get(i);
                    for (EDISearchResultVO itemUpdated : cpsEDIManageForm
                            .getListItemToUpdate()) {
                        if (itemUpdated.getPsWorkId() != null
                                && CPSHelper.isNotEmpty(itemUpdated
                                .getPsWorkId())) {
                            if (ediSearchResultVO.getPsWorkId().equals(
                                    itemUpdated.getPsWorkId())) {
                                cpsEDIManageForm.getEdiSearchResultVOLst()
                                        .remove(i);
                                i -= 1;
                                break;
                            }
                        }
                    }
                }
                CPSMessage message;
                if (!cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                    message = new CPSMessage(
                            " Candidate(s) Submitted Successfully.The Candidates Will Be Approved Once The Mainframe Job Runs.",
                            ErrorSeverity.INFO);
                } else {
                    message = new CPSMessage("Failed to Submit for approval",
                            ErrorSeverity.ERROR);
                }
                saveMessage(cpsEDIManageForm, message);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(cpsEDIManageForm, new CPSMessage(" Error in Approve : "
                    + e.getMessage(), ErrorSeverity.ERROR));
        }
        // reset listItemToUpdate
        cpsEDIManageForm.setListItemToUpdate(null);
    }

    private void updateCostAndRetailTab(ManageEDICandidate cpsEDIManageForm,
                                        int currentTab) {
        String status = getStatusCodeForUserRole();
        Map<String, String> allStatus = null;
        try {
            if (cpsEDIManageForm.getListItemToUpdate() != null
                    && !cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                getCommonService().updateValues(
                        cpsEDIManageForm.getListItemToUpdate(), currentTab,
                        getUserRole(), getUserInfo().getUserName());
                try {
                    allStatus = getCommonService().getCandidateStatus();
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                    allStatus = null;
                }
                // update items is updated successful to form
                for (EDISearchResultVO eDISearchResultVO : cpsEDIManageForm
                        .getEdiSearchResultVOLst()) {
                    for (EDISearchResultVO itemUpdated : cpsEDIManageForm
                            .getListItemToUpdate()) {
                        if (itemUpdated.getPsProdId() != null
                                && CPSHelper.isNotEmpty(itemUpdated
                                .getPsProdId())) {
                            if (eDISearchResultVO.getPsProdId().equals(
                                    itemUpdated.getPsProdId())
                                    && eDISearchResultVO
                                    .getCostAndRetailDetailVO()
                                    .getUnitCost()
                                    .equals(itemUpdated
                                            .getCostAndRetailDetailVO()
                                            .getUnitCost())
                                    && eDISearchResultVO
                                    .getCostAndRetailDetailVO()
                                    .getListCost()
                                    .equals(itemUpdated
                                            .getCostAndRetailDetailVO()
                                            .getListCost())) {
                                eDISearchResultVO.setStatus(status);
                                if (allStatus != null && !allStatus.isEmpty()) {
                                    eDISearchResultVO
                                            .setStatusValue(allStatus
                                                    .get(eDISearchResultVO
                                                            .getStatus()));
                                }
                                if (!("").equals(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getActualRetail())
                                        && CPSHelper.isNotEmpty(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getActualRetail())) {
                                    DecimalFormat df2 = new DecimalFormat(
                                            "#########0.00");
                                    String aTR = df2
                                            .format(Double.parseDouble(df2.format(Double
                                                    .valueOf(itemUpdated
                                                            .getCostAndRetailDetailVO()
                                                            .getActualRetail()))));
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setActualRetail(aTR);
                                } else {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setActualRetail("");
                                }
                                if (!("").equals(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getActualMultipleRetail())
                                        && CPSHelper.isNotEmpty(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getActualMultipleRetail())) {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setActualMultipleRetail(
                                                    itemUpdated
                                                            .getCostAndRetailDetailVO()
                                                            .getActualMultipleRetail());
                                } else {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setActualMultipleRetail("");
                                }
                                if (!("").equals(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getRetailLink())
                                        && CPSHelper.isNotEmpty(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getRetailLink())) {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setRetailLink(
                                                    itemUpdated
                                                            .getCostAndRetailDetailVO()
                                                            .getRetailLink());
                                } else {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setRetailLink("");
                                }
                                if (!("").equals(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getPennyProfit())
                                        && CPSHelper.isNotEmpty(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getPennyProfit())) {
                                    DecimalFormat df2 = new DecimalFormat(
                                            "#########0.00");
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setPennyProfit(
                                                    df2.format(Double
                                                            .valueOf(itemUpdated
                                                                    .getCostAndRetailDetailVO()
                                                                    .getPennyProfit())));
                                } else {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setPennyProfit("");
                                }
                                if (!("").equals(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getPercentageMargin())
                                        && CPSHelper.isNotEmpty(itemUpdated
                                        .getCostAndRetailDetailVO()
                                        .getPercentageMargin())) {
                                    DecimalFormat df2 = new DecimalFormat(
                                            "#########0.00");
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setPercentageMargin(
                                                    df2.format(Double
                                                            .valueOf(itemUpdated
                                                                    .getCostAndRetailDetailVO()
                                                                    .getPercentageMargin())));
                                } else {
                                    eDISearchResultVO
                                            .getCostAndRetailDetailVO()
                                            .setPercentageMargin("");
                                }

                            }
                        }
                    }
                }

                CPSMessage message;
                if (!cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                    message = new CPSMessage("Updated successfully",
                            ErrorSeverity.INFO);
                } else {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_FAILED,
                            ErrorSeverity.ERROR);
                }

                saveMessage(cpsEDIManageForm, message);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(cpsEDIManageForm,
                    new CPSMessage(CPSConstants.ERROR_IN_SAVING + e.getMessage(),
                            ErrorSeverity.ERROR));
        }

        // reset listItemToUpdate
        cpsEDIManageForm.setListItemToUpdate(null);
    }

    /*
	 * @author tuanle
	 *
	 * @Description update form for Description And Size Tab
	 *
	 * @Param cpsEDIManageForm and current tab = 2
	 */
    private void updateDescriptionAndSizeTab(ManageEDICandidate cpsEDIManageForm,
                                             int currentTab) {
        String status = getStatusCodeForUserRole();
        Map<String, String> allStatus = null;
        try {
            if (cpsEDIManageForm.getListItemToUpdate() != null
                    && !cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                getCommonService().updateValues(
                        cpsEDIManageForm.getListItemToUpdate(), currentTab,
                        getUserRole(), getUserInfo().getUserName());
                try {
                    allStatus = getCommonService().getCandidateStatus();
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                    allStatus = null;
                }
                // update items is updated successful to form
                for (EDISearchResultVO eDISearchResultVO : cpsEDIManageForm
                        .getEdiSearchResultVOLst()) {
                    for (EDISearchResultVO itemUpdated : cpsEDIManageForm
                            .getListItemToUpdate()) {
                        if (itemUpdated.getPsProdId() != null
                                && CPSHelper.isNotEmpty(itemUpdated
                                .getPsProdId())) {
                            if (eDISearchResultVO.getPsProdId().equals(
                                    itemUpdated.getPsProdId())) {
                                eDISearchResultVO.setStatus(status);
                                if (allStatus != null && !allStatus.isEmpty()) {
                                    eDISearchResultVO
                                            .setStatusValue(allStatus
                                                    .get(eDISearchResultVO
                                                            .getStatus()));
                                }
                                eDISearchResultVO
                                        .getDescriptionAndSizeDetailVO()
                                        .setDescription(
                                                itemUpdated
                                                        .getDescriptionAndSizeDetailVO()
                                                        .getDescription());
                                eDISearchResultVO.setProdEnglishDes(itemUpdated
                                        .getDescriptionAndSizeDetailVO()
                                        .getDescription());
                                eDISearchResultVO
                                        .getSellingUPCDetailVO()
                                        .setDescription(
                                                itemUpdated
                                                        .getDescriptionAndSizeDetailVO()
                                                        .getDescription());
                                eDISearchResultVO
                                        .getDescriptionAndSizeDetailVO()
                                        .setCfd1(
                                                itemUpdated
                                                        .getDescriptionAndSizeDetailVO()
                                                        .getCfd1());
                                if (CPSHelper.isNotEmpty(itemUpdated
                                        .getDescriptionAndSizeDetailVO()
                                        .getCfd2()))
                                    eDISearchResultVO
                                            .getDescriptionAndSizeDetailVO()
                                            .setCfd2(
                                                    itemUpdated
                                                            .getDescriptionAndSizeDetailVO()
                                                            .getCfd2());
                                else
                                    eDISearchResultVO
                                            .getDescriptionAndSizeDetailVO()
                                            .setCfd2("");
                                eDISearchResultVO
                                        .getDescriptionAndSizeDetailVO()
                                        .setSizeText(
                                                itemUpdated
                                                        .getDescriptionAndSizeDetailVO()
                                                        .getSizeText());
                                break;

                            }
                        }
                    }
                }

                CPSMessage message;
                if (!cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_SUCCESSFULLY,
                            ErrorSeverity.INFO);
                } else {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_FAILED,
                            ErrorSeverity.ERROR);
                }

                saveMessage(cpsEDIManageForm, message);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(cpsEDIManageForm,
                    new CPSMessage(CPSConstants.ERROR_IN_SAVING + e.getMessage(),
                            ErrorSeverity.ERROR));
        }

        // reset listItemToUpdate
        cpsEDIManageForm.setListItemToUpdate(null);
    }

    /**
     * @author trungnv (VODC)
     * @des Active Candidates is NON_MRT
     * @param workId
     *            workrequestId
     * @param productId
     *            id of candidates that user selected to active.
     * @param List
     *            <Integer> activatedWorkIdList contain ids of candidates
     *            activated successfully.
     * @param StringBuffer
     *            checkMessage Contain message information(error, successfully).
     * @return
     */
    @RequestMapping(method = {RequestMethod.POST}, value = ManageEDIMainController.RELATIVE_PATH_ACTIVE)
    public ModelAndView activate(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        setForm(req, manageEDICandidate);
        // set current page is selected for grid
        manageEDICandidate.setCurrentPage(1);
        String inputSource = manageEDICandidate.getEdiSearchResultVOLst().get(0)
                .getInputSource();
        List<Integer> activatedWorkIdListCadidates = new ArrayList<Integer>();

        // list active fail
        List<Integer> activatedFailWorkIdListCadidates = new ArrayList<Integer>();
        // list working candidate
        List<Integer> activatedToWorkingWorkIdListCadidates = new ArrayList<Integer>();
        StringBuffer checkCadidatesMessage = new StringBuffer();
        CPSMessage message;
        checkCadidatesMessage.append(CPSConstants.EMPTY_STRING);
        // get List psWorkId from GUI
        String psWorkIdLst = manageEDICandidate.getPsWorkSelectedIds();
        String psProdIdLst = manageEDICandidate.getProductSelectedIds();
        //AddNewCandidateAction action = new AddNewCandidateAction();
        ConvertStrToObjVO temp = new ConvertStrToObjVO();
        temp.setArrStr1(psWorkIdLst);
        temp.setArrStr2(psProdIdLst);
        List<ConvertStrToObjVO> lstObj = temp.convertToOBJ();
        try {
            // pass to activateCandidate function
            if (("CPS").equals(inputSource.trim().toUpperCase())) {
                for (ConvertStrToObjVO convertStrToObjVO : lstObj) {
                    int workId = Integer.parseInt(convertStrToObjVO.getProperty1());
                    String prodId = convertStrToObjVO.getProperty2();
                    activateSingleEntryCandidate(workId, prodId,
                            activatedWorkIdListCadidates, checkCadidatesMessage,
                            activatedFailWorkIdListCadidates,
                            activatedToWorkingWorkIdListCadidates,
                            manageEDICandidate, this.getLstVendorId(req));
                }
            } else {
                // active batch upload candidate
                activateBatchUploadCandidate(activatedWorkIdListCadidates, lstObj,
                        checkCadidatesMessage, manageEDICandidate,
                        activatedFailWorkIdListCadidates,
                        activatedToWorkingWorkIdListCadidates,
                        this.getLstVendorId(req));
            }
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
            checkCadidatesMessage.append(e.getMessage());
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            checkCadidatesMessage.append(e.getMessage());
        }
        // add message to UI
        int activatedWorkIdListCadidatesLenght = 0;
        activatedWorkIdListCadidatesLenght = activatedWorkIdListCadidates
                .size();

        if (("CPS").equals(inputSource.trim().toUpperCase())) {
            List<Integer> activatedWorkIdList = new ArrayList<Integer>();
            if (activatedWorkIdListCadidatesLenght > 0) {

                if (activatedWorkIdListCadidatesLenght > 0) {
                    activatedWorkIdList.addAll(activatedWorkIdListCadidates);
                }
                req.setAttribute(CPSConstants.MESSAGETITLE, CPSConstants.ACTIVATED_TITLE);
                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, "Y");
                if (activatedWorkIdList.size() == 1) {
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "Y");
                } else {
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "N");
                }
                req.getSession().setAttribute(CPSConstants.ACTIVATED_WORK_IDS,
                        activatedWorkIdList);
                req.getSession().setAttribute(CPSConstants.CHECK_ACTIVED_FAIL, true);
            } else {
                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, "N");
            }

            String checkMessage = checkCadidatesMessage.toString();
            if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(checkMessage
                    .replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING)
                    .trim())) {
                message = new CPSMessage(CPSConstants.CANDIDATES_ACTIVATED_SUCCESSFULLY,
                        ErrorSeverity.INFO);
            } else {

                message = new CPSMessage(checkMessage, ErrorSeverity.ERROR);
            }

        } else {
            req.getSession().setAttribute("isBatchActiv", "Y");
            if (!activatedWorkIdListCadidates.isEmpty()) {
                req.setAttribute(CPSConstants.MESSAGETITLE, CPSConstants.SUBMITTED_TITLE);
                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, "Y");
                if (activatedWorkIdListCadidates.size() == 1) {
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "Y");
                } else {
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "N");
                }
                req.getSession().setAttribute(CPSConstants.ACTIVATED_WORK_IDS,
                        activatedWorkIdListCadidates);
                req.getSession().setAttribute(CPSConstants.CHECK_ACTIVED_FAIL, false);
                // call trigger when active batch upload candidate.
                try {
                    getCommonService().approveDSDWS("CPSA");
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                }

            } else {
                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, "N");
            }
            if (CPSConstants.EMPTY_STRING
                    .equalsIgnoreCase(checkCadidatesMessage
                            .toString()
                            .replace(CPSConstants.NEXT_LINE,
                                    CPSConstants.EMPTY_STRING).trim())) {
                message = new CPSMessage(CPSConstants.CANDIDATES_SUBMITTED_SUCCESSFULLY,
                        ErrorSeverity.INFO);
            } else {

                message = new CPSMessage(checkCadidatesMessage.toString(),
                        ErrorSeverity.ERROR);
            }

        }
        saveMessage(manageEDICandidate, message);

        // remove active candidate in current result

        // Edit ManageEDICandidate to remove activate candidate
        List<EDISearchResultVO> searchResultVOLst = new ArrayList<EDISearchResultVO>();
        List<EDISearchResultVO> searchResultVOLstTemp = manageEDICandidate
                .getEdiSearchResultVOLst();
        List<EDISearchResultVO> searchResultVOLstReal = new ArrayList<EDISearchResultVO>();

        for (int psWrkId : activatedWorkIdListCadidates) {
            for (EDISearchResultVO searchResultVO : searchResultVOLstTemp) {
                int wrkId = searchResultVO.getPsWorkId();
                if (psWrkId == wrkId) {
                    searchResultVOLst.add(searchResultVO);
                }
            }
        }

        for (EDISearchResultVO searchResultVO : searchResultVOLstTemp) {
            if (!searchResultVOLst.contains(searchResultVO)) {
                searchResultVOLstReal.add(searchResultVO);
            }
        }

        // change status when active fail to current form result

        changeStatusOfFormWhenActive(searchResultVOLstReal,
                activatedFailWorkIdListCadidates, CPSConstants.ACTIVATION_FAILURE_CODE);
        // change status when active fail to current form result
        changeStatusOfFormWhenActive(searchResultVOLstReal,
                activatedToWorkingWorkIdListCadidates, CPSConstants.WORKING);

        manageEDICandidate.setEdiSearchResultVOLst(searchResultVOLstReal);
        manageEDICandidate.setPsWrkActiveFailSelectedId("");
        this.setDataAutoCompltete(manageEDICandidate,req);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
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
     * @author trungnv (VODC)
     * @des Active Candidates belong on Batch Upload
     * @param List
     *            <Integer> activatedWorkIdList contain ids of candidates
     *            activated successfully.
     * @param List
     *            <ConvertStrToObjVO> results contain candidates that user
     *            searched.
     * @param StringBuffer
     *            checkMessage Contain message information(error, successfully).
     * @return
     */
    public void activateBatchUploadCandidate(List<Integer> activatedWorkIdList,
                                             List<ConvertStrToObjVO> results, StringBuffer checkMessage,
                                             ManageEDICandidate cpsEDIManageForm,
                                             List<Integer> activatedFailWorkIdListCadidates,
                                             List<Integer> activatedToWorkingWorkIdListCadidates,
                                             List<Integer> lstVendor) throws Exception {

        String psWrkIdActiveFail = cpsEDIManageForm
                .getPsWrkActiveFailSelectedId();
        List<String> tempArr = new ArrayList<String>();
        if (!psWrkIdActiveFail.isEmpty()) {
            String[] arrStr = psWrkIdActiveFail.split(",");

            for (int i = 0; i < arrStr.length; i++) {
                if (!tempArr.contains(arrStr[i])) {
                    tempArr.add(arrStr[i]);
                }
            }
        }
        for (ConvertStrToObjVO convertStrToObjVO : results) {
            int workId = Integer.parseInt(convertStrToObjVO.getProperty1());
            String prodId = convertStrToObjVO.getProperty2();
            if (!tempArr.contains(convertStrToObjVO.getProperty1())) {
                ArrayList<String> temp = new ArrayList<String>();
                temp.add(prodId);

                // calidate testscan
                try {
                String mess = getAddNewCandidateService()
                        .activateBatUploadValidator(workId, prodId,
                                getUserRole());
                if (CPSHelper.isEmpty(mess)) {
                    // validate retail and retail for
                        String workStatus = null;
                        workStatus = BusinessConstants.ACTIVATE_BATCHUPLOAD_CODE;
                        getAddNewCandidateService().changeWorkStatus(workId,
                                workStatus);
                        getCommonService().updateBatchUploadCandidateStatus(
                                workId, getUserInfo().getUserName());
                        /**
                         * Candidate Activated Successfully. Preserve the
                         * workId.
                         */
                        activatedWorkIdList.add(workId);

                } else {
                    checkMessage.append(" [Product Description :"
                            + getDescriptionByProId(
                            cpsEDIManageForm.getEdiSearchResultVOLst(),
                            prodId) + "] " + mess);
                }
                } catch (CPSBusinessException e) {
                    LOG.error(e.getMessage(), e);
                    getAddNewCandidateService().changeWorkStatus(workId,
                            BusinessConstants.ACTIVATION_FAILURE_CODE);
                    activatedFailWorkIdListCadidates.add(workId);
                    List<CPSMessage> list = e.getMessages();
                    for (CPSMessage errMsg : list) {
                        checkMessage.append(errMsg.getMessage());
                    }
                }catch (CPSGeneralException e) {
                    LOG.error(e.getMessage(), e);
                    getAddNewCandidateService().changeWorkStatus(workId,
                            BusinessConstants.ACTIVATION_FAILURE_CODE);
                    activatedFailWorkIdListCadidates.add(workId);
                    checkMessage.append(e.getMessage());
                }catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                    getAddNewCandidateService().changeWorkStatus(workId,
                            BusinessConstants.ACTIVATION_FAILURE_CODE);
                    activatedFailWorkIdListCadidates.add(workId);
                    checkMessage.append(e.getMessage());
                }
            } else {
                activateSingleEntryCandidate(workId, prodId,
                        activatedWorkIdList, checkMessage,
                        activatedFailWorkIdListCadidates,
                        activatedToWorkingWorkIdListCadidates,
                        cpsEDIManageForm, lstVendor);
            }

        }

    }

    /**
     * @author trungnv (VODC)
     * @des get information for pop up when active success
     * @return
     */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_ACTIVATION_MESSAGE)
    public ModelAndView activationMessage(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        manageEDICandidate.setSession(req.getSession());
        keepSearchCriteriaList(req.getSession(),  manageEDICandidate);
        setForm(req, manageEDICandidate);
        List<Integer> activatedWorkIdList = (List<Integer>) req.getSession()
                .getAttribute(CPSConstants.ACTIVATED_WORK_IDS);
        req.getSession().removeAttribute(CPSConstants.ACTIVATED_WORK_IDS);
        Boolean activateFail = (Boolean) req.getSession().getAttribute(
                CPSConstants.CHECK_ACTIVED_FAIL);

        String isBatchActive = (String) req.getSession().getAttribute(
                "isBatchActiv");
        req.getSession().removeAttribute(CPSConstants.CHECK_ACTIVED_FAIL);
        String strJSON = "";
        if (activatedWorkIdList.size() == 1) {
            req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "Y");
        } else {
            req.setAttribute("SINGLE_ACTIVATION", "N");
        }
        if (CPSHelper.isNotEmpty(isBatchActive)
                && ("Y").equals(isBatchActive.trim().toUpperCase())
                && !activateFail) {
            strJSON = getJSONForProductBatUpload(activatedWorkIdList);
        } else {
            String close = "]}}";
            String rows = "";
            strJSON = "{\"ResultSet\":{\"recordsReturned\":1,\"totalRecords\":1, \"startIndex\":0, \"sort\":null, \"dir\":\"asc\",";
            strJSON += "\"records\":[";
            rows = rows + getJSONForProduct(activatedWorkIdList);
            rows = rows.substring(0, rows.length() - 1);
            strJSON += rows + close;

        }
        resp.getWriter().write(strJSON);
        return null;
    }

    private String getJSONForProduct(List<Integer> activatedWorkIdList) {
        String row4 = "";
        try {
            List<ActivationMessageVO> activationMessageVOList = getCommonService()
                    .getActivationInfo(activatedWorkIdList);
            Iterator<ActivationMessageVO> activationMessageVOIterator = activationMessageVOList
                    .iterator();
            while (activationMessageVOIterator.hasNext()) {
                ActivationMessageVO activationMessageVO = activationMessageVOIterator
                        .next();
                String itemInfo = getItemInfo(activationMessageVO
                        .getItemCodes());
                String upcInfo = getUPC(activationMessageVO.getUpc());
                row4 += "{\"code\":\"Product Id :\", \"desc\":\""
                        + activationMessageVO.getProductID().toString()
                        + "\"},";
                row4 += "{\"code\":\"Product Description :\",  \"desc\":\""
                        + CPSHelper.correctDQuotes(activationMessageVO
                        .getProductDesc()) + "\"},";
                row4 += "{\"code\":\"Item Code(s) :\",\"desc\":\"" + itemInfo
                        + "\"},";
                row4 += "{\"code\":\"UPC(s) :\",\"desc\":\"" + upcInfo + "\"},";
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        return row4;
    }

    private String getUPC(List<String> upcInfo) {
        String returnVal = "";
        for (final String upc : upcInfo) {
            returnVal = returnVal + upc + "-" + CPSHelper
                    .getCheckDigit(upc) +"<br>";
        }
        return returnVal;
    }

    private String getItemInfo(List<String> itemInfo) {
        String returnVal = "";
        for (final String strItem : itemInfo) {
            returnVal = returnVal + CPSHelper.correctDQuotes(strItem) + "<br>";
        }
        return returnVal;
    }

    /**
     * @author trungnv (VODC)
     * @des get information of candidates.
     * @param List
     *            <Integer> activatedWorkIdList contain ids of candidates
     *            activated successfully.
     * @return String
     */
    private String getJSONForProductBatUpload(List<Integer> activatedWorkIdList) {
        String jsonString = "{\"ResultSet\":{\"recordsReturned\":1,\"totalRecords\":1, \"startIndex\":0, \"sort\":null, \"dir\":\"asc\",";
        jsonString += "\"records\":[";
        String row4 = "";
        try {
            List<ActivationMessageVO> activationMessageVOList = getCommonService()
                    .getBatchUploadSubmissionInfo(activatedWorkIdList);
            Iterator<ActivationMessageVO> activationMessageVOIterator = activationMessageVOList
                    .iterator();
            while (activationMessageVOIterator.hasNext()) {
                ActivationMessageVO activationMessageVO = activationMessageVOIterator
                        .next();
                String itemInfo = getItemInfo(activationMessageVO
                        .getItemCodes());
                String upcInfo = getUPC(activationMessageVO.getUpc());
                row4 += "{\"code\":\"Candidate Id :\", \"desc\":\""
                        + activationMessageVO.getProductID().toString()
                        + "\"},";
                row4 += "{\"code\":\"Candidate Description :\",  \"desc\":\""
                        + CPSHelper.correctDQuotes(activationMessageVO
                        .getProductDesc()) + "\"},";
                row4 += "{\"code\":\"Candidate Item Code(s) :\",\"desc\":\""
                        + itemInfo + "\"},";
                row4 += "{\"code\":\"UPC(s) :\",\"desc\":\"" + upcInfo + "\"},";
            }

            row4 = row4.substring(0, row4.length() - 1);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        String close = "]}}";
        return jsonString + row4 + close;
    }

    private void changeStatusOfFormWhenActive(
            List<EDISearchResultVO> searchResultVOLstReal,
            List<Integer> activatedTemplst, String code) {
        Map<String, String> allStatus = null;
        try {
            allStatus = getCommonService().getCandidateStatus();
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            allStatus = null;
        }
        for (int psWrkWrking : activatedTemplst) {
            for (EDISearchResultVO searchResultVO : searchResultVOLstReal) {
                if (searchResultVO.getPsWorkId().intValue() == psWrkWrking) {
                    searchResultVO.setStatus(code);
                    if (allStatus != null && !allStatus.isEmpty()) {
                        searchResultVO.setStatusValue(allStatus
                                .get(searchResultVO.getStatus()));
                    }
                }
            }
        }
    }

    private void updateDiscontinue(ManageEDICandidate cpsEDIManageForm) {
        try {
            if (cpsEDIManageForm.getListItemToUpdate() != null
                    && !cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                getCommonService().updateDataForDsdDiscontinue(
                        cpsEDIManageForm.getListItemToUpdate());

                for (EDISearchResultVO eDISearchResultVO : cpsEDIManageForm
                        .getEdiSearchResultVOLst()) {
                    for (EDISearchResultVO itemUpdated : cpsEDIManageForm
                            .getListItemToUpdate()) {
                        if (itemUpdated.getPsItemId() != null
                                && CPSHelper.isNotEmpty(itemUpdated
                                .getPsItemId())) {
                            if (eDISearchResultVO.getPsItemId().equals(
                                    itemUpdated.getPsItemId())) {
                                eDISearchResultVO
                                        .setDiscontinueDate(itemUpdated
                                                .getDiscontinueDate());
                                break;
                            }
                        }
                    }
                }

                CPSMessage message;
                if (cpsEDIManageForm.getListItemToUpdate().isEmpty()) {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_FAILED,
                            ErrorSeverity.ERROR);
                } else {
                    message = new CPSMessage(
                            EDIConstants.CANDIDATE_SAVED_SUCCESSFULLY,
                            ErrorSeverity.INFO);
                }
                saveMessage(cpsEDIManageForm, message);

                // reset listItemToUpdate
                cpsEDIManageForm.setListItemToUpdate(null);
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(cpsEDIManageForm,
                    new CPSMessage(CPSConstants.ERROR_IN_SAVING + e.getMessage(),
                            ErrorSeverity.ERROR));
        }
    }

    /*
	 * @author : nhatnc
	 *
	 * @Description : update discontinueDate for DSD Discontinue
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_UPDATE_DSD_DISCONTINUE)
    public ModelAndView updateDsdDiscontinue(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        manageEDICandidate.setSession(req.getSession());
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        setForm(req, manageEDICandidate);
        updateDiscontinue(manageEDICandidate);

        if (req.getParameter("isSaveExit") != null
                && "1".equals(req.getParameter("isSaveExit").toString())) {
            model = new ModelAndView(RELATIVE_PATH_EDI_MAIN_BASE + RELATIVE_PATH_EDIT_SEARCH_WRAPPER);
            model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
            return model;
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

	/*
	 * @author nhatnc
	 *
	 * @Description ActionForward UPS Authorized Stores
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_AUTHORIZED_STORE)
    public ModelAndView authorizedStore(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + AUTHORIZED_STORES);
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            manageEDICandidate.setSession(req.getSession());
            manageEDICandidate.setUpcStoreAuthorization(null);

            String resultArray = (String) req.getSession().getAttribute(
                    EDIConstants.ITEMS_SELECTED_SESSION);
            StringTokenizer stSelectedItemList = new StringTokenizer(
                    resultArray, CPSConstants.COMMA);

            if (stSelectedItemList.hasMoreTokens()) {
                String item = stSelectedItemList.nextToken();
                VendorVO vendorVO = new VendorVO();
                vendorVO.setPsItemId(Integer.parseInt(item.split("-")[0]));
                vendorVO.setVendorLocNumber(Integer.parseInt(item.split("-")[1]));
                vendorVO.setChannel("D"); // only DSD

                String upcNo = item.split("-")[2];

                UpcStoreAuthorizationVO upcStoreAuthorizationVO = getCommonService()
                        .getUpcStoreAuthorization(vendorVO);

                for (EDISearchResultVO ediSearchResultVO : manageEDICandidate
                        .getEdiSearchResultVOLst()) {
                    if (ediSearchResultVO.getPsItemId().equals(
                            String.valueOf(vendorVO.getPsItemId()))
                            && ediSearchResultVO.getPsVendno().equals(
                            String.valueOf(vendorVO
                                    .getVendorLocNumber()))
                            && ediSearchResultVO.getUpcNo().equals(upcNo)) {
                        upcStoreAuthorizationVO.setUpcNo(ediSearchResultVO
                                .getUpcNo());
                        upcStoreAuthorizationVO
                                .setDescription(ediSearchResultVO
                                        .getUpcDescription() != null ? ediSearchResultVO
                                        .getUpcDescription() : "");
                        upcStoreAuthorizationVO.setPsVendno(ediSearchResultVO
                                .getPsVendno());
                        upcStoreAuthorizationVO.setPsVendName(ediSearchResultVO
                                .getPsVendName());
                        break;
                    }
                }

                manageEDICandidate
                        .setUpcStoreAuthorization(upcStoreAuthorizationVO);
            }

        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author nhatnc
	 *
	 * @Description get items is selected on DSD Discontinue page
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_AUTHORIZED_STORE_AJAX)
    public ModelAndView authorizedStoreAjax(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_MODULE + AUTHORIZED_STORES_AJAX);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);

            Object objSelectedItems = req.getSession().getAttribute(
                    EDIConstants.ITEMS_SELECTED_SESSION);
            String arrSelectedItems = manageEDICandidate.getSelectedItems();
            if (objSelectedItems != null) {
                req.getSession().removeAttribute(
                        EDIConstants.ITEMS_SELECTED_SESSION);
            }
            req.getSession().setAttribute(EDIConstants.ITEMS_SELECTED_SESSION,
                    arrSelectedItems);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

	/*
	 * @author tuanle
	 *
	 * @Description remove Delected Candidate
	 */

    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_REMOVE_REJECTED_CANDIDATE)
    public ModelAndView removeRejectedCandidate(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null) {
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            }
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
            Map<String, String> allStatus = null;
            try {
                allStatus = getCommonService().getCandidateStatus();
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
                allStatus = null;
            }
            if (manageEDICandidate.getEdiSearchResultVOLst() != null
                    && !manageEDICandidate.getEdiSearchResultVOLst().isEmpty()) {
                if (manageEDICandidate.getListItemToUpdate() != null
                        && !manageEDICandidate.getListItemToUpdate().isEmpty()) {
                    for (EDISearchResultVO eDISearchResultVO : manageEDICandidate
                            .getEdiSearchResultVOLst()) {
                        for (EDISearchResultVO itemUpdate : manageEDICandidate
                                .getListItemToUpdate()) {
                            if (itemUpdate.getPsWorkId() != null
                                    && CPSHelper.isNotEmpty(itemUpdate
                                    .getPsWorkId())) {
                                if (eDISearchResultVO.getPsWorkId().equals(
                                        itemUpdate.getPsWorkId())) {
                                    eDISearchResultVO.setStatus(itemUpdate
                                            .getStatus());
                                    if (allStatus != null
                                            && !allStatus.isEmpty()) {
                                        eDISearchResultVO
                                                .setStatusValue(allStatus
                                                        .get(eDISearchResultVO
                                                                .getStatus()));
                                    }
                                }
                            }
                        }
                    }
                }
                saveMessage(manageEDICandidate, new CPSMessage(
                        "Rejected UPC(s) Successfully", ErrorSeverity.INFO));
            } else if (manageEDICandidate.getEdiSearchResultVOLst().isEmpty()) {
                manageEDICandidate.setHaveResults(false);
                saveMessage(manageEDICandidate, new CPSMessage(
                        "No matches found,change criteria",
                        ErrorSeverity.WARNING));

            } else {
                saveMessage(manageEDICandidate, new CPSMessage(
                        "Rejected UPC(s) Fails", ErrorSeverity.INFO));
            }
            // set current page is selected for grid
            manageEDICandidate.setCurrentPage(1);

            // reset listItemToUpdate
            manageEDICandidate.setListItemToUpdate(null);

        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            saveMessage(manageEDICandidate, new CPSMessage(
                    "Error Reject Candidate", ErrorSeverity.WARNING));
        }

        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author nghianguyen
	 *
	 * @Description reject DSD Discontinue
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_REJECT_DSD_AJAX)
    public ModelAndView rejectDSDAjax(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + REJECT_DSD_FORM);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            manageEDICandidate.getCommentUPCVOs().clear();
            Object objProductId = req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            String productIdArray = manageEDICandidate.getProductSelectedIds();// cho
            // nay
            // iD
            // khac
            // nhau
            if (objProductId != null) {
                req.getSession().removeAttribute(
                        EDIConstants.EDI_PRODUCT_ID_SESSION);
            }
            req.getSession().setAttribute(EDIConstants.EDI_PRODUCT_ID_SESSION,
                    productIdArray);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author nghianguyen
	 *
	 * @Description reject DSD Discontinue
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_REJECT_DSD)
    public ModelAndView rejectDSD(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + REJECT_DSD_FORM);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        try {
            setForm(req, manageEDICandidate);
            manageEDICandidate.getCommentUPCVOs().clear();
            ArrayList<String> productSelectedIds = new ArrayList<String>();
            String resultArray = (String) req.getSession().getAttribute(
                    EDIConstants.EDI_PRODUCT_ID_SESSION);
            StringTokenizer stCandidateTypeList = new StringTokenizer(
                    resultArray, CPSConstants.COMMA);
            while (stCandidateTypeList.hasMoreTokens()) {
                productSelectedIds.add(stCandidateTypeList.nextToken());
            }
            List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
            for (String productId : productSelectedIds) {
                for (EDISearchResultVO ediSearchResultVO : manageEDICandidate
                        .getEdiSearchResultVOLst()) {
                    if (productId.equals(ediSearchResultVO.getPsProdId()
                            .toString())) {
                        listEDISearchResultVO.add(ediSearchResultVO);
                    }
                }
            }
            final String userRole = getUserRole();
            List<CommentUPCVO> listCommentUPCVOs = new ArrayList<CommentUPCVO>();
            listCommentUPCVOs.addAll(getCommonService().getUpcCommentDataDSDS(
                    listEDISearchResultVO, userRole));
            manageEDICandidate.getCommentUPCVOs().addAll(listCommentUPCVOs);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author trungnguyen
	 *
	 * @Disable row result
	 */
    private void validateAndDisableRowResult(ManageEDICandidate cpsEDIManageForm,
                                             Map<Integer, String> m) {
        String userRole = getUserRole();
        boolean renderNone = false;
        boolean renderView = false;
        boolean renderExec = false;
        boolean renderEdit = false;

        if (m != null) {
            String acs = m.get(CPSConstants.ITEM_CATEGORY_RESOURCE);
            if (acs != null) {
                if ("EX".equals(acs)) {
                    renderExec = true;
                } else if ("ED".equals(acs)) {
                    renderEdit = true;
                } else if ("V".equals(acs)) {
                    renderView = true;
                } else {
                    renderNone = true;
                }
            } else {
                renderNone = true;
            }
        } else {
            renderNone = true;
        }

        boolean roleDisableAllField = false;
        if (BusinessConstants.SCALE_MAN_ROLE.equalsIgnoreCase(userRole)) {
            roleDisableAllField = true;
        }
        List<EDISearchResultVO> listEDISearchResultVO = cpsEDIManageForm
                .getEdiSearchResultVOLst();
        if (listEDISearchResultVO != null) {
            for (EDISearchResultVO searchResultVO : listEDISearchResultVO) {
                if ((!cpsEDIManageForm.getIsVendor()
                        && CPSHelper.isNotEmpty(searchResultVO.getStatus()) && ("103")
                        .equals(searchResultVO.getStatus().trim()))
                        || (CPSHelper.isNotEmpty(searchResultVO.getStatus())
                        && "109".equals(searchResultVO.getStatus()
                        .trim())
                        && CPSHelper.isNotEmpty(searchResultVO
                        .getInputSource()) && "EDI"
                        .equals(searchResultVO.getInputSource()
                                .trim().toUpperCase()))
                        || roleDisableAllField
                        || (cpsEDIManageForm.getIsVendor()
                        && CPSHelper.isNotEmpty(searchResultVO
                        .getStatus()) && !("103"
                        .equals(searchResultVO.getStatus()) || "105"
                        .equals(searchResultVO.getStatus())))) {
                    searchResultVO.setDisable(true);
                }

                if (cpsEDIManageForm.getCandidateEDISearchCriteria()
                        .getActionId()
                        .equals(CPSConstants.SEARCH_ACTION_ACTIVEPRODUCTS_ID)) {
                    searchResultVO.setDisable(true);
                }

                if (renderNone) {
                    searchResultVO.getSellingUPCDetailVO().setItemCategoryCode(
                            "");
                    searchResultVO.getSellingUPCDetailVO().setItemCategoryName(
                            "");
                }
            }
        }
    }

	/*
	 * @author trungnguyen
	 *
	 * @ get description by product id
	 */

    private String getDescriptionByProId(List<EDISearchResultVO> lstTemp,
                                         String prodId) {
        String des = "";

        for (EDISearchResultVO searchResultVO : lstTemp) {
            if (searchResultVO.getPsProdId().toString().equals(prodId)) {
                des = searchResultVO.getSellingUPCDetailVO().getDescription();
                break;
            }
        }
        return des;
    }

    /*
	 * @author tuanle
	 *
	 * @Description save Reject Comment Candidate
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_SAVE_REJECTED_COMMENT_CANDIDATE)
    public ModelAndView saveRejectedCommentCandidate(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null) {
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            }
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
            // set current page is selected for grid
            manageEDICandidate.setCurrentPage(1);

            saveMessage(manageEDICandidate, new CPSMessage(
                    "Reject Comment UPC(s) Updated Successfully",
                    ErrorSeverity.INFO));
        } catch (Exception e) {
            saveMessage(manageEDICandidate, new CPSMessage(
                    "Reject Comment UPC(s) Updated Fails",
                    ErrorSeverity.WARNING));
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    /*
	 * @author tuanle
	 *
	 * @Description save Test Scan
	 */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_SAVE_TEST_SCAN_CANDIDATE)
    public ModelAndView saveTestScanCandidate(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        manageEDICandidate.setSession(req.getSession());
        try {
            keepSearchCriteriaList(req.getSession(), manageEDICandidate);
            setForm(req, manageEDICandidate);
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null) {
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            }
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
            // set current page is selected for grid
            manageEDICandidate.setCurrentPage(1);

            saveMessage(manageEDICandidate, new CPSMessage(
                    "Test Scan Successfully Saved", ErrorSeverity.INFO));
        } catch (Exception e) {
            saveMessage(manageEDICandidate, new CPSMessage(
                    "Test Scan Saved Fails", ErrorSeverity.WARNING));
            LOG.error(e.getMessage(), e);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

	/*
	 * @author trungnguyen
	 *
	 * @ get status code by userRole id
	 */

    private String getStatusCodeForUserRole() {
        String status = "";
        final String userRole = getUserRole();
        if (BusinessUtil.isVendor(userRole)) {
            status = BusinessConstants.VENDOR_CODE;
        } else if (BusinessUtil.isAdmin(userRole)
                || BusinessUtil.isPIARole(userRole)
                || BusinessUtil.isPIALead(userRole)) {
            status = BusinessConstants.WORKING_CODE;
        }

        return status;
    }

    /*
	 * @author trungnguyen
	 *
	 * @ activate normal candidate
	 */
    private void activateSingleEntryCandidate(int workId, String prodId,
                                              List<Integer> activatedWorkIdListCadidates,
                                              StringBuffer checkCadidatesMessage,
                                              List<Integer> activatedFailWorkIdListCadidates,
                                              List<Integer> activatedToWorkingWorkIdListCadidates,
                                              ManageEDICandidate cpsEDIManageForm, List<Integer> lstVendor)
            throws CPSGeneralException {

        String returnMessage = getAddNewCandidateService().activateValidator(
                workId, prodId, getUserRole(), lstVendor, null);
        if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnMessage.replace(
                CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim())) {
            try {
                String returnValue = getCommonService().getActivate(workId,
                        getUserInfo().getUserName());
                String workStatus = null;

                if (BusinessConstants.MFPE.equalsIgnoreCase(returnValue)) {
                    workStatus = BusinessConstants.ACTIVATE_CODE;
                    getAddNewCandidateService().changeWorkStatus(workId,
                            workStatus);
                    /**
                     * Candidate Activated Successfully. Preserve the workId.
                     */
                    activatedWorkIdListCadidates.add(workId);
                } else {
                    workStatus = CPSConstants.WORKING_CODE;
                    checkCadidatesMessage
                            .append("DB Time out issue while activating");
                    getAddNewCandidateService().changeWorkStatus(workId,
                            workStatus);
                    activatedToWorkingWorkIdListCadidates.add(workId);
                }
            } catch (CPSBusinessException e) {
                LOG.error(e.getMessage(), e);
                getAddNewCandidateService().changeWorkStatus(workId,
                        BusinessConstants.ACTIVATION_FAILURE_CODE);
                activatedFailWorkIdListCadidates.add(workId);
                List<CPSMessage> list = e.getMessages();
                for (CPSMessage errMsg : list) {
                    checkCadidatesMessage.append(errMsg.getMessage());
                }
            }
        } else {

            List<EDISearchResultVO> lstTemp = cpsEDIManageForm
                    .getEdiSearchResultVOLst();

            checkCadidatesMessage.append(" [Product Description :"
                    + getDescriptionByProId(lstTemp, prodId) + "] "
                    + returnMessage);
        }
    }
    @RequestMapping(method = RequestMethod.GET, value = ManageEDIMainController.RELATIVE_PATH_VIEW_MASS_UPLOAD_PROFIED)
    public ModelAndView viewMassUpLoadProfied(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + VIEW_MASS_PROFILES);
        manageEDICandidate.setSession(req.getSession());
        setForm(req, manageEDICandidate);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null) {
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        }
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.EDI);
        manageEDICandidate.setFilterValues("");
        manageEDICandidate.setCurrentPage(1);
        manageEDICandidate.setCurrentRecord(50);
        List<MassUploadVO> lstMassUploadVOs = getCommonService()
                .getAllMassUpploadProfiles();
        if (req.getSession().getAttribute(CPSConstants.MASS_UPLOAD_VOs) != null) {
            req.getSession().removeAttribute(CPSConstants.MASS_UPLOAD_VOs);
        }
        req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs, lstMassUploadVOs);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_DELETE_MASS_UPLOAD_PROFILIES)
    public ModelAndView deleteMassUploadProfilies(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + VIEW_MASS_PROFILES);
        manageEDICandidate.setSession(req.getSession());
        if (req.getSession().getAttribute(CPSConstants.MASS_UPLOAD_VOs) != null) {
            req.getSession().removeAttribute(CPSConstants.MASS_UPLOAD_VOs);
        }

        List<MassUploadVO> lstMassUPloadUpdates = manageEDICandidate
                .getLstMassUPloadUpdates();
        getCommonService().removeMassUpploadProfiles(lstMassUPloadUpdates);
        List<MassUploadVO> lstMassUploadVOs = getCommonService()
                .getAllMassUpploadProfiles();
        req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs, lstMassUploadVOs);
        saveMessage(manageEDICandidate, new CPSMessage("Deleted Successfully.",
                ErrorSeverity.INFO));
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_UPDATE_MASS_UPLOAD_PROFILIES)
    public ModelAndView updateMassUploadProfilies(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + VIEW_MASS_PROFILES);
        manageEDICandidate.setSession(req.getSession());
        setForm(req, manageEDICandidate);
        if (req.getSession().getAttribute(CPSConstants.MASS_UPLOAD_VOs) != null)
            req.getSession().removeAttribute(CPSConstants.MASS_UPLOAD_VOs);
        List<MassUploadVO> lstMassUPloadUpdates = manageEDICandidate
                .getLstMassUPloadUpdates();
        getCommonService().saveMassUpploadProfiles(lstMassUPloadUpdates);
        List<MassUploadVO> lstMassUploadVOs = getCommonService()
                .getAllMassUpploadProfiles();
        Integer vendorIdAdd = null;
        int functionId = 0;
        for (MassUploadVO massUploadVO : lstMassUPloadUpdates) {
            if (massUploadVO != null && massUploadVO.isAddFlag()) {
                vendorIdAdd = massUploadVO.getVendorId();
                functionId = massUploadVO.getFunctionId();
                break;
            }
        }
        if (!CPSHelper.isEmpty(vendorIdAdd)) {
            List<MassUploadVO> lstMassUploadVOsDisplay = new ArrayList<MassUploadVO>();
            MassUploadVO massUploadVOAdd = null;
            for (MassUploadVO massUploadVO : lstMassUploadVOs) {
                if (massUploadVO != null
                        && massUploadVO.getVendorId().equals(vendorIdAdd)
                        && massUploadVO.getFunctionId() == functionId) {
                    massUploadVOAdd = massUploadVO;
                } else {
                    lstMassUploadVOsDisplay.add(massUploadVO);
                }
            }
            if (massUploadVOAdd != null) {
                int currentPage = manageEDICandidate.getCurrentPage();
                int currentRowPage = manageEDICandidate.getCurrentRecord();
                int index = 0;
                if (currentPage > 1) {
                    index = (currentPage - 1) * currentRowPage;
                }
                lstMassUploadVOsDisplay.add(index, massUploadVOAdd);
            }
            req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs,
                    lstMassUploadVOsDisplay);
        } else {
            req.getSession().setAttribute(CPSConstants.MASS_UPLOAD_VOs, lstMassUploadVOs);
        }

        saveMessage(manageEDICandidate, new CPSMessage("Saved Successfully.",
                ErrorSeverity.INFO));
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

    private List<String> columnHeadingCandidates() {
        List<String> columnPrinSumaryProductHeadings = new ArrayList<String>();
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE);
        columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_UOM);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_STYLE);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_MODEL);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_COLOR);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_BRAND);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PACKING);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_LIST_COST);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL);
        // HebApprovedSellingPrice
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_RETAIL);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_RETAIL_LINK_UPC_CANDIDATE);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_ITEM_CODE);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR);
        // Code Date
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS);

        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY);
        columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_BDM);
        // new Attribute
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_STATUS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_EMPTY);
        return columnPrinSumaryProductHeadings;
    }

    private List<String> columnHeadingProducts() {
        List<String> columnPrinSumaryProductHeadings = new ArrayList<String>();
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE);
        columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_UOM);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_STYLE);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_MODEL);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_COLOR);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_BRAND);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PACKING);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_LIST_COST);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL);
        // HebApprovedSellingPrice
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_RETAIL);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_RETAIL_LINK_UPC);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_ITEM_CODE);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR);
        // Code Date
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS);

        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY);
        columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_BDM);
        // new Attribute
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_STATUS);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER);
        columnPrinSumaryProductHeadings
                .add(CPSConstants.PRINSUMARY_COLUMN_EMPTY);
        return columnPrinSumaryProductHeadings;
    }

    /**
     * PIM-1642 Delete Candidates
     *
     * @param mapping the mapping
     * @param form the form
     * @param req the request
     * @param resp the response
     * @return to the screen
     * @throws Exception the exception
     */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = ManageEDIMainController.RELATIVE_PATH_DELETE_EDI)
    public ModelAndView deleteEdi(ManageEDICandidate manageEDICandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.EDI_MANAGE_MAIN);
        keepSearchCriteriaList(req.getSession(), manageEDICandidate);
        manageEDICandidate.setSession(req.getSession());
        setForm(req, manageEDICandidate);
        StringTokenizer idList = new StringTokenizer(manageEDICandidate.getProductSelectedIds(), ",");
        List<Integer> psWorkIdList = new ArrayList<Integer>();
        while (idList.hasMoreElements()) {
            int prodId = CPSHelper.getIntegerValue(idList.nextToken());
            List<EDISearchResultVO> results = manageEDICandidate.getEdiSearchResultVOLst();
            for (EDISearchResultVO searchResultVO : results) {
                if (prodId == searchResultVO.getPsProdId()) {
                    psWorkIdList.add(searchResultVO.getPsWorkId());
                }
            }
        }
        if (CPSHelper.isNotEmpty(psWorkIdList)) {
            String status = getCommonService().changeStatusCandidateList(psWorkIdList, CPSConstants.DELETED);
            req.setAttribute(CPSConstants.MY_MESSAGE, "Candidate(s) " + status);
        }
        searchEDICandidate(manageEDICandidate, req, resp);
        CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_DELETED_SUCCESS, ErrorSeverity.VALIDATION);
        saveMessage(manageEDICandidate, message);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageEDICandidate);
        return model;
    }

}
