package com.heb.operations.cps.controller;

import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.heb.operations.cps.model.AddNewCandidate;
import com.heb.operations.cps.util.*;
import com.heb.operations.cps.vo.*;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.heb.jaf.security.HebLdapUserService;
import com.heb.jaf.security.UserInfo;
import com.heb.jaf.vo.VendorOrg;
import com.heb.operations.business.framework.exeption.CPSBusinessException;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.exeption.CPSMessage.ErrorSeverity;
import com.heb.operations.business.framework.exeption.CPSSystemException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.ClassCommodityVO;
import com.heb.operations.business.framework.vo.VendorLocationVO;
import com.heb.operations.business.framework.vo.WareHouseVO;
import com.heb.operations.cps.database.entities.PsCandidateStat;
import com.heb.operations.cps.ejb.webservice.WarehouseService.GetWarehouseListByVendor_Request.VendorList;
import com.heb.operations.cps.excelExport.CPSExportToExcel;
import com.heb.operations.cps.model.HebBaseInfo;
import com.heb.operations.cps.model.ManageCandidate;
import com.heb.operations.cps.model.ManageProduct;

/**
 * Created by thangdang on 11/6/2017.
 */
@Controller
@RequestMapping(value = ManageCandidateController.RELATIVE_PATH_CANDIDATE_SEARCH_BASE)
public class ManageCandidateController extends HEBBaseService {
    @Autowired
    HebLdapUserService hebLdapUserService;
    /**
     * The Constant LOG.
     */
    private static final Logger LOG = Logger.getLogger(HEBBaseService.class);
    private static final String RELATIVE_PATH_CANDIDATE_SEARCH_WRAPPER="/candSearchWrapper";
    public static final String RELATIVE_PATH_CANDIDATE_SEARCH_BASE="/protected/cps/manage";
    public static final String RELATIVE_PATH_CANDIDATE_SEARCH="/searchCandidate";
    public static final String RELATIVE_PATH_FILTER_CHANGE="/filterChange";
    public static final String RELATIVE_PATH_CLEAR_SEARCH_RESULTS = "/clearSearchResults";
    public static final String RELATIVE_PATH_LOAD_PAGING_SEARCH = "/loadPagingSearch";
    public static final String RELATIVE_PATH_FILTER = "/filter";
    public static final String RELATIVE_PATH_CHECK_ALLS = "/checkAlls";
    public static final String RELATIVE_PATH_PRINT_FORM="/printForm";
    public static final String RELATIVE_PATH_PRINT_FORM_MRT="/printMRT";
    public static final String RELATIVE_PATH_PRINT_FORM_AJAX="/printFormAjax";
    public static final String RELATIVE_PATH_PRINT_SUMARY="/printSummary";
    public static final String RELATIVE_PATH_ACTIVATE="/activate";
    public static final String RELATIVE_PATH_TEST_SCAN="/testScan";
    public static final String RELATIVE_PATH_TEST_SCAN_AJAX="/testScanAjax";
    public static final String RELATIVE_PATH_SUBMIT="/submitCandidate";
    public static final String RELATIVE_PATH_DELETE_CANDIDATE="/deleteCand";
    public static final String RELATIVE_PATH_REJECT_CANDIDATE="/rejectCand";
    public static final String RELATIVE_PATH_REJECT_CANDIDATE_AND_COMMENTS="/rejectCandComments";
    public static final String RELATIVE_PATH_REJECT_CANDIDATE_AND_COMMENTS_AJAX="/rejectCandCommentsAjax";
    public static final String RELATIVE_PATH_SAVE_COMMENTS="/saveComments";
    public static final String RELATIVE_PATH_UPDATE_REJECT_COMMENTS="/updateRejectMessage";
    public static final String RELATIVE_PATH_REJECT_MRT_CANDIDATE="/rejectMRTCandidate";
    public static final String RELATIVE_PATH_ACTIVATION_MESSAGE = "/activationMessage";
    public static final String RELATIVE_PATH_SCALE_APPROVE = "/scaleApprove";
    public static final String RELATIVE_PATH_TRACK_ERROR_UPC = "/trackErrorUPC";
    public static final String RELATIVE_PATH_PRODUCT_SEARCH_WRAPPER = "/prodSearchWrapper";
    public static final String RELATIVE_PATH_SEARCH_PRODUCT = "/searchProduct";
    public static final String RELATIVE_PATH_PRINT_PRODUCT_SUMMARY = "/printProductSummary";
    public static final String RELATIVE_PATH_PRODUCT_FILTER_CHANGE = "/productFilterChange";
    public static final String RELATIVE_PATH_PRODUCT_FILTER_CHANGE_CLEAR = "/productFilterChangeClear";
    public static final String RELATIVE_PATH_SORT_FILTER = "/sortFilter";
    public static final String RELATIVE_PATH_ROOT_PAGE="/cps/manage/";
    public static final String RELATIVE_PATH_AJAX_SEARCH_RESULT_PAGE="modules/ajaxSearchResults";
    public static final String RELATIVE_PATH_PRINT_FORM_CANDIDATE_PAGE="modules/printFormFiles";
    public static final String RELATIVE_PATH_PRINT_FORM_CANDIDATE_AJAX_PAGE="modules/printFormFiles_ajax";
    public static final String RELATIVE_PATH_TEST_SCAN_PAGE="modules/testScan_popup";
    public static final String RELATIVE_PATH_TEST_SCAN_AJAX_PAGE="modules/testScan_popup_ajax";
    public static final String RELATIVE_PATH_REJECT_CANDIDATE_PAGE="modules/rejectCandidate_popup";
    public static final String RELATIVE_PATH_REJECT_CANDIDATE_AJAX_PAGE="modules/rejectCandidate_popup_ajax";
    public static final String RELATIVE_PATH_PRODUCT_SEARCH_PAGE = "CPSProductSearch";
    public static final String RELATIVE_PATH_PRODUCT_AJAX_RESULTS_PAGE = "modules/prodAjaxResults";
    public static final String MANAGE_CANDIDATE_MODEL_ATTRIBUTE="manageCandidate";
    public static final String MANAGE_PRODUCT_MODEL_ATTRIBUTE = "manageProduct";
    private static final String RELATIVE_PATH_KEEP_VALUE_CANDIDATE_SEARCH="/keepValueCandidateSearch";
    private static final String RELATIVE_PATH_KEEP_VALUE_PRODUCT_SEARCH="/keepValueProductSearch";


    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_CANDIDATE_SEARCH_WRAPPER)
    public ModelAndView candSearchWrapper(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ManageCandidate manageCandidate = new ManageCandidate();
        manageCandidate.setSession(req.getSession());
        manageCandidate.clearQuestionaireVO();
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        req.getSession().setAttribute(CPSConstants.PRESENT_BTS, "2");
        return candSearch(manageCandidate,  req, resp);
    }
    /**
     * handles the candidate search
     *
     * @param manageCandidate
     * @param req
     * @param resp
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public ModelAndView candSearch(ManageCandidate manageCandidate,
                                   HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        this.setForm(req, manageCandidate);
        try {
            manageCandidate.setClasses(getCommonService()
                    .getClassesAsBaseJSFVOs());
        } catch (Exception e) {
            LOG.error("Error get getClassesAsBaseJSFVOs Exception :" + e);
        }
        manageCandidate.setAllStatus(initStatus(getUserRole()));
        manageCandidate.setValidForCandSearch(true);
        manageCandidate.setValidForResults(false);
        manageCandidate.setSelectedFunction(CPSConstants.MAANAGE_CANDIDATE);
        manageCandidate.setManageCandidateMode();
        manageCandidate.setValidForResults(true);
        manageCandidate.setSelectedProductId("");
        manageCandidate.setCandidateTypeList("");
        manageCandidate.setSelectedProdWorkRqstId("");
        manageCandidate.setSelectedWorkStatus("");
        manageCandidate.setSelectedProductCandidateId("");
        HttpSession session = req.getSession();
        Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
                .getAttribute("vendorMap");
        if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
            vendorMap = getVendorLocationList();
            if (null != vendorMap) {
                session.setAttribute("vendorMap", vendorMap);
            }
        }
        try {
            populateBDMs(manageCandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateBDMs Exception :" + e.getMessage());
        }
		/*
		 * Initial commodity and sub-commodity for the first run
		 *
		 * @author khoapkl
		 */
        try {
            populateCommodities(manageCandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateCommodities Exception :"
                    + e.getMessage());
        }
        try {
            populateSubCommodities(manageCandidate, req);
        } catch (Exception e) {
            LOG.error("Error get populateSubCommodities Exception :"
                    + e.getMessage());
        }
        manageCandidate.getProducts().clear();
        if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
            req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
        manageCandidate.setProductsDisplay(new ArrayList<SearchResultVO>());
        manageCandidate.setCriteria(new CandidateSearchCriteria());
        if (CPSHelper.isEmpty(manageCandidate.getProductTypes())) {
            manageCandidate.setProductTypes(getAppContextFunctions()
                    .getProductTypes());
        }
        saveMessage(manageCandidate, new CPSMessage());
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }

    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_CANDIDATE_SEARCH)
    public ModelAndView searchCandidate(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        try {
            manageCandidate.setSession(req.getSession());
            setForm(req, manageCandidate);
            manageCandidate.setUserRole(this.getUserRole());
            if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
                req.getSession().removeAttribute(CPSConstants.REDIRECT_FORM);
            }
            req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
            req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION);
            req.getSession().removeAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
            // keep list of search criteria
            this.setDataAutoComplete(manageCandidate,req);
            if (CPSHelper.isEmpty(manageCandidate.getClasses())) {
                manageCandidate.setClasses(this.getCommonService().getClassesAsBaseJSFVOs());
            }
            manageCandidate.getQuestionnarieVO().setSelectedOption("1");
            manageCandidate.getQuestionnarieVO().setSelectedValue(null);
            clearViewMode(manageCandidate);
            manageCandidate.getProducts().clear();
            if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            manageCandidate.setSelectedProductId("");
            manageCandidate.setCandidateTypeList("");
            manageCandidate.setSelectedProdWorkRqstId("");
            manageCandidate.setSelectedWorkStatus("");
            manageCandidate.setSelectedProductCandidateId("");
            CandidateSearchCriteria searchCriteria = manageCandidate
                    .getCriteria();
            if (searchCriteria.isBatchUploadSwitch()) {
                manageCandidate.setHidBatchUploadSwitch(true);
            } else {
                manageCandidate.setHidBatchUploadSwitch(false);
            }
        /*
         * Reset mrtSwitch
		 *
		 * @author khoapkl
		 */
            searchCriteria.setMrtSwitchCheck(false);
            if (CPSHelper.isNotEmpty(searchCriteria.getVendorDescription())
                    && CPSHelper.isEmpty(searchCriteria.getVendorIDList())) {
                List<Integer> vendorIDList = new ArrayList<Integer>();
                try {
                    Integer vendorID = CPSHelper.getIntegerValue(searchCriteria
                            .getVendorDescription());
                    vendorIDList.add(vendorID);
                    VendorList vendorList = new VendorList(null, null, vendorID);
                    List<WareHouseVO> warehouseList = this.getCommonService()
                            .getWareHouseList(vendorList, null);
                    if (CPSHelper.isNotEmpty(warehouseList)) {
                        String padVendorID = CPSHelper.padZeros(
                                searchCriteria.getVendorDescription(), 6);
                        for (WareHouseVO whVo : warehouseList) {
                            int vendorId = CPSHelper.getIntegerValue(whVo
                                    .getWhareHouseid() + padVendorID);
                            if (vendorId > 0) {
                                vendorIDList.add(vendorId);
                            }
                        }
                    }
                } catch (NumberFormatException num) {
                    // It is not a Vendor ID - go on.
                } catch (CPSSystemException sys) {
                    // Service not up - log & go on.
                    LOG.error("Unable to get Warehouse service", sys);
                } catch (CPSGeneralException gen) {
                    // no warehouses found - could be DSD vendor - go on.
                    LOG.warn("Unable to get Warehouse service", gen);
                }
                if (CPSHelper.isNotEmpty(vendorIDList)) {
                    searchCriteria.setVendorIDList(vendorIDList);
                }
            }
            searchCriteria.setUserName(this.getCommonService().getUserName());
            searchCriteria.setRole(getUserRole());
            manageCandidate.setAllStatus(this.initStatus(getUserRole()));
            if (CPSHelper.isEmpty(manageCandidate.getProductTypes())) {
                manageCandidate.setProductTypes(this.getAppContextFunctions()
                        .getProductTypes());
            }
            manageCandidate.setProductsDisplay(new ArrayList<SearchResultVO>());
            // Albin - other criteria to be added
            List<SearchResultVO> results = this.getCommonService()
                    .getCandidatesForCriteria(searchCriteria);
            if (results != null) {
                if (results.isEmpty()) {
                    // Checking for Activation
                    if (!manageCandidate.isActivateSwitch()) {
                        saveMessage(manageCandidate, new CPSMessage(
                                "No matches found,change criteria",
                                CPSMessage.ErrorSeverity.WARNING));
                    }
                } else {
                    if (searchCriteria.isMrtSwitchCheck()) {
                        manageCandidate.setHidManageMrtSwitch(true);
                    } else {
                        manageCandidate.setHidManageMrtSwitch(false);
                    }
                    if (!manageCandidate.isActivateSwitch()) {
                        if (results.size() > 1) {
                            saveMessage(manageCandidate,
                                    new CPSMessage(results.size()
                                            + CPSConstants.CANDIDATES_FOUND, CPSMessage.ErrorSeverity.INFO));
                        } else {
                            saveMessage(manageCandidate,
                                    new CPSMessage(
                                            results.size() + CPSConstants.CANDIDATE_FOUND,
                                            CPSMessage.ErrorSeverity.INFO));
                        }
                    }
                }
            }
            manageCandidate.setValidForCandSearch(true);
            manageCandidate.setValidForResults(false);
            manageCandidate.setSelectedFunction(CPSConstants.MAANAGE_CANDIDATE);
            manageCandidate.setManageCandidateMode();
            manageCandidate.setValidForResults(true);
            manageCandidate.setProducts(results);
            manageCandidate.setProductsTemp(results);
            if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
            req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION, results);
            req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, results);
            clearSessionPaging(req);
            processPaging(req, null, null, results, manageCandidate);
         /*
		 * keep results in session It used for reject candidate at search pag
		 */
            req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION, results);
            req.getSession().setAttribute(CPSConstants.CPS_CRITERIA_SESSION, searchCriteria);
		/*
		 * identify search result is not empty and don't execute search by Mrt
		 * Switch
		 *
		 * @author khoapkl
		 */
//        req.setAttribute("noData", results != null && !results.isEmpty() ? true
//                : false);

            if (this.getUserRole().equals(
                    CPSConstants.REGISTERED_VENDOR_ROLE)
                    || this.getUserRole().equals(
                    CPSConstants.UNREGISTERED_VENDOR_ROLE)) {
                req.getSession().removeAttribute(CPSConstants.VENDOR_LOGIN_COFIRM);
                req.getSession().setAttribute(CPSConstants.VENDOR_LOGIN_COFIRM,
                        "true");
            }
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            model.addObject("noData", results != null && !results.isEmpty() ? true
                    : false);
        }catch (CPSBusinessException e) {
            LOG.fatal("CPSBusinessException:-", e);
            if (!isInputForwardValueSet(req)) {
            }
            handleException(e, manageCandidate,
                    req, resp);
        } catch (CPSSystemException e) {
            LOG.fatal("CPSSystemException:-", e);

            handleException(e, manageCandidate, req, resp);
        } catch (Exception e) {
            LOG.fatal("Exception:-", e);
            handleException(e, manageCandidate,req, resp);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    /**
     * handles the filter functionality of the candidates search page
     *
     * @param manageCandidate
     * @param req
     * @param resp
     * @return
     * @throws Exception
     */
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_FILTER_CHANGE)
    public ModelAndView filterChange(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, BindingResult result,HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_AJAX_SEARCH_RESULT_PAGE);
        setForm(req, manageCandidate);
//        CPSManageCandidateMainForm mainForm = (CPSManageCandidateMainForm) form;
        String pageSet = "0";
        String numSet = "10";
        List<SearchResultVO> products = new ArrayList<SearchResultVO>();
        products = (List<SearchResultVO>) req.getSession().getAttribute(
                CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
        manageCandidate.setValidForResults(true);
        List<SearchResultVO> productTemps = new ArrayList<SearchResultVO>();
		/*
		 * Filter by Mrt Switch
		 *
		 * @author khoapkl
		 */
        if (manageCandidate.getCriteria().isMrtSwitchCheck() == false) {
            productTemps = products;
        } else {
            for (SearchResultVO searchResultVO : products) {
                boolean isMRT = searchResultVO.getMrtLabel().equals(CPSConstants.MRT) ? true
                        : false;
                if (manageCandidate.getCriteria().isMrtSwitchCheck() == isMRT) {
                    productTemps.add(searchResultVO);
                }
            }
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // vendor id
        if (manageCandidate.getVndrId() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getVndrId().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getVndrId().equals(searchResultVO.getVendorId())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // vendor desc
        if (CPSWebUtil.replaceHTMLSpecialChars(manageCandidate.getVndrDesc()) != null
                && !CPSConstants.EMPTY_STRING
                .equals(CPSWebUtil.replaceHTMLSpecialChars(manageCandidate
                        .getVndrDesc().trim()))) {
            for (SearchResultVO searchResultVO : products) {
                if (CPSWebUtil.replaceHTMLSpecialChars(manageCandidate.getVndrDesc())
                        .equals(CPSHelper.trimSpaces(searchResultVO
                                .getVendorDesc()))) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // UPC
        if (manageCandidate.getVndrUnitUpc() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getVndrUnitUpc().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getVndrUnitUpc().equals(
                        searchResultVO.getUnitUPC())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // Product Desc
        if (CPSWebUtil.replaceHTMLSpecialChars(manageCandidate.getPrdDesc()) != null
                && !CPSConstants.EMPTY_STRING.equals(CPSWebUtil
                .replaceHTMLSpecialChars(manageCandidate.getPrdDesc().trim()))) {
            for (SearchResultVO searchResultVO : products) {
                if (CPSWebUtil.replaceHTMLSpecialChars(manageCandidate.getPrdDesc())
                        .equals(CPSHelper.trimSpaces(searchResultVO
                                .getProdDescription()))) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // list cost
        if (manageCandidate.getListCost() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getListCost().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getListCost().equals(searchResultVO.getListCost())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // press date
        if (manageCandidate.getProdPresDate() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getProdPresDate().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getProdPresDate().equals(
                        searchResultVO.getPressDate())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // status
        if (manageCandidate.getStatus() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getStatus().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getStatus().equals(
                        searchResultVO.getWorkStatusCode())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // test scan status
        if (manageCandidate.getTestScanStatus() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getTestScanStatus().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getTestScanStatus().equals(
                        searchResultVO.getTestScanStatus())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // source
        if (manageCandidate.getSource() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getSource().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getSource().equals(searchResultVO.getSource())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // ship pack
        if (manageCandidate.getShipPack() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getShipPack().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getShipPack().equals(searchResultVO.getShipPack())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        productTemps = new ArrayList<SearchResultVO>();
        // master pack
        if (manageCandidate.getMasterPack() != null
                && !CPSConstants.EMPTY_STRING.equals(manageCandidate.getMasterPack().trim())) {
            for (SearchResultVO searchResultVO : products) {
                if (manageCandidate.getMasterPack().equals(
                        searchResultVO.getMasterPack())) {
                    productTemps.add(searchResultVO);
                }
            }
        } else {
            productTemps = products;
        }
        products = productTemps;
        manageCandidate.setProductsTemp(products);
        if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
            req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
        req.getSession()
                .setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, products);
        if (products.isEmpty()) {
            saveMessage(manageCandidate, new CPSMessage(
                    "No matches found, change criteria", CPSMessage.ErrorSeverity.WARNING));
            processPaging(req, null, null, products, manageCandidate);
        } else if (products.size() > 1) {
            List<SearchResultVO> results = (List<SearchResultVO>) req
                    .getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            if (products.size() == results.size()) {
                Object pageCurrent = req.getSession().getAttribute(
                        CPSConstants.SEARCH__PAGE_CURRENT_SESSION);
                Object numViewCurrent = req.getSession().getAttribute(
                        CPSConstants.SEARCH_NUMBER_VIEW_SESSION);
                if (numViewCurrent != null) {
                    numSet = req.getSession()
                            .getAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION)
                            .toString();
                }
                if (pageCurrent != null) {
                    pageSet = req.getSession()
                            .getAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION)
                            .toString();
                }
                processPaging(req, pageSet, numSet, products, manageCandidate);
            } else {
                processPaging(req, null, null, products, manageCandidate);
            }
            saveMessage(manageCandidate, new CPSMessage(products.size()
                    + CPSConstants.CANDIDATE_FOUND, CPSMessage.ErrorSeverity.INFO));
        } else {
            processPaging(req, null, null, products, manageCandidate);
            saveMessage(manageCandidate, new CPSMessage(products.size()
                    + CPSConstants.CANDIDATE_FOUND, CPSMessage.ErrorSeverity.INFO));
        }
        manageCandidate.setSortCaseValue(0);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_CLEAR_SEARCH_RESULTS)
    public ModelAndView clearSearchResults(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,
                                           HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        setForm(req, manageCandidate);
        if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
            req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
        if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
            req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
        return model;
    }

    private void clearSessionPaging(HttpServletRequest request) {
        if (request.getSession().getAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION) != null)
            request.getSession().removeAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION);
        if (request.getSession().getAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION) != null)
            request.getSession().removeAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION);
        if (request.getSession().getAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION) != null)
            request.getSession().removeAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION);
    }

	/**
	 * Load paging search when click on page number.
	 * 
	 * @param manageCandidate
	 *            the model attribute manage candidate.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return the ajax search results page.
	 * @throws Exception
	 *             if error has occurred.
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = RELATIVE_PATH_LOAD_PAGING_SEARCH)
	public final ModelAndView loadPagingSearch(
			@Valid @ModelAttribute(MANAGE_PRODUCT_MODEL_ATTRIBUTE) final ManageCandidate manageCandidate,
			final HttpServletRequest req, final HttpServletResponse resp) throws Exception {
		final ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_AJAX_SEARCH_RESULT_PAGE);
		final String pageSet = req.getParameter("pageSet");
		final String numSet = req.getParameter("numSet");
		List<SearchResultVO> results = (List<SearchResultVO>) req.getSession()
				.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
		processPaging(req, pageSet, numSet, results, manageCandidate);
		model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageCandidate);
		return model;
	}

	/**
	 * Filter handle when click on sort by column name.
	 * 
	 * @param manageCandidate
	 *            the model attribute manage candidate.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return the ajax search result page.
	 * @throws Exception
	 *             if error has occurred.
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = RELATIVE_PATH_FILTER)
	public ModelAndView filter(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_AJAX_SEARCH_RESULT_PAGE);
		setForm(req, manageCandidate);
		HttpSession session = req.getSession();

		List<SearchResultVO> prodcuts = (List<SearchResultVO>) req.getSession()
				.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
		if (manageCandidate.getSortCaseValue() == 0) {
			prodcuts = (List<SearchResultVO>) req.getSession()
					.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
			Collections.sort(prodcuts, SearchResultVO.getComparator(1));
		} else {
			Collections.sort(prodcuts, SearchResultVO.getComparator(manageCandidate.getSortCaseValue()));
		}
		if (CPSConstants.DOWN.equals(manageCandidate.getDirection())) {
			Collections.reverse(prodcuts);
		}
		Object pageCurrent = session.getAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION);
		if (pageCurrent != null) {
			String pageSet = session.getAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION).toString();
			processPaging(req, pageSet, null, prodcuts, manageCandidate);
		}
		manageCandidate.setValidForResults(true);

		model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageCandidate);
		return model;
	}

	/**
	 * Check all.
	 * 
	 * @param manageCandidate
	 *            the model attribute manage candidate.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return the ajax search result page.
	 * @throws Exception
	 *             if error has occurred.
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = RELATIVE_PATH_CHECK_ALLS)
	public ModelAndView checkAlls(
			@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_AJAX_SEARCH_RESULT_PAGE);
		final String flag = req.getParameter("flag");
		List<SearchResultVO> lstSearchResult = null;
		if ("true".equals(flag)) {
			lstSearchResult = (List<SearchResultVO>) req.getSession()
					.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
			if (lstSearchResult != null && !lstSearchResult.isEmpty()) {
				String allProdWorkRqstId = "";
				String candidateTypeArray = "";
				String allProdIdsSelected = "";
				String allWorkStatus = "";
				String allProductCandidateId = "";
				if (lstSearchResult.size() == 1) {
					allProdIdsSelected = String.valueOf(lstSearchResult.get(0).getPsProdId());
					if (CPSHelper.isEmpty(lstSearchResult.get(0).getMrtLabel())) {
						candidateTypeArray = "None-MRT";
						allProductCandidateId = allProdIdsSelected;
					} else {
						candidateTypeArray = "MRT";
					}
					allProdWorkRqstId = lstSearchResult.get(0).getWorkIdentifier() + ":"
							+ lstSearchResult.get(0).getPsProdId();
					allWorkStatus = lstSearchResult.get(0).getWorkStatusDesc();
				} else {
					for (SearchResultVO searchResultVO : lstSearchResult) {
						if (CPSHelper.isEmpty(allProdIdsSelected)) {
							allProdIdsSelected = allProdIdsSelected + String.valueOf(searchResultVO.getPsProdId());
						} else {
							allProdIdsSelected = allProdIdsSelected + ","
									+ String.valueOf(searchResultVO.getPsProdId());
						}
						if (CPSHelper.isEmpty(allProdWorkRqstId)) {
							allProdWorkRqstId = allProdWorkRqstId + searchResultVO.getWorkIdentifier() + ":"
									+ searchResultVO.getPsProdId();
						} else {
							allProdWorkRqstId = allProdWorkRqstId + "," + searchResultVO.getWorkIdentifier() + ":"
									+ searchResultVO.getPsProdId();
						}
						if (CPSHelper.isEmpty(searchResultVO.getMrtLabel())) {
							if (CPSHelper.isEmpty(candidateTypeArray)) {
								candidateTypeArray = candidateTypeArray + "None-MRT";
								allProductCandidateId = allProductCandidateId
										+ String.valueOf(searchResultVO.getPsProdId());
							} else {
								candidateTypeArray = candidateTypeArray + "," + "None-MRT";
								allProductCandidateId = allProductCandidateId + ","
										+ String.valueOf(searchResultVO.getPsProdId());
							}
						} else {
							if (CPSHelper.isEmpty(candidateTypeArray)) {
								candidateTypeArray = candidateTypeArray + "MRT";
							} else {
								candidateTypeArray = candidateTypeArray + "," + "MRT";
							}
						}
						if (CPSHelper.isEmpty(allWorkStatus)) {
							allWorkStatus = allWorkStatus + searchResultVO.getWorkStatusDesc();
						} else {
							allWorkStatus = allWorkStatus + "," + searchResultVO.getWorkStatusDesc();
						}
					}
				}
				manageCandidate.setSelectedProductId(allProdIdsSelected);
				manageCandidate.setCandidateTypeList(candidateTypeArray);
				manageCandidate.setSelectedProdWorkRqstId(allProdWorkRqstId);
				manageCandidate.setSelectedWorkStatus(allWorkStatus);
				manageCandidate.setSelectedProductCandidateId(allProductCandidateId);
			}
		} else {
			manageCandidate.setSelectedProductId("");
			manageCandidate.setCandidateTypeList("");
			manageCandidate.setSelectedProdWorkRqstId("");
			manageCandidate.setSelectedWorkStatus("");
			manageCandidate.setSelectedProductCandidateId("");
		}
		String pageSet = "0";
		int pageCurrentSelected = 0;
		int totalPage = 0;
		Object pageCurrent = req.getSession().getAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION);
		Object totalPageObject = req.getSession().getAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION);
		if (totalPageObject != null) {
			try {
				totalPage = Integer
						.parseInt(req.getSession().getAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION).toString());
			} catch (NumberFormatException ex) {
				LOG.error(ex.getMessage(), ex);
				totalPage = 0;
			}
		}
		if (pageCurrent == null) {
			lstSearchResult = (List<SearchResultVO>) req.getSession()
					.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
			processPaging(req, null, null, lstSearchResult, manageCandidate);
		} else {
			pageSet = req.getSession().getAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION).toString();
			try {
				pageCurrentSelected = Integer.parseInt(pageSet);
			} catch (NumberFormatException ex) {
				pageCurrentSelected = 0;
			}
			if (totalPage > 0 && pageCurrentSelected > 0 && pageCurrentSelected < totalPage) {
				lstSearchResult = (List<SearchResultVO>) req.getSession()
						.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
				processPaging(req, pageSet, null, lstSearchResult, manageCandidate);
			} else {
				lstSearchResult = (List<SearchResultVO>) req.getSession()
						.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
				processPaging(req, null, null, lstSearchResult, manageCandidate);
			}
		}
		model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageCandidate);
		return model;
	}

    public List<BaseJSFVO> getCommoditiesFromBDM(
            HebBaseInfo candidateMainForm, String bdmId)
            throws CPSGeneralException {
        Map<String, ClassCommodityVO> classComMap = getCommonService()
                .getCommoditiesForBDM(bdmId);
        if (CPSHelper.isNotEmpty(classComMap)) {
            candidateMainForm.setClassCommodityMap(classComMap);
        }
        List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
        list.addAll(classComMap.values());
        CPSHelper.sortList(list);
        return list;
    }

    /*
	 * Init candidate status. It used for search page
	 *
	 * @author khoapkl
	 */
    public List<BaseJSFVO> initStatus(String userRole) {
        List<BaseJSFVO> allStatus = new ArrayList<BaseJSFVO>();
        if (userRole.equals(BusinessConstants.REGISTERED_VENDOR_ROLE)
                || userRole.equals(
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

    /**
     * <p>
     * processPaging
     * </p>
     *
     * @param request         The HttpServletRequest
     * @param pageSet         String
     * @param request         The HTTP request
     * @param numSet          String
     * @param listResult      List<SearchResultVO>
     * @param manageCandidate ManageCandidate
     * @author vn55306
     */
    private void processPaging(HttpServletRequest request, String pageSet,
                               String numSet, List<SearchResultVO> listResult,
                               ManageCandidate manageCandidate) {
        int totalPage = 0;
        int totalRecord = 0;
        int numView = 10;
        int page = 0;
        HttpSession session = request.getSession();
		/* Check session numView is exist? */
        if (numSet == null || "".equals(numSet)) {
            if (session.getAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION) != null) {
                try {
                    numView = Integer.parseInt(session.getAttribute(
                            CPSConstants.SEARCH_NUMBER_VIEW_SESSION).toString());
                } catch (NumberFormatException nfe) {
                }
            }
        }
        if ((pageSet == null || "".equals(pageSet))
                && (numSet == null || "".equals(numSet))) {
            if (!listResult.isEmpty()) {
                totalRecord = listResult.size();
                totalPage = totalRecord / numView;
                if (totalPage * numView != totalRecord)
                    totalPage++;
                session.setAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION, totalPage);
            }
        } else {
            if (numSet != null && !"".equals(numSet.trim())
                    && (pageSet != null && !"".equals(pageSet))) {
                if (!listResult.isEmpty()) {
                    totalRecord = listResult.size();
                    numView = Integer.parseInt(numSet);
                    session.setAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION, numView);
                    totalPage = totalRecord / numView;
                    if (totalPage * numView != totalRecord)
                        totalPage++;
                    session.setAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION, totalPage);
                    page = Integer.parseInt(pageSet);
                }
            } else if (numSet != null && !"".equals(numSet.trim())) {
                if (!listResult.isEmpty()) {
                    totalRecord = listResult.size();
                    numView = Integer.parseInt(numSet);
                    session.setAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION, numView);
                    totalPage = totalRecord / numView;
                    if (totalPage * numView != totalRecord)
                        totalPage++;
                    session.setAttribute(CPSConstants.SEARCH_TOTAL_PAGE_SESSION, totalPage);
                    page = 0;
                }
            } else {
                if (!listResult.isEmpty()) {
                    totalRecord = listResult.size();
                }
                page = Integer.parseInt(pageSet);
                totalPage = Integer.parseInt(session.getAttribute(
                        CPSConstants.SEARCH_TOTAL_PAGE_SESSION).toString());
            }
        }
        if (listResult.isEmpty()) {
            manageCandidate
                    .setProductsDisplay(new ArrayList<SearchResultVO>());
        } else {
            totalRecord = listResult.size();
            int to = numView * page + numView;
            if (to > totalRecord) {
                to = totalRecord;
            }
            final List<SearchResultVO> pageResult = listResult.subList(numView
                    * page, to);
            if (pageResult == null || pageResult.isEmpty()) {
                manageCandidate.setProductsDisplay(manageCandidate
                        .getProductsTemp());
            } else {
                manageCandidate.setProductsDisplay(pageResult);
            }
            session.setAttribute(CPSConstants.SEARCH__PAGE_CURRENT_SESSION, page);
            session.setAttribute(CPSConstants.SEARCH_NUMBER_VIEW_SESSION, numView);
            request.setAttribute("pageCurrent", page);
            request.setAttribute("numView", numView);
            request.setAttribute("totalRecord", totalRecord);
            request.setAttribute("totalPage", totalPage);
        }
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
    private void populateBDMs(HebBaseInfo manageForm,
                              HttpServletRequest req) throws Exception {
        if (manageForm.getBdms() == null
                || manageForm.getBdms().isEmpty()) {
            List<BaseJSFVO> bdmList = getAppContextFunctions().getBdmList();
            manageForm.setBdms(bdmList);
        }
    }

    /*
     * Get all commodities from Cache and set value into Commodity combo-box
     *
     * @author khoapkl
     */
    private void populateCommodities(HebBaseInfo manageForm, HttpServletRequest req)
            throws Exception {
        if (manageForm.getCommodities() == null
                || manageForm.getCommodities().isEmpty()) {
            List<BaseJSFVO> commodities = getAppContextFunctions()
                    .getCommodityList();
            manageForm.setCommodities(commodities);
        }
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_PRINT_FORM_AJAX)
    public ModelAndView printFormAjax(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,
                                      HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_PRINT_FORM_CANDIDATE_AJAX_PAGE);
        setForm(req, manageCandidate);
        Object objProductId = req.getSession().getAttribute(
                CPSConstants.CPS_PRODUCT_ID_SESSION);
        Object objCandidateType = req.getSession().getAttribute(
                CPSConstants.CPS_CANDIDATE_TYPE_SESSION);
        String productIdArray = manageCandidate.getSelectedProductId();
        String candidateTypeArray = manageCandidate.getCandidateTypeList();
        if (objProductId != null)
            req.getSession().removeAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
        if (objCandidateType != null)
            req.getSession().removeAttribute(CPSConstants.CPS_CANDIDATE_TYPE_SESSION);
        req.getSession().setAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION, productIdArray);
        req.getSession().setAttribute(CPSConstants.CPS_CANDIDATE_TYPE_SESSION,
                candidateTypeArray);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageCandidate);
        return model;
    }
    /**
     * This class is for getting the details for generating the form.
     *
     * @param manageCandidate
     * @param req
     * @param resp
     * @return ActionForward
     * @throws Exception
     */
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_PRINT_FORM)
    public ModelAndView printForm(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_PRINT_FORM_CANDIDATE_PAGE);
        ProductVO productVO = new ProductVO();
        setForm(req, manageCandidate);
        manageCandidate.setRejectClose(false);
        manageCandidate.setRejectComments(CPSConstants.EMPTY_STRING);
        String printArray = (String) req.getSession().getAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
        StringTokenizer st = new StringTokenizer(printArray, CPSConstants.COMMA);
        int productId = 0;
        List<Integer> prodList = new ArrayList<Integer>();
        while (st.hasMoreTokens()) {
            productId = Integer.parseInt(st.nextToken());
            prodList.add(productId);
        }
        String productTypeArray = (String) req.getSession().getAttribute(
                CPSConstants.CPS_CANDIDATE_TYPE_SESSION);// req.getParameter("productTypeArray");
        List<String> prodTypeList = new ArrayList<String>();
        if (null != productTypeArray) {
            StringTokenizer idList = new StringTokenizer(productTypeArray,
                    CPSConstants.COMMA);
            if (idList.hasMoreTokens()) {
                while (idList.hasMoreTokens()) {
                    prodTypeList.add(idList.nextToken());
                }
            }
        }
        int count = 0;
        manageCandidate.setMRTList(new ArrayList<MrtVO>());
        manageCandidate.setPrintFormVOList(new ArrayList<PrintFormVO>());
        manageCandidate.setPrintFormVOMRTList(new ArrayList<PrintFormVO>());
        // Set the form for each product
        for (Integer prodId : prodList) {
            List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();
            if (prodTypeList.get(count).trim().equals(CPSConstants.NONE_MRT)) {
                productVO = getAddNewCandidateService().fetchProductPrint(
                        CPSHelper.getStringValue(prodId), getUserRole(), false);
                if (hasNewVendor(productVO)) {
                    //Sprint - 23
                    productVO.clearUPCKitVOs();
                    productVO.setUpcKitVOs(getAddNewCandidateService().getKitComponents(prodId, false, true));
                    CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                    this.setOneTouchAndSeasons(productVO);
                    if (!productVO.getCaseVOs().isEmpty()) {
                        for (CaseVO caseVO : productVO.getCaseVOs()) {
                            this.setItemCategoryList(caseVO);
                        }
                    }
                    if (null != productVO) {
                        String validationMsg = "";
                        validationMsg = validatePrintForm(productVO);
                        validationMsg = validationMsg.replace(CPSConstants.NEXT_LINE,
                                CPSConstants.EMPTY_STRING).trim();
                        setCreateOnProduct(productVO);
                        if (CPSHelper.isEmpty(validationMsg)) {
                            productVO
                                    .setVendorLocationList(getVendorLocationList());
                            if (BusinessUtil.isVendor(getUserRole())) {
                                productVO.setVendorLogin(true);
                            }
                            printFormVOList = PrintFormHelper
                                    .copyEntityToEntity(productVO, req
                                                    .getSession().getId() + prodId,
                                            req, resp, getCommonService(),
                                            getAddNewCandidateService(),
                                            hebLdapUserService);
                            // Add the forms to the final List
                            if (CPSHelper.isNotEmpty(printFormVOList)) {
                                int i = 0;
                                for (PrintFormVO prtForm : printFormVOList) {
                                    if (i != 0) {
                                        prtForm.setProductDescription(CPSConstants.EMPTY_STRING);
                                    }
                                    // printList.add(prtForm);
                                    manageCandidate.getPrintFormVOList().add(
                                            prtForm);
                                    i++;
                                }
                            }
                        } else {
                            // Before doing the print form, validate it.
                            manageCandidate.setRejectClose(true);
                            req.getSession().setAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS, validationMsg);
                        }
                    }
                } else {
                    manageCandidate.setRejectClose(true);
                    req.getSession().setAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS, "Please select candidate having at least one new vendor.");
                }
            } else {
				/*
				 * Now MRT print is available.
				 */
                try {
                    manageCandidate.getPrintFormVOMRTList().add(
                            getMRTPrintInfo(prodId, manageCandidate));
                } catch (CPSGeneralException e) {
                    LOG.error(e.getMessage(), e);
                    manageCandidate.setRejectClose(true);
                    req.getSession().setAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS, e.getMessage());
                }
            }
            count++;
        }
        if (CPSHelper.isNotEmpty(manageCandidate.getPrintFormVOMRTList())
                || CPSHelper.isNotEmpty(manageCandidate.getPrintFormVOList())) {
            manageCandidate.setRejectClose(false);
            req.getSession().setAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS, CPSConstants.EMPTY_STRING);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_PRINT_FORM_MRT)
    public String printMRT(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        //setForm(req, manageCandidate);
        List<MrtVO> mrtVOs = manageCandidate.getMRTList();
        if (CPSHelper.isEmpty(mrtVOs)) {
            mrtVOs = (List<MrtVO>) req.getSession().getAttribute("MRTList");
            ManageCandidate form =  (ManageCandidate)req.getSession().getAttribute(ManageCandidate.FORM_NAME);
            if(form != null && mrtVOs == null || mrtVOs.isEmpty()){
                mrtVOs = form.getMRTList();
            }
        }
        String mrtID = req.getParameter("mrtId");
        MrtVO selectedMRT = null;
        if (CPSHelper.isNotEmpty(mrtID) && mrtVOs != null) {
            Integer iMrtId = Integer.valueOf(mrtID.trim());
            for (MrtVO mrtVO : mrtVOs) {
                if (mrtVO.getWorkRequest().getWorkIdentifier().equals(iMrtId)) {
                    selectedMRT = mrtVO;
                    break;
                }
            }
        }
        String fileName = "";
        String mrtVenID = req.getParameter("mrtVenId");
        if (CPSHelper.isNotEmpty(mrtVenID)) {
            if (selectedMRT != null) {
                fileName = printMRTVendor(selectedMRT, mrtVenID, req, resp);
            }
        } else {
            String prodID = req.getParameter("prodID");
            String prodVenID = req.getParameter("prodVenId");
            fileName = printMRTProduct(selectedMRT, prodID, prodVenID, req,
                    resp);
        }

        resp.sendRedirect("../../../protected/PrintFormViewerServlet?errorMessage="
                + fileName);
        return null;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_PRINT_SUMARY)
    public ModelAndView printSummary(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        List<SearchResultVO> results = (List<SearchResultVO>) req.getSession()
                .getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
        UserInfo userInfo = getUserInfo();
        String userFullName = "";
        userFullName = userInfo.getAttributeValue("givenName") + " "
                + userInfo.getAttributeValue("sn") + " [" + userInfo.getUid()
                + "]";
        String printArray = manageCandidate.getSelectedProductId();
        StringTokenizer st = new StringTokenizer(printArray, ",");
        List<Integer> prodIdList = new ArrayList<Integer>();
        HttpSession session = req.getSession();
        while (st.hasMoreTokens()) {
            prodIdList.add(Integer.parseInt(st.nextToken()));
        }
        boolean hasVendor = false;
        for (Integer productId : prodIdList) {
            PrintFormVO printFormVO = getSelectedVendorDescription(results,
                    productId);
            if (null == printFormVO
                    || null == printFormVO.getVendorName()
                    || CPSConstants.EMPTY_STRING.equalsIgnoreCase(printFormVO
                    .getVendorName())) {
                hasVendor = false;
            } else {
                hasVendor = true;
                break;
            }
        }
        if (hasVendor) {
            setForm(req, manageCandidate);
            CPSExportToExcel exportToExcel = new CPSExportToExcel();
            String prodIdNormal = "";
            List<String> prodIdMrt = new ArrayList<String>();
            List<String> lstProdType = new ArrayList<String>();
            List<PrintSumaryProductVO> finalPrintList = new ArrayList<PrintSumaryProductVO>();
            String candTpeVal = manageCandidate.getCandidateTypeList();
            StringTokenizer candTypeList = new StringTokenizer(candTpeVal,
                    CPSConstants.COMMA);
            while (candTypeList.hasMoreTokens()) {
                lstProdType.add(candTypeList.nextToken());
            }
            int index = 0;
            for (String candTyp : lstProdType) {
                if (CPSHelper.isNotEmpty(candTyp) && candTyp.equals(CPSConstants.NONE_MRT)) {
                    prodIdNormal = prodIdNormal + prodIdList.get(index) + CPSConstants.COMMA;
                } else {
                    if (CPSHelper.isNotEmpty(prodIdList.get(index))) {
                        prodIdMrt.add(String.valueOf(prodIdList.get(index)));
                    }
                }
                index++;
            }
            if (CPSHelper.isNotEmpty(prodIdNormal)) {
                prodIdNormal = prodIdNormal.substring(0,
                        prodIdNormal.lastIndexOf(CPSConstants.COMMA));
                finalPrintList = getAddNewCandidateService()
                        .getPrintSummaryCandidateNormal(prodIdNormal,
                                userFullName);
            }
            if (CPSHelper.isNotEmpty(prodIdMrt)) {
                List<PrintSumaryProductVO> lstPrintSumaryMRT = getAddNewCandidateService()
                        .getPrintSummaryCandidateMRT(prodIdMrt, userFullName);
                if (lstPrintSumaryMRT != null && !lstPrintSumaryMRT.isEmpty()) {
                    finalPrintList.addAll(lstPrintSumaryMRT);
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
                if (CPSHelper.isNotEmpty(finalPrintList)) {
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
                }
                finalPrintList = finalPrintListTemp;
            }
            CandidateSearchCriteria searchCriteria = manageCandidate
                    .getCriteria();
            if (CPSHelper.isNotEmpty(searchCriteria.getStatus())) {
                if (manageCandidate.getAllStatus() != null
                        && !manageCandidate.getAllStatus().isEmpty()) {
                    for (BaseJSFVO baseJSFVO : manageCandidate.getAllStatus()) {
                        if (baseJSFVO.getId() != null
                                && baseJSFVO.getId().equals(
                                searchCriteria.getStatus())) {
                            searchCriteria.setStatusName(baseJSFVO.getName());
                            break;
                        }
                    }
                }
            } else {
                searchCriteria.setStatusName("");
            }
            if (CPSHelper.isNotEmpty(searchCriteria.getTestScanStatus())) {
                if (manageCandidate.getTestScans() != null
                        && !manageCandidate.getTestScans().isEmpty()) {
                    for (BaseJSFVO baseJSFVO : manageCandidate.getTestScans()) {
                        if (baseJSFVO.getId() != null
                                && baseJSFVO.getId().equals(
                                searchCriteria.getTestScanStatus())) {
                            searchCriteria.setTestScanStatusName(baseJSFVO
                                    .getName());
                            break;
                        }
                    }
                }
            } else {
                searchCriteria.setTestScanStatusName("");
            }
            if (CPSHelper.isNotEmpty(searchCriteria.getProductType())) {
                if (manageCandidate.getProductTypes() != null
                        && !manageCandidate.getProductTypes().isEmpty()) {
                    for (BaseJSFVO baseJSFVO : manageCandidate.getProductTypes()) {
                        if (baseJSFVO.getId() != null
                                && baseJSFVO
                                .getId()
                                .trim()
                                .equals(searchCriteria.getProductType())) {
                            searchCriteria.setProductTypeName(baseJSFVO
                                    .getName());
                            break;
                        }
                    }
                }
            } else {
                searchCriteria.setProductTypeName("");
            }
            List<String> columnHeadings = columnHeadingCandidates();
            exportToExcel.exportToExcelCandidate(columnHeadings,
                    finalPrintList, "PrintSummary", null, searchCriteria, resp,
                    req, hebLdapUserService);
            model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
            return model;

        } else {
            CPSMessage message = new CPSMessage(
                    "Please select candidate having vendor", CPSMessage.ErrorSeverity.INFO);
            saveMessage(manageCandidate, message);
            manageCandidate.setSelectedProductId("");
            manageCandidate.setCandidateTypeList("");
            manageCandidate.setSelectedProdWorkRqstId("");
            manageCandidate.setSelectedProductCandidateId("");
            manageCandidate.setActivateSwitch(true);
            searchCandidate(manageCandidate, req, resp);
            manageCandidate.setActivateSwitch(false);
            model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        }
        return model;
    }

    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_ACTIVATE)
    public ModelAndView activate(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        manageCandidate.getStatusCandidates().clear();
        List<SearchResultVO> results = (List<SearchResultVO>) req.getSession()
                .getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
        List<MrtVO> mrtVOList = new ArrayList<MrtVO>();
        List<Integer> activatedWorkIdListMRT = new ArrayList<Integer>();
        StringBuffer checkMRTMessage = new StringBuffer();
        checkMRTMessage.append(CPSConstants.EMPTY_STRING);
        List<Integer> activatedWorkIdListCadidates = new ArrayList<Integer>();
        StringBuffer checkCadidatesMessage = new StringBuffer();
        checkCadidatesMessage.append(CPSConstants.EMPTY_STRING);
        List<Integer> activatedWorkIdListBatchUploadCadidates = new ArrayList<Integer>();
        StringBuffer checkBatchUploadCadidatesMessage = new StringBuffer();
        checkBatchUploadCadidatesMessage.append(CPSConstants.EMPTY_STRING);
        int indexCandidateTypeList = 0;
        ArrayList<String> candidateTypeLists = new ArrayList<String>();
//        AddNewCandidateAction action = new AddNewCandidateAction();
        CPSMessage message;
        int checkActivate = 0;
        StringTokenizer stCandidateTypeList = new StringTokenizer(
                manageCandidate.getCandidateTypeList(), CPSConstants.COMMA);
        while (stCandidateTypeList.hasMoreTokens()) {
            candidateTypeLists.add(stCandidateTypeList.nextToken());
        }
        // init dropdown list for bdm, commodity, subcommodity, class, product types, status
        this.setDataAutoComplete(manageCandidate,req);
        if (CPSHelper.isEmpty(manageCandidate.getClasses())) {
        	manageCandidate.setClasses(this.getCommonService().getClassesAsBaseJSFVOs());
        }
		if (CPSHelper.isEmpty(manageCandidate.getProductTypes())) {
			manageCandidate.setProductTypes(getAppContextFunctions().getProductTypes());
		}
        manageCandidate.setAllStatus(initStatus(getUserRole()));
        String resultArray = manageCandidate.getSelectedProdWorkRqstId();
        StringTokenizer st = new StringTokenizer(resultArray,
                CPSConstants.COMMA);
        int workId = 0;
        String productId = "0";
        List<String> productIdList = new ArrayList<String>();
        while (st.hasMoreTokens()) {
            productIdList.add(st.nextToken());
        }
        if (manageCandidate.isHidBatchUploadSwitch()) {
            checkActivate = checkBatchUploadValidateActivate(results,
                    productIdList);
            if (checkActivate == 0) {
                message = new CPSMessage(
                        CPSConstants.CHECK_CANDIDATES_BATCHUPLOAD_ACTIVEDFAIL,
                        CPSMessage.ErrorSeverity.INFO);
                saveMessage(manageCandidate, message);
                model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
                return model;
            }
        }

        for (String string : productIdList) {
            StringTokenizer integerSt = new StringTokenizer(string
                    + CPSConstants.EMPTY_STRING, CPSConstants.SEMI_COLON);
            while (integerSt.hasMoreTokens()) {
                try {
                    workId = Integer.parseInt(integerSt.nextToken());
                } catch (NumberFormatException e) {
                    workId = 0;
                }
                if (integerSt.hasMoreTokens()) {
                    productId = integerSt.nextToken();
                }
                if (manageCandidate.isHidBatchUploadSwitch()) {
                    if (checkActivate == 1) {
                        activateCandidate(workId, productId,
                                activatedWorkIdListCadidates, results,
                                checkCadidatesMessage,
                                this.getLstVendorId(req));
                    } else {
                        activateBatchUploadCandidate(workId, productId,
                                activatedWorkIdListBatchUploadCadidates,
                                results, checkBatchUploadCadidatesMessage);
                    }
                } else {
                    if (candidateTypeLists.get(indexCandidateTypeList).trim()
                            .equals(CPSConstants.MRT)) {
                        manageCandidate.getStatusCandidates().put(workId,
                                true);
                        activateMRTCandidate(workId, productId,
                                activatedWorkIdListMRT, results, mrtVOList,
                                checkMRTMessage);
                    } else {
                        manageCandidate.getStatusCandidates().put(workId,
                                false);
                        activateCandidate(workId, productId,
                                activatedWorkIdListCadidates, results,
                                checkCadidatesMessage,
                                this.getLstVendorId(req));
                    }
                    indexCandidateTypeList++;
                }
            }
        }
        /**
         * set the ActivatedWorkIdList in to the session.
         */
        if (manageCandidate.isHidBatchUploadSwitch() && checkActivate != 1) {
            if (!activatedWorkIdListBatchUploadCadidates.isEmpty()) {
                req.setAttribute(CPSConstants.MESSAGETITLE, CPSConstants.SUBMITTED_TITLE);
                req.getSession().setAttribute(CPSConstants.IS_MRT, "N");
                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, "Y");
                if (activatedWorkIdListBatchUploadCadidates.size() == 1) {
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "Y");
                } else {
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "N");
                }
                req.getSession().setAttribute(CPSConstants.ACTIVATED_WORK_IDS,
                        activatedWorkIdListBatchUploadCadidates);
                req.getSession().setAttribute(CPSConstants.CHECK_ACTIVED_FAIL, false);

                // trungnv call triigger after change status to 111.
                getCommonService().approveDSDWS("CPSA");

            } else {
                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, "N");
            }
            if (CPSConstants.EMPTY_STRING
                    .equalsIgnoreCase(checkBatchUploadCadidatesMessage
                            .toString()
                            .replace(CPSConstants.NEXT_LINE,
                                    CPSConstants.EMPTY_STRING).trim())) {
                List<SearchResultVO> correctedList = removeActivatedCandidate(
                        activatedWorkIdListBatchUploadCadidates,
                        manageCandidate, req);
                manageCandidate.setProductsTemp(correctedList);
                manageCandidate.setProducts(correctedList);
                if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION,
                        correctedList);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION,
                        correctedList);
                message = new CPSMessage(CPSConstants.CANDIDATES_SUBMITTED_SUCCESSFULLY,
                        CPSMessage.ErrorSeverity.INFO);
            } else {
                List<SearchResultVO> correctedList = removeActivatedCandidate(
                        activatedWorkIdListBatchUploadCadidates,
                        manageCandidate, req);
                manageCandidate.setProductsTemp(correctedList);
                manageCandidate.setProducts(correctedList);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION,
                        correctedList);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION,
                        correctedList);
                message = new CPSMessage(
                        checkBatchUploadCadidatesMessage.toString(),
                        CPSMessage.ErrorSeverity.ERROR);
            }
            saveMessage(manageCandidate, message);
        } else {
            int activatedWorkIdListMRTLenght = 0;
            int activatedWorkIdListCadidatesLenght = 0;
            activatedWorkIdListMRTLenght = activatedWorkIdListMRT.size();
            activatedWorkIdListCadidatesLenght = activatedWorkIdListCadidates
                    .size();
            List<Integer> activatedWorkIdList = new ArrayList<Integer>();
            if (activatedWorkIdListMRTLenght > 0
                    || activatedWorkIdListCadidatesLenght > 0) {
                if (activatedWorkIdListMRTLenght > 0) {
                    activatedWorkIdList.addAll(activatedWorkIdListMRT);
                }
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
            String checkMessage = checkMRTMessage.toString()
                    + checkCadidatesMessage.toString();
            if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(checkMessage
                    .replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING)
                    .trim())) {
                List<SearchResultVO> correctedList = removeActivatedCandidate(
                        activatedWorkIdList, manageCandidate, req);
                manageCandidate.setProductsTemp(correctedList);
                manageCandidate.setProducts(correctedList);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION,
                        correctedList);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION,
                        correctedList);
                message = new CPSMessage(CPSConstants.CANDIDATES_ACTIVATED_SUCCESSFULLY,
                        CPSMessage.ErrorSeverity.INFO);
            } else {
                List<SearchResultVO> correctedList = removeActivatedCandidate(
                        activatedWorkIdList, manageCandidate, req);
                manageCandidate.setProductsTemp(correctedList);
                manageCandidate.setProducts(correctedList);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION,
                        correctedList);
                req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION,
                        correctedList);
                message = new CPSMessage(checkMessage, CPSMessage.ErrorSeverity.ERROR);
            }
            saveMessage(manageCandidate, message);
        }
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        results = (List<SearchResultVO>) req.getSession().getAttribute(
                CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
        processPaging(req, null, null, results, manageCandidate);
        manageCandidate.setSelectedProductId("");
        manageCandidate.setCandidateTypeList("");
        manageCandidate.setSelectedProdWorkRqstId("");
        manageCandidate.setSelectedProductCandidateId("");
		manageCandidate.setValidForResults(true);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    /**
     * shows the 'authorize WHS' pop up
     *
     * @param manageCandidate
     * @param req
     * @param resp
     * @return
     * @throws Exception
     */
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_TEST_SCAN)
    public ModelAndView testScan(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_TEST_SCAN_PAGE);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        boolean hasScannableUPC = false;
        manageCandidate.clearUPCVOs();
        String resultArray = (String) req.getSession().getAttribute(
                CPSConstants.CPS_PRODUCT_ID_SESSION);
        StringTokenizer st = new StringTokenizer(resultArray, CPSConstants.COMMA);
        List<Integer> productIdList = new ArrayList<Integer>();
        int productSize = 0;
        while (st.hasMoreTokens()) {
            productIdList.add(Integer.parseInt(st.nextToken()));
        }
        Map<String, List<UPCVO>> products = getAddNewCandidateService()
                .getTestScanUpc(productIdList);
        boolean nonSavedUPC = false;
        boolean nonSellable = false;
        if (null != products && !products.isEmpty()) {
            hasScannableUPC = true;
            for (Map.Entry<String, List<UPCVO>> entry : products.entrySet()) {
                String key = entry.getKey();
                if (key.split("_")[1].equalsIgnoreCase("SPLY")) {
                    nonSellable = true;
                    break;
                }
                for (UPCVO upcvo : entry.getValue()) {
                    if (upcvo.getSeqNo() == 0) {
                        nonSavedUPC = true;
                        break;
                    }
                }
            }
        }

        if (nonSavedUPC) {
            manageCandidate
                    .setRejectComments("Please save the candidate to do Test Scan");
            manageCandidate.setRejectClose(true);
        } else {
            if (nonSellable) {
                CPSMessage message = new CPSMessage(
                        "Selected candidate(s) don't have UPC's for Testscan",
                        CPSMessage.ErrorSeverity.ERROR);
                saveMessage(manageCandidate, message);
            } else {
                for (Map.Entry<String, List<UPCVO>> entry : products.entrySet()) {
                    for (UPCVO upcvo : entry.getValue()) {
                        if ("UPC".equalsIgnoreCase(upcvo.getUpcType())
                                || "HEB".equalsIgnoreCase(upcvo.getUpcType())) {
                            if ('Y' == upcvo.getNewDataSw()) {
                                if (CPSHelper.isEmpty(upcvo.getTestScanUPC())) {
                                    manageCandidate.addUpcVOs(upcvo);
                                }
                            }
                        }
                    }
                }
            }
            if (null != products) {
                productSize = products.size();
            }
            manageCandidate.setProductsSize(productSize);
            manageCandidate.setRejectClose(false);
        }
        String userRole = getUserRole();
        if (BusinessConstants.ADMIN_ROLE.equalsIgnoreCase(userRole)
                || BusinessConstants.PIA_LEAD_ROLE.equalsIgnoreCase(userRole)) {
            manageCandidate.setTestScanUserSwitch(true);
        } else {
            manageCandidate.setTestScanUserSwitch(false);
        }
        if (manageCandidate.getUpcVOs().isEmpty()) {
            if (hasScannableUPC == false) {
                CPSMessage message = new CPSMessage(
                        "All UPC's of the selected Candidate have been Testscaned",
                        CPSMessage.ErrorSeverity.INFO);
                saveMessage(manageCandidate, message);
            } else {
                CPSMessage message = new CPSMessage(
                        "Selected candidate(s) don't have UPC's for Testscan",
                        CPSMessage.ErrorSeverity.ERROR);
                saveMessage(manageCandidate, message);
            }
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_TEST_SCAN_AJAX)
    public ModelAndView testScanAjax(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_TEST_SCAN_AJAX_PAGE);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        Object objProductId = req.getSession().getAttribute(
                CPSConstants.CPS_PRODUCT_ID_SESSION);
        String productIdArray = manageCandidate.getSelectedProductId();
        if (objProductId != null) {
            req.getSession().removeAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
        }
        req.getSession().setAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION, productIdArray);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_SUBMIT)
    public ModelAndView submitCandidate(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        int indexCandidateTypeList = 0;
        ArrayList<String> candidateTypeLists = new ArrayList<String>();
        CPSMessage message = null;
        StringTokenizer stCandidateTypeList = new StringTokenizer(
                manageCandidate.getCandidateTypeList(), CPSConstants.COMMA);
        while (stCandidateTypeList.hasMoreTokens()) {
            candidateTypeLists.add(stCandidateTypeList.nextToken());
        }
        String resultArray = manageCandidate.getSelectedProductId();
        StringTokenizer st = new StringTokenizer(resultArray,
                CPSConstants.COMMA);
        boolean isError = false;
        String productIdError = "";
        String candidateType = "";
        StringBuilder finalCpsMessage = new StringBuilder();
        finalCpsMessage.append(CPSConstants.EMPTY_STRING);
        List<String> productIdList = new ArrayList<String>();
        while (st.hasMoreTokens()) {
            productIdList.add(st.nextToken());
        }
        for (String productIds : productIdList) {
            if (candidateTypeLists.get(indexCandidateTypeList).trim()
                    .equals(CPSConstants.MRT)) {
                if (!this.submitMRTCandidateHandle(productIds, getUserRole())) {
                    productIdError = productIds;
                    candidateType = candidateTypeLists.get(
                            indexCandidateTypeList).trim();
                    isError = true;
                    break;
                }
            } else {
                if (!submitCandHandle(productIds, getUserRole())) {
                    productIdError = productIds;
                    candidateType = candidateTypeLists.get(
                            indexCandidateTypeList).trim();
                    isError = true;
                    break;
                }
            }
            indexCandidateTypeList++;
        }
        if (isError) {
            if (candidateType.equals(CPSConstants.MRT)) {
                MrtVO searchMrtVO = getAddNewCandidateService()
                        .fetchMRTProduct(productIdError);
                String mrtName = searchMrtVO.getCaseVO().getCaseDescription();
                String caseUPC = searchMrtVO.getCaseVO().getCaseUPC();
                String messageStr = "";
                String submitCheckMRT = getAddNewCandidateService()
                        .submitMRTValidator(searchMrtVO, getUserRole());
                submitCheckMRT = submitCheckMRT
                        .replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
                if (!this.checkRolesForSubmitMRTCandidate(searchMrtVO)) {
                    messageStr = "Only Candidates in Vendor Candidate Status can be submitted. "
                            + "The Current Status of the Candidate is ["
                            + searchMrtVO.getWorkRequest().getWorkStatusAbb()
                            + "]";
                    finalCpsMessage.append(messageStr);
                } else {
                    if (!CPSConstants.EMPTY_STRING
                            .equalsIgnoreCase(submitCheckMRT)) {
                        messageStr = "The following fields are mandatory for submitting  candidate  ";
                        messageStr += "CASE UPC [" + caseUPC
                                + "] with Case Desription" + mrtName + " ,"
                                + "<BR>" + submitCheckMRT + "<BR>";
                        finalCpsMessage.append(messageStr);
                    }
                }
            } else {
                ProductVO searchProductVo = new ProductVO();
                String productName = CPSConstants.EMPTY_STRING;
                String messageStr = "";
                searchProductVo = getAddNewCandidateService().fetchProduct(
                        productIdError, getUserRole());
                productName = searchProductVo.getClassificationVO()
                        .getProdDescritpion();
                String submitCheck = SubmitValidator
                        .mandatoryCheck(searchProductVo);
                if (this.checkRolesForSubmitCandidate(searchProductVo)) {
                    messageStr = "The following fields are mandatory for submitting  candidate  ";
                    messageStr += productName + " ," + "<BR>" + submitCheck
                            + "<BR>";
                    finalCpsMessage.append(messageStr);
                } else {
                    messageStr = "Only Candidates in Vendor Candidate Status can be submitted. "
                            + "The Current Status of the Candidate is ["
                            + searchProductVo.getWorkRequest()
                            .getWorkStatusAbb() + "]";
                    finalCpsMessage.append(messageStr);
                }
            }
            message = new CPSMessage(finalCpsMessage.toString(),
                    CPSMessage.ErrorSeverity.ERROR);
        } else {
            message = new CPSMessage(CPSConstants.CANDIDATES_SUBMITTED, CPSMessage.ErrorSeverity.INFO);
        }
        saveMessage(manageCandidate, message);
        // Re calling the search function - starts
        manageCandidate.setActivateSwitch(true);
        this.searchCandidate(manageCandidate, req, resp);
        manageCandidate.setActivateSwitch(false);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    /**
     * PIM-1642 Delete Candidates
     *
     * @param manageCandidate the form
     * @param req the request
     * @param resp the response
     * @return to the screen
     * @throws Exception the exception
     */
    @SuppressWarnings("unchecked")
	@RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_DELETE_CANDIDATE)
    public ModelAndView deleteCand(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        StringTokenizer idList = new StringTokenizer(manageCandidate.getSelectedProductId(), CPSConstants.COMMA);
        List<Integer> psWorkIdList = new ArrayList<Integer>();
        while (idList.hasMoreElements()) {
            int prodId = CPSHelper.getIntegerValue(idList.nextToken());
			List<SearchResultVO> results = (List<SearchResultVO>) req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
			if (CPSHelper.isEmpty(results)) {
				results = (List<SearchResultVO>) req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION);
			}
            for (SearchResultVO searchResultVO : results) {
                if (prodId == searchResultVO.getPsProdId()) {
                    psWorkIdList.add(searchResultVO.getWorkIdentifier());
                }
            }
        }
        if (CPSHelper.isNotEmpty(psWorkIdList)) {
            String status = getCommonService().changeStatusCandidateList(psWorkIdList, CPSConstants.DELETED);
            req.setAttribute(CPSConstants.MY_MESSAGE, CPSConstants.CANDIDATES + status);
        }
        searchCandidate(manageCandidate, req, resp);
        CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_DELETED_SUCCESS, CPSMessage.ErrorSeverity.VALIDATION);
        saveMessage(manageCandidate, message);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_REJECT_CANDIDATE)
    public ModelAndView rejectCand(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String status = null;
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_REJECT_CANDIDATE_PAGE);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        String resultArray = (String) req.getSession().getAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
		StringTokenizer selectedProdIds = new StringTokenizer(resultArray, CPSConstants.COMMA);
		List<String> rejectProdId = new ArrayList<String>();
		while (selectedProdIds.hasMoreTokens()) {
			rejectProdId.add(selectedProdIds.nextToken());
		}
        for (String stringVal : rejectProdId) {
            int prodId = CPSHelper.getIntegerValue(stringVal);
            List<SearchResultVO> results = (List<SearchResultVO>) req
                    .getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            if (CPSHelper.isEmpty(results)) {
                List<SearchResultVO> resultSession = (List<SearchResultVO>) req
                        .getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION);
                if (CPSHelper.isNotEmpty(resultSession)) {
                    results = resultSession;
                }
            }
            for (SearchResultVO searchResultVO : results) {
                if (prodId == searchResultVO.getPsProdId()) {
                    status = getCommonService().rejectCandidate(
                            searchResultVO.getWorkIdentifier(),
                            searchResultVO.getRecordCreationUserId(),
                            getUserRole(), getUserInfo().getUserName());
                    req.setAttribute(CPSConstants.MY_MESSAGE, CPSConstants.CANDIDATES + status);
                }
            }
        }
        manageCandidate.setRejectClose(true);
        CPSMessage message = new CPSMessage(CPSConstants.SAVED_SUCCESSFULLY,
                CPSMessage.ErrorSeverity.VALIDATION);
        saveMessage(manageCandidate, message);
        Object currentMode = req.getSession().getAttribute(
                CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        req.getSession().setAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS, CPSConstants.CANDIDATE_REJECT_SUCCESS);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }

    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_REJECT_CANDIDATE_AND_COMMENTS)
    public ModelAndView rejectCandComments(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        StringBuffer returnStringBuffer = new StringBuffer();
        returnStringBuffer.append(CPSConstants.EMPTY_STRING);
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_REJECT_CANDIDATE_PAGE);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        String resultArray = (String) req.getSession().getAttribute(
                CPSConstants.CPS_PRODUCT_ID_SESSION);
        StringTokenizer st = new StringTokenizer(resultArray,
                CPSConstants.COMMA);
        Set<String> productIdList = new HashSet<String>();
        while (st.hasMoreTokens()) {
            productIdList.add(st.nextToken());
        }
        ArrayList<String> candidateTypeLists = new ArrayList<String>();
        String resultCandidateTypes = (String) req.getSession().getAttribute(
                CPSConstants.CPS_CANDIDATE_TYPE_SESSION);
        StringTokenizer stCandidateTypeList = new StringTokenizer(
                resultCandidateTypes, CPSConstants.COMMA);
        while (stCandidateTypeList.hasMoreTokens()) {
            candidateTypeLists.add(stCandidateTypeList.nextToken());
        }
        manageCandidate.setRejectCommentsProdId(new ArrayList<String>(productIdList));
        manageCandidate.setRejectCommentsProdIdType(candidateTypeLists);
        manageCandidate.setRejectComments(CPSConstants.EMPTY_STRING);
        manageCandidate.setRejectClose(false);
        // User Privilage Checking
        List<SearchResultVO> results = (List<SearchResultVO>) req.getSession()
                .getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
        String userRole = getUserRole();
        boolean flag = false;
        for (String stringVal : productIdList) {
            for (SearchResultVO searchResultVO : results) {
                if (stringVal.equals(CPSHelper.getStringValue(searchResultVO
                        .getPsProdId()))
                        && BusinessUtil.isVendor(userRole)
                        && CPSConstants.WORKING_CANDIDATE_STATUS.equalsIgnoreCase(searchResultVO
                        .getWorkStatusDesc())) {
                    returnStringBuffer.append(searchResultVO
                            .getProdDescription());
                    returnStringBuffer.append(", ");
                    flag = true;
                }
            }
        }
        if (flag) {
            StringBuffer buffer = new StringBuffer();
            buffer.append("Only Candidates in Vendor Candidate Status can be rejected. The Following product description candidates are in Working Candidate status - ");
            buffer.append(returnStringBuffer.toString());
            CPSMessage message = new CPSMessage(CPSConstants.VENDOR_REJECT,
                    CPSMessage.ErrorSeverity.ERROR);
            saveMessage(manageCandidate, message);
            manageCandidate.setRejectClose(true);
            req.getSession().setAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS, buffer.toString());
        } else {
            manageCandidate.setRejectClose(false);
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_REJECT_MRT_CANDIDATE)
    public ModelAndView rejectMRTCandidate(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        String status = null;
        StringBuffer returnStringBuffer = new StringBuffer();
        returnStringBuffer.append(CPSConstants.EMPTY_STRING);
        boolean flag = false;
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        clearMessages(manageCandidate);
        String resultArray = manageCandidate.getSelectedProductId();
        StringTokenizer st = new StringTokenizer(resultArray,
                CPSConstants.COMMA);
        List<String> productIdList = new ArrayList<String>();
        while (st.hasMoreTokens()) {
            productIdList.add(st.nextToken());
        }
        manageCandidate.setRejectCommentsProdId(productIdList);
        // Fix 1307
        List<String> rejectProdId = manageCandidate.getRejectCommentsProdId();
        for (String stringVal : productIdList) {
            List<SearchResultVO> results = (List<SearchResultVO>) req
                    .getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            if (results != null) {
                for (SearchResultVO searchResultVO : results) {
                    if (stringVal.equals(CPSHelper
                            .getStringValue(searchResultVO.getPsProdId()))
                            && BusinessUtil.isVendor(getUserRole())
                            && CPSConstants.WORKING_CANDIDATE_STATUS
                            .equalsIgnoreCase(searchResultVO
                                    .getWorkStatusDesc())) {
                        returnStringBuffer.append(searchResultVO
                                .getProdDescription());
                        returnStringBuffer.append(", ");
                        flag = true;
                    }
                }
            }
        }
        if (flag) {
            StringBuffer buffer = new StringBuffer();
            buffer.append("Only Candidates in Vendor Candidate Status can be rejected. The following MRT candidates are in Working Candidate status - ");
            buffer.append(returnStringBuffer.toString());
            CPSMessage message = new CPSMessage(buffer.toString(),
                    CPSMessage.ErrorSeverity.ERROR);
            saveMessage(manageCandidate, message);
        } else {
            for (String stringVal : rejectProdId) {
                int prodId = CPSHelper.getIntegerValue(stringVal);
                List<SearchResultVO> results = (List<SearchResultVO>) req
                        .getSession().getAttribute(
                                CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                for (SearchResultVO searchResultVO : results) {
                    if (prodId == searchResultVO.getPsProdId()) {
                        status = getCommonService().rejectCandidate(
                                searchResultVO.getWorkIdentifier(),
                                searchResultVO.getRecordCreationUserId(),
                                getUserRole(), getUserInfo().getUserName());
                        req.setAttribute(CPSConstants.MY_MESSAGE, CPSConstants.CANDIDATES + status);
                    }
                }
            }
            CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_REJECT_SUCCESS,
                    CPSMessage.ErrorSeverity.VALIDATION);
            saveMessage(manageCandidate, message);
            // Re calling the search function - starts
            manageCandidate.setActivateSwitch(true);
            searchCandidate(manageCandidate, req, resp);
            manageCandidate.setActivateSwitch(false);
            // Re calling the search function - Ends
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_REJECT_CANDIDATE_AND_COMMENTS_AJAX)
    public ModelAndView rejectCandCommentsAjax(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+RELATIVE_PATH_REJECT_CANDIDATE_AJAX_PAGE);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        Object objProductId = req.getSession().getAttribute(
                CPSConstants.CPS_PRODUCT_ID_SESSION);
        Object objCandidateType = req.getSession().getAttribute(
                CPSConstants.CPS_CANDIDATE_TYPE_SESSION);
        String productIdArray = manageCandidate.getSelectedProductId();
        String candidateTypeArray = manageCandidate.getCandidateTypeList();
        if (objProductId != null)
            req.getSession().removeAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
        if (objCandidateType != null)
            req.getSession().removeAttribute(CPSConstants.CPS_CANDIDATE_TYPE_SESSION);
        req.getSession().setAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION, productIdArray);
        req.getSession().setAttribute(CPSConstants.CPS_CANDIDATE_TYPE_SESSION,
                candidateTypeArray);
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }
    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_SAVE_COMMENTS)
    public ModelAndView saveComments(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
		String resultArray = (String) req.getSession().getAttribute(CPSConstants.CPS_PRODUCT_ID_SESSION);
		StringTokenizer selectedProdIds = new StringTokenizer(resultArray, CPSConstants.COMMA);
		List<String> rejectProdId = new ArrayList<String>();
		while (selectedProdIds.hasMoreTokens()) {
			rejectProdId.add(selectedProdIds.nextToken());
		}
		List<String> rejectProdType = new ArrayList<String>();
		String resultCandidateTypes = (String) req.getSession().getAttribute(CPSConstants.CPS_CANDIDATE_TYPE_SESSION);
		StringTokenizer stCandidateTypeList = new StringTokenizer(resultCandidateTypes, CPSConstants.COMMA);
		while (stCandidateTypeList.hasMoreTokens()) {
			rejectProdType.add(stCandidateTypeList.nextToken());
		}
        int indexCandidateTypeList = 0;
        for (String stringVal : rejectProdId) {
            if (CPSConstants.NONE_MRT.equals(rejectProdType.get(indexCandidateTypeList)
                    .trim())) {
                ProductVO productVO = getAddNewCandidateService().fetchProduct(
                        stringVal, getUserRole());
                productVO.getClassificationVO().setComments(
                        manageCandidate.getRejectComments());
                productVO.getClassificationVO().setVendorVisibilitySw(false);
                productVO.getClassificationVO().setUser(getUserRole());
                productVO = getAddNewCandidateService().insertComments(
                        productVO);
                CPSMessage message = new CPSMessage(
                        CPSConstants.COMMENTS_SAVED_SUCCESSFULLY, CPSMessage.ErrorSeverity.INFO);
                saveMessage(manageCandidate, message);
            }
            indexCandidateTypeList++;
        }
        return rejectCand(manageCandidate, req, resp);
    }

    @RequestMapping(method ={RequestMethod.POST,RequestMethod.GET} , value = RELATIVE_PATH_UPDATE_REJECT_COMMENTS)
    public ModelAndView updateRejectMessage(@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        manageCandidate.setSession(req.getSession());
        setForm(req, manageCandidate);
        String errorMessage = (String) req.getSession().getAttribute(CPSConstants.REJECTE_MESSAGE_COMMENTS);
        if (CPSConstants.CANDIDATE_REJECT_SUCCESS
                .equalsIgnoreCase(errorMessage)) {
            CPSMessage message = new CPSMessage(errorMessage,
                    CPSMessage.ErrorSeverity.VALIDATION);
            saveMessage(manageCandidate, message);
        } else {
            CPSMessage message = new CPSMessage(errorMessage,
                    CPSMessage.ErrorSeverity.ERROR);
            saveMessage(manageCandidate, message);
        }
        // Re calling the search function - starts
        manageCandidate.setActivateSwitch(true);
        searchCandidate(manageCandidate, req, resp);
        manageCandidate.setActivateSwitch(false);
        // Re calling the search function - Ends
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,manageCandidate);
        return model;
    }

    public boolean submitCandHandle(String productId, String userRole)
            throws Exception {
        ProductVO searchProductVo = new ProductVO();
        boolean isSubmit = false;
        searchProductVo = getAddNewCandidateService().fetchProduct(productId,
                userRole);
        String submitCheck = SubmitValidator.mandatoryCheck(searchProductVo);
        submitCheck = submitCheck.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
        if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(submitCheck)) {
            // Fix 1197
            UserInfo userInfo = getUserInfo();
            WorkRequest workRqst = searchProductVo.getWorkRequest();
            workRqst.setVendorEmail(userInfo.getMail());
            String phone = userInfo.getAttributeValue("telephoneNumber");
            if (phone != null) {
                phone = CPSHelper.cleanPhoneNumber(phone);
                if (phone.length() >= 10) {
                    workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                    workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                } else {
                    workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                    workRqst.setVendorPhoneNumber(phone.substring(3,
                            phone.length()));
                }
            }
            workRqst.setCandUpdtUID(userInfo.getUid());
            workRqst.setCandUpdtFirstName(userInfo
                    .getAttributeValue("givenName"));
            workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
            try {
                getAddNewCandidateService().submitProduct(searchProductVo,
                        getUserRole());
                isSubmit = true;
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
                isSubmit = false;
            }
        }
        return isSubmit;
    }
    public boolean checkRolesForSubmitCandidate(ProductVO productVo) {
        boolean isFlag = false;
        if (BusinessUtil.isVendor(getUserRole())
                && (BusinessConstants.VENDOR_CODE.equalsIgnoreCase(productVo
                .getWorkRequest().getWorkStatusCode())
                || BusinessConstants.REJECT_CODE
                .equalsIgnoreCase(productVo.getWorkRequest()
                        .getWorkStatusCode())
                || BusinessConstants.VENDOR_CANDIDATE
                .equalsIgnoreCase(productVo.getWorkRequest()
                        .getWorkStatusAbb()) || BusinessConstants.REJECT_CANDIDATE
                .equalsIgnoreCase(productVo.getWorkRequest()
                        .getWorkStatusAbb()))) {
            isFlag = true;
        }
        return isFlag;
    }
    public boolean checkRolesForSubmitMRTCandidate(MrtVO mrtVO) {
        boolean isFlag = false;
        if (BusinessUtil.isVendor(getUserRole())
                && (BusinessConstants.VENDOR_CODE.equalsIgnoreCase(mrtVO
                .getWorkRequest().getWorkStatusCode())
                || BusinessConstants.REJECT_CODE.equalsIgnoreCase(mrtVO
                .getWorkRequest().getWorkStatusCode())
                || BusinessConstants.VENDOR_CANDIDATE
                .equalsIgnoreCase(mrtVO.getWorkRequest()
                        .getWorkStatusAbb()) || BusinessConstants.REJECT_CANDIDATE
                .equalsIgnoreCase(mrtVO.getWorkRequest()
                        .getWorkStatusAbb()))) {
            isFlag = true;
        }
        return isFlag;
    }
    public boolean submitMRTCandidateHandle(String productId, String userRole)
            throws Exception {
        MrtVO searchMrtVO = null;
        boolean isSubmit = false;
        searchMrtVO = getAddNewCandidateService().fetchMRTProduct(productId);
        String submitCheck = getAddNewCandidateService().submitMRTValidator(
                searchMrtVO, userRole);
        submitCheck = submitCheck.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
        if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(submitCheck)) {
            try {
                getAddNewCandidateService().submitMRTProduct(
                        searchMrtVO, userRole);
                isSubmit = true;
            } catch (Exception exp) {
                LOG.error(exp.getMessage(), exp);
                isSubmit = false;
            }
        }
        return isSubmit;
    }
    /**
     * @author thangdang (VODC)
     * @des Active Candidates is MRT
     * @param workId
     *            workrequestId
     * @param productId
     *            id of candidates that user selected to active.
     * @param activatedWorkIdList
     *            <Integer> activatedWorkIdList contain ids of candidates
     *            activated successfully.
     * @param results
     *            <SearchResultVO> results contain candidates that user
     *            searched.
     * @param checkMessage
     *            checkMessage Contain message information(error, successfully).
     * @return
     */

    public void activateMRTCandidate(int workId, String productId,
                                     List<Integer> activatedWorkIdList, List<SearchResultVO> results,
                                     List<MrtVO> mrtVOList, StringBuffer checkMessage)
            throws CPSGeneralException, Exception {
        for (SearchResultVO searchResultVO : results) {
            if (searchResultVO.getWorkIdentifier() == workId) {
                MrtVO mrtVO = getAddNewCandidateService().fetchMRTProduct(
                        productId);
                if (CPSHelper.isNotEmpty(mrtVO)) {
                    if (CPSHelper.isNotEmpty(mrtVO.getMrtVOs())
                            && mrtVO.getMrtVOs().size() < 2) {
                        checkMessage
                                .append("MRT's MUST have more than 1 element. Please change the MRT before activation");
                    } else {
                        mrtVOList.add(mrtVO);
                        String returnMessage = getAddNewCandidateService()
                                .activateMRTValidator(productId, getUserRole(),
                                        getUserInfo().getUserName());
                        if (CPSConstants.EMPTY_STRING
                                .equalsIgnoreCase(returnMessage.replace(
                                        CPSConstants.NEXT_LINE,
                                        CPSConstants.EMPTY_STRING).trim())) {
                            try {
                                String returnValue = getCommonService()
                                        .getActivate(workId,
                                                getUserInfo().getUserName());
                                String workStatus = null;
                                if (BusinessConstants.MFPE
                                        .equalsIgnoreCase(returnValue)) {
                                    workStatus = BusinessConstants.ACTIVATE_CODE;
                                    getAddNewCandidateService()
                                            .changeWorkStatus(workId,
                                                    workStatus);
                                    searchResultVO
                                            .setStatus(CPSConstants.ACTIVE);
                                    /**
                                     * MRT Candidate Activated successfully. Now
                                     * preserve the workID
                                     */
                                    activatedWorkIdList.add(workId);

                                } else {
                                    workStatus = BusinessConstants.WORKING_CODE;
                                    checkMessage
                                            .append("DB Time out issue while activating");
                                    getAddNewCandidateService()
                                            .changeWorkStatus(workId,
                                                    workStatus);
                                    searchResultVO.setStatus(CPSConstants.AIP);
                                }
                            } catch (CPSBusinessException e) {
                                getAddNewCandidateService()
                                        .changeWorkStatus(
                                                workId,
                                                BusinessConstants.ACTIVATION_FAILURE_CODE);
                                List<CPSMessage> list = e.getMessages();
                                for (CPSMessage errMsg : list) {
                                    checkMessage.append(errMsg.getMessage());
                                }
							} catch (CPSSystemException e) {
								getAddNewCandidateService().changeWorkStatus(workId,
										BusinessConstants.ACTIVATION_FAILURE_CODE);
								checkMessage.append(e.getCPSMessage().getMessage());
							}
                        } else {
                            checkMessage.append(" [Product Description :"
                                    + searchResultVO.getProdDescription()
                                    + "] " + returnMessage);
                        }
                    }
                }
            }
        }
    }
    /**
     * @author thangdang (VODC)
     * @des Active Candidates is NON_MRT
     * @param workId
     *            workrequestId
     * @param productId
     *            id of candidates that user selected to active.
     * @param activatedWorkIdList
     *            <Integer> activatedWorkIdList contain ids of candidates
     *            activated successfully.
     * @param results
     *            <SearchResultVO> results contain candidates that user
     *            searched.
     * @param checkMessage
     *            checkMessage Contain message information(error, successfully).
     * @return
     */
    public void activateCandidate(int workId, String productId,
                                  List<Integer> activatedWorkIdList, List<SearchResultVO> results,
                                  StringBuffer checkMessage, List<Integer> lstVendor)
            throws Exception {
        // iterate all candidates that user searched
        for (SearchResultVO searchResultVO : results) {
            if (searchResultVO.getWorkIdentifier() == workId) {
                // Validate candidate
                String returnMessage = getAddNewCandidateService()
                        .activateValidator(workId, productId, getUserRole(),
                                lstVendor, null);
                if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnMessage
                        .replace(CPSConstants.NEXT_LINE,
                                CPSConstants.EMPTY_STRING).trim())) {
                    try {
                        String returnValue = getCommonService().getActivate(
                                workId, getUserInfo().getUserName());
                        String workStatus = null;

                        if (BusinessConstants.MFPE
                                .equalsIgnoreCase(returnValue)) {
                            workStatus = BusinessConstants.ACTIVATE_CODE;
                            getAddNewCandidateService().changeWorkStatus(
                                    workId, workStatus);
                            searchResultVO.setStatus(CPSConstants.ACTIVE);
                            /**
                             * Candidate Activated Successfully. Preserve the
                             * workId.
                             */
                            activatedWorkIdList.add(workId);
                        } else {
                            workStatus = BusinessConstants.WORKING_CODE;
                            checkMessage
                                    .append("DB Time out issue while activating");
                            getAddNewCandidateService().changeWorkStatus(
                                    workId, workStatus);
                            searchResultVO.setStatus(CPSConstants.AIP);
                        }
                    } catch (CPSBusinessException e) {
                        getAddNewCandidateService().changeWorkStatus(workId,
                                BusinessConstants.ACTIVATION_FAILURE_CODE);
                        List<CPSMessage> list = e.getMessages();
                        for (CPSMessage errMsg : list) {
                            checkMessage.append(errMsg.getMessage());
                        }
                    } catch (CPSSystemException e) {
                        getAddNewCandidateService().changeWorkStatus(workId,
                                BusinessConstants.ACTIVATION_FAILURE_CODE);
                        checkMessage.append(e.getCPSMessage().getMessage());
                    }
                } else {
                    checkMessage.append(" [Product Description :"
                            + searchResultVO.getProdDescription() + "] "
                            + returnMessage);
                }
                break;
            }
        }
    }

	@SuppressWarnings("unchecked")
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_ACTIVATION_MESSAGE)
	public ModelAndView activationMessage(
			@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		setForm(req, manageCandidate);
		List<Integer> activatedWorkIdList = (List<Integer>) req.getSession()
				.getAttribute(CPSConstants.ACTIVATED_WORK_IDS);
		req.getSession().removeAttribute(CPSConstants.ACTIVATED_WORK_IDS);
		Boolean activateFail = (Boolean) req.getSession().getAttribute(CPSConstants.CHECK_ACTIVED_FAIL);
		req.getSession().removeAttribute(CPSConstants.CHECK_ACTIVED_FAIL);
		if (activatedWorkIdList.size() == 1) {
			req.setAttribute(CPSConstants.SINGLE_ACTIVATION, "Y");
		} else {
			req.setAttribute("SINGLE_ACTIVATION", "N");
		}
		String strJSON = "";
		// check active to Batch upload switch.
		if (manageCandidate.isHidBatchUploadSwitch() && !activateFail) {
			strJSON = getJSONForProductBatUpload(activatedWorkIdList);
		} else {
			List<Integer> activatedWorkIdMRTList = new ArrayList<Integer>();
			List<Integer> activatedWorkIdCandidateList = new ArrayList<Integer>();
			String close = "]}}";
			String rows = "";
			strJSON = "{\"ResultSet\":{\"recordsReturned\":1,\"totalRecords\":1, \"startIndex\":0, \"sort\":null, \"dir\":\"asc\",";
			strJSON += "\"records\":[";
			for (Integer id : activatedWorkIdList) {
				// check if candidate is MRT
				if (null != manageCandidate.getStatusCandidates().get(id)
						&& manageCandidate.getStatusCandidates().get(id) == true) {
					activatedWorkIdMRTList.add(id);
				} else {
					activatedWorkIdCandidateList.add(id);
				}
			}
			if (!activatedWorkIdMRTList.isEmpty()) {
				rows = rows + getJSONForMRT(activatedWorkIdMRTList);
			}
			if (!activatedWorkIdCandidateList.isEmpty()) {
				rows = rows + getJSONForProduct(activatedWorkIdCandidateList);
			}
			rows = rows.substring(0, rows.length() - 1);
			strJSON += rows + close;
		}
		resp.getWriter().write(strJSON);
		return null;
	}

	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_SCALE_APPROVE)
	public ModelAndView scaleApprove(
			@Valid @ModelAttribute(MANAGE_CANDIDATE_MODEL_ATTRIBUTE) ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + CPSConstants.CPS_MANAGE_MAIN);
		String resultArray = manageCandidate.getSelectedProductId();
		String multipleApprove = req.getParameter("multipleApprove");
		if (CPSConstants.TRUE_STRING.equals(multipleApprove)) {
			char scaleSw = 'Y';
			List<String> productIdList = new ArrayList<String>();
			StringTokenizer st = new StringTokenizer(resultArray, CPSConstants.COMMA);

			while (st.hasMoreTokens()) {
				productIdList.add(st.nextToken());
			}

			char insertedSw = getAddNewCandidateService().approveScaleItem(productIdList, scaleSw, getUserRole());
			if ('Y' == insertedSw) {
				CPSMessage message = new CPSMessage("Scale Item Approved", ErrorSeverity.INFO);
				saveMessage(manageCandidate, message);
			}
			multipleApprove = "false";
		}
		model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE, manageCandidate);
		return model;
	}

	/**
	 * This method keeps the tracking of the UPC if it is entered wrong more
	 * than twice.
	 * 
	 * @param manageCandidate
	 *            the manage candidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return ModelAndView call the method candSearch.
	 * @throws Exception
	 *             the error.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_TRACK_ERROR_UPC)
	public ModelAndView trackErrorUPC(
			@Valid @ModelAttribute("MANAGE_CANDIDATE_MODEL_ATTRIBUTE") ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		setForm(req, manageCandidate);
		String enteredUPC = req.getParameter("enteredUPC");
		String userId = getUserInfo().getUid();
		String workId = req.getParameter("workId");
		Integer psWorkId = (null != workId && !"".equalsIgnoreCase(workId)) ? Integer.parseInt(workId) : 0;
		Date dateCreated = new Date();

		getAddNewCandidateService().trackErrorUPCDetails(enteredUPC, userId, psWorkId, dateCreated);
		return candSearch(manageCandidate, req, resp);
	}

    // reuturn 1: all active Fail
    // reuturn 2:all active Working
    // return 0 : error
    public int checkBatchUploadValidateActivate(List<SearchResultVO> results,
                                                List<String> productIds) {
        int workId = 0;
        boolean working = false;
        boolean activeFail = false;
        List<Integer> workRequestList = new ArrayList<Integer>();
        for (final String string : productIds) {
            StringTokenizer integerSt = new StringTokenizer(string
                    + CPSConstants.EMPTY_STRING, CPSConstants.SEMI_COLON);
            while (integerSt.hasMoreTokens()) {
                try {
                    workId = Integer.parseInt(integerSt.nextToken());
                } catch (NumberFormatException e) {
                    workId = 0;
                }
                workRequestList.add(workId);
                if (integerSt.hasMoreTokens()) {
                    integerSt.nextToken();
                }
            }
        }
        for (final Integer workRQId : workRequestList) {
            for (final SearchResultVO result : results) {
                if (result.getWorkIdentifier() == workRQId) {
                    if (result.getWorkStatusCode().equals(
                            BusinessConstants.ACTIVATION_FAILURE_CODE)) {
                        activeFail = true;
                    } else {
                        working = true;
                    }
                    break;
                }
            }
            if (activeFail && working) {
                return 0;
            }
        }
        if (activeFail) {
            return 1;
        } else {
            return 2;
        }
    }
    /**
     * @author thangdang (VODC)
     * @des Active Candidates belong on Batch Upload
     * @param workId
     *            workrequestId
     * @param productId
     *            id of candidates that user selected to active.
     * @param activatedWorkIdList
     *            <Integer> activatedWorkIdList contain ids of candidates
     *            activated successfully.
     * @param results
     *            <SearchResultVO> results contain candidates that user
     *            searched.
     * @param checkMessage
     *            checkMessage Contain message information(error, successfully).
     * @return
     */
    public void activateBatchUploadCandidate(int workId, String productId,
                                             List<Integer> activatedWorkIdList, List<SearchResultVO> results,
                                             StringBuffer checkMessage) throws Exception {
        // check workid have activated? (in batch upload, a workid have more
        // than a product)
        if (!activatedWorkIdList.contains(workId)) {
            for (SearchResultVO searchResultVO : results) {
                if (searchResultVO.getWorkIdentifier() == workId) {
                    if (!isTestScanNeeded(searchResultVO)) {
                        if (searchResultVO.getRetail() != 0
                                && !CPSHelper.isEmpty(searchResultVO
                                .getRetailForValidate())) {
                            try {
                                String workStatus = null;
                                workStatus = BusinessConstants.ACTIVATE_BATCHUPLOAD_CODE;
                                getAddNewCandidateService().changeWorkStatus(
                                        workId, workStatus);
                                getCommonService()
                                        .updateBatchUploadCandidateStatus(
                                                workId,
                                                getUserInfo().getUserName());
                                searchResultVO.setStatus(CPSConstants.ACTIVE);
                                /**
                                 * Candidate Activated Successfully. Preserve
                                 * the workId.
                                 */
                                activatedWorkIdList.add(workId);
                            } catch (CPSBusinessException e) {
                                LOG.error(e.getMessage(), e);
                                getAddNewCandidateService()
                                        .changeWorkStatus(
                                                workId,
                                                BusinessConstants.ACTIVATION_FAILURE_CODE);
                                List<CPSMessage> list = e.getMessages();
                                for (CPSMessage errMsg : list) {
                                    checkMessage.append(errMsg.getMessage());
                                }
                            }
                        } else {
                            checkMessage.append(" [Product Description :"
                                    + searchResultVO.getProdDescription()
                                    + "] "
                                    + CPSConstants.ACTIVATION_VALIDATE_RETAIL);
                        }
                    } else {
                        checkMessage.append(" [Product Description :"
                                + searchResultVO.getProdDescription() + "] "
                                + CPSConstants.CHECK_TESTSCAN);
                    }
                    break;
                }
            }
        }
    }
    public boolean isScaleProduct(SearchResultVO searchResultVO) {
        boolean scaleProduct = false;
        if (searchResultVO != null) {
            final List<UPCVO> upcs = searchResultVO.getUpcVO();
            for (final UPCVO upcvo : upcs) {
                if (upcvo.getUnitUpc().endsWith("00000")
                        && upcvo.getUnitUpc().startsWith("002")) {
                    scaleProduct = true;
                    break;
                }
            }
        }
        return scaleProduct;
    }
    /**
     * @return boolean value to indicate if test scan is needed.
     */
    public boolean isTestScanNeeded(SearchResultVO searchResultVO) {
        boolean testScanNeeded = false;
        if (isScaleProduct(searchResultVO)) {
            return false;
        }

        testScanNeeded = true;
        String productType = searchResultVO.getProductType();
        // No need to do a test scan if it is not a SELLABLE item.
        if ("SPLY".equalsIgnoreCase(productType)
                || CPSConstants.EMPTY_STRING.equalsIgnoreCase(productType)) {
            testScanNeeded = false;
        } else {
            List<UPCVO> upcvos = searchResultVO.getUpcVO();
            if (null == upcvos || upcvos.isEmpty()) {
                // If there is no UPC then no need to do test scan
                testScanNeeded = false;
            }
        }
        if (testScanNeeded) {
            List<UPCVO> upcvoList = searchResultVO.getUpcVO();
            for (UPCVO upcvo : upcvoList) {
                if ("UPC".equalsIgnoreCase(upcvo.getUpcType())
                        || "HEB".equalsIgnoreCase(upcvo.getUpcType())) {
                    // If there is at least one Sellable UPC, for which
                    // the test scan is not performed yet, the "TEST
                    // SCAN" button should be active.
                    if ((upcvo.getTestScanUPC() == null || upcvo
                            .getTestScanUPC().trim().length() == 0)
                            && 'Y' == upcvo.getNewDataSw()) {
                        // Not test scan has been performed yet for this
                        // UPC.
                        testScanNeeded = true;
                        break;
                    } else {
                        testScanNeeded = false;
                    }
                } else {
                    testScanNeeded = false;
                }
            }
        }
        return testScanNeeded;
    }
    private List<SearchResultVO> removeActivatedCandidate(
            List<Integer> activatedWorkIdList,ManageCandidate manageCandidate, HttpServletRequest req) {
        List<SearchResultVO> results = (List<SearchResultVO>) req.getSession()
                .getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
        List<SearchResultVO> correctedList = new ArrayList<SearchResultVO>();
        for (SearchResultVO searchResultVO : results) {
            correctedList.add(searchResultVO);
        }
        List<SearchResultVO> searchResultDelete = new ArrayList<SearchResultVO>();
        if (!activatedWorkIdList.isEmpty()) {
            for (Integer workId : activatedWorkIdList) {
                for (SearchResultVO searchResultVO : correctedList) {
                    if (searchResultVO.getWorkIdentifier() == workId) {
                        searchResultDelete.add(searchResultVO);
                        if (!manageCandidate.isHidBatchUploadSwitch()) {
                            break;
                        }
                    }
                }
            }
            correctedList.removeAll(searchResultDelete);
        }
        return correctedList;
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
        //columnPrinSumaryProductHeadings
        //	.add(CPSConstants.PRINSUMARY_COLUMN_RATING);
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
    /**
     * This method is to get the product id of the selected candidate form the
     * search result.
     *
     * @param results
     * @param selectedProductId
     * @return PrintFormVO
     */
    public PrintFormVO getSelectedVendorDescription(
            List<SearchResultVO> results, int selectedProductId) {
        PrintFormVO printFormVO = null;
        for (SearchResultVO searchResultVO : results) {
            if (selectedProductId == searchResultVO.getPsProdId()) {
                printFormVO = new PrintFormVO();
                printFormVO.setVendorName(searchResultVO.getVendorDesc());
                printFormVO.setProductDescription(searchResultVO
                        .getProdDescription());
            }
        }
        return printFormVO;
    }
    public String printMRTProduct(MrtVO selectedMRT, String prodID,
                                  String prodVenID, HttpServletRequest req, HttpServletResponse resp)
            throws IllegalAccessException, InvocationTargetException,
            CPSGeneralException {
        List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();
        int vendorId = -1;
        int caseId = -1;
        List<MRTUPCVO> mrtUPCVoprints = null;// new ArrayList<MRTUPCVO>();
        if (null != selectedMRT.getMrtVOPrints()
                && !selectedMRT.getMrtVOPrints().isEmpty()) {
            mrtUPCVoprints = selectedMRT.getMrtVOPrints();
        } else {
            mrtUPCVoprints = selectedMRT.getMrtVOs();
        }
        for (MRTUPCVO mrtupcvo : mrtUPCVoprints) {
            ProductVO productVO = mrtupcvo.getProductVO();
            if (CPSHelper.isNotEmpty(prodID) && null != productVO.getPsProdId()
                    && productVO.getPsProdId().equals(Integer.valueOf(prodID))) {
                for (CaseVO caseVO : productVO.getCaseVOs()) {
                    if (CPSHelper.isNotEmpty(caseVO.getVendorVOListPrints())) {
                        setItemCategoryList(caseVO);
                        setTouchTypeList(selectedMRT.getCaseVO());
                        for (VendorVO vendorVO : caseVO.getVendorVOs()) {
                            if (vendorVO.getVendorLocNumber() == Integer
                                    .valueOf(prodVenID).intValue()) {
                                vendorId = vendorVO.getVendorLocNumber();
                                caseId = caseVO.getPsItemId();
                                setCreateOnProduct(productVO);
                                productVO
                                        .setVendorLocationList(getVendorLocationList());
                                if (BusinessUtil.isVendor(getUserRole())) {
                                    productVO.setVendorLogin(true);
                                }
                                printFormVOList = PrintFormHelper
                                        .copyEntityToEntity(productVO, req
                                                        .getSession().getId()
                                                        + "-"
                                                        + prodID, req, resp,
                                                getCommonService(),
                                                getAddNewCandidateService(),
                                                hebLdapUserService);
                            }
                        }
                    }
                }
            }
        }
        String fileName = "";
        for (PrintFormVO printFormVO : printFormVOList) {
            if (printFormVO.getFileName().indexOf(
                    req.getSession().getId() + "-" + prodID) > 0) {
                if (printFormVO.getFileName().indexOf(
                        "-" + caseId + "-" + vendorId) > 0) {
                    fileName = printFormVO.getFileName();
                }
            }
        }
        return fileName;
    }

    public String printMRTVendor(MrtVO selectedMRT, String mrtVenID,
                                 HttpServletRequest req, HttpServletResponse resp)
            throws IllegalAccessException, InvocationTargetException,
            CPSGeneralException {
        List<PrintFormVO> printFormVOList = null;// new
        // ArrayList<PrintFormVO>();
        setCreateOnMRT(selectedMRT);
        if (selectedMRT.getCaseVO() != null) {
            setItemCategoryList(selectedMRT.getCaseVO());
            setTouchTypeList(selectedMRT.getCaseVO());
            selectedMRT.setVendorLocationList(getVendorLocationList());
            if (BusinessUtil.isVendor(getUserRole())) {
                selectedMRT.setVendorLogin(true);
            }
        }
        printFormVOList = PrintFormHelper.copyEntityToEntityMRT(selectedMRT,
                req.getSession().getId() + "-"
                        + selectedMRT.getWorkRequest().getWorkIdentifier(),
                req, resp, getCommonService(), getAddNewCandidateService(),
                hebLdapUserService);
        String fileName = "";
        for (PrintFormVO printFormVO : printFormVOList) {
            if (printFormVO.getFileName().indexOf(
                    req.getSession().getId() + "-"
                            + selectedMRT.getWorkRequest().getWorkIdentifier()) > 0) {
                if (printFormVO.getFileName().indexOf("-" + mrtVenID) > 0) {
                    fileName = printFormVO.getFileName();
                }
            }
        }
        return fileName;
    }
    // Fix PrintForm Create On
    public void setCreateOnMRT(MrtVO selectedMRT) {
        final int workrequestId = selectedMRT.getWorkRequest()
                .getWorkIdentifier();
        try {
            List<PsCandidateStat> psCandidateStats = getAddNewCandidateService()
                    .getCandidateStatByworkId(workrequestId);
            if (null != psCandidateStats && !psCandidateStats.isEmpty()) {
                for (PsCandidateStat psCandidateStat : psCandidateStats) {
                    if (CPSHelper.getTrimmedValue(
                            psCandidateStat.getPsStat().getPdSetupStatCd())
                            .equalsIgnoreCase(BusinessConstants.WORKING_CODE)) {
                        selectedMRT.setCreateOn(psCandidateStat.getId()
                                .getLstUpdtTs());
                        break;
                    } else {
                        selectedMRT.setCreateOn(psCandidateStat.getId()
                                .getLstUpdtTs());
                    }
                }
            }
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
        }
    }
    private List<BaseJSFVO> setTouchTypeList(CaseVO caseVO) {
        List<BaseJSFVO> touchTypes = null;
        // try {
        if (caseVO != null && CPSHelper.isEmpty(caseVO.getTouchTypeList())) {
            touchTypes = getAppContextFunctions().getTouchTypeCodes();
            caseVO.setTouchTypeList(touchTypes);
        }
        // } catch (CPSWebException e) {
        // LOG.error(e.getMessage(), e);
        // return touchTypes;
        // }
        return touchTypes;
    }
    private List<BaseJSFVO> setItemCategoryList(CaseVO caseVO) {
        List<BaseJSFVO> itemCategorys = null;
        // try {
        if (caseVO != null && CPSHelper.isEmpty(caseVO.getItemCategoryList())) {
            itemCategorys = getAppContextFunctions().getItemCategory();
            caseVO.setItemCategoryList(itemCategorys);
        }
        return itemCategorys;
    }
    // Fix PrintForm Create On
    public void setCreateOnProduct(ProductVO productVO) {
        final int workrequestId = productVO.getWorkRequest()
                .getWorkIdentifier();
        try {
            final List<PsCandidateStat> psCandidateStats = getAddNewCandidateService()
                    .getCandidateStatByworkId(workrequestId);
            if (null != psCandidateStats && !psCandidateStats.isEmpty()) {
                for (PsCandidateStat psCandidateStat : psCandidateStats) {
                    if (CPSHelper.getTrimmedValue(
                            psCandidateStat.getPsStat().getPdSetupStatCd())
                            .equalsIgnoreCase(BusinessConstants.WORKING_CODE)) {
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
    private void setOneTouchAndSeasons(ProductVO productVO) {
        List<BaseJSFVO> touchTypes = null;
        List<BaseJSFVO> seasons = null;
        if (productVO != null) {
            List<CaseVO> cases = productVO.getCaseVOs();
            if (CPSHelper.isNotEmpty(cases)) {
                for (CaseVO caseVO : cases) {
                    if (caseVO != null
                            && !CPSHelper.isEmpty(caseVO.getChannel())
                            && ("V".equalsIgnoreCase(CPSHelper
                            .getTrimmedValue(caseVO.getChannel())) || "WHS"
                            .equalsIgnoreCase(CPSHelper
                                    .getTrimmedValue(caseVO
                                            .getChannel())))) {
                        if (CPSHelper.isEmpty(caseVO.getTouchTypeList())) {
                            if (touchTypes == null) {
                                touchTypes = getAppContextFunctions()
                                        .getTouchTypeCodes();
                            }
                            caseVO.setTouchTypeList(touchTypes);
                        }
                        List<VendorVO> vendors = caseVO.getVendorVOs();
                        if (CPSHelper.isNotEmpty(vendors)) {
                            for (VendorVO vendorVO : vendors) {
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
    private PrintFormVO getMRTPrintInfo(int selectedProductId,ManageCandidate manageCandidate)
            throws CPSGeneralException {
        PrintFormVO printFormVO = new PrintFormVO();
        MrtVO mrtVO = getAddNewCandidateService().fetchMRTProduct(
                String.valueOf(selectedProductId));
        if (null != mrtVO) {
        	List<MRTUPCVO> mrtList = mrtVO.getMrtVOs();
        	Map<BigDecimal, ProductVO> productVOs = null;
    		if (CPSHelper.isNotEmpty(mrtList)) {
    			List<BigDecimal> upcs = new ArrayList<BigDecimal>();
    			for (MRTUPCVO mrtupcvo : mrtList) {
    				upcs.add(CPSHelper.getBigdecimalValueForServices(mrtupcvo.getUnitUPC()));
    			}
    			BigDecimal[] upcArr = upcs.toArray(new BigDecimal[upcs.size()]);
    			productVOs = getAddNewCandidateService().getProductBasicForAddUpcMrtByArrayUPC(upcArr);
    		}
			String validationMsg = "";
            validationMsg = validatePrintForm(mrtVO, productVOs);
            validationMsg = validationMsg.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING)
                    .trim();
            if (CPSHelper.isNotEmpty(validationMsg)) {
                throw new CPSGeneralException(validationMsg);
            }
            manageCandidate.getMRTList().add(getCorrectedMRT1(mrtVO, productVOs));
            final String caseDescription = mrtVO.getCaseVO()
                    .getCaseDescription();
            List<MRTUPCVO> prods = mrtVO.getMrtVOs();
            List<BaseJSFVO> prodDesc = new ArrayList<BaseJSFVO>();
            for (MRTUPCVO mrtupcvo : prods) {
                prodDesc.add(new BaseJSFVO(mrtupcvo.getProdId(), mrtupcvo
                        .getDescription()));
            }
            printFormVO.setMrtDescription(new BaseJSFVO(String
                    .valueOf(selectedProductId), caseDescription));
            printFormVO.setMrtchildren(prodDesc);
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
    private String validatePrintForm(MrtVO mrtVO, Map<BigDecimal, ProductVO> productVOs) {
        String submitCheck = "";
        try {
            if (isVendor()) {
                submitCheck = getAddNewCandidateService().submitMRTValidatorForPrintForm(
                        mrtVO, getUserRole(), productVOs);
            }
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
            submitCheck = "Problem while validating MRT. Please logout and try again.";
        }
        return submitCheck;
    }

    private boolean isVendor() {
        String userRole = getUserRole();
        return (CPSConstants.UNREGISTERED_VENDOR_ROLE
                .equalsIgnoreCase(userRole) || CPSConstants.REGISTERED_VENDOR_ROLE
                .equalsIgnoreCase(userRole));
    }

    private String validatePrintForm(ProductVO productVO) {
        String submitCheck = "";
        if (isVendor()) {
            submitCheck = SubmitValidator.mandatoryCheck(productVO);
        }
        return submitCheck;
    }
    /*
     * Get all sub-commodities from Cache and set value into Sub-Commodity
     * combo-box
     *
     * @author khoapkl
     */
    private void populateSubCommodities(HebBaseInfo manageForm, HttpServletRequest req)
            throws Exception {
        if (manageForm.getSubCommodities() == null
                || manageForm.getSubCommodities().isEmpty()) {
            List<BaseJSFVO> subCommodities = getAppContextFunctions()
                    .getSubCommodityList();
            manageForm.setSubCommodities(subCommodities);
        }
    }
    private MrtVO getCorrectedMRT(MrtVO mrtVO) throws CPSGeneralException {
        List<MRTUPCVO> allMRT = mrtVO.getMrtVOs();
        List<MRTUPCVO> newAllMRT = new ArrayList<MRTUPCVO>(); // This will
        // contain
        // candidates
        // only.
        List<MRTUPCVO> commentUPCs = new ArrayList<MRTUPCVO>();
        for (MRTUPCVO mrtupcvo : allMRT) {
            ProductVO productVO = null;
            try {
                // fix performance change method getProduct to get
                // getProductBasic because print form do not use image atribute
                productVO = getAddNewCandidateService().getProductBasicForMRTPrintForm(
                        mrtupcvo.getUnitUPC(), CPSConstants.EMPTY_STRING, CPSConstants.EMPTY_STRING);
            } catch (CPSGeneralException e) {
                LOG.error(e.getMessage(), e);
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
            }
            if (productVO != null && productVO.getProdId() != null
                    && !productVO.getProdId().isEmpty()) {
                // pim 933
                CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                // end pim 933
                mrtupcvo.setProductVO(productVO);
                commentUPCs.add(mrtupcvo);
            } else {
                productVO = mrtupcvo.getProductVO();
                if (productVO.getPsProdId() != null
                        && productVO.getPsProdId() > 0) {
                    try {
                        productVO = getAddNewCandidateService().fetchProductPrint(
                                CPSHelper.getStringValue(productVO
                                        .getPsProdId()), getUserRole(), false);
                    } catch (CPSGeneralException e) {
                        LOG.error(e.getMessage(), e);
                    } catch (Exception e) {
                        LOG.error(e.getMessage(), e);
                    }
                    String validationMsg = "";
                    validationMsg = validatePrintForm(productVO);
                    validationMsg = validationMsg.replace(CPSConstants.NEXT_LINE,CPSConstants.EMPTY_STRING).trim();
                    if (CPSHelper.isEmpty(validationMsg)) {
                        // pim 933
                        CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                        // end pim 933
                        mrtupcvo.setProductVO(productVO);
                        newAllMRT.add(mrtupcvo);
                        commentUPCs.add(mrtupcvo);
                    } else {
                        throw new CPSGeneralException(
                                "Can not print form. Missing following data - "
                                        + validationMsg);
                    }
                }
            }
        }
        mrtVO.clearMrtVOs();
        mrtVO.setMrtVOs(newAllMRT);
        mrtVO.getMrtVOPrints().clear();
        mrtVO.setComments(commentUPCs);
        return mrtVO;
    }

    /**
     * Gets the corrected mrt.
     *
     * @param mrtVO
     *            the mrt vo
     * @return the corrected mrt
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private MrtVO getCorrectedMRT1(MrtVO mrtVO, Map<BigDecimal, ProductVO> productVOs) throws CPSGeneralException {
        String tempMsg = CPSConstants.EMPTY_STRING;
        String tempActiveMsg = CPSConstants.EMPTY_STRING;
        boolean tempFlag = false;
        List<MRTUPCVO> allMRT = mrtVO.getMrtVOs();
        List<MRTUPCVO> newAllMRT = new ArrayList<MRTUPCVO>(); // This will
        // contain
        // candidates
        // only.
        List<MRTUPCVO> allMRTPrint = mrtVO.getMrtVOPrints();
        List<MRTUPCVO> commentMRTs = new ArrayList<MRTUPCVO>();
        int sizeMRTAll = allMRT.size();
        boolean flag = false;
        // thang dang fix
        if (sizeMRTAll > allMRTPrint.size()) {
            for (MRTUPCVO mrtUPCVO : allMRT) {
                flag = false;
                String unitUPC = mrtUPCVO.getUnitUPC();
                for (MRTUPCVO mrtprint : allMRTPrint) {
                    if (unitUPC.trim().equals(mrtprint.getUnitUPC().trim())) {
                        flag = true;
                        break;
                    }
                }
                if (!flag) {
                    allMRTPrint.add(mrtUPCVO);
                }
            }
            if (allMRTPrint.size() > sizeMRTAll) {
                List<MRTUPCVO> temp = new ArrayList<MRTUPCVO>();
                for (MRTUPCVO mrtUPCVO : allMRTPrint) {
                    flag = false;
                    String unitUPC = mrtUPCVO.getUnitUPC();
                    for (MRTUPCVO mrtprint : allMRT) {
                        if (unitUPC.trim().equals(mrtprint.getUnitUPC().trim())) {
                            flag = true;
                            break;
                        }
                    }
                    if (!flag) {
                        temp.add(mrtUPCVO);
                    }
                }
                allMRTPrint.removeAll(temp);
            }
        } else if (sizeMRTAll < allMRTPrint.size()) {
            List<MRTUPCVO> temp = new ArrayList<MRTUPCVO>();
            for (MRTUPCVO mrtUPCVO : allMRTPrint) {
                flag = false;
                String unitUPC = mrtUPCVO.getUnitUPC();
                for (MRTUPCVO mrtprint : allMRT) {
                    if (unitUPC.trim().equals(mrtprint.getUnitUPC().trim())) {
                        flag = true;
                        break;
                    }
                }
                if (!flag) {
                    temp.add(mrtUPCVO);
                }
            }
            allMRTPrint.removeAll(temp);
        }
        List<BigDecimal> upcs = new ArrayList<BigDecimal>();
        for (MRTUPCVO mrtupcvo : allMRTPrint) {
        	BigDecimal upc = CPSHelper.getBigdecimalValueForServices(mrtupcvo.getUnitUPC());
        	if(!productVOs.keySet().contains(upc)){
        		upcs.add(upc);
        	}        	
        }
        if(upcs!= null && !upcs.isEmpty()){
        	BigDecimal[] upcArr = upcs.toArray(new BigDecimal[upcs.size()]);
        	Map<BigDecimal, ProductVO> productVOsNew = getAddNewCandidateService().getProductBasicForAddUpcMrtByArrayUPC(upcArr);
        	productVOs.putAll(productVOsNew);
        }    
    	for (MRTUPCVO mrtupcvo : allMRTPrint) {
    		ProductVO productVO = null;
    		if(productVOs != null && !productVOs.isEmpty()){
    			productVO = productVOs.get(CPSHelper.getBigdecimalValueForServices(mrtupcvo.getUnitUPC()));
    		}
            if (productVO != null && productVO.getProdId() != null && !productVO.getProdId().isEmpty()) {
            	this.correctUOM(productVO);
                // fix pim 933
//				try {
//					productVO = getAddNewCandidateService().fetchProductPrint(productVO.getProdId(), getUserRole(), true);
//				} catch (CPSGeneralException e) {
//					LOG.error(e.getMessage(), e);
//				} catch (Exception e) {
//					LOG.error(e.getMessage(), e);
//				}
//				String validationMsg = EMPTY_STRING;
//				// set isNotChckMerForMrt for PIM 1005
//				productVO.setNotChckMerForMrt(true);
//				validationMsg = validateActivePrintForm(productVO);
//				productVO.setNotChckMerForMrt(false);
//				validationMsg = validationMsg.replace(NEXT_LINE, EMPTY_STRING).trim();
//				if (CPSHelper.isEmpty(validationMsg)) {
//					CPSWebUtil.setVendorVoListPrintsToCase(productVO);
//					mrtupcvo.setProductVO(productVO);
//					newAllMRT.add(mrtupcvo);
//					commentMRTs.add(mrtupcvo);
//					tempFlag = true;
//				} else {
//					// throw new
//					// CPSGeneralException("Can not print form. Missing
//					// following data - "
//					// + validationMsg);
//					if (CPSHelper.isEmpty(tempActiveMsg)) {
//						tempActiveMsg = "Can not print form. Missing following data - " + validationMsg;
//					}
//				}
                // end fix pim 933
                // mrtupcvo.setProductVO(productVO);
                // commentMRTs.add(mrtupcvo);
                // pim 933
                CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                // end pim 933
                mrtupcvo.setProductVO(productVO);
                commentMRTs.add(mrtupcvo);

            } else {
                productVO = mrtupcvo.getProductVO();
                if (productVO.getPsProdId() != null && productVO.getPsProdId() > 0) {
                    try {
                        productVO = getAddNewCandidateService()
                                .fetchProductPrint(CPSHelper.getStringValue(productVO.getPsProdId()), getUserRole(), false);
                    } catch (CPSGeneralException e) {
                        LOG.error(e.getMessage(), e);
                    } catch (Exception e) {
                        LOG.error(e.getMessage(), e);
                    }
                } else {
                    try {
                        if (BusinessUtil.isVendor(getUserRole())) {
                            productVO = getAddNewCandidateService().getProductByUPCFromVendor(mrtupcvo.getUnitUPC(),
                                    getUserRole());
                        } else {
                            productVO = getAddNewCandidateService().getProductFromUPC(mrtupcvo.getUnitUPC(),
                                    getUserRole());
                        }
                    } catch (CPSGeneralException e) {
                        LOG.error(e.getMessage(), e);
                    } catch (Exception e) {
                        LOG.error(e.getMessage(), e);
                    }
                }
                if (productVO.getPsProdId() != null && productVO.getPsProdId() > 0) {
                    String validationMsg = CPSConstants.EMPTY_STRING;
                    // set isNotChckMerForMrt for PIM 1005
                    productVO.setNotChckMerForMrt(true);
                    validationMsg = validateActivePrintForm(productVO);
                    productVO.setNotChckMerForMrt(false);
                    validationMsg = validationMsg.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
                    if (CPSHelper.isEmpty(validationMsg)) {
                        // pim 933
                        CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                        // end pim 933
                        mrtupcvo.setProductVO(productVO);
                        newAllMRT.add(mrtupcvo);
                        commentMRTs.add(mrtupcvo);
                        tempFlag = true;
                    } else {
                        // throw new
                        // CPSGeneralException("Can not print form. Missing
                        // following data - "
                        // + validationMsg);
                        if (CPSHelper.isEmpty(tempMsg)) {
                            tempMsg = "Can not print form. Missing following data - " + validationMsg;
                        }
                    }
                }
            }
        }
        // [MRT]_Print form issue
        validateVendorLink(tempFlag, newAllMRT, tempMsg, tempActiveMsg);
        // [MRT]_Print form issue
        mrtVO.getMrtVOPrints().clear();
        // mrtVO.clearMrtVOs();
        mrtVO.setMrtVOPrints(newAllMRT);
        mrtVO.setComments(commentMRTs);
        return mrtVO;
    }
    
    private void correctUOM(ProductVO productVO) {
        if (productVO == null || CPSHelper.isEmpty(productVO.getCaseVOs())) {
            return;
        }
        for (final CaseVO caseVO : productVO.getCaseVOs()) {
            for (CaseUPCVO caseUPCVO : caseVO.getCaseUPCVOs()) {
                if (CPSHelper.isEmpty(caseUPCVO.getUnitMeasureCode())) {
                    // UOM when empty should display NOUNPR
                    caseUPCVO.setUnitMeasureCode(CPSConstant.SPACE_STRING);
                    caseUPCVO.setUnitMeasureDesc("NOUNPR");
                }
            }
        }
    }
    
    private String validateActivePrintForm(ProductVO productVO) {
        String submitCheck = CPSConstants.EMPTY_STRING;
        if (isVendor()) {
            submitCheck = SubmitValidator.mandatoryCheckActive(productVO);
        }
        return submitCheck;
    }
    
    private void validateVendorLink(boolean tempFlag, List<MRTUPCVO> newAllMRT, String tempMsg, String tempActiveMsg)
            throws CPSGeneralException {
        if (tempFlag) {
            ProductVO productVO = null;
            boolean checkFlag = false;
            if (!newAllMRT.isEmpty()) {
                for (MRTUPCVO mrtupcvo2 : newAllMRT) {
                    productVO = mrtupcvo2.getProductVO();
                    for (CaseVO caseVO : productVO.getCaseVOs()) {
                        if (!caseVO.getVendorVOListPrints().isEmpty()) {
                            checkFlag = true;
                            break;
                        }
                    }
                }
            }
            if (!checkFlag) {
                if (!CPSHelper.isEmpty(tempMsg)) {
                    throw new CPSGeneralException(tempMsg);
                }
                if (!CPSHelper.isEmpty(tempActiveMsg)) {
                    throw new CPSGeneralException(tempActiveMsg);
                }
            }
        } else {
            if (!CPSHelper.isEmpty(tempMsg)) {
                throw new CPSGeneralException(tempMsg);
            }
            if (!CPSHelper.isEmpty(tempActiveMsg)) {
                throw new CPSGeneralException(tempActiveMsg);
            }
        }
    }
    
    @Override
    protected void setErrorPath(HebBaseInfo form, HttpServletRequest request) {
        super.setErrorPath(form, request);
        if (form instanceof ManageCandidate) {
            setInputForwardValue(request, CPSConstants.CPS_MANAGE_MAIN);
        }
//        else if (form instanceof CPSManageProductForm) {
//            setInputForwardValue(request, CPSConstants.CPS_MANAGE_PRODUCT);
//        } else {
//            setInputForwardValue(request, CPSConstants.CPS_MANAGE_MAIN);
//        }
    }

	/**
	 * Active product search wrapper when navigating on menu.
	 * 
	 * @param manageProduct
	 *            the model attribute manage product.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return the method product search.
	 * @throws Exception
	 *             if error has occurred.
	 */
	@RequestMapping(method = RequestMethod.GET, value = ManageCandidateController.RELATIVE_PATH_PRODUCT_SEARCH_WRAPPER)
	public ModelAndView prodSearchWrapper(HttpServletRequest req, HttpServletResponse resp)
			throws Exception {
		ManageProduct manageProduct = new ManageProduct();
		manageProduct.setSession(req.getSession());
		manageProduct.clearQuestionaireVO();
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
		req.getSession().setAttribute(CPSConstants.PRESENT_BTS, "2");
		req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS);
		return prodSearch(manageProduct, req, resp);
	}

	public ModelAndView prodSearch(ManageProduct manageProduct, HttpServletRequest req, HttpServletResponse resp)
			throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_SEARCH_PAGE);
		this.setForm(req, manageProduct);

		manageProduct.setProdcriteria(new CandidateSearchCriteria());
		manageProduct.setValidForCandSearch(true);
		manageProduct.setValidForResults(false);
		manageProduct.setSelectedFunction(HebBaseInfo.COPY_PRODUCT);
		manageProduct.setManageCandidateMode();
		manageProduct.setValidForResults(true);
		try {
			manageProduct.setClasses(getCommonService().getClassesAsBaseJSFVOs());
			this.populateBDMs(manageProduct, req);
		} catch (Exception e) {
			LOG.error("Error has occurred: " + e.getMessage());
		}
		if (CPSHelper.isEmpty(manageProduct.getProductTypes())) {
			manageProduct.setProductTypes(getAppContextFunctions().getProductTypes());
		}
		manageProduct.getProducts().clear();
		manageProduct.getProductsTemp().clear();
		if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
			req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
		if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
			req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
		manageProduct.setProdcriteria(new CandidateSearchCriteria());
		if (this.getUserRole().equals(CPSConstants.REGISTERED_VENDOR_ROLE)
				|| this.getUserRole().equals(CPSConstants.UNREGISTERED_VENDOR_ROLE)) {
			req.getSession().removeAttribute(CPSConstants.VENDOR_LOGIN_COFIRM);
			req.getSession().setAttribute(CPSConstants.VENDOR_LOGIN_COFIRM, "true");
		}
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);

		saveMessage(manageProduct, new CPSMessage());
		model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, manageProduct);
		return model;

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = ManageCandidateController.RELATIVE_PATH_SEARCH_PRODUCT)
	public ModelAndView searchProduct(
			@Valid @ModelAttribute(MANAGE_PRODUCT_MODEL_ATTRIBUTE) ManageProduct manageProduct, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_SEARCH_PAGE);
		manageProduct.setSession(req.getSession());
		setForm(req, manageProduct);

		if (manageProduct.getQuestionnarieVO() != null) {
			manageProduct.getQuestionnarieVO().setSelectedOption("1");
			manageProduct.getQuestionnarieVO().setSelectedValue(null);
		}
		manageProduct.getProducts().clear();
		if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
			req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
		if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
			req.getSession().removeAttribute(CPSConstants.REDIRECT_FORM);
		}
		req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
		req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION);
		CandidateSearchCriteria searchCriteria = manageProduct.getProdcriteria();
		/*
		 * Reset mrtSwitch
		 * 
		 * @author khoapkl
		 */
		searchCriteria.setMrtSwitchCheck(false);
		if (searchCriteria.isMrtSwitchCheck()) {
			manageProduct.setHidManageMrtSwitch(true);
		} else {
			manageProduct.setHidManageMrtSwitch(false);
		}
		// Albin - other criteria to be added
		if (CPSHelper.isNotEmpty(searchCriteria.getVendorDescription())
				&& CPSHelper.isEmpty(searchCriteria.getVendorIDList())) {
			List<Integer> vendorIDList = new ArrayList<Integer>();
			try {
				Integer vendorID = CPSHelper.getIntegerValue(searchCriteria.getVendorDescription());
				vendorIDList.add(vendorID);
				VendorList vendorList = new VendorList(null, null, vendorID);
				List<WareHouseVO> warehouseList = getCommonService().getWareHouseList(vendorList, null);
				if (CPSHelper.isNotEmpty(warehouseList)) {
					String padVendorID = CPSHelper.padZeros(searchCriteria.getVendorDescription(), 6);
					for (WareHouseVO whVo : warehouseList) {
						vendorIDList.add(CPSHelper.getIntegerValue(whVo.getWhareHouseid() + padVendorID));
					}
				}
			} catch (NumberFormatException num) {
				// It is not a Vendor ID - go on.
			} catch (CPSSystemException sys) {
				// Service not up - log & go on.
				LOG.error("Unable to get Warehouse service", sys);
			} catch (CPSGeneralException gen) {
				// no warehouses found - could be DSD vendor - go on.
				LOG.warn("Unable to get Warehouse service", gen);
			}
			if (!vendorIDList.isEmpty()) {
				searchCriteria.setVendorIDList(vendorIDList);
			}
		}
		searchCriteria.setUserName(getCommonService().getUserName());
		searchCriteria.setRole(getUserRole());
		Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) req.getSession()
				.getAttribute("vendorMap");

		if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
			vendorMap = getVendorLocationList();
		}
		searchCriteria.setVendorMap(vendorMap);
		List<ProductSearchResultVO> results = null;
		try {
			results = getCommonService().getProductsForCriteria(searchCriteria);
		} catch (CPSBusinessException e) {
			handleException(e, manageProduct, req, resp);
		} catch (Exception e) {
			handleException(e, manageProduct, req, resp);
		}
		if (results != null) {
			if (results.isEmpty()) {
				saveMessage(manageProduct, new CPSMessage("No matches found, change criteria", ErrorSeverity.WARNING));
			} else if (results.size() > 1) {
				saveMessage(manageProduct,
						new CPSMessage(results.size() + CPSConstants.PRODUCTS_FOUND, ErrorSeverity.INFO));
			} else {
				saveMessage(manageProduct,
						new CPSMessage(results.size() + CPSConstants.PRODUCT_FOUND, ErrorSeverity.INFO));
			}
		}

		/*
		 * identify search result is not empty and don't execute search by Mrt
		 * Switch
		 * 
		 * @author khoapkl
		 */
		req.setAttribute("noData", results != null && !results.isEmpty() ? true : false);
		manageProduct.setValidForCandSearch(true);
		manageProduct.setValidForResults(false);
		manageProduct.setSelectedFunction(HebBaseInfo.MAANAGE_CANDIDATE);
		manageProduct.setManageCandidateMode();
		manageProduct.setValidForResults(true);
		manageProduct.setProducts(results);
		manageProduct.setProductsTemp(results);
		// keep list of search criteria
        this.setDataAutoComplete(manageProduct, req);
        if (CPSHelper.isEmpty(manageProduct.getClasses())) {
        	manageProduct.setClasses(this.getCommonService().getClassesAsBaseJSFVOs());
        }
		if (CPSHelper.isEmpty(manageProduct.getProductTypes())) {
			manageProduct.setProductTypes(getAppContextFunctions().getProductTypes());
		}
		if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
			req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
		if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
			req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
		req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION, results);
		req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, results);
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);

		model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, manageProduct);
		return model;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = ManageCandidateController.RELATIVE_PATH_PRINT_PRODUCT_SUMMARY)
	public ModelAndView printProductSummary(
			@Valid @ModelAttribute(MANAGE_PRODUCT_MODEL_ATTRIBUTE) ManageProduct manageProduct, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_SEARCH_PAGE);
		manageProduct.setSession(req.getSession());
		setForm(req, manageProduct);

		CPSExportToExcel exportToExcel = new CPSExportToExcel();
		CandidateSearchCriteria candidateSearchCriteria = manageProduct.getProdcriteria();
		String printArray = manageProduct.getSelectedProductId();
		HttpSession session = req.getSession();
		// String userRole = getUserRole();
		UserInfo userInfo = getUserInfo();
		String userFullName = "";
		userFullName = userInfo.getAttributeValue("givenName") + " " + userInfo.getAttributeValue("sn") + " ["
				+ userInfo.getUid() + "]";
		List<String> prodIdAllList = new ArrayList<String>();
		String prodIdNormal = "";
		List<String> prodIdMrt = new ArrayList<String>();
		List<String> lstProdType = new ArrayList<String>();
		List<PrintSumaryProductVO> finalPrintList = new ArrayList<PrintSumaryProductVO>();
		printArray = printArray.substring(0, printArray.lastIndexOf('-'));
		StringTokenizer st = new StringTokenizer(printArray, "-");
		while (st.hasMoreTokens()) {
			prodIdAllList.add(st.nextToken());
		}
		String candTpeVal = manageProduct.getCandidateTypeList();
		StringTokenizer candTypeList = new StringTokenizer(candTpeVal, CPSConstants.COMMA);
		while (candTypeList.hasMoreTokens()) {
			lstProdType.add(candTypeList.nextToken());
		}
		int index = 0;
		for (final String candTyp : lstProdType) {
			if (CPSHelper.isNotEmpty(candTyp) && candTyp.equals(CPSConstants.NONE_MRT)) {
				prodIdNormal = prodIdNormal + prodIdAllList.get(index) + CPSConstants.COMMA;
			} else {
				if (CPSHelper.isNotEmpty(prodIdAllList.get(index))) {
					prodIdMrt.add(prodIdAllList.get(index));
				}
			}
			index++;
		}
		if (CPSHelper.isNotEmpty(prodIdNormal)) {
			prodIdNormal = prodIdNormal.substring(0, prodIdNormal.lastIndexOf(CPSConstants.COMMA));
			finalPrintList = getAddNewCandidateService().getPrintSummaryProductNormal(prodIdNormal, userFullName);
		}
		if (CPSHelper.isNotEmpty(prodIdMrt)) {
			final List<PrintSumaryProductVO> lstPrintSumaryMRT = getAddNewCandidateService()
					.getPrintSummaryProductMRT(prodIdMrt, userFullName);
			if (lstPrintSumaryMRT != null && !lstPrintSumaryMRT.isEmpty()) {
				finalPrintList.addAll(lstPrintSumaryMRT);
			}
		}
		Map<String, List<VendorLocationVO>> vendorMap = (Map<String, List<VendorLocationVO>>) session
				.getAttribute("vendorMap");

		if (null == vendorMap && BusinessUtil.isVendor(getUserRole())) {
			vendorMap = getVendorLocationList();
		}
		List<VendorLocationVO> vendorLocVOOfUser = new ArrayList<VendorLocationVO>();
		List<String> vendorUserIds = null;// new ArrayList<String>();
		if (BusinessUtil.isVendor(getUserRole())) {
			List<PrintSumaryProductVO> finalPrintLstTmp = new ArrayList<PrintSumaryProductVO>();
			for (final PrintSumaryProductVO printSuProdTmp : finalPrintList) {
				vendorUserIds = new ArrayList<String>();
				vendorLocVOOfUser = new ArrayList<VendorLocationVO>();
				if ("V".equalsIgnoreCase(printSuProdTmp.getChannel())) {
					vendorLocVOOfUser = vendorMap.get("whsLst");
				} else {
					if ("D".equalsIgnoreCase(printSuProdTmp.getChannel())) {
						vendorLocVOOfUser = vendorMap.get("dsdLst");
					} else {
						vendorLocVOOfUser.addAll(vendorMap.get("whsLst"));
						vendorLocVOOfUser.addAll(vendorMap.get("dsdLst"));
					}
				}
				for (final VendorLocationVO vendorLocationVO : vendorLocVOOfUser) {
					if (CPSHelper.isNotEmpty(vendorLocationVO.getVendorId())) {
						vendorUserIds.add(CPSHelper.checkVendorNumber(vendorLocationVO.getVendorId()));
					}
				}
				if (vendorUserIds != null
						&& vendorUserIds.contains(CPSHelper.checkVendorNumber(printSuProdTmp.getVendorNumber()))) {
					printSuProdTmp.setRetail("");
					finalPrintLstTmp.add(printSuProdTmp);
				}
			}

			finalPrintList.clear();

			finalPrintList = finalPrintLstTmp;
		}
		List<String> columnHeadings = columnHeadingProducts();
		if (CPSHelper.isNotEmpty(candidateSearchCriteria.getProductType())) {
			if (manageProduct.getProductTypes() != null && !manageProduct.getProductTypes().isEmpty()) {
				for (BaseJSFVO baseJSFVO : manageProduct.getProductTypes()) {
					if (baseJSFVO.getId() != null
							&& baseJSFVO.getId().equals(candidateSearchCriteria.getProductType())) {
						candidateSearchCriteria.setProductTypeName(baseJSFVO.getName());
						break;
					}
				}
			}
		}
		exportToExcel.exportToExcelProduct(columnHeadings, finalPrintList, "PrintSummary", null,
				candidateSearchCriteria, resp, req, hebLdapUserService);
		model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, manageProduct);
		return model;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = ManageCandidateController.RELATIVE_PATH_PRODUCT_FILTER_CHANGE)
	public ModelAndView productFilterChange(
			@Valid @ModelAttribute(MANAGE_PRODUCT_MODEL_ATTRIBUTE) ManageProduct manageProduct, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_AJAX_RESULTS_PAGE);
		manageProduct.setSession(req.getSession());
		setForm(req, manageProduct);

		List<ProductSearchResultVO> products = new ArrayList<ProductSearchResultVO>();
		products = (List<ProductSearchResultVO>) req.getSession()
				.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
		manageProduct.setValidForResults(true);
		List<ProductSearchResultVO> productTemps = new ArrayList<ProductSearchResultVO>();
		/*
		 * Filter by Mrt Switch
		 * 
		 * @author khoapkl
		 */
		if (manageProduct.getProdcriteria().isMrtSwitchCheck() == false) {
			productTemps = products;
		} else {
			for (ProductSearchResultVO searchResultVO : products) {
				boolean isMRT = searchResultVO.getMrtLabel().equals(CPSConstants.MRT) ? true : false;
				if (manageProduct.getProdcriteria().isMrtSwitchCheck() == isMRT) {
					productTemps.add(searchResultVO);
				}
			}
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();
		// vendor id
		if (manageProduct.getVndrId() != null && !CPSConstants.EMPTY_STRING.equals(manageProduct.getVndrId().trim())) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (manageProduct.getVndrId().equals(searchResultVO.getVendorId())) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();
		// vendor desc
		if (CPSWebUtil.replaceHTMLSpecialChars(manageProduct.getVndrDesc()) != null && !CPSConstants.EMPTY_STRING
				.equals(CPSWebUtil.replaceHTMLSpecialChars(manageProduct.getVndrDesc().trim()))) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (CPSWebUtil.replaceHTMLSpecialChars(manageProduct.getVndrDesc())
						.equals(CPSHelper.trimSpaces(searchResultVO.getVendorDesc()))) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();
		// UPC
		if (manageProduct.getVndrUnitUpc() != null
				&& !CPSConstants.EMPTY_STRING.equals(manageProduct.getVndrUnitUpc().trim())) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (manageProduct.getVndrUnitUpc().equals(searchResultVO.getUnitUPC())) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();
		// Product Desc
		if (CPSWebUtil.replaceHTMLSpecialChars(manageProduct.getPrdDesc()) != null && !CPSConstants.EMPTY_STRING
				.equals(CPSWebUtil.replaceHTMLSpecialChars(manageProduct.getPrdDesc().trim()))) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (CPSWebUtil.replaceHTMLSpecialChars(manageProduct.getPrdDesc())
						.equals(CPSHelper.trimSpaces(searchResultVO.getProductDesc()))) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();

		// pres date
		if (manageProduct.getProdPresDate() != null
				&& !CPSConstants.EMPTY_STRING.equals(manageProduct.getProdPresDate().trim())) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (manageProduct.getProdPresDate().equals(searchResultVO.getPressDate())) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();

		// Item code
		if (manageProduct.getProdItemCode() != null
				&& !CPSConstants.EMPTY_STRING.equals(manageProduct.getProdItemCode().trim())) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (manageProduct.getProdItemCode().equals(searchResultVO.getItemCode())) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();

		// Activation date
		if (manageProduct.getActivateDate() != null
				&& !CPSConstants.EMPTY_STRING.equals(manageProduct.getActivateDate().trim())) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (manageProduct.getActivateDate().equals(searchResultVO.getActivationDate())) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		productTemps = new ArrayList<ProductSearchResultVO>();

		// master pack
		if (manageProduct.getMasterPack() != null
				&& !CPSConstants.EMPTY_STRING.equals(manageProduct.getMasterPack().trim())) {
			for (ProductSearchResultVO searchResultVO : products) {
				if (manageProduct.getMasterPack().equals(searchResultVO.getMasterPack())) {
					productTemps.add(searchResultVO);
				}
			}
		} else {
			productTemps = products;
		}
		products = productTemps;
		if (products.isEmpty()) {
			saveMessage(manageProduct, new CPSMessage("No matches found, change criteria", ErrorSeverity.WARNING));
		} else if (products.size() > 1) {
			saveMessage(manageProduct,
					new CPSMessage(products.size() + CPSConstants.PRODUCTS_FOUND, ErrorSeverity.INFO));
		} else {
			saveMessage(manageProduct,
					new CPSMessage(products.size() + CPSConstants.PRODUCT_FOUND, ErrorSeverity.INFO));
		}
		manageProduct.setSortCaseValue(0);
		manageProduct.setProductsTemp(products);
		if (req.getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
			req.getSession().removeAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
		req.getSession().setAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, products);

		model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, manageProduct);
		return model;
	}

	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = ManageCandidateController.RELATIVE_PATH_PRODUCT_FILTER_CHANGE_CLEAR)
	public ModelAndView productFilterChangeClear(
			@Valid @ModelAttribute(MANAGE_PRODUCT_MODEL_ATTRIBUTE) ManageProduct manageProduct, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_AJAX_RESULTS_PAGE);
		manageProduct.setSession(req.getSession());
		setForm(req, manageProduct);

		List<ProductSearchResultVO> products = new ArrayList<ProductSearchResultVO>();
		manageProduct.setProductsTemp(products);
		model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, manageProduct);
		return model;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = ManageCandidateController.RELATIVE_PATH_SORT_FILTER)
	public ModelAndView sortFilter(@Valid @ModelAttribute(MANAGE_PRODUCT_MODEL_ATTRIBUTE) ManageProduct manageProduct,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_AJAX_RESULTS_PAGE);
		manageProduct.setSession(req.getSession());
		setForm(req, manageProduct);

		List<ProductSearchResultVO> products = (List<ProductSearchResultVO>) req.getSession()
				.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
		if (manageProduct.getSortCaseValue() == 0) {
			products = (List<ProductSearchResultVO>) req.getSession()
					.getAttribute(CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
			Collections.sort(products, ProductSearchResultVO.getComparator(1));
		} else {
			Collections.sort(products, ProductSearchResultVO.getComparator(manageProduct.getSortCaseValue()));
		}
		if (CPSConstants.DOWN.equals(manageProduct.getDirection())) {
			Collections.reverse(products);
		}
		manageProduct.setValidForResults(true);
		manageProduct.setProductsTemp(products);

		model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, manageProduct);
		return model;
	}

	private List<String> columnHeadingProducts() {
		List<String> columnPrinSumaryProductHeadings = new ArrayList<String>();
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_VENDOR_NAME);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_UPC);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_DESCRIPTION);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SELLINGUNIT_SIZE);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_UOM);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_STYLE);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_MODEL);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_COLOR);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_BRAND);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_PACKING);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_RARING_TYPE_RATING);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_CASE_UPC);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_MASTER_PACK);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SHIP_PACK);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_MAX_SHELF_LIFE_DAYS);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_COST_LINK_UPC);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_COUNTRY_OF_ORIGIN);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_LIST_COST);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_UNIT_COST);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SUGGESTED_UNIT_RETAIL);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_PREPRICE_UNIT_RETAIL);
		// HebApprovedSellingPrice
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_RETAIL);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_PENNY_PROFIT);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_PERCENT_MARGIN);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_RETAIL_LINK_UPC);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_ITEM_CODE);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SEASONALITY_YEAR);
		// Code Date
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_INBOUND_SPECIFICATION_DAYS);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_REACTION_DAYS);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_GUARANTEE_TO_STORE_DAYS);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SUB_COMMODITY);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_BDM);
		// new Attribute
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SUB_DEPT_NAME);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_PSS_DEPT);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_SOURCE_METHOD);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_STATUS);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_TESTSCAN);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_ID_OF_USER);
		columnPrinSumaryProductHeadings.add(CPSConstants.PRINSUMARY_COLUMN_EMPTY);
		return columnPrinSumaryProductHeadings;
	}

	private void setDataAutoComplete(HebBaseInfo manageMainForm, HttpServletRequest req) throws CPSGeneralException {
		CandidateSearchCriteria searchCriteria = null;
		if (manageMainForm instanceof ManageCandidate) {
			searchCriteria = ((ManageCandidate) manageMainForm).getCriteria();
		} else if (manageMainForm instanceof ManageProduct) {
			searchCriteria = ((ManageProduct) manageMainForm).getProdcriteria();
		}
		try {
			populateBDMs(manageMainForm, req);
		} catch (Exception e) {
			LOG.error("Error get populateBDMs Exception :" + e.getMessage());
		}
		if (searchCriteria != null) {
			if (CPSHelper.isNotEmpty(searchCriteria.getBdm())) {
				manageMainForm.setCommodities(
						this.getCommoditiesFromBDM(manageMainForm, searchCriteria.getBdm()));
			} else {
				try {
					populateCommodities(manageMainForm, req);
				} catch (Exception e) {
					LOG.error("Error get populateCommodities Exception :" + e.getMessage());
				}
			}
			if (CPSHelper.isNotEmpty(searchCriteria.getCommodity())) {
				manageMainForm.setSubCommodities(this.getCommonService().getSubCommodityByClassAndCommodity(
						searchCriteria.getClassField(), searchCriteria.getCommodity()));
			} else {
				try {
					populateSubCommodities(manageMainForm, req);
				} catch (Exception e) {
					LOG.error("Error get populateSubCommodities Exception :" + e.getMessage());
				}
			}
		}
	}

	private String getJSONForProduct(List<Integer> activatedWorkIdList) {
		StringBuilder row4Builder = new StringBuilder();
		try {
			List<ActivationMessageVO> activationMessageVOList = getCommonService()
					.getActivationInfo(activatedWorkIdList);
			Iterator<ActivationMessageVO> activationMessageVOIterator = activationMessageVOList.iterator();
			while (activationMessageVOIterator.hasNext()) {
				ActivationMessageVO activationMessageVO = activationMessageVOIterator.next();
				String itemInfo = getItemInfo(activationMessageVO.getItemCodes());
				String upcInfo = getUPC(activationMessageVO.getUpc());
				row4Builder.append("{\"code\":\"Product Id :\", \"desc\":\""
						+ CPSHelper.getTrimmedValue(activationMessageVO.getProductID()) + "\"},");
				row4Builder.append("{\"code\":\"Product Description :\",  \"desc\":\""
						+ CPSHelper.correctDQuotes(activationMessageVO.getProductDesc()) + "\"},");
				row4Builder.append("{\"code\":\"Item Code(s) :\",\"desc\":\"" + itemInfo + "\"},");
				row4Builder.append("{\"code\":\"UPC(s) :\",\"desc\":\"" + upcInfo + "\"},");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return row4Builder.toString();
	}

	private String getJSONForMRT(List<Integer> activatedWorkIdList) {
		StringBuilder row4Builder = new StringBuilder();
		try {
			List<ActivationMessageVO> activationMessageVOList = getCommonService()
					.getActivationInfoForMRT(activatedWorkIdList);
			for (ActivationMessageVO activationMessageVO : activationMessageVOList) {
				String upcInfo = getMrtUPC(activationMessageVO.getMrtUPC());
				row4Builder.append("{\"code\":\"MRT Case Id :\", \"desc\":\"" + activationMessageVO.getProductID()
						+ " - " + CPSHelper.correctDQuotes(activationMessageVO.getProductDesc()) + "\"},");
				row4Builder.append("{\"code\":\"New UPC(s) tied to this MRT :\",  \"desc\":\"" + upcInfo + "\"},");
				// waiting data
				row4Builder.append("{\"code\":\" \",  \"desc\":\" \"},");
				row4Builder.append("{\"code\":\" \",  \"desc\":\" \"},");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return row4Builder.toString();
	}

	/**
	 * @author thangdang (VODC)
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
			StringBuilder row4Builder = new StringBuilder();
			Iterator<ActivationMessageVO> activationMessageVOIterator = activationMessageVOList.iterator();
			while (activationMessageVOIterator.hasNext()) {
				ActivationMessageVO activationMessageVO = activationMessageVOIterator.next();
				String itemInfo = getItemInfo(activationMessageVO.getItemCodes());
				String upcInfo = getUPC(activationMessageVO.getUpc());
				row4Builder.append("{\"code\":\"Candidate Id :\", \"desc\":\""
						+ activationMessageVO.getProductID().toString() + "\"},");
				row4Builder.append("{\"code\":\"Candidate Description :\",  \"desc\":\""
						+ CPSHelper.correctDQuotes(activationMessageVO.getProductDesc()) + "\"},");
				row4Builder.append("{\"code\":\"Candidate Item Code(s) :\",\"desc\":\"" + itemInfo + "\"},");
				row4Builder.append("{\"code\":\"UPC(s) :\",\"desc\":\"" + upcInfo + "\"},");
			}
			row4 = row4Builder.toString();
			row4 = row4.substring(0, row4.length() - 1);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		String close = "]}}";
		return jsonString + row4 + close;
	}

	private String getItemInfo(List<String> itemInfo) {
		StringBuilder returnBuilder = new StringBuilder();
		for (String strItem : itemInfo) {
			returnBuilder.append(CPSHelper.correctDQuotes(strItem) + "<br>");
		}
		return returnBuilder.toString();
	}

	private String getUPC(List<String> UPCInfo) {
		String returnVal = "";
		for (String upc : UPCInfo) {
			returnVal = returnVal + upc + "-" + CPSHelper
                    .getCheckDigit(upc.trim()) + "<br>";
		}
		return returnVal;
	}

	private String getMrtUPC(List<String> UPCInfo) {
		StringBuilder returnBuilder = new StringBuilder();
		for (String mrtupc : UPCInfo) {
			int dot = mrtupc.lastIndexOf('.');
			String strUPC = "";
			if (dot >= 0) {
				strUPC = mrtupc.substring(0, dot);
			} else {
				strUPC = mrtupc;
			}
			returnBuilder.append(strUPC + "-" + CPSHelper
                    .getCheckDigit(strUPC) + "<br>");
		}
		return returnBuilder.toString();
	}

	public BaseJSFVO getClassFromCommodities(String commodityId) throws Exception {
		List<BaseJSFVO> classComMap = this.getCommonService().getClassForCommodity(commodityId);
		if (classComMap.isEmpty()) {
			return new BaseJSFVO("", "");
		} else {
			String classDesc = CPSHelper.getTrimmedValue(classComMap.get(0).getName());
			classDesc = classDesc.substring(0, classDesc.indexOf('['));
			return new BaseJSFVO(classComMap.get(0).getId(), classDesc);
		}
	}

    public List<BaseJSFVO> getBDMForCommodity(String commodityId)
            throws CPSGeneralException {
        return getCommonService().getBDMForCommodity(commodityId);
    }

    @RequestMapping(method = RequestMethod.GET, value = ManageCandidateController.RELATIVE_PATH_KEEP_VALUE_CANDIDATE_SEARCH)
    public ModelAndView keepValueCandidateSearch(ManageCandidate manageCandidate, HttpServletRequest req,
                                          HttpServletResponse resp)throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE+CPSConstants.CPS_MANAGE_MAIN);
        ManageCandidate candidateMainForm = (ManageCandidate) req.getSession().getAttribute(ManageCandidate.FORM_NAME);
        if (candidateMainForm == null)
            candidateMainForm = manageCandidate;
        setForm(req, candidateMainForm);
        candidateMainForm.setSession(req.getSession());
        candidateMainForm.setUserRole(this.getUserRole());
        clearModifyMode(candidateMainForm);
        if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))
                && (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_PLU_REJECT_VALUE)))) {
            if (req.getSession().getAttribute(CPSConstants.CPS_CRITERIA_SESSION) != null) {
                CandidateSearchCriteria cri = (CandidateSearchCriteria) req.getSession().getAttribute(CPSConstants.CPS_CRITERIA_SESSION);
                cri.setMrtSwitchCheck(false);
                candidateMainForm.setCriteria(cri);
            }
            List<SearchResultVO> list = (List<SearchResultVO>) req
                    .getSession().getAttribute(CPSConstants.CPS_SEARCH_RESULTS_SESSION);
            if (list != null) {
                candidateMainForm.setProducts(list);
                candidateMainForm.setProductsTemp(list);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                if (req.getSession().getAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                    req.getSession().removeAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
                req.getSession().setAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION, list);
                req.getSession().setAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, list);
                saveMessage(candidateMainForm, new CPSMessage(list.size()
                        + CPSConstants.CANDIDATES_FOUND, ErrorSeverity.INFO));
                clearSessionPaging(req);
                processPaging(req, null, null, list, candidateMainForm);
            }

            candidateMainForm.setClasses(getCommonService()
                    .getClassesAsBaseJSFVOs());
            candidateMainForm.setAllStatus(initStatus(getUserRole()));
            if (CPSHelper.isEmpty(candidateMainForm.getProductTypes())) {
                candidateMainForm.setProductTypes(getAppContextFunctions()
                        .getProductTypes());
            }
            candidateMainForm.setValidForCandSearch(true);
            candidateMainForm.setValidForResults(false);
            candidateMainForm
                    .setSelectedFunction(CPSConstants.MAANAGE_CANDIDATE);
            candidateMainForm.setManageCandidateMode();
            candidateMainForm.setValidForResults(true);
            populateBDMs(candidateMainForm, req);
            /*
             * Initial commodity and sub-commodity for the first run
             *
             * @author nghianguyen
             */
            populateCommodities(candidateMainForm, req);
            populateSubCommodities(candidateMainForm, req);
        } else {
            // bug #6585
            if (CPSHelper.isNotEmpty(req.getSession().getAttribute(
                    CPSConstants.MODIFY_PLU_REJECT_VALUE))) {
                req.getSession().removeAttribute(
                        CPSConstants.MODIFY_PLU_REJECT_VALUE);
            }
            CandidateSearchCriteria candSearchCriteria = (CandidateSearchCriteria) req
                    .getSession().getAttribute(CPSConstants.CPS_CRITERIA_SESSION);
            if (candSearchCriteria != null) {
                if (CPSHelper.isNotEmpty(candSearchCriteria.getCommodity())) {
                    if (!CPSHelper.isNotEmpty(candSearchCriteria.getBdm())) {
                        candidateMainForm
                                .setBdms(getBDMForCommodity(candSearchCriteria
                                        .getCommodity()));
                    }
                }
                candidateMainForm.setCriteria(candSearchCriteria);
                candidateMainForm.setCommodities(getCommoditiesFromBDM(
                        candidateMainForm, candSearchCriteria.getBdm()));
                candidateMainForm.setSubCommodities(getCommonService()
                        .getSubCommodityByClassAndCommodity(
                                candSearchCriteria.getClassField(),
                                candSearchCriteria.getCommodity()));
            } else {
                populateBDMs(candidateMainForm, req);
                populateCommodities(candidateMainForm, req);
                populateSubCommodities(candidateMainForm, req);
                candidateMainForm.setClasses(getCommonService()
                        .getClassesAsBaseJSFVOs());
                candidateMainForm.setAllStatus(initStatus(getUserRole()));
            }
            if (CPSHelper.isEmpty(candidateMainForm.getProductTypes())) {
                candidateMainForm.setProductTypes(getAppContextFunctions()
                        .getProductTypes());
            }
            candidateMainForm.getQuestionnarieVO().setSelectedOption("1");
            candidateMainForm.getQuestionnarieVO().setSelectedValue(null);
            clearViewMode(candidateMainForm);
            candidateMainForm.getProducts().clear();
            if (req.getSession().getAttribute(
                    CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                req.getSession().removeAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            CandidateSearchCriteria searchCriteria = (CandidateSearchCriteria) req
                    .getSession().getAttribute(CPSConstants.CPS_CRITERIA_SESSION);
            if (searchCriteria != null
                    && searchCriteria.isBatchUploadSwitch()) {
                candidateMainForm.setHidBatchUploadSwitch(true);
            } else {
                candidateMainForm.setHidBatchUploadSwitch(false);
            }
            /*
             * Reset mrtSwitch
             *
             * @author khoapkl
             */
            if (searchCriteria != null) {
                searchCriteria.setMrtSwitchCheck(false);
                if (CPSHelper.isNotEmpty(searchCriteria
                        .getVendorDescription())
                        && CPSHelper.isEmpty(searchCriteria
                        .getVendorIDList())) {
                    List<Integer> vendorIDList = new ArrayList<Integer>();
                    try {
                        Integer vendorID = CPSHelper
                                .getIntegerValue(searchCriteria
                                        .getVendorDescription());
                        vendorIDList.add(vendorID);
                        VendorList vendorList = new VendorList(null, null,
                                vendorID);
                        List<WareHouseVO> warehouseList = getCommonService()
                                .getWareHouseList(vendorList, null);
                        if (CPSHelper.isNotEmpty(warehouseList)) {
                            String padVendorID = CPSHelper.padZeros(
                                    searchCriteria.getVendorDescription(),
                                    6);
                            for (WareHouseVO whVo : warehouseList) {
                                int vendorId = CPSHelper.getIntegerValue(whVo
                                        .getWhareHouseid() + padVendorID);
                                if(vendorId>0) {
                                    vendorIDList.add(vendorId);
                                }
                            }
                        }
                    } catch (NumberFormatException num) {
                        // It is not a Vendor ID - go on.
                    } catch (CPSSystemException sys) {
                        // Service not up - log & go on.
                        LOG.error("Unable to get Warehouse service", sys);
                    } catch (CPSGeneralException gen) {
                        // no warehouses found - could be DSD vendor - go
                        // on.
                        LOG.warn("Unable to get Warehouse service", gen);
                    }
                    if (!vendorIDList.isEmpty()) {
                        searchCriteria.setVendorIDList(vendorIDList);
                    }
                }

                searchCriteria
                        .setUserName(getCommonService().getUserName());
                searchCriteria.setRole(getUserRole());
                // Albin - other criteria to be added
                List<SearchResultVO> results = getCommonService()
                        .getCandidatesForCriteria(searchCriteria);
                if (results != null) {
                    if (results.isEmpty()) {
                        // Checking for Activation
                        if (!candidateMainForm.isActivateSwitch()) {
                            saveMessage(candidateMainForm, new CPSMessage(
                                    "No matches found,change criteria",
                                    ErrorSeverity.WARNING));
                        }
                    } else {
                        if (searchCriteria.isMrtSwitchCheck()) {
                            candidateMainForm.setHidManageMrtSwitch(true);
                        } else {
                            candidateMainForm.setHidManageMrtSwitch(false);
                        }
                        if (!candidateMainForm.isActivateSwitch()) {
                            if (results.size() > 1) {
                                saveMessage(candidateMainForm,
                                        new CPSMessage(results.size()
                                                + CPSConstants.CANDIDATES_FOUND,
                                                ErrorSeverity.INFO));
                            } else {
                                saveMessage(candidateMainForm,
                                        new CPSMessage(results.size()
                                                + CPSConstants.CANDIDATE_FOUND,
                                                ErrorSeverity.INFO));
                            }
                        }
                    }
                    candidateMainForm.setValidForCandSearch(true);
                    candidateMainForm.setValidForResults(false);
                    candidateMainForm
                            .setSelectedFunction(CPSConstants.MAANAGE_CANDIDATE);
                    candidateMainForm.setManageCandidateMode();
                    candidateMainForm.setValidForResults(true);
                    candidateMainForm.setProducts(results);
                    candidateMainForm.setProductsTemp(results);
                    if (req.getSession().getAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION) != null)
                        req.getSession().removeAttribute(
                                CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
                    if (req.getSession().getAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION) != null)
                        req.getSession().removeAttribute(
                                CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION);
                    req.getSession().setAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION, results);
                    req.getSession().setAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, results);
                    clearSessionPaging(req);
                    processPaging(req, null, null, results,
                            candidateMainForm);
                    /*
                     * keep results and criteria search in session It used
                     * for reject candidate at search page
                     */
                    req.getSession().setAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_SESSION, results);
                    req.getSession().setAttribute(CPSConstants.CPS_CRITERIA_SESSION,
                            candidateMainForm.getCriteria());

                    /*
                     * identify search result is not empty and don't execute
                     * search by Mrt Switch
                     *
                     * @author khoapkl
                     */
                    req.setAttribute("noData", !results.isEmpty() ? true
                            : false);
                }

                // keep bdm value after searching
                candidateMainForm.getCriteria().setBdmValue(
                        candidateMainForm.getCriteria().getBdmValue());
                candidateMainForm.setAllStatus(initStatus(getUserRole()));
            } else {
                candidateMainForm.setAllStatus(initStatus(getUserRole()));
            }

            if (candidateMainForm.getUserRole().equals(
                    CPSConstants.REGISTERED_VENDOR_ROLE)
                    || candidateMainForm.getUserRole().equals(
                    CPSConstants.UNREGISTERED_VENDOR_ROLE)) {
                req.getSession().removeAttribute(
                        CPSConstants.VENDOR_LOGIN_COFIRM);
                req.getSession().setAttribute(
                        CPSConstants.VENDOR_LOGIN_COFIRM, "true");
            }
            Object currentMode = req.getSession().getAttribute(
                    CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            req.getSession().removeAttribute(CPSConstants.MODIFY_VALUE);
            // end bug #6585
        }
        model.addObject(MANAGE_CANDIDATE_MODEL_ATTRIBUTE,candidateMainForm);
        return model;
    }

    @RequestMapping(method = RequestMethod.GET, value = ManageCandidateController.RELATIVE_PATH_KEEP_VALUE_PRODUCT_SEARCH)
    public ModelAndView keepValueProductSearch(ManageProduct manageProduct, HttpServletRequest req,
                                                 HttpServletResponse resp)throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_ROOT_PAGE + RELATIVE_PATH_PRODUCT_SEARCH_PAGE);
        ManageProduct productForm = (ManageProduct) req.getSession().getAttribute(ManageProduct.FORM_NAME);
        if (productForm == null)
            productForm = manageProduct;
        setForm(req, productForm);
        productForm.setSession(req.getSession());
        clearModifyMode(productForm);

        if (CPSHelper.isEmpty(req.getSession().getAttribute(
                CPSConstants.MODIFY_VALUE))) {
            List<ProductSearchResultVO> results = (List<ProductSearchResultVO>) req
                    .getSession().getAttribute(
                            CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION);
            saveMessage(productForm, new CPSMessage(results.size()
                    + CPSConstants.PRODUCTS_FOUND, ErrorSeverity.INFO));
            productForm.setValidForCandSearch(true);
            productForm.setValidForResults(false);
            productForm.setSelectedFunction(CPSConstants.COPY_PRODUCT);
            productForm.setManageCandidateMode();
            productForm.setValidForResults(true);
            productForm.setClasses(getCommonService()
                    .getClassesAsBaseJSFVOs());
            if (CPSHelper.isEmpty(productForm.getProductTypes())) {
                productForm.setProductTypes(getAppContextFunctions()
                        .getProductTypes());
            }
            populateBDMs(productForm, req);
        } else {

            CandidateSearchCriteria searchCriteria = productForm
                    .getProdcriteria();
            /*
             * Reset mrtSwitch
             *
             * @author khoapkl
             */
            // productForm.setProdcriteria(searchCriteria);
            if (searchCriteria == null) {
                productForm.setHidManageMrtSwitch(false);
            } else {
                searchCriteria.setMrtSwitchCheck(false);
                if (searchCriteria.isMrtSwitchCheck()) {
                    productForm.setHidManageMrtSwitch(true);
                } else {
                    productForm.setHidManageMrtSwitch(false);
                }
            }
            if (searchCriteria != null) {
                // TODO - Albin - other criteria to be added
                if (CPSHelper.isNotEmpty(searchCriteria
                        .getVendorDescription())
                        && CPSHelper.isEmpty(searchCriteria
                        .getVendorIDList())) {
                    List<Integer> vendorIDList = new ArrayList<Integer>();
                    try {
                        Integer vendorID = CPSHelper
                                .getIntegerValue(searchCriteria
                                        .getVendorDescription());
                        vendorIDList.add(vendorID);
                        VendorList vendorList = new VendorList(null, null,
                                vendorID);
                        List<WareHouseVO> warehouseList = getCommonService()
                                .getWareHouseList(vendorList, null);
                        if (CPSHelper.isNotEmpty(warehouseList)) {
                            String padVendorID = CPSHelper.padZeros(
                                    searchCriteria.getVendorDescription(),
                                    6);
                            for (WareHouseVO whVo : warehouseList) {
                                vendorIDList.add(CPSHelper
                                        .getIntegerValue(whVo
                                                .getWhareHouseid()
                                                + padVendorID));
                            }
                        }
                    } catch (NumberFormatException num) {
                        LOG.error(num.getMessage(), num);
                    } catch (CPSSystemException sys) {
                        // Service not up - log & go on.
                        LOG.error("Unable to get Warehouse service", sys);
                    } catch (CPSGeneralException gen) {
                        // no warehouses found - could be DSD vendor - go
                        // on.
                        LOG.warn("Unable to get Warehouse service", gen);
                    }
                    if (!vendorIDList.isEmpty()) {
                        searchCriteria.setVendorIDList(vendorIDList);
                    }
                }

                List<ProductSearchResultVO> results = getCommonService()
                        .getProductsForCriteria(searchCriteria);
                if (results != null) {
                    if (results.isEmpty()) {
                        saveMessage(productForm, new CPSMessage(
                                "No matches found, change criteria",
                                ErrorSeverity.WARNING));
                    } else if (results.size() > 1) {
                        saveMessage(productForm,
                                new CPSMessage(results.size()
                                        + CPSConstants.PRODUCTS_FOUND,
                                        ErrorSeverity.INFO));
                    } else {
                        saveMessage(
                                productForm,
                                new CPSMessage(results.size()
                                        + CPSConstants.PRODUCT_FOUND, ErrorSeverity.INFO));
                    }
                }

                /*
                 * keep criteria and result search in session It used for
                 * back to search from AddCandidateOtherInfo.jsp page
                 */
                // req.getSession().setAttribute(CPS_SEARCH_RESULTS_SESSION,
                // results);
                // req.getSession().setAttribute(CPS_CRITERIA_SESSION,
                // productForm.getProdcriteria());
                /*
                 * identify search result is not empty and don't execute
                 * search by Mrt Switch
                 *
                 * @author khoapkl
                 */
                req.setAttribute("noData",
                        results != null && !results.isEmpty() ? true
                                : false);
                productForm.setValidForCandSearch(true);
                productForm.setValidForResults(false);
                productForm
                        .setSelectedFunction(CPSConstants.MAANAGE_CANDIDATE);
                productForm.setManageCandidateMode();
                productForm.setValidForResults(true);
                productForm.setProducts(results);
                productForm.setProductsTemp(results);
                req.getSession().setAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_MAIN_SESSION, results);
                req.getSession().setAttribute(
                        CPSConstants.CPS_SEARCH_RESULTS_TEMP_SESSION, results);
                if (CPSHelper.isEmpty(productForm.getProductTypes())) {
                    productForm.setProductTypes(getAppContextFunctions()
                            .getProductTypes());
                }
                Object currentMode = req.getSession().getAttribute(
                        CPSConstants.CURRENT_MODE_APP_NAME);
                if (currentMode != null)
                    req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
                req.getSession().removeAttribute(CPSConstants.MODIFY_VALUE);
            } else {
                if (CPSHelper.isEmpty(productForm.getProductTypes())) {
                    productForm.setProductTypes(getAppContextFunctions()
                            .getProductTypes());
                }
            }
        }
        model.addObject(MANAGE_PRODUCT_MODEL_ATTRIBUTE, productForm);
        return model;
    }
}