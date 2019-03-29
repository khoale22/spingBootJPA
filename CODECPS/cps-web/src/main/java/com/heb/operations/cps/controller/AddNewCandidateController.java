package com.heb.operations.cps.controller;

import com.heb.jaf.security.HebLdapUserService;
import com.heb.jaf.security.UserInfo;
import com.heb.operations.business.framework.exeption.CPSBusinessException;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.exeption.CPSMessage.ErrorSeverity;
import com.heb.operations.business.framework.exeption.CPSSystemException;
import com.heb.operations.business.framework.vo.*;
import com.heb.operations.cps.database.entities.CstOwn;
import com.heb.operations.cps.database.entities.PdNisCntlTab;
import com.heb.operations.cps.database.entities.PsCandidateStat;
import com.heb.operations.cps.ejb.webservice.WarehouseService.GetWarehouseListByVendor_Request.VendorList;
import com.heb.operations.cps.excelExport.CPSExportToExcel;
import com.heb.operations.cps.model.AddNewCandidate;
import com.heb.operations.cps.model.ManageCandidate;
import com.heb.operations.cps.model.ManageEDICandidate;
import com.heb.operations.cps.util.*;
import com.heb.operations.cps.vo.*;
import com.heb.operations.ui.framework.exception.CPSWebException;
import com.heb.sadc.utils.AntiVirusException;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import java.io.ByteArrayInputStream;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by vn70516 on 11/23/2017.
 */
@Controller
@SessionAttributes(AddNewCandidateController.ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)
@RequestMapping(value = AddNewCandidateController.RELATIVE_PATH_ADD_NEW_CANDIDATE_BASE)
public class AddNewCandidateController extends HEBBaseService {

    @Autowired
    HebLdapUserService hebLdapUserService;

    private static final Logger LOG = Logger.getLogger(HEBBaseService.class);
    public static final String RELATIVE_PATH_ADD_NEW_CANDIDATE_BASE="/protected/cps/add";

    //Url
    public static final String RELATIVE_PATH_NAV_TO_PROD_AND_UPC="/navToProdAndUPC";
    public static final String RELATIVE_PATH_CHECK_DSV_ITEM="/checkDSVItem";
    public static final String RELATIVE_PATH_FETCH_PRODUCT="/fetchProduct";
    public static final String RELATIVE_PATH_AUTH_AND_DIST="/authAndDist";
    public static final String RELATIVE_PATH_SAVE_DETAIL="/saveDetail";

    //Page
    public static final String RELATIVE_PATH_QUESTIONNAIRE_PAGE = "/cps/add/modules/questionnaire";
    public static final String RELATIVE_PATH_NEW_PRODUCT_PAGE = "/cps/add/AddCandidateOtherInfo";
    private static final String RELATIVE_PATH_PSE_POPUP_PAGE ="/cps/add/modules/psePopup";
    private static final String RELATIVE_PATH_WIC_POPUP_PAGE ="/cps/add/modules/wic_popup";
    private static final String RELATIVE_PATH_ADD_SUB_BRAND_PAGE ="/cps/add/modules/subBrand_popup";
    private static final String RELATIVE_PATH_PLU_GENERATION_POPUP_PAGE ="/cps/add/modules/pluGenerationPopup";
    private static final String RELATIVE_PATH_MATRIX_MARGIN_POPUP_PAGE ="/cps/add/modules/matrixMargin_popup";
    private static final String RELATIVE_PATH_ASSORMENT_PAGE ="/cps/add/modules/assortment";
    private static final String RELATIVE_PATH_RETAIL_LINK_POPUP ="/cps/add/modules/retailLinkPopup";
    private static final String RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE ="/cps/add/modules/ajaxGetDataJson";

    public static final String RELATIVE_PATH_REQUEST_NEW_ATT_PAGE = "/cps/add/modules/requestNewAttribute";
    private static final String RELATIVE_PATH_MRT_MAIN_AJAX_PAGE = "/cps/add/modules/MrtMainAjax";
    private static final String RELATIVE_PATH_VIEW_FACTORIES_PAGE = "/cps/add/modules/viewFactories";
    private static final String RELATIVE_PATH_AUTHORIZE_WHS_PAGE = "/cps/add/modules/authorizeWHS_popup";
    private static final String RELATIVE_PATH_VIEW_STORE_PAGE = "/cps/add/modules/viewStore";
    private static final String RELATIVE_PATH_AUTH_AND_DIST_AJAX = "/cps/add/modules/authAndDistAjax";
    private static final String RELATIVE_PATH_CONFLICT_STORES = "/cps/add/modules/ConflictStores";
    private static final String RELATIVE_PATH_AUTH_AND_DIST_VENDOR_AJAX = "/cps/add/modules/authAndDistVendorAjax";
    private static final String RELATIVE_PATH_PRINT_CANDIDATE = "/cps/manage/modules/printCandidate";
    private static final String RELATIVE_PATH_PRINT_FORM_MRTZ = "/cps/manage/modules/printFormMRTz";
    private static final String RELATIVE_PATH_REJECT_ADD_CANDIDATE_PAGE = "/cps/add/modules/rejectAddCandidate_popup";
    private static final String RELATIVE_PATH_BACK_TO_EDI_SEARCH_PAGE = "/protected/cps/manageEDI/keepValueSearch";
    private static final String RELATIVE_PATH_BACK_TO_CANDIDATE_SEARCH_PAGE = "/protected/cps/manage/keepValueCandidateSearch";
    private static final String RELATIVE_PATH_BACK_TO_PRODUCT_SEARCH_PAGE = "/protected/cps/manage/keepValueProductSearch";
    private static final String RELATIVE_PATH_TEST_SCAN_POPUP_PAGE = "/cps/manage/modules/testScanNew_popup";
    private static final String RELATIVE_PATH_REJECT_CAND_COMMENT_POPUP_PAGE = "/cps/add/modules/rejectAddCandidate_popup";

    public static final String ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE="addNewCandidate";
    private static final String RELATIVE_PATH_MRT_SCREEN ="mrtScreen";
    private static final String RELATIVE_PATH_SHOW_MRT ="showMRT";
    private static final String RELATIVE_PATH_PROD_AND_UPC ="prodAndUpc";
    private static final String RELATIVE_PATH_POW ="pow";
    private static final String RELATIVE_PATH_TRACK_ERROR_UPC ="trackErrorUPC";
    private static final String RELATIVE_PATH_QUESTIONNAIRE_WRAPPER ="questionnaireWrapper";
    private static final String RELATIVE_PATH_QUESTIONNAIRE ="questionnaire";
    private static final String RELATIVE_PATH_REQUEST_NEW_ATTRIBUTE ="requestNewAtt";
    private static final String RELATIVE_PATH_PSE_POPUP ="psePopup";
    private static final String RELATIVE_PATH_FETCH_CANDIDATE_FROM_UPC ="fetchCandidateFromUPC";
    private static final String RELATIVE_PATH_FETCH_UPC_PRODUCT ="fetchUPCProduct";
    private static final String RELATIVE_PATH_HANDLE_EXISTING_ID ="handleExistingId";
    private static final String RELATIVE_PATH_WIC ="wic";
    private static final String RELATIVE_PATH_ADD_SUB_BRAND ="addSubBrand";
    private static final String RELATIVE_PATH_PLU_GENERATION ="pluGeneration";
    private static final String RELATIVE_PATH_PRODUCT_AND_UPC_FROM_MRT ="prodAndUpcFromMRT";
    private static final String RELATIVE_PATH_ASSORMENT ="assortment";
    private static final String RELATIVE_PATH_MATRIX_MARGIN ="matrixMargin";
    private static final String RELATIVE_PATH_RETAIL_LINK ="retailLink";
    private static final String RELATIVE_PATH_GET_APPROVED_USERNAME ="getApprovedUserName";
    private static final String RELATIVE_PATH_GET_TAX_CATE_DEFAULT ="getTaxCateDefault";
    private static final String RELATIVE_PATH_GET_ALL_SELLING_RES_FROM_CACHE ="getAllSellingResFromCache";
    private static final String RELATIVE_PATH_SET_TAX_FLAG_WHEN_CHANGE_TAX_CATE ="setTaxFlagWhenChangeTaxCate";
    private static final String RELATIVE_PATH_GET_TOTAL_PROD_BY_TAX_CATEGORY ="getTotalProdByTaxCategory";
    private static final String RELATIVE_PATH_GET_LIST_PROD_BY_TAX_CATEGORY ="getListProdByTaxCategory";
    private static final String RELATIVE_PATH_GET_TAX_CATEGORY_BASED_ON_TAX_FLAG ="getTaxCategoryBasedOnTaxFlag";
    private static final String RELATIVE_PATH_CHANGE_SELLING_RESTRICTIONS ="changeSellingRestrictions";
    private static final String RELATIVE_PATH_GET_SELLING_RESTRICTIONS ="getSellingRestrictions";
    private static final String RELATIVE_PATH_GET_LIST_DATA_DISTINCT ="getListDataDistinct";
    private static final String RELATIVE_PATH_RETAIL_NON_SELABLE ="setRetailNonSelable";
    private static final String RELATIVE_PATH_REMOVE_DISABLE_SCALE_ATT ="removedDisableScaleAtt";
    private static final String RELATIVE_PATH_SET_SACLE_IS_TRUE ="setScaleIsTrue";
    private static final String RELATIVE_PATH_SAVE_DETAILS="/saveDetails";
    private static final String RELATIVE_PATH_GET_RETAIL_FOR_MRT="/getRetailForMrt";
    private static final String RELATIVE_PATH_VENDERMRT_DETAILS="/vendorMRTDetails";
    private static final String RELATIVE_PATH_VIEW_FACTORIES_MRT="/viewFactoriesMRT";
    private static final String RELATIVE_PATH_AUTH_WHS="/authWHS";
    private static final String RELATIVE_PATH_VIEW_STORES="/viewStores";
    private static final String RELATIVE_PATH_AUTH_MRT_WHS="/authMRTWHS";
    private static final String RELATIVE_PATH_CASE_DETAILS="/caseDetails";
    private static final String RELATIVE_PATH_CONFLICT_STORE="/conflictStore";
    private static final String RELATIVE_PATH_VENDOR_DETAILS="/vendorDetails";
    private static final String RELATIVE_PATH_VIEW_MRT_STORES="/viewMRTStores";
    private static final String RELATIVE_PATH_ACTIVATE="/activate";
    private static final String RELATIVE_PATH_ACTIVE_BATCH_UPLOAD_CANDIDATE="/activeBatchUploadCandidate";
    private static final String RELATIVE_PATH_ACTIVE_MRT_CANDIDATE="/activeMRTCandidate";
    private static final String RELATIVE_PATH_ACTIVE_CANDIDATE="/activeCandidate";
    private static final String RELATIVE_PATH_REJECT_MRT_CANDIDATE="/rejectMRTCandidate";
    private static final String RELATIVE_PATH_DELETE_CAN="/deleteCand";
    private static final String RELATIVE_PATH_ACTIVATION_MESSAGE="/activationMessage";
    private static final String RELATIVE_PATH_CONFLICT_STORE_UPDATE="/conflictStoreUpdate";
    private static final String RELATIVE_PATH_PRINT_CONFLICT_STORE="/printConflictStore";
    private static final String RELATIVE_PATH_UPDATE_VIEW_STORES="/updateViewStores";
    private static final String RELATIVE_PATH_PRINT_FORM="/printForm";
    private static final String RELATIVE_PATH_CHECK_DSV_ITEM_MODIFY_FROM_VIEW="/checkDSVItemModifyFromView";
    private static final String RELATIVE_PATH_REJECT_COMMENTS="/rejectComments";
    private static final String RELATIVE_PATH_REJECT_CAND="/rejectCand";
    private static final String RELATIVE_PATH_GET_DATA_BRICK_INFOR="/getDataBrickInfor";
    private static final String RELATIVE_PATH_GET_DATA_TABLE_INFOR="/getDataTableInfor";
    private static final String RELATIVE_PATH_SAVE_COMMENTS="/saveComments";
    private static final String RELATIVE_PATH_GET_SERV_SIZE_UOM_DATA="/getServSizeUOMData";
    private static final String RELATIVE_PATH_MODIFY_CAND_FROM_EDI="/modifyCandFromEDI";
    private static final String RELATIVE_PATH_MODIFY_PRODUCT_FROM_EDI="/modifyProductFromEDI";
    private static final String RELATIVE_PATH_VIEW_CAND_FROM_EDI="/viewCandFromEDI";
    private static final String RELATIVE_PATH_VIEW_PRODUCT_FROM_EDI="/viewProductFromEDI";
    private static final String RELATIVE_PATH_VIEW_FACTORIES="/viewFactories";
    private static final String RELATIVE_PATH_VIEW_CAND = "/viewCand";
    private static final String RELATIVE_PATH_VIEW_CAND_FROM_MANAGE = "/viewCandFromManage";
    private static final String RELATIVE_PATH_MODIFY_CAND = "/modifyCand";
    private static final String RELATIVE_PATH_COPY_CAND = "/copyCand";
    private static final String RELATIVE_PATH_MODIFY_CAND_DBLCLICK = "/modifyCandDblClick";
    private static final String RELATIVE_PATH_VIEW_PRODUCT = "/viewProduct";
    private static final String RELATIVE_PATH_MODIFY_PRODUCT = "/modifyProduct";
    private static final String RELATIVE_PATH_COPY_PRODUCT = "/copyProduct";
    private static final String RELATIVE_PATH_BACK_TO_SEARCH = "/backToSearch";
    private static final String RELATIVE_PATH_UPDATE_CANDIDATE_MESSAGE = "/updateCandidateMessage";
    public static final String RELATIVE_PATH_TEST_SCAN = "/testScanNew";
    private static final String RELATIVE_PATH_REJECT_CAND_COMMENTS = "/rejectCandComments";
    private static final String RELATIVE_PATH_REJECT_QUESTIONNAIRE = "/rejectQuestionnaire";
    private static final String RELATIVE_PATH_SAVE_CASE_DETAILS = "/saveCaseDetails";
    private static final String RELATIVE_PATH_SAVE_ATTACHMENTS = "/saveAttachments";
    private static final String RELATIVE_PATH_REMOVE_AND_GET_NEXT_DETAILS = "/removeAndGetNextDetails";
    private static final String RELATIVE_PATH_VIEW_NEXT = "/viewNext";
    private static final String RELATIVE_PATH_SUBMIT = "/submit";
    private static final String RELATIVE_PATH_SUBMIT_MRT_CANDIDATE = "/submitMRTCandidate";
    private static final String RELATIVE_PATH_SUBMIT_CANDIDATE = "/submitCandidate";
    private static final String RELATIVE_PATH_PRINT_SUMMARY = "/printSummary";
    private static final String RELATIVE_PATH_RESET_MATRIX_MARGIN = "/resetMatrixMargin";
    private static final String RELATIVE_PATH_RESET_TEST_SCAN = "/resetTestScan";
    private static final String RELATIVE_PATH_RESET_PRODUCT = "/resetProduct";
    private static final String RELATIVE_PATH_FILE_UPLOAD = "/fileUpload";
    private static final String RELATIVE_PATH_DELETE_ATTACHMENT = "/deleteAttachment";

    @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)
    public AddNewCandidate getAddNewCandidate() {
        AddNewCandidate addNewCandidate = null;
        try {
            addNewCandidate = new AddNewCandidate() ;
            addNewCandidate.setUserRole(this.getUserRole());
            addNewCandidate.clearViewOverRide();
            addNewCandidate.setSelectedFunction(CPSConstants.ADD_NEWCANDIDATE);
            addNewCandidate.setTabIndex(0);
            addNewCandidate.getProductVO().setClassificationVO(new ProductClassificationVO());
            addNewCandidate.setSubCommodities(new ArrayList<BaseJSFVO>());
            addNewCandidate.setCommentsVOs(new HashMap<String, CommentsVO>());
            addNewCandidate.setMerchandizingTypes(new ArrayList<BaseJSFVO>());
            addNewCandidate.setProduct(true);
            addNewCandidate.setUpcCheck(false);
            if (null != addNewCandidate.getPendingProdIds() && !addNewCandidate.getPendingProdIds().isEmpty()) {
                addNewCandidate.getPendingProdIds().clear();
            }

            ModelAndView model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        }catch (Exception ex){}
        return addNewCandidate;
    }
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_QUESTIONNAIRE)
    public ModelAndView questionnaire(AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        this.setForm(req, addNewCandidate);

        addNewCandidate .setSession(req.getSession());
        addNewCandidate.setUserRole(this.getUserRole());
        addNewCandidate.clearQuestionaireVO();
        addNewCandidate.clearViewOverRide();
        addNewCandidate.setSelectedFunction(CPSConstants.ADD_NEWCANDIDATE);
        this.removeDataSessionFlag(req, addNewCandidate);
        addNewCandidate.setTabIndex(0);
        addNewCandidate.getProductVO().setClassificationVO(new ProductClassificationVO());
        addNewCandidate.setSubCommodities(new ArrayList<BaseJSFVO>());
        addNewCandidate.setCommentsVOs(new HashMap<String, CommentsVO>());
        addNewCandidate.setMerchandizingTypes(new ArrayList<BaseJSFVO>());
        addNewCandidate.setProduct(true);
        addNewCandidate.setUpcCheck(false);

        // upc
        if (null != addNewCandidate.getPendingProdIds() && !addNewCandidate.getPendingProdIds().isEmpty()) {
            addNewCandidate.getPendingProdIds().clear();
        }
        if (addNewCandidate.getUserRole() != null && (addNewCandidate.getUserRole().equals(CPSConstants
                .REGISTERED_VENDOR_ROLE)
                || addNewCandidate.getUserRole().equals(CPSConstants.UNREGISTERED_VENDOR_ROLE))) {
            req.getSession().removeAttribute(CPSConstants.VENDOR_LOGIN_COFIRM);
            req.getSession().setAttribute(CPSConstants.VENDOR_LOGIN_COFIRM, CPSConstant.STRING_TRUE);
        }
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null) {
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        }
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);

        ModelAndView model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Questionnaire wrapper.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_QUESTIONNAIRE_WRAPPER)
    public ModelAndView questionnaireWrapper(AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
        req.getSession().setAttribute(CPSConstants.PRESENT_BTS, CPSConstant.STRING_1);
        clearMessages(addNewCandidate);
        return questionnaire(addNewCandidate, req, resp);
    }

    private void removeDataSessionFlag(HttpServletRequest request, AddNewCandidate form) {
        Object foodstampSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION);
        Object drugPanelSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION);
        Object taxbleSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION);
        Object qntityRestrictedSession = request.getSession().getAttribute(CPSConstants
                .CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION);
        Object abusiveVolatileChemicalSession = request.getSession()
                .getAttribute(CPSConstants.CPS_POINTOFSALEVO_ABUSIVEVOLATILECHEMICAL_SESSION);
        Object weightFlagSession = request.getSession().getAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION);
        Object fsaSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION);
        Object mechtenzSession = request.getSession().getAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION);
        Object showClrsSwSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION);

        if (foodstampSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION);
        }
        if (drugPanelSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION);
        }
        if (taxbleSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION);
        }
        if (qntityRestrictedSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION);
        }
        if (abusiveVolatileChemicalSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_ABUSIVEVOLATILECHEMICAL_SESSION);
        }
        if (weightFlagSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION);
        }
        if (fsaSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION);
        }
        if (mechtenzSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION);
        }
        if(showClrsSwSession != null) {
            request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION);
        }
    }

    private void setIntentIdentifier(AddNewCandidate addNewCandidate) {
        QuestionnarieVO questionnarieVO = addNewCandidate.getQuestionnarieVO();
        ProductVO productVO = addNewCandidate.getProductVO();
        MrtVO mrtVO = addNewCandidate.getMrtvo();
        String first = questionnarieVO.getSelectedOption();
        String second = questionnarieVO.getUpcDescription();
        //Sprint - 23
        if(productVO.getWorkRequest().getIntentIdentifier()!=12) {
            if ("4".equalsIgnoreCase(first)) {
                mrtVO.getWorkRequest().setIntentIdentifier(CPSHelper.getIntegerValue(first));
            } else if (CPSHelper.isNotEmpty(first)) {
                productVO.getWorkRequest().setIntentIdentifier(CPSHelper.getIntegerValue(first));
            } else {
                productVO.getWorkRequest().setIntentIdentifier(CPSHelper.getIntegerValue(second));
            }
        }
    }

    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_NAV_TO_PROD_AND_UPC)
    public ModelAndView addNewProduct(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                      HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);

        addNewCandidate .setSession(req.getSession());
        addNewCandidate.setUserRole(this.getUserRole());
        addNewCandidate.clearQuestionaireVO();
        addNewCandidate.getQuestionnarieVO().setSelectedOption(addNewCandidate.getSelectedOption());
        addNewCandidate.getQuestionnarieVO().setSelectedValue(addNewCandidate.getSelectedValue());
        addNewCandidate.getQuestionnarieVO().setEnteredValue(addNewCandidate.getEnteredValue());
        addNewCandidate.setMessages(new ArrayList<>());

        addNewCandidate.setUpcValueFromMRT(true);
        // enable P&U, A&D tabs
        addNewCandidate.setEnableTabs(true);
        // over validate MRT Case when navigate to Additional Information tab
        addNewCandidate.setNormalProduct(true);
        addNewCandidate.setProduct(false);
        addNewCandidate.setHidMrtSwitch(false);
        addNewCandidate.setViewOnlyProductMRT(false);
        clearViewMode(addNewCandidate);
        addNewCandidate.setTabIndex(CPSConstants.TAB_PROD_UPC);
        this.removeDataSessionFlag(req, addNewCandidate);
        addNewCandidate.setAddCandidateMode();
        addNewCandidate.clearViewOverRide();
        addNewCandidate.setProductVO(new ProductVO());
        this.setIntentIdentifier(addNewCandidate);
        addNewCandidate.clearUPCVOs();
        addNewCandidate.getcommoditySubMap().clear();
        addNewCandidate.getClassCommodityMap().clear();
        addNewCandidate.getBrickMap().clear();
        addNewCandidate.clearCaseItemVOs();
        addNewCandidate.clearVendors();
        addNewCandidate.setVendorVO(new VendorVO());
        addNewCandidate.setPssList(new ArrayList<BaseJSFVO>());
        addNewCandidate.setModifyMode(true);
        this.getDetails(addNewCandidate, false, req);
        // -----New feature for Tax category---
        if (!BusinessUtil.isVendor(getUserRole())) {
            try {
                addNewCandidate.getProductVO().getPointOfSaleVO()
                        .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
            }
        }
        // reset Scale Attribute
        List<String> lst = new ArrayList<String>();
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getUpcVO())) {
            for (UPCVO upcvo : addNewCandidate.getProductVO().getUpcVO()) {
                lst.add(upcvo.getUnitUpc());
            }
        }
        String pluType = getAddNewCandidateService().checkPluTypeIsScale(lst);
        addNewCandidate.setScaleAttrib(pluType);
        addNewCandidate.setEnableActiveButton(true);
        addNewCandidate.setUpcAdded(true);
        addNewCandidate.setMrtvo(new MrtVO());
        addNewCandidate.setSelectedProductId(StringUtils.EMPTY);

        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        if(addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier()==12) {
            req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.ADDNEW_KIT);
            addNewCandidate.setCurrentAppName(CPSConstants.ADDNEW_KIT);
        } else {
            req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.ADDNEW_CANDIDATE);
            addNewCandidate.setCurrentAppName(CPSConstants.ADDNEW_CANDIDATE);
        }

        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    /**
     * Gets the details.
     *
     * @param addNewCandidate
     *            the candidate form
     * @param req
     *            the req
     * @return the details
     * @throws CPSGeneralException
     *             the CPS general exception
     * @throws Exception
     *             the exception
     */
    private void getDetails(AddNewCandidate addNewCandidate, HttpServletRequest req)
            throws CPSGeneralException, Exception {
        this.getDetails(addNewCandidate, false, req);
    }

    private void getDetails(AddNewCandidate addNewCandidate, boolean viewMode, HttpServletRequest req)
            throws CPSGeneralException, Exception {
        ProductVO productVO = null;
        if (addNewCandidate.getProductVO() != null && null != addNewCandidate.getProductVO().getPsProdId()
                && 0 != addNewCandidate.getProductVO().getPsProdId() && !addNewCandidate.getProductVO().isModifiedProd()) {
            ProductVO newProductVO = getAddNewCandidateService()
                    .fetchProduct(CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId()), getUserRole());
            // Deepu - The attached files that are not saved(inserted in db) are
            // to be retained
            // even after navigating from additional info tab to various tab
            // So the attachment is added to the newProductVO
            List<AttachmentVO> attachments = addNewCandidate.getProductVO().getAttachmentVO();
            for (AttachmentVO attachmentVO : attachments) {
                newProductVO.getAttachmentVO().add(attachmentVO);
            }
            // merger selling unit upc after user clicking on Product & UPC tab
            List<UPCVO> oldUpcVO = addNewCandidate.getProductVO().getUpcVO();
            if (CPSHelper.isNotEmpty(oldUpcVO)) {
                for (UPCVO upcvo2 : oldUpcVO) {
                    newProductVO.addUpcVO(upcvo2);
                }
            }
            // set Selling when have a OriginSellingRestriction
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getOriginSellingRestriction())) {
                newProductVO.setOriginSellingRestriction(addNewCandidate.getProductVO().getOriginSellingRestriction());
            }
            // fnSetScaleUPC(newProductVO);
            productVO = ProductVOHelper.copyProductVOtoProductVO(newProductVO);
            productVO.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
            addNewCandidate.setProductVO(productVO);
            initProductVO(addNewCandidate, req);
            if (addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_N) {
                initProductServiceVO(addNewCandidate, req);
            }
        } else if (null != addNewCandidate.getProductVO().getPsProdId()
                && 0 != addNewCandidate.getProductVO().getPsProdId()) {
            productVO = ProductVOHelper.copyProductVOtoProductVO(addNewCandidate.getSavedProductVO());
            setSellingRestriction(productVO);
            productVO.setBactchUploadMode(addNewCandidate.getSavedProductVO().isBactchUploadMode());
        } else if (addNewCandidate.getProductVO() != null) {
            productVO = ProductVOHelper.copyProductVOtoProductVO(addNewCandidate.getProductVO());
            productVO.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
        } else {
            productVO = new ProductVO();
            addNewCandidate.setPssList(new ArrayList<BaseJSFVO>());
        }
        String upc = StringUtils.EMPTY;
        String prodId =  StringUtils.EMPTY;
        String itemId =  StringUtils.EMPTY;

        if (!viewMode && needsData(addNewCandidate.getProductTypes())) {
            addNewCandidate.setProductTypes(getProductTypes());
        }
        if (!viewMode && needsData(addNewCandidate.getUpcType())) {
            addNewCandidate.setUpcType(getUpcTypeList());
        }
        //SPINT 22
        if (!viewMode) {
            addNewCandidate.setUnitsOfMeasure(getUnitOfMeasureList(productVO.getClassificationVO().getSubCommodity()));
        }

        if (!viewMode && needsData(addNewCandidate.getTobaccoProdtype())) {
            addNewCandidate.setTobaccoProdtype(getTobaccoProdTypeList());
        }

        if (!viewMode && needsData(addNewCandidate.getDrugSchedules())) {
            addNewCandidate.setDrugSchedules(getDrugSchedules());
        }

        if (!viewMode && needsData(addNewCandidate.getNutrientList())) {
            addNewCandidate.setNutrientList(getNutrientList());
        }

        if (!viewMode && needsData(addNewCandidate.getCaseVO().getTouchTypeList())) {
            addNewCandidate.getCaseVO().setTouchTypeList(getTouchTypeCodes());
        }

        if (!viewMode && needsData(addNewCandidate.getCaseVO().getItemCategoryList())) {
            addNewCandidate.getCaseVO().setItemCategoryList(getItemCategoryList());
        }
        if (!viewMode && needsData(addNewCandidate.getCaseVO().getPurchaseStatusList())) {
            addNewCandidate.getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
        }
        if (!viewMode && needsData(addNewCandidate.getVendorVO().getTop2TopList())) {
            addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
        }

        if (!viewMode && needsData(addNewCandidate.getVendorVO().getSeasonalityList())) {
            addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
        }

        if (!viewMode && needsData(addNewCandidate.getVendorVO().getCountryOfOriginList())) {
            addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
        }
        if (!viewMode && needsData(addNewCandidate.getVendorVO().getOrderRestrictionList())) {
            addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());
        }
        // Order Unit changes
        if (!viewMode && needsData(addNewCandidate.getVendorVO().getOrderUnitList())) {
            addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());
        }

        if (!viewMode && needsData(addNewCandidate.getActionCode())) {
            addNewCandidate.setActionCode(getActionCodeList());
        }

        if (!viewMode && needsData(addNewCandidate.getGraphicsCode())) {
            addNewCandidate.setGraphicsCode(getGraphicsCodeList());
        }

        if (!viewMode && needsData(addNewCandidate.getCaseVO().getReadyUnits())) {
            addNewCandidate.getCaseVO().setReadyUnits(getReadyUnitList());
        }
        if (!viewMode && needsData(addNewCandidate.getCaseVO().getOrientations())) {
            addNewCandidate.getCaseVO().setOrientations(getOrientationList());
        }
        String selectedValue = addNewCandidate.getQuestionnarieVO().getSelectedValue();
        // Fix PIM 846
        if (CPSConstant.STRING_1.equals(selectedValue)) {
            upc = addNewCandidate.getQuestionnarieVO().getEnteredValue();
            addNewCandidate.getQuestionnarieVO().setBonusUpcValue(upc);
        } else if ("2".equals(selectedValue)) {
            itemId = addNewCandidate.getQuestionnarieVO().getEnteredValue();
        } else if ("3".equals(selectedValue)) {
            prodId = addNewCandidate.getQuestionnarieVO().getEnteredValue();
        }
        if (CPSHelper.isNotEmpty(upc) || CPSHelper.isNotEmpty(itemId) || CPSHelper.isNotEmpty(prodId)) {
            productVO = getAddNewCandidateService().getProduct(upc, prodId, itemId);
            fnSetScaleUPC(productVO);
            if (CPSHelper.isNotEmpty(productVO.getProdId())) {
                JSONArray jsonData = getSellingJsonFromWS(productVO.getProdId(),getCommonService().getSellingRestriction(productVO.getClassCommodityVO().getDeptId(), productVO.getClassCommodityVO().getSubDeptId(), productVO.getClassCommodityVO().getClassCode(), productVO.getClassificationVO().getCommodity(), productVO.getClassificationVO().getSubCommodity()));
                if (!jsonData.isEmpty()) {
                    productVO.setOriginSellingRestriction(jsonData.toString());
                }
            }
            if (CPSHelper.isNotEmpty(itemId)) {
                itemId = itemId.trim();
                // Fix PIM 846
                // candidateForm.getQuestionnarieVO().setBonusUpcValue(upc);
                if (productVO != null && CPSHelper.isNotEmpty(productVO.getCaseVOs())) {
                    for (CaseVO caseVO : productVO.getCaseVOs()) {
                        if (caseVO != null && itemId.equals(String.valueOf(caseVO.getItemId()))) {
                            addNewCandidate.getQuestionnarieVO()
                                    .setBonusUpcValue(removeDotDecimal(caseVO.getOrderingUPC()));

                            break;
                        }
                    }
                }
            } else if (CPSHelper.isNotEmpty(prodId)) {
                addNewCandidate.getQuestionnarieVO().setBonusUpcValue(String.valueOf(productVO.getPrimaryUPC()));
            }
            this.correctUOM(productVO);

            // correct the list cost for Vendors
            if (BusinessUtil.isVendor(getUserRole())) {
                correctListCostForVendor(productVO, addNewCandidate);
                // PIM 831
                // getCorrectInforVendorLogin(productVO, req);
                // end PIM 831
            }
            // merge from old cps
            setSellingRestriction(addNewCandidate.getProductVO());
        }
        addNewCandidate.getQuestionnarieVO().setEnteredValue(StringUtils.EMPTY);

        // getting commodity
        try {
            Map<String, ClassCommodityVO> map = getCommonService()
                    .getCommoditiesForBDM(addNewCandidate.getProductVO().getClassificationVO().getAlternateBdm());
            addNewCandidate.setClassCommodityMap(map);
        addNewCandidate.getProductVO().getClassificationVO().setCommodityName(
                getNameForCode(addNewCandidate.getCommodities(), addNewCandidate.getProductVO().getClassificationVO().getCommodity()));

        Map<String, CommoditySubCommVO> subComm = getCommonService().getSubCommoditiesForClassCommodity(
                addNewCandidate.getProductVO().getClassificationVO().getClassField(), addNewCandidate.getProductVO().getClassificationVO().getCommodity());
        addNewCandidate.setcommoditySubMap(subComm);
        }catch (Exception e){
            LOG.error("Error occur when call ws Commodities & SubCommodities:" + e.getMessage(), e);
        }
        // setPurchaseTimeName(productVO);
        initBrandField(addNewCandidate);
        addNewCandidate.setProductVO(productVO);
        setDefaultValuePointOfSale(addNewCandidate);
        // setRestrictedSalesAgeLimit(candidateForm);
        this.setUOMDesc(productVO, addNewCandidate);
        // merge from old cps
        // setSellingRestriction(candidateForm.getProductVO());
        // setRateAndRatingType(candidateForm);
        fnSetScaleUPC(addNewCandidate.getProductVO());

        List<BaseJSFVO> pssDeptList = new ArrayList<BaseJSFVO>();
        if (addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity()) != null) {
            String deptNbr = addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO()
                    .getCommodity()).getDeptId();
            String subDeptNbdr = addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                    .getSubDeptId();
            if (CPSHelper.isNotEmpty(deptNbr) && CPSHelper.isNotEmpty(subDeptNbdr)) {
                pssDeptList = getCommonService().getDeptNumbersForDeptSubDept(deptNbr, subDeptNbdr);
            }
            // Fix 1034
            pssDeptList = setDefault(pssDeptList,
                    addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity()).getPssDept());
        }
        addNewCandidate.setPssList(pssDeptList);

        // -----New feature for Tax category---
        if (!BusinessUtil.isVendor(getUserRole())) {
            try {
                addNewCandidate.getProductVO().getPointOfSaleVO()
                        .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
                    for (TaxCategoryVO tax : addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory()) {
                        if (CPSHelper.checkEqualValue(addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode(),
                                tax.getTxBltyDvrCode())) {
                            addNewCandidate.getProductVO().getPointOfSaleVO().setTaxCateName(tax.getTxBltyDvrName());
                            break;
                        }
                    }
                }
            } catch (Exception e) {
                LOG.error("Error occur when call ws TaxCategory:" + e.getMessage(), e);
            }
        }
    }

    private void initProductVO(AddNewCandidate addNewCandidate, HttpServletRequest req) throws Exception {
        cacheBDM(addNewCandidate, req);
        ProductVO productVO = addNewCandidate.getProductVO();
        Map<String, ClassCommodityVO> map = getCommonService()
                .getCommoditiesForBDM(productVO.getClassificationVO().getAlternateBdm());
        addNewCandidate.setClassCommodityMap(map);
        this.initElligible(addNewCandidate, req);
        cacheCommodity(addNewCandidate, req);

        initClassField(addNewCandidate);
        initBrandField(addNewCandidate);
        initMerchandisingTypes(addNewCandidate);
        initScaleAttribute(addNewCandidate);
        Map<String, CommoditySubCommVO> subComm = getCommonService().getSubCommoditiesForClassCommodity(
                productVO.getClassificationVO().getClassField(), productVO.getClassificationVO().getCommodity());
        addNewCandidate.setcommoditySubMap(subComm);
        cacheSubCommodity(addNewCandidate, req);
        String deptNbr = StringUtils.EMPTY;
        String subDeptNbdr = StringUtils.EMPTY;
        List<BaseJSFVO> pssDeptList = new ArrayList<BaseJSFVO>();
        if (addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()) != null) {
            deptNbr = addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()).getDeptId();
            subDeptNbdr = addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity())
                    .getSubDeptId();
            if (CPSHelper.isNotEmpty(deptNbr) && CPSHelper.isNotEmpty(subDeptNbdr)) {
                try{
                    pssDeptList = getCommonService().getDeptNumbersForDeptSubDept(deptNbr, subDeptNbdr);
                }catch (CPSSystemException ex){
                    saveMessage(addNewCandidate, ex.getCPSMessage());
                }
            }
            // Fix 1034
            pssDeptList = setDefault(pssDeptList,
                    addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()).getPssDept());
        }
        //this.initBrickMap(addNewCandidate);
        //this.initBrick(addNewCandidate);
        addNewCandidate.setPssList(pssDeptList);

        this.setBrandCache(addNewCandidate, req);
        initScaleVO(addNewCandidate, addNewCandidate.getProductVO());
        initCostOwner(addNewCandidate);
        if (CPSHelper.isEmpty(productVO.getRetailVO().getCriticalItemName())) {
            productVO.getRetailVO().setCriticalItemName(
                    getNameForCode(addNewCandidate.getCriItemList(), productVO.getRetailVO().getCriticalItem()));
        }
        if (CPSHelper.isEmpty(productVO.getRetailVO().getTobaccoTaxName())) {
            productVO.getRetailVO().setTobaccoTaxName(
                    getNameForCode(addNewCandidate.getYesNoList(), productVO.getRetailVO().getTobaccoTax()));
        }
        // Set the UPC Type List
        addNewCandidate.setUpcType(getUpcTypeList());
        // //////
        setSubBrand(addNewCandidate);
        setDefaultValuePointOfSale(addNewCandidate);
    }

    private void initProductServiceVO(AddNewCandidate addNewCandidate, HttpServletRequest req)
            throws CPSGeneralException, CPSWebException {
        ProductVO productVO = addNewCandidate.getProductVO();
        productVO.getClassificationVO()
                .setBdmName(getNameForCode(getBdmList(), productVO.getClassificationVO().getAlternateBdm()));
        // getting commodity
        Map<String, ClassCommodityVO> map = getCommonService()
                .getCommoditiesForBDM(productVO.getClassificationVO().getAlternateBdm());
        addNewCandidate.setClassCommodityMap(map);
        productVO.getClassificationVO().setCommodityName(
                getNameForCode(addNewCandidate.getCommodities(), productVO.getClassificationVO().getCommodity()));
        initClassField(addNewCandidate);
        this.setBrandCache(addNewCandidate, req);
        initBrandField(addNewCandidate);
        initMerchandisingTypes(addNewCandidate);
        initScaleAttribute(addNewCandidate);
        if (CPSHelper.isEmpty(productVO.getClassificationVO().getMerchandizeName())) {
            productVO.getClassificationVO().setMerchandizeName(getNameForCode(addNewCandidate.getMerchandizingTypes(),
                    productVO.getClassificationVO().getMerchandizeType()));
        }
        Map<String, CommoditySubCommVO> subComm = getCommonService().getSubCommoditiesForClassCommodity(
                productVO.getClassificationVO().getClassField(), productVO.getClassificationVO().getCommodity());
        addNewCandidate.setcommoditySubMap(subComm);
        productVO.getClassificationVO().setSubCommodityName(
                getNameForCode(addNewCandidate.getSubCommodities(), productVO.getClassificationVO().getSubCommodity()));

        this.initBrickMap(addNewCandidate);
        this.initElligible(addNewCandidate, req);

        String deptNbr = StringUtils.EMPTY;
        String subDeptNbdr = StringUtils.EMPTY;
        List<BaseJSFVO> pssDeptList = new ArrayList<BaseJSFVO>();
        if (addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()) != null) {
            deptNbr = addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()).getDeptId();
            subDeptNbdr = addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity())
                    .getSubDeptId();
            if (CPSHelper.isNotEmpty(deptNbr) && CPSHelper.isNotEmpty(subDeptNbdr)) {
                pssDeptList = getCommonService().getDeptNumbersForDeptSubDept(deptNbr, subDeptNbdr);
            }
            pssDeptList = setDefault(pssDeptList,
                    addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()).getPssDept());
        }
        // Fix 1034
        addNewCandidate.setPssList(pssDeptList);
        if (CPSHelper.isEmpty(productVO.getRetailVO().getCriticalItemName())) {
            productVO.getRetailVO().setCriticalItemName(
                    getNameForCode(addNewCandidate.getCriItemList(), productVO.getRetailVO().getCriticalItem()));
        }
        if (CPSHelper.isEmpty(productVO.getRetailVO().getTobaccoTaxName())) {
            productVO.getRetailVO().setTobaccoTaxName(
                    getNameForCode(addNewCandidate.getYesNoList(), productVO.getRetailVO().getTobaccoTax()));
        }
        setSubBrand(addNewCandidate);
        // FIX PIM 354
        setDefaultValuePointOfSale(addNewCandidate);
    }

    private void setSellingRestriction(ProductVO savedProductVo) {
        try {
            JSONArray jsonData = new JSONArray();
            List<RatingVO> savedRatings = new ArrayList<RatingVO>();
            List<String> lstSellingFromWS = new ArrayList<String>();
            String offPre = null;
            if (savedProductVo.getPsProdId() != null) {
                savedRatings = getAddNewCandidateService().getSellingAndRating(savedProductVo.getPsProdId());
                offPre = getAddNewCandidateService().getOffPreConsumpByPsProdId(savedProductVo.getPsProdId(),false);
            }
            if (CPSHelper.isNotEmpty(savedProductVo.getClassificationVO().getSubCommodity())) {
                lstSellingFromWS = getSellingFromWS(savedProductVo.getClassificationVO().getSubCommodity());
            }
            if (CPSHelper.isNotEmpty(savedRatings)) {
                Map<String,BaseJSFVO> mapRateType = getCommonService().getMapAllSalsFromCache();
                jsonData = JsonOrgConverter.buildJsonTbleSellRes(savedRatings,lstSellingFromWS,mapRateType,false,offPre,lstSellingFromWS);
            }
            if (!jsonData.isEmpty()) {
                savedProductVo.setOriginSellingRestriction(jsonData.toString());
            }
        } catch (Exception exp) {
            LOG.error(exp.getMessage(), exp);
        }
    }

    private boolean needsData(Collection c) {
        return c == null || c.isEmpty();
    }

    /**
     * Gets the product types.
     *
     * @return the product types
     */
    public List<BaseJSFVO> getProductTypes() {
        return getAppContextFunctions().getProductTypes();
    }

    /**
     * Gets the upc type list.
     *
     * @return the upc type list
     */
    public List<BaseJSFVO> getUpcTypeList() {
        return getAppContextFunctions().getUpcTypeList();
    }

    /**
     * Gets the unit of measure list.
     *
     * @return the unit of measure list
     */
    public List<BaseJSFVO> getUnitOfMeasureList(String subCommodity) {
		/*
		 * Sort Unit Of Measure alphabetically - Fixed QC 1208
		 *
		 * @author khoapkl
		 */
        List<BaseJSFVO> lstUOM = getAppContextFunctions().getUnitOfMeasureList();
        CPSHelper.sortList(lstUOM);
        //SPRINT 22
        if(lstUOM==null){
            lstUOM = new ArrayList<>();
        }
        lstUOM.add(0, new BaseJSFVO("NONE","--Select--"));
        return getUOMFromSubCommodity(lstUOM, subCommodity);
    }

    /**
     * Gets the tobacco prod type list.
     *
     * @return the tobacco prod type list
     */
    public List<BaseJSFVO> getTobaccoProdTypeList() {
        return getAppContextFunctions().getTobaccoProdTypeList();
    }

    /**
     * Gets the action code list.
     *
     * @return the action code list
     */
    public List<BaseJSFVO> getActionCodeList() {
        return getAppContextFunctions().getActionCodeList();
    }

    /**
     * Gets the graphics code list.
     *
     * @return the graphics code list
     */
    public List<BaseJSFVO> getGraphicsCodeList() {
        return getAppContextFunctions().getGraphicsCodeList();
    }

    /**
     * Gets the restricted sales age limit list.
     *
     * @return the restricted sales age limit list
     */
    public List<BaseJSFVO> getRestrictedSalesAgeLimitList() {
        return getAppContextFunctions().getRestrictedSalesAgeLimitList();
    }

    /**
     * Gets the drug schedules.
     *
     * @return the drug schedules
     */
    public List<BaseJSFVO> getDrugSchedules() {
        return getAppContextFunctions().getDrugSchedules();
    }

    /**
     * Gets the touch type codes.
     *
     * @return the touch type codes
     */
    public List<BaseJSFVO> getTouchTypeCodes() {
        return getAppContextFunctions().getTouchTypeCodes();
    }

    /**
     * Gets the item category list.
     *
     * @return the item category list
     */
    private List<BaseJSFVO> getItemCategoryList() {
        return getAppContextFunctions().getItemCategory();
    }

    /**
     * Gets the channels.
     *
     * @return the channels
     */
    public List<BaseJSFVO> getChannels() {
        return getAppContextFunctions().getChannels();
    }

    /**
     * Gets the country of origin.
     *
     * @return the country of origin
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    public List<BaseJSFVO> getCountryOfOrigin() throws CPSGeneralException {
        return getAppContextFunctions().getCountryOfOrigin();
    }

    /**
     * Gets the seasonality.
     *
     * @return the seasonality
     */
    public List<BaseJSFVO> getSeasonality() {
        return getAppContextFunctions().getSeasonality();
    }

    /**
     * Gets the seasonality yr.
     *
     * @return the seasonality yr
     */
    public List<BaseJSFVO> getSeasonalityYr() {
        return getAppContextFunctions().getSeasonalityYr();
    }

    /**
     * Gets the top2 top.
     *
     * @return the top2 top
     */
    public List<BaseJSFVO> getTop2Top() {
        return getAppContextFunctions().getTop2Top();
    }

    /**
     * Gets the nutrient list.
     *
     * @return the nutrient list
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    public List<BaseJSFVO> getNutrientList() throws CPSGeneralException {
        return getAppContextFunctions().getNutrientList();
    }

    /**
     * Gets the order restriction.
     *
     * @return the order restriction
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private List<BaseJSFVO> getOrderRestriction() throws CPSGeneralException {
        return getAppContextFunctions().getOrderRestriction();
    }

    /**
     * Gets the purchase status list.
     *
     * @return the purchase status list
     */
    private List<BaseJSFVO> getPurchaseStatusList() {
        return getAppContextFunctions().getPurchaseStatus();
    }

    /**
     * Gets the label format list.
     *
     * @return the label format list
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    public List<BaseJSFVO> getLabelFormatList() throws CPSGeneralException {
        return getAppContextFunctions().getLabelFormatList();
    }

    /**
     * Gets the order unit list.
     *
     * @return the order unit list
     */
    private List<BaseJSFVO> getOrderUnitList() {
        return getAppContextFunctions().getOrderUnitList();
    }

    /**
     * Gets the ready unit list.
     *
     * @return the ready unit list
     */
    private List<BaseJSFVO> getReadyUnitList() {
        return getAppContextFunctions().getReadyUnitList();
    }

    /**
     * Gets the orientation list.
     *
     * @return the orientation list
     */
    private List<BaseJSFVO> getOrientationList() {
        return getAppContextFunctions().getOrientationList();
    }

    /**
     * Fn set scale upc.
     *
     * @param productVO
     *            the product vo
     */
    private void fnSetScaleUPC(ProductVO productVO) {
        List<String> lst = new ArrayList<String>();
        if (CPSHelper.isNotEmpty(productVO.getUpcVO())) {
            for (UPCVO upcvo : productVO.getUpcVO()) {
                lst.add(upcvo.getUnitUpc());
            }
        }
        if (CPSHelper.isNotEmpty(lst)) {
            for (String upcSimple : lst) {
                if (upcSimple.endsWith("00000") && upcSimple.startsWith("002")) {
                    productVO.setScaleUPC(true);
                    break;
                }
            }
        }

    }

    /**
     * Sets the view override flags.
     *
     * @param addNewCandidate
     *            the new view override flags
     */
    private void setViewOverrideFlags(AddNewCandidate addNewCandidate) {
        addNewCandidate.setUpcViewOverRide();
        addNewCandidate.setCaseViewOverRide();
    }

    private JSONArray getSellingJsonFromWS(String stringVal,List<String> sellingResWs) throws CPSGeneralException {
        List<RatingVO> lstRatingVOs = null;
        lstRatingVOs = getLstRatingFromWS(stringVal);
        String offPre = getAddNewCandidateService().getOffPreConsumpByPsProdId(CPSHelper.getIntegerValue(stringVal),true);
        JSONArray jsonData = new JSONArray();
        if (lstRatingVOs.size() > 0) {
            try {
                jsonData = createJsonSelResFromRatingVO(lstRatingVOs,offPre,sellingResWs);
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
            }
        }
        return jsonData;
    }

    /**
     * Gets the lst rating from ws.
     *
     * @author hungbang
     * @param stringVal
     *            the string val
     * @return List RatingVO
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private List<RatingVO> getLstRatingFromWS(String stringVal) throws CPSGeneralException {
        List<RatingVO> ratingVOs = new ArrayList<RatingVO>();
        try {
            ratingVOs = getAddNewCandidateService().getRatingFromWS(stringVal);
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
            e.printStackTrace();
        }
        return ratingVOs;
    }

    /**
     * Creates the json sel res from rating vo.
     *
     * @param lstRatingVO
     *            the lst rating vo
     * @return the JSON array
     * @throws Exception
     *             the exception
     */
    @SuppressWarnings("unchecked")
    private JSONArray createJsonSelResFromRatingVO(List<RatingVO> lstRatingVO,String offPre,List<String> sellingResWs) throws Exception {
        JSONArray jsonArray = new JSONArray();
        List<String> lstRatingCd = new ArrayList<String>();
        for (int i = 0; i < lstRatingVO.size(); i++) {
            Map<String,RatingVO> lstRating = getCommonService().getMapAllRatingBySellResFromCache(lstRatingVO.get(i).getSalsRstrGrpCd().trim());
            if(!lstRating.isEmpty() && lstRating.containsKey(lstRatingVO.get(i).getSalsRstrCd().trim())){
                lstRatingVO.get(i).setRstredQty(lstRating.get(lstRatingVO.get(i).getSalsRstrCd().trim()).getRstredQty());
            }
            lstRatingCd.add(lstRatingVO.get(i).getSalsRstrGrpCd().trim());
        }
        if (CPSHelper.isNotEmpty(lstRatingVO)) {
            Map<String,BaseJSFVO> mapRateType = getCommonService().getMapAllSalsFromCache();
            jsonArray = JsonOrgConverter.buildJsonTbleSellRes(lstRatingVO,lstRatingCd,mapRateType,true,offPre, sellingResWs);
        }
        return jsonArray;
    }

    /**
     * Removes the dot decimal.
     *
     * @param value
     *            the value
     * @return the string
     */
    private String removeDotDecimal(String value) {
        String ret = StringUtils.EMPTY;
        if (null != value) {
            final int index = value.indexOf('.');
            if (index != -1) {
                ret = value.substring(0, index);
            }
        }
        return ret;
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

    /**
     * Correct list cost for vendor.
     *
     * @param productVO
     *            the product vo
     * @param addNewCandidate
     *            the candidate form
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private void correctListCostForVendor(ProductVO productVO, AddNewCandidate addNewCandidate)
            throws CPSGeneralException {
        if (productVO == null || CPSHelper.isEmpty(productVO.getCaseVOs())) {
            return;
        }
        if (null != productVO.getClassificationVO()) {
            if (null != productVO.getClassificationVO().getCommodity()) {
                if (CPSHelper
                        .isEmpty(addNewCandidate.getClassCommodityVO(productVO.getClassificationVO().getCommodity()))) {
                    Map<String, ClassCommodityVO> map = getCommonService()
                            .getCommoditiesForBDM(productVO.getClassificationVO().getAlternateBdm());
                    addNewCandidate.setClassCommodityMap(map);
                }
            }
        }
        for (CaseVO caseVO : productVO.getCaseVOs()) {
            String chnlVal = caseVO.getChannelVal();
            // 958 enhancement. Commenting the below line and getting the entire
            // vendorList irrespective of dept, suptDept
            // List<VendorLocationVO> vendorList = getVendorList(chnlVal,
            // deptNbr, subDept, classField, candidateForm);
            List<VendorLocationVO> vendorList = addNewCandidate.getVendorList(chnlVal);

            List<Integer> vendorIds = new ArrayList<Integer>();
            if (CPSHelper.isNotEmpty(vendorList)) {
                for (VendorLocationVO vendorLoc : vendorList) {
                    if (vendorLoc.getVendorId() != null) {
                        try {
                            vendorIds.add(Integer.valueOf(vendorLoc.getVendorId()));
                        } catch (NumberFormatException e) {

                        }
                    }
                }
            }
            String vendorId = StringUtils.EMPTY;
            Integer vendorIdCheck = null;
            for (VendorVO vendorVO : caseVO.getVendorVOs()) {
                vendorVO.setVendorLogin(true);
                if (CPSHelper.isNotEmpty(vendorIds)) {
                    vendorId = String.valueOf(vendorVO.getVendorLocNumber());
                    vendorIdCheck = null;
                    if (CPSHelper.isNotEmpty(vendorId)) {
                        if (CPSConstants.CHANNEL_WHS.equalsIgnoreCase(chnlVal)) {
                            if (vendorId.length() > 6) {
                                vendorId = vendorId.substring(2, vendorId.length());
                            }
                        } else if (!CPSConstants.CHANNEL_DSD.equalsIgnoreCase(chnlVal)) {
                            if (vendorId.length() > 6) {
                                vendorId = vendorId.substring(2, vendorId.length());
                            }
                        }
                        try {
                            vendorIdCheck = Integer.valueOf(vendorId);
                        } catch (NumberFormatException e) {

                        }
                    }
                    if (CPSHelper.isNotEmpty(vendorIdCheck) && !vendorIds.contains(vendorIdCheck)) {
                        vendorVO.setListCostVendor(CPSConstant.STRING_0);
                    }
                } else {
                    vendorVO.setListCostVendor(CPSConstant.STRING_0);
                }
            }
        }
    }

    /**
     * Inits the brand field.
     *
     * @param addNewCandidate
     *            the add candidate form
     */
    private void initBrandField(AddNewCandidate addNewCandidate) {
        ProductClassificationVO classificationVO = addNewCandidate.getProductVO().getClassificationVO();
        String brand = classificationVO.getBrand();
        String brandName = classificationVO.getBrandName();
        if (CPSHelper.isNotEmpty(brandName) && CPSHelper.isNotEmpty(brand)) {
            if (!brandName.contains(brand)) {
                classificationVO.setBrandName(brandName + "[" + brand + "]");
            }
        }
    }

    /**
     * Inits the cost owner.
     *
     * @param addNewCandidate
     *            the add candidate form
     */
    private void initCostOwner(AddNewCandidate addNewCandidate) {
        if (!CPSHelper.isEmpty(addNewCandidate.getProductVO().getClassificationVO().getBrand())) {
            Integer brand = CPSHelper.getIntegerValue(addNewCandidate.getProductVO().getClassificationVO().getBrand());
            try {
                addNewCandidate.setCostOwners(getAddNewCandidateService().getCostOwnerbyBrand(brand));
            } catch (CPSGeneralException e) {
            }
        }
    }

    /**
     * Sets the default value point of sale.
     *
     * @param addNewCandidate
     *            the new default value point of sale
     */
    public void setDefaultValuePointOfSale(AddNewCandidate addNewCandidate) {
        if (addNewCandidate.getProductVO() != null && addNewCandidate.getProductVO().getClassificationVO() != null) {
            CommoditySubCommVO codes = addNewCandidate.getcommoditySubMap()
                    .get(addNewCandidate.getProductVO().getClassificationVO().getSubCommodity());
            if (codes != null) {
                if (CPSHelper.isNotEmpty(codes.getFdStampCd()) && (CPSConstant.STRING_Y).equals(codes.getFdStampCd())) {
                    addNewCandidate.getProductVO().getPointOfSaleVO().setFoodStampDefault(true);
                } else {
                    addNewCandidate.getProductVO().getPointOfSaleVO().setFoodStampDefault(false);
                }
                if (CPSHelper.isNotEmpty(codes.getCrgTaxCd()) && (CPSConstant.STRING_Y).equals(codes.getCrgTaxCd())) {
                    addNewCandidate.getProductVO().getPointOfSaleVO().setTaxableDefault(true);
                } else {
                    addNewCandidate.getProductVO().getPointOfSaleVO().setTaxableDefault(false);
                }
            }
        }
    }

    /**
     * Sets the uom desc.
     *
     * @param productVO
     *            the product vo
     * @param addNewCandidate
     *            the candidate form
     */
    private void setUOMDesc(ProductVO productVO, AddNewCandidate addNewCandidate) {
        if (productVO != null && CPSHelper.isNotEmpty(productVO.getUpcVO())) {
            Iterator<UPCVO> iterator = productVO.getUpcVO().iterator();
            while (iterator.hasNext()) {
                UPCVO upcvo = iterator.next();
                if (upcvo.getUnitMeasureDesc() == null || upcvo.getUnitMeasureDesc().trim().length() == 0) {
                    if (upcvo.getUnitMeasureCode() != null && upcvo.getUnitMeasureCode().trim().length() > 0) {

                        String uomCode = upcvo.getUnitMeasureCode();

                        Iterator<BaseJSFVO> uomListIterator = null;
                        if (addNewCandidate.getUnitsOfMeasure() == null) {
                            uomListIterator = getUnitOfMeasureList(productVO.getClassificationVO().getSubCommodity()).iterator();
                        } else {
                            uomListIterator = addNewCandidate.getUnitsOfMeasure().iterator();
                        }
                        while (uomListIterator.hasNext()) {
                            BaseJSFVO baseJSFVO = uomListIterator.next();
                            if (baseJSFVO.getId() != null && baseJSFVO.getId().equalsIgnoreCase(uomCode)) {
                                upcvo.setUnitMeasureDesc(baseJSFVO.getName());
                                break;
                            }
                        }
                    } else {
                        // UOM when empty should display NOUNPR
                        upcvo.setUnitMeasureCode(CPSConstant.SPACE_STRING);
                        upcvo.setUnitMeasureDesc("NOUNPR");
                    }
                }
            }
            setUOMDescInCaseUPCVO(addNewCandidate);
        }
    }
    /**
     * Sets the UOM desc in case upcvo.
     *
     * @param addNewCandidate
     *            the new UOM desc in case upcvo
     */
    private void setUOMDescInCaseUPCVO(AddNewCandidate addNewCandidate) {

        if (CPSHelper.isEmpty(addNewCandidate.getCaseVO().getCaseUPCVOs())) {
            initApplicableUPCs(addNewCandidate);
        } else {
            ProductVO productVO = addNewCandidate.getProductVO();
            List<UPCVO> list = productVO.getUpcVO();
            List<CaseUPCVO> caseList = null;
            for (UPCVO upcvo : list) {
                caseList = addNewCandidate.getCaseVO().getCaseUPCVOs();
                for (CaseUPCVO caseUpcvo : caseList) {
                    if (CPSHelper.checkEqualValue(caseUpcvo.getUnitUpc(), upcvo.getUnitUpc())) {
                        caseUpcvo.setUnitMeasureDesc(upcvo.getUnitMeasureDesc());
                        break;
                    }
                }

            }
        }
    }

    /**
     * Inits the applicable up cs.
     *
     * @param addNewCandidate
     *            the candidate form
     */
    private void initApplicableUPCs(AddNewCandidate addNewCandidate) {

        ProductVO productVO = addNewCandidate.getProductVO();
        // CaseVO caseVO = candidateForm.getCaseVO();
        List<UPCVO> list = productVO.getUpcVO();
        // khoapkl
        // candidateForm.getCaseVO().clearCaseUPCVOs();
        for (UPCVO upcvo : list) {
            CaseUPCVO caseUPCVO = new CaseUPCVO();
            caseUPCVO.setCheckDigit(upcvo.getUnitUpc10());
            // Handle primary upc
            /**
             * Fix defect # 544
             */

            if (isPrimaryAndLinked(productVO.getPrimaryUPC(), upcvo.getUnitUpc())) {
                caseUPCVO.setPrimary(true);
                caseUPCVO.setLinked(true);
            } else {
                caseUPCVO.setPrimary(false);
                caseUPCVO.setLinked(false);
            }
            caseUPCVO.setSize(upcvo.getSize());
            if (CPSHelper.isNotEmpty(upcvo.getUnitMeasureCode())) {
                caseUPCVO.setUnitMeasureCode(CPSHelper.translateUOMCode(upcvo.getUnitMeasureCode()));
                caseUPCVO.setUnitMeasureDesc(upcvo.getUnitMeasureDesc());
            } else {
                caseUPCVO.setUnitMeasureCode(" ");
                caseUPCVO.setUnitMeasureDesc("NOUNPR");
            }

            caseUPCVO.setNewDataSw(upcvo.getNewDataSw());

            if (CPSHelper.isNotEmpty(upcvo.getUnitSize())) {
                caseUPCVO.setUnitSize(upcvo.getUnitSize());
            }
            caseUPCVO.setUnitUpc(CPSHelper.getPadding(upcvo.getUnitUpc()));
            if (CPSHelper.isNotEmpty(upcvo.getUpcType())) {
                caseUPCVO.setUpcType(upcvo.getUpcType());
            }
            caseUPCVO.setWorkRequest(upcvo.getWorkRequest());
            addNewCandidate.getCaseVO().addCaseUPCVO(caseUPCVO);
        }
    }

    /**
     * Checks if is primary and linked.
     *
     * @param primaryUPC
     *            the primary upc
     * @param unitUPC
     *            the unit upc
     * @return true, if is primary and linked
     */
    private boolean isPrimaryAndLinked(Number primaryUPC, String unitUPC) {
        boolean result = false;
        if (!CPSHelper.isEmpty(primaryUPC) && !CPSHelper.isEmpty(unitUPC)) {
            String sPrimaryUPC = primaryUPC.toString();
            int dot = sPrimaryUPC.lastIndexOf('.');
            String strPrimaryUPC = StringUtils.EMPTY;
            if (dot >= 0) {
                strPrimaryUPC = sPrimaryUPC.substring(0, dot);
            } else {
                strPrimaryUPC = sPrimaryUPC;
            }
            String strUnitUPC = unitUPC;
            if (!CPSHelper.isEmpty(strPrimaryUPC) && !CPSHelper.isEmpty(strUnitUPC)) {
                if (strUnitUPC.length() != strPrimaryUPC.length()) {
                    strUnitUPC = trimLeadingZeros(strUnitUPC);
                }
                result = strPrimaryUPC.equals(strUnitUPC);
            }
        }
        return result;
    }

    /**
     * Cache sub commodity.
     *
     * @param addNewCandidate
     *            the add candidate form
     */
    private void cacheSubCommodity(AddNewCandidate addNewCandidate, HttpServletRequest req) {
        cacheAutoCompleterResults(req, addNewCandidate.getSubCommodities(),
                CPSConstants.ADD_CAND_SUB_COMMODITY_TYPEAHEAD_ID);
    }

    /**
     * Cache commodity.
     *
     * @param addNewCandidate
     *            the add candidate form
     */
    private void cacheCommodity(AddNewCandidate addNewCandidate, HttpServletRequest req) {
        try {
            cacheAutoCompleterResults(req, addNewCandidate.getCommodities(),
                    CPSConstants.ADD_CAND_COMMODITY_TYPEAHEAD_ID);
        }catch (Exception ex){LOG.error(CPSConstants.ERROR_FETCHING_PROD, ex);}
    }

    /**
     * Cache bdm.
     *
     * @param addNewCandidate
     *            the add candidate form
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private void cacheBDM(AddNewCandidate addNewCandidate, HttpServletRequest req) throws CPSGeneralException {
        cacheAutoCompleterResults(req, getCommonService().getBDMsAsBaseJSFVOs(),
                CPSConstants.ADD_CAND_BDM_TYPEAHEAD_ID);
    }

    /**
     * Inits the merchandising types.
     *
     * @param addNewCandidate
     *            the form
     * @throws CPSWebException
     *             the CPS web exception
     */
    private void initMerchandisingTypes(AddNewCandidate addNewCandidate) throws CPSWebException {
        String productType = addNewCandidate.getProductVO().getClassificationVO().getProductType();

        addNewCandidate.setMerchandizingTypes(getAppContextFunctions().getProdTypeChildren(productType));
    }

    /**
     * Trim leading zeros.
     *
     * @param strUnitUPC
     *            the str unit upc
     * @return the string
     */
    private String trimLeadingZeros(String strUnitUPC) {
        char[] chrUnitUPC = strUnitUPC.toCharArray();
        int index = 0;
        for (; index < chrUnitUPC.length; index++) {
            if (chrUnitUPC[index] != '0') {
                break;
            }
        }
        return strUnitUPC.substring(index);
    }

    /**
     * Inits the have ful fill.
     *
     * @param addNewCandidate
     *            the add candidate form
     * @param req
     *            the req
     */
    private void initElligible(AddNewCandidate addNewCandidate, HttpServletRequest req) {
        boolean check = false;
        Integer psWorkId = null;
        Integer psProdId = null;
        if (addNewCandidate.getProductVO() != null && addNewCandidate.getProductVO().getWorkRequest() != null) {
            psWorkId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
            psProdId = addNewCandidate.getProductVO().getPsProdId();
        }
        check = this.getCommonService().checkElligible(null,
                addNewCandidate.getProductVO().getClassificationVO().getCommodity(), psWorkId, psProdId);
        addNewCandidate.getProductVO().getClassificationVO().setEligible(check);
        if (addNewCandidate.getSavedProductVO() != null
                && addNewCandidate.getSavedProductVO().getClassificationVO() != null) {
            addNewCandidate.getSavedProductVO().getClassificationVO().setEligible(check);
        }
    }

    /**
     * Inits the class field.
     *
     * @param addNewCandidate
     *            the add candidate form
     */
    private void initClassField(AddNewCandidate addNewCandidate) {
        String commCode = addNewCandidate.getProductVO().getClassificationVO().getCommodity();
        BaseJSFVO classVO = (BaseJSFVO) addNewCandidate.getClassForCommodity(commCode);
        addNewCandidate.getProductVO().getClassificationVO().setClassField(CPSHelper.getTrimmedValue(classVO.getId()));
        addNewCandidate.getProductVO().getClassificationVO().setClassDesc(
                CPSHelper.getTrimmedValue(classVO.getName()) + " [" + CPSHelper.getTrimmedValue(classVO.getId()) + "]");
    }


    /**
     * Inits the scale attribute.
     *
     * @param addNewCandidate
     *            the add candidate form
     */
    private void initScaleAttribute(AddNewCandidate addNewCandidate) {
        // For Sprint17 remove old code get scale from commodity
        // ClassCommodityVO commodityVO =
        // addCandidateForm.getClassCommodityMap().get(addCandidateForm.getProductVO().getClassificationVO().getCommodity());
        String pluType = StringUtils.EMPTY;
        List<String> lst = new ArrayList<String>();
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getUpcVO())) {
            for (UPCVO upcvo : addNewCandidate.getProductVO().getUpcVO()) {
                lst.add(upcvo.getUnitUpc());
            }
        }
        if (isScaleUpcActivate(addNewCandidate.getProductVO().getUpcVO())) {
            // pluType = getAddNewCandidateService().checkPluTypeIsScale(lst);
            pluType = "I";
        }

        // if (!CPSHelper.isEmpty(commodityVO)) {
        addNewCandidate.setScaleAttrib(pluType);
        if ("I".equalsIgnoreCase(pluType)) {
            addNewCandidate.getProductVO().getScaleVO().setIngredientSw('Y');
            addNewCandidate.getProductVO().setScaleUPC(true);
        }
        // }
    }

    /**
     * Checks if is scale upc activate.
     *
     * @param lstUpcVo
     *            the lst upc vo
     * @return true, if is scale upc activate
     */
    public boolean isScaleUpcActivate(List<UPCVO> lstUpcVo) {
        boolean flag = false;
        for (UPCVO upcvo : lstUpcVo) {
            if (CPSHelper.isY(upcvo.getNewDataSw())) {
                if (CPSHelper.isNotEmpty(upcvo.getUnitUpc())) {
                    String temp = upcvo.getUnitUpc().trim();
                    if (temp.startsWith("002") && temp.endsWith("00000")) {
                        flag = true;
                        break;
                    }
                }
            }
        }
        return flag;
    }

    private List<BaseJSFVO> setDefault(List<BaseJSFVO> list, String defaultValue) {
        List<BaseJSFVO> correctedList = new ArrayList<BaseJSFVO>();
        List<PdNisCntlTab> pdNisCntlTabLst = new ArrayList<PdNisCntlTab>();
        try {
            pdNisCntlTabLst = getCommonService().getAllPssDept();
        } catch (Exception e) {
        }
        if (CPSHelper.isNotEmptyOrNotZero(defaultValue)) {
            correctedList.add(0,
                    new BaseJSFVO(defaultValue, defaultValue + getPssDeptDesc(defaultValue, pdNisCntlTabLst)));
        }
        for (BaseJSFVO baseJSFVO : list) {
            if (!defaultValue.equals(baseJSFVO.getId())) {
                correctedList.add(baseJSFVO);
            }
        }
        return correctedList;
    }

    private String getPssDeptDesc(String pssDeptId, List<PdNisCntlTab> pdNisCntlTabList) {
        String result = "-";
        if (CPSHelper.isNotEmpty(pdNisCntlTabList)) {
            for (PdNisCntlTab pdNisCntlTab : pdNisCntlTabList) {
                if (CPSHelper.getTrimmedValue(pssDeptId).equals(pdNisCntlTab.getPdCntlValCd().trim())) {
                    result += pdNisCntlTab.getPdCntlValDes();
                }
            }
        }
        return result;
    }

    /**
     * Inits the brick map.
     *
     * @param addNewCandidate
     *            the candidate form
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private void initBrickMap(AddNewCandidate addNewCandidate) throws CPSGeneralException {
        ProductVO productVO = addNewCandidate.getProductVO();
        // initBrick
        if (CPSHelper.isNotEmpty(productVO.getClassificationVO().getSubCommodity())) {
            addNewCandidate.setBrickMap(
                    this.getCommonService().getBricksBySubCommodity(productVO.getClassificationVO().getSubCommodity()));
        } else {
            addNewCandidate.setBrickMap(new HashMap<String, BaseJSFVO>());
        }
        if (CPSHelper.isNotEmpty(productVO.getClassificationVO().getBrick())
                && CPSHelper.isNumeric(productVO.getClassificationVO().getBrick())) {
            if (!addNewCandidate.getBrickMap().containsKey(productVO.getClassificationVO().getBrick())) {
                addNewCandidate.getBrickMap().put(productVO.getClassificationVO().getBrick(), new BaseJSFVO(
                        productVO.getClassificationVO().getBrick(), productVO.getClassificationVO().getBrickName()));
            }
        }
    }

    /**
     * Inits the brick. abusiveVolatileChemical
     *
     * @param addNewCandidate
     *            the candidate form
     */
    private void initBrick(AddNewCandidate addNewCandidate) {
        ProductVO productVO = addNewCandidate.getProductVO();
        if (CPSHelper.isNotEmpty(productVO.getClassificationVO().getBrick())
                && CPSHelper.isNumeric(productVO.getClassificationVO().getBrick())) {
            if (addNewCandidate.getBrickMap().containsKey(productVO.getClassificationVO().getBrick())) {
                addNewCandidate.getProductVO().getClassificationVO().setBrickName(
                        addNewCandidate.getBrickMap().get(productVO.getClassificationVO().getBrick()).getName());
            }
        }
    }

    /**
     * Sets the brand cache.
     *
     * @param addNewCandidate
     *            the new brand cache
     */
    private void setBrandCache(AddNewCandidate addNewCandidate, HttpServletRequest req) {
        List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
        String brndName = Constants.STRING_EMPTY;
        //PIM-1755 Fixed performance - Brand Name : Use Get name by Id over GetAll
        if(CPSHelper.isNotEmpty(addNewCandidate) && CPSHelper.isNotEmpty(addNewCandidate.getProductVO()) && CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getClassificationVO())){
            brndName = getCommonService().getBrandName(CPSHelper.getTrimmedValue(addNewCandidate.getProductVO().getClassificationVO().getBrand()));
            addNewCandidate.getProductVO().getClassificationVO().setBrandName(brndName);
        }
        list.add(
                new BaseJSFVO(CPSHelper.getTrimmedValue(addNewCandidate.getProductVO().getClassificationVO().getBrand()),
                        CPSHelper.getTrimmedValue(brndName) + " ["
                                + CPSHelper.getTrimmedValue(addNewCandidate.getProductVO().getClassificationVO().getBrand())
                                + "] "));
        cacheAutoCompleterResults(req, list, CPSConstants.ADD_CAND_BRAND_TYPEAHEAD_ID);
    }

    /**
     * Inits the scale vo.
     *
     * @param addNewCandidate
     *            the candidate form
     * @param prodVO
     *            the prod vo
     * @throws CPSSystemException
     *             the CPS system exception
     */
    private void initScaleVO(AddNewCandidate addNewCandidate, ProductVO prodVO) throws CPSSystemException {
        if (null != prodVO && null != prodVO.getScaleVO()) {
            ScaleVO scaleVO = prodVO.getScaleVO();
            List<IngdVO> list = scaleVO.getIngdVOList();
            for (IngdVO ingdVO : list) {
                ingdVO.setIngdDesc(CPSHelper.decorateLabelWithCode(
                        getIngdDescription(addNewCandidate, ingdVO.getIngdCode()), ingdVO.getIngdCode()));
            }
        }

        initScaleAttribute(addNewCandidate);
        if (null != prodVO && null != prodVO.getScaleVO()) {
            String associatedPLUs = StringUtils.EMPTY;
            boolean isOnlyCheckerUPC = false;
            ScaleVO scaleVO = prodVO.getScaleVO();
            List<UPCVO> upcs = prodVO.getUpcVO();
            Long upc;
            String upcStr = StringUtils.EMPTY;
            for (UPCVO upcvo : upcs) {
                // if (CPSHelper.checkEqualValue(upcvo.getUpcType(), "PLU")) {
                if (CPSHelper.isY(upcvo.getNewDataSw())) {
                    if (CPSHelper.isNotEmpty(upcvo.getUnitUpc())) {
                        upc = CPSHelper.getLongValue(upcvo.getUnitUpc());
                        upcStr = upc.toString();
                        if (upcStr.endsWith("00000") && upcvo.getUnitUpc().startsWith("002")) {
                            upcStr = upcStr.substring(1, upcStr.length() - 5);
                            prodVO.setScaleUPC(true);
                        } else {
                            if (upcs.size() == 1)
                                isOnlyCheckerUPC = true;
                        }
                        associatedPLUs += upcStr + ",";
                    }
                }
                // }
            }
            prodVO.setOnlyCheckerUPC(isOnlyCheckerUPC);
            scaleVO.setAssociatedPLUs(associatedPLUs);
            fnSetScaleUPC(prodVO);
        }
    }

    /**
     * Gets the ingd description.
     *
     * @param addNewCandidate
     *            the candidate form
     * @param code
     *            the code
     * @return the ingd description
     * @throws CPSSystemException
     *             the CPS system exception
     */
    private String getIngdDescription(AddNewCandidate addNewCandidate, String code) throws CPSSystemException {
        String[][] strings;
        try {
            // strings =
            // CPSWebUtil.getIndexBean(candidateForm.getCurrentRequest()).ingredientSearch(CPSHelper.getTrimmedValue(code),
            // 1000);
            strings = getCpsIndexService().ingredientSearch(CPSHelper.getTrimmedValue(code), 1000);
            for (String[] codeVal : strings) {
                if (code.equalsIgnoreCase(CPSHelper.getTrimmedValue(codeVal[0]))) {
                    return codeVal[1];
                }
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            throw new CPSSystemException(new CPSMessage("Cannot search ingd in lucene", CPSMessage.ErrorSeverity.ERROR));
        }
        return null;
    }

    /**
     * Gets the name for code.
     *
     * @param list
     *            the list
     * @param code
     *            the code
     * @return the name for code
     */
    private String getNameForCode(List<BaseJSFVO> list, String code) {
        for (BaseJSFVO baseJSFVO : list) {
            if (CPSHelper.getTrimmedValue(code).equals(CPSHelper.getTrimmedValue(baseJSFVO.getId()))) {
                return baseJSFVO.getName();
            }
        }
        return null;
    }

    /**
     * Sets the sub brand.
     *
     * @param addNewCandidate
     *            the new sub brand
     */
    private void setSubBrand(AddNewCandidate addNewCandidate) {
        ProductVO productVO = addNewCandidate.getProductVO();
        if (productVO != null) {
            List<UPCVO> list = productVO.getUpcVO();
            if (CPSHelper.isNotEmpty(list)) {
                for (UPCVO upcvo : list) {
                    String brandDesc = upcvo.getSubBrandDesc();
                    String brandCode = upcvo.getSubBrand();
                    if (CPSHelper.isNotEmpty(brandCode) && CPSHelper.isEmpty(brandDesc)) {
                        //PIM-1755 Fixed performance - Sub Brand Name : Use Get name by Id over GetAll
                        upcvo.setSubBrandDesc(this.getCommonService().getSubBrandName(brandCode));
                    }
                }
            }
        }
    }

    /**
     * Gets the bdm list.
     *
     * @return the bdm list
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    public List<BaseJSFVO> getBdmList() throws CPSGeneralException {
        return getAppContextFunctions().getBdmList();
    }

    /**
     * Gets the selling from ws.
     *
     * @author hungbang
     * @param subCommodity
     *            the sub commodity
     * @return list selling restriction from WS
     */
    private List<String> getSellingFromWS(String subCommodity) {
        List<String> lstRateTypeSelected = new ArrayList<String>();
        try {
            if (CPSHelper.isNotEmpty(subCommodity)) {
                ProductClassificationVO pcVo = getCommonService().getComSubCls(subCommodity);
                ClassCommodityVO clsComVo = getCommonService().getDeptSubDeptByComCd(pcVo.getCommodity());

                if (CPSHelper.isNotEmpty(pcVo) && CPSHelper.isNotEmpty(clsComVo)) {
                    lstRateTypeSelected = getCommonService().getSellingRestriction(clsComVo.getDeptId(),
                            clsComVo.getSubDeptId(), pcVo.getClassDesc(), pcVo.getCommodity(), subCommodity);

                }
            }
        } catch (Exception e) {
            LOG.error(CPSConstants.ERROR_FETCHING_PROD, e);
        }
        return lstRateTypeSelected;
    }

    public List<BaseJSFVO> getUOMFromSubCommodity(List<BaseJSFVO> originalUom, String subCommodity) {
        List<BaseJSFVO> results = null;
        List<BaseJSFVO> eliminateUom = null;
        try {
            if(CPSHelper.isNotEmpty(subCommodity)) {
                List<BaseJSFVO> uomDefaults = CommonBridge.getCommonServiceInstance().getUOMDefaultBySubCommodity(subCommodity);
                if(CPSHelper.isNotEmpty(uomDefaults)) {
                    results = new ArrayList<BaseJSFVO>();
                    eliminateUom = new ArrayList<BaseJSFVO>();
                    results.add(0, new BaseJSFVO("NONE", "--Select--"));
                    results.addAll(uomDefaults);
                    results.add(new BaseJSFVO(CPSConstant.STRING_EMPTY,"---------------------"));
                    if(CPSHelper.isNotEmpty(originalUom)) {
                        for(BaseJSFVO uom : originalUom) {
                            boolean found=false;
                            for(BaseJSFVO uomDefault : results) {
                                if(uomDefault.getId().equalsIgnoreCase(uom.getId()) || uom.getId().equalsIgnoreCase("NONE") ) {
                                    found=true;
                                    break;
                                }
                            }
                            if(!found){
                                eliminateUom.add(uom);
                            }
                        }
                        results.addAll(eliminateUom);
                    }
                } else {
                    results = originalUom;
                }
            }
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
        }
        return results;
    }

    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_CHECK_DSV_ITEM)
    public ModelAndView checkDSVItem(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                               HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        String itemId = req.getParameter("itemid");
        String upc = req.getParameter("upc");
        String prodId = req.getParameter("prodid");
        StringBuilder warningDSV = new StringBuilder();
        if (CPSHelper.isNotEmpty(itemId)) {
            String temp = getCommonService().checkDSV(itemId);
            if (CPSHelper.isNotEmpty(temp)) {
                warningDSV.append(temp);
            }
        } else if (CPSHelper.isNotEmpty(prodId)) {
            String strItemId = getCommonService().getItemIdBasedOnProdId(prodId);
            if (CPSHelper.isNotEmpty(strItemId)) {
                String temp = getCommonService().checkDSV(strItemId);
                if (CPSHelper.isNotEmpty(temp)) {
                    warningDSV.append(temp);
                }
            }
        } else if (CPSHelper.isNotEmpty(upc)) {
            String strItemId = getCommonService().getItemIdBasedOnUpc(upc);
            if (CPSHelper.isNotEmpty(strItemId)) {
                String temp = getCommonService().checkDSV(strItemId);
                if (CPSHelper.isNotEmpty(temp)) {
                    warningDSV.append(temp);
                }
            }
        }
        ModelAndView model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        model.addObject(CPSConstants.JSON_DATA,warningDSV.toString());
        return model;
    }

    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_FETCH_PRODUCT)
    public ModelAndView fetchProduct(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                     HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
        setForm(req, addNewCandidate);

        addNewCandidate.clearQuestionaireVO();
        addNewCandidate.getQuestionnarieVO().setSelectedOption(addNewCandidate.getSelectedOption());
        addNewCandidate.getQuestionnarieVO().setSelectedValue(addNewCandidate.getSelectedValue());
        addNewCandidate.getQuestionnarieVO().setEnteredValue(addNewCandidate.getEnteredValue());
        addNewCandidate.getQuestionnarieVO().setUpcDescription(addNewCandidate.getUpcDescription());
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        try {
            clearMessages(addNewCandidate);
            String userRole = getUserRole();
            this.setIntentIdentifier(addNewCandidate);
            // TBR candidateForm.initUPCVOs();
            addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
            addNewCandidate.setAddCandidateMode();
            this.getDetails(addNewCandidate, true, req);
            //Sprint - 23
            if(CPSHelper.isNotEmpty(addNewCandidate.getProductVO()) && addNewCandidate.getProductVO().isActiveProductKit()) {
                saveMessage(addNewCandidate, new CPSMessage(BusinessConstants.COPY_KIT_PRODUCT_MSG, CPSMessage.ErrorSeverity.ERROR));
                model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
                model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                return model;
            }
            // set Selling when product haven't a Selling data
            if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getOriginSellingRestriction())) {
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getProdId())) {
                    JSONArray jsonData = getSellingJsonFromWS(addNewCandidate.getProductVO().getProdId(),
                            getCommonService().getSellingRestriction(addNewCandidate.getProductVO().getClassCommodityVO().getDeptId(),
                            addNewCandidate.getProductVO().getClassCommodityVO().getSubDeptId(), addNewCandidate.getProductVO().
                                            getClassCommodityVO().getClassCode(), addNewCandidate.getProductVO().getClassificationVO().getCommodity(),
                                    addNewCandidate.getProductVO().getClassificationVO().getSubCommodity()));
                    if (!jsonData.isEmpty()) {
                        addNewCandidate.getProductVO().setOriginSellingRestriction(jsonData.toString());
                    }
                }
            }
            ProductVO productVO = addNewCandidate.getProductVO();
            productVO.setNewDataSw(CPSConstant.CHAR_N);
            addNewCandidate.setHidMrtSwitch(false);
            addNewCandidate.setViewOnlyProductMRT(false);
            // be sure user can be add UPC when switch to another tabs in Edit
            // Mode- Fix 1505
            addNewCandidate.setUpcAdded(true);
            ProductVO preservedProduct = productVO;
            this.setIntentIdentifier(productVO, addNewCandidate.getQuestionnarieVO());
            // Fix PIM 846
            if (productVO.getWorkRequest().getIntentIdentifier() == 5) {
                if (addNewCandidate.getQuestionnarieVO() != null
                        && CPSHelper.isNotEmpty(addNewCandidate.getQuestionnarieVO().getSelectedValue())) {
                    productVO.getWorkRequest().setScnCdId(addNewCandidate.getQuestionnarieVO().getBonusUpcValue());
                }
            }
            // End fix PIM 846
            // Fix 1197
            UserInfo userInfo = getUserInfo();
            WorkRequest workRqst = productVO.getWorkRequest();
            workRqst.setVendorEmail(userInfo.getMail());
            String phone = userInfo.getAttributeValue("telephoneNumber");
            if (phone != null) {
                phone = CPSHelper.cleanPhoneNumber(phone);
                if (phone.length() >= 10) {
                    workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                    workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                } else {
                    workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                    workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
                }
            }
            workRqst.setCandUpdtUID(userInfo.getUid());
            workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
            workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
            addNewCandidate
                    .setProductVO(getAddNewCandidateService().saveProductAndCaseDetails(productVO, null, userRole));
            addNewCandidate.getProductVO().setModifiedProd(true);
            this.afterSave(addNewCandidate, addNewCandidate.getProductVO(), req);
            saveStoresForVendors(addNewCandidate, preservedProduct);
            setViewMode(addNewCandidate);
            //Sprint - 23
            setModifyMode(addNewCandidate);
            // be sure data saved when user clicking on Next button
            addNewCandidate.clearViewProduct();
            setViewOverrideFlags(addNewCandidate);
            Map<String, UPCVO> upcMap = new HashMap<String, UPCVO>();
            List<UPCVO> upcs = addNewCandidate.getProductVO().getUpcVO();
            for (UPCVO upcvo : upcs) {
                upcvo.setUnitUpc10(CPSHelper.calculateCheckDigit(upcvo.getUnitUpc()) + StringUtils.EMPTY);
                upcMap.put(upcvo.getUniqueId(), upcvo);
            }
            addNewCandidate.setUpcVOs(upcMap);
            Map<String, CommentsVO> commentsMap = new HashMap<String, CommentsVO>();
            List<CommentsVO> comments = addNewCandidate.getProductVO().getCommentsVO();
            for (CommentsVO commentsvo : comments) {
                commentsvo.setUniqueId(CPSHelper.getUniqueId(commentsvo));
                commentsMap.put(commentsvo.getUniqueId(), commentsvo);
            }
            addNewCandidate.setCommentsVOs(commentsMap);
            initProductVO(addNewCandidate, req);
            initBrandField(addNewCandidate);
            clearMessages(addNewCandidate);
            addNewCandidate.setButtonViewOverRide();
            req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_PRODUCT);
            addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_PRODUCT);
            Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            saveMessage(addNewCandidate, new CPSMessage("Product copied for modify", CPSMessage.ErrorSeverity.INFO));
        } catch (Exception e) {
            LOG.error(CPSConstants.ERROR_FETCHING_PROD, e);
            clearMessages(addNewCandidate);
            saveMessage(addNewCandidate, new CPSMessage(CPSConstants.ERROR_FETCHING_PROD, CPSMessage.ErrorSeverity
                    .ERROR));
            model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
        }
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    private void afterSave(AddNewCandidate addNewCandidate, ProductVO savedProductVo, ProductVO toBeSaved,
                           ScaleVO scaleVO, HttpServletRequest req) throws CPSGeneralException {
        if (addNewCandidate.isProduct() && !addNewCandidate.isProductCaseOverridden()) {
            List<CaseVO> caseVOList = toBeSaved.getCaseVOs();
            for (CaseVO caseVO : caseVOList) {
                // Hardcoded Values
                if (caseVO.getShipPack().equalsIgnoreCase(StringUtils.EMPTY) || null == caseVO.getShipPack()) {
                    caseVO.setChannel(CPSConstants.CHANNEL_DSD);
                    caseVO.setChannelVal(CPSConstants.CHANNEL_DSD);
                } else {
                    // fix case channel = BOTH so comment 2 line below 4/3/2015
                    // caseVO.setChannel(CHANNEL_WHS);
                    // caseVO.setChannelVal(CHANNEL_WHS);

                    if (null == caseVO.getChannel() || caseVO.getChannel().equals(CPSConstants.CHANNEL_DSD)) {
                        caseVO.setChannel(CPSConstants.CHANNEL_WHS);
                        caseVO.setChannelVal(CPSConstants.CHANNEL_WHS);
                    }
                }
                // Hardcoded Values - Ends
                CaseVO caseVO2 = getAddNewCandidateService().insertCaseToProduct(savedProductVo, caseVO,
                        addNewCandidate.getQuestionnarieVO());
                List<VendorVO> list2 = caseVO2.getVendorVOs();
                for (VendorVO vendorVO : list2) {
                    // Hardcoded Values
                    if (caseVO.getShipPack().equalsIgnoreCase(StringUtils.EMPTY) || null == caseVO.getShipPack()) {
                        vendorVO.setChannel(CPSConstants.CHANNEL_DSD);
                        vendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
                    } else {
                        vendorVO.setChannel(CPSConstants.CHANNEL_WHS);
                        vendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
                    }
                    // Hardcoded Values - Ends
                    getAddNewCandidateService().insertVendorToCase(caseVO2, vendorVO, addNewCandidate.getProductVO());
                }
            }
            savedProductVo.setCaseVOs(caseVOList);
        }
        // candidateForm.setProduct(false); this line commented by deepu
        // candidateForm.setProductVO();

        // below single added by deepu(for defect 210)
        savedProductVo.setAttachmentVO(toBeSaved.getAttachmentVO());
        // savedProductVo.setScaleVO(scaleVO);
        // PIM 831
        if (BusinessUtil.isVendor(getUserRole())) {
            correctListCostForVendor(savedProductVo, addNewCandidate);
        }
        // end PIM 831
        // ProductVOHelper.clearChangeImageAttr(savedProductVo);
        addNewCandidate.setSavedProductVO(ProductVOHelper.copyProductVOtoProductVO(savedProductVo));
        //Sprint - 23
        List<UPCKitVO> newUpcKitVos = new ArrayList<UPCKitVO>();
        List<UPCKitVO> upcKitVos = savedProductVo.getUpcKitVOs();
        for (UPCKitVO upcKitVO : upcKitVos) {
            upcKitVO.setUniqueId(CPSHelper.getUniqueId(upcKitVO));
        }
        newUpcKitVos.addAll(upcKitVos);
        savedProductVo.clearUPCKitVOs();
        savedProductVo.setUpcKitVOs(newUpcKitVos);
        addNewCandidate.setProductVO(savedProductVo);
        // Fix PIM 354
        setDefaultValuePointOfSale(addNewCandidate);

        // getting commodity
        Map<String, ClassCommodityVO> map = getCommonService()
                .getCommoditiesForBDM(addNewCandidate.getProductVO().getClassificationVO().getAlternateBdm());
        addNewCandidate.setClassCommodityMap(map);
        addNewCandidate.getProductVO().getClassificationVO().setCommodityName(
                getNameForCode(addNewCandidate.getCommodities(), addNewCandidate.getProductVO().getClassificationVO().getCommodity()));

        Map<String, CommoditySubCommVO> subComm = getCommonService().getSubCommoditiesForClassCommodity(
                addNewCandidate.getProductVO().getClassificationVO().getClassField(), addNewCandidate.getProductVO().getClassificationVO().getCommodity());
        addNewCandidate.setcommoditySubMap(subComm);

        // End Fix PIM 354
        initClassField(addNewCandidate);

        this.setBrandCache(addNewCandidate, req);
        initBrandField(addNewCandidate);

        initScaleVO(addNewCandidate, addNewCandidate.getProductVO());
        this.initBrick(addNewCandidate);
        this.initElligible(addNewCandidate, req);

        if (addNewCandidate.getProductTypes() == null || addNewCandidate.getProductTypes().isEmpty()) {
            addNewCandidate.setProductTypes(getProductTypes());
        }

        List<BaseJSFVO> pssDeptList = new ArrayList<BaseJSFVO>();
        if (addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity()) != null) {
            String deptNbr = addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO()
                    .getCommodity()).getDeptId();
            String subDeptNbdr = addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                    .getSubDeptId();
            if (CPSHelper.isNotEmpty(deptNbr) && CPSHelper.isNotEmpty(subDeptNbdr)) {
                pssDeptList = getCommonService().getDeptNumbersForDeptSubDept(deptNbr, subDeptNbdr);
            }
            // Fix 1034
            pssDeptList = setDefault(pssDeptList,
                    addNewCandidate.getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity()).getPssDept());
        }
        addNewCandidate.setPssList(pssDeptList);

        // -----New feature for Tax category---
        if (!BusinessUtil.isVendor(getUserRole())) {
            try {
                addNewCandidate.getProductVO().getPointOfSaleVO()
                        .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
                    for (TaxCategoryVO tax : addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory()) {
                        if (CPSHelper.checkEqualValue(addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode(),
                                tax.getTxBltyDvrCode())) {
                            addNewCandidate.getProductVO().getPointOfSaleVO().setTaxCateName(tax.getTxBltyDvrName());
                            break;
                        }
                    }
                }
            } catch (Exception e) {
                LOG.error("Error occur when call ws TaxCategory:" + e.getMessage(), e);
            }
        }

        CPSMessage message;
        if (addNewCandidate.getProductVO().getClassificationVO().isEligible()
                && (CPSHelper.isEmpty(addNewCandidate.getProductVO().getUpcVO())
                || (addNewCandidate.getProductVO().getUpcVO().size() == 1 && CPSConstant.STRING_ITUPC
                .equalsIgnoreCase(addNewCandidate.getProductVO().getUpcVO().get(0).getUpcType())))
                && CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getClassificationVO().getBrick())
                && CPSHelper.isNumeric(addNewCandidate.getProductVO().getClassificationVO().getBrick())) {
            message = new CPSMessage(CPSConstants.CANDIDATE_SAVE_SUCCESS_WITHOUT_BRICK, CPSMessage.ErrorSeverity.INFO);
        } else {
            message = new CPSMessage(CPSConstants.CANDIDATE_SAVE_SUCCESS, CPSMessage.ErrorSeverity.INFO);
        }

        initCostOwner(addNewCandidate);
        saveMessage(addNewCandidate, message);
    }

    private void saveStoresForVendors(AddNewCandidate addNewCandidate, ProductVO preservedProduct) {
        List<CaseVO> preCases = preservedProduct.getCaseVOs();
        List<CaseVO> cases = addNewCandidate.getProductVO().getCaseVOs();

        for (CaseVO preCaseVO : preCases) {
            List<VendorVO> preVendors = preCaseVO.getVendorVOs();
            if (CPSHelper.isNotEmpty(preVendors)) {
                for (VendorVO preVendorVO : preVendors) {
                    List<StoreVO> stoVOList = preVendorVO.getAuthorizedStores();
                    if (CPSHelper.isNotEmpty(stoVOList)) {
                        this.correctAuthorizedStoreList(stoVOList, cases);
                        // boolean check = false;
                        try {
                            // HB-S21
                            getAddNewCandidateService().insertStoreData(stoVOList, null);
                        } catch (CPSGeneralException e) {
                            LOG.error(e.getMessage(), e);
                        }
                    }
                }
            }
        }
    }

    private void correctAuthorizedStoreList(List<StoreVO> stores, List<CaseVO> cases) {
        for (CaseVO caseVO : cases) {
            List<VendorVO> vendors = caseVO.getVendorVOs();
            if (CPSHelper.isNotEmpty(vendors)) {
                for (StoreVO storeVO : stores) {
                    if (CPSHelper.getStringValue(caseVO.getItemId()).equals(storeVO.getItemId())) {
                        storeVO.setItemId(caseVO.getPsItemId().toString());
                    }
                }
            }
        }
    }

    private void setIntentIdentifier(ProductVO productVO, QuestionnarieVO questionnarieVO) {
        String first = questionnarieVO.getSelectedOption();
        String second = questionnarieVO.getUpcDescription();
        if(productVO.getWorkRequest().getIntentIdentifier()!=12) {
            if (CPSConstant.STRING_1.equalsIgnoreCase(first)) {
                productVO.getWorkRequest().setIntentIdentifier(CPSHelper.getIntegerValue(second));
            } else if (CPSHelper.isNotEmpty(first)) {
                productVO.getWorkRequest().setIntentIdentifier(CPSHelper.getIntegerValue(first));
            } else {
                productVO.getWorkRequest().setIntentIdentifier(CPSHelper.getIntegerValue(second));
            }
        }
    }

    private void afterSave(AddNewCandidate addNewCandidate, ProductVO savedProductVo, HttpServletRequest req)
            throws Exception {
        // PIM 831
        if (BusinessUtil.isVendor(getUserRole())) {
            correctListCostForVendor(savedProductVo, addNewCandidate);
        }
        // end PIM 831
        // ProductVOHelper.clearChangeImageAttr(savedProductVo);
        addNewCandidate.setSavedProductVO(ProductVOHelper.copyProductVOtoProductVO(savedProductVo));

        addNewCandidate.setProductVO(savedProductVo);

        initProductVO(addNewCandidate, req);
        initBrandField(addNewCandidate);
        CPSMessage message;
        if (addNewCandidate.getProductVO().getClassificationVO().isEligible()
                && this.checkUPCForBrick(addNewCandidate.getProductVO().getUpcVO())
                && CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getClassificationVO().getBrick())
                && CPSHelper.isNumeric(addNewCandidate.getProductVO().getClassificationVO().getBrick())) {
            message = new CPSMessage(CPSConstants.CANDIDATE_SAVE_SUCCESS_WITHOUT_BRICK, CPSMessage.ErrorSeverity.ERROR);
        } else {
            message = new CPSMessage(CPSConstants.CANDIDATE_SAVE_SUCCESS, CPSMessage.ErrorSeverity.INFO);
        }
        saveMessage(addNewCandidate, message);
        if (addNewCandidate.getSavedProductVO() != null && addNewCandidate.getSavedProductVO().getClassificationVO() != null
                && CPSHelper.isEmpty(addNewCandidate.getSavedProductVO().getClassificationVO().getClassDesc())) {
            if (addNewCandidate.getProductVO() != null && addNewCandidate.getProductVO().getClassificationVO() != null) {
                addNewCandidate.getSavedProductVO().getClassificationVO()
                        .setClassDesc(addNewCandidate.getProductVO().getClassificationVO().getClassDesc());
            }
        }
    }

    private boolean checkUPCForBrick(List<UPCVO> upcs) {
        boolean check = false;
        if (CPSHelper.isEmpty(upcs)) {
            check = true;
        }
        if (this.isITUPCLst(upcs)) {
            check = true;
        }
        return check;
    }

    private boolean isITUPCLst(List<UPCVO> upcs) {
        boolean check = false;
        int count = 0;
        if (CPSHelper.isNotEmpty(upcs)) {
            for (UPCVO upcvo : upcs) {
                if (CPSConstant.STRING_ITUPC.equalsIgnoreCase(upcvo.getUpcType())) {
                    count++;
                }
            }
            check = count == upcs.size();
        }
        return check;
    }
    /**
     * Get the last form/model.
     *
     * @param session the current session.
     * @param addNewCandidate current form/model.
     * @return current form/model.
     */
    private AddNewCandidate getLastForm(HttpSession session, AddNewCandidate addNewCandidate){
        if(session.getAttribute(AddNewCandidate.FORM_NAME) != null){
            AddNewCandidate oldAddNewCandidate =  (AddNewCandidate)session.getAttribute(AddNewCandidate.FORM_NAME);
            oldAddNewCandidate.setHidUpcValue(addNewCandidate.getHidUpcValue());
            oldAddNewCandidate.setHidUpcCheckDigit(addNewCandidate.getHidUpcCheckDigit());
            oldAddNewCandidate.setHidDescription(addNewCandidate.getHidDescription());
            oldAddNewCandidate.setHiddenKitCost(addNewCandidate.getHiddenKitCost());
            oldAddNewCandidate.setHidBatchUploaded(addNewCandidate.isHidBatchUploaded());
            return oldAddNewCandidate;
        }
        return addNewCandidate;
    }
    /**
     * Function for displaying the MRT tab functions.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = RELATIVE_PATH_MRT_SCREEN)
    public ModelAndView mrtScreen(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                     HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        addNewCandidate.getQuestionnarieVO().setSelectedOption(addNewCandidate.getSelectedOption());
        setForm(req, addNewCandidate);
        req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
        clearViewMode(addNewCandidate);
        this.setIntentIdentifier(addNewCandidate);
        addNewCandidate.setHidMrtSwitch(true);
        addNewCandidate.setMrtvo(new MrtVO());
        addNewCandidate.setNormalProduct(false);
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
        addNewCandidate.getMrtvo().getCaseVO().setTouchTypeList(getTouchTypeCodes());
        addNewCandidate.getMrtvo().getCaseVO().setItemCategoryList(getItemCategoryList());
        // DRU
        addNewCandidate.getMrtvo().getCaseVO().setReadyUnits(getReadyUnitList());
        addNewCandidate.getMrtvo().getCaseVO().setOrientations(getOrientationList());
        // END DRU
        addNewCandidate.getMrtvo().getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
        addNewCandidate.setChannels(getChannels());
        addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
        addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
        addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
        addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());

        // Order Unit changes
        addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());
        List<VendorLocationVO> subVendorList = new ArrayList<VendorLocationVO>();
        addNewCandidate.getVendorVO().setVendorLocationList(subVendorList);
        ProductVO productVO = new ProductVO();
        MRTUPCVO mrtUpcVO = new MRTUPCVO();
        mrtUpcVO.setProductVO(productVO);
        addNewCandidate.setProductVO(mrtUpcVO.getProductVO());
        // visible Additional Information Tab
        addNewCandidate.setViewAddInforPage(true);
        addNewCandidate.setEnableActiveButton(true);
        addNewCandidate.setUpcAdded(true);
        req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.SET_UP_MRT);
        addNewCandidate.setCurrentAppName(CPSConstants.SET_UP_MRT);
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * When clicking Next button from questionnaire page and from Auth &
     * distribution tab.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_PROD_AND_UPC)
    public ModelAndView prodAndUpc(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                  HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        if (!addNewCandidate.isUpcValueFromMRT()) {
            addNewCandidate.setUpcValueFromMRT(false);
        }
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
        addNewCandidate.setAddCandidateMode();
        if (addNewCandidate.isViewMode() && !addNewCandidate.isProduct())
            addNewCandidate.setPrintable(true);
        else
            addNewCandidate.setPrintable(false);
        if (CPSConstants.MODIFY.equals(addNewCandidate.getAction())) {
            req.setAttribute(CPSConstants.CURRENT_APP_NAME,CPSConstants. MODIFY_CANDIDATE);
        }
        try {
            this.getDetails(addNewCandidate, req);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        // add empty data in Merchandise Type
        if ("SPLY".equals(addNewCandidate.getProductVO().getClassificationVO().getProductType())) {
            BaseJSFVO jsfVo = new BaseJSFVO();
            jsfVo.setId(CPSConstant.STRING_EMPTY);
            jsfVo.setName(CPSConstant.STRING_EMPTY);
            addNewCandidate.getMerchandizingTypes().add(0, jsfVo);
        }
        // -----New feature for Tax category---
        if (!BusinessUtil.isVendor(getUserRole())) {
            try {
                addNewCandidate.getProductVO().getPointOfSaleVO()
                        .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
                    for (TaxCategoryVO tax : addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory()) {
                        if (CPSHelper.checkEqualValue(addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode(),
                                tax.getTxBltyDvrCode())) {
                            addNewCandidate.getProductVO().getPointOfSaleVO().setTaxCateName(tax.getTxBltyDvrName());
                            break;
                        }
                    }
                }
            } catch (Exception e) {
                LOG.error("Error occur when call ws TaxCategory:" + e.getMessage(), e);
            }
        }
        // -----New feature for Tax category---
        try {
            if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getClassificationVO().getClassDesc())) {
                initClassField(addNewCandidate);
            }
            initMatrixMarginMap(addNewCandidate);
            if (CPSConstants.WORKING_CODE.equalsIgnoreCase(addNewCandidate.getProductVO().getWorkRequest().getWorkStatusCode())
                    && CPSWebUtil.isVendor(getUserRole())) {
                addNewCandidate.setViewOverRide();
                setViewMode(addNewCandidate);
                addNewCandidate.setEnableClose(false);
            } else if (CPSHelper.isN(addNewCandidate.getProductVO().getNewDataSw()) && addNewCandidate.isUpcAdded()) {
                setViewMode(addNewCandidate);
                addNewCandidate.setUpcViewOverRide();
                addNewCandidate.setCaseViewOverRide();
                addNewCandidate.setButtonViewOverRide();
                addNewCandidate.setEnableClose(false);
                addNewCandidate.setModifyProdCand(true);
                addNewCandidate.setScaleViewOverRide();
            }
            //BAU-Feb-PIM-1608-Nutrition Facts--Get information
            List<BigInteger> unitUPCs = new ArrayList<BigInteger>();
            Map<BigInteger, String> mapUnitUPC = new HashMap<BigInteger, String>();
            Integer psWrkId = CPSConstant.NUMBER_0;
            if(!CPSHelper.isEmpty(addNewCandidate.getProductVO().getUpcVO())){
                for(UPCVO upcVO : addNewCandidate.getProductVO().getUpcVO()){
                    if(!CPSHelper.isEmpty(upcVO) && upcVO.getNewDataSw() == CPSConstant.CHAR_Y){
                        BigInteger upc = BigInteger.valueOf(Long.valueOf(CPSHelper.getTrimmedValue(upcVO.getUnitUpc())));
                        unitUPCs.add(upc);
                        mapUnitUPC.put(upc, CPSHelper.getTrimmedValue(upcVO.getUnitUpc()));
                    }
                }
                psWrkId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
            }
            this.getAddNewCandidateService().getNutritionFactsInformation(addNewCandidate.getProductVO(), unitUPCs, psWrkId, mapUnitUPC);
            if (!CPSHelper.isEmpty(addNewCandidate.getProductVO().getApprByUserId())) {
                addNewCandidate.getProductVO().setApprByUserName(getDisplayNameByUserId(addNewCandidate.getProductVO().getApprByUserId()));
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
		addNewCandidate.setDummyProperty(BusinessConstants.EMPTY_STRING);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    /**
     * Function for displaying the MRT tab functions.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_SHOW_MRT)
    public ModelAndView showMRT(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                   HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        try {
            addNewCandidate.setSession(req.getSession());
            setForm(req, addNewCandidate);
            addNewCandidate.setEnableActiveButton(true);
            // clearViewMode(candidateForm);
            // candidateForm.clearViewOverRide();
            int unitTotalAttribute = 0;
            // Check whether modify button is clicked from View mode
            String modifyFromView = req.getParameter("modifyFromView");
            if (null != modifyFromView) {
                if (CPSConstant.STRING_Y.equalsIgnoreCase(modifyFromView)) {
                    addNewCandidate.setViewMode(false);
                }
            }

            // trungnv fix 2936

            /*
             * if current page is MRT and click on this tab keep current state
             */
            if (addNewCandidate.getTabIndex() == AddNewCandidate.TAB_MRT) {
                // be sure status code not change when user navigate between tabs
                if (addNewCandidate.getMrtvo() != null && addNewCandidate.getMrtvo().getCaseVO() != null
                        && addNewCandidate.getMrtvo().getCaseVO().getPsItemId() != null) {
                    addNewCandidate.getProductVO().getWorkRequest().setWorkStatusCode(getAddNewCandidateService()
                            .getPdSetupStatCd(addNewCandidate.getMrtvo().getCaseVO().getPsItemId()));
                }
                model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
                return model;
            }

            // 1198 changes
            if (!addNewCandidate.isMrtViewMode()) {
                addNewCandidate.setViewMode(false);
                addNewCandidate.setCaseViewOverRide();
                addNewCandidate.setUpcViewOverRide();
            }
            if (AddNewCandidate.TAB_PROD_UPC == addNewCandidate.getTabIndex()
                    && CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getClassificationVO().getProductType())) {
                if (!addNewCandidate.isMrtActiveProduct()) {
                    saveDetails(addNewCandidate, req, resp);
                }
            }
            //addNewCandidate.setDummyProperty(BusinessConstants.EMPTY_STRING);
            addNewCandidate.setMrtActiveProduct(false);
            addNewCandidate.setProduct(false);
            this.setIntentIdentifier(addNewCandidate);
            addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
            List<VendorLocationVO> subVendorList = new ArrayList<VendorLocationVO>();
            List<MRTUPCVO> mrtUpcList = addNewCandidate.getMrtvo().getMrtVOs();
            // Checking with the production database - Starts
            ProductVO productVO = null;
            MRTUPCVO mrtUpcVO = null;
            String unitUPC = CPSConstants.EMPTY_STRING;
            if (!mrtUpcList.isEmpty()) {
                Map<String, MRTUPCVO> map = new HashMap<String, MRTUPCVO>();
                for (MRTUPCVO mrtupcvo : mrtUpcList) {
                    map.put(mrtupcvo.getUnitUPC(), mrtupcvo);
                }
                mrtUpcList = new ArrayList<MRTUPCVO>(map.values());
                for (MRTUPCVO mrtVOTemp : mrtUpcList) {
                    productVO = new ProductVO();
                    mrtUpcVO = new MRTUPCVO();
                    unitUPC = mrtVOTemp.getUnitUPC();
                    boolean flagWebService = true;
                    try {
                        productVO = getAddNewCandidateService().getProductBasic(unitUPC, CPSConstants.EMPTY_STRING, CPSConstants.EMPTY_STRING);
                        flagWebService = true;
                        this.correctUOM(productVO);
                    } catch (CPSBusinessException e) {
                        LOG.error(e.getMessage(), e);
                    } catch (CPSSystemException ex) {
                        LOG.error(ex.getMessage(), ex);
                        mrtUpcVO.setApproval("No");
                        flagWebService = false;
                        mrtUpcVO.setDescription(CPSConstants.EMPTY_STRING);
                    }
                    if (null == productVO.getProdId() && flagWebService) {
                        mrtUpcVO = getAddNewCandidateService().getMRTDetails(unitUPC);
                        if (mrtUpcVO.isSelected())
                            addNewCandidate.setProductVO(mrtUpcVO.getProductVO());
                    } else {
                        mrtUpcVO.setApproval("No");
                        mrtUpcVO.setDescription(productVO.getClassificationVO().getProdDescritpion());
                        setItemCode(mrtUpcVO, productVO);
                        mrtUpcVO.setProductVO(productVO);
                        if (mrtUpcVO.isSelected())
                            addNewCandidate.setProductVO(mrtUpcVO.getProductVO());
                    }
                    mrtUpcVO.setSellableUnits(mrtVOTemp.getSellableUnits());
                    // Add current number of sellable units to Unit Total Attribute
                    mrtUpcVO.setUnitUPC(unitUPC);
                    mrtUpcVO.setUnitUPCCheckDigit(String.valueOf(CPSHelper.calculateCheckDigit(unitUPC)));
                    // not sum for FakeUPC
                    if (!CPSHelper.isFakeUPC(mrtUpcVO.getUnitUPC())) {
                        unitTotalAttribute += Integer.parseInt(mrtVOTemp.getSellableUnits());
                    }
                    mrtUpcVO.setMrtUPCSaved(mrtVOTemp.isMrtUPCSaved());
                    addNewCandidate.getMrtvo().addMRTVO(mrtUpcVO);
                    addNewCandidate.getMrtvo().removeMRTVO(mrtVOTemp.getUniqueId());
                    unitUPC = CPSConstants.EMPTY_STRING;
                }
            }
            addNewCandidate.getMrtvo().getMrtUpcVO().setUnitTotalAttribute(unitTotalAttribute);
            // Checking with the production database - Ends
            addNewCandidate.setChannels(getChannels());
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO())) {
                if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getChannelVal())) {
                    subVendorList = setVendorListForMRT(addNewCandidate.getMrtvo().getMrtVOs(), addNewCandidate,
                            addNewCandidate.getMrtvo().getCaseVO(), req);
                }
                // fix reset cost owner list when update brand
                addNewCandidate.setCostOwners(new ArrayList<BaseJSFVO>());
                // Fix 1289.
                addNewCandidate.setCostOwners(setCostOwnerValuesForMRT(addNewCandidate));
                addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
                addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
                addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
                addNewCandidate.getMrtvo().getCaseVO().setTouchTypeList(getTouchTypeCodes());
                addNewCandidate.getMrtvo().getCaseVO().setItemCategoryList(getItemCategoryList());
                // DRU
                addNewCandidate.getMrtvo().getCaseVO().setReadyUnits(getReadyUnitList());
                addNewCandidate.getMrtvo().getCaseVO().setOrientations(getOrientationList());
                // END DRU
                addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());
                addNewCandidate.getMrtvo().getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
                // Order Unit changes
                addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());
            }
            addNewCandidate.getVendorVO().setVendorLocationList(subVendorList);
            Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            if (addNewCandidate.getTabIndex() > 0) {
                // be sure status code not change when user navigate between tabs
                if (addNewCandidate.getMrtvo() != null && addNewCandidate.getMrtvo().getCaseVO() != null
                        && addNewCandidate.getMrtvo().getCaseVO().getPsItemId() != null) {
                    addNewCandidate.getProductVO().getWorkRequest().setWorkStatusCode(getAddNewCandidateService()
                            .getPdSetupStatCd(addNewCandidate.getMrtvo().getCaseVO().getPsItemId()));
                }
            }
        }catch (Exception exp){
            LOG.error(exp.getMessage(), exp);
            CPSMessage message = new CPSMessage(exp.getMessage(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
        }
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_SAVE_DETAIL)
    public ModelAndView saveDetail(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                   HttpServletRequest req, HttpServletResponse resp) throws Exception {
        boolean flag = doSaveDetail(addNewCandidate, req, resp);
        return null;
    }

    private boolean doSaveDetail(AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        // Test flow
        // Dont change anything if it is activate flow.
        if (AddNewCandidate.TAB_NEW_AUTH != addNewCandidate.getTabIndex()) {
            this.mapCheckBoxesInProductAndUPCPage(req, addNewCandidate);
        }
        // Setting the brand to Un-assigned if product type is Non-Sellable
        //if (CPSConstant.SPLY.equalsIgnoreCase(addNewCandidate.getProductVO().getClassificationVO().getProductType())) {
        if (null == addNewCandidate.getProductVO().getClassificationVO().getBrand()
                || StringUtils.EMPTY.equals(addNewCandidate.getProductVO().getClassificationVO().getBrand())  || CPSHelper
                .isEmpty
                        (addNewCandidate.getProductVO().getClassificationVO().getBrandName())) {
            addNewCandidate.getProductVO().getClassificationVO().setBrand(CPSConstant.STRING_0);
            addNewCandidate.getProductVO().getClassificationVO().setBrandName(CPSConstant.UNASSIGNED);
        }
        //}
        // validate ExpectedDate
        /*if (addNewCandidate.getTabIndex() == AddNewCandidate.TAB_IMG_ATTR) {
            if (addNewCandidate.getProductVO().getImageAttVO() != null
                    && addNewCandidate.getSavedProductVO().getImageAttVO() != null) {
                if (CPSHelper.isNotEmpty(addNewCandidate.getSavedProductVO().getImageAttVO().getImageExpectDt())
                        && !CPSHelper.checkEqualValue(
                        addNewCandidate.getSavedProductVO().getImageAttVO().getImageExpectDt(),
                        addNewCandidate.getProductVO().getImageAttVO().getImageExpectDt())) {
                    if (!validateExpectedDate(addNewCandidate.getProductVO().getImageAttVO().getImageExpectDt())) {
                        addNewCandidate.getProductVO().getImageAttVO().setChangeImageExpectDt(true);
                        return false;
                    }
                }
                if (addNewCandidate.getProductVO().getClassificationVO() != null
                        && addNewCandidate.getProductVO().getImageAttVO() != null) {
                    if (addNewCandidate.getProductVO().getImageAttVO().isBrickDispl()
                            && addNewCandidate.getProductVO().getImageAttVO().isBrickRq()
                            && CPSHelper.isEmpty(addNewCandidate.getProductVO().getClassificationVO().getBrick())) {
                        return false;
                    }
                }
            }
        }*/
        // validating before save
        if (!addNewCandidate.getProductVO().isModifiedProd()) {
            if (!validateSaveReturn(addNewCandidate)) {
                // move this lines from in method validateSaveReturn
                addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
                return false;
            }
        } else {
            String ingSwt = addNewCandidate.getScaleAttrib();
            if ("I".equalsIgnoreCase(ingSwt)) {
                addNewCandidate.getProductVO().getScaleVO().setIngredientSw('Y');
            } else {
                addNewCandidate.getProductVO().getScaleVO().setIngredientSw('N');
            }
        }
        if (CPSConstant.HEB.equals(addNewCandidate.getProductVO().getPharmacyVO().getDrugNmCd())) {
            addNewCandidate.getProductVO().getPharmacyVO().setDrugNmCd(StringUtils.EMPTY);
        }
        // convert string json to object selling before save
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getJsonSellingRestriction())) {
            // PointOfSaleVO pointOfS = JsonOrgConverter
            // .convertJsonToVO(addNewCandidate.getProductVO().getJsonSellingRestriction());
            PointOfSaleVO pointOfS = JsonOrgConverter
                    .convertSellingResJsonToVO(addNewCandidate.getProductVO().getJsonSellingRestriction());
            addNewCandidate.getProductVO().getPointOfSaleVO().setLstRating(pointOfS.getLstRating());
            addNewCandidate.getProductVO().getPointOfSaleVO()
                    .setLstSellingRestrictions(pointOfS.getLstSellingRestrictions());
            addNewCandidate.getProductVO().getPointOfSaleVO().setOffPermise(pointOfS.getOffPermise());
        } else {
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getOriginSellingRestriction())) {
                PointOfSaleVO pointOfS = ProductEntityConverter
                        .convertJson1ToVO(addNewCandidate.getProductVO().getOriginSellingRestriction());
                addNewCandidate.getProductVO().getPointOfSaleVO().setLstRating(pointOfS.getLstRating());
                addNewCandidate.getProductVO().getPointOfSaleVO()
                        .setLstSellingRestrictions(pointOfS.getLstSellingRestrictions());
                addNewCandidate.getProductVO().getPointOfSaleVO().setOffPermise(pointOfS.getOffPermise());
            }
        }

        String userRole = getUserRole();
        if (null != addNewCandidate.getProductVO().getScaleVO()) {
            if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getScaleVO().getForceTare())
                    || (CPSConstant.STRING_0).equals(addNewCandidate.getProductVO().getScaleVO().getForceTare())) {
                addNewCandidate.getProductVO().getScaleVO().setForceTare(CPSConstant.STRING_N);
            } else if ((CPSConstant.STRING_1).equals(addNewCandidate.getProductVO().getScaleVO().getForceTare())) {
                addNewCandidate.getProductVO().getScaleVO().setForceTare(CPSConstant.STRING_Y);
            }
        }
        if (addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_N) {
            // Fix 1198. ignore if mrt product
            if (!addNewCandidate.isMrtActiveProduct()) {
                // fix alway save TAB_PROD_UPC when change tab or save to change
                // status from 105 -> 107
                if (ProductVOHelper.entitySaved(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO(),
                        addNewCandidate.getTabIndex())
                        || AddNewCandidate.TAB_PROD_UPC == addNewCandidate.getTabIndex()) {
                    ProductVO preservedProduct = addNewCandidate.getProductVO();
                    if (ProductVOHelper.pssChanged(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO())) {
                        if (addNewCandidate.getVendorVO().getPssDept() != null
                                && !StringUtils.EMPTY.equals(addNewCandidate.getVendorVO().getPssDept().trim())) {
                            addNewCandidate.getVendorVO()
                                    .setPssDept(addNewCandidate.getProductVO().getPointOfSaleVO().getPssDept());
                        }
                    }
                    // Fix 1197
                    UserInfo userInfo = getUserInfo();
                    WorkRequest workRqst = addNewCandidate.getProductVO().getWorkRequest();
                    workRqst.setVendorEmail(userInfo.getMail());
                    String phone = userInfo.getAttributeValue("telephoneNumber");
                    if (phone != null) {
                        phone = CPSHelper.cleanPhoneNumber(phone);
                        if (phone.length() >= 10) {
                            workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                            workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                        } else {
                            workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                            workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
                        }
                    }
                    workRqst.setCandUpdtUID(userInfo.getUid());
                    workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
                    workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
                    ProductVO savedProductVo = getAddNewCandidateService().saveProductAndCaseDetails(
                            addNewCandidate.getProductVO(), addNewCandidate.getQuestionnarieVO(), userRole);
                    savedProductVo.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
                    savedProductVo.setModifiedProd(true);
                    addNewCandidate.setProductVO(savedProductVo);
                    saveStoresForVendors(addNewCandidate, preservedProduct);
                    this.afterSave(addNewCandidate, addNewCandidate.getProductVO(), req);
                    clearMessages(addNewCandidate);
                }
                CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_SAVED_SUCCESSFULLY, CPSMessage.ErrorSeverity.INFO);
                saveMessage(addNewCandidate, message);
            }
        } else {
            // fix alway save TAB_PROD_UPC when change tab or save to change
            // status from 105 -> 107
            if (ProductVOHelper.entitySaved(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO(),
                    addNewCandidate.getTabIndex()) || AddNewCandidate.TAB_PROD_UPC == addNewCandidate.getTabIndex()) {
                preSave(addNewCandidate);
                ProductVO savedProductVo = new ProductVO();
                ProductVO toBeSaved = addNewCandidate.getProductVO();
                if (ProductVOHelper.pssChanged(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO())) {
                    if (addNewCandidate.getVendorVO().getPssDept() != null
                            && !StringUtils.EMPTY.equals(addNewCandidate.getVendorVO().getPssDept().trim())) {
                        addNewCandidate.getVendorVO()
                                .setPssDept(addNewCandidate.getProductVO().getPointOfSaleVO().getPssDept());
                    }
                }
                ScaleVO scaleVO = toBeSaved.getScaleVO();
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getCopiedProdid())) {
                    // Fix 1223
                    if (!addNewCandidate.getProductVO().isCopiedProductSaved()) {
                        // Set the dept and sub-dept
                        if (null != toBeSaved.getClassificationVO().getCommodity() && null != addNewCandidate
                                .getClassCommodityVO(toBeSaved.getClassificationVO().getCommodity())) {
                            String deptNbr = addNewCandidate
                                    .getClassCommodityVO(toBeSaved.getClassificationVO().getCommodity()).getDeptId();
                            String subDeptNbdr = addNewCandidate
                                    .getClassCommodityVO(toBeSaved.getClassificationVO().getCommodity()).getSubDeptId();
                            toBeSaved.setDept(deptNbr);
                            toBeSaved.setSubDept(subDeptNbdr);
                        }
                    }
                    savedProductVo = getAddNewCandidateService().saveProductAndCaseDetails(toBeSaved,
                            addNewCandidate.getQuestionnarieVO(), userRole);
                    savedProductVo.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
                    // Fix 1223
                    if (!addNewCandidate.getProductVO().isCopiedProductSaved()) {
                        toBeSaved.setCopiedProductSaved(true);
                        savedProductVo.setCopiedProductSaved(true);
                    }
                    savedProductVo.setModifiedProd(true);
                } else {
                    // Fix 1197
                    UserInfo userInfo = getUserInfo();
                    WorkRequest workRqst = toBeSaved.getWorkRequest();
                    workRqst.setVendorEmail(userInfo.getMail());
                    String phone = userInfo.getAttributeValue("telephoneNumber");
                    if (phone != null) {
                        phone = CPSHelper.cleanPhoneNumber(phone);
                        if (phone.length() >= 10) {
                            workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                            workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                        } else {
                            workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                            workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
                        }
                    }
                    workRqst.setCandUpdtUID(userInfo.getUid());
                    workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
                    workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
                    savedProductVo = getAddNewCandidateService().saveProductDetails(toBeSaved, userRole);
                    savedProductVo.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
                }
                this.afterSave(addNewCandidate, savedProductVo, toBeSaved, scaleVO, req);
            }
        }
        return true;
    }
    /**
     * handles the 'prodAndUpc' tab of the tab view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_AUTH_AND_DIST)
    public ModelAndView authAndDist(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                   HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ProductClassificationVO productClassificationVO= addNewCandidate.getProductVO().getClassificationVO();
        PointOfSaleVO pointOfSaleVO = addNewCandidate.getProductVO().getPointOfSaleVO();
        RetailVO retailVO = addNewCandidate.getProductVO().getRetailVO();
        ShelfEdgeVO shelfEdgeVO = addNewCandidate.getProductVO().getShelfEdgeVO();
        MerchandisingAttributesVO merchandisingAttributesVO = addNewCandidate.getProductVO().getMerchandisingAttributesVO();
        if(StringUtils.isBlank(addNewCandidate.getSelectedProductId())) {
            // New product
            addNewCandidate.getProductVO().setClassificationVO(productClassificationVO);
            addNewCandidate.getProductVO().setPointOfSaleVO(pointOfSaleVO);
            addNewCandidate.getProductVO().setRetailVO(retailVO);
            addNewCandidate.getProductVO().setMerchandisingAttributesVO(merchandisingAttributesVO);
            addNewCandidate.getProductVO().setShelfEdgeVO(shelfEdgeVO);
        }
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        addNewCandidate.setSession(req.getSession());
        try {
            setForm(req, addNewCandidate);
            List<CaseVO> caseVOs = addNewCandidate.getProductVO().getCaseVOs();
            // re-write ItemCode for each Case UPC --fix QC1508
            Number itemId = 0;
            for (CaseVO caseVO : caseVOs) {
                if (CPSHelper.isNotEmpty(caseVO.getPsItemId())) {
                    itemId = getAddNewCandidateService().getItemCode(caseVO.getPsItemId());
                    if (itemId != null && itemId.longValue() > 0) {
                        caseVO.setItemId(itemId);
                    }
                }
            }
            if (addNewCandidate.getTabIndex() == AddNewCandidate.TAB_PROD_UPC) {
                setDataSessionBoxesInProductAndUPCPage(req, addNewCandidate);
            }
            this.mapCheckBoxesInProductAndUPCPage(req, addNewCandidate);
            // Check whether modify button is clicked from View mode
            String modifyFromView = req.getParameter("modifyFromView");
            if (null != modifyFromView) {
                if (CPSConstant.STRING_Y.equalsIgnoreCase(modifyFromView)) {
                    if(addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier()==12) {
                        req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_KIT);
                        addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_KIT);
                    } else {
                        req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_CANDIDATE);
                        addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_CANDIDATE);
                    }
                    addNewCandidate.setViewMode(false);
                    addNewCandidate.setUpcAdded(true);
                    if (addNewCandidate.isProduct()) {
                        addNewCandidate.clearViewProduct();
                    }
                    if (CPSHelper.isN(addNewCandidate.getProductVO().getNewDataSw())) {
                        setViewMode(addNewCandidate);
                        addNewCandidate.setUpcViewOverRide();
                        addNewCandidate.setCaseViewOverRide();
                        addNewCandidate.setButtonViewOverRide();
                        addNewCandidate.setEnableClose(false);
                        addNewCandidate.setModifyProdCand(true);
                    }
                    addNewCandidate.setModifyMode(true);
                    // Fix 1307
                    if (CPSConstants.WORKING_CODE.equalsIgnoreCase(addNewCandidate.getProductVO().getWorkRequest().getWorkStatusCode())
                            && CPSWebUtil.isVendor(getUserRole())) {
                        addNewCandidate.setViewOverRide();
                        setViewMode(addNewCandidate);
                        addNewCandidate.setEnableClose(false);
                    }
                }
            } else {
                if (!addNewCandidate.isViewMode()) {
                    addNewCandidate.clearViewProduct();// be sure data validation
                    // when move to next tab
                }
            }
            if (addNewCandidate.isViewMode() && !addNewCandidate.isProduct()) {
                addNewCandidate.setPrintable(true);
            } else {
                addNewCandidate.setPrintable(false);
            }

            // trungnv fix 1718
			/*
			 * if (ProductVOHelper.entitySaved(addNewCandidate.getProductVO(),
			 * addNewCandidate.getSavedProductVO())) {
			 * addNewCandidate.clearViewProduct(); }
			 */
            if (!addNewCandidate.isViewProduct()) {
                if (!doSaveDetail(addNewCandidate , req, resp)) {
                    //
                    CPSMessage message = new CPSMessage("Please enter the mandatory fields.", CPSMessage.ErrorSeverity.VALIDATION);
                    /*if (AddNewCandidate.TAB_IMG_ATTR == addNewCandidate.getTabIndex()) {
                        // if
                        // (addNewCandidate.getProductVO().getImageAttVO().isChangeImageExpectDt())
                        // {
                        if (addNewCandidate.getProductVO().getImageAttVO().isChangeImageExpectDt()) {
                            message = new CPSMessage(
                                    "Please enter a valid date, Expected date does not allow a past date.",
                                    CPSMessage.ErrorSeverity.VALIDATION);
                            addNewCandidate.getProductVO().getImageAttVO().setChangeImageExpectDt(false);
                        }
                        message = new CPSMessage("Please enter a valid date, Expected date does not allow a past date.",
                                CPSMessage.ErrorSeverity.VALIDATION);
                        // addNewCandidate.getProductVO().getImageAttVO().setImageExpectDt(addNewCandidate.getSavedProductVO().getImageAttVO().getImageExpectDt());
                        addNewCandidate.getProductVO().getImageAttVO().setChangeImageExpectDt(false);
                        // }
                    } else {
                        message = new CPSMessage("Please enter the mandatory fields.", CPSMessage.ErrorSeverity.VALIDATION);
                    }*/
                    saveMessage(addNewCandidate, message);
                    // comment setRateAndRatingType because it can moved to
                    // selling restrictions
                    // setRateAndRatingType(addNewCandidate);
                    // ---------end
                    model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                    return model;
                } else {
                    addNewCandidate.clearViewProduct();
                }
                // be sure data saved when user clicking on Next button or
                // switch tabs
                clearViewMode(addNewCandidate);
            }
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getProdId())
                    && (CPSHelper.isEmpty(addNewCandidate.getProductVO().getPsProdId())
                    || addNewCandidate.getProductVO().getPsProdId() == 0)) {
                setViewMode(addNewCandidate);
                // addNewCandidate.setUpcAdded(false);
            }
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getProdId())
                    && addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_N) {
                setViewMode(addNewCandidate);
            }
            //Sprint-23
            if(!addNewCandidate.getProductVO().isActiveProductKit() || CPSHelper.isEmpty(addNewCandidate.getProductVO().getUpcKitVOs())) {
                //Nothing to do
            } else {
                this.setIntentIdentifier(addNewCandidate);
            }

            addNewCandidate.setTabIndex(AddNewCandidate.TAB_NEW_AUTH);
            addNewCandidate.getCaseVO().setTouchTypeList(getTouchTypeCodes());
            addNewCandidate.getCaseVO().setItemCategoryList(getItemCategoryList());
            // DRU
            addNewCandidate.getCaseVO().setReadyUnits(getReadyUnitList());
            addNewCandidate.getCaseVO().setOrientations(getOrientationList());
            if (CPSHelper.isEmpty(addNewCandidate.getCaseVO().getPsItemId())
                    || addNewCandidate.getCaseVO().getPsItemId() <= 0) {
                addNewCandidate.getCaseVO().setDsplyDryPalSw(false);
                addNewCandidate.getCaseVO().setSrsAffTypCd(null);
                addNewCandidate.getCaseVO().setProdFcngNbr(StringUtils.EMPTY);
                addNewCandidate.getCaseVO().setProdRowDeepNbr(StringUtils.EMPTY);
                addNewCandidate.getCaseVO().setProdRowHiNbr(StringUtils.EMPTY);
                addNewCandidate.getCaseVO().setNbrOfOrintNbr(StringUtils.EMPTY);

            }
            // END DRU
            addNewCandidate.getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
            addNewCandidate.setChannels(getChannels());
            initApplicableUPCs(addNewCandidate);
            addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
            addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
            addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
            addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());
            // Order Unit changes
            addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());
            /**
             * correct the productVO.caseVo.VendorVOs here.
             */
            ProductVO productVO = getCommonService().correctVendorInfo(addNewCandidate.getProductVO());
            // PIM 831
            // getCorrectInforVendorLogin(productVO, req);
            initScaleVO(addNewCandidate, productVO);
            setEdcForItems(productVO.getCaseVOs(), addNewCandidate);
            // for(CaseVO caseVO: productVO.getCaseVOs()){
            // if(!flag){
            // CPSHelper.setChannelForMorph(caseVO);
            // }
            // }
            addNewCandidate.setProductVO(productVO);
            if (addNewCandidate.getProductVO().isModifyFlag()) {
                addNewCandidate.getProductVO().setModifyFlag(true);
            }
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, getSelectedCaseVO(addNewCandidate));
            Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
            return model;

        } catch (Exception e) {
            LOG.error("Exception:-", e);
        }
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    /**
     * Get the display name by userId using HebLdapService - PIM 1608
     *
     * @param apprByUserId
     * @return the displayName
     */
    public String getDisplayNameByUserId(String apprByUserId){
        String userName = apprByUserId;
        try{
            if(!CPSHelper.isEmpty(CPSHelper.getTrimmedValue(apprByUserId))){
                UserInfo userInfo = (UserInfo) this.hebLdapUserService.getUserInfo(apprByUserId);
                if(!CPSHelper.isEmpty(userInfo)){
                    userName = userInfo.getDisplayName();
                }
            }
        }catch( UsernameNotFoundException e){
            LOG.error("getDisplayNameByUserId UsernameNotFoundException"+e);
        }catch(DataAccessException e){
            LOG.error("getDisplayNameByUserId DataAccessException"+e);
        }catch (Exception e) {
            LOG.error("getDisplayNameByUserId Exception"+e);
        }
        return userName;
    }/**
     * Inits the matrix margin map.
     *
     * @param candidateForm
     *            the candidate form
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private void initMatrixMarginMap(AddNewCandidate candidateForm) throws CPSGeneralException {
        String criticalItem = CPSConstants.EMPTY_STRING;
        String subComCode = CPSConstants.EMPTY_STRING;
        String matrixMargin = CPSConstants.EMPTY_STRING;
        if (null != candidateForm.getProductVO().getRetailVO()) {
            if (CPSHelper.isNotEmpty(candidateForm.getProductVO().getRetailVO().getRetailRadio())
                    && "matrixMargin".equals(candidateForm.getProductVO().getRetailVO().getRetailRadio())) {
                matrixMargin = candidateForm.getProductVO().getRetailVO().getRetailRadio();
            }
        }
        if (null != candidateForm.getProductVO().getRetailVO())
            criticalItem = candidateForm.getProductVO().getRetailVO().getCriticalItem();
        if (null != candidateForm.getProductVO().getClassificationVO())
            subComCode = candidateForm.getProductVO().getClassificationVO().getSubCommodity();
        if (CPSHelper.isNotEmpty(criticalItem) && CPSHelper.isNotEmpty(subComCode)
                && CPSHelper.isNotEmpty(matrixMargin)) {
            this.getMarginPercent(criticalItem, subComCode, candidateForm);
        }
    }
    /**
     * Gets the margin percent.
     *
     * @param criticalItem
     *            the critical item
     * @param subComCode
     *            the sub com code
     * @param candidateForm
     *            the candidate form
     * @return the margin percent
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    public String getMarginPercent(String criticalItem, String subComCode, AddNewCandidate candidateForm)
            throws CPSGeneralException {

        String margin = CPSConstants.EMPTY_STRING;
        String maxMargin = CPSConstants.EMPTY_STRING;
        String minMargin = CPSConstants.EMPTY_STRING;

        String subComCd = CPSHelper.getTrimmedValue(subComCode);

        Map<String, List<BigDecimal>> marginMap = getAddNewCandidateService().getMatrixMarginList(subComCd, null);

        List<BigDecimal> normalList = marginMap.get(BusinessConstants.NORMAL_QTY);
        List<BigDecimal> seasonalList = marginMap.get(BusinessConstants.SEASONAL_QTY);
        List<BigDecimal> profitList = marginMap.get(BusinessConstants.PROFIT_QTY);

        if (BusinessConstants.NORMAL_QTY.equalsIgnoreCase(criticalItem) && CPSHelper.isNotEmpty(normalList)) {
            maxMargin = CPSHelper.getStringValue(CPSHelper.getMaxPercentage(normalList));
            minMargin = CPSHelper.getStringValue(CPSHelper.getMinPercentage(normalList));
            candidateForm.setMaxMargin(maxMargin);
            candidateForm.setMinMargin(minMargin);

            margin = CPSHelper.getStringValue(CPSHelper.findMode(normalList));

            candidateForm.getProductVO().getRetailVO().setMarginPercent(CPSHelper.getIntegerValue(margin));
        }

        if (BusinessConstants.SEASONAL_QTY.equalsIgnoreCase(criticalItem) && CPSHelper.isNotEmpty(seasonalList)) {
            maxMargin = CPSHelper.getStringValue(CPSHelper.getMaxPercentage(seasonalList));
            minMargin = CPSHelper.getStringValue(CPSHelper.getMinPercentage(seasonalList));
            candidateForm.setMaxMargin(maxMargin);
            candidateForm.setMinMargin(minMargin);

            margin = CPSHelper.getStringValue(CPSHelper.findMode(seasonalList));

            candidateForm.getProductVO().getRetailVO().setMarginPercent(CPSHelper.getIntegerValue(margin));
        }
        if (BusinessConstants.PROFIT_QTY.equalsIgnoreCase(criticalItem) && CPSHelper.isNotEmpty(profitList)) {
            maxMargin = CPSHelper.getStringValue(CPSHelper.getMaxPercentage(profitList));
            minMargin = CPSHelper.getStringValue(CPSHelper.getMinPercentage(profitList));
            candidateForm.setMaxMargin(maxMargin);
            candidateForm.setMinMargin(minMargin);

            margin = CPSHelper.getStringValue(CPSHelper.findMode(profitList));

            candidateForm.getProductVO().getRetailVO().setMarginPercent(CPSHelper.getIntegerValue(margin));
        }

        return margin;
    }
    /**
     *
     * @param caseVOs
     * @param candidateForm
     * @return
     */
    private void setEdcForItems(List<CaseVO> caseVOs, AddNewCandidate candidateForm) {
        Map<String, Boolean> mapValueEdcViewProd = new HashMap<String, Boolean>();
        Map<String, Boolean> mapValueEdcEditProd = new HashMap<String, Boolean>();
        for (CaseVO caseVO : caseVOs) {
            if (candidateForm.isViewProduct() == true && null != caseVO.getItemId()) {
                mapValueEdcViewProd.put(caseVO.getItemId().toString(), false);
            } else {
                if(caseVO.getPsItemId()!=null) {
                    mapValueEdcEditProd.put(caseVO.getPsItemId().toString(), false);
                }
            }
        }
        if (!mapValueEdcViewProd.isEmpty()) {
            mapValueEdcViewProd = CommonBridge.getAddNewCandidateServiceInstance()
                    .checkProdHasEdcInRelatedItems(mapValueEdcViewProd, true);
        } else if (!mapValueEdcEditProd.isEmpty()) {
            mapValueEdcEditProd = CommonBridge.getAddNewCandidateServiceInstance()
                    .checkProdHasEdcInRelatedItems(mapValueEdcEditProd, false);
        }
        for (CaseVO caseVO : caseVOs) {
            if (candidateForm.isViewProduct() == true && null != caseVO.getItemId()) {
                if (mapValueEdcViewProd.containsKey(caseVO.getItemId().toString())) {
                    if (mapValueEdcViewProd.get(caseVO.getItemId().toString())) {
                        CPSHelper.setChannelForMorph(caseVO);
                    }
                }
            } else {
                if (caseVO.getPsItemId()!=null && mapValueEdcEditProd.containsKey(caseVO.getPsItemId().toString())) {
                    if (mapValueEdcEditProd.get(caseVO.getPsItemId().toString())) {
                        CPSHelper.setChannelForMorph(caseVO);
                    }
                }
            }
        }
    }

    /**
     * Map check boxes in product and upc page.
     *
     * @param request
     *            the request
     * @param form
     *            the form
     */
    private void mapCheckBoxesInProductAndUPCPage(HttpServletRequest request, AddNewCandidate form) {
        if (form.isViewMode() == false) {
            ProductVO productVO = form.getProductVO();
            String foodstamp = (String) request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION);
            if (CPSHelper.isEmpty(foodstamp)) {
                String foodStampAttribute = request.getParameter("productVO.pointOfSaleVO.foodStamp");
                if (foodStampAttribute != null && CPSConstant.STRING_TRUE.equals(foodStampAttribute)) {
                    productVO.getPointOfSaleVO().setFoodStamp(true);
                } else {
                    productVO.getPointOfSaleVO().setFoodStamp(false);
                }
            } else {
                if (foodstamp != null && CPSConstant.STRING_TRUE.equals(foodstamp)) {
                    productVO.getPointOfSaleVO().setFoodStamp(true);
                } else {
                    productVO.getPointOfSaleVO().setFoodStamp(false);
                }
            }
            String drugFactPanel = (String) request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION);
            if (CPSHelper.isEmpty(drugFactPanel)) {
                String drugFactPanelAttribute = request.getParameter("productVO.pointOfSaleVO.drugFactPanel");
                if (drugFactPanelAttribute != null && CPSConstant.STRING_TRUE.equals(drugFactPanelAttribute)) {
                    productVO.getPointOfSaleVO().setDrugFactPanel(true);
                } else {
                    productVO.getPointOfSaleVO().setDrugFactPanel(false);
                }
            } else {
                if (drugFactPanel != null && CPSConstant.STRING_TRUE.equals(drugFactPanel)) {
                    productVO.getPointOfSaleVO().setDrugFactPanel(true);
                } else {
                    productVO.getPointOfSaleVO().setDrugFactPanel(false);
                }
            }

            String taxable = (String) request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION);
            if (CPSHelper.isEmpty(taxable)) {
                String taxableAttribute = request.getParameter("productVO.pointOfSaleVO.taxable");
                if (taxableAttribute != null && CPSConstant.STRING_TRUE.equals(taxableAttribute)) {
                    productVO.getPointOfSaleVO().setTaxable(true);
                } else {
                    productVO.getPointOfSaleVO().setTaxable(false);
                }
            } else {
                if (taxable != null && CPSConstant.STRING_TRUE.equals(taxable)) {
                    productVO.getPointOfSaleVO().setTaxable(true);
                } else {
                    productVO.getPointOfSaleVO().setTaxable(false);
                }
            }
            // trungnv fix pim 482

            String fsa = (String) request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION);
            if (CPSHelper.isEmpty(fsa)) {
                String fsaAttribute = request.getParameter("productVO.pointOfSaleVO.fsa");
                if (fsaAttribute != null && CPSConstant.STRING_TRUE.equals(fsaAttribute)) {
                    productVO.getPointOfSaleVO().setFsa(true);
                } else {
                    productVO.getPointOfSaleVO().setFsa(false);
                }
            } else {
                if (fsa != null && CPSConstant.STRING_TRUE.equals(fsa)) {
                    productVO.getPointOfSaleVO().setFsa(true);
                } else {
                    productVO.getPointOfSaleVO().setFsa(false);
                }
            }

            String quantityRestricted = (String) request.getSession()
                    .getAttribute(CPSConstants.CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION);
            if (CPSHelper.isEmpty(quantityRestricted)) {
                String quantityRestrictedAttribute = request.getParameter("productVO.pointOfSaleVO.qntityRestricted");
                if (quantityRestrictedAttribute != null
                        && CPSConstant.STRING_TRUE.equals(quantityRestrictedAttribute)) {
                    productVO.getPointOfSaleVO().setQntityRestricted(true);
                } else {
                    productVO.getPointOfSaleVO().setQntityRestricted(false);
                }
            } else {
                if (quantityRestricted != null && CPSConstant.STRING_TRUE.equals(quantityRestricted)) {
                    productVO.getPointOfSaleVO().setQntityRestricted(true);
                } else {
                    productVO.getPointOfSaleVO().setQntityRestricted(false);
                }
            }
            String soldByWeight = (String) request.getSession().getAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION);
            if (CPSHelper.isEmpty(soldByWeight)) {
                String soldByWeightAttribute = request.getParameter("productVO.retailVO.weightFlag");
                if (soldByWeightAttribute != null && CPSConstant.STRING_TRUE.equals(soldByWeightAttribute)) {
                    productVO.getRetailVO().setWeightFlag(true);
                } else {
                    productVO.getRetailVO().setWeightFlag(false);
                }
            } else {
                if (soldByWeight != null && CPSConstant.STRING_TRUE.equals(soldByWeight)) {
                    productVO.getRetailVO().setWeightFlag(true);
                } else {
                    productVO.getRetailVO().setWeightFlag(false);
                }
            }

            String mechtenz = (String) request.getSession().getAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION);
            if (CPSHelper.isEmpty(mechtenz)) {
                String mechtenzAttribute = request.getParameter("productVO.scaleVO.mechTenz");
                if (mechtenzAttribute != null && CPSConstant.STRING_TRUE.equals(mechtenzAttribute)) {
                    productVO.getScaleVO().setMechTenz(true);
                } else {
                    productVO.getScaleVO().setMechTenz(false);
                }
            } else {
                if (mechtenz != null && CPSConstant.STRING_TRUE.equals(mechtenz)) {
                    productVO.getScaleVO().setMechTenz(true);
                } else {
                    productVO.getScaleVO().setMechTenz(false);
                }
            }

            String showClrsSw = (String) request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION);
            if (CPSHelper.isEmpty(showClrsSw)) {
                showClrsSw = request.getParameter("productVO.pointOfSaleVO.showClrsSw");
                if (showClrsSw != null && CPSConstant.STRING_TRUE.equals(showClrsSw)) {
                    productVO.getPointOfSaleVO().setShowClrsSw(true);
                } else {
                    productVO.getPointOfSaleVO().setShowClrsSw(false);
                }
            } else {
                if (showClrsSw != null && CPSConstant.STRING_TRUE.equals(showClrsSw)) {
                    productVO.getPointOfSaleVO().setShowClrsSw(true);
                } else {
                    productVO.getPointOfSaleVO().setShowClrsSw(false);
                }
            }
        }
    }
    /**
     * Validate expected date.
     *
     * @param dateN
     *            the date n
     * @return true, if successful
     */
    private boolean validateExpectedDate(String dateN) {
        try {
            if (CPSHelper.isNotEmpty(dateN)) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date();
                Date dateNew;
                dateNew = dateFormat.parse(dateN);
                if (dateFormat.format(dateNew).compareTo(dateFormat.format(date)) < 0) {
                    return false;
                }
            }
        } catch (ParseException e) {
            return false;
        }
        return true;
    }
    /**
     * Validate save return.
     *
     * @param candidateForm
     *            the candidate form
     * @return true, if successful
     * @throws CPSBusinessException
     *             the CPS business exception
     */
    private boolean validateSaveReturn(AddNewCandidate candidateForm) throws CPSBusinessException {
        // cannot set tabIndex in this position comment 27/4/2016
        // candidateForm.setTabIndex(CPSAddCandidateForm.TAB_PROD_UPC);
        candidateForm.setAddCandidateMode();
        String ingSwt = CPSConstants.EMPTY_STRING;
        ingSwt = candidateForm.getScaleAttrib();
        if ("I".equalsIgnoreCase(ingSwt)) {
            candidateForm.getProductVO().getScaleVO().setIngredientSw(CPSConstant.CHAR_Y);
        } else {
            candidateForm.getProductVO().getScaleVO().setIngredientSw(CPSConstant.CHAR_N);
        }

        if (ProductVOHelper.isMandatoryFieldsEntered(candidateForm.getProductVO())) {
            return false;
        }
        return true;
    }

    /**
     * Gets the selected case vo.
     *
     * @param candidateForm
     *            the candidate form
     * @return the selected case vo
     */
    private CaseVO getSelectedCaseVO(AddNewCandidate candidateForm) {
        CaseVO caseVO = null;
        if (candidateForm.getCaseVO() != null) {
            caseVO = candidateForm.getCaseVO();
        }
        if (caseVO == null) {
            caseVO = new CaseVO();
        }
        List<CaseUPCVO> caseUPCs = new ArrayList<CaseUPCVO>();
        List<UPCVO> upcs = candidateForm.getProductVO().getUpcVO();
        int totalUPCs = upcs.size();
        for (UPCVO upcvo : upcs) {
            CaseUPCVO caseUPCVO = caseVO.getCaseUPCVO(upcvo.getUnitUpc());
            if (caseUPCVO != null) {
                caseUPCs.add(caseUPCVO);
            } else {
                caseUPCVO = new CaseUPCVO();
                caseUPCVO.setUnitUpc(upcvo.getUnitUpc());
                caseUPCVO.setUnitSize(upcvo.getUnitSize());
                caseUPCVO.setUnitMeasureDesc(upcvo.getUnitMeasureDesc());
                caseUPCVO.setLinked(false);
                caseUPCVO.setPrimary(false);
                if (totalUPCs == 1) {
                    caseUPCVO.setLinked(true);
                    caseUPCVO.setPrimary(true);
                }
                caseUPCVO.setNewDataSw(upcvo.getNewDataSw());
                caseUPCs.add(caseUPCVO);
            }
        }
        caseVO.clearCaseUPCVOs();
        for (CaseUPCVO caseUPC : caseUPCs) {
            caseVO.addCaseUPCVO(caseUPC);
        }
        return caseVO;
    }
    /**
     * Sets the data session boxes in product and upc page.
     *
     * @param request
     *            the request
     * @param form
     *            the form
     */
    private void setDataSessionBoxesInProductAndUPCPage(HttpServletRequest request, AddNewCandidate form) {
        if (form.isViewMode() == false) {
            Object foodstampSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION);
            Object drugPanelSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION);
            Object taxbleSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION);
            Object qntityRestrictedSession = request.getSession()
                    .getAttribute(CPSConstants.CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION);
            Object abusiveVolatileChemicalSession = request.getSession()
                    .getAttribute(CPSConstants.CPS_POINTOFSALEVO_ABUSIVEVOLATILECHEMICAL_SESSION);
            Object weightFlagSession = request.getSession().getAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION);
            Object fsaSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION);
            Object mechtenzSession = request.getSession().getAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION);
            Object showClrsSwSession = request.getSession().getAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION);
            if (foodstampSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION);
            if (drugPanelSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION);
            if (taxbleSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION);
            if (qntityRestrictedSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION);
            if (abusiveVolatileChemicalSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_ABUSIVEVOLATILECHEMICAL_SESSION);
            if (weightFlagSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION);
            if (fsaSession != null)
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION);
            if (mechtenzSession != null) {
                request.getSession().removeAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION);
            }
            if(showClrsSwSession != null) {
                request.getSession().removeAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION);
            }
            String foodStamp = request.getParameter("productVO.pointOfSaleVO.foodStamp");
            if (foodStamp != null && CPSConstant.STRING_TRUE.equals(foodStamp)) {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_FOODSTAMP_SESSION, CPSConstant.STRING_FALSE);
            }

            String drugFactPanel = request.getParameter("productVO.pointOfSaleVO.drugFactPanel");
            if (drugFactPanel != null && CPSConstant.STRING_TRUE.equals(drugFactPanel)) {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_DRUGPANEL_SESSION, CPSConstant.STRING_FALSE);
            }

            String taxable = request.getParameter("productVO.pointOfSaleVO.taxable");
            if (taxable != null && CPSConstant.STRING_TRUE.equals(taxable)) {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_TAXABLE_SESSION, CPSConstant.STRING_FALSE);
            }

            String quantityRestricted = request.getParameter("productVO.pointOfSaleVO.qntityRestricted");
            if (quantityRestricted != null && CPSConstant.STRING_TRUE.equals(quantityRestricted)) {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_QNTITYRESTRICTED_SESSION, CPSConstant.STRING_FALSE);
            }

            String soldByWeight = request.getParameter("productVO.retailVO.weightFlag");
            if (soldByWeight != null && CPSConstant.STRING_TRUE.equals(soldByWeight)) {
                request.getSession().setAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_RETAILVO_WEIGHTFLAG_SESSION, CPSConstant.STRING_FALSE);
            }

            // trungnv fix pim 482

            String fsa = request.getParameter("productVO.pointOfSaleVO.fsa");
            if (fsa != null && CPSConstant.STRING_TRUE.equals(fsa)) {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_FSA_SESSION, CPSConstant.STRING_FALSE);
            }

            String mechtenz = request.getParameter("productVO.scaleVO.mechTenz");
            if (mechtenz != null && CPSConstant.STRING_TRUE.equals(mechtenz)) {
                request.getSession().setAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_SCALEATTR_MECHTENZ_SESSION, CPSConstant.STRING_FALSE);
            }

            String showClrsSw = request.getParameter("productVO.pointOfSaleVO.showClrsSw");
            if (showClrsSw != null && CPSConstant.STRING_TRUE.equals(showClrsSw)) {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION, CPSConstant.STRING_TRUE);
            } else {
                request.getSession().setAttribute(CPSConstants.CPS_POINTOFSALEVO_SHOWCLRSSW_SESSION, CPSConstant.STRING_FALSE);
            }
        }
    }
    /**
     * When clicking Next button from questionnaire page and from Auth &
     * distribution tab.
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_SAVE_DETAILS)
    public ModelAndView saveDetails(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate,
                                    HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
        addNewCandidate.setUserRole(this.getUserRole());

        //merge list of upc has been save on session into current candidate.
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        setForm(req, addNewCandidate);
        try {
            // Dont change anything if it is activate flow.
            if (AddNewCandidate.TAB_PROD_UPC == addNewCandidate.getTabIndex()) {
                setDataSessionBoxesInProductAndUPCPage(req, addNewCandidate);
            }
            if (AddNewCandidate.TAB_NEW_AUTH != addNewCandidate.getTabIndex()) {
                this.mapCheckBoxesInProductAndUPCPage(req, addNewCandidate);
            }
            // Setting the brand to Un-assigned if product type is Non-Sellable
            //if (CPSConstant.SPLY.equalsIgnoreCase(candidateForm.getProductVO().getClassificationVO().getProductType())) {
            if (null == addNewCandidate.getProductVO().getClassificationVO().getBrand()
                    || CPSConstants.EMPTY_STRING.equals(addNewCandidate.getProductVO().getClassificationVO().getBrand()) || CPSHelper.isEmpty(addNewCandidate.getProductVO().getClassificationVO().getBrandName())) {
                addNewCandidate.getProductVO().getClassificationVO().setBrand(CPSConstant.STRING_0);
                addNewCandidate.getProductVO().getClassificationVO().setBrandName(CPSConstant.UNASSIGNED);
            }
            //}
            //SPRINT 22
            //addNewCandidate.setUnitsOfMeasure(getUOMFromSubCommodity(addNewCandidate.getUnitsOfMeasure(), addNewCandidate.getProductVO().getClassificationVO().getSubCommodity()));
            addNewCandidate.setUnitsOfMeasure(getUnitOfMeasureList(addNewCandidate.getProductVO().getClassificationVO().getSubCommodity()));
            // validating before save
            if (!addNewCandidate.getProductVO().isModifiedProd()) {
                if (!validateSaveReturn(addNewCandidate)) {
                    getDetails(addNewCandidate, req);
                    CPSMessage message = new CPSMessage("Please enter the mandatory fields.", CPSMessage.ErrorSeverity.VALIDATION);
                    saveMessage(addNewCandidate, message);
                    model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
                    return model;
                }

            } else {
                String ingSwt = addNewCandidate.getScaleAttrib();
                if ("I".equalsIgnoreCase(ingSwt)) {
                    addNewCandidate.getProductVO().getScaleVO().setIngredientSw('Y');
                } else {
                    addNewCandidate.getProductVO().getScaleVO().setIngredientSw('N');
                }
            }
            if (CPSConstant.HEB.equals(addNewCandidate.getProductVO().getPharmacyVO().getDrugNmCd())) {
                addNewCandidate.getProductVO().getPharmacyVO().setDrugNmCd(CPSConstants.EMPTY_STRING);
            }
            String userRole = getUserRole();
            if (null != addNewCandidate.getProductVO().getScaleVO()) {
                if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getScaleVO().getForceTare())
                        || (CPSConstant.STRING_0).equals(addNewCandidate.getProductVO().getScaleVO().getForceTare())) {
                    addNewCandidate.getProductVO().getScaleVO().setForceTare(CPSConstant.STRING_N);
                } else if ((CPSConstant.STRING_1).equals(addNewCandidate.getProductVO().getScaleVO().getForceTare())) {
                    addNewCandidate.getProductVO().getScaleVO().setForceTare(CPSConstant.STRING_Y);
                }
            }
            // Fixed QC-9(CPS Update)
            if (CPSHelper.isNotEmpty(addNewCandidate.getSavedProductVO().getOriginSellingRestriction())) {
                PointOfSaleVO pointOfS = ProductEntityConverter
                        .convertJson1ToVO(addNewCandidate.getSavedProductVO().getOriginSellingRestriction());
                addNewCandidate.getSavedProductVO().getPointOfSaleVO().setLstRating(pointOfS.getLstRating());
                addNewCandidate.getSavedProductVO().getPointOfSaleVO()
                        .setLstSellingRestrictions(pointOfS.getLstSellingRestrictions());
                addNewCandidate.getSavedProductVO().getPointOfSaleVO().setOffPermise(pointOfS.getOffPermise());
            }
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getJsonSellingRestriction())) {
                PointOfSaleVO pointOfS = JsonOrgConverter
                        .convertJsonToVO(addNewCandidate.getProductVO().getJsonSellingRestriction());
                addNewCandidate.getProductVO().getPointOfSaleVO().setLstRating(pointOfS.getLstRating());
                addNewCandidate.getProductVO().getPointOfSaleVO()
                        .setLstSellingRestrictions(pointOfS.getLstSellingRestrictions());
                addNewCandidate.getProductVO().getPointOfSaleVO().setOffPermise(pointOfS.getOffPermise());

            } else {
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getOriginSellingRestriction())) {
                    PointOfSaleVO pointOfS = ProductEntityConverter
                            .convertJson1ToVO(addNewCandidate.getProductVO().getOriginSellingRestriction());
                    addNewCandidate.getProductVO().getPointOfSaleVO().setLstRating(pointOfS.getLstRating());
                    addNewCandidate.getProductVO().getPointOfSaleVO()
                            .setLstSellingRestrictions(pointOfS.getLstSellingRestrictions());
                    addNewCandidate.getProductVO().getPointOfSaleVO().setOffPermise(pointOfS.getOffPermise());
                }
            }
            // convert string json to object selling before save
            if (addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_N) {
                // Fix 1198. ignore if mrt product
                if (!addNewCandidate.isMrtActiveProduct()) {
                    if (ProductVOHelper.entitySaved(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO(),
                            addNewCandidate.getTabIndex())) {
                        ProductVO preservedProduct = addNewCandidate.getProductVO();
                        if (ProductVOHelper.pssChanged(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO())) {
                            if (addNewCandidate.getVendorVO().getPssDept() != null
                                    && !CPSConstants.EMPTY_STRING.equals(addNewCandidate.getVendorVO().getPssDept().trim())) {
                                addNewCandidate.getVendorVO()
                                        .setPssDept(addNewCandidate.getProductVO().getPointOfSaleVO().getPssDept());
                            }
                        }
                        // Fix 1197
                        UserInfo userInfo = getUserInfo();
                        WorkRequest workRqst = addNewCandidate.getProductVO().getWorkRequest();
                        workRqst.setVendorEmail(userInfo.getMail());
                        String phone = userInfo.getAttributeValue("telephoneNumber");
                        if (phone != null) {
                            phone = CPSHelper.cleanPhoneNumber(phone);
                            if (phone.length() >= 10) {
                                workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                                workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                            } else {
                                workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                                workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
                            }
                        }
                        workRqst.setCandUpdtUID(userInfo.getUid());
                        workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
                        workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
                        ProductVO savedProductVo = getAddNewCandidateService().saveProductAndCaseDetails(
                                addNewCandidate.getProductVO(), addNewCandidate.getQuestionnarieVO(), userRole);
                        savedProductVo.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
                        savedProductVo.setModifiedProd(true);
                        addNewCandidate.setProductVO(savedProductVo);
                        saveStoresForVendors(addNewCandidate, preservedProduct);
                        this.afterSave(addNewCandidate, addNewCandidate.getProductVO(), req);
                        clearMessages(addNewCandidate);
                    } else {
                        addNewCandidate.getProductVO().setOriginSellingRestriction(addNewCandidate.getProductVO().getJsonSellingRestriction());
                    }
                    CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_SAVED_SUCCESSFULLY, CPSMessage.ErrorSeverity.INFO);
                    saveMessage(addNewCandidate, message);
                }
            }
            // not mrt active product
            else {
                if (ProductVOHelper.entitySaved(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO(),
                        addNewCandidate.getTabIndex())) {
                    preSave(addNewCandidate);
                    ProductVO savedProductVo = new ProductVO();
                    ProductVO toBeSaved = addNewCandidate.getProductVO();
                    if (ProductVOHelper.pssChanged(addNewCandidate.getProductVO(), addNewCandidate.getSavedProductVO())) {
                        if (addNewCandidate.getVendorVO().getPssDept() != null
                                && !CPSConstants.EMPTY_STRING.equals(addNewCandidate.getVendorVO().getPssDept().trim())) {
                            addNewCandidate.getVendorVO()
                                    .setPssDept(addNewCandidate.getProductVO().getPointOfSaleVO().getPssDept());
                        }
                    }
                    ScaleVO scaleVO = toBeSaved.getScaleVO();

                    if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getCopiedProdid())) {
                        // Fix 1223
                        if (!addNewCandidate.getProductVO().isCopiedProductSaved()) {
                            // Set the dept and sub-dept
                            if (null != toBeSaved.getClassificationVO().getCommodity() && null != addNewCandidate
                                    .getClassCommodityVO(toBeSaved.getClassificationVO().getCommodity())) {
                                String deptNbr = addNewCandidate
                                        .getClassCommodityVO(toBeSaved.getClassificationVO().getCommodity()).getDeptId();
                                String subDeptNbdr = addNewCandidate
                                        .getClassCommodityVO(toBeSaved.getClassificationVO().getCommodity()).getSubDeptId();
                                toBeSaved.setDept(deptNbr);
                                toBeSaved.setSubDept(subDeptNbdr);
                            }
                        }
                        savedProductVo = getAddNewCandidateService().saveProductAndCaseDetails(toBeSaved,
                                addNewCandidate.getQuestionnarieVO(), userRole);
                        savedProductVo.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
                        // Fix 1223
                        if (!addNewCandidate.getProductVO().isCopiedProductSaved()) {
                            toBeSaved.setCopiedProductSaved(true);
                            savedProductVo.setCopiedProductSaved(true);
                        }
                        savedProductVo.setModifiedProd(true);
                    } else {
                        // Fix 1197
                        UserInfo userInfo = getUserInfo();
                        WorkRequest workRqst = toBeSaved.getWorkRequest();
                        workRqst.setVendorEmail(userInfo.getMail());
                        String phone = userInfo.getAttributeValue("telephoneNumber");
                        if (phone != null) {
                            phone = CPSHelper.cleanPhoneNumber(phone);
                            if (phone.length() >= 10) {
                                workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                                workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                            } else {
                                workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                                workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
                            }
                        }
                        workRqst.setCandUpdtUID(userInfo.getUid());
                        workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
                        workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
                        savedProductVo = getAddNewCandidateService().saveProductDetails(toBeSaved, userRole);
                        savedProductVo.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
                        // savedProductVo.setCompareRating(toBeSaved.getCompareRating());
                    }

                    this.afterSave(addNewCandidate, savedProductVo, toBeSaved, scaleVO, req);
                }
            }
            if (!(addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_Y && !addNewCandidate.getProductVO().getPointOfSaleVO().isShowClrsSw())) {
                //BAU-Feb-PIM-1608-Nutrition Facts--Get information
                List<BigInteger> unitUPCs = new ArrayList<BigInteger>();
                Map<BigInteger, String> mapUnitUPC = new HashMap<BigInteger, String>();
                Integer psWrkId = CPSConstant.NUMBER_0;
                if (!CPSHelper.isEmpty(addNewCandidate.getProductVO().getUpcVO())) {
                    for (UPCVO upcVO : addNewCandidate.getProductVO().getUpcVO()) {
                        if (!CPSHelper.isEmpty(upcVO) && upcVO.getNewDataSw() == CPSConstant.CHAR_Y) {
                            BigInteger upc = BigInteger.valueOf(Long.valueOf(CPSHelper.getTrimmedValue(upcVO.getUnitUpc())));
                            unitUPCs.add(upc);
                            mapUnitUPC.put(upc, CPSHelper.getTrimmedValue(upcVO.getUnitUpc()));
                        }
                    }
                    psWrkId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
                }
                this.getAddNewCandidateService().getNutritionFactsInformation(addNewCandidate.getProductVO(), unitUPCs, psWrkId, mapUnitUPC);
                if (!CPSHelper.isEmpty(addNewCandidate.getProductVO().getApprByUserId())) {
                    addNewCandidate.getProductVO().setApprByUserName(getDisplayNameByUserId(addNewCandidate.getProductVO().getApprByUserId()));
                }
            }
        }catch (CPSSystemException e){
            LOG.error(e.getMessage(), e);
            saveMessage(addNewCandidate, e.getCPSMessage());
        }catch (CPSBusinessException ex) {
        	LOG.error(ex.getMessage(), ex);
            saveMessage(addNewCandidate, ex.getMessages().get(0));
		}
        //return
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    /**
     * Sets the item code.
     *
     * @param mrtVO
     *            the mrt vo
     * @param productVO
     *            the product vo
     */
    private void setItemCode(MRTUPCVO mrtVO, ProductVO productVO) {
        int caseVOSize = 0;
        caseVOSize = productVO.getCaseVOs().size();
        if (0 == caseVOSize) {
            mrtVO.setItemCode(CPSConstants.EMPTY_STRING);
        } else {
            // Check whether the case having more than one records
            if (caseVOSize > 1) {
                mrtVO.setItemCode(CPSConstants.MULTIPLE);
            } else {
                // Check whether the case is DSD or NOT
                if (productVO.getCaseVOs().get(0).getChannelVal().trim().equalsIgnoreCase(CPSConstants.CHANNEL_DSD)) {
                    mrtVO.setItemCode(CPSConstants.CHANNEL_DSD);
                } else {
                    mrtVO.setItemCode(CPSHelper.getStringValue(productVO.getCaseVOs().get(0).getItemId()));
                }
            }
        }
    }

    /**
     * Sets the vendor list for mrt.
     *
     * @param mrtList
     *            the mrt list
     * @param candidateForm
     *            the candidate form
     * @param caseVO
     *            the case vo
     * @param req
     *            the req
     * @return the list
     * @throws Exception
     *             the exception
     */
    private List<VendorLocationVO> setVendorListForMRT(List<MRTUPCVO> mrtList, AddNewCandidate candidateForm,
                                                       CaseVO caseVO, HttpServletRequest req) throws Exception {
        List<VendorLocationVO> vos = new ArrayList<VendorLocationVO>();
        for (MRTUPCVO mrtupcvo : mrtList) {
            if (CPSHelper.isNotEmpty(mrtupcvo.getDescription())
                    && !mrtupcvo.getDescription().equalsIgnoreCase(CPSConstants.NO_DESCRIPTION)
                    && !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())
                    && !(CPSConstants.EMPTY_STRING).equals(mrtupcvo.getDescription())) {
                try {
                    candidateForm.setProductVO(mrtupcvo.getProductVO());
                    try {
                        initProductVO(mrtupcvo, candidateForm);
                    } catch (Exception e) {
                        LOG.error(e.getMessage(), e);
                    }
                    vos.addAll(setVendorValuesForMRT(caseVO, mrtupcvo, candidateForm, req));
                    // break;
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                }
            }
        }
        return vos;
    }
    /**
     * Inits the product vo.
     *
     * @param mrtupcvo
     *            the mrtupcvo
     * @param form
     *            the form
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private void initProductVO(MRTUPCVO mrtupcvo, AddNewCandidate form) throws CPSGeneralException {
        ProductVO productVO = mrtupcvo.getProductVO();
        Map<String, ClassCommodityVO> existingMap = form.getClassCommodityMap();

        Map<String, ClassCommodityVO> map = getCommonService()
                .getCommoditiesForBDM(productVO.getClassificationVO().getAlternateBdm());

        if (CPSHelper.isNotEmpty(existingMap)) {
            if (CPSHelper.isEmpty(map)) {
                map = new HashMap<String, ClassCommodityVO>();
            }
            map.putAll(existingMap);
        }
        form.setClassCommodityMap(map);
        initClassField(form);
    }
    // @SuppressWarnings("unchecked")
    /**
     * Sets the vendor values for mrt.
     *
     * @param caseVO
     *            the case vo
     * @param mrtupcvo
     *            the mrtupcvo
     * @param addCandidateForm
     *            the add candidate form
     * @param req
     *            the req
     * @return the list
     * @throws Exception
     *             the exception
     */
    private List<VendorLocationVO> setVendorValuesForMRT(CaseVO caseVO, MRTUPCVO mrtupcvo,
                                                         AddNewCandidate addCandidateForm, HttpServletRequest req) throws Exception {
        List<VendorLocationVO> vos = new ArrayList<VendorLocationVO>();
        try {
            String chnlVal = CPSWebUtil.getChannelValForService(caseVO.getChannelVal());

            String deptNbr = null;
            String subDeptNbdr = null;

            if (null != addCandidateForm.getProductVO().getClassificationVO().getCommodity() && null != addCandidateForm
                    .getClassCommodityVO(addCandidateForm.getProductVO().getClassificationVO().getCommodity())) {
                deptNbr = addCandidateForm
                        .getClassCommodityVO(addCandidateForm.getProductVO().getClassificationVO().getCommodity())
                        .getDeptId();
                subDeptNbdr = addCandidateForm
                        .getClassCommodityVO(addCandidateForm.getProductVO().getClassificationVO().getCommodity())
                        .getSubDeptId();
            }
            String classField = mrtupcvo.getProductVO().getClassificationVO().getClassField();
            String commodityVal = mrtupcvo.getProductVO().getClassificationVO().getCommodity();
            if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
                addCandidateForm.updateVendorList(deptNbr, subDeptNbdr, classField, null, chnlVal);
                if (BusinessUtil.isVendor(getUserRole())) {
                    vos = new ArrayList<VendorLocationVO>();
                    vos = addCandidateForm.getVendorVO().getVendorLocationList();
                } else {

                    List<VendorLocDeptVO> list = getCommonService().getVendorLocationListFromCache(deptNbr, subDeptNbdr,
                            mrtupcvo.getProductVO().getClassificationVO().getClassField(),
                            mrtupcvo.getProductVO().getClassificationVO().getCommodity(), chnlVal);
                    convertToVendorLocationVO(vos, list);

                }
            } else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {

                addCandidateForm.updateVendorList(null, null, classField, commodityVal, chnlVal);
                if (BusinessUtil.isVendor(getUserRole())) {
                    vos = new ArrayList<VendorLocationVO>();
                    vos = addCandidateForm.getVendorVO().getVendorLocationList();
                } else {
                    List<VendorLocDeptVO> list = getCommonService().getVendorLocationListFromCache(null, null,
                            mrtupcvo.getProductVO().getClassificationVO().getClassField(),
                            mrtupcvo.getProductVO().getClassificationVO().getCommodity(), chnlVal);
                    convertToVendorLocationVO(vos, list);
                }
            } else {
                addCandidateForm.updateVendorList(deptNbr, subDeptNbdr, classField, commodityVal, chnlVal);
                if (BusinessUtil.isVendor(getUserRole())) {
                    vos = new ArrayList<VendorLocationVO>();
                    vos = addCandidateForm.getVendorVO().getVendorLocationList();
                } else {
                    List<VendorLocDeptVO> list = getCommonService().getVendorLocationListFromCache(deptNbr, subDeptNbdr,
                            mrtupcvo.getProductVO().getClassificationVO().getClassField(),
                            mrtupcvo.getProductVO().getClassificationVO().getCommodity(), chnlVal);
                    convertToVendorLocationVO(vos, list);
                }
            }
            mrtupcvo.setSelected(true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            vos = new ArrayList<VendorLocationVO>();
        }
        return vos;
    }
    /**
     * Convert to vendor location vo.
     *
     * @param vos
     *            the vos
     * @param list
     *            the list
     */
    private void convertToVendorLocationVO(List<VendorLocationVO> vos, List<VendorLocDeptVO> list) {
        Iterator<VendorLocDeptVO> iterator = list.iterator();
        while (iterator.hasNext()) {
            VendorLocDeptVO vendorLocDeptVO = iterator.next();
            VendorLocationVO vendVO = new VendorLocationVO();
            vendVO.setVendorId(vendorLocDeptVO.getVendorLocationNumber().toString());
            vendVO.setName(vendorLocDeptVO.getLocationName());
            vendVO.setVendorLocationType(vendorLocDeptVO.getChannel());
            vos.add(vendVO);
        }
    }
    /**
     * Sets the cost owner values for mrt.
     *
     * @param addCandidateForm
     *            the add candidate form
     * @return the list
     */
    private List<BaseJSFVO> setCostOwnerValuesForMRT(AddNewCandidate addCandidateForm) {
        List<BaseJSFVO> mrtCostOwners = new ArrayList<BaseJSFVO>();
        List<MRTUPCVO> mrtList = addCandidateForm.getMrtvo().getMrtVOs();
        for (MRTUPCVO mrtupcvo : mrtList) {
            // Fix 1289. populate all cost owners
            if (CPSHelper.isNotEmpty(mrtupcvo.getDescription())
                    && !mrtupcvo.getDescription().equalsIgnoreCase(CPSConstants.NO_DESCRIPTION)
                    && !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())
                    && !(CPSConstants.EMPTY_STRING).equals(mrtupcvo.getDescription())) {
                try {
                    String brandId = mrtupcvo.getProductVO().getClassificationVO().getBrand();
                    if (CPSHelper.isNotEmpty(brandId)) {

                        Integer brand = CPSHelper.getIntegerValue(brandId);
                        List<BaseJSFVO> costOwners = getAddNewCandidateService().getCostOwnerbyBrand(brand);
                        if (CPSHelper.isNotEmpty(costOwners)) {
                            mrtCostOwners.addAll(costOwners);
                        }
                    }
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                }
            }
        }
        return CPSHelper.getUniqueList(mrtCostOwners);
    }
    /**
     * Sets the cost owner values for mrt.
     *
     * @param addCandidateForm
     *            the add candidate form
     * @param cstOwnId
     *            the cst own id
     * @return the list
     */
    private List<BaseJSFVO> setCostOwnerValuesForMRT(AddNewCandidate addCandidateForm, int cstOwnId) {
        List<BaseJSFVO> mrtCostOwners = new ArrayList<BaseJSFVO>();
        List<MRTUPCVO> mrtList = addCandidateForm.getMrtvo().getMrtVOs();
        for (MRTUPCVO mrtupcvo : mrtList) {
            // Fix 1289. populate all cost owners
            if (CPSHelper.isNotEmpty(mrtupcvo.getDescription())
                    && !mrtupcvo.getDescription().equalsIgnoreCase(CPSConstants.NO_DESCRIPTION)
                    && !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())
                    && !(CPSConstants.EMPTY_STRING).equals(mrtupcvo.getDescription())) {
                try {
                    // get cost owners from cst_own table
                    List<CstOwn> lstCostOwner = getCommonService().getCostOwners(cstOwnId);
                    if (CPSHelper.isNotEmpty(lstCostOwner)) {
                        for (CstOwn cstOwn : lstCostOwner) {
                            mrtCostOwners.add(new BaseJSFVO(CPSHelper.getStringValue(cstOwn.getCstOwnId()),
                                    cstOwn.getCstOwnNm()));
                        }
                    }
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                }
            }
        }
        return CPSHelper.getUniqueList(mrtCostOwners);
    }
    /**
     * When clicking Next button from questionnaire page and from Auth &
     * distribution tab.
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_POW)
    public ModelAndView pow( @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                    HttpServletResponse resp) throws Exception {
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String prodId = CPSConstant.STRING_0;
        if("4".equals(addNewCandidate.getSelectedOption())){
            addNewCandidate.setHidMrtSwitch(true);
        }
        // Check whether modify button is clicked from View mode
        String modifyFromView = req.getParameter("modifyFromView");
        if (null != modifyFromView) {
            if (CPSConstant.STRING_Y.equalsIgnoreCase(modifyFromView)) {
                if(addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier()==12) {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_KIT);
                    addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_KIT);
                } else {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_CANDIDATE);
                    addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_CANDIDATE);
                }
                addNewCandidate.setViewMode(false);
                addNewCandidate.setEnableTabs(true);
                addNewCandidate.setModifyMode(true);
                // be sure user can be add UPC in Edit Mode - Fix 1505
                addNewCandidate.setUpcAdded(true);
                if (addNewCandidate.isProduct()) {
                    addNewCandidate.clearViewProduct();
                }
                if (CPSConstants.WORKING_CODE.equalsIgnoreCase(addNewCandidate.getProductVO().getWorkRequest().getWorkStatusCode())
                        && CPSWebUtil.isVendor(getUserRole())) {
                    addNewCandidate.setViewOverRide();
                    setViewMode(addNewCandidate);
                    addNewCandidate.setEnableClose(false);
                } else if (CPSHelper.isN(addNewCandidate.getProductVO().getNewDataSw())) {
                    setViewMode(addNewCandidate);
                    addNewCandidate.setUpcViewOverRide();
                    addNewCandidate.setCaseViewOverRide();
                    addNewCandidate.setButtonViewOverRide();
                    addNewCandidate.setEnableClose(false);
                    addNewCandidate.setModifyProdCand(true);
                    addNewCandidate.setScaleViewOverRide();
                } else {
                    addNewCandidate.clearViewOverRide();
                    clearViewMode(addNewCandidate);
                    /* khoapkl */
                    addNewCandidate.setViewAddInforPage(true);
                }
            }
        }
        /**
         * Checking For MRT - Starts khoapkl
         */
        if (addNewCandidate.isHidMrtSwitch() == true) {
            addNewCandidate.getQuestionnarieVO().setSelectedOption("4");
            addNewCandidate.setViewAddInforPage(true);
        }
        if (!addNewCandidate.isViewProduct()) {
            if (!addNewCandidate.isNormalProduct() && !CPSConstant.STRING_Y.equalsIgnoreCase(modifyFromView)) {
                // validate MRT candidate when user wasn't saved MRT case
                if (CPSHelper.isEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                    CPSMessage message = new CPSMessage("Please enter the mandatory fields.", CPSMessage.ErrorSeverity.VALIDATION);
                    saveMessage(addNewCandidate, message);
                    if (addNewCandidate.isViewAddInforPage()) {
                        addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
                        addNewCandidate.setSelectedFunction(4);
                    }
                    model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                    return model;
                }
            } else {
                if (addNewCandidate.getTabIndex() == AddNewCandidate.TAB_PROD_UPC) {
                    setDataSessionBoxesInProductAndUPCPage(req, addNewCandidate);
                }
                if (!doSaveDetail(addNewCandidate, req, resp)) {
                    CPSMessage message = new CPSMessage("Please enter the mandatory fields.", CPSMessage.ErrorSeverity.VALIDATION);
                    /*if (AddNewCandidate.TAB_IMG_ATTR == addNewCandidate.getTabIndex()) {
                        if (addNewCandidate.getProductVO().getImageAttVO().isChangeImageExpectDt()) {
                            message = new CPSMessage(
                                    "Please enter a valid date, Expected date does not allow a past date.",
                                    CPSMessage.ErrorSeverity.VALIDATION);
                            addNewCandidate.getProductVO().getImageAttVO().setChangeImageExpectDt(false);
                        }
                    } else {
                        message = new CPSMessage("Please enter the mandatory fields.", CPSMessage.ErrorSeverity.VALIDATION);
                    }*/

                    saveMessage(addNewCandidate, message);
                    model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                    return model;
                } else {
                    addNewCandidate.clearViewProduct();
                }
            }
            // be sure data saved when user clicking on Next button or
            // switch tabs
            clearViewMode(addNewCandidate);
        }
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getProdId())
                && (CPSHelper.isEmpty(addNewCandidate.getProductVO().getPsProdId())
                || addNewCandidate.getProductVO().getPsProdId() == 0)) {
            setViewMode(addNewCandidate);
            // candidateForm.setUpcAdded(false);
        }
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getProdId())
                && addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_N) {
            setViewMode(addNewCandidate);
        }
        List<AuditTrailVO> auditTrailVo = getAddNewCandidateService()
                .getAuditTrailInfo(addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier());
        long primaryUPC = 0;
        if (!addNewCandidate.isProduct()) {
            primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
        } else {
            if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
            }
        }
        if (primaryUPC == 0) {
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPsProdId())) {
                prodId = CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId());
            } else if (CPSHelper.isNotEmpty(addNewCandidate.getSelectedProductId())
                    && CPSHelper.isEmpty(addNewCandidate.getProductVO().getProdId())) {
                prodId = addNewCandidate.getSelectedProductId();
            }
        }
        if (CPSHelper.isEmpty(prodId)) {
            prodId = CPSConstant.STRING_0;
        }
        addNewCandidate.getProductVO().getClassificationVO().setCommentOld(CPSConstants.EMPTY_STRING);
        List<CommentsVO> commentsVo = null;
        try{
            commentsVo = getAddNewCandidateService().fetchCommentHandle(prodId, getUserRole(), primaryUPC);
            addNewCandidate.getProductVO().setCommentsVO(commentsVo);
        }catch(Exception e){

        }
//		List<CommentsVO> commentsVo = getAddNewCandidateService().fetchCommentHandle(prodId, getUserRole(), primaryUPC);
        List<AttachmentVO>  lstAttachmentVOs = null;
        try{
            lstAttachmentVOs = getAddNewCandidateService().fetchAttachmentHandle(prodId, primaryUPC);
            addNewCandidate.getProductVO().setAttachmentVO(lstAttachmentVOs);
        }catch(Exception e){

        }
        initDocumentCategory(addNewCandidate);
        addNewCandidate.setAuditTrail(auditTrailVo);
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_POW);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    private void initDocumentCategory(AddNewCandidate candidateForm) {
        if (CPSHelper.isEmpty(candidateForm.getDocCatList())){
            candidateForm.setDocCatList(this.getAddNewCandidateService().getAllDocumentCategories());

        }
    }
    /**
     * This method keeps the tracking of the UPC if it is entered wrong more
     * than twice.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return ActionForward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_TRACK_ERROR_UPC)
    public ModelAndView trackErrorUPC(AddNewCandidate addNewCandidate, HttpServletRequest req,
                            HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String enteredUPC = req.getParameter("enteredUPC");
        String userId = getUserInfo().getUid();
        String workId = req.getParameter("workId");
        Integer psWorkId = (null != workId && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(workId)) ? Integer.parseInt(workId) : 0;
        Date dateCreated = new Date();

        // ckdgNbr will always be 2 as we are inserting after the second time of
        // wrong entry

        try {
            getAddNewCandidateService().trackErrorUPCDetails(enteredUPC, userId, psWorkId, dateCreated);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        return questionnaireWrapper(addNewCandidate, req, resp);
    }
    /**
     * shows the 'authorize whs' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_REQUEST_NEW_ATTRIBUTE)
    public ModelAndView requestNewAtt(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        ModelAndView model = new ModelAndView(RELATIVE_PATH_REQUEST_NEW_ATT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * shows the 'batch upload' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = RELATIVE_PATH_PSE_POPUP)
    public ModelAndView psePopup(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        addNewCandidate.setBatchUploadMode();
        if (req.getParameter("pseType") != null) {
            String pseTp = (String) req.getParameter("pseType");
            req.setAttribute("pseType", pseTp);
            if (CPSHelper.checkEqualValue(pseTp.trim(), "NO PSE")) {
                ProductVO vo = addNewCandidate.getProductVO();
                List<UPCVO> lstVo = vo.getUpcVO();
                for (UPCVO upcvo : lstVo) {
                    if (upcvo.isEditable()) {
                        upcvo.setPseGram("0.0000");
                        upcvo.setEditFlag(true);
                        addNewCandidate.getProductVO().addUpcVO(upcvo);
                    }
                }
            }
        }
        req.setAttribute(CPSConstants.CURRENT_APP_NAME, "Add Candidate");

        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        setBypass(req);
        ModelAndView model = new ModelAndView(RELATIVE_PATH_PSE_POPUP_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Fetch candidate from upc.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_FETCH_CANDIDATE_FROM_UPC)
    public ModelAndView fetchCandidateFromUPC(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                 HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        String upc = req.getParameter("SelectedUPC");
        if (upc != null) {
            ProductVO productVO;
            try {
                productVO = getAddNewCandidateService().getProductFromUPC(upc, getUserRole());
                addNewCandidate.setProductVO(productVO);
                this.setUOMDesc(productVO, addNewCandidate);
                setSellingRestriction(productVO);
                // -----New feature for Tax category---
                if (!BusinessUtil.isVendor(getUserRole())) {
                    try {
                        addNewCandidate.getProductVO().getPointOfSaleVO()
                                .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
                        if (CPSHelper
                                .isNotEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
                            for (TaxCategoryVO tax : addNewCandidate.getProductVO().getPointOfSaleVO()
                                    .getListTaxCategory()) {
                                if (CPSHelper.checkEqualValue(
                                        addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode(),
                                        tax.getTxBltyDvrCode())) {
                                    addNewCandidate.getProductVO().getPointOfSaleVO()
                                            .setTaxCateName(tax.getTxBltyDvrName());
                                    break;
                                }
                            }
                        }
                    } catch (CPSGeneralException e) {
                        CPSMessage message = new CPSMessage(e.getMessage(), CPSMessage.ErrorSeverity.INFO);
                        saveMessage(addNewCandidate, message);
                        LOG.error(e.getMessage(), e);
                    }
                }
                // -----New feature for Tax category---
                ProductVO productVOSaved = ProductVOHelper.copyProductVOtoProductVO(productVO);
                productVOSaved.setWorkRequest(productVO.getWorkRequest());
                addNewCandidate.setSavedProductVO(ProductVOHelper.copyProductVOtoProductVO(productVO));
                Map<String, UPCVO> upcMap = new HashMap<String, UPCVO>();
                List<UPCVO> upcs = productVO.getUpcVO();

                for (UPCVO upcvo : upcs) {
                    upcvo.setUnitUpc10(CPSHelper.calculateCheckDigit(upcvo.getUnitUpc()) + CPSConstants.EMPTY_STRING);
                    upcMap.put(upcvo.getUniqueId(), upcvo);
                }
                addNewCandidate.setUpcVOs(upcMap);
                Map<String, CommentsVO> commentsMap = new HashMap<String, CommentsVO>();
                List<CommentsVO> comments = productVO.getCommentsVO();
                for (CommentsVO commentsvo : comments) {
                    commentsvo.setUniqueId(CPSHelper.getUniqueId(commentsvo));
                    commentsMap.put(commentsvo.getUniqueId(), commentsvo);
                }
                addNewCandidate.setCommentsVOs(commentsMap);

                // PIM-1527 init upc kit vo for Kit Components.
                initUpcKitVO(addNewCandidate, productVO);

                initProductVO(addNewCandidate, req);
                initBrandField(addNewCandidate);
                initMatrixMarginMap(addNewCandidate);

                clearViewMode(addNewCandidate);
                addNewCandidate.setPrintable(false);
                addNewCandidate.setEnableClose(true);
                if (CPSConstants.WORKING_CANDIDATE.equalsIgnoreCase(productVO.getWorkRequest().getWorkStatusCode())
                        && CPSWebUtil.isVendor(getUserRole())) {
                    addNewCandidate.setViewOverRide();
                    setViewMode(addNewCandidate);
                    addNewCandidate.setEnableClose(false);
                } else if (CPSHelper.isN(productVO.getNewDataSw())) {
                    setViewMode(addNewCandidate);
                    addNewCandidate.setUpcViewOverRide();
                    addNewCandidate.setCaseViewOverRide();
                    addNewCandidate.setButtonViewOverRide();
                    addNewCandidate.setEnableClose(false);
                    addNewCandidate.setModifyProdCand(true);
                } else {
                    addNewCandidate.clearViewOverRide();
                    clearViewMode(addNewCandidate);
                }
            } catch (CPSGeneralException e) {
                LOG.error(e.getMessage(), e);
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
            }
        }
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * PIM-1527 init upc kit vo for Kit Components.
     *
     * @param candidateForm
     * @param productVO
     */
    public void initUpcKitVO(AddNewCandidate candidateForm, ProductVO productVO) {
        List<UPCKitVO> upcKitVos = productVO.getUpcKitVOs();
        double totalKitRetail = 0;
        double totalKitCost = 0;
        if (CPSHelper.isNotEmpty(upcKitVos)) {
            for (UPCKitVO upcKitVO : upcKitVos) {
                upcKitVO.setUniqueId(CPSHelper.getUniqueId(upcKitVO));
                totalKitRetail += upcKitVO.getQuantity() * upcKitVO.getRetail();
                totalKitCost += upcKitVO.getQuantity() * upcKitVO.getAvgCost();
            }
            candidateForm.getProductVO().clearUPCKitVOs();
            candidateForm.getProductVO().setUpcKitVOs(upcKitVos);
            candidateForm.getProductVO().getRetailVO().setSuggRetail("1");
            candidateForm.getProductVO().getRetailVO().setSuggforPrice(String.format("%.2f", totalKitRetail));
            candidateForm.setHiddenKitCost(String.format("%.4f", totalKitCost));
        }
    }
    /**
     * Fetch upc product.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_FETCH_UPC_PRODUCT)
    public ModelAndView fetchUPCProduct(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                              HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        String upc = req.getParameter("SelectedUPC");
        addNewCandidate.setProductVO(new ProductVO());
        addNewCandidate.setSavedProductVO(new ProductVO());
        addNewCandidate.setSelectedValue(CPSConstant.STRING_1);
        addNewCandidate.setEnteredValue(upc);
        addNewCandidate.getQuestionnarieVO().setSelectedValue(CPSConstant.STRING_1);
        addNewCandidate.getQuestionnarieVO().setEnteredValue(upc);
        return this.handleExistingId(addNewCandidate, req, resp);
    }
    /**
     * handles the 'questionnaire' tab of the tab view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_HANDLE_EXISTING_ID)
    public ModelAndView handleExistingId(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                        HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        // ((CPSAddCandidateForm)form).setTabIndex(CPSAddCandidateForm.TAB_PRODUCT_CLASSIFICATION);
        // enable Activate button
        addNewCandidate.setEnableActiveButton(true);
        // hide MRT tab
        addNewCandidate.setEnableTabs(true);
        // be sure user can be add UPC when switch to another tabs in Edit Mode-
        // Fix 1505
        addNewCandidate.setUpcAdded(true);
        addNewCandidate.setHidMrtSwitch(false);
        addNewCandidate.setViewOnlyProductMRT(false);
        ModelAndView model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
        try {
            addNewCandidate.getQuestionnarieVO().setEnteredValue(addNewCandidate.getEnteredValue());
            addNewCandidate.getQuestionnarieVO().setSelectedValue(addNewCandidate.getSelectedValue());
            addNewCandidate.getQuestionnarieVO().setSelectedOption(addNewCandidate.getSelectedOption());
            addNewCandidate.getQuestionnarieVO().setUpcDescription(addNewCandidate.getUpcDescription());
            addNewCandidate.setSelectedFunction(AddNewCandidate.ADD_NEWCANDIDATE);
            String upc = CPSConstants.EMPTY_STRING;
            String itemId = CPSConstants.EMPTY_STRING;
            String prodId = CPSConstants.EMPTY_STRING;
            String selectedValue = addNewCandidate.getQuestionnarieVO().getSelectedValue();
            if (CPSConstant.STRING_1.equals(selectedValue)) {
                upc = addNewCandidate.getQuestionnarieVO().getEnteredValue();
            } else if (CPSConstant.STRING_2.equals(selectedValue)) {
                itemId = addNewCandidate.getQuestionnarieVO().getEnteredValue();
            } else if (CPSConstant.STRING_3.equals(selectedValue)) {
                prodId = addNewCandidate.getQuestionnarieVO().getEnteredValue();
            }
            // fix QC-1549
            addNewCandidate.getCaseVO().clearCaseUPCVOs();
            if (CPSHelper.isNotEmpty(upc) || CPSHelper.isNotEmpty(itemId) || CPSHelper.isNotEmpty(prodId)) {
                ProductVO productVO = getAddNewCandidateService().getProduct(upc, prodId, itemId);
                //Sprint - 23
                if(CPSHelper.isNotEmpty(productVO) && productVO.isActiveProductKit()) {
                    saveMessage(addNewCandidate, new CPSMessage(BusinessConstants.COPY_KIT_PRODUCT_MSG, CPSMessage.ErrorSeverity.ERROR));
                    model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                    return model;
                }
                // HungBang
                fnSetScaleUPC(productVO);
                if (CPSHelper.isEmpty(productVO.getOriginSellingRestriction())) {
                    JSONArray jsonData = getSellingJsonFromWS(productVO.getProdId(),getCommonService().getSellingRestriction(productVO.getClassCommodityVO().getDeptId(), productVO.getClassCommodityVO().getSubDeptId() , productVO.getClassCommodityVO().getClassCode(), productVO.getClassificationVO().getCommodity(), productVO.getClassificationVO().getSubCommodity()));
                    if (!jsonData.isEmpty()) {
                        productVO.setOriginSellingRestriction(jsonData.toString());
                    }
                }
                ProductVO preservedProduct = productVO;
                this.correctUOM(productVO);

                // correct the list cost for Vendors
                if (BusinessUtil.isVendor(getUserRole())) {
                    correctListCostForVendor(productVO, addNewCandidate);
                    // PIM 831
                    // getCorrectInforVendorLogin(productVO, req);
                    // end PIM 831
                }

                // setViewMode(candidateForm);//old code
                clearViewMode(addNewCandidate);// permit user modify candidate
                setViewOverrideFlags(addNewCandidate);
                addNewCandidate.clearViewProduct();
                productVO.setNewDataSw(CPSConstant.CHAR_N);
                this.setIntentIdentifier(productVO, addNewCandidate.getQuestionnarieVO());
                // Defect ID : 3059 	CPS-Introduce a new case-->Print form--->"New pack" check box is not checked.
                // getIntentIdentifier == 2 -> Introduce a new case
                if(productVO.getWorkRequest().getIntentIdentifier() != 2) {
                    if (CPSHelper.isNotEmpty(productVO) && !productVO.isActiveProductKit()) {
                        productVO.getWorkRequest().setIntentIdentifier(0);
                    }
                }
                // Fix 1197
                UserInfo userInfo = getUserInfo();
                WorkRequest workRqst = productVO.getWorkRequest();
                workRqst.setVendorEmail(userInfo.getMail());
                String phone = userInfo.getAttributeValue("telephoneNumber");
                if (phone != null) {
                    phone = CPSHelper.cleanPhoneNumber(phone);
                    if (phone.length() >= 10) {
                        workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                        workRqst.setVendorPhoneNumber(phone.substring(3, 10));
                    } else {
                        workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                        workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
                    }
                }
                workRqst.setCandUpdtUID(userInfo.getUid());
                workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
                workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
                productVO = getAddNewCandidateService().saveProductAndCaseDetails(productVO, null, getUserRole());
                this.correctUOM(productVO);
                productVO.setModifiedProd(true);
                addNewCandidate.setProductVO(productVO);
                this.afterSave(addNewCandidate, addNewCandidate.getProductVO(), req);
                saveStoresForVendors(addNewCandidate, preservedProduct);
            }
            this.setIntentIdentifier(addNewCandidate);
            //Sprint - 23
            // Defect ID : 3059 	CPS-Introduce a new case-->Print form--->"New pack" check box is not checked.
            // getIntentIdentifier == 2 -> Introduce a new case
            if(addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier() != 2) {
                if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO()) && !addNewCandidate.getProductVO().isActiveProductKit()) {
                    addNewCandidate.getProductVO().getWorkRequest().setIntentIdentifier(0);
                }
            }
            addNewCandidate.getQuestionnarieVO().setEnteredValue(CPSConstants.EMPTY_STRING);
            addNewCandidate.setEnteredValue(CPSConstants.EMPTY_STRING);
            addNewCandidate.setTabIndex(AddNewCandidate.TAB_NEW_AUTH);
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());

            addNewCandidate.getCaseVO().setTouchTypeList(getTouchTypeCodes());
            addNewCandidate.getCaseVO().setItemCategoryList(getItemCategoryList());
            // DRU
            addNewCandidate.getCaseVO().setReadyUnits(getReadyUnitList());
            addNewCandidate.getCaseVO().setOrientations(getOrientationList());
            // END DRU
            addNewCandidate.getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
            addNewCandidate.setChannels(getChannels());
            initApplicableUPCs(addNewCandidate);
            addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
            addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
            addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
            addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());

            // Order Unit changes
            addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());
            List<VendorLocationVO> subVendorList = new ArrayList<VendorLocationVO>();
            addNewCandidate.getVendorVO().setVendorLocationList(subVendorList);
            clearMessages(addNewCandidate);
            addNewCandidate.setButtonViewOverRide();
            this.setUOMDesc(addNewCandidate.getProductVO(), addNewCandidate);
            addNewCandidate.setMrtvo(new MrtVO());
            addNewCandidate.setSelectedProductId(CPSConstants.EMPTY_STRING);
            req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_PRODUCT);
            addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_PRODUCT);
            Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            saveMessage(addNewCandidate, new CPSMessage("Product Copied for Modify", CPSMessage.ErrorSeverity.INFO));
            model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        } catch (Exception e) {
            // Any issue, just stay at Questionnaire page.
            clearMessages(addNewCandidate);
            saveMessage(addNewCandidate, new CPSMessage(CPSConstants.ERROR_FETCHING_PROD, CPSMessage.ErrorSeverity.ERROR));
            LOG.error(CPSConstants.ERROR_FETCHING_PROD, e);
        }
        return model;
    }
    /**
     * Wic.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST,RequestMethod.GET}, value = RELATIVE_PATH_WIC)
    public ModelAndView wic(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                         HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String value = req.getParameter("val");
        String disableWic = req.getParameter("disable");
        addNewCandidate.setWic(value);
        if (CPSHelper.isNotEmpty(disableWic) && CPSConstant.STRING_TRUE.equalsIgnoreCase(disableWic)) {
            addNewCandidate.setDisableWic(true);
        } else {
            addNewCandidate.setDisableWic(false);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_WIC_POPUP_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * shows the 'Add Sub Brand' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_ADD_SUB_BRAND)
    public ModelAndView addSubBrand(AddNewCandidate addNewCandidate, HttpServletRequest req,
                            HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String subBrand = req.getParameter("newSubBrand");
        addNewCandidate.setNewSubBrand(subBrand);
        req.setAttribute(CPSConstants.CURRENT_APP_NAME, "Add Candidate");
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_ADD_SUB_BRAND_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * shows the 'batch upload' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_PLU_GENERATION)
    public ModelAndView pluGeneration(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                    HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
        setForm(req, addNewCandidate);
        addNewCandidate.setBatchUploadMode();

        List<BaseJSFVO> pluTypes = getAddNewCandidateService().getPluType();
        addNewCandidate.getUpcvo().setPluTypeList(pluTypes);

        List<BaseJSFVO> pluRange = getAddNewCandidateService().getRangeDetails();
        addNewCandidate.getUpcvo().setRangeList(pluRange);

        req.setAttribute(CPSConstants.CURRENT_APP_NAME, "Add Candidate");
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        setBypass(req);
        addNewCandidate.setPluRangeOlds(CPSConstants.EMPTY_STRING);
        addNewCandidate.setLstPluGenerates(new ArrayList<Integer>());
        //return mapping.findForward("pluGenerationPopup");
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_PLU_GENERATION_POPUP_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * When clicking Next button from questionnaire page and from Auth &
     * distribution tab.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_PRODUCT_AND_UPC_FROM_MRT)
    public ModelAndView prodAndUpcFromMRT(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        ProductVO productVO = new ProductVO();
        addNewCandidate.setPrintable(true);
        addNewCandidate.clearViewOverRide();
        addNewCandidate.setScaleViewOverRide();
        clearMessages(addNewCandidate);
        addNewCandidate.setUpcVOs(new HashMap<String, UPCVO>());
        addNewCandidate.setCommentsVOs(new HashMap<String, CommentsVO>());
        String upcValue = addNewCandidate.getHidUpcValue();
        String upcCheckDigit = addNewCandidate.getHidUpcCheckDigit();
        String description = addNewCandidate.getHidDescription();
        upcValue = (null != upcValue) ? upcValue.trim() : upcValue;
        description = (null == description) ? CPSConstants.EMPTY_STRING : description;
        if (null != upcValue && !(CPSConstants.EMPTY_STRING.equals(upcValue))) {
            if (AddNewCandidate.NO_DESCRIPTION.equals(description)) {
                Map<String, UPCVO> upcMap = new HashMap<String, UPCVO>();
                Map<String, CommentsVO> commentsMap = new HashMap<String, CommentsVO>();
                addNewCandidate.setProductVO(productVO);
                addNewCandidate.setUpcVOs(upcMap);
                addNewCandidate.setCommentsVOs(commentsMap);
                addNewCandidate.setUpcValueFromMRT(false);
                addNewCandidate.setMrtUpcAdded(true);
                addNewCandidate.setUpcValue(upcValue);
                addNewCandidate.setUpcSubValue(upcCheckDigit);
                addNewCandidate.setMrtActiveProduct(false);
                if (!addNewCandidate.isCaseViewOverRide()) {
                    clearViewMode(addNewCandidate);
                }
            } else if (CPSConstants.VENDOR_CANDIDATE_STATUS.equalsIgnoreCase(description)) {
                CPSMessage message = new CPSMessage("Vendor candidate pending approval", CPSMessage.ErrorSeverity.ERROR);
                saveMessage(addNewCandidate, message);

                return this.showMRT(addNewCandidate, req, resp);
            } else {
                /* Searching for the data base */
                MRTUPCVO mrtVO = new MRTUPCVO();
                /*
                 * setViewMode(candidateForm); candidateForm.setViewOverRide();
                 */
                /* searching from the mainframe DB */
                boolean flagWebService = true;
                try {
                    // fix performance change getProduct to getProductBasic
                    productVO = getAddNewCandidateService().getProductBasic(upcValue, CPSConstants.EMPTY_STRING, CPSConstants.EMPTY_STRING);
                    // productVO =
                    // getAddNewCandidateService().getProduct(upcValue,
                    // EMPTY_STRING, EMPTY_STRING);
                    this.correctUOM(productVO);
                    flagWebService = true;
                } catch (CPSBusinessException e) {
                    LOG.error(e.getMessage(), e);
                    // List<CPSMessage> msgList = e.getMessages();
                    // String messg = SERVICE_ERROR;
                    // for (CPSMessage msg : msgList) {
                    // messg = CPSHelper.getTrimmedValue(msg.getMessage());
                    // }
                    // CPSMessage message = new CPSMessage(messg,
                    // ErrorSeverity.ERROR);
                    // saveMessage(candidateForm, message);
                    // mrtVO.setApproval("No");
                    // flagWebService = false;
                    // mrtVO.setDescription(EMPTY_STRING);
                    // return mapping.findForward(ADD_NEW_OTHER_INFO);
                } catch (CPSSystemException e) {
                    LOG.error(e.getMessage(), e);
                    CPSMessage message = new CPSMessage("Product not existing", CPSMessage.ErrorSeverity.ERROR);
                    saveMessage(addNewCandidate, message);
                    mrtVO.setApproval("No");
                    flagWebService = false;
                    mrtVO.setDescription(CPSConstants.EMPTY_STRING);
                    model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                    return model;
                }
                if (null == productVO.getProdId() && flagWebService) {
                    /* searching from the CPS DB */
                    mrtVO = getAddNewCandidateService().getMRTDetails(upcValue);
                    productVO = getAddNewCandidateService().fetchProduct(mrtVO.getProdId(), getUserRole());
                    addNewCandidate.setSelectedProductId(CPSHelper.getStringValue(productVO.getPsProdId()));
                    addNewCandidate.setMrtActiveProduct(false);
                } else {
                    setViewMode(addNewCandidate);
                    addNewCandidate.setViewOverRide();
                    addNewCandidate.clearCaseViewOverRide();
                    addNewCandidate.clearUpcViewOverRide();
                    addNewCandidate.setSelectedProductId(productVO.getProdId());
                    addNewCandidate.setMrtActiveProduct(true);
                    addNewCandidate.setUpcAdded(false);
                    addNewCandidate.setViewMode(true);
                }
                // Fix 1198
                addNewCandidate.setLabelFormats(getLabelFormatList());
                addNewCandidate.setProductVO(productVO);
                Map<String, UPCVO> upcMap = new HashMap<String, UPCVO>();
                List<UPCVO> upcs = productVO.getUpcVO();
                for (UPCVO upcvo : upcs) {
                    upcvo.setUniqueId(CPSHelper.getUniqueId(upcvo));
                    upcMap.put(upcvo.getUniqueId(), upcvo);
                }
                addNewCandidate.setUpcVOs(upcMap);
                Map<String, CommentsVO> commentsMap = new HashMap<String, CommentsVO>();
                List<CommentsVO> comments = productVO.getCommentsVO();
                for (CommentsVO commentsvo : comments) {
                    commentsvo.setUniqueId(CPSHelper.getUniqueId(commentsvo));
                    commentsMap.put(commentsvo.getUniqueId(), commentsvo);
                }
                addNewCandidate.setCommentsVOs(commentsMap);
                try {
                    initProductVO(addNewCandidate, req);
                }catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                    CPSMessage message = new CPSMessage("Error", CPSMessage.ErrorSeverity.ERROR);
                    saveMessage(addNewCandidate, message);
                }
                initBrandField(addNewCandidate);
                addNewCandidate.setUpcValueFromMRT(true);
            }
        } /** Checking For MRT - Ends */
        else {
            addNewCandidate.setUpcValueFromMRT(true);
            addNewCandidate.setNormalProduct(false);
        }
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
        if (!addNewCandidate.isMrtActiveProduct()) {
            addNewCandidate.setAddCandidateMode();
        }

        if (CPSConstants.MODIFY.equals(addNewCandidate.getAction())) {
            req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_CANDIDATE);
        }
        try {
            this.getDetails(addNewCandidate, req);
        }catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        addNewCandidate.setHidUpcValue(null);
        addNewCandidate.setHidDescription(null);
        addNewCandidate.setHidUpcCheckDigit(null);
        if (addNewCandidate.isMrtActiveProduct()) {
            if(addNewCandidate.getProductVO().isActiveProductKit()) {
                req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_KIT_PRODUCT);
                addNewCandidate.setCurrentAppName(CPSConstants.VIEW_KIT_PRODUCT);
            } else {
                req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_PRODUCT);
                addNewCandidate.setCurrentAppName(CPSConstants.VIEW_PRODUCT);
            }

            addNewCandidate.clearScaleViewOverRide();
            addNewCandidate.setNormalProduct(false);
            // candidateForm.setProduct(true);
            addNewCandidate.setCandidateType(CPSConstants.EMPTY_STRING);
            getViewProductDetails(addNewCandidate, req, upcValue);
            productVO = addNewCandidate.getProductVO();
        } else {
            // -----New feature for Tax category---
            if (!BusinessUtil.isVendor(getUserRole())) {
                try {
                    addNewCandidate.getProductVO().getPointOfSaleVO()
                            .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
                    if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
                        for (TaxCategoryVO tax : addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory()) {
                            if (CPSHelper.checkEqualValue(
                                    addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode(),
                                    tax.getTxBltyDvrCode())) {
                                addNewCandidate.getProductVO().getPointOfSaleVO().setTaxCateName(tax.getTxBltyDvrName());
                                break;
                            }
                        }
                    }
                } catch (Exception e) {
                    LOG.error("Error occur when call ws TaxCategory:" + e.getMessage(), e);
                }
            }
        }

        // be sure work status code follow over flows
        // FIX #4422 comment code work status code ?
        // if(CPSHelper.isNotEmpty(workStatusCode)) {
        // WorkRequest wr=new WorkRequest();
        // wr.setWorkStatusCode(workStatusCode);
        // productVO.setWorkRequest(wr);
        // candidateForm.setProductVO(productVO);
        // }

        // fix #28608 enable button Modify
        addNewCandidate.clearButtonViewOverRide();
        if (CPSHelper.isN(addNewCandidate.getProductVO().getNewDataSw()) && addNewCandidate.isUpcAdded()) {
            setViewMode(addNewCandidate);
            addNewCandidate.setUpcViewOverRide();
            addNewCandidate.setCaseViewOverRide();
            addNewCandidate.setButtonViewOverRide();
            addNewCandidate.setEnableClose(false);
            addNewCandidate.setModifyProdCand(true);
            addNewCandidate.setScaleViewOverRide();
        }
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getProdId())
                && addNewCandidate.getProductVO().getNewDataSw() == CPSConstant.CHAR_N) {
            setViewMode(addNewCandidate);
        }
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Gets the view product details.
     *
     * @param addNewCandidate
     *            the candidate form
     * @param req
     *            the req
     * @param upcValue
     *            the upc value
     * @return the view product details
     * @throws Exception
     *             the exception
     */
    private ModelAndView getViewProductDetails(AddNewCandidate addNewCandidate, HttpServletRequest req, String upcValue) throws Exception {
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        addNewCandidate.setProduct(true);
        String stringVal = null;
        stringVal = addNewCandidate.getSelectedProductId();
        List<String> prodIds = addNewCandidate.getPendingProdIds();
        // setQualifyCondition(candidateForm);

        boolean viewMode = isViewMode(addNewCandidate);
        if (CPSHelper.isEmpty(prodIds)) {
            String resultArray = req.getParameter("SelectedViewArray");
            if (null != resultArray) {
                StringTokenizer idList = new StringTokenizer(resultArray, ",");
                stringVal = idList.nextToken();
                if (idList.hasMoreTokens()) {
                    List<String> addlIds = new ArrayList<String>();
                    while (idList.hasMoreTokens()) {
                        addlIds.add(idList.nextToken());
                    }
                    addNewCandidate.setPendingProdIds(addlIds);
                }
            }
        }
        JSONArray jsonData = new JSONArray();
        if (null != stringVal) {
            /*
             * Check candidate type when user clicking on View Next a candidate
             *
             * @author khoapkl
             */
            if (addNewCandidate.getCandidateType().equals(CPSConstants.MRT)) {
                clearMessages(addNewCandidate);
                req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_PRODUCT);
                addNewCandidate.setCurrentAppName(CPSConstants.VIEW_PRODUCT);
                addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
                addNewCandidate.getQuestionnarieVO().setSelectedOption("4");
                addNewCandidate.getProductVO().setModifyFlag(false);
                addNewCandidate.setViewOnlyProductMRT(true);
                addNewCandidate.setButtonViewOverRide();// hide Modify button
                addNewCandidate.setViewOverRide();
                setViewMode(addNewCandidate);
                addNewCandidate.setPrintable(false);
                addNewCandidate.setEnableClose(false);
                addNewCandidate.setHidMrtSwitch(true);
                addNewCandidate.setMrtViewMode(viewMode);
                viewProductMRTCase(addNewCandidate, req, stringVal, upcValue);
            } else {
                addNewCandidate.setSelectedProductId(stringVal);
                // fix performance change getProduct to getProductBasic
                // ProductVO productVO =
                // getAddNewCandidateService().getProduct(null, stringVal,
                // null);
                ProductVO productVO = getAddNewCandidateService().getProductBasic(null, stringVal, null);
                this.correctUOM(productVO);
                // correct the list cost for Vendors
                if (BusinessUtil.isVendor(getUserRole())) {
                    correctListCostForVendor(productVO, addNewCandidate);
                    // PIM 831
                    // getCorrectInforVendorLogin(productVO, req);
                    // end PIM 831
                }
                this.setUOMDesc(productVO, addNewCandidate);
                addNewCandidate.setProductVO(productVO);
                initProductServiceVO(addNewCandidate, req);
                addNewCandidate.setBdms(getBdmList());
                addNewCandidate.setProduct(true);
                List<String> sellingResWs = getCommonService().getSellingRestriction(productVO.getClassCommodityVO().getDeptId(), productVO.getClassCommodityVO().getSubDeptId(), productVO.getClassCommodityVO().getClassCode(), productVO.getClassificationVO().getCommodity(), productVO.getClassificationVO().getSubCommodity());
                // set Selling Restrictions from WS
                jsonData = getSellingJsonFromWS(stringVal,sellingResWs);

                // -----New feature for Tax category---
                if (!BusinessUtil.isVendor(getUserRole())) {
                    try {
                        addNewCandidate.getProductVO().getPointOfSaleVO()
                                .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));

                    } catch (Exception e) {
                        LOG.error("WS get Tax category error in function view product:" + e);
                    }
                }
                if(addNewCandidate.getProductVO().isActiveProductKit()) {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_KIT_PRODUCT);
                    addNewCandidate.setCurrentAppName(CPSConstants.VIEW_KIT_PRODUCT);
                }
                // -----New feature for Tax category---
            }
        }
        if (!jsonData.isEmpty()) {
            addNewCandidate.getProductVO().setOriginSellingRestriction(jsonData.toString());

        }
        Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        if (currentMode != null)
            req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
        req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * This method used for get MRTs data and display on screen.
     *
     * @author khoapkl
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param stringVal
     *            the string val
     * @param upcValue
     *            the upc value
     * @throws Exception
     *             the exception
     */
    public void viewProductMRTCase(AddNewCandidate addNewCandidate, HttpServletRequest req, String stringVal, String upcValue)
            throws Exception {
        setForm(req, addNewCandidate);
        long orderingUpc = 0;
        String itmTypCd = CPSConstants.EMPTY_STRING;
        // ordering_upc got when user clicking on per unit upc at MRT Tab
        if (CPSHelper.isNotEmpty(upcValue)) {
            orderingUpc = CPSHelper.getLongValue(upcValue);
        } else {
            String stringValItmTypCd = addNewCandidate.getSelectedProductIdItmTypCd();
            String[] arrr = null;
            String[] arrItmTypCd = null;
            if (stringValItmTypCd != null && !stringValItmTypCd.isEmpty()) {
                arrr = stringValItmTypCd.split(",");
            }
            if (null != arrr && arrr.length > 0) {
                for (String strItmTyp : arrr) {
                    if (null != strItmTyp && !strItmTyp.isEmpty()) {
                        arrItmTypCd = strItmTyp.split("-");
                        if (null != arrItmTypCd && arrItmTypCd.length > 0) {
                            if (null != stringVal && null != arrItmTypCd[0]) {
                                if (stringVal.trim().equals(arrItmTypCd[0].trim())) {
                                    itmTypCd = arrItmTypCd[1];
                                    break;
                                }
                            }
                        }
                    }

                }
            }
            orderingUpc = getAddNewCandidateService().getOrderingUpcByItmId(stringVal, itmTypCd);
        }
        List<MRTUPCVO> mrtUpcList = getAddNewCandidateService().getMRTUnitUPCProduction(orderingUpc);
        int unitTotalAttribute = 0;
        MrtVO mrtVO = new MrtVO();
        if (CPSHelper.isNotEmpty(mrtUpcList)) {
            List<VendorLocationVO> subVendorList = new ArrayList<VendorLocationVO>();
            for (MRTUPCVO mrtVOTemp : mrtUpcList) {
                // not sum for FakeUPC
                if (!CPSHelper.isFakeUPC(mrtVOTemp.getUnitUPC())) {
                    unitTotalAttribute += Integer.parseInt(mrtVOTemp.getSellableUnits());
                }
                mrtVO.setMrtUpcVO(mrtVOTemp);
                addNewCandidate.getMrtvo().addMRTVO(mrtVOTemp);
                addNewCandidate.getMrtvo().removeMRTVO(mrtVOTemp.getUniqueId());
            }
            mrtVO.setMrtVOs(mrtUpcList);
            addNewCandidate.setMrtvo(mrtVO);
            addNewCandidate.getMrtvo().getMrtUpcVO().setUnitTotalAttribute(unitTotalAttribute);
            addNewCandidate.setChannels(getChannels());
            try {
                ProductVO productVO = getAddNewCandidateService().getMRTProduction(stringVal, itmTypCd);
                if (CPSHelper.isNotEmpty(productVO)) {
                    List<CaseVO> lstCaseVO = productVO.getCaseVOs();
                    if (CPSHelper.isNotEmpty(lstCaseVO)) {
                        for (CaseVO caseVO : lstCaseVO) {
                            addNewCandidate.getMrtvo().setCaseVO(caseVO);
                        }
                    }
                    // I don't understand why set productVO at here. This action
                    // will prevent to calculate %Margin & Profit Penny on each
                    // child UPC
                    // and affect to validateBeforeCaculateMRTMargin method.
                    // candidateForm.getMrtvo().getMrtUpcVO().setProductVO(productVO);
                    if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getChannelVal())) {
                        subVendorList = setVendorListForMRT(addNewCandidate.getMrtvo().getMrtVOs(), addNewCandidate,
                                addNewCandidate.getMrtvo().getCaseVO(), req);
                    }
                    if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getVendorVOs())) {
                        addNewCandidate.setCostOwners(setCostOwnerValuesForMRT(addNewCandidate, CPSHelper.getIntegerValue(addNewCandidate.getMrtvo().getCaseVO().getVendorVOs().get(0).getCostOwnerVal())));
                    }
                    addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
                    addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
                    addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
                    addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());
                    addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());

                    addNewCandidate.getMrtvo().getCaseVO().setTouchTypeList(getTouchTypeCodes());
                    addNewCandidate.getMrtvo().getCaseVO().setItemCategoryList(getItemCategoryList());
                    addNewCandidate.getMrtvo().getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
                    // DRU
                    addNewCandidate.getMrtvo().getCaseVO().setReadyUnits(getReadyUnitList());
                    addNewCandidate.getMrtvo().getCaseVO().setOrientations(getOrientationList());
                    // END DRU
                    // FIX PIM 831
                    // getCorrectInforVendorLoginMRT(candidateForm.getMrtvo().getCaseVO(),
                    // req);
                    // END FIX
                }
            } catch (CPSGeneralException cps) {
                LOG.error(cps.getMessage(), cps);
                CPSMessage message = new CPSMessage("Product not existing", CPSMessage.ErrorSeverity.ERROR);
                saveMessage(addNewCandidate, message);
                if (CPSHelper.isNotEmpty(upcValue)) {
                    addNewCandidate.setViewMode(false);
                }
                throw new CPSBusinessException(new CPSMessage(message.getMessage(), CPSMessage.ErrorSeverity.ERROR));
            }
            addNewCandidate.getVendorVO().setVendorLocationList(subVendorList);
        }
    }
    /**
     * shows the 'assortment' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_ASSORMENT)
    public ModelAndView assortment(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                          HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_ASSORMENT_PAGE);
        setForm(req, addNewCandidate);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * shows the 'matrixMargin' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_MATRIX_MARGIN)
    public ModelAndView matrixMargin(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                   HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String margin = CPSHelper.getStringValue(addNewCandidate.getProductVO().getRetailVO().getMarginPercent());
        if (CPSConstants.ZERO_STRING.equalsIgnoreCase(margin) || null == margin) {
            addNewCandidate.setMatrixMarginClose(true);
        } else {
            addNewCandidate.setMatrixMarginClose(false);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_MATRIX_MARGIN_POPUP_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * shows the 'retail link' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_RETAIL_LINK)
    public ModelAndView retailLink(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                     HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        req.setAttribute(CPSConstants.CURRENT_APP_NAME, "Add Candidate");
        StringBuffer checkMessage = new StringBuffer();
        checkMessage.append(CPSConstants.EMPTY_STRING);
        // saveDetails(mapping, form, req, resp);
        clearMessages(addNewCandidate);
        String retailLinkInput = req.getParameter("retailLinkUpc");
        try {
            boolean flagValid = true;
            String retailLinkUPC = null;
            int itemId = 0;
            if (retailLinkInput.length() == 13) {
                retailLinkUPC = retailLinkInput;
                try {
                    // Long retailLinkUPCTemp = Long.parseLong(retailLinkUPC);
                } catch (NumberFormatException e) {
                    addNewCandidate.getProductVO().setRetailLinkVO(new RetailLinkVO());
                    flagValid = false;
                    CPSMessage message = new CPSMessage("Retail Link To must be a numeric value.", CPSMessage.ErrorSeverity.ERROR);
                    addNewCandidate.getProductVO().getRetailVO().setRetailLinkTo(CPSConstants.EMPTY_STRING);
                    saveMessage(addNewCandidate, message);
                }
            } else if (retailLinkInput.length() == 7) {
                try {
                    itemId = Integer.parseInt(retailLinkInput);
                } catch (NumberFormatException e) {
                    addNewCandidate.getProductVO().setRetailLinkVO(new RetailLinkVO());
                    flagValid = false;
                    CPSMessage message = new CPSMessage("Retail Link To must be a numeric value.", CPSMessage.ErrorSeverity.ERROR);
                    addNewCandidate.getProductVO().getRetailVO().setRetailLinkTo(CPSConstants.EMPTY_STRING);
                    saveMessage(addNewCandidate, message);
                }
            }
            if (flagValid) {
                RetailLinkVO linkVO = getAddNewCandidateService().getRetailLinkVO(retailLinkUPC, itemId);
                addNewCandidate.getProductVO().getRetailLinkVO().setRetailLinkNum(linkVO.getRetailLinkNum());
                addNewCandidate.getProductVO().getRetailVO().setRetailLinkNum(linkVO.getRetailLinkNum());
                // Fix production issue
                addNewCandidate.getProductVO().getRetailVO().setRetailLinkTo(linkVO.getUnitUpc());
                addNewCandidate.getProductVO().getRetailLinkVO().setCommodity(linkVO.getCommodity());
                addNewCandidate.getProductVO().getRetailLinkVO().setProdDesc(linkVO.getProdDesc());
                addNewCandidate.getProductVO().getRetailLinkVO().setSize(linkVO.getSize());
                addNewCandidate.getProductVO().getRetailLinkVO().setSubCommodity(linkVO.getSubCommodity());
                addNewCandidate.getProductVO().getRetailLinkVO().setUnitRetail(linkVO.getUnitRetail());
                addNewCandidate.getProductVO().getRetailLinkVO().setUnitRetailFor(linkVO.getUnitRetailFor());
                addNewCandidate.getProductVO().getRetailLinkVO().setUnitUpc(linkVO.getUnitUpc());
                addNewCandidate.getProductVO().getRetailLinkVO().setUpcType(linkVO.getUpcType());
            }
        } catch (CPSBusinessException ex) {
            LOG.error(ex.getMessage(), ex);
            addNewCandidate.getProductVO().setRetailLinkVO(new RetailLinkVO());
            List<CPSMessage> list = ex.getMessages();
            for (CPSMessage message : list) {
                checkMessage.append(message.getMessage());
            }
            addNewCandidate.getProductVO().getRetailVO().setRetailLinkTo(CPSConstants.EMPTY_STRING);
            CPSMessage message = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            CPSMessage message = new CPSMessage(CPSConstants.SERVICE_ERROR, CPSMessage.ErrorSeverity.ERROR);
            addNewCandidate.getProductVO().getRetailVO().setRetailLinkTo(CPSConstants.EMPTY_STRING);
            saveMessage(addNewCandidate, message);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_RETAIL_LINK_POPUP);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Gets the nutrition facts.
     *
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_APPROVED_USERNAME)
    public ModelAndView getApprovedUserName(HttpServletRequest req,
                                   HttpServletResponse resp) throws Exception {
        String approvedUserName = CPSConstant.STRING_EMPTY;;
        try {
            String approvedUserId = req.getParameter("approvedUserId").toString();
            approvedUserName = getDisplayNameByUserId(approvedUserId);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        req.setAttribute(CPSConstants.JSON_DATA, approvedUserName);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Gets the tax cate default.
     *
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the tax cate default
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_TAX_CATE_DEFAULT)
    public ModelAndView getTaxCateDefault(HttpServletRequest req,
                                            HttpServletResponse resp) throws Exception {
        JSONObject jsonData = null;
        TaxCategoryVO taxCate = null;
        try {
            taxCate = getCommonService().getTaxCateDefault(req.getParameter("subCommodity"));
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        if (null != taxCate) {
            jsonData = ExtendAndBrickAttrHelper.buildTaxCategoryToJson(taxCate);
        }
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws Exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_ALL_SELLING_RES_FROM_CACHE)
    public ModelAndView getAllSellingResFromCache(HttpServletRequest req,
                                          HttpServletResponse resp) throws Exception {
        List<BaseJSFVO> lstRateType =  null;
        String userRole = getUserRole();
        if(!(userRole.equalsIgnoreCase(BusinessConstants.REGISTERED_VENDOR_ROLE) || userRole.equalsIgnoreCase(BusinessConstants.UNREGISTERED_VENDOR_ROLE))) {
            lstRateType = getCommonService().getAllSalsFromCache();
        }

        JSONArray jsonArray = JsonOrgConverter.convertSellingResJsonToVO(lstRateType);
        req.setAttribute(CPSConstants.JSON_DATA, jsonArray);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Sets the tax flag when change tax cate.
     *
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_SET_TAX_FLAG_WHEN_CHANGE_TAX_CATE)
    public ModelAndView setTaxFlagWhenChangeTaxCate(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                                  HttpServletResponse resp) throws Exception {
        //setForm(req, addNewCandidate);
        String flag = CPSConstant.STRING_TRUE;
        String vertex = req.getParameter("vertexTax").trim();
        Map<String, String> tax = new HashMap<String, String>();
        tax = getCommonService().getTaxCateAndTaxFlag(req.getParameter("subCommodity"));
        if (vertex.equals(tax.get("vertexTax"))) {
            flag = CPSConstant.STRING_TRUE;
        } else if (vertex.equals(tax.get("vertexNonTax"))) {
            flag = CPSConstant.STRING_FALSE;
        } else {
            flag = "None";
        }
        req.setAttribute(CPSConstants.JSON_DATA, flag);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Gets the total prod by tax category.
     *
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the total prod by tax category
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_TOTAL_PROD_BY_TAX_CATEGORY)
    public ModelAndView getTotalProdByTaxCategory(HttpServletRequest req,
                                                    HttpServletResponse resp) throws Exception {
        JSONObject jsonData = null;
        int total = 0;
        try {
            total = getAddNewCandidateService().getTotalProdByTaxCategory(req.getParameter("txBltyDvrCode"));
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        jsonData = ExtendAndBrickAttrHelper.buildValueTotalToJson(total);
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Gets the list prod by tax category.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the list prod by tax category
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_LIST_PROD_BY_TAX_CATEGORY)
    public ModelAndView getListProdByTaxCategory(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                                  HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);

        List<ProductMiniTaxCateVO> listProd = addNewCandidate.getProductVO().getPointOfSaleVO().getListProdMiniTax();
        List<ProductMiniTaxCateVO> listReturn = new ArrayList<ProductMiniTaxCateVO>();
        List<ProductMiniTaxCateVO> listGetWs = new ArrayList<ProductMiniTaxCateVO>();
        int total = CPSHelper.getIntegerValue(req.getParameter("total"));
        int startValue = CPSHelper.getIntegerValue(req.getParameter("startValue"));
        int numberOfRows = CPSHelper.getIntegerValue(req.getParameter("numberOfRows"));
        String taxCode = req.getParameter("txBltyDvrCode");
        int endValue = startValue + numberOfRows;
        if (taxCode.equals(addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCodeForPaging())
                && CPSHelper.isNotEmpty(listProd)) {
            if (listProd.size() <= total) { //
                if ((endValue) <= listProd.size()) {
                    listReturn = listProd.subList(startValue, startValue + numberOfRows);
                } else {
                    if (listProd.size() < total) {
                        while (listProd.size() < total && endValue > listProd.size()) {
                            try {
                                int numberRowNeedGet = endValue - listProd.size();
                                if (numberRowNeedGet > numberOfRows) { // get
                                    // all
                                    // record
                                    // numberRowNeedGet
                                    listGetWs = getAddNewCandidateService().getLstProdByTaxCd(taxCode,
                                            listProd.get(listProd.size() - 1).getProductId(), numberRowNeedGet);
                                } else {
                                    listGetWs = getAddNewCandidateService().getLstProdByTaxCd(taxCode,
                                            listProd.get(listProd.size() - 1).getProductId(), numberOfRows);
                                }
                            } catch (Exception e) {
                                LOG.error("Error getLstProdByTaxCd:" + e.getMessage(), e);
                            }
                            if (CPSHelper.isNotEmpty(listGetWs)) {
                                listProd.addAll(listGetWs);
                                addNewCandidate.getProductVO().getPointOfSaleVO().setListProdMiniTax(listProd);
                                if (endValue <= listProd.size()) {
                                    listReturn = listProd.subList(startValue, endValue);
                                } else {
                                    if (startValue < listProd.size()) {
                                        listReturn = listProd.subList(startValue, listProd.size());
                                    }
                                }
                            }
                        }

                    } else {
                        listReturn = listProd.subList(startValue, listProd.size());
                    }
                }
            }
        } else {
            addNewCandidate.getProductVO().getPointOfSaleVO().setTaxCateCodeForPaging(taxCode);
            if (total > 0) {
                listProd = new ArrayList<ProductMiniTaxCateVO>();
                try {
                    listGetWs = getAddNewCandidateService().getLstProdByTaxCd(taxCode, CPSConstant.STRING_0,
                            numberOfRows);
                } catch (Exception e) {
                    LOG.error("Error getLstProdByTaxCd:" + e.getMessage(), e);
                }
                if (CPSHelper.isNotEmpty(listGetWs)) {
                    listProd.addAll(listGetWs);
                    addNewCandidate.getProductVO().getPointOfSaleVO().setListProdMiniTax(listProd);
                    if ((startValue + numberOfRows) <= listProd.size()) {
                        listReturn = listProd.subList(startValue, startValue + numberOfRows);
                    } else {
                        listReturn = listProd.subList(startValue, listProd.size());
                    }
                }
            }
        }
        JSONArray jsonData = null;
        if (!listReturn.isEmpty()) {
            jsonData = ExtendAndBrickAttrHelper.buildProdListToJson(listReturn);
        }
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Gets the tax category based on tax flag.
     *
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the tax category based on tax flag
     * @throws Exception
     *             the exception
     */
    // HungBang get Tax category based on Tax Flat and sub common
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_TAX_CATEGORY_BASED_ON_TAX_FLAG)
    public ModelAndView getTaxCategoryBasedOnTaxFlag(HttpServletRequest req,
                                                 HttpServletResponse resp) throws Exception {

        JSONObject jsonData = null;
        TaxCategoryVO taxCate = null;
        try {
            taxCate = getCommonService().getTaxCategoryBasedOnTaxAble(req.getParameter("taxFlag"),
                    req.getParameter("subCommodity"));
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        if (null != taxCate) {
            jsonData = ExtendAndBrickAttrHelper.buildTaxCategoryToJson(taxCate);
        }
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * get rating from selling restrictions(Rating type).
     *
     * @author hungbang
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_CHANGE_SELLING_RESTRICTIONS)
    public ModelAndView changeSellingRestrictions(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                                     HttpServletResponse resp) throws Exception {
        //setForm(req, addNewCandidate);
        String rateType = req.getParameter("rateType");
        List<RatingVO> lstRating = new ArrayList<RatingVO>();
        if (CPSHelper.isNotEmpty(rateType)) {
            lstRating = getCommonService().getAllRatingBySellResFromCache(rateType);
        }
        JSONObject jsonObj = JsonOrgConverter.getJsonRatingVo(lstRating);
        jsonObj.put("rateTypeSelected", rateType);
        req.setAttribute(CPSConstants.JSON_DATA, jsonObj);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * get Selling Restrictions from Sub Commodity.
     *
     * @author hungbang
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the selling restrictions
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_SELLING_RESTRICTIONS)
    public ModelAndView getSellingRestrictions(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                                  HttpServletResponse resp) throws Exception {
        //setForm(req, addNewCandidate);
        String subCommodity = req.getParameter("subComm");
        List<String> lstSellingRestrictions = null;
        String userRole = getUserRole();
        if(!(userRole.equalsIgnoreCase(BusinessConstants.REGISTERED_VENDOR_ROLE) || userRole.equalsIgnoreCase(BusinessConstants.UNREGISTERED_VENDOR_ROLE))) {
            lstSellingRestrictions = getSellingFromWS(subCommodity);
        }
        JSONArray jsonArray = createJsonSellingRes(lstSellingRestrictions);
        req.setAttribute(CPSConstants.JSON_DATA, jsonArray);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Creates the json selling res.
     *
     * @param lstRateTypeSelected
     *            the lst rate type selected
     * @return the JSON array
     * @throws Exception
     *             the exception
     */
    @SuppressWarnings("unchecked")
    private JSONArray createJsonSellingRes(List<String> lstRateTypeSelected) throws Exception {
        JSONArray jsonArray = new JSONArray();
        List<BaseJSFVO> lstRateType = getCommonService().getAllSalsFromCache();
        if (CPSHelper.isEmpty(lstRateTypeSelected)) {
            lstRateTypeSelected = new ArrayList<>();
            lstRateTypeSelected.add("-1");
        }
        for (String rateType : lstRateTypeSelected) {
            List<BaseJSFVO> lstRating = new ArrayList<BaseJSFVO>();
            if (rateType != "-1") {
                lstRating = getCommonService().getAllRatingFromCache(rateType);
            }
            JSONObject jsonData = JsonOrgConverter.initJsonForDT(lstRateType, lstRating, rateType);
            jsonArray.add(jsonData);

        }
        return jsonArray;
    }
    /**
     * Gets the list data distinct.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the list data distinct
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_LIST_DATA_DISTINCT)
    public ModelAndView getListDataDistinct(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                               HttpServletResponse resp) throws Exception {
        JSONArray jsonData = null;
        List<TaxCategoryVO> taxCate = null;
        String errorMess = CPSConstants.EMPTY_STRING;
        try {
            taxCate = this.getAddNewCandidateService().getLstTaxForDistinct(req.getParameter("subCommodity"));
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
            errorMess = e.getMessage();
        }

        if (CPSHelper.isNotEmpty(taxCate) || CPSHelper.isEmpty(errorMess)) {
            jsonData = ExtendAndBrickAttrHelper.buildListDataDistinctToJson(taxCate);
            req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        } else {
            req.setAttribute(CPSConstants.JSON_DATA, "cpsexception:" + errorMess);
        }

        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Sets the retail non selable.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_RETAIL_NON_SELABLE)
    public ModelAndView setRetailNonSelable(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                            HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
     //   setForm(req, addNewCandidate);
        if (!addNewCandidate.getUserRole().equals(CPSConstants.REGISTERED_VENDOR_ROLE)
                || !addNewCandidate.getUserRole().equals(CPSConstants.UNREGISTERED_VENDOR_ROLE)) {
            addNewCandidate.getProductVO().getRetailVO().setRetail(CPSConstant.STRING_1);
            addNewCandidate.getProductVO().getRetailVO().setRetailForWrap("0.00");
        }
        addNewCandidate.getProductVO().getRetailVO().setSuggRetail(CPSConstant.STRING_1);
        addNewCandidate.getProductVO().getRetailVO().setSuggforPrice("0.00");
        req.setAttribute(CPSConstants.JSON_DATA, "success");
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Removed disable scale att.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_REMOVE_DISABLE_SCALE_ATT)
    public ModelAndView removedDisableScaleAtt(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                            HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
     //   setForm(req, addNewCandidate);
        String flag = CPSConstant.STRING_FALSE;
        ProductVO productVO = addNewCandidate.getProductVO();
        if (!addNewCandidate.isUpcViewOverRide()) {
            for (UPCVO upcvo : productVO.getUpcVO()) {
                if (upcvo.getUnitUpc().startsWith("002") && upcvo.getUnitUpc().endsWith("00000")
                        && CPSHelper.isY(upcvo.getNewDataSw())) {
                    addNewCandidate.setScaleAttrib("I");
                    flag = CPSConstant.STRING_TRUE;
                    break;
                }
            }
        }
        req.setAttribute(CPSConstants.JSON_DATA, flag);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    /**
     * Sets the scale is true.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_SET_SACLE_IS_TRUE)
    public ModelAndView setScaleIsTrue(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                               HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String flag = CPSConstant.STRING_TRUE;
        addNewCandidate.setScaleAttrib("I");
        addNewCandidate.getProductVO().setScaleUPC(true);
        addNewCandidate.getProductVO().setOnlyCheckerUPC(false);
        req.setAttribute(CPSConstants.JSON_DATA, flag);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        return model;
    }
    private void preSave(AddNewCandidate addNewCandidate) throws CPSBusinessException {
        boolean dataBaseCheckForUPC = false;
        if ((!CPSHelper.isEmpty(addNewCandidate.getUpcvo().getSelectedUpcType()))
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedUnitSize())
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedUnitUPC())
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedUPCHeight())
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedUPCLength())
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedUPCSize())
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedUPCWidth())
                || CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedWic())) {

            UPCVO upcvo = new UPCVO();
            if (addNewCandidate.getUpcvo().isSelectedBonus()) {
                upcvo.setBonus(true);
            } else {
                upcvo.setBonus(false);
            }
            upcvo.setUnitMeasureDesc(CPSHelper.getTrimmedValue(addNewCandidate.getUpcvo().getUnitMeasureDesc()));
            upcvo.setUnitMeasureCode(addNewCandidate.getUpcvo().getSelectedUnitOfMeasure());
            upcvo.setUnitSize(addNewCandidate.getUpcvo().getSelectedUnitSize());
            upcvo.setUnitUpc(addNewCandidate.getUpcvo().getSelectedUnitUPC());
            upcvo.setHeight(addNewCandidate.getUpcvo().getSelectedUPCHeight());
            upcvo.setLength(addNewCandidate.getUpcvo().getSelectedUPCLength());
            upcvo.setSize(addNewCandidate.getUpcvo().getSelectedUPCSize());
            upcvo.setUpcType(addNewCandidate.getUpcvo().getSelectedUpcType());
            upcvo.setWidth(addNewCandidate.getUpcvo().getSelectedUPCWidth());
            upcvo.setSubBrand(addNewCandidate.getUpcvo().getSelectedSubBrand());
            if (CPSHelper.isNotEmpty(addNewCandidate.getUpcvo().getSelectedWic())) {
                upcvo.setWic(addNewCandidate.getUpcvo().getSelectedWic());
            }
            // Vishnu added upcCheck
            boolean isExistsInProduction = false;
            String upcValue = addNewCandidate.getUpcvo().getSelectedUnitUPC();
            if (!addNewCandidate.isUpcCheck() && CPSHelper.isNotEmpty(upcValue)) {

                try {
                    // fix performance change getProduct to
                    // checkExistProdByUpcBinding5
                    // getAddNewCandidateService().getProduct(upcValue,
                    // CPSConstants.EMPTY_STRING, CPSConstants.EMPTY_STRING);
                    isExistsInProduction = getAddNewCandidateService().checkExistProdByUpcBinding5(upcValue);
                    // isExistsInProduction = true;
                } catch (CPSBusinessException e) {
                    List<CPSMessage> message = e.getMessages();
                    for (CPSMessage cpsMsg : message) {
                        if (CPSConstants.SERVICE_TIME_OUT_ERROR.equalsIgnoreCase(cpsMsg.getMessage())) {
                            throw new CPSBusinessException(new CPSMessage(cpsMsg.getMessage(), CPSMessage.ErrorSeverity.ERROR));
                        }
                    }
                    LOG.error(e.getMessage(), e);
                    // do nothing, continuing the flow
                } catch (CPSGeneralException e) {
                    LOG.error(e.getMessage(), e);
                }
                if (!isExistsInProduction) {
                    dataBaseCheckForUPC = getAddNewCandidateService().checkExistingUPC(upcValue);
                }
            }
            if (dataBaseCheckForUPC || isExistsInProduction) {
                CPSMessage message = new CPSMessage("Entered UPC Already Exists.Please Re Enter!",
                        CPSMessage.ErrorSeverity.VALIDATION);
                throw new CPSBusinessException(message);
            } else {
                if (CPSHelper.isNotEmpty(upcValue))
                    addNewCandidate.getProductVO().addUpcVO(upcvo);
            }
        }

        if (null != addNewCandidate
                .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())) {

            String buyerCode = addNewCandidate
                    .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                    .getBuyerCode();
            String primaryBdm = addNewCandidate
                    .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity()).getBdmCd();
            if (CPSConstant.STRING_A.equalsIgnoreCase(buyerCode)) {
                addNewCandidate.getProductVO().getClassificationVO().setPrimaryBdm(primaryBdm);
            }
        }
    }
    // hungbang added function get average Retail and RetailFor for MRT. 12
    // April 2016
    // ============================begin================================
    @SuppressWarnings("unchecked")
    @RequestMapping(method = RequestMethod.GET, value = RELATIVE_PATH_GET_RETAIL_FOR_MRT)
    public ModelAndView getRetailForMrt(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                       HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        List<MRTUPCVO> mrtUpcVo = addNewCandidate.getMrtvo().getMrtVOs();
        BigDecimal unitRetailMrt = null;
        JSONObject jsonData = new JSONObject();
        String messageWarning = CPSConstant.STRING_EMPTY;
        if (CPSHelper.isNotEmpty(mrtUpcVo)) {
            messageWarning = validateBeforeCaculateMRTMarginNew(mrtUpcVo, addNewCandidate);
            if (CPSHelper.isEmpty(messageWarning)) {
                unitRetailMrt = getUnitRetailMRT(mrtUpcVo);
                if (null != unitRetailMrt) {
                    addNewCandidate.getMrtvo().setUnitRetailAverage(CPSHelper.getStringValue(unitRetailMrt));
                    jsonData.put("unitRetail-average", unitRetailMrt);
                } else {
                    jsonData.put("unitRetail-average", unitRetailMrt);
                }
            } else {
                jsonData.put("unitRetail-average", messageWarning);
            }
        }
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    @SuppressWarnings("unused")
    private String validateBeforeCaculateMRTMarginNew(List<MRTUPCVO> mrtUpcVo, AddNewCandidate form) {
        StringBuilder messageWaring = new StringBuilder();
        List<String> upcLstPriceRq = new ArrayList<String>();
        List<String> upcLstRetail = new ArrayList<String>();
        List<String> upcLstRetail0 = new ArrayList<String>();
        for (MRTUPCVO mrtupcvo2 : mrtUpcVo) {
            if ("priceRequired".equals(mrtupcvo2.getProductVO().getRetailVO().getRetailRadio())) {
                upcLstPriceRq.add(mrtupcvo2.getUnitUPC());
            } else {
                if (CPSHelper.isEmpty(mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap())) {
                    upcLstRetail.add(mrtupcvo2.getUnitUPC());
                }

                if (mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap() != null
                        && ("0".equals(mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap().trim())
                        || "0.00".equals(mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap().trim()))) {
                    upcLstRetail0.add(mrtupcvo2.getUnitUPC());
                }
            }
        }
        if (!upcLstPriceRq.isEmpty()) {
            String rs = StringUtils.join(upcLstPriceRq, ',');
            messageWaring.append(CPSConstants.MARGIN_PENNY_BLANK);
            messageWaring.append(" Because UPC ");
            messageWaring.append(rs);
            messageWaring.append(" has Price Required field checked. ");
        }
        if (!upcLstRetail.isEmpty()) {
            String rs = StringUtils.join(upcLstRetail, ',');
            if (messageWaring.indexOf(CPSConstants.MARGIN_PENNY_BLANK) == -1) {
                messageWaring.append(CPSConstants.MARGIN_PENNY_BLANK);
            }
            messageWaring.append("Please enter Retail For value for UPC ");
            messageWaring.append(rs);
            messageWaring.append(". ");
        }
        if (!upcLstRetail0.isEmpty()) {

            String rs = StringUtils.join(upcLstRetail0, ',');
            if (messageWaring.indexOf(CPSConstants.MARGIN_PENNY_BLANK) == -1) {
                messageWaring.append(CPSConstants.MARGIN_PENNY_BLANK);
            }
            if (messageWaring.indexOf("Please enter") == -1) {
                messageWaring.append("Please enter a valid Retail For value for UPC ");
            } else {
                messageWaring.append(" and enter a valid Retail For value for UPC ");
            }
            messageWaring.append(rs);
            messageWaring.append(". ");
        }

        if (messageWaring != null) {
            return messageWaring.toString();
        }
        return CPSConstants.EMPTY_STRING;
    }
    /**
     * @author hungbang calculate unit retail based on retail vs retail for if
     *         unit retail = retail > 1 ? retail for / retail : retail for
     * @param lstNotDup
     * @return
     */
    private BigDecimal getUnitRetailMRT(List<MRTUPCVO> lstNotDup) {
        BigDecimal result = null;
        if (!lstNotDup.isEmpty()) {
            BigDecimal sumMrt = BigDecimal.ZERO;
            for (MRTUPCVO mrtUpcVo : lstNotDup) {
                BigDecimal devUnitRetail = null;
                BigDecimal retail = CPSHelper.getBigdecimalValue(mrtUpcVo.getProductVO().getRetailVO().getRetail());
                BigDecimal retailFor = CPSHelper
                        .getBigdecimalValue(mrtUpcVo.getProductVO().getRetailVO().getRetailForWrap());
                BigDecimal sellable = CPSHelper.getBigdecimalValue(mrtUpcVo.getSellableUnits());
                // Only retail for in each element UPC is zero
                if (retailFor != null && retailFor.compareTo(BigDecimal.ZERO) == 0) {
                    result = null;
                    break;
                }
                if (retail.compareTo(BigDecimal.ONE) == 1) {
                    devUnitRetail = retailFor.divide(retail, 2, RoundingMode.HALF_UP);
                } else {
                    devUnitRetail = retailFor;
                }
                BigDecimal unitRetailSellable = devUnitRetail.multiply(sellable).setScale(2, RoundingMode.HALF_UP);
                sumMrt = sumMrt.add(unitRetailSellable);
            }
            result = sumMrt;
        }
        return result;

    }
    /**
     * Function for displaying the MRT tab - Vendor details(after saving the
     * vendor details from the DB).
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = RequestMethod.POST, value = RELATIVE_PATH_VENDERMRT_DETAILS)
    public ModelAndView vendorMRTDetails(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                        HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
        String uniquevendorId = req.getParameter("selectedMRTVendorId");
        try {
            CaseVO caseVO = addNewCandidate.getMrtvo().getCaseVO();
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
            VendorVO vendorVO = caseVO.getVendorVO(uniquevendorId);
            if (CPSHelper.isEmpty(vendorVO)) {
                vendorVO = setVendorVOValues(caseVO, uniquevendorId, addNewCandidate);
            }
            if (null != vendorVO) {
                if (addNewCandidate.getProductVO().getClassificationVO() == null) {
                    addNewCandidate.getProductVO().setClassificationVO(new ProductClassificationVO());
                }
                vendorVO.setCountryOfOriginList(getCountryOfOrigin());
                vendorVO.setSeasonalityList(getSeasonality());
                vendorVO.setTop2TopList(getTop2Top());
                vendorVO.setOrderRestrictionList(getOrderRestriction());

                // Order Unit changes
                vendorVO.setOrderUnitList(getOrderUnitList());
                String chnlVal = CPSWebUtil.getChannelValForService(caseVO.getChannelVal());
                if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
                    vendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
                    vendorVO.setMasterPack(caseVO.getMasterPack());
                } else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
                    vendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
                    vendorVO.setShipPack(caseVO.getShipPack());
                } else {
                    vendorVO.setChannelVal(CPSConstants.CHANNEL_BOTH);
                    vendorVO.setShipPack(caseVO.getShipPack());
                    vendorVO.setMasterPack(caseVO.getMasterPack());
                }

                List<VendorLocationVO> vendorLocationList = addNewCandidate.getVendorVO().getVendorLocationList();
                String vendorLocationCode = CPSHelper
                        .getTrimmedValue(CPSHelper.getStringValue(vendorVO.getOriginalVendorLocNumber()));
                for (VendorLocationVO vendorLocationVO : vendorLocationList) {
                    if (vendorLocationVO.getVendorId().equals(vendorLocationCode)) {
                        vendorVO.setVendorChannelVal(vendorLocationVO.getVendorLocationType());
                        break;
                    }
                }
                // Fix 8456
                if (!CPSHelper.isEmpty(vendorVO.getCostOwnerVal()) && Integer.parseInt(vendorVO.getCostOwnerVal())>0) {
                    //addCandidateForm.setCostOwners(setCostOwnerValuesForMRT(addCandidateForm,
                    //CPSHelper.getIntegerValue(vendorVO.getCostOwnerVal())));
                    List<BaseJSFVO> t2T = new ArrayList<BaseJSFVO>();

                    // Fix 1241
                    try {
                        t2T = getAddNewCandidateService()
                                .getT2TbyCostOwner(CPSHelper.getIntegerValue(vendorVO.getCostOwnerVal()));
                    } catch (Exception e) {
                        LOG.error(e.getMessage(), e);
                    }
                    addNewCandidate.setTopToTops(t2T);
                } else {
                    List<BaseJSFVO> t2T = new ArrayList<BaseJSFVO>();
                    boolean contain = false;
                    for(BaseJSFVO base:addNewCandidate.getCostOwners()) {
                        if(!CPSHelper.isEmpty(vendorVO.getCostOwnerVal()) && Integer.parseInt(vendorVO.getCostOwnerVal())==0 && vendorVO.getCostOwnerVal().equalsIgnoreCase(base.getId())) {
                            t2T.add(base);
                            contain = true;
                            break;
                        }
                    }
                    if(!contain && !CPSHelper.isEmpty(vendorVO.getCostOwnerVal()) && Integer.parseInt(vendorVO.getCostOwnerVal())==0) {
                        addNewCandidate.setTopToTops(CPSHelper.insertBlankSelect(t2T));
                    }
                    addNewCandidate.setTopToTops(t2T);
                }
                vendorVO.setVendorLocationList(vendorLocationList);
                addNewCandidate.getVendorVO().setVendorLocationList(vendorLocationList);

                populateMRTDetailsFromUPC(addNewCandidate);

            }

            // keep selected vendor VO in form so that it is accessible while
            // saving facilities
            addNewCandidate.setVendorVO(vendorVO);
            modifyRetailForMrt(addNewCandidate);
            req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, addNewCandidate.getVendorVO());
        } catch (Exception exp) {
            LOG.error(exp.getMessage(), exp);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_MRT_MAIN_AJAX_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Sets the vendor vo values.
     *
     * @param caseVO
     *            the case vo
     * @param uniquevendorId
     *            the uniquevendor id
     * @param addCandidateForm
     *            the add candidate form
     * @return the vendor vo
     */
    private VendorVO setVendorVOValues(CaseVO caseVO, String uniquevendorId, AddNewCandidate addCandidateForm) {
        List<VendorVO> vendorVOs = caseVO.getVendorVOs();
        VendorVO vendorVO = new VendorVO();
        for (VendorVO vendorVO2 : vendorVOs) {
            if (uniquevendorId.equalsIgnoreCase(vendorVO2.getUniqueId())) {
                vendorVO = vendorVO2;
                break;
            }
        }
        return vendorVO;
    }
    /**
     * Populate mrt details from upc.
     *
     * @param candidateForm
     *            the candidate form
     */
    private void populateMRTDetailsFromUPC(AddNewCandidate candidateForm) {
        List<VendorVO> vendors = candidateForm.getMrtvo().getCaseVO().getVendorVOs();
        List<MRTUPCVO> mrts = candidateForm.getMrtvo().getMrtVOs();
        if (vendors != null && !vendors.isEmpty()) {
            CaseVO caseVo = candidateForm.getMrtvo().getCaseVO();
            Iterator<MRTUPCVO> mrtIterator = mrts.iterator();
            MRTUPCVO selectedUPC = null;
            if (CPSConstants.CHANNEL_DSD.equals(caseVo.getChannel().trim())) {
                VendorVO vendor = vendors.get(0);
                VendorLocDeptVO details = candidateForm.getSessionVO().getVendorInfo(vendor.getVendorLocationVal());
                while (mrtIterator.hasNext() && details != null) {
                    MRTUPCVO upc = mrtIterator.next();
                    if (CPSHelper.isNotEmpty(candidateForm
                            .getClassCommodityVO(upc.getProductVO().getClassificationVO().getCommodity()))) {
                        if (candidateForm.getClassCommodityVO(upc.getProductVO().getClassificationVO().getCommodity())
                                .getDeptId().equals(details.getDepartment())) {
                            selectedUPC = upc;
                            break;
                        }
                    }
                }
            } else if (CPSConstants.CHANNEL_WHS.equals(caseVo.getChannel().trim())) {
                VendorVO vendor = vendors.get(0);
                VendorLocDeptVO details = candidateForm.getSessionVO().getVendorInfo(vendor.getVendorLocationVal());
                while (mrtIterator.hasNext() && details != null) {
                    MRTUPCVO upc = mrtIterator.next();
                    if (null != upc.getProductVO().getClassificationVO()
                            && null != upc.getProductVO().getClassificationVO().getClassField()) {
                        if (upc.getProductVO().getClassificationVO().getClassField()
                                .equals(details.getCommodityClass().toString())) {
                            selectedUPC = upc;
                            break;
                        }
                    }
                }
            } else if (CPSConstants.CHANNEL_BOTH.equals(caseVo.getChannel().trim())) {
                Iterator<VendorVO> vendIterator = vendors.iterator();
                while (vendIterator.hasNext()) {
                    VendorVO vendor = vendIterator.next();
                    if (("V").equals(vendor.getVendorLocationTypeCode())) {
                        VendorLocDeptVO details = candidateForm.getSessionVO()
                                .getVendorInfo(vendor.getVendorLocationVal());
                        while (mrtIterator.hasNext() && details != null) {
                            MRTUPCVO upc = mrtIterator.next();
                            if (null != upc.getProductVO().getClassificationVO()
                                    && null != upc.getProductVO().getClassificationVO().getClassField()) {
                                if (upc.getProductVO().getClassificationVO().getClassField()
                                        .equals(details.getCommodityClass().toString())) {
                                    selectedUPC = upc;
                                    break;
                                }
                            }
                        }
                        break;
                    }
                }

                if (selectedUPC == null) {// No WHS Vendor;
                    VendorVO vendor = vendors.get(0);
                    VendorLocDeptVO details = candidateForm.getSessionVO().getVendorInfo(vendor.getVendorLocationVal());
                    while (mrtIterator.hasNext() && details != null) {
                        MRTUPCVO upc = mrtIterator.next();
                        if (CPSHelper.isNotEmpty(candidateForm
                                .getClassCommodityVO(upc.getProductVO().getClassificationVO().getCommodity()))) {
                            if (candidateForm
                                    .getClassCommodityVO(upc.getProductVO().getClassificationVO().getCommodity())
                                    .getDeptId().equals(details.getDepartment())) {
                                selectedUPC = upc;
                                break;
                            }
                        }
                    }
                }

            }
            if (selectedUPC != null) {
                candidateForm.getProductVO().getClassificationVO()
                        .setCommodity(selectedUPC.getProductVO().getClassificationVO().getCommodity());
                candidateForm.getProductVO().getClassificationVO()
                        .setCommodityName(selectedUPC.getProductVO().getClassificationVO().getCommodityName());
                candidateForm.getProductVO().getClassificationVO().setCommodityNameValue(
                        selectedUPC.getProductVO().getClassificationVO().getCommodityNameValue());
                candidateForm.getProductVO().getClassificationVO()
                        .setSubCommodity(selectedUPC.getProductVO().getClassificationVO().getSubCommodity());
                candidateForm.getProductVO().getClassificationVO()
                        .setSubCommodityName(selectedUPC.getProductVO().getClassificationVO().getSubCommodityName());
                candidateForm.getProductVO().getClassificationVO()
                        .setClassField(selectedUPC.getProductVO().getClassificationVO().getClassField());
                candidateForm.getProductVO().getClassificationVO()
                        .setClassDesc(selectedUPC.getProductVO().getClassificationVO().getClassDesc());

                candidateForm.getMrtvo().getCaseVO()
                        .setDeptId(candidateForm
                                .getClassCommodityVO(selectedUPC.getProductVO().getClassificationVO().getCommodity())
                                .getDeptId());
            }
        }
    }
    /**
     * set Profit and Margin when modify MRT
     *
     * @param candidateForm
     * @throws Exception
     */

    public void modifyRetailForMrt(AddNewCandidate candidateForm) throws Exception {
        BigDecimal unitRetailAverage = null;
        List<MRTUPCVO> mrtUpcVo = candidateForm.getMrtvo().getMrtVOs();
        String messageWarning = CPSConstant.STRING_EMPTY;
        if (CPSHelper.isNotEmpty(mrtUpcVo)) {
            messageWarning = validateBeforeCaculateMRTMargin(mrtUpcVo, candidateForm);
        }
        if (CPSHelper.isEmpty(messageWarning)) {
            if (CPSHelper.isEmpty(candidateForm.getMrtvo().getUnitRetailAverage())) {
                List<MRTUPCVO> lstNotDup = mrtUpcVo;
                BigDecimal unitRetailMrt = getUnitRetailMRT(lstNotDup);

                if (unitRetailMrt != null) {
                    candidateForm.getMrtvo().setUnitRetailAverage(CPSHelper.getStringValue(unitRetailMrt));
                    unitRetailAverage = unitRetailMrt;
                }
            } else {
                unitRetailAverage = new BigDecimal(candidateForm.getMrtvo().getUnitRetailAverage());
            }
            Map<BigDecimal, BigDecimal> mapData = getDataMarginAndProfit(candidateForm, unitRetailAverage);
            String listCost = candidateForm.getVendorVO().getListCostFormatted();
            if (CPSHelper.isNotEmpty(listCost)) {
                for (Map.Entry<BigDecimal, BigDecimal> entry : mapData.entrySet()) {
                    if (null != entry.getKey()) {
                        candidateForm.getVendorVO()
                                .setPercentMarginLabelFormatted(CPSHelper.getStringValue(entry.getKey()));
                    }
                    if (null != entry.getValue()) {
                        candidateForm.getVendorVO().setPennyProfitLabelFormatted(
                                CPSConstants.CHARACTER_DOLLAR + CPSHelper.getStringValue(entry.getValue()));
                    }
                }
            } else {
                candidateForm.getVendorVO().setPercentMarginLabelFormatted(CPSConstants.EMPTY_STRING);
                candidateForm.getVendorVO().setPennyProfitLabelFormatted(CPSConstants.EMPTY_STRING);
            }
        } else {
            candidateForm.getVendorVO().setMarginMessageWarning(messageWarning);
            candidateForm.getVendorVO().setPercentMarginLabelFormatted(CPSConstants.EMPTY_STRING);
            candidateForm.getVendorVO().setPennyProfitLabelFormatted(CPSConstants.EMPTY_STRING);
        }

    }
    /**
     * @author hungbang check exists a candidate have retail For is null. If
     *         have then return false, else return true
     * @param mrtUpcVo
     * @return boolean
     */
    @SuppressWarnings("unused")
    private String validateBeforeCaculateMRTMargin(List<MRTUPCVO> mrtUpcVo, AddNewCandidate form) {
        StringBuilder messageWaring = new StringBuilder();
        List<String> upcLstPriceRq = new ArrayList<String>();
        List<String> upcLstRetail = new ArrayList<String>();
        List<String> upcLstRetail0 = new ArrayList<String>();
        for (MRTUPCVO mrtupcvo2 : mrtUpcVo) {
            if ("priceRequired".equals(mrtupcvo2.getProductVO().getRetailVO().getRetailRadio())) {
                upcLstPriceRq.add(mrtupcvo2.getUnitUPC());
            } else {
                if (CPSHelper.isEmpty(mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap())) {
                    upcLstRetail.add(mrtupcvo2.getUnitUPC());
                }

                if (mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap() != null
                        && ("0".equals(mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap().trim())
                        || "0.00".equals(mrtupcvo2.getProductVO().getRetailVO().getRetailForWrap().trim()))) {
                    upcLstRetail0.add(mrtupcvo2.getUnitUPC());
                }
            }
        }
        if (!upcLstPriceRq.isEmpty()) {
            String rs = StringUtils.join(upcLstPriceRq, ',');
            messageWaring.append(CPSConstants.MARGIN_PENNY_BLANK);
            messageWaring.append(" Because UPC ");
            messageWaring.append(rs);
            messageWaring.append(" has Price Required field checked. ");
        }
        if (!upcLstRetail.isEmpty()) {
            String rs = StringUtils.join(upcLstRetail, ',');
            if (messageWaring.indexOf(CPSConstants.MARGIN_PENNY_BLANK) == -1) {
                messageWaring.append(CPSConstants.MARGIN_PENNY_BLANK);
            }
            messageWaring.append("Please enter Retail For value for UPC ");
            messageWaring.append(rs);
            messageWaring.append(". ");
        }
        if (!upcLstRetail0.isEmpty()) {
            String rs = StringUtils.join(upcLstRetail0, ',');
            if (messageWaring.indexOf(CPSConstants.MARGIN_PENNY_BLANK) == -1) {
                messageWaring.append(CPSConstants.MARGIN_PENNY_BLANK);
            }
            if (messageWaring.indexOf("Please enter") == -1) {
                messageWaring.append("Please enter a valid Retail For value for UPC ");
            } else {
                messageWaring.append(" and enter a valid Retail For value for UPC ");
            }
            messageWaring.append(rs);
            messageWaring.append(". ");
        }

        if (CPSHelper.isEmpty(form.getVendorVO().getListCostFormatted())) {
            messageWaring.append("\n MRT is missing List Cost. ");
        }
        if (messageWaring != null) {
            return messageWaring.toString();
        }
        return CPSConstants.EMPTY_STRING;
    }
    /**
     * @author hungbang calculate margin and profit based on average unit retail
     *         and unit cost vs list cost
     * @param candidateForm
     * @param unitRetailAverage
     * @return
     */
    private Map<BigDecimal, BigDecimal> getDataMarginAndProfit(AddNewCandidate candidateForm,
                                                               BigDecimal unitRetailAverage) {
        Map<BigDecimal, BigDecimal> mapData = new HashMap<BigDecimal, BigDecimal>();
        String listCost = candidateForm.getVendorVO().getListCostFormatted();
        String unitCost = null;
        BigDecimal percentMargin = null;
        BigDecimal pennyProfit = null;
        if ("BOTH".equals(candidateForm.getMrtvo().getCaseVO().getChannelVal())) {
            unitCost = candidateForm.getVendorVO().getUnitCostLabelFormattedBoth();
        } else {
            unitCost = candidateForm.getVendorVO().getUnitCostLabelFormatted();
        }
        BigDecimal decimalUnitCost = null;
        BigDecimal decimalListCost = null;
        if (CPSHelper.isNotEmpty(unitCost)) {
            decimalUnitCost = CPSHelper.getBigdecimalValue(CPSHelper.getFormattedDecimal(unitCost));
        }
        if (listCost != null) {
            decimalListCost = CPSHelper.getBigdecimalValue(CPSHelper.getFormattedDecimal(listCost));
        }
        if (decimalUnitCost != null && decimalListCost != null && unitRetailAverage != null) {
            percentMargin = unitRetailAverage.subtract(decimalUnitCost)
                    .divide(unitRetailAverage, 4, RoundingMode.HALF_UP).multiply(new BigDecimal(100)).setScale(2);
            pennyProfit = unitRetailAverage.subtract(decimalUnitCost).setScale(2, RoundingMode.HALF_UP);
        }
        mapData.put(percentMargin, pennyProfit);
        return mapData;
    }
    /**
     * View factories mrt.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VIEW_FACTORIES_MRT)
    public ModelAndView viewFactoriesMRT(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                         HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        List<FactoryVO> factories = getCommonService().getFactories();
        // Identify which case, which vendor & pass to jsp for processing.
        String vendorID = req.getParameter("selectedVendorId");
        req.setAttribute("selectedVendorId", vendorID);

        req.setAttribute(CPSConstants.FACTORY_LIST, factories);
        req.setAttribute(CPSConstants.CURRENT_APP_NAME, "Import Facilities");
        String vendorType = getChannelType(vendorID, addNewCandidate);
        CaseVO caseVO = addNewCandidate.getMrtvo().getCaseVO();
        String itemID = caseVO.getPsItemId().toString();
        List<WareHouseVO> list = getImportedWarehouses(vendorID, itemID, vendorType, caseVO.getClassCode());

        addNewCandidate.setWareHouseList(list);
        addNewCandidate.setItemID(itemID);
        addNewCandidate.setVendorId(vendorID);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_VIEW_FACTORIES_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Gets the channel type.
     *
     * @param vendorId
     *            the vendor id
     * @param form
     *            the form
     * @return the channel type
     */
    private String getChannelType(String vendorId, AddNewCandidate form) {
        String vendorType = CPSConstants.EMPTY_STRING;
        List<VendorLocationVO> vendors = form.getVendorVO().getVendorLocationList();
        for (VendorLocationVO v : vendors) {
            if (CPSHelper.checkVendorNumber(v.getVendorId()).equalsIgnoreCase(CPSHelper.checkVendorNumber(vendorId))) {
                vendorType = v.getVendorLocationType().trim();
            }
        }
        return vendorType;
    }
    /**
     * Gets the imported warehouses.
     *
     * @param uniquevendorId
     *            the uniquevendor id
     * @param itemId
     *            the item id
     * @param vendorType
     *            the vendor type
     * @return the imported warehouses
     * @throws CPSSystemException
     *             the CPS system exception
     * @throws CPSGeneralException
     *             the CPS general exception
     * @throws CPSBusinessException
     *             the CPS business exception
     * @throws Exception
     *             the exception
     */
    private List<WareHouseVO> getImportedWarehouses(String uniquevendorId, String itemId, String vendorType, String classCode)
            throws CPSSystemException, CPSGeneralException, CPSBusinessException, Exception {
        // To get the Facility Code
        VendorList vendorList = new VendorList(null, null, CPSHelper.getIntegerValue(uniquevendorId));
        List<WareHouseVO> wareHouseListTemp;
        List<WareHouseVO> fetchWareHouseList = new ArrayList<WareHouseVO>();
        List<WareHouseVO> facilityList = getCommonService().getWareHouseList(vendorList, classCode);
        List<WareHouseVO> list = new ArrayList<WareHouseVO>();
        wareHouseListTemp = getWareHouseList(facilityList, CPSHelper.getTrimmedValue(uniquevendorId), itemId,
                vendorType);
        if (null != wareHouseListTemp) {
            fetchWareHouseList = getWareHouseDetails(wareHouseListTemp, CPSHelper.getTrimmedValue(uniquevendorId),
                    itemId, vendorType);
        }
        for (WareHouseVO wareHouseVO : wareHouseListTemp) {
            if (fetchWareHouseList.contains(wareHouseVO)) {
                wareHouseVO.setCheck(true);
            } else {
                wareHouseVO.setCheck(false);
            }
            wareHouseVO.setVendorWHSNumber(CPSHelper.getTrimmedValue(uniquevendorId));
            list.add(wareHouseVO);
        }
        return list;
    }
    /**
     * Gets the ware house list.
     *
     * @param wareHouseList
     *            the ware house list
     * @param uniquevendorId
     *            the uniquevendor id
     * @param itemId
     *            the item id
     * @param vendorType
     *            the vendor type
     * @return the ware house list
     */
    private List<WareHouseVO> getWareHouseList(List<WareHouseVO> wareHouseList, String uniquevendorId, String itemId,
                                               String vendorType) {
        List<WareHouseVO> wareHouseListTemp = new ArrayList<WareHouseVO>();
        for (WareHouseVO wareHouseVO : wareHouseList) {
            wareHouseVO.setItemId(itemId);
            wareHouseVO.setVendorNumber(uniquevendorId);
            wareHouseVO.setVendorType(vendorType);
            wareHouseListTemp.add(wareHouseVO);
        }
        return wareHouseListTemp;
    }
    /**
     * Gets the ware house details.
     *
     * @param wareHouseList
     *            the ware house list
     * @param vendorId
     *            the vendor id
     * @param itemId
     *            the item id
     * @param vendorType
     *            the vendor type
     * @return the ware house details
     * @throws CPSBusinessException
     *             the CPS business exception
     * @throws Exception
     *             the exception
     */
    public List<WareHouseVO> getWareHouseDetails(List<WareHouseVO> wareHouseList, String vendorId, String itemId,
                                                 String vendorType) throws CPSBusinessException, Exception {
        List<WareHouseVO> baseJSFVOList = getAddNewCandidateService().fetchWareHouseDetails(vendorId, vendorType,
                itemId, wareHouseList);
        return baseJSFVOList;

    }
    /**
     * shows the 'authorize whs' pop up.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_AUTH_WHS)
    public ModelAndView authWHS(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                         HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(),addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        setInputForwardValue(req, RELATIVE_PATH_AUTHORIZE_WHS_PAGE);
        addNewCandidate.setRejectClose(true);
        CPSMessage message = null;
        String uniquevendorId = req.getParameter("selectedVendorId");
        String caseId = req.getParameter("selectedItemId");
        CaseVO caseVO = setCaseVOValues(caseId, addNewCandidate);
        String itemId = CPSHelper.getTrimmedValue(caseVO.getPsItemId() + CPSConstants.EMPTY_STRING);

        String vendorType = getChannelType(uniquevendorId, addNewCandidate);
        List<WareHouseVO> list = new ArrayList<WareHouseVO>();
        VendorVO vendorVO = new VendorVO();
        // Fix 1201. vendor number should be 6 digits
        String fmtVendorId = CPSHelper.checkVendorNumber(uniquevendorId);
        try {
            list = getImportedWarehouses(fmtVendorId, itemId, vendorType, caseVO.getClassCode());
            addNewCandidate.setRejectClose(false);
        } catch (CPSBusinessException e) {
            LOG.error(e.getMessage(), e);
            List<CPSMessage> msgList = e.getMessages();
            String messg = CPSConstants.SERVICE_ERROR;
            for (CPSMessage msg : msgList) {
                messg = CPSHelper.getTrimmedValue(msg.getMessage());
            }
            message = new CPSMessage(messg, CPSMessage.ErrorSeverity.INFO);
            saveMessage(addNewCandidate, message);
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
            // keep selected vendor VO in form so that it is accessible while
            // saving facilities
            addNewCandidate.setVendorVO(vendorVO);

            addNewCandidate.setRejectClose(true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            message = new CPSMessage(CPSConstants.SERVICE_ERROR, CPSMessage.ErrorSeverity.INFO);
            saveMessage(addNewCandidate, message);
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
            // keep selected vendor VO in form so that it is accessible while
            // saving facilities
            addNewCandidate.setVendorVO(vendorVO);

            addNewCandidate.setRejectClose(true);
        }
        addNewCandidate.setWareHouseList(list);
        addNewCandidate.setVendorId(uniquevendorId);
        addNewCandidate.setItemID(itemId);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_AUTHORIZE_WHS_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Sets the case vo values.
     *
     * @param uniqueId
     *            the unique id
     * @param addCandidateForm
     *            the add candidate form
     * @return the case vo
     */
    private CaseVO setCaseVOValues(String uniqueId, AddNewCandidate addCandidateForm) {
        List<CaseVO> caseVOs = addCandidateForm.getProductVO().getCaseVOs();
        CaseVO caseVO = new CaseVO();
        for (CaseVO eachCaseVO : caseVOs) {
            if (uniqueId.equalsIgnoreCase(eachCaseVO.getUniqueId())) {
                caseVO = eachCaseVO;
                /**
                 * Fix defect # 544
                 */
                setCaseUPCVO(caseVO, addCandidateForm.getProductVO());
                break;
            }
        }
        return caseVO;
    }
    /**
     * Sets the case upcvo.
     *
     * @param caseVO
     *            the case vo
     * @param productVO
     *            the product vo
     */
    private void setCaseUPCVO(CaseVO caseVO, ProductVO productVO) {
        if (CPSHelper.isEmpty(caseVO.getCaseUPCVOs())) {
            List<UPCVO> list = productVO.getUpcVO();
            // khoapkl
            // caseVO.clearCaseUPCVOs();
            for (UPCVO upcvo : list) {
                CaseUPCVO caseUPCVO = new CaseUPCVO();
                caseUPCVO.setCheckDigit(upcvo.getUnitUpc10());
                if (isPrimaryAndLinked(productVO.getPrimaryUPC(), upcvo.getUnitUpc())) {
                    caseUPCVO.setPrimary(true);
                    caseUPCVO.setLinked(true);
                }
                caseUPCVO.setSize(upcvo.getSize());
                if (CPSHelper.isNotEmpty(upcvo.getUnitMeasureCode())) {
                    caseUPCVO.setUnitMeasureCode(CPSHelper.translateUOMCode(upcvo.getUnitMeasureCode()));
                    caseUPCVO.setUnitMeasureDesc(upcvo.getUnitMeasureDesc());
                } else {
                    caseUPCVO.setUnitMeasureCode(CPSConstant.SPACE_STRING);
                    caseUPCVO.setUnitMeasureDesc("NOUNPR");
                }

                if (CPSHelper.isNotEmpty(upcvo.getUnitSize())) {
                    caseUPCVO.setUnitSize(upcvo.getUnitSize());
                }
                caseUPCVO.setUnitUpc(CPSHelper.getPadding(upcvo.getUnitUpc()));

                if (CPSHelper.isNotEmpty(upcvo.getUpcType())) {
                    caseUPCVO.setUpcType(upcvo.getUpcType());
                }
                caseUPCVO.setWorkRequest(upcvo.getWorkRequest());
                caseUPCVO.setNewDataSw(upcvo.getNewDataSw());
                caseVO.addCaseUPCVO(caseUPCVO);
            }
        } else {
            // Set the desc if empty
            List<CaseUPCVO> caseupcvos = caseVO.getCaseUPCVOs();
            List<UPCVO> list = productVO.getUpcVO();

            for (CaseUPCVO caseUPCVO : caseupcvos) {
                if (CPSHelper.isEmpty(caseUPCVO.getUnitMeasureDesc())) {
                    for (UPCVO upcvo : list) {
                        if (CPSHelper.checkEqualValue(caseUPCVO.getUnitUpc(), upcvo.getUnitUpc())) {
                            caseUPCVO.setUnitMeasureDesc(upcvo.getUnitMeasureDesc());
                            caseUPCVO.setUnitSize(upcvo.getUnitSize());
                            break;
                        }
                    }
                }
            }
            // Revert values if system is throwing the error message "Current
            // UPC type is not available for DSD Case. Please modify"
            // and clicking on Cancel Selected Case
            if ("DSD".equalsIgnoreCase(caseVO.getChannelVal())) {
                for (CaseUPCVO caseUpc : caseupcvos) {
                    // Check whether ITMUPC is linked
                    if (caseUpc.isLinked()) {
                        if ("ITUPC".equalsIgnoreCase(caseUpc.getUpcType())) {
                            caseUpc.setLinked(false);
                            caseUpc.setPrimary(false);
                            break;
                        }
                    }
                }
            }
        }
    }
    /**
     * handles the 'viewStores' tab of the tab view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VIEW_STORES)
    public ModelAndView viewStores(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                HttpServletResponse resp) throws Exception {
        addNewCandidate.getMessages().clear();
        addNewCandidate.setSession(req.getSession());
        setInputForwardValue(req, RELATIVE_PATH_VIEW_STORE_PAGE);
        setForm(req, addNewCandidate);
        addNewCandidate.setPreventUpdateStore(false);
        addNewCandidate.setRejectClose(true);
        addNewCandidate.clearStoreVOs();
        addNewCandidate.setAuthorizeServiceMessage(CPSConstants.EMPTY_STRING);
        String uniquevendorId = req.getParameter("selectedVendorId");
        String caseId = req.getParameter("selectedItemId");
        CaseVO caseVO = setCaseVOValues(caseId, addNewCandidate);
        String itemId = CPSHelper.getTrimmedValue(caseVO.getPsItemId() + CPSConstants.EMPTY_STRING);
        String listCost = req.getParameter("listCost");
        listCost = (listCost != null && !listCost.equalsIgnoreCase(CPSConstants.EMPTY_STRING)) ? listCost : CPSConstants.ZERO_STRING;
        List<StoreVO> fetchDBStoreList = getAddNewCandidateService().fetchStoreData(itemId, uniquevendorId);
        Map<String, String> allVendorDsdHashMap = null;
        try {
            allVendorDsdHashMap = getCommonService().getAllApVendorAsHashMap();
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        if (allVendorDsdHashMap != null && !allVendorDsdHashMap.isEmpty()) {
            if (CPSHelper.isNotEmpty(allVendorDsdHashMap.get(uniquevendorId))) {
                boolean flag = getAddNewCandidateService()
                        .checkPreventUpdateStore(Integer.valueOf(allVendorDsdHashMap.get(uniquevendorId)));
                addNewCandidate.setPreventUpdateStore(flag);
            }
        }
        if (fetchDBStoreList.isEmpty()) {
            // Production Data Base
            String deptNbr = null;
            String subDeptNbdr = null;

            // 958 enhancements
            VendorVO vendor = addNewCandidate.getVendorVO();
            if (CPSHelper.isNotEmpty(vendor)) {
                if (CPSHelper.isNotEmpty(vendor.getDept()) && CPSHelper.isNotEmpty(vendor.getSubDeptId())) {
                    deptNbr = vendor.getDept();
                    subDeptNbdr = vendor.getSubDeptId();
                }
            }

            if (CPSHelper.isEmpty(deptNbr) || CPSHelper.isEmpty(subDeptNbdr)) {
                if (null != addNewCandidate.getProductVO().getClassificationVO().getCommodity() && null != addNewCandidate
                        .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())) {
                    deptNbr = addNewCandidate
                            .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                            .getDeptId();
                    subDeptNbdr = addNewCandidate
                            .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                            .getSubDeptId();
                    if (deptNbr.length() < 2) {
                        deptNbr = CPSConstants.ZERO_STRING + deptNbr;
                    }
                }
            }

            List<StoreVO> viewStoreList = new ArrayList<StoreVO>();
            try {
                viewStoreList = getCommonService().getViewStoresList(uniquevendorId, deptNbr, subDeptNbdr, listCost,
                        itemId);
            } catch (CPSBusinessException e) {
                LOG.error(e.getMessage(), e);
                List<CPSMessage> list = e.getMessages();
                for (CPSMessage message : list) {
                    addNewCandidate.setAuthorizeServiceMessage(CPSHelper.getTrimmedValue(message.getMessage()));
                }
            }
            // Production Data Ends
            if (!viewStoreList.isEmpty()) {
                setStoreVO(addNewCandidate, viewStoreList);
                addNewCandidate.setRejectClose(false);
            } else {
                addNewCandidate.setRejectClose(true);
                CPSMessage message = new CPSMessage(BusinessConstants.SERVICE_ERROR_NO_RECORDS_FOUND,
                        CPSMessage.ErrorSeverity.INFO);
                saveMessage(addNewCandidate, message);
                req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            }
        } else {
            addNewCandidate.setRejectClose(false);
            setStoreVO(addNewCandidate, fetchDBStoreList);
        }
        addNewCandidate.setListCost(listCost);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_VIEW_STORE_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Sets the store vo.
     *
     * @param candidateForm
     *            the candidate form
     * @param storeVOList
     *            the store vo list
     */
    private void setStoreVO(AddNewCandidate candidateForm, List<StoreVO> storeVOList) {
        List<BaseJSFVO> costGroups = new ArrayList<BaseJSFVO>();
        // Get the conflict list
        List<ConflictStoreVO> conflictList = conflictStore(storeVOList);
        for (StoreVO storeVO : storeVOList) {
            String costGroup = storeVO.getCostGroup();
            BaseJSFVO baseJSFVO = new BaseJSFVO(costGroup, costGroup);
            if (!costGroups.contains(baseJSFVO)) {
                costGroups.add(baseJSFVO);
            }
            String storeId = storeVO.getStoreId() + CPSConstants.EMPTY_STRING;
            long store = storeVO.getStoreId();
            if (CPSHelper.isNotEmpty(conflictList)) {
                // remove stores that resolved conflict
                if (!storeVO.isStoreRemoved()) {
                    for (ConflictStoreVO conflictStore : conflictList) {
                        if (store == conflictStore.getConflictStoreId()) {
                            storeVO.setConflictStore(true);
                            break;
                        }
                    }
                }
            }
            String storeAbbrevation = getStoreAbbrevation(storeId);
            storeVO.setStoreAbbreviation(storeAbbrevation);
            // set storeRemoved value to match to AUTHN_SW in DB
            if (CPSHelper.getTrimmedValue(storeVO.getAuthorizationSW()).equalsIgnoreCase(CPSConstant.STRING_N)) {
                storeVO.setStoreRemoved(true);
            } else {
                storeVO.setStoreRemoved(false);
            }
            // Fix PIM 526
            // storeVO.setUpdateData(candidateForm.isPreventUpdateStore());
            candidateForm.addStoreVOs(storeVO);
            candidateForm.setCostGroups(costGroups);
        }
        // / Create CostGroup - Store relation Map.
        createCostGrpStoreMap(candidateForm);
    }
    /**
     * Conflict store.
     *
     * @param stoVOList
     *            the sto vo list
     * @return the list
     */
    private List<ConflictStoreVO> conflictStore(List<StoreVO> stoVOList) {
        List<StoreVO> list = new ArrayList<StoreVO>();
        List<BaseJSFVO> storeIDs = new ArrayList<BaseJSFVO>();
        List<ConflictStoreVO> conflictStoreVO = new ArrayList<ConflictStoreVO>();
        for (StoreVO storeVO : stoVOList) {
            StoreVO storeVO1 = new StoreVO();
            String storeId = CPSHelper.getStringValue(storeVO.getStoreId());
            BaseJSFVO baseJSFVO = new BaseJSFVO(storeId, storeId);
            if (!storeIDs.contains(baseJSFVO)) {
                storeIDs.add(baseJSFVO);
                storeVO1.setVendorNumber(storeVO.getVendorNumber());
                storeVO1.setItemId(storeVO.getItemId());
                storeVO1.setListCost(storeVO.getListCost());
                storeVO1.setStoreId(storeVO.getStoreId());
                storeVO1.setCostGroup(storeVO.getCostGroup());
                storeVO1.setAuthorizationSW(storeVO.getAuthorizationSW());
                list.add(storeVO1);
            }
        }
        if (!list.isEmpty()) {
            try {
                conflictStoreVO = getAddNewCandidateService().conflictStoreData(list);
            } catch (CPSBusinessException e) {
                LOG.error(e.getMessage(), e);
                conflictStoreVO = new ArrayList<ConflictStoreVO>();
            }
        }
        return conflictStoreVO;
    }
    /**
     * Gets the store abbrevation.
     *
     * @param storeId
     *            the store id
     * @return the store abbrevation
     */
    private String getStoreAbbrevation(String storeId) {
        String abbrevation = CPSConstants.EMPTY_STRING;
        BaseJSFVO baseJSFVO = getCommonService().getStoresAsBaseJSFVOs().get(storeId);
        if (null != baseJSFVO) {
            if (CPSHelper.isNotEmpty(baseJSFVO.getName()))
                abbrevation = baseJSFVO.getName();
        }
        return abbrevation;
    }
    /**
     * Creates the cost grp store map.
     *
     * @param candidateForm
     *            the candidate form
     */
    private void createCostGrpStoreMap(AddNewCandidate candidateForm) {
        Map<String, List<StoreVO>> costGrpStoreMap = new HashMap<String, List<StoreVO>>();
        List<StoreVO> storeVOs = candidateForm.getStoreVOs();
        List<String> costGroups = new ArrayList<String>();
        if (storeVOs != null) {
            Iterator<StoreVO> storeVOIterator = storeVOs.iterator();
            while (storeVOIterator.hasNext()) {
                StoreVO storeVO = storeVOIterator.next();
                String costGroup = storeVO.getCostGroup();

                List<StoreVO> voList = costGrpStoreMap.get(costGroup);
                if (voList == null) {
                    voList = new ArrayList<StoreVO>();
                    costGrpStoreMap.put(costGroup, voList);
                    costGroups.add(costGroup);
                }
                voList.add(storeVO);
            }
            // Fix 1308. Sort the Map.
            for (String cstGrp : costGroups) {
                List<StoreVO> stores = costGrpStoreMap.get(cstGrp);
                Collections.sort(stores, new Comparator<StoreVO>() {
                    public int compare(StoreVO storeVO1, StoreVO storeVO2) {
                        return Long.valueOf(storeVO1.getStoreId()).compareTo(Long.valueOf(storeVO2.getStoreId()));
                    }
                });
            }
            candidateForm.setCostGrpStoreMap(costGrpStoreMap);
        }
    }

    /**
     * View mrt stores.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     *
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VIEW_MRT_STORES)
    public ModelAndView viewMRTStores(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                   HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setInputForwardValue(req, RELATIVE_PATH_VIEW_STORE_PAGE);
        setForm(req, addNewCandidate);
        addNewCandidate.setRejectClose(true);
        addNewCandidate.clearStoreVOs();
        addNewCandidate.setPreventUpdateStore(false);
        addNewCandidate.setAuthorizeServiceMessage(CPSConstants.EMPTY_STRING);
        String uniquevendorId = req.getParameter("selectedVendorId");
        String itemId = CPSHelper.getTrimmedValue(addNewCandidate.getMrtvo().getCaseVO().getPsItemId() + CPSConstants.EMPTY_STRING);
        String listCost = req.getParameter("listCost");
        String channel = "D";
        listCost = (listCost != null && !listCost.equalsIgnoreCase(CPSConstants.EMPTY_STRING)) ? listCost : CPSConstants.ZERO_STRING;
        List<StoreVO> fetchDBStoreList = getAddNewCandidateService().fetchStoreData(itemId, uniquevendorId);
        Map<String, String> allVendorDsdHashMap = null;
        try {
            allVendorDsdHashMap = getCommonService().getAllApVendorAsHashMap();
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        if (allVendorDsdHashMap != null && !allVendorDsdHashMap.isEmpty()) {
            if (CPSHelper.isNotEmpty(allVendorDsdHashMap.get(uniquevendorId))) {
                boolean flag = getAddNewCandidateService()
                        .checkPreventUpdateStore(Integer.valueOf(allVendorDsdHashMap.get(uniquevendorId)));
                addNewCandidate.setPreventUpdateStore(flag);
            }
        }
        if (fetchDBStoreList.isEmpty()) {
            // Production Data Base
            String deptNbr = CPSConstants.ZERO_STRING;
            String subDeptNbdr = CPSConstants.ZERO_STRING;
            String deptSubDept[];
            // Deparment and sub-deparment call direct from database
            deptSubDept = getCommonService().getDeptAndSubDept(channel, uniquevendorId, itemId).split("-");
            deptNbr = deptSubDept[0];
            if(deptSubDept.length > 1) {
                subDeptNbdr = deptSubDept[1];
            }
            if (deptNbr.length() < 2) {
                deptNbr = CPSConstants.ZERO_STRING + deptNbr;
            }
            // @SuppressWarnings("unused")
            // String deptNumber = deptNbr + subDeptNbdr;
            List<StoreVO> viewStoreList = new ArrayList<StoreVO>();
            try {
                // call from web-service
                viewStoreList = getCommonService().getViewStoresList(uniquevendorId, deptNbr, subDeptNbdr, listCost,
                        itemId);
            } catch (CPSBusinessException e) {
                LOG.error(e.getMessage(), e);
                final List<CPSMessage> list = e.getMessages();
                for (final CPSMessage message : list) {
                    addNewCandidate.setAuthorizeServiceMessage(CPSHelper.getTrimmedValue(message.getMessage()));
                }
            }
            // Production Data Ends
            if (viewStoreList.isEmpty()) {
                addNewCandidate.setRejectClose(true);
                CPSMessage message = new CPSMessage(BusinessConstants.SERVICE_ERROR_NO_RECORDS_FOUND,
                        CPSMessage.ErrorSeverity.INFO);
                saveMessage(addNewCandidate, message);
                req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            } else {
                setStoreVO(addNewCandidate, viewStoreList);
                addNewCandidate.setRejectClose(false);
            }
        } else {
            addNewCandidate.setRejectClose(false);
            setStoreVO(addNewCandidate, fetchDBStoreList);
        }
        addNewCandidate.setListCost(listCost);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_VIEW_STORE_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Auth mrtwhs.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_AUTH_MRT_WHS)
    public ModelAndView authMRTWHS(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        setInputForwardValue(req, RELATIVE_PATH_AUTHORIZE_WHS_PAGE);
        addNewCandidate.setRejectClose(true);
        CPSMessage message = null;
        String uniquevendorId = req.getParameter("selectedVendorId");
        String itemId = CPSHelper.getStringValue(addNewCandidate.getMrtvo().getCaseVO().getPsItemId());
        String vendorType = getChannelType(uniquevendorId, addNewCandidate);
        if (CPSHelper.isEmpty(vendorType)) {
            vendorType = "V";
        }
        List<WareHouseVO> list = new ArrayList<WareHouseVO>();
        VendorVO vendorVO = new VendorVO();
        try {
            list = getImportedWarehouses(uniquevendorId, itemId, vendorType, addNewCandidate.getMrtvo().getCaseVO().getClassCode());
            addNewCandidate.setRejectClose(false);
        } catch (CPSBusinessException e) {
            LOG.error(e.getMessage(), e);
            List<CPSMessage> msgList = e.getMessages();
            String messg = CPSConstants.SERVICE_ERROR;
            for (CPSMessage msg : msgList) {
                messg = CPSHelper.getTrimmedValue(msg.getMessage());
            }
            message = new CPSMessage(messg, CPSMessage.ErrorSeverity.INFO);
            saveMessage(addNewCandidate, message);
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
            // keep selected vendor VO in form so that it is accessible while
            // saving facilities
            addNewCandidate.setVendorVO(vendorVO);

            addNewCandidate.setRejectClose(true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            message = new CPSMessage(CPSConstants.SERVICE_ERROR, CPSMessage.ErrorSeverity.INFO);
            saveMessage(addNewCandidate, message);
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
            // keep selected vendor VO in form so that it is accessible while
            // saving facilities
            addNewCandidate.setVendorVO(vendorVO);

            addNewCandidate.setRejectClose(true);
        }
        addNewCandidate.setWareHouseList(list);
        addNewCandidate.setVendorId(uniquevendorId);
        addNewCandidate.setItemID(itemId);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_AUTHORIZE_WHS_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * handles the 'prodAndUpc' tab of the tab view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_CASE_DETAILS)
    public ModelAndView caseDetails( @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                   HttpServletResponse resp) throws Exception {
        //addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_NEW_AUTH);
        String uniqueId = req.getParameter("selectedCaseVOId");
        req.setAttribute("showNoData", req.getParameter("showNoData"));
        CaseVO caseVO = addNewCandidate.getProductVO().getCaseVO(uniqueId);

        if (CPSHelper.isEmpty(caseVO)) {
            caseVO = setCaseVOValues(uniqueId, addNewCandidate);
        } else {
            setCaseUPCVO(caseVO, addNewCandidate.getProductVO());
        }
        if (null != addNewCandidate.getCaseVO().getTouchTypeList()) {
            caseVO.setTouchTypeList(addNewCandidate.getCaseVO().getTouchTypeList());
        }
        if (null != addNewCandidate.getCaseVO().getItemCategoryList()) {
            caseVO.setItemCategoryList(addNewCandidate.getCaseVO().getItemCategoryList());
        }
        if (null != addNewCandidate.getCaseVO().getPurchaseStatusList()) {
            caseVO.setPurchaseStatusList(addNewCandidate.getCaseVO().getPurchaseStatusList());
        }
        // DRU
        if (null != addNewCandidate.getCaseVO().getReadyUnits()) {
            caseVO.setReadyUnits(addNewCandidate.getCaseVO().getReadyUnits());
        }
        if (null != addNewCandidate.getCaseVO().getOrientations()) {
            caseVO.setOrientations(addNewCandidate.getCaseVO().getOrientations());
        }
        // END DRU
        addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
        addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
        addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
        addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());
        // Order Unit changes
        addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());

        if (caseVO.getNewDataSw() == 'Y' && addNewCandidate.isModifyProdCand()) {
            caseVO.setCaseViewOverride(false);
        }

        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        String channelval = caseVO.getChannelVal();
        String chnlVal = CPSWebUtil.getChannelValForService(channelval);
        String deptNbr = null;
        String subDeptNbdr = null;

        if (null != addNewCandidate.getProductVO().getClassificationVO().getCommodity() && null != addNewCandidate
                .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())) {
            deptNbr = addNewCandidate
                    .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                    .getDeptId();
            subDeptNbdr = addNewCandidate
                    .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                    .getSubDeptId();
        }
        String classField = addNewCandidate.getProductVO().getClassificationVO().getClassField();
        String commodityVal = addNewCandidate.getProductVO().getClassificationVO().getCommodity();
        // Fix 1241
        try {
            if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
                addNewCandidate.updateVendorList(deptNbr, subDeptNbdr, classField, null, chnlVal);
            } else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
                addNewCandidate.updateVendorList(null, null, classField, commodityVal, chnlVal);
            } else {
                addNewCandidate.updateVendorList(deptNbr, subDeptNbdr, classField, commodityVal, chnlVal);
            }
        } catch (Exception e) {
            addNewCandidate.getVendorVO().setVendorLocationList(new ArrayList<VendorLocationVO>());
        }
        /**
         * added below line to make sure that the vendor list is correct.
         */
        if (addNewCandidate.isVendor()) {
            try {
                addNewCandidate.getVendorVO()
                        .setVendorLocationList(getCorrectedVendorList(deptNbr, subDeptNbdr, chnlVal, classField, addNewCandidate));
            } catch (CPSGeneralException e) {
                addNewCandidate.getVendorVO().setVendorLocationList(new ArrayList<VendorLocationVO>());
            }
        }
        addNewCandidate.getVendorVO().setVendorLocationList(addNewCandidate.getVendorVO().getVendorLocationList());
        addNewCandidate.getVendorVO().setSeasonality("13");
        // hide Activate button when modify a product in Search Active Product
        if (addNewCandidate.isProduct()) {
            addNewCandidate.getProductVO().setModifyFlag(true);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_AUTH_AND_DIST_AJAX);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Gets the corrected vendor list.
     *
     * @param deptNbr
     *            the dept nbr
     * @param subDept
     *            the sub dept
     * @param chnlVal
     *            the chnl val
     * @param classField
     *            the class field
     * @param candidateForm
     *            the form
     * @return the corrected vendor list
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private List<VendorLocationVO> getCorrectedVendorList(String deptNbr, String subDept, String chnlVal,
                                                          String classField, AddNewCandidate candidateForm) throws CPSGeneralException {
        List<VendorLocationVO> sessionVendors = candidateForm.getVendorVO().getVendorLocationList();
        List<VendorLocDeptVO> cachedVendors = null;
        if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
            cachedVendors = getCommonService().getVendorLocationListFromCache(deptNbr, subDept, classField, null, "D");
        } else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
            cachedVendors = getCommonService().getVendorLocationListFromCache(null, null, classField, null, "V");
        } else {
            cachedVendors = getCommonService().getVendorLocationListFromCache(deptNbr, subDept, classField, null, "D");
            cachedVendors.addAll(getCommonService().getVendorLocationListFromCache(null, null, classField, null, "V"));
        }

        List<VendorLocationVO> actualVendors = new ArrayList<VendorLocationVO>();

        if (sessionVendors != null && cachedVendors != null) {
            Iterator<VendorLocationVO> sessionVendorIterator = sessionVendors.iterator();
            while (sessionVendorIterator.hasNext()) {
                VendorLocationVO sessionVendorLocationVO = sessionVendorIterator.next();
                int size = cachedVendors.size();
                for (int index = 0; index < size; index++) {
                    VendorLocDeptVO cachedVendorLocDeptVO = cachedVendors.get(index);
                    if (sessionVendorLocationVO.getVendorId().equals(cachedVendorLocDeptVO.getVendorLocationNumber())) {
                        actualVendors.add(sessionVendorLocationVO);
                    }
                }
            }
        }
        return actualVendors;
    }
    /**
     * Conflict store.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_CONFLICT_STORE)
    public ModelAndView conflictStore(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                    HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_CONFLICT_STORES);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * handles the 'prodAndUpc' tab of the tab view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VENDOR_DETAILS)
    public ModelAndView vendorDetails(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_NEW_AUTH);
        String uniqueCaseId = req.getParameter("selectedCaseVOId");
        String uniquevendorId = req.getParameter("selectedVendorId");

        if (CPSHelper.isEmpty(addNewCandidate.getCostOwners())) {
            // Fix 1241
            try {
                initCostOwner(addNewCandidate);
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
                addNewCandidate.setCostOwners(new ArrayList<BaseJSFVO>());
            }
        }
        CaseVO caseVO = addNewCandidate.getProductVO().getCaseVO(uniqueCaseId);
        if (CPSHelper.isEmpty(caseVO)) {
            caseVO = setCaseVOValues(uniqueCaseId, addNewCandidate);
        }
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        VendorVO vendorVO = caseVO.getVendorVO(uniquevendorId);
        if (CPSHelper.isEmpty(vendorVO)) {
            vendorVO = setVendorVOValues(caseVO, uniquevendorId, addNewCandidate);
        }
        vendorVO.setCountryOfOriginList(getCountryOfOrigin());
        vendorVO.setSeasonalityList(getSeasonality());
        vendorVO.setTop2TopList(getTop2Top());
        vendorVO.setOrderRestrictionList(getOrderRestriction());
        if(caseVO.getChannel().equalsIgnoreCase(CPSConstant.CHANNEL_WHSDSD)) {
            vendorVO.setItemCodeRadio(false);
            vendorVO.setCostLinkRadio(false);
        }
        // Order Unit changes
        vendorVO.setOrderUnitList(getOrderUnitList());
        // req.setAttribute("selectedVendorVO", vendorVO);
        String chnlVal = CPSWebUtil.getChannelValForService(caseVO.getChannelVal());

        String deptNbr = null;
        String subDeptNbdr = null;

        // 958 enhancements
        if (CPSHelper.isNotEmpty(vendorVO.getDept()) && CPSHelper.isNotEmpty(vendorVO.getSubDeptId())) {
            deptNbr = vendorVO.getDept();
            subDeptNbdr = vendorVO.getSubDeptId();
        } else {
            if (null != addNewCandidate.getProductVO().getClassificationVO().getCommodity() && null != addNewCandidate
                    .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())) {
                deptNbr = CPSHelper.getTrimmedValue(addNewCandidate
                        .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                        .getDeptId());
                subDeptNbdr = CPSHelper.getTrimmedValue(addNewCandidate
                        .getClassCommodityVO(addNewCandidate.getProductVO().getClassificationVO().getCommodity())
                        .getSubDeptId());
                vendorVO.setDept(deptNbr);
                vendorVO.setSubDeptId(subDeptNbdr);
            }
        }
        String classField = addNewCandidate.getProductVO().getClassificationVO().getClassField();
        String commodityVal = addNewCandidate.getProductVO().getClassificationVO().getCommodity();
        // Fix 1241
        try {
            if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {

                vendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
                vendorVO.setMasterPack(caseVO.getMasterPack());
                addNewCandidate.updateVendorList(deptNbr, subDeptNbdr, classField, null, chnlVal);
            } else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {

                vendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
                vendorVO.setShipPack(caseVO.getShipPack());
                addNewCandidate.updateVendorList(null, null, classField, commodityVal, chnlVal);
            } else {
                vendorVO.setChannelVal(CPSConstants.CHANNEL_BOTH);
                vendorVO.setShipPack(caseVO.getShipPack());
                vendorVO.setMasterPack(caseVO.getMasterPack());
                addNewCandidate.updateVendorList(deptNbr, subDeptNbdr, classField, commodityVal, chnlVal);
            }
        } catch (Exception e) {
            addNewCandidate.getVendorVO().setVendorLocationList(new ArrayList<VendorLocationVO>());
        }

        List<VendorLocationVO> vendorLocationList = addNewCandidate.getVendorVO().getVendorLocationList();
        String vendorLocationCode = vendorVO.getOriginalVendorLocNumber() + CPSConstants.EMPTY_STRING;
        for (VendorLocationVO vendorLocationVO : vendorLocationList) {
            if (vendorLocationVO.getVendorId().equals(vendorLocationCode)) {
                vendorVO.setVendorChannelVal(vendorLocationVO.getVendorLocationType());
                break;
            }
        }
        // To fix 1080
        if (CPSHelper.isEmpty(vendorVO.getVendorChannelVal())
                && CPSHelper.isNotEmpty(vendorVO.getOriginalLocationTypeCode())) {
            vendorVO.setVendorChannelVal(vendorVO.getOriginalLocationTypeCode());
        }
        // End 1080
        if (vendorVO.getNewDataSw() == 'Y' && addNewCandidate.isModifyProdCand()) {
            vendorVO.setVendorViewOverride(false);
        }
        setListCostFlags(vendorVO, addNewCandidate);
        // 958 PSS changes
        setPSSDeptList(vendorVO, addNewCandidate);
        setGrossMargin(vendorVO, addNewCandidate);
        if (!CPSHelper.isEmpty(vendorVO.getCostOwnerVal()) && Integer.parseInt(vendorVO.getCostOwnerVal())>0) {
            // Fix 1241
            int count=0;
            for(BaseJSFVO base:addNewCandidate.getCostOwners()) {
                if(!vendorVO.getCostOwnerVal().equalsIgnoreCase(base.getId())) {
                    count++;
                }
            }
            if(count>0 && count==addNewCandidate.getCostOwners().size()) {
                List ret = new ArrayList();
                addNewCandidate.setTopToTops(ret);
            }else {
                List<BaseJSFVO> t2T = new ArrayList<BaseJSFVO>();
                try {
                    t2T = getAddNewCandidateService()
                            .getT2TbyCostOwner(CPSHelper.getIntegerValue(vendorVO.getCostOwnerVal()));
                } catch (Exception e) {
                    LOG.error(e.getMessage(), e);
                }
                addNewCandidate.setTopToTops(t2T);
            }
        } else {
            List ret = new ArrayList();
            List<BaseJSFVO> t2T = new ArrayList<BaseJSFVO>();
            boolean contain = false;
            for(BaseJSFVO base:addNewCandidate.getCostOwners()) {
                if(!CPSHelper.isEmpty(vendorVO.getCostOwnerVal()) && Integer.parseInt(vendorVO.getCostOwnerVal())==0 && vendorVO.getCostOwnerVal().equalsIgnoreCase(base.getId())) {
                    t2T.add(base);
                    contain = true;
                    break;
                }
            }
            if(!contain && !CPSHelper.isEmpty(vendorVO.getCostOwnerVal()) && Integer.parseInt(vendorVO.getCostOwnerVal())==0) {
                addNewCandidate.setTopToTops(ret);
            } else {
                addNewCandidate.setTopToTops(t2T);
            }
        }
        req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
        // keep selected vendor VO in form so that it is accessible while saving
        // facilities
        addNewCandidate.setVendorVO(vendorVO);
        addNewCandidate.getVendorVO().setVendorLocationList(vendorLocationList);
        // hide Activate button when modify a product in Search Active Product
        if (addNewCandidate.isProduct()) {
            addNewCandidate.getProductVO().setModifyFlag(true);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_AUTH_AND_DIST_VENDOR_AJAX);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Sets the list cost flags.
     *
     * @param vendorVO
     *            the vendor vo
     * @param form
     *            the form
     */
    private void setListCostFlags(VendorVO vendorVO, AddNewCandidate form) {
        String costLink = vendorVO.getCostLinkFormatted();
        String commodityCode = form.getProductVO().getClassificationVO().getCommodity();
        if (CPSHelper.isNotEmpty(costLink) && CPSHelper.isNotEmpty(commodityCode)
                && (!vendorVO.isCostLinkRadio() && !vendorVO.isItemCodeRadio())) {
            String returnvalue = null;
            String listCosts = null;
            try {
                listCosts = getCommonService()._getCostList(null, String.valueOf(vendorVO.getVendorLocNumber()),
                        costLink, null, vendorVO.getVendorLocation());
                returnvalue = listCosts;
                if (CPSHelper.isNotEmpty(returnvalue)) {
                    if (vendorVO.getListCostFormatted().equalsIgnoreCase(returnvalue)) {
                        vendorVO.setCostLinkRadio(true);
                    } else {
                        vendorVO.setCostLinkRadio(false);
                    }
                }
                if (vendorVO.isCostLinkRadio() == false) {
                    returnvalue = null;
                    listCosts = getCommonService()._getCostList(null, String.valueOf(vendorVO.getVendorLocNumber()),
                            null, costLink, vendorVO.getVendorLocation());
                    returnvalue = listCosts;
                    if (CPSHelper.isNotEmpty(returnvalue)) {
                        if (vendorVO.getListCostFormatted().equalsIgnoreCase(returnvalue)) {
                            vendorVO.setItemCodeRadio(true);
                        } else {
                            vendorVO.setItemCodeRadio(false);
                        }
                    }
                }
            } catch (CPSGeneralException e) {
                LOG.error(e.getMessage(), e);
            }
        }
    }
    /**
     * Sets the pss dept list.
     *
     * @param vendorVO
     *            the vendor vo
     * @param addCandidateForm
     *            the add candidate form
     */
    private void setPSSDeptList(VendorVO vendorVO, AddNewCandidate addCandidateForm) {
        String vendSubDept = vendorVO.getSubDept();
        List<BaseJSFVO> vendPSSList = addCandidateForm.getPssList();
        // get the overridden pss list
        if (CPSHelper.isNotEmpty(vendSubDept)
                && !(addCandidateForm.getDefaultSubDept().equalsIgnoreCase(vendSubDept))) {
            try {
                vendPSSList = getCommonService().getDeptNumbersForDeptSubDept(vendorVO.getDept(),
                        vendorVO.getSubDeptId());
            } catch (CPSGeneralException e) {
                vendPSSList = new ArrayList<BaseJSFVO>();
            }
        }
        vendorVO.setPssList(vendPSSList);
    }

    private void setGrossMargin(VendorVO vendorVO, AddNewCandidate form) {
        ProductVO productVO = form.getProductVO();
        String rs = CPSConstant.STRING_EMPTY;
        StringBuilder messageWaring = new StringBuilder();
        try {
            double retail = CPSHelper.getDoubleValue(productVO.getRetailVO().getRetail());
            double retailFor = CPSHelper.getDoubleValue(productVO.getRetailVO().getRetailFor());
            double unitCost = 0;
            String unitCostReal = CPSConstant.STRING_EMPTY;
            if (form.getCaseVO().getChannelVal() != null && form.getCaseVO().getChannelVal().equals(CPSConstants.CHANNEL_BOTH)) {
                unitCost = CPSHelper.getDoubleValue(vendorVO.getUnitCostLabelFormattedBoth());
                unitCostReal = vendorVO.getUnitCostLabelFormattedBoth();
            } else {
                unitCost = CPSHelper.getDoubleValue(vendorVO.getUnitCostLabelFormatted());
                unitCostReal = vendorVO.getUnitCostLabelFormatted();
            }

            if (retailFor != 0 && unitCost != 0) {
                if (retail > 1) {
                    retail = retailFor / retail;
                } else {
                    retail = retailFor;
                }

                double margin = (retail - unitCost) / retail * 100;
                setGrossProfit(vendorVO, retail, unitCost);
                if (margin == 0) {
                    rs = "0.00 %";
                } else {
                    rs = String.format("%.4f", margin);
                }

            } else {
                // rs = CPSConstant.STRING_EMPTY;
                vendorVO.setGrossProfit(CPSConstant.STRING_EMPTY);
            }
            if ("priceRequired".equals(productVO.getRetailVO().getRetailRadio())
                    && (CPSHelper.isEmpty(productVO.getRetailVO().getRetailFor())
                    || CPSHelper.getIntegerValue(productVO.getRetailVO().getRetailFor()) == 0)) {
                messageWaring.append("% Margin and Penny profit are blank. Because Price Required field checked.");
            } else if (CPSHelper.isEmpty(productVO.getRetailVO().getRetailFor())
                    || CPSHelper.getIntegerValue(productVO.getRetailVO().getRetailFor()) == 0) {
                messageWaring
                        .append("% Margin and Penny Profit are blank. Please enter Retail For value greater than 0.");
            } else if (CPSHelper.isEmpty(vendorVO.getListCost()) && CPSHelper.isEmpty(unitCostReal)) {
                messageWaring.append("% Margin and Penny Profit are blank. Please enter List Cost value.");
            } else if (!CPSHelper.isEmpty(vendorVO.getListCost()) && CPSHelper.isEmpty(unitCostReal)) {
                messageWaring
                        .append("% Margin and Penny Profit are blank. Please enter Ship Pack / Master Pack value.");
            }
            vendorVO.setMarginMessageWarning(messageWaring.toString());
        } catch (ArithmeticException ex) {
            LOG.error(ex.getMessage(), ex);
            rs = CPSConstant.STRING_EMPTY;
        }
        vendorVO.setGrossMargin(rs);
    }
    private void setGrossProfit(VendorVO vendorVO, double retail, double unitCost) {
        double profit = 0;
        String rs = CPSConstant.STRING_EMPTY;
        profit = retail - unitCost;
        try {
            BigDecimal bigDecimal = new BigDecimal(profit);
            BigDecimal roundedWithScale = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP);
            rs = "$" + roundedWithScale;
        } catch (NumberFormatException ex) {
            rs = CPSConstant.STRING_EMPTY;
        }
        vendorVO.setGrossProfit(rs);
    }
    /**
     * Activate.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_ACTIVATE)
    public ModelAndView activate( @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        ModelAndView forward = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        String mrtString = addNewCandidate.getQuestionnarieVO().getSelectedOption();
        // setSellingRestriction(candidateForm.getProductVO(),
        // candidateForm.getProductVO());
        // check if user check into Batch Upload switch
        if (addNewCandidate.isHidBatchUploaded() && !addNewCandidate.getProductVO().getWorkRequest().getWorkStatusCode()
                .equals(BusinessConstants.ACTIVATION_FAILURE_CODE)) {
            forward = activeBatchUploadCandidate(addNewCandidate, req, resp);
        } else {
            if ("4".equalsIgnoreCase(mrtString)) {
                // MRT Candidate
                String productId = CPSHelper.getTrimmedValue(addNewCandidate.getMrtvo().getCaseVO().getPsItemId());
                if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(productId) && !CPSConstants.ZERO_STRING.equalsIgnoreCase(productId)) {
                    forward = activeMRTCandidate(addNewCandidate, req, resp);

                } else {
                    CPSMessage errorMessage = new CPSMessage("Please save the MRT candidate before activating it",
                            CPSMessage.ErrorSeverity.ERROR);
                    saveMessage(addNewCandidate, errorMessage);
                    forward = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
                }
            } else {
                String productId = CPSHelper
                        .getTrimmedValue(CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId()));
                if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(productId) && !CPSConstants.ZERO_STRING.equalsIgnoreCase(productId)) {
                    if (addNewCandidate.getProductVO().getWorkRequest().getWorkStatusCode()
                            .equals(BusinessConstants.ACTIVATION_FAILURE_CODE)) {
                        addNewCandidate.setActivatedFail(true);
                    }
                    forward = activeCandidate(addNewCandidate, req, resp);
                } else {
                    CPSMessage errorMessage = new CPSMessage("Please save the candidate before activating it",
                            CPSMessage.ErrorSeverity.ERROR);
                    saveMessage(addNewCandidate, errorMessage);
                    forward = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
                }
            }
        }
        List<CaseVO> caseVOs = addNewCandidate.getProductVO().getCaseVOs();
        // re-write ItemCode for each Case UPC --fix QC1508
        Number itemId = 0;
        for (CaseVO caseVO : caseVOs) {
            if (CPSHelper.isNotEmpty(caseVO.getPsItemId())) {
                itemId = getAddNewCandidateService().getItemCode(caseVO.getPsItemId());
                if (itemId != null && itemId.longValue() > 0) {
                    caseVO.setItemId(itemId);
                }
            }
        }

        forward.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return forward;
    }
    /**
     * Active batch upload candidate.
     *
     * @author thangdang (VODC)
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     * @des activate candidate is batchUpload
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_ACTIVE_BATCH_UPLOAD_CANDIDATE)
    public ModelAndView activeBatchUploadCandidate(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                 HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String forward = RELATIVE_PATH_NEW_PRODUCT_PAGE;
        StringBuffer checkMessage = new StringBuffer();
        checkMessage.append(CPSConstants.EMPTY_STRING);
        clearMessages(addNewCandidate);
        // saveDetails(mapping, form, req, resp);
        if (!addNewCandidate.isTestScanNeeded()) {
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getRetailVO().getRetail())
                    && CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getRetailVO().getRetailForWrap())
                    && Double.parseDouble(addNewCandidate.getProductVO().getRetailVO().getRetailForWrap()) > 0) {
                int workRequestId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
                clearMessages(addNewCandidate);
                try {
                    String workStatus = null;
                    workStatus = BusinessConstants.ACTIVATE_BATCHUPLOAD_CODE;
                    getAddNewCandidateService().changeWorkStatus(workRequestId, workStatus);
                    getCommonService().updateBatchUploadCandidateStatus(workRequestId, getUserInfo().getUserName());
                    checkMessage.append(CPSConstants.SUBMIT_SUCCESSFULL);
                    req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, CPSConstant.STRING_Y);
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, CPSConstant.STRING_Y);
                    req.getSession().setAttribute(CPSConstants.IS_MRT, CPSConstant.STRING_N);
                    questionnaire(addNewCandidate, req, resp);
                    forward = RELATIVE_PATH_QUESTIONNAIRE_PAGE;
                } catch (CPSBusinessException e) {
                    LOG.error(e.getMessage(), e);
                    getAddNewCandidateService().changeWorkStatus(workRequestId,
                            BusinessConstants.ACTIVATION_FAILURE_CODE);
                    CaseVO caseVO = new CaseVO();
                    req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
                    List<CPSMessage> list = e.getMessages();
                    for (CPSMessage message : list) {
                        checkMessage.append(message.getMessage());
                    }
                }
            } else {
                checkMessage.append(" [Product Description :")
                        .append(addNewCandidate.getProductVO().getClassificationVO().getProdDescritpion()).append("] ")
                        .append(CPSConstants.ACTIVATION_VALIDATE_RETAIL);
            }
            CPSMessage finalMessage;
            if (CPSConstants.SUBMIT_SUCCESSFULL.equalsIgnoreCase(checkMessage.toString())) {
                finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.INFO);

                // trungnv call trigger after change status to 111.
                getCommonService().approveDSDWS("CPSA");
            } else {
                finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.ERROR);
            }
            saveMessage(addNewCandidate, finalMessage);
            CaseVO caseVO = new CaseVO();
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        } else {
            checkMessage.append(" [Product Description :")
                    .append(addNewCandidate.getProductVO().getClassificationVO().getProdDescritpion()).append("] ")
                    .append(CPSConstants.CHECK_TESTSCAN);
            CPSMessage finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, finalMessage);
            CaseVO caseVO = new CaseVO();
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        }
        ModelAndView  model = new ModelAndView(forward);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Active mrt candidate.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_ACTIVE_MRT_CANDIDATE)
    public ModelAndView activeMRTCandidate(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                                   HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String forward = RELATIVE_PATH_NEW_PRODUCT_PAGE;
        StringBuffer checkMessage = new StringBuffer();
        checkMessage.append(CPSConstants.EMPTY_STRING);
        clearMessages(addNewCandidate);
        Integer workRequestId = addNewCandidate.getMrtvo().getWorkRequest().getWorkIdentifier();
        String productId = CPSHelper.getTrimmedValue(addNewCandidate.getMrtvo().getCaseVO().getPsItemId() + CPSConstants.EMPTY_STRING);
        if (!CPSHelper.isEmpty(productId) && !"null".equalsIgnoreCase(productId)) {

            if (addNewCandidate.getProductVO().getClassificationVO() == null) {
                addNewCandidate.getProductVO().setClassificationVO(new ProductClassificationVO());
            }
            if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getClassificationVO().getClassDesc())) {
                populateMRTDetailsFromUPC(addNewCandidate);
            }
            if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getMrtVOs())) {
                int countSaved = 0;
                for (MRTUPCVO mrtUpcVo : addNewCandidate.getMrtvo().getMrtVOs()) {
                    if (mrtUpcVo.isMrtUPCSaved()) {
                        countSaved++;
                    }
                }
                if (countSaved < 2) {
                    checkMessage.append("MRT's MUST have more than 1 element. Please change the MRT before activation");
                } else {
                    try {
                        String returnMessage = getAddNewCandidateService().activateMRTValidator(productId, getUserRole(),
                                getUserInfo().getUserName());
                        if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnMessage.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim())) {
                            String returnValue = getCommonService().getActivate(workRequestId,
                                    getUserInfo().getUserName());
                            String workStatus = null;
                            if (BusinessConstants.MFPE.equalsIgnoreCase(returnValue)) {
                                workStatus = BusinessConstants.ACTIVATE_CODE;
                                getAddNewCandidateService().changeWorkStatus(workRequestId, workStatus);
                                checkMessage.append(CPSConstants.SUBMIT_SUCCESSFULL);
                                req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, CPSConstant.STRING_Y);
                                req.setAttribute(CPSConstants.SINGLE_ACTIVATION, CPSConstant.STRING_Y);
                                req.getSession().setAttribute(CPSConstants.IS_MRT, CPSConstant.STRING_Y);
                            } else {
                                workStatus = CPSConstants.WORKING_CODE;
                                checkMessage.append("DB Time out issue while activating");
                                getAddNewCandidateService().changeWorkStatus(workRequestId, workStatus);
                            }
                            questionnaire(addNewCandidate, req, resp);
                            forward = RELATIVE_PATH_QUESTIONNAIRE_PAGE;
                        } else {
                            checkMessage.append(returnMessage);
                        }
                    } catch (CPSBusinessException e) {
                        LOG.error(e.getMessage(), e);
                        getAddNewCandidateService().changeWorkStatus(workRequestId,
                                BusinessConstants.ACTIVATION_FAILURE_CODE);
                        CaseVO caseVO = addNewCandidate.getMrtvo().getCaseVO();
                        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
                        List<CPSMessage> list = e.getMessages();
                        for (CPSMessage message : list) {
                            checkMessage.append(message.getMessage());
                        }
                    } catch (Exception e) {
                        LOG.error(e.getMessage(), e);
                        checkMessage.append(e.getMessage());
                    }
                }
            }
        } else {
            checkMessage.append("Please setup the MRT Candidate before Activating");
        }
        CPSMessage finalMessage;
        if (CPSConstants.SUBMIT_SUCCESSFULL.equalsIgnoreCase(checkMessage.toString())) {
            finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.INFO);
        } else {
            finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.ERROR);
        }
        saveMessage(addNewCandidate, finalMessage);
        CaseVO caseVO = addNewCandidate.getMrtvo().getCaseVO();
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO())) {
            addNewCandidate.getMrtvo().getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
            // Fix 1335
            caseVO.setItemCategoryList(getItemCategoryList());
            caseVO.setTouchTypeList(getTouchTypeCodes());
            caseVO.setReadyUnits(getReadyUnitList());
            caseVO.setOrientations(getOrientationList());
        }

        ModelAndView  model = new ModelAndView(forward);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Active candidate.
     * protected/cps/add/AddNewCandidate.do?tab=activeCandidate
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_ACTIVE_CANDIDATE)
    public ModelAndView activeCandidate(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE)AddNewCandidate addNewCandidate, HttpServletRequest req,
                                           HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String forward = RELATIVE_PATH_NEW_PRODUCT_PAGE;
        StringBuffer checkMessage = new StringBuffer();
        checkMessage.append(CPSConstants.EMPTY_STRING);
        clearMessages(addNewCandidate);
        // saveDetails(mapping, form, req, resp);
        int workRequestId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
        String productId = CPSHelper
                .getTrimmedValue(CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId()));
        // String imgExpectedDate = addNewCandidate.getProductVO().getImageAttVO().getImageExpectDt();
        String returnMessage = CPSConstants.EMPTY_STRING;
        try {
            returnMessage = getAddNewCandidateService().activateValidator(workRequestId, productId, getUserRole(),
                    this.getLstVendorId(req), null);//imgExpectedDate);
        } catch (CPSGeneralException e) {
            if (e instanceof CPSBusinessException) {
                List<CPSMessage> errors = ((CPSBusinessException) e).getMessages();
                for (CPSMessage error : errors) {
                    returnMessage = error.getMessage();
                }
            } else if (e instanceof CPSSystemException) {
                CPSMessage error = ((CPSSystemException) e).getCPSMessage();
                returnMessage = error.getMessage();
            }
        }
        clearMessages(addNewCandidate);
        if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnMessage.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim())) {
            try {
                String returnValue = getCommonService().getActivate(workRequestId, getUserInfo().getUserName());
                String workStatus = null;
                if (BusinessConstants.MFPE.equalsIgnoreCase(returnValue)) {
                    workStatus = BusinessConstants.ACTIVATE_CODE;
                    getAddNewCandidateService().changeWorkStatus(workRequestId, workStatus);
                    checkMessage.append(CPSConstants.ACTIVATE_SUCCESSFULL);
                    req.setAttribute(CPSConstants.ACTIVATION_SUCCESS, CPSConstant.STRING_Y);
                    req.setAttribute(CPSConstants.SINGLE_ACTIVATION, CPSConstant.STRING_Y);
                    req.getSession().setAttribute(CPSConstants.IS_MRT, CPSConstant.STRING_N);
                } else {
                    workStatus = CPSConstants.WORKING_CODE;
                    checkMessage.append("Activation is taking longer than the normal time. Please refresh and verify the UPC status.");
                    getAddNewCandidateService().changeWorkStatus(workRequestId, workStatus);
                }
                questionnaire(addNewCandidate, req, resp);
                forward = RELATIVE_PATH_QUESTIONNAIRE_PAGE;
            } catch (CPSBusinessException e) {
                LOG.error(e.getMessage(), e);
                getAddNewCandidateService().changeWorkStatus(workRequestId, BusinessConstants.ACTIVATION_FAILURE_CODE);
                CaseVO caseVO = new CaseVO();
                req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
                List<CPSMessage> list = e.getMessages();
                for (CPSMessage message : list) {
                    checkMessage.append(message.getMessage());
                }
            } catch (CPSSystemException e) {
                checkMessage.append(e.getCPSMessage().getMessage());
            }
        } else {
            checkMessage.append(returnMessage);
        }
        CPSMessage finalMessage;
        if (CPSConstants.ACTIVATE_SUCCESSFULL.equalsIgnoreCase(checkMessage.toString())) {
            finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.INFO);
        } else {
            finalMessage = new CPSMessage(checkMessage.toString(), CPSMessage.ErrorSeverity.ERROR);

            // trungnv fix clear nutrient grid when active fail
            if (addNewCandidate.getTabIndex() == AddNewCandidate.TAB_IMG_ATTR) {
                if (addNewCandidate.getDynamicExtendAtrrTab() == AddNewCandidate.TAB_EXTEND_ATTR) {
                    ProductVOHelper.clearChangeDynAttrExtTab(addNewCandidate.getProductVO(),
                            addNewCandidate.getSavedProductVO());
                } else if (addNewCandidate.getDynamicExtendAtrrTab() == AddNewCandidate.TAB_BRICK_ATTR) {
                    ProductVOHelper.clearChangeDynAttrBrickTab(addNewCandidate.getProductVO(),
                            addNewCandidate.getSavedProductVO());
                }
                // ProductVOHelper.clearChangeDynAttrNutrtInfor(candidateForm.getProductVO());
                /*if (CPSHelper
                        .isEmpty(addNewCandidate.getProductVO().getImageAttVO().getNutriInfoVO().getLstNutriDatagrid())) {
                    addNewCandidate.getProductVO().getImageAttVO().getNutriInfoVO()
                            .setLstNutriDatagrid(new ArrayList<com.heb.operations.cps.vo.ImageAttribute.NutritionDetailVO>());
                    addNewCandidate.getProductVO().getImageAttVO().getNutriInfoVO()
                            .setJsonNutriDataGrid(CPSConstants.EMPTY_STRING);
                }*/
            }
            // -----------------

        }
        saveMessage(addNewCandidate, finalMessage);
        setEdcForItems(addNewCandidate.getProductVO().getCaseVOs(), addNewCandidate);
        CaseVO caseVO = new CaseVO();
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        ModelAndView  model = new ModelAndView(forward);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Reject mrt candidate.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_REJECT_MRT_CANDIDATE)
    public ModelAndView rejectMRTCandidate(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                        HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        int itemId = 0;
        String status = null;
        MrtVO mrtVO = addNewCandidate.getMrtvo();
        if (CPSHelper.isNotEmpty(mrtVO.getCaseVO().getPsItemId())) {
            itemId = mrtVO.getCaseVO().getPsItemId();
        }
        if (itemId == 0) {
            setForm(req, addNewCandidate);
            CPSMessage message = new CPSMessage("Only saved MRT candidate can be rejected", CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
            ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
            return model;
        } // Fix 1307
        else if (BusinessUtil.isVendor(getUserRole())
                && (CPSConstants.WORKING_CODE.equalsIgnoreCase(mrtVO.getWorkRequest().getWorkStatusCode()))) {
            setForm(req, addNewCandidate);
            CPSMessage message = new CPSMessage(
                    "Only Candidates in Vendor Candidate Status can be rejected. The Current Status is Working Candidate",
                    CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
            ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
            return model;
        } else {
            status = getAddNewCandidateService().reject(addNewCandidate.getMrtvo().getWorkRequest(), getUserRole());
            req.setAttribute("myMessage", "Candidate(s) " + status);
            CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_REJECT_SUCCESS, CPSMessage.ErrorSeverity.VALIDATION);
            saveMessage(addNewCandidate, message);
            ModelAndView  model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
            return model;
        }
    }
    /**
     * PIM-1642 Delete Candidates
     *
     * @param addNewCandidate the form
     * @param req the request
     * @param resp the response
     * @return to the questionnaire screen
     * @throws Exception the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_DELETE_CAN)
    public ModelAndView deleteCand(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                           HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        CPSMessage message;
        WorkRequest workRqst;
        String mrtString = addNewCandidate.getQuestionnarieVO().getSelectedOption();
        if (CPSHelper.checkEqualValue(CPSConstant.STRING_4, mrtString)) {
            // not yet saved mrt candidate
            if (CPSHelper.isEmpty(addNewCandidate.getMrtvo())
                    || CPSHelper.isEmpty(addNewCandidate.getMrtvo().getCaseVO())
                    || CPSHelper.isEmpty(addNewCandidate.getMrtvo().getCaseVO().getPsItemId())) {
                message = new CPSMessage(CPSConstants.ERROR_DELETE_NOT_SAVED_MRT_CANDIDATE, CPSMessage.ErrorSeverity.ERROR);
                saveMessage(addNewCandidate, message);
                ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
                model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                return model;
            } else {
                //tam le fix for BUG-981 - [Delete]_App changes stt from 107 to 104 when deleting element upc of mrt
                if(addNewCandidate.getTabIndex() == AddNewCandidate.TAB_POW || addNewCandidate.getTabIndex() == AddNewCandidate.TAB_MRT){
                    workRqst = addNewCandidate.getMrtvo().getWorkRequest();
                }else{
                    workRqst = addNewCandidate.getProductVO().getWorkRequest();
                }
            }
        } else {
            if (CPSHelper.isEmpty(addNewCandidate.getProductVO())
                    || CPSHelper.isEmpty(addNewCandidate.getProductVO().getPsProdId())) {
                // not yet saved candidate
                message = new CPSMessage(CPSConstants.ERROR_DELETE_NOT_SAVED_CANDIDATE, CPSMessage.ErrorSeverity.ERROR);
                saveMessage(addNewCandidate, message);
                ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
                model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
                return model;
            } else {
                workRqst = addNewCandidate.getProductVO().getWorkRequest();
            }
        }
        if (CPSHelper.isNotEmpty(workRqst)) {
            List<Integer> psWorkIdList = new ArrayList<Integer>();
            psWorkIdList.add(workRqst.getWorkIdentifier());
            // change status candidate
            String status = getCommonService().changeStatusCandidateList(psWorkIdList, CPSConstants.DELETED);
            req.setAttribute("myMessage", "Candidate " + status);
        }
        message = new CPSMessage(CPSConstants.CANDIDATE_DELETED_SUCCESS, CPSMessage.ErrorSeverity.VALIDATION);
        saveMessage(addNewCandidate, message);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;

    }
    /**
     * Activation message.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_ACTIVATION_MESSAGE)
    public ModelAndView activationMessage(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                   HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        Integer workRequestId = 0;
        String strJSON = CPSConstants.EMPTY_STRING;
        if (addNewCandidate.isHidBatchUploaded() && !addNewCandidate.isActivatedFail()) {
            if (addNewCandidate.getProductVO() != null && addNewCandidate.getProductVO().getWorkRequest() != null
                    && addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier() != null
                    && addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier() > 0) {
                List<Integer> workRequestIdList = new ArrayList<Integer>();
                workRequestId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
                workRequestIdList.add(workRequestId);
                strJSON = getJSONForProductBatUpload(workRequestIdList);
            }
        } else {
            String mrtSW = (String) req.getSession().getAttribute(CPSConstants.IS_MRT);
            if (CPSConstant.STRING_Y.equalsIgnoreCase(mrtSW)) {
                workRequestId = addNewCandidate.getMrtvo().getWorkRequest().getWorkIdentifier();
                // Fix 1214. show * for existing upc's.
                List<MRTUPCVO> mrtvos = addNewCandidate.getMrtvo().getMrtVOs();
                List<Long> existingupcs = new ArrayList<Long>();
                if (CPSHelper.isNotEmpty(mrtvos)) {
                    for (MRTUPCVO mrtupcVO : mrtvos) {
                        if ("No".equalsIgnoreCase(mrtupcVO.getApproval())) {
                            existingupcs.add(CPSHelper.getLongValue(mrtupcVO.getUnitUPC()));
                        }
                    }
                }
                strJSON = getJSONForMRT(workRequestId, existingupcs);
            } else {
                if (addNewCandidate.getProductVO() != null && addNewCandidate.getProductVO().getWorkRequest() != null
                        && addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier() != null
                        && addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier() > 0) {
                    workRequestId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
                    strJSON = getJSONForProduct(workRequestId);
                }
            }
        }
        req.getSession().removeAttribute(CPSConstants.IS_MRT);
        req.setAttribute("SingleActivation", CPSConstant.STRING_Y);
        try {
            resp.setContentType("application/json");
            resp.setHeader("Cache-Control", "no-cache");
            resp.getWriter().write(strJSON);
            resp.getWriter().close();
        } catch (Exception e) {
            LOG.error("Error occurred in activationMessage method: " + e);
        }
        return null;
    }
    /**
     * Gets the JSON for mrt.
     *
     * @param workRequestId
     *            the work request id
     * @param existingUPC
     *            the existing upc
     * @return the JSON for mrt
     */
    private String getJSONForMRT(int workRequestId, List<Long> existingUPC) {
        String row4 = CPSConstants.EMPTY_STRING;
        String jsonString = "{\"ResultSet\":{\"recordsReturned\":1,\"totalRecords\":1, \"startIndex\":0, \"sort\":null, \"dir\":\"asc\",";
        jsonString += "\"records\":[";
        try {
            ActivationMessageVO activationMessageVO = getCommonService().getActivationInfoForMRT(workRequestId);
            // Fix 1214
            String upcInfo = getMrtUPC(activationMessageVO.getMrtUPC(), existingUPC);
            row4 = "{\"code\":\"MRT Case Id :\", \"desc\":\"" + activationMessageVO.getProductID() + " - "
                    + correctDQuotes(formatBackSlashForJSON(activationMessageVO.getProductDesc())) + "\"},";
            row4 += "{\"code\":\"UPC(s) tied to this MRT :\",  \"desc\":\""
                    + correctDQuotes(formatBackSlashForJSON(upcInfo)) + "\"}";
            row4 += "]}}";

        } catch (Exception e) {
            LOG.error("### Debug getJSONForMRT data error :"+e.getMessage(), e);
            row4 = "{\"code\":\"MRT Case Id :\", \"desc\":\"  - \"},";
            row4 += "{\"code\":\"UPC(s) tied to this MRT :\",  \"desc\":\" \"}";
            row4 += "]}}";
        }

        return jsonString + row4;
    }
    /**
     * Correct d quotes.
     *
     * @param value
     *            the value
     * @return the string
     */
    private String correctDQuotes(String value) {
        if (CPSHelper.isNotEmpty(value)) {
            if (value.indexOf('"') >= 0) {
                CharSequence t = "\"";
                CharSequence r = "\\\"";
                value = value.replace(t, r);
            }
        }
        return value;
    }
    /**
     * Gets the mrt upc.
     *
     * @param upcInfo
     *            the upc info
     * @param existingUPC
     *            the existing upc
     * @return the mrt upc
     */
    private String getMrtUPC(List<String> upcInfo, List<Long> existingUPC) {
        String returnVal = CPSConstants.EMPTY_STRING;
        if (null != upcInfo && !upcInfo.isEmpty()) {
            for (final String mrtupc : upcInfo) {
                final int dot = mrtupc.lastIndexOf('.');
                String strUPC = CPSConstants.EMPTY_STRING;
                if (dot >= 0) {
                    strUPC = mrtupc.substring(0, dot);
                } else {
                    strUPC = mrtupc;
                }
                String checkDigit = CPSHelper.getCheckDigit(strUPC);
                if (existingUPC != null && !existingUPC.isEmpty()) {
                    if (existingUPC.contains(CPSHelper.getLongValue(strUPC))) {
                        strUPC += "*";
                    }
                }
                returnVal = returnVal + strUPC + "-" + checkDigit+ "<br>";
            }
        }
        return returnVal;
    }
    /**
     * Format back slash for json.
     *
     * @param str
     *            the str
     * @return the string
     */
    public String formatBackSlashForJSON(String str) {
        String rtnStr = str;
        if (CPSHelper.isNotEmpty(str) && str.indexOf("\\") >= 0) {
            rtnStr = str.replace("\\", "\\\\");
        }
        return rtnStr;
    }
    /**
     * Gets the JSON for product.
     *
     * @param workRequestId
     *            the work request id
     * @return the JSON for product
     */
    private String getJSONForProduct(int workRequestId) {
        String row4 = CPSConstants.EMPTY_STRING;
        String jsonString = "{\"ResultSet\":{\"recordsReturned\":1,\"totalRecords\":1, \"startIndex\":0, \"sort\":null, \"dir\":\"asc\",";
        jsonString += "\"records\":[";
        try {
            ActivationMessageVO activationMessageVO = getCommonService().getActivationInfo(workRequestId);
            // ActivationMessageVO activationMessageVO =
            // getCommonService().getActivationInfo(52328); //52278, 52543,
            // 52561
            String itemInfo = getItemInfo(activationMessageVO.getItemCodes());
            String upcInfo = getUPC(activationMessageVO.getUpc());
            
            row4 = "{\"code\":\"Product Id :\", \"desc\":\""
                    + CPSHelper.getTrimmedValue(activationMessageVO.getProductID()) + "\"},";
            row4 += "{\"code\":\"Product Description :\",  \"desc\":\""
                    + correctDQuotes(formatBackSlashForJSON(activationMessageVO.getProductDesc())) + "\"},";
            row4 += "{\"code\":\"Item Code(s) :\",\"desc\":\"" + correctDQuotes(formatBackSlashForJSON(itemInfo))
                    + "\"},";
            row4 += "{\"code\":\"UPC(s) :\",\"desc\":\"" + upcInfo + "\"}";
            row4 += "]}}";

        } catch (Exception e) {
            LOG.error("### Debug getJSONForProduct data error :"+e.getMessage(), e);
            row4 = "{\"code\":\"Product Id :\", \"desc\":\"\"},";
            row4 += "{\"code\":\"Product Description :\",  \"desc\":\"\"},";
            row4 += "{\"code\":\"Item Code(s) :\",\"desc\":\"\"},";
            row4 += "{\"code\":\"UPC(s) :\",\"desc\":\"\"}";
            row4 += "]}}";
        }
        return jsonString + row4;
    }
    /**
     * Gets the item info.
     *
     * @param itemInfo
     *            the item info
     * @return the item info
     */
    private String getItemInfo(List<String> itemInfo) {
        String returnVal = CPSConstants.EMPTY_STRING;
        for (String strItem : itemInfo) {
            returnVal = returnVal + correctDQuotes(strItem) + "<br>";
        }
        return returnVal;
    }
    /**
     * Gets the upc.
     *
     * @param upcInfo
     *            the upc info
     * @return the upc
     */
    private String getUPC(List<String> upcInfo) {
        String returnVal = CPSConstants.EMPTY_STRING;
        for (final String upc : upcInfo) {
            returnVal = returnVal + upc + "-" + CPSHelper
    				.getCheckDigit(upc) + "<br>";
        }
        return returnVal;
    }

    /*
     * Add by VODC
     */
    /**
     * Gets the JSON for product bat upload. activateButton-button
     *
     * @param activatedWorkIdList
     *            the activated work id list
     * @return the JSON for product bat upload
     */
    private String getJSONForProductBatUpload(List<Integer> activatedWorkIdList) {
        String jsonString = "{\"ResultSet\":{\"recordsReturned\":1,\"totalRecords\":1, \"startIndex\":0, \"sort\":null, \"dir\":\"asc\",";
        jsonString += "\"records\":[";
        String row4 = CPSConstants.EMPTY_STRING;
        try {
            List<ActivationMessageVO> activationMessageVOList = getCommonService()
                    .getBatchUploadSubmissionInfo(activatedWorkIdList);
            Iterator<ActivationMessageVO> activationMessageVOIterator = activationMessageVOList.iterator();
            while (activationMessageVOIterator.hasNext()) {
                ActivationMessageVO activationMessageVO = activationMessageVOIterator.next();
                String itemInfo = getItemInfo(activationMessageVO.getItemCodes());
                String upcInfo = getUPC(activationMessageVO.getUpc());
                row4 += "{\"code\":\"Candidate Id :\", \"desc\":\"" + activationMessageVO.getProductID().toString()
                        + "\"},";
                row4 += "{\"code\":\"Candidate Description :\",  \"desc\":\""
                        + correctDQuotes(formatBackSlashForJSON(activationMessageVO.getProductDesc())) + "\"},";
                row4 += "{\"code\":\"Candidate Item Code(s) :\",\"desc\":\""
                        + correctDQuotes(formatBackSlashForJSON(itemInfo)) + "\"},";
                row4 += "{\"code\":\"UPC(s) :\",\"desc\":\"" + upcInfo + "\"},";
            }

            row4 = row4.substring(0, row4.length() - 1);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        String close = "]}}";
        return jsonString + row4 + close;
    }
    /**
     * Conflict store update.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_CONFLICT_STORE_UPDATE)
    public ModelAndView conflictStoreUpdate(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                          HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        List<ConflictStoreVO> conflictList = addNewCandidate.getConflictStoreVOs();
        List<StoreVO> savedList = new ArrayList<StoreVO>();
        addNewCandidate.setRejectClose(false);
        addNewCandidate.setRejectComments(CPSConstants.EMPTY_STRING);
        int k = 0;
        boolean check = false;
        for (ConflictStoreVO conflictStoreVO : conflictList) {
            if ((!CPSHelper.isEmpty(conflictStoreVO.getConflictListCost1())
                    && Float.parseFloat(conflictStoreVO.getConflictListCost1()) != 0)
                    || (!CPSHelper.isEmpty(conflictStoreVO.getConflictListCost2())
                    && Float.parseFloat(conflictStoreVO.getConflictListCost2()) != 0)) {
                StoreVO storeVO = new StoreVO();
                storeVO.setItemId(conflictStoreVO.getConflictItemId());
                storeVO.setVendorNumber(conflictStoreVO.getConflictVNumber1());
                storeVO.setCostGroup(conflictStoreVO.getConflictCostGroup1());
                storeVO.setListCost(conflictStoreVO.getConflictListCost1());
                storeVO.setStoreId(conflictStoreVO.getConflictStoreId());
                int conflictListCostInt1 = CPSHelper.getIntegerValue(
                        CPSHelper.getTrimmedValue(conflictStoreVO.getConflictListCost1() + CPSConstants.EMPTY_STRING));
                if (0 >= conflictListCostInt1) {
                    storeVO.setStoreRemoved(true);
                } else {
                    storeVO.setStoreRemoved(false);
                }
                savedList.add(storeVO);
                storeVO = new StoreVO();
                storeVO.setItemId(conflictStoreVO.getConflictItemId());
                storeVO.setVendorNumber(conflictStoreVO.getConflictVNumber2());
                storeVO.setCostGroup(conflictStoreVO.getConflictCostGroup2());
                storeVO.setListCost(conflictStoreVO.getConflictListCost2());
                storeVO.setStoreId(conflictStoreVO.getConflictStoreId());
                int conflictListCostInt2 = CPSHelper.getIntegerValue(
                        CPSHelper.getTrimmedValue(conflictStoreVO.getConflictListCost2() + CPSConstants.EMPTY_STRING));
                if (0 >= conflictListCostInt2) {
                    storeVO.setStoreRemoved(true);
                } else {
                    storeVO.setStoreRemoved(false);
                }
                savedList.add(storeVO);
            } else {
                k++;
                addNewCandidate.setRejectComments("C");
                addNewCandidate.setRejectClose(false);
                break;
            }
        }
        if (k == 0) {
            // Saving the conflict data to database
            // HB-S21
            check = getAddNewCandidateService().insertStoreData(savedList, null);
            if (check) {
                // insertStoreProduct(savedList, candidateForm);
                addNewCandidate.setRejectClose(true);
            }
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_CONFLICT_STORES);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * handles the 'viewStores' tab of the tab view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_UPDATE_VIEW_STORES)
    public ModelAndView updateViewStores(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                            HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String costGroup = addNewCandidate.getCostGroup();
        String listCost = addNewCandidate.getListCost();
        if (null != costGroup) {
            List<StoreVO> list = addNewCandidate.getStoreVOs();
            for (StoreVO storeVO : list) {
                String costGrp = storeVO.getCostGroup();
                if (costGroup.equals(costGrp)) {
                    storeVO.setListCost(listCost);
                }

            }
        }

        ModelAndView  model = new ModelAndView(RELATIVE_PATH_VIEW_STORE_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Prints the form.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_PRINT_FORM)
    public ModelAndView printForm(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                         HttpServletResponse resp) throws Exception {
        String forward = RELATIVE_PATH_PRINT_CANDIDATE;
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        addNewCandidate.setRejectClose(false);
        addNewCandidate.setRejectComments(CPSConstants.EMPTY_STRING);
        List<PrintFormVO> printFormVOList = new ArrayList<PrintFormVO>();
        addNewCandidate.setMRTList(new ArrayList<MrtVO>());
        if (!addNewCandidate.isHidMrtSwitch()) {
            List<CaseVO> caseVOList = addNewCandidate.getProductVO().getCaseVOs();
            boolean vendorExists = false;
            for (CaseVO caseVO : caseVOList) {
                List<VendorVO> vendorVOList = caseVO.getVendorVOs();
                if (null != vendorVOList && !vendorVOList.isEmpty()) {
                    vendorExists = true;
                    break;
                }
            }
            if (vendorExists) {
                /* try { */
                // productVO = getAddNewCandidateService().fetchProduct(prodId,
                // getUserRole());
                ProductVO productVO = addNewCandidate.getProductVO();
                if (null != productVO) {
                    String validationMsg = CPSConstants.EMPTY_STRING;
                    validationMsg = validatePrintForm(productVO);
                    if (CPSHelper.isNotEmpty(validationMsg)) {
                        validationMsg = validationMsg.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
                    }
                    if (CPSHelper.isEmpty(validationMsg)) {
                        if (hasNewVendor(productVO)) {
                            setEdcForItems(productVO.getCaseVOs(), addNewCandidate);
                            CPSWebUtil.setVendorVoListPrintsToCase(productVO);
                            setOneTouchAndSeasons(productVO);
                            setCreateOnProduct(productVO);
                            if (productVO.getCaseVOs() != null && !productVO.getCaseVOs().isEmpty()) {
                                for (CaseVO caseVO : productVO.getCaseVOs()) {
                                    caseVO.setItemCategoryList(getItemCategoryList());
                                }
                            }
                            //Sprint - 23
                            productVO.clearUPCKitVOs();
                            productVO.setUpcKitVOs(getAddNewCandidateService().getKitComponents(productVO.getPsProdId(), false, true));
                            productVO.setVendorLocationList(
                                    (Map<String, List<VendorLocationVO>>) req.getSession().getAttribute("vendorMap"));
                            if (BusinessUtil.isVendor(getUserRole())) {
                                productVO.setVendorLogin(true);
                            }
                            if (null != productVO.getWorkRequest()
                                    && CPSHelper.isEmpty(productVO.getWorkRequest().getScnCdId())) {// missing
                                // bunus
                                // upc
                                String scanId = this.getAddNewCandidateService()
                                        .checkBonusByPsProdId(productVO.getWorkRequest().getWorkIdentifier());
                                if (CPSHelper.isNotEmpty(scanId)) {
                                    productVO.getWorkRequest().setScnCdId(scanId);
                                }
                            }
                            printFormVOList = PrintFormHelper.copyEntityToEntity(productVO, req.getSession().getId(),
                                    req, resp, getCommonService(), getAddNewCandidateService(), hebLdapUserService);
                            addNewCandidate.setPrintFormVOList(printFormVOList);
                            addNewCandidate.setProductDescription(productVO.getClassificationVO().getProdDescritpion());
                        } else {
                            addNewCandidate.setRejectClose(true);
                            addNewCandidate.setRejectComments(
                                    "Candidate needs to have at least one new vendor to Print Form.");
                        }
                    } else {
                        addNewCandidate.setRejectClose(true);
                        String strMessage = "Can not print form. Missing following data - ";
                        addNewCandidate.setRejectComments(strMessage + validationMsg);
                    }
                }
            } else {
                addNewCandidate.setRejectClose(true);
                addNewCandidate.setRejectComments("Candidate needs to have a vendor to Print Form");
            }
            req.getSession().setAttribute(CPSConstants.SELECTED_CASE_VO, getSelectedCaseVO(addNewCandidate));
        } else {
            // MRT print form
            try {
                printFormVOList = new ArrayList<PrintFormVO>();
                printFormVOList.add(getMRTPrintInfo(addNewCandidate));
                forward = RELATIVE_PATH_PRINT_FORM_MRTZ;
                addNewCandidate.setPrintFormVOList(printFormVOList);
                req.getSession().setAttribute("MRTList", addNewCandidate.getMRTList());
            } catch (CPSGeneralException e) {
                LOG.error(e.getMessage(), e);
                addNewCandidate.setRejectClose(true);
                addNewCandidate.setRejectComments(e.getMessage());
            }
            req.getSession().setAttribute(CPSConstants.SELECTED_CASE_VO, getSelectedCaseVO(addNewCandidate));

        }
        ModelAndView  model = new ModelAndView(forward);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Gets the MRT print info.
     *
     * @param candidateForm
     *            the candidate form
     * @return the MRT print info
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    private PrintFormVO getMRTPrintInfo(AddNewCandidate candidateForm) throws CPSGeneralException {
        PrintFormVO printFormVO = new PrintFormVO();
        List<BaseJSFVO> prodDesc = new ArrayList<BaseJSFVO>();

        List<MRTUPCVO> prods = null;
        MrtVO mrtVO = candidateForm.getMrtvo();
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
            // set isNotChckMerForMrt for PIM 1005
            mrtVO.setNotChckMerForMrt(true);
            String validationMsg = validatePrintForm(mrtVO, productVOs);
            mrtVO.setNotChckMerForMrt(false);
            validationMsg = validationMsg.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
            if (CPSHelper.isNotEmpty(validationMsg)) {
                throw new CPSGeneralException(validationMsg);
            }

            // MrtVO mrtVOTemp =getCorrectedMRT(mrtVO);
            candidateForm.getMRTList().add(getCorrectedMRT(mrtVO, productVOs));
            String caseDescription = mrtVO.getCaseVO().getCaseDescription();
            String prodId = CPSHelper.getStringValue(mrtVO.getCaseVO().getPsItemId());
            prods = mrtVO.getMrtVOs();

            for (MRTUPCVO mrtupcvo : prods) {
                prodDesc.add(new BaseJSFVO(mrtupcvo.getProdId(), mrtupcvo.getDescription()));
            }

            printFormVO.setMrtDescription(new BaseJSFVO(prodId, caseDescription));
            printFormVO.setMrtchildren(prodDesc);
        }
        return printFormVO;
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
    private MrtVO getCorrectedMRT(MrtVO mrtVO, Map<BigDecimal, ProductVO> productVOs) throws CPSGeneralException {
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
    /**
     * Validate vendor link.
     *
     * @param tempFlag
     *            the temp flag
     * @param newAllMRT
     *            the new all mrt
     * @param tempMsg
     *            the temp msg
     * @param tempActiveMsg
     *            the temp active msg
     * @throws CPSGeneralException
     *             the CPS general exception
     */
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
    /**
     * Validate active print form.
     *
     * @param productVO
     *            the product vo
     * @return the string
     */
    private String validateActivePrintForm(ProductVO productVO) {
        String submitCheck = CPSConstants.EMPTY_STRING;
        if (isVendor()) {
            submitCheck = SubmitValidator.mandatoryCheckActive(productVO);
        }
        return submitCheck;
    }
    // Fix PrintForm Create On
    /**
     * Sets the creates the on product.
     *
     * @param productVO
     *            the new creates the on product
     */
    public void setCreateOnProduct(ProductVO productVO) {
        int workrequestId = productVO.getWorkRequest().getWorkIdentifier();
        try {
            List<PsCandidateStat> psCandidateStats = getAddNewCandidateService()
                    .getCandidateStatByworkId(workrequestId);
            if (null != psCandidateStats && !psCandidateStats.isEmpty()) {
                for (PsCandidateStat psCandidateStat : psCandidateStats) {
                    if (CPSHelper.getTrimmedValue(psCandidateStat.getPsStat().getPdSetupStatCd())
                            .equalsIgnoreCase(BusinessConstants.WORKING_CODE)) {
                        productVO.setCreateOn(psCandidateStat.getId().getLstUpdtTs());
                        break;
                    } else {
                        productVO.setCreateOn(psCandidateStat.getId().getLstUpdtTs());
                    }
                }
            }
        } catch (Exception ex) {
            LOG.error(ex.getMessage(), ex);
        }
    }
    /**
     * Sets the one touch and seasons.
     *
     * @param productVO
     *            the new one touch and seasons
     */
    private void setOneTouchAndSeasons(ProductVO productVO) {
        List<BaseJSFVO> touchTypes = null;
        List<BaseJSFVO> seasons = null;
        if (productVO != null) {
            List<CaseVO> cases = productVO.getCaseVOs();
            if (CPSHelper.isNotEmpty(cases)) {
                for (CaseVO caseVO : cases) {
                    if (("V").equalsIgnoreCase(caseVO.getChannel()) || ("WHS").equalsIgnoreCase(caseVO.getChannel())) {
                        try {
                            if (CPSHelper.isEmpty(caseVO.getTouchTypeList())) {
                                if (touchTypes == null) {
                                    touchTypes = getAppContextFunctions().getTouchTypeCodes();
                                }
                                caseVO.setTouchTypeList(touchTypes);
                            }
                        } catch (Exception e) {
                            LOG.error(e.getMessage(), e);
                        }
                    }
                    List<VendorVO> vendors = caseVO.getVendorVOs();
                    if (CPSHelper.isNotEmpty(vendors)) {
                        for (VendorVO vendorVO : vendors) {
                            if (CPSHelper.isEmpty(vendorVO.getSeasonalityList())) {
                                try {
                                    if (seasons == null) {
                                        seasons = getAppContextFunctions().getSeasonality();
                                    }
                                    vendorVO.setSeasonalityList(seasons);
                                } catch (Exception e) {
                                    LOG.error(e.getMessage(), e);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    /**
     * Checks for new vendor.
     *
     * @param productVO
     *            the product vo
     * @return true, if successful
     */
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
    /**
     * Validate print form.
     *
     * @param mrtVO
     *            the mrt vo
     * @return the string
     */
    private String validatePrintForm(MrtVO mrtVO, Map<BigDecimal, ProductVO> productVOs) {
        String submitCheck = CPSConstants.EMPTY_STRING;
        try {
            if (isVendor()) {
                submitCheck = getAddNewCandidateService().submitMRTValidatorForPrintForm(mrtVO, getUserRole(), productVOs);
            }
        } catch (CPSGeneralException e) {
            LOG.error(e.getMessage(), e);
            submitCheck = "Problem while validating MRT. Please logout and try again.";
        }
        return submitCheck;
    }
    /**
     * Validate print form.
     *
     * @param productVO
     *            the product vo
     * @return the string
     */
    private String validatePrintForm(ProductVO productVO) {
        String submitCheck = CPSConstants.EMPTY_STRING;
        if (isVendor()) {
            submitCheck = SubmitValidator.mandatoryCheck(productVO);
        }
        return submitCheck;
    }
    /**
     * Checks if is vendor.
     *
     * @return true, if is vendor
     */
    private boolean isVendor() {
        String userRole = getUserRole();
        return (CPSConstants.UNREGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole)
                || CPSConstants.REGISTERED_VENDOR_ROLE.equalsIgnoreCase(userRole));
    }
    /**
     * Check dsv item modify from view.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_CHECK_DSV_ITEM_MODIFY_FROM_VIEW)
    public ModelAndView checkDSVItemModifyFromView( @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                  HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String prodId = addNewCandidate.getProductVO().getProdId();
        StringBuilder warningDSV = new StringBuilder();
        if (CPSHelper.isNotEmpty(prodId)) {
            String strItemId = getCommonService().getItemIdBasedOnProdId(prodId);
            if (CPSHelper.isNotEmpty(strItemId)) {
                String temp = getCommonService().checkDSV(strItemId);
                if (CPSHelper.isNotEmpty(temp)) {
                    warningDSV.append(temp);
                }
            }
        }
        req.setAttribute(CPSConstants.JSON_DATA, warningDSV.toString());
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }
    /**
     * Reject comments.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_REJECT_COMMENTS)
    public ModelAndView rejectComments(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                                   HttpServletResponse resp) throws Exception {
        try {
            addNewCandidate.setSession(req.getSession());
            setForm(req, addNewCandidate);
            addNewCandidate.setTabIndex(AddNewCandidate.TAB_POW);
            addNewCandidate.setAddCandidateMode();

            ProductVO productVO = addNewCandidate.getProductVO();
            productVO.getClassificationVO().setUser(getUserRole());
            productVO.getClassificationVO().setComments(addNewCandidate.getRejectComments());
            productVO.getClassificationVO()
                    .setVendorVisibilitySw(addNewCandidate.getProductVO().getClassificationVO().isVendorVisibilitySw());
            productVO = getAddNewCandidateService().insertComments(productVO);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }

        return this.rejectCand(addNewCandidate, req, resp);
    }
    /**
     * Reject cand.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_REJECT_CAND)
    public ModelAndView rejectCand(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                   HttpServletResponse resp) throws Exception {
        String status = null;
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        status = getAddNewCandidateService().reject(addNewCandidate.getProductVO().getWorkRequest(), getUserRole());
        req.setAttribute("myMessage", "Candidate(s) " + status);
        addNewCandidate.setRejectClose(true);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_REJECT_ADD_CANDIDATE_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * Gets the data brick infor.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the data brick infor
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_GET_DATA_BRICK_INFOR)
    public ModelAndView getDataBrickInfor(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                          HttpServletResponse resp) throws Exception {
        addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String upc = req.getParameter("upc");
        int psWorkId = 0;
        if (null != req.getParameter("psWorkId")) {
            psWorkId = Integer.parseInt(req.getParameter("psWorkId"));
        }
        /*if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getImageAttVO()) && CPSHelper.isNotEmpty(upc)) {
            ImageAttributeVO imageAttributeVO = getAddNewCandidateService().getBrickAttrValue(upc, psWorkId,
                    addNewCandidate.getProductVO().getImageAttVO());
            addNewCandidate.getProductVO().setImageAttVO(imageAttributeVO);
            // buil data to json to match datatable for yui
            JSONObject jsonData = ExtendAndBrickAttrHelper.buildDtaOfAttrToJsonForBrick(imageAttributeVO);
            try {
                ImageAttributeVO imageAttributeVOTmp = (ImageAttributeVO) SerializationUtils.clone(imageAttributeVO);
                addNewCandidate.getSavedProductVO().setImageAttVO(imageAttributeVOTmp);
            } catch (SerializationException e) {
                LOG.error(e.getMessage(), e);
            }
            req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        }*/
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * get Data for All Attribute and build to Json.
     *
     * @author ha.than
     * @param addNewCandidate
     *            ActionForm
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ActionForward GET_DATA_TABLE_INFOR
     * @throws Exception
     *             Exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_GET_DATA_TABLE_INFOR)
    public ModelAndView getDataTableInfor(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                          HttpServletResponse resp) throws Exception {
        addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String upc = req.getParameter("upc");
        int psWorkId = Integer.parseInt(req.getParameter("psWorkId"));
        JSONObject jsonData = null;
        /*if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getImageAttVO()) && CPSHelper.isNotEmpty(upc)) {
            ImageAttributeVO imageAttributeVO = getAddNewCandidateService().getDynamicExtendAttrValue(upc, psWorkId,
                    addNewCandidate.getProductVO().getImageAttVO());
            addNewCandidate.getProductVO().setImageAttVO(imageAttributeVO);
            // buil data to json to match datatable for yui
            jsonData = ExtendAndBrickAttrHelper.buildDtaGrpToJson(imageAttributeVO);
            
             * try { ImageAttributeVO imageAttributeVOTmp = new
             * ImageAttributeVO(); BeanUtils.copyProperties(imageAttributeVOTmp,
             * imageAttributeVO);
             * candidateForm.getSavedProductVO().setImageAttVO
             * (imageAttributeVOTmp); } catch (IllegalAccessException e) { }
             * catch (InvocationTargetException e) { }
             
            try {
                // ImageAttributeVO imageAttributeVOTmp = (ImageAttributeVO)
                // SerializationUtils.clone(imageAttributeVO);
                addNewCandidate.getSavedProductVO().getImageAttVO()
                        .setExtendAttrWrapper((DynamicExtentionAttributeWrapperVO) SerializationUtils
                                .clone(imageAttributeVO.getExtendAttrWrapper()));
            } catch (SerializationException e) {
                LOG.error(e.getMessage(), e);
            }
        }*/
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * When clicking save button from audit record page.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_SAVE_COMMENTS)
    public ModelAndView saveComments(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                     HttpServletResponse resp) throws Exception {
        addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);

        String visibleSwitch = req.getParameter("selectedSwitch");
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_POW);
        addNewCandidate.setAddCandidateMode();
        try {
            ProductVO productVO = addNewCandidate.getProductVO();
            if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getClassificationVO().getUserComments())
                    && !addNewCandidate.getProductVO().getClassificationVO().getUserComments().trim()
                    .equals(addNewCandidate.getProductVO().getClassificationVO().getCommentOld().trim())) {
                productVO.getClassificationVO().setUser(getUserRole());
                productVO.getClassificationVO()
                        .setComments(addNewCandidate.getProductVO().getClassificationVO().getUserComments());
                if (CPSConstant.STRING_TRUE.equalsIgnoreCase(visibleSwitch)) {
                    productVO.getClassificationVO().setVendorVisibilitySw(true);
                } else {
                    productVO.getClassificationVO().setVendorVisibilitySw(false);
                }
                long primaryUPC = 0;
                if (!addNewCandidate.isProduct()) {
                    primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                } else {
                    if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                        /*
                         * This case upc got when user clicked on 'Save MRT
                         * Case' button Called from DWR
                         * (AddNewCandidateDWR->addMRTCaseVO)
                         */
                        primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                    }
                }
                String prodId = CPSConstant.STRING_0;
                if (primaryUPC == 0) {
                    if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPsProdId())) {
                        prodId = CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId());
                    } else if (CPSHelper.isNotEmpty(addNewCandidate.getSelectedProductId())
                            && CPSHelper.isEmpty(addNewCandidate.getProductVO().getProdId())) {
                        prodId = addNewCandidate.getSelectedProductId();
                    }
                    if (CPSHelper.isEmpty(prodId)) {
                        prodId = CPSConstant.STRING_0;
                    }
                }
                int workRequestId = getAddNewCandidateService().getWorkRequestId(prodId, primaryUPC);
                if (workRequestId != 0) {
                    WorkRequest workRequest = new WorkRequest();
                    workRequest.setWorkIdentifier(workRequestId);
                    productVO.setWorkRequest(workRequest);
                    productVO = getAddNewCandidateService().insertComments(productVO);
                    CPSMessage message = new CPSMessage(CPSConstants.COMMENTS_SAVED_SUCCESSFULLY, CPSMessage.ErrorSeverity.INFO);
                    saveMessage(addNewCandidate, message);
                    addNewCandidate.getProductVO().getClassificationVO()
                            .setCommentOld(addNewCandidate.getProductVO().getClassificationVO().getUserComments());
                    addNewCandidate.getProductVO().getClassificationVO().setUserComments(CPSConstants.EMPTY_STRING);
                } else {
                    CPSMessage message = new CPSMessage(CPSConstants.ALERT_CANDIDATE, CPSMessage.ErrorSeverity.INFO);
                    saveMessage(addNewCandidate, message);
                }
            }
        } catch (Exception exp) {
            LOG.error(exp.getMessage(), exp);
            CPSMessage message = new CPSMessage("Can not save comments", CPSMessage.ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * Gets the serv size uom data.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the serv size uom data
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_GET_SERV_SIZE_UOM_DATA)
    public ModelAndView getServSizeUOMData(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                           HttpServletResponse resp) throws Exception {
        addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        /*List<BaseVO> lstSzUOMs = addNewCandidate.getProductVO().getImageAttVO().getLstQuantityUOM();
        if (CPSHelper.isEmpty(lstSzUOMs)) {
            lstSzUOMs = getAddNewCandidateService().getLstNutriUOM();
        }*/
        List<BaseVO> lstSzUOMs = getAddNewCandidateService().getLstNutriUOM();
        JSONObject jsonData = ExtendAndBrickAttrHelper.buildDtaOfAttrToJsonForSzUOMs(lstSzUOMs);
        req.setAttribute(CPSConstants.JSON_DATA, jsonData);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_GET_APPROVED_USERNAME_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * This method used to modify candidate from EDI.
     *
     * @author nhatnc
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_MODIFY_CAND_FROM_EDI)
    public ModelAndView modifyCandFromEDI(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                          HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        String productSelecteds = addNewCandidate.getSelectedProductId();
        if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
            req.getSession().removeAttribute(CPSConstants.REDIRECT_FORM);
        }
        req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.EDI);
        if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
            req.getSession().setAttribute(CPSConstants.MODIFY_VALUE, CPSConstant.STRING_1);
        }

        if (productSelecteds != null && !CPSConstants.EMPTY_STRING.equals(productSelecteds)) {
            try {
                // candidateForm.getProductVO().setPsProdId(Integer.parseInt(productSelecteds.split(",")[0]));
                // candidateForm.setSelectedProductId(productSelecteds);

                setInputForwardValue(req, RELATIVE_PATH_NEW_PRODUCT_PAGE);
                clearViewMode(addNewCandidate);
                setViewMode(addNewCandidate);
                addNewCandidate.setModifyMode(true);
                addNewCandidate.setPrintable(false);
                addNewCandidate.setEnableClose(true);
                // be sure user can add UPC when switch to another tabs in Edit
                // Mode- Fix 1505
                addNewCandidate.setUpcAdded(true);
                Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                if (currentMode != null)
                    req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
                if(addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier()==12) {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_KIT);
                    addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_KIT);
                } else {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_CANDIDATE);
                    addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_CANDIDATE);
                }

                addNewCandidate.setPendingCandidateTypes(null);
                addNewCandidate.setCandidateTypeList(null);

                setForm(req, addNewCandidate);
                addNewCandidate.setEnableActiveButton(true);
                boolean viewMode = isViewMode(addNewCandidate);

                addNewCandidate.setLabelFormats(getLabelFormatList()); // R2
                if (addNewCandidate.getProductTypes() == null || addNewCandidate.getProductTypes().isEmpty()) {
                    addNewCandidate.setProductTypes(getProductTypes());
                }
                handleModify(addNewCandidate, viewMode, req);
                ProductVO productVO = addNewCandidate.getProductVO();
                if (CPSConstants.WORKING_CODE.equalsIgnoreCase(productVO.getWorkRequest().getWorkStatusCode())
                        && CPSWebUtil.isVendor(getUserRole())) {
                    addNewCandidate.setViewOverRide();
                    setViewMode(addNewCandidate);
                    addNewCandidate.setEnableClose(false);
                } else if (CPSHelper.isN(productVO.getNewDataSw())) {
                    setViewMode(addNewCandidate);
                    addNewCandidate.setUpcViewOverRide();
                    addNewCandidate.setCaseViewOverRide();
                    addNewCandidate.setButtonViewOverRide();
                    addNewCandidate.setEnableClose(false);
                    addNewCandidate.setModifyProdCand(true);
                } else {
                    addNewCandidate.clearViewOverRide();
                    clearViewMode(addNewCandidate);
                }
                // be sure data saved when user clicking on Next button or
                // switch to other tabs
                addNewCandidate.clearViewProduct();
            } catch (Exception e) {
                LOG.error("Error modify candidate from EDI:" + e.getMessage(), e);
            }
        }

        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * Handle modify.
     *
     * @param candidateForm
     *            the candidate form
     * @param viewMode
     *            the view mode
     * @param req
     *            the req
     * @throws Exception
     *             the exception
     */
    private void handleModify(AddNewCandidate candidateForm, boolean viewMode, HttpServletRequest req)
            throws Exception {
        candidateForm.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
        candidateForm.setManageCandidateMode();
        if (!viewMode) {
            this.getDetails(candidateForm, req);
        }
        candidateForm.setNormalProduct(true);
        String stringVal = null;
        stringVal = candidateForm.getSelectedProductId();
        List<String> prodIds = candidateForm.getPendingProdIds();
        List<String> candidateType = candidateForm.getPendingCandidateTypes();
        if (CPSHelper.isEmpty(prodIds)) {
            String resultArray = candidateForm.getSelectedProductId();// req.getParameter("SelectedAttributeList");
            if (null != resultArray) {
                StringTokenizer idList = new StringTokenizer(resultArray, CPSConstants.COMMA);
                stringVal = idList.nextToken();
                if (idList.hasMoreTokens()) {
                    List<String> addlIds = new ArrayList<String>();
                    while (idList.hasMoreTokens()) {
                        addlIds.add(idList.nextToken());
                    }
                    candidateForm.setPendingProdIds(addlIds);
                }
            }
        }
        /*
         * Loop candidate types and set into a variable. Purpose: user can view
         * next candidate.
         *
         * @author khoapkl
         */
        String candTpeVal = candidateForm.getCandidateTypeList();
        if (CPSHelper.isEmpty(candidateType)) {
            String resultArray = candidateForm.getCandidateTypeList();
            if (null != resultArray) {
                StringTokenizer candTypeList = new StringTokenizer(resultArray, CPSConstants.COMMA);
                candTpeVal = candTypeList.nextToken();
                if (candTypeList.hasMoreTokens()) {
                    List<String> pendingCandidateTypes = new ArrayList<String>();
                    while (candTypeList.hasMoreTokens()) {
                        pendingCandidateTypes.add(candTypeList.nextToken());
                    }
                    candidateForm.setPendingCandidateTypes(pendingCandidateTypes);
                    // Used for get next candidate type
                    // candidateForm.setCandidateTypeList(pendingCandidateTypes.toString());
                }
            }
        }
        if (null != stringVal) {
            try{
            candidateForm.setSelectedProductId(stringVal);
            ProductVO productVO = getAddNewCandidateService().fetchProduct(stringVal, getUserRole());
            //BAU-Feb-PIM-1608-Nutrition Facts--Get information
            List<BigInteger> unitUPCs = new ArrayList<BigInteger>();
            Map<BigInteger, String> mapUnitUPC = new HashMap<BigInteger, String>();
            Integer psWrkId = CPSConstant.NUMBER_0;
            if(!CPSHelper.isEmpty(productVO.getUpcVO())){
                for(UPCVO upcVO : productVO.getUpcVO()){
                    if(!CPSHelper.isEmpty(upcVO) && upcVO.getNewDataSw() == CPSConstant.CHAR_Y){
                        BigInteger upc = BigInteger.valueOf(Long.valueOf(CPSHelper.getTrimmedValue(upcVO.getUnitUpc())));
                        unitUPCs.add(upc);
                        mapUnitUPC.put(upc, CPSHelper.getTrimmedValue(upcVO.getUnitUpc()));
                    }
                }
                psWrkId = productVO.getWorkRequest().getWorkIdentifier();
            }
            this.getAddNewCandidateService().getNutritionFactsInformation(productVO, unitUPCs, psWrkId, mapUnitUPC);
            if (!CPSHelper.isEmpty(productVO.getApprByUserId())) {
                productVO.setApprByUserName(getDisplayNameByUserId(productVO.getApprByUserId()));
            }
            // search selling restriction for candidate
            setSellingRestriction(productVO);
            candidateForm.setProductVO(productVO);
            // -----New feature for Tax category---
            if (!BusinessUtil.isVendor(getUserRole())) {
                try {
                    candidateForm.getProductVO().getPointOfSaleVO()
                            .setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
                    if (CPSHelper.isNotEmpty(candidateForm.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
                        for (TaxCategoryVO tax : candidateForm.getProductVO().getPointOfSaleVO().getListTaxCategory()) {
                            if (CPSHelper.checkEqualValue(
                                    candidateForm.getProductVO().getPointOfSaleVO().getTaxCateCode(),
                                    tax.getTxBltyDvrCode())) {
                                candidateForm.getProductVO().getPointOfSaleVO().setTaxCateName(tax.getTxBltyDvrName());
                                break;
                            }
                        }
                    }
                } catch (CPSGeneralException e) {
                    CPSMessage message = new CPSMessage(e.getMessage(), CPSMessage.ErrorSeverity.INFO);
                    saveMessage(candidateForm, message);
                    LOG.error(e.getMessage(), e);
                }
            }
            // -----New feature for Tax category---
            if (candidateForm.isHidBatchUploaded()) {
                productVO.setBactchUploadMode(true);
            } else {
                productVO.setBactchUploadMode(false);
            }
            this.setUOMDesc(productVO, candidateForm);
            if (BusinessUtil.isVendor(getUserRole())) {
                correctListCostForVendor(productVO, candidateForm);
            }
            if (CPSHelper.isNotEmpty(candidateForm.getProductVO().getOriginSellingRestriction())) {
                productVO.setOriginSellingRestriction(candidateForm.getProductVO().getOriginSellingRestriction());
            }

            candidateForm.setSavedProductVO(ProductVOHelper.copyProductVOtoProductVO(productVO));
            Map<String, UPCVO> upcMap = new HashMap<String, UPCVO>();
            List<UPCVO> upcs = productVO.getUpcVO();

            for (UPCVO upcvo : upcs) {
                upcvo.setUnitUpc10(CPSHelper.calculateCheckDigit(upcvo.getUnitUpc()) + CPSConstants.EMPTY_STRING);
                upcMap.put(upcvo.getUniqueId(), upcvo);
            }
            candidateForm.setUpcVOs(upcMap);
            Map<String, CommentsVO> commentsMap = new HashMap<String, CommentsVO>();
            List<CommentsVO> comments = productVO.getCommentsVO();
            for (CommentsVO commentsvo : comments) {
                commentsvo.setUniqueId(CPSHelper.getUniqueId(commentsvo));
                commentsMap.put(commentsvo.getUniqueId(), commentsvo);
            }
            //Sprint - 23
            initUpcKitVO(candidateForm, productVO);

            candidateForm.setCommentsVOs(commentsMap);
            initProductVO(candidateForm, req);
            initBrandField(candidateForm);
            initMatrixMarginMap(candidateForm);
            }catch (Exception e) {
                CPSMessage message = new CPSMessage(e.getMessage(), CPSMessage.ErrorSeverity.INFO);
                saveMessage(candidateForm, message);
                LOG.error(e.getMessage(), e);
            }
            // setQualifyCondition(candidateForm);
        } else {
            CPSMessage message = new CPSMessage("Please Select a candidate", CPSMessage.ErrorSeverity.INFO);
            saveMessage(candidateForm, message);
        }
    }
    /**
     * This method used to modify product from EDI.
     *
     * @author tuanle
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_MODIFY_PRODUCT_FROM_EDI)
    public ModelAndView modifyProductFromEDI(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                             HttpServletResponse resp) throws Exception {
        // String productSelecteds = req.getParameter("productIds");
        addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());

        if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
            req.getSession().removeAttribute(CPSConstants.REDIRECT_FORM);
        }
        req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.EDI);
        if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
            req.getSession().setAttribute(CPSConstants.MODIFY_VALUE, CPSConstant.STRING_1);
        }
        String productSelecteds = addNewCandidate.getSelectedProductId();
        if (productSelecteds != null && !CPSConstants.EMPTY_STRING.equals(productSelecteds)) {
            try {
                setForm(req, addNewCandidate);
                setInputForwardValue(req, RELATIVE_PATH_NEW_PRODUCT_PAGE);
                req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_PRODUCT);
                // req.setAttribute(CURRENT_MODE_APP_NAME,CPSConstants.CPS);
                // CPSAddCandidateForm candidateForm = ((CPSAddCandidateForm)
                // form);
                // candidateForm.setSelectedProductId(productSelecteds);
                // hide Activate button
                addNewCandidate.setEnableActiveButton(false);
                // be sure user can add UPC when switch to another tabs in Edit
                // Mode- Fix 1505
                addNewCandidate.setUpcAdded(true);
                setViewMode(addNewCandidate);
                setModifyMode(addNewCandidate);
                addNewCandidate.setEnableClose(true);

                addNewCandidate.setModifyProdCand(true);
                setViewOverrideFlags(addNewCandidate);
                addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
                addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_PRODUCT);
                addNewCandidate.clearViewOverRide();
                addNewCandidate.setViewAddInforPage(false);
                // identify system will not validate for MRT product when
                // navigate to Additional Information Tab.
                addNewCandidate.setNormalProduct(true);

                String stringVal = null;
                stringVal = addNewCandidate.getSelectedProductId();
                List<String> prodIds = addNewCandidate.getPendingProdIds();
                if (CPSHelper.isEmpty(prodIds)) {
                    String resultArray = addNewCandidate.getSelectedProductId();
                    if (null != resultArray) {
                        StringTokenizer idList = new StringTokenizer(resultArray, ",");
                        if (idList.hasMoreTokens())
                            stringVal = idList.nextToken();
                        if (idList.hasMoreTokens()) {
                            List<String> addlIds = new ArrayList<String>();
                            while (idList.hasMoreTokens()) {
                                addlIds.add(idList.nextToken());
                            }
                            addNewCandidate.setPendingProdIds(addlIds);
                        }
                    }
                }
                if (null != stringVal) {
                    addNewCandidate.setSelectedProductId(stringVal);
                    ProductVO productVO = getAddNewCandidateService().getProduct(null, stringVal, null);
                    this.correctUOM(productVO);
                    // correct the list cost for Vendors
                    if (BusinessUtil.isVendor(getUserRole())) {
                        correctListCostForVendor(productVO, addNewCandidate);
                        // PIM 831
                        // getCorrectInforVendorLogin(productVO, req);
                        // end PIM 831
                    }
                    if (productVO!=null && CPSHelper.isNotEmpty(productVO.getProdId())) {
                        JSONArray jsonData = getSellingJsonFromWS(productVO.getProdId(),getCommonService().getSellingRestriction(productVO.getClassCommodityVO().getDeptId(), productVO.getClassCommodityVO().getSubDeptId(), productVO.getClassCommodityVO().getClassCode(), productVO.getClassificationVO().getCommodity(), productVO.getClassificationVO().getSubCommodity()));
                        if (!jsonData.isEmpty()) {
                            productVO.setOriginSellingRestriction(jsonData.toString());
                        }
                    }
                    addNewCandidate.setProductVO(productVO);
                    // saving the product VO
                    productVO.setNewDataSw(CPSConstant.CHAR_N);

                    clearMessages(addNewCandidate);

                    productVO = addNewCandidate.getProductVO();
                    productVO.setModifyFlag(true);
                    addNewCandidate.setBdms(getBdmList());
                    initProductVO(addNewCandidate, req);
                    initProductServiceVO(addNewCandidate, req);
                    if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getShelfEdgeVO().getPackaging())) {
                        addNewCandidate.setPackagingViewOverRide();
                    }
                    addNewCandidate.setButtonViewOverRide();
                    CPSMessage message = new CPSMessage("Product Copied for Modifiy", CPSMessage.ErrorSeverity.INFO);
                    saveMessage(addNewCandidate, message);
                    addNewCandidate.setProduct(true);
                    addNewCandidate.setProductCaseOverridden(true);
                    addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
                    Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                    if (currentMode != null)
                        req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                    req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
                    this.getDetails(addNewCandidate, req);

                    productVO = addNewCandidate.getProductVO();
                    if (CPSHelper.isEmpty(productVO.getRetailVO().getCriticalItemName())) {
                        productVO.getRetailVO().setCriticalItemName(getNameForCode(addNewCandidate.getCriItemList(),
                                productVO.getRetailVO().getCriticalItem()));
                    }
                    if (CPSHelper.isEmpty(productVO.getRetailVO().getTobaccoTaxName())) {
                        productVO.getRetailVO().setTobaccoTaxName(
                                getNameForCode(addNewCandidate.getYesNoList(), productVO.getRetailVO().getTobaccoTax()));
                    }

                    addNewCandidate.getProductVO().setModifyFlag(true);
                    addNewCandidate.setViewOverRide();

                }
                addNewCandidate.getProductVO().setModifyFlag(true);
                addNewCandidate.setViewOverRide();
                // be sure data saved when user clicking on Next button or
                // switch to other tabs
                addNewCandidate.clearViewProduct();

            } catch (Exception e) {
                LOG.error("Error modify product from EDI:" + e.getMessage(), e);
            }

        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * This method used to view candidate from EDI.
     *
     * @author nhatnc
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VIEW_CAND_FROM_EDI)
    public ModelAndView viewCandFromEDI(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                        HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.EDI);
        ManageEDICandidate ediform = (ManageEDICandidate) req.getSession().getAttribute(ManageEDICandidate.FORM_NAME);

        if (ediform != null)
            req.getSession().setAttribute(CPSConstants.EDI_CURRENT_TAB, ediform.getCurrentTab());

        if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
            req.getSession().removeAttribute(CPSConstants.MODIFY_VALUE);
        }
        String productSelecteds = addNewCandidate.getSelectedProductId();
        if (productSelecteds != null && !CPSConstants.EMPTY_STRING.equals(productSelecteds)) {
            try {
                // candidateForm.getProductVO().setPsProdId(Integer.parseInt(productSelecteds.split(",")[0]));
                addNewCandidate.setSelectedProductId(productSelecteds);
                setViewMode(addNewCandidate);
                clearModifyMode(addNewCandidate);
                addNewCandidate.setViewOverRide();
                addNewCandidate.setProduct(false);
                addNewCandidate.setPrintable(true);
                addNewCandidate.setEnableClose(false);
                // be sure user can not add upc in View Mode-fix 1505
                addNewCandidate.setUpcAdded(false);
                Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                if (currentMode != null)
                    req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
                if(addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier()==12) {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_KIT_CANDIDATE);
                    addNewCandidate.setCurrentAppName(CPSConstants.VIEW_KIT_CANDIDATE);
                } else {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_CANDIDATE);
                    addNewCandidate.setCurrentAppName(CPSConstants.VIEW_CANDIDATE);
                }
                addNewCandidate.setPendingCandidateTypes(null);
                addNewCandidate.setCandidateTypeList(null);

                setForm(req, addNewCandidate);
                addNewCandidate.setEnableActiveButton(true);
                boolean viewMode = isViewMode(addNewCandidate);
                addNewCandidate.setViewAddInforPage(false);
                addNewCandidate.setLabelFormats(getLabelFormatList()); // R2
                handleModify(addNewCandidate, viewMode, req);
                // modifyCandInternal(mapping, candidateForm, req, resp);
                addNewCandidate.setViewProduct();
            } catch (Exception e) {
                LOG.error("Error view candidate from EDI:" + e.getMessage(), e);
            }
        }
        // comment setRateAndRatingType because it can moved to selling
        // restrictions
        // setRateAndRatingType(candidateForm);
        // ---------end
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }
    /**
     * This method used to view product from EDI.
     *
     * @author tuanle
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VIEW_PRODUCT_FROM_EDI)
    public ModelAndView viewProductFromEDI(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req,
                                           HttpServletResponse resp) throws Exception {
        //addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.EDI);
        if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
            req.getSession().removeAttribute(CPSConstants.MODIFY_VALUE);
        }
        String productSelecteds = addNewCandidate.getSelectedProductId();
        if (productSelecteds != null && !CPSConstants.EMPTY_STRING.equals(productSelecteds)) {
            try {
                setForm(req, addNewCandidate);
                setInputForwardValue(req, RELATIVE_PATH_NEW_PRODUCT_PAGE);
                req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
                addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
                addNewCandidate.setManageCandidateMode();
                clearModifyMode(addNewCandidate);
                // addCandidateForm.setSelectedProductId(productSelecteds);
                addNewCandidate.setEnableActiveButton(false);
                // be sure user can not add UPC when switch to another tabs in
                // View Mode- Fix 1505
                addNewCandidate.setUpcAdded(false);

                // addCandidateForm.setHidMrtSwitch(false);
                addNewCandidate.clearButtonViewOverRide();
                addNewCandidate.setViewOnlyProductMRT(false);
                addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
                req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_PRODUCT);
                Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                if (currentMode != null)
                    req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
                req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
                req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_PRODUCT);
                addNewCandidate.setCurrentAppName(CPSConstants.VIEW_PRODUCT);

                addNewCandidate.setViewOverRide();
                setViewMode(addNewCandidate);
                addNewCandidate.setViewProduct();
                this.getDetails(addNewCandidate, req);
                addNewCandidate.setEnableClose(false);

                addNewCandidate.setProduct(true);
                String stringVal = null;
                stringVal = addNewCandidate.getSelectedProductId();
                List<String> prodIds = addNewCandidate.getPendingProdIds();
                isViewMode(addNewCandidate);// boolean viewMode =
                if (CPSHelper.isEmpty(prodIds)) {
                    String resultArray = addNewCandidate.getSelectedProductId();
                    if (null != resultArray) {
                        StringTokenizer idList = new StringTokenizer(resultArray, ",");
                        stringVal = idList.nextToken();
                        if (idList.hasMoreTokens()) {
                            List<String> addlIds = new ArrayList<String>();
                            while (idList.hasMoreTokens()) {
                                addlIds.add(idList.nextToken());
                            }
                            addNewCandidate.setPendingProdIds(addlIds);
                        }
                    }
                }
                if (null != stringVal) {
                    addNewCandidate.setSelectedProductId(stringVal);
                    // fix performance change menthod getProduct to
                    // getProductBasic(don't get image attribute)
                    // because when navigate to image tab then app will get data
                    // image
                    ProductVO productVO = getAddNewCandidateService().getProductBasic(null, stringVal, null);
                    this.correctUOM(productVO);
                    // correct the list cost for Vendors
                    if (BusinessUtil.isVendor(getUserRole())) {
                        correctListCostForVendor(productVO, addNewCandidate);
                        // PIM 831
                        // getCorrectInforVendorLogin(productVO, req);
                        // end PIM 831
                    }
                    if (productVO!=null && CPSHelper.isNotEmpty(productVO.getProdId())) {
                        JSONArray jsonData = getSellingJsonFromWS(productVO.getProdId(),getCommonService().getSellingRestriction(productVO.getClassCommodityVO().getDeptId(), productVO.getClassCommodityVO().getSubDeptId(), productVO.getClassCommodityVO().getClassCode(), productVO.getClassificationVO().getCommodity(), productVO.getClassificationVO().getSubCommodity()));
                        if (!jsonData.isEmpty()) {
                            productVO.setOriginSellingRestriction(jsonData.toString());
                        }
                    }
                    this.setUOMDesc(productVO, addNewCandidate);
                    addNewCandidate.setProductVO(productVO);
                    initProductServiceVO(addNewCandidate, req);
                    // comment setRateAndRatingType because it can moved to
                    // selling restrictions
                    // setRateAndRatingType(candidateForm);
                    // ---------end
                    addNewCandidate.setBdms(getBdmList());
                    addNewCandidate.setProduct(true);
                }
                if(addNewCandidate.getProductVO().isActiveProductKit()) {
                    req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_KIT_PRODUCT);
                    addNewCandidate.setCurrentAppName(CPSConstants.VIEW_KIT_PRODUCT);
                }
            } catch (Exception e) {
                LOG.error("Error view product from EDI:" + e.getMessage(), e);
            }
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return  model;
    }

    @RequestMapping(method = {RequestMethod.POST, RequestMethod.GET}, value = RELATIVE_PATH_VIEW_FACTORIES)
    public ModelAndView viewFactories(AddNewCandidate addNewCandidate, HttpServletRequest req,
                                      HttpServletResponse resp) throws Exception {
        addNewCandidate = getLastForm(req.getSession(), addNewCandidate);
        addNewCandidate.setSession(req.getSession());
        setForm(req, addNewCandidate);
        List<FactoryVO> factories = getCommonService().getFactories();
        // Identify which case, which vendor & pass to jsp for processing.
        String vendorID = req.getParameter("selectedVendorId");
        String itemID = req.getParameter("selectedItemId");
        req.setAttribute("selectedVendorId", vendorID);
        req.setAttribute("selectedItemId", itemID);
        req.setAttribute("editVendorBtnEnable", req.getParameter("editVendorBtnEnable"));
        req.setAttribute(CPSConstants.FACTORY_LIST, factories);
        req.setAttribute(CPSConstants.CURRENT_APP_NAME, "Import Facilities");
        String vendorType = getChannelType(vendorID, addNewCandidate);
        CaseVO caseVO = addNewCandidate.getProductVO().getCaseVO(itemID);
        List<WareHouseVO> list = null;
        if (!addNewCandidate.isViewMode()) {
            list = getImportedWarehouses(vendorID, String.valueOf(caseVO.getPsItemId()), vendorType, caseVO.getClassCode());
        } else if (caseVO.getNewDataSw() == CPSConstant.CHAR_N) {
            list = getImportFactoryProduct(vendorID, String.valueOf(caseVO.getItemId()), vendorType,
                    caseVO.getVendorVO(vendorID), caseVO.getClassCode());
        } else {
            list = getImportedWarehouses(vendorID, String.valueOf(caseVO.getPsItemId()), vendorType, caseVO.getClassCode());
        }
        addNewCandidate.setWareHouseList(list);
        if (caseVO.getNewItemSw() == CPSConstant.CHAR_N) {
            addNewCandidate.setItemID(String.valueOf(caseVO.getItemId()));
        } else {
            addNewCandidate.setItemID(String.valueOf(caseVO.getPsItemId()));
        }
        addNewCandidate.setVendorId(vendorID);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_VIEW_FACTORIES_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    private List<WareHouseVO> getImportFactoryProduct(String uniquevendorId, String itemId, String vendorType,
                                                      VendorVO vendorVO, String classCode) throws CPSSystemException, CPSGeneralException, CPSBusinessException, Exception {
        // To get the Facility Code
        VendorList vendorList = new VendorList(null, null, CPSHelper.getIntegerValue(uniquevendorId));
        List<WareHouseVO> wareHouseListTemp;
        // List<WareHouseVO> fetchWareHouseList = new ArrayList<WareHouseVO>();
        List<WareHouseVO> facilityList = getCommonService().getWareHouseList(vendorList, classCode);
        // List<WareHouseVO> list = new ArrayList<WareHouseVO>();
        wareHouseListTemp = getWareHouseList(facilityList, CPSHelper.getTrimmedValue(uniquevendorId), itemId,
                vendorType);
        if (null != wareHouseListTemp) {
            // fetchWareHouseList = getWareHouseDetails(wareHouseListTemp,
            // CPSHelper.getTrimmedValue(uniquevendorId), itemId,
            // vendorType);
            if (vendorVO != null && vendorVO.getImportVO() != null && vendorVO.getImportVO().getFactoryIDs() != null
                    && !vendorVO.getImportVO().getFactoryIDs().isEmpty()) {
                for (WareHouseVO wareHouseVO : wareHouseListTemp) {
                    for (String fatoryId : vendorVO.getImportVO().getFactoryIDs()) {
                        if (wareHouseVO.getFacilityNumber().equals(fatoryId)) {
                            wareHouseVO.setCheck(true);
                            break;
                        }
                        wareHouseVO.setVendorWHSNumber(CPSHelper.getTrimmedValue(uniquevendorId));
                    }
                }
            }
        }
        return wareHouseListTemp;
    }
    
    @RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_VIEW_CAND_FROM_MANAGE)
	public ModelAndView viewCandFromManage(
			@Valid @ModelAttribute ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
    	AddNewCandidate addNewCandidate = this.getConvertedModel(manageCandidate);
		return viewCand(addNewCandidate, req, resp);
	}

	/**
	 * View candidate.
	 * 
	 * @param addNewCandidate
	 *            the add new candidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return call the method modifyCandInternal
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_VIEW_CAND)
	public ModelAndView viewCand(
			@Valid @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
        if("MRT".equals(addNewCandidate.getCandidateTypeList())){
            addNewCandidate.setSelectedOption("4");
            addNewCandidate.setViewAddInforPage(true);
        }else{
            addNewCandidate.setSelectedOption(null);
            addNewCandidate.setViewAddInforPage(false);
        }        
		setForm(req, addNewCandidate);
		addNewCandidate.setSession(req.getSession());
		addNewCandidate.setCurrentRequest(req);		
		addNewCandidate.setUserRole(this.getUserRole());
		clearMessages(addNewCandidate);
		setViewMode(addNewCandidate);		

		boolean isEDI = false;
		if (req.getSession().getAttribute(CPSConstants.REDIRECT_FORM) != null) {
			String fmNm = req.getSession().getAttribute(CPSConstants.REDIRECT_FORM).toString();
			if (fmNm.equals(CPSConstants.EDI)) {
				isEDI = true;
			}
		}
		if (!isEDI) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS);
		}
		if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
			req.getSession().removeAttribute(CPSConstants.MODIFY_VALUE);
		}
		clearModifyMode(addNewCandidate);
		addNewCandidate.setViewOverRide();
		addNewCandidate.setProduct(false);
		addNewCandidate.setPrintable(true);
		addNewCandidate.setEnableClose(false);
		// Add list qualify condition
		// setQualifyCondition(addNewCandidate);
		// be sure user can not add upc in View Mode-fix 1505
		addNewCandidate.setUpcAdded(false);
		String hidBatchUpload = req.getParameter("batchUpload");
		if (CPSHelper.isNotEmpty(hidBatchUpload)) {
			if ((CPSConstant.STRING_TRUE).equals(hidBatchUpload)) {
				addNewCandidate.setHidBatchUploaded(true);
			} else {
				addNewCandidate.setHidBatchUploaded(false);
			}
		}
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
		req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_CANDIDATE);
		addNewCandidate.setCurrentAppName(CPSConstants.VIEW_CANDIDATE);

		addNewCandidate.setViewImgAtt(true);
		ModelAndView modelAndView = modifyCandInternal(addNewCandidate, req, resp);
		if (addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier() == 12) {
			req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_KIT_CANDIDATE);
			addNewCandidate.setCurrentAppName(CPSConstants.VIEW_KIT_CANDIDATE);
		}
		addNewCandidate.setViewProduct();
		return modelAndView;
	}

	/**
	 * Modify candidate.
	 * 
	 * @param addNewCandidate
	 *            the add new candidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return call the method modifyCandInternal.
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_MODIFY_CAND)
	public ModelAndView modifyCand(
			@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView modelAndView = null;
        addNewCandidate.getMessages().clear();
        addNewCandidate.setUserRole(this.getUserRole());
		setForm(req, addNewCandidate);
		if("MRT".equals(addNewCandidate.getCandidateTypeList())) {
            addNewCandidate.setSelectedOption("4");
            addNewCandidate.setViewAddInforPage(true);
        }else{
            addNewCandidate.setSelectedOption(null);
            addNewCandidate.setViewAddInforPage(false);
        }
		addNewCandidate.setSession(req.getSession());
		addNewCandidate.setCurrentRequest(req);

		String hidBatchUpload = req.getParameter("batchUpload");
		if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS);
		} else if (req.getSession().getAttribute(CPSConstants.REDIRECT_FORM).equals(CPSConstants.EDI)) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.EDI);
		} else if (req.getSession().getAttribute(CPSConstants.REDIRECT_FORM).equals(CPSConstants.CPS)) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS);
		}
		if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
			req.getSession().setAttribute(CPSConstants.MODIFY_VALUE, CPSConstant.STRING_1);
		}

		if (CPSHelper.isNotEmpty(hidBatchUpload)) {
			if ((CPSConstant.STRING_TRUE).equals(hidBatchUpload)) {
				addNewCandidate.setHidBatchUploaded(true);
			} else {
				addNewCandidate.setHidBatchUploaded(false);
			}
		}
		setInputForwardValue(req, RELATIVE_PATH_NEW_PRODUCT_PAGE);
		clearViewMode(addNewCandidate);
		addNewCandidate.setPrintable(false);
		addNewCandidate.setEnableClose(true);
		addNewCandidate.setModifyMode(true);
		// be sure user can add UPC when switch to another tabs in Edit Mode-
		// Fix 1505
		addNewCandidate.setUpcAdded(true);
		modelAndView = modifyCandInternal(addNewCandidate, req, resp);
		ProductVO productVO = addNewCandidate.getProductVO();
		// add empty data in Merchandise Type
		if ("SPLY".equals(productVO.getClassificationVO().getProductType())) {
			BaseJSFVO jsfVo = new BaseJSFVO();
			jsfVo.setId(CPSConstant.STRING_EMPTY);
			jsfVo.setName(CPSConstant.STRING_EMPTY);
			addNewCandidate.getMerchandizingTypes().add(0, jsfVo);
		}
		if (addNewCandidate.isHidBatchUploaded()) {
			productVO.setBactchUploadMode(true);
		} else {
			productVO.setBactchUploadMode(false);
		}

		String mrtCheck = req.getParameter("mrtCheck");
		if (CPSConstant.STRING_TRUE.equalsIgnoreCase(mrtCheck) || addNewCandidate.isMrtActiveProduct()
				|| addNewCandidate.getCandidateType().equals(CPSConstants.MRT)) {
			MrtVO mrtVO = addNewCandidate.getMrtvo();
			if (CPSConstants.WORKING_CODE.equalsIgnoreCase(mrtVO.getWorkRequest().getWorkStatusCode())
					&& CPSWebUtil.isVendor(getUserRole())) {
				addNewCandidate.setViewOverRide();
				setViewMode(addNewCandidate);
				addNewCandidate.setEnableClose(false);
			} else {
				/*
				 * Identify MRT Additional Information Page
				 * 
				 * @author khoapkl
				 */
				addNewCandidate.setViewAddInforPage(true);
			}
		} else if (CPSConstants.WORKING_CODE.equalsIgnoreCase(productVO.getWorkRequest().getWorkStatusCode())
				&& CPSWebUtil.isVendor(getUserRole())) {
			addNewCandidate.setViewOverRide();
			setViewMode(addNewCandidate);
			addNewCandidate.setEnableClose(false);
		} else if (CPSHelper.isN(productVO.getNewDataSw())) {
			setViewMode(addNewCandidate);
			addNewCandidate.setUpcViewOverRide();
			addNewCandidate.setCaseViewOverRide();
			addNewCandidate.setButtonViewOverRide();
			addNewCandidate.setEnableClose(false);
			addNewCandidate.setModifyProdCand(true);
			addNewCandidate.setScaleViewOverRide();
		} else {
			addNewCandidate.clearViewOverRide();
			clearViewMode(addNewCandidate);
		}
		// be sure data saved when user clicking on Next button or switch to
		// other tabs
		addNewCandidate.clearViewProduct();
		if (addNewCandidate.getProductVO().getWorkRequest().getIntentIdentifier() == 12) {
			req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_KIT);
			addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_KIT);
		} else {
			req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_CANDIDATE);
			addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_CANDIDATE);
		}
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
		return modelAndView;
	}

	/**
	 * handles the 'prodAndUpc' tab of the tab view.
	 *
	 * @param manageCandidate
	 *            the addNewCandidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return ModelAndView
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_COPY_CAND)
	public ModelAndView copyCand(
			@Valid @ModelAttribute ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {

		AddNewCandidate addNewCandidate = this.getConvertedModel(manageCandidate);
		setForm(req, addNewCandidate);
		ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
		addNewCandidate.setSession(req.getSession());

		setInputForwardValue(req, CPSConstants.ADD_NEW_OTHER_INFO);
		addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
		addNewCandidate.setManageCandidateMode();
		addNewCandidate.setEnableActiveButton(true);
		req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.COPPY_CANDIDATE);
		addNewCandidate.setCurrentAppName(CPSConstants.COPPY_CANDIDATE);
		this.getDetails(addNewCandidate, req);
		StringTokenizer idList = new StringTokenizer(addNewCandidate.getSelectedProductId(), CPSConstants.COMMA);
		String stringVal = idList.nextToken();
		req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS);
		UserInfo userInfo = getUserInfo();
		WorkRequest workRqst = new WorkRequest();
		workRqst.setVendorEmail(userInfo.getMail());
		String phone = userInfo.getAttributeValue("telephoneNumber");
		if (!CPSHelper.isEmpty(phone)) {
			phone = CPSHelper.cleanPhoneNumber(phone);
			if (!CPSHelper.isEmpty(phone)) {
				if (phone.length() >= 10) {
					workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
					workRqst.setVendorPhoneNumber(phone.substring(3, 10));
				} else {
					workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
					workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
				}
			}
		}
		workRqst.setCandUpdtUID(userInfo.getUid());
		workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
		workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
		ProductVO productVO = getAddNewCandidateService().copyProduct(stringVal, getUserRole(), workRqst);

		productVO.setPrimaryUPC(null);
		productVO.getPointOfSaleVO().setPse(CPSConstants.EMPTY_STRING);
		// Sprint - 23
		addNewCandidate.setModifyMode(true);
		addNewCandidate.setProductVO(productVO);
		initProductVO(addNewCandidate, req);
		initBrandField(addNewCandidate);

		// be sure user can be add UPC in Edit Mode
		addNewCandidate.setUpcAdded(true);
		Map<String, UPCVO> upcMap = new HashMap<String, UPCVO>();
		List<UPCVO> upcs = productVO.getUpcVO();
		for (UPCVO upcvo : upcs) {
			upcvo.setUniqueId(CPSHelper.getUniqueId(upcvo));
			upcvo.setPseGram(CPSConstants.EMPTY_STRING);
			upcMap.put(upcvo.getUniqueId(), upcvo);
		}

		addNewCandidate.setUpcVOs(upcMap);
		// fix bug 31829
		// -----New feature for Tax category---
		if (!BusinessUtil.isVendor(getUserRole())) {
			try {
				addNewCandidate.getProductVO().getPointOfSaleVO()
						.setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
				if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory())) {
					for (TaxCategoryVO tax : addNewCandidate.getProductVO().getPointOfSaleVO().getListTaxCategory()) {
						if (CPSHelper.checkEqualValue(
								addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode(),
								tax.getTxBltyDvrCode())) {
							addNewCandidate.getProductVO().getPointOfSaleVO().setTaxCateName(tax.getTxBltyDvrName());
							break;
						}
					}
				}
			} catch (Exception e) {
				LOG.error("Error occur when call ws TaxCategory:" + e.getMessage(), e);
			}
		}

		model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
		return model;
	}

	/**
	 * handles the 'prodAndUpc' tab of the tab view.
	 *
	 * @param manageCandidate
	 *            the addNewCandidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return ModelAndView
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_MODIFY_CAND_DBLCLICK)
	public ModelAndView modifyCandDblClick(
			@Valid @ModelAttribute ManageCandidate manageCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {

		AddNewCandidate addNewCandidate = this.getConvertedModel(manageCandidate);
		return modifyCand(addNewCandidate, req, resp);
	}

	/**
	 * View product.
	 * 
	 * @param addNewCandidate
	 *            the addNewCandidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return ModelAndView
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_VIEW_PRODUCT)
	public ModelAndView viewProduct(
			@Valid @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
        clearMessages(addNewCandidate);
		setForm(req, addNewCandidate);
		setInputForwardValue(req, CPSConstants.ADD_NEW_OTHER_INFO);
		req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS_PRODUCT);
		if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
			req.getSession().removeAttribute(CPSConstants.MODIFY_VALUE);
		}
		req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
		addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
		addNewCandidate.setManageCandidateMode();
		// hide Activate button
		addNewCandidate.setEnableActiveButton(false);
		// be sure user can not add UPC when switch to another tabs in View
		// Mode- Fix 1505
		addNewCandidate.setUpcAdded(false);
		clearModifyMode(addNewCandidate);
		boolean viewMode = isViewMode(addNewCandidate);
		String selectedMrtLabel = addNewCandidate.getSelectedMrtLabel();
		// String candTpeVal = addNewCandidate.getCandidateTypeList();
		List<String> candidateType = addNewCandidate.getPendingCandidateTypes();
		/*
		 * Loop candidate types and set into a variable. Purpose: user can view
		 * next product.
		 * 
		 * @author khoapkl
		 */
		if (CPSHelper.isEmpty(candidateType)) {
			String resultArray = addNewCandidate.getCandidateTypeList();
			if (null != resultArray && !resultArray.isEmpty()) {
				StringTokenizer candTypeList = new StringTokenizer(resultArray, CPSConstants.COMMA);
				candTypeList.nextToken();
				if (candTypeList.hasMoreTokens()) {
					List<String> pendingCandidateTypes = new ArrayList<String>();
					while (candTypeList.hasMoreTokens()) {
						pendingCandidateTypes.add(candTypeList.nextToken());
					}
					addNewCandidate.setPendingCandidateTypes(pendingCandidateTypes);
				}
			}
		}
		/*
		 * Enable Production MRTs and collect data has relation
		 * 
		 * @author khoapkl
		 */
		if (selectedMrtLabel.equals(CPSConstants.MRT)) {
			String stringVal = null;
			stringVal = addNewCandidate.getSelectedProductId();
			List<String> prodIds = addNewCandidate.getPendingProdIds();
			if (CPSHelper.isEmpty(prodIds)) {
				String resultArray = req.getParameter("SelectedViewArray");
				if (null != resultArray) {
					StringTokenizer idList = new StringTokenizer(resultArray, ",");
					stringVal = idList.nextToken();
					if (idList.hasMoreTokens()) {
						List<String> addlIds = new ArrayList<String>();
						while (idList.hasMoreTokens()) {
							addlIds.add(idList.nextToken());
						}
						addNewCandidate.setPendingProdIds(addlIds);
					}
				}
			}
			clearMessages(addNewCandidate);
			req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_PRODUCT);
			addNewCandidate.setCurrentAppName(CPSConstants.VIEW_PRODUCT);
			addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
			addNewCandidate.getQuestionnarieVO().setSelectedOption("4");
			addNewCandidate.setSelectedOption("4");
			addNewCandidate.getProductVO().setModifyFlag(false);			
			addNewCandidate.setViewOnlyProductMRT(true);
			addNewCandidate.setButtonViewOverRide();// hide Modify button
			addNewCandidate.setViewOverRide();
			setViewMode(addNewCandidate);
			addNewCandidate.setPrintable(false);
			addNewCandidate.setEnableClose(false);
			addNewCandidate.setHidMrtSwitch(true);
			addNewCandidate.setMrtViewMode(viewMode);
			viewProductMRTCase(addNewCandidate, req, stringVal, CPSConstants.EMPTY_STRING);

			ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
			model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
			return model;
		} else {
			addNewCandidate.setSelectedOption(null);
			addNewCandidate.setHidMrtSwitch(false);
			addNewCandidate.clearButtonViewOverRide();
			addNewCandidate.setViewOnlyProductMRT(false);
			addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
		}
		addNewCandidate.setManageCandidateMode();

		req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_PRODUCT);
		addNewCandidate.setCurrentAppName(CPSConstants.VIEW_PRODUCT);

		addNewCandidate.setViewOverRide();
		setViewMode(addNewCandidate);
		addNewCandidate.setViewProduct();
		this.getDetails(addNewCandidate, req);
		addNewCandidate.setEnableClose(false);
		addNewCandidate.setDummyProperty(BusinessConstants.EMPTY_STRING);
		return getViewProductDetails(addNewCandidate, req, CPSConstants.EMPTY_STRING);
	}

	/**
	 * Modify product.
	 * 
	 * @param addNewCandidate
	 *            the addNewCandidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return ModelAndView
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_MODIFY_PRODUCT)
	public ModelAndView modifyProduct(
			@Valid @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
		addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
		setForm(req, addNewCandidate);
		setInputForwardValue(req, CPSConstants.ADD_NEW_OTHER_INFO);
		req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_PRODUCT);

		if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.REDIRECT_FORM))) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS_PRODUCT);
		} else if (req.getSession().getAttribute(CPSConstants.REDIRECT_FORM).equals(CPSConstants.EDI)) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.EDI);
		} else if (req.getSession().getAttribute(CPSConstants.REDIRECT_FORM).equals(CPSConstants.CPS_PRODUCT)) {
			req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS_PRODUCT);
		}

		if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_VALUE))) {
			req.getSession().setAttribute(CPSConstants.MODIFY_VALUE, CPSConstant.STRING_1);
		}

		// hide Activate button
		addNewCandidate.setEnableActiveButton(false);
		// be sure user can add UPC when switch to another tabs in Edit Mode-
		// Fix 1505 modifyBut
		addNewCandidate.setUpcAdded(true);
		setViewMode(addNewCandidate);
		addNewCandidate.setEnableClose(true);
		// hung add list combo box qualify condition
		// setQualifyCondition(addNewCandidate);
		// trung nv fix 1718
		addNewCandidate.setModifyProdCand(true);
		setViewOverrideFlags(addNewCandidate);
		addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
		addNewCandidate.setCurrentAppName(CPSConstants.MODIFY_PRODUCT);
		addNewCandidate.clearViewOverRide();
		addNewCandidate.setViewAddInforPage(false);
		// identify system will not validate for MRT product when navigate to
		// Additional Information Tab.
		addNewCandidate.setNormalProduct(true);
		// trungnv fix #28632
		if (addNewCandidate.isMrtActiveProduct()) {
			if ("4".equalsIgnoreCase(addNewCandidate.getQuestionnarieVO().getSelectedOption())) {
				addNewCandidate.clearQuestionaireVO();
			}
		}

		addNewCandidate.setMrtActiveProduct(false);
		// -------fix user click button modify in mrt then set
		// addNewCandidate.setHidMrtSwitch(false);
		addNewCandidate.setHidMrtSwitch(false);
		// ------------
		String stringVal = null;
		stringVal = addNewCandidate.getSelectedProductId();
		List<String> prodIds = addNewCandidate.getPendingProdIds();
		if (CPSHelper.isEmpty(prodIds)) {
			String resultArray = addNewCandidate.getSelectedProductId();
			if (null != resultArray) {
				StringTokenizer idList = new StringTokenizer(resultArray, "-");
				if (idList.hasMoreTokens())
					stringVal = idList.nextToken();
				if (idList.hasMoreTokens()) {
					List<String> addlIds = new ArrayList<String>();
					while (idList.hasMoreTokens()) {
						addlIds.add(idList.nextToken());
					}
					addNewCandidate.setPendingProdIds(addlIds);
				}
			}
		}

		JSONArray jsonData = new JSONArray();
		if (null != stringVal) {
			addNewCandidate.setSelectedProductId(stringVal);
			ProductVO productVO = getAddNewCandidateService().getProduct(null, stringVal, null);
			this.correctUOM(productVO);
			// correct the list cost for Vendors
			if (BusinessUtil.isVendor(getUserRole())) {
				correctListCostForVendor(productVO, addNewCandidate);
				// PIM 831
				// getCorrectInforVendorLogin(productVO, req);
				// end PIM 831
			}

			addNewCandidate.setProductVO(productVO);
			// set Selling Restrictions from WS
			jsonData = getSellingJsonFromWS(stringVal, getCommonService().getSellingRestriction(
					productVO.getClassCommodityVO().getDeptId(), productVO.getClassCommodityVO().getSubDeptId(),
					productVO.getClassCommodityVO().getClassCode(), productVO.getClassificationVO().getCommodity(),
					productVO.getClassificationVO().getSubCommodity()));
			// saving the product VO
			productVO.setNewDataSw(CPSConstant.CHAR_N);

			clearMessages(addNewCandidate);

			productVO = addNewCandidate.getProductVO();
			productVO.setModifyFlag(true);
			addNewCandidate.setBdms(getBdmList());
			initProductVO(addNewCandidate, req);
			initProductServiceVO(addNewCandidate, req);
			if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getShelfEdgeVO().getPackaging())) {
				addNewCandidate.setPackagingViewOverRide();
			}
			addNewCandidate.setButtonViewOverRide();
			CPSMessage message = new CPSMessage("Product Copied for Modifiy", ErrorSeverity.INFO);
			saveMessage(addNewCandidate, message);
			addNewCandidate.setProduct(true);
			addNewCandidate.setProductCaseOverridden(true);
			String selectedVal = addNewCandidate.getQuestionnarieVO().getSelectedOption();
			if (CPSConstant.STRING_2.equalsIgnoreCase(CPSHelper.getTrimmedValue(selectedVal))) {
				addNewCandidate.setTabIndex(AddNewCandidate.TAB_NEW_AUTH);
				addNewCandidate.setChannels(getChannels());
				addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
				addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
				addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
				addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());

				// Order Unit changes
				addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());
				List<VendorLocationVO> subVendorList = new ArrayList<VendorLocationVO>();
				addNewCandidate.getVendorVO().setVendorLocationList(subVendorList);
				req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
			} else {
				addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
				this.getDetails(addNewCandidate, req);
				if (!jsonData.isEmpty()) {
					addNewCandidate.getProductVO().setOriginSellingRestriction(jsonData.toString());
				}
				productVO = addNewCandidate.getProductVO();
				// -----New feature for Tax category---
				if (!BusinessUtil.isVendor(getUserRole())) {
					try {
						addNewCandidate.getProductVO().getPointOfSaleVO()
								.setListTaxCategory(this.getCommonService().getTaxCategoryForAD(null));
					} catch (Exception e) {
						LOG.error(e.getMessage(), e);
					}
				}
				// -----New feature for Tax category---
				if (CPSHelper.isEmpty(productVO.getRetailVO().getCriticalItemName())) {
					productVO.getRetailVO().setCriticalItemName(getNameForCode(addNewCandidate.getCriItemList(),
							productVO.getRetailVO().getCriticalItem()));
				}
				if (CPSHelper.isEmpty(productVO.getRetailVO().getTobaccoTaxName())) {
					productVO.getRetailVO().setTobaccoTaxName(
							getNameForCode(addNewCandidate.getYesNoList(), productVO.getRetailVO().getTobaccoTax()));
				}

			}
			addNewCandidate.getProductVO().setModifyFlag(true);
			addNewCandidate.setViewOverRide();

		}
		addNewCandidate.getProductVO().setModifyFlag(true);
		addNewCandidate.setViewOverRide();
		// be sure data saved when user clicking on Next button or switch to
		// other tabs
		addNewCandidate.clearViewProduct();
		// set modify mode 16/5/16
		setModifyMode(addNewCandidate);
		// end modify mode 16/5/16
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
		model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
		return model;
	}

	/**
	 * Copy product.
	 * 
	 * @param addNewCandidate
	 *            the addNewCandidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return ModelAndView
	 * @throws Exception
	 *             the exception.
	 */
	@RequestMapping(method = { RequestMethod.POST, RequestMethod.GET }, value = RELATIVE_PATH_COPY_PRODUCT)
	public ModelAndView copyProduct(
			@Valid @ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
		addNewCandidate.setSession(req.getSession());
		setForm(req, addNewCandidate);
		addNewCandidate.setEnableActiveButton(false);
		clearViewMode(addNewCandidate);
		setInputForwardValue(req, CPSConstants.ADD_NEW_OTHER_INFO);
		addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
		addNewCandidate.setManageCandidateMode();
		req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.COPPY_PRODUCT);
		addNewCandidate.setCurrentAppName(CPSConstants.COPPY_PRODUCT);
		this.getDetails(addNewCandidate, req);
		StringTokenizer idList = new StringTokenizer(addNewCandidate.getSelectedProductId(), "-");
		String stringVal = idList.nextToken();
		ProductVO productVO = getAddNewCandidateService().getProduct(null, stringVal, null);
		// trungnv fix pim 482
		productVO.getPointOfSaleVO().setPse(CPSConstants.EMPTY_STRING);

		productVO = getAddNewCandidateService().populateCostGroupsForCopiedProduct(productVO);

		this.correctUOM(productVO);

		// correct the list cost for Vendors
		if (BusinessUtil.isVendor(getUserRole())) {
			correctListCostForVendor(productVO, addNewCandidate);
			// PIM 831
			// getCorrectInforVendorLogin(productVO, req);
			// end PIM 831
		}
		JSONArray jsonData = getSellingJsonFromWS(stringVal,
				getCommonService().getSellingRestriction(productVO.getClassCommodityVO().getDeptId(),
						productVO.getClassCommodityVO().getSubDeptId(), productVO.getClassCommodityVO().getClassCode(),
						productVO.getClassificationVO().getCommodity(),
						productVO.getClassificationVO().getSubCommodity()));
		if (!jsonData.isEmpty()) {
			productVO.setOriginSellingRestriction(jsonData.toString());
		}

		productVO.getClassificationVO().setProdDescritpion(CPSConstants.EMPTY_STRING);
		productVO.getShelfEdgeVO().setCustFrndlyDescription1(CPSConstants.EMPTY_STRING);
		productVO.getShelfEdgeVO().setCustFrndlyDescription2(CPSConstants.EMPTY_STRING);
		productVO.getShelfEdgeVO().setScanDesc(CPSConstants.EMPTY_STRING);
		productVO.setCopiedProdid(productVO.getProdId());
		// //
		productVO.setProdId(null);
		productVO.setPsProdId(null);
		// //
		productVO.setNewDataSw('Y');
		List<CaseVO> caseList = productVO.getCaseVOs();
		for (CaseVO caseVO : caseList) {
			caseVO.setNewDataSw('Y');
			caseVO.setItemId(null);
			caseVO.setPsItemId(null);
			// //
			List<VendorVO> vendorList = caseVO.getVendorVOs();
			for (VendorVO vendorVO : vendorList) {
				vendorVO.setVpc(CPSConstants.EMPTY_STRING);
				vendorVO.setNewDataSw('Y');
				vendorVO.setPsItemId(0);
			}
			caseVO.clearCaseUPCVOs();// No old UPC - so no old CaseUPC too.
		}

		productVO.setUpcVO(new ArrayList<UPCVO>());

		// UAT Defect. Prim_scn_cd of old prduct not required
		productVO.setPrimaryUPC(null);

		// QC defect# 1027 - No Scale data to be copied while Copy Product
		productVO.setScaleVO(new ScaleVO());

		// Fix 1223
		productVO.setCopiedProductSaved(false);
		productVO.getPointOfSaleVO().setFdaMenuLabelingStatus(BusinessConstants.PENDING_NUTRITION);
		addNewCandidate.setProductVO(productVO);
		addNewCandidate.setBdms(getBdmList());
		initProductVO(addNewCandidate, req);
		initBrandField(addNewCandidate);
		CPSMessage message = new CPSMessage("Product Copied", ErrorSeverity.INFO);
		saveMessage(addNewCandidate, message);
		addNewCandidate.setProduct(true);
		addNewCandidate.setProductCaseOverridden(true);
		// be sure user can be add UPC in Edit Mode
		addNewCandidate.setUpcAdded(true);
		// Sprint - 23
		addNewCandidate.setModifyMode(true);
		Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		if (currentMode != null)
			req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
		req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
		req.getSession().setAttribute(CPSConstants.REDIRECT_FORM, CPSConstants.CPS_PRODUCT);
		addNewCandidate.getProductVO().getPointOfSaleVO().setRateType(CPSConstants.EMPTY_STRING);
		addNewCandidate.getProductVO().getPointOfSaleVO().setRating(CPSConstants.EMPTY_STRING);
		addNewCandidate.getProductVO().getPointOfSaleVO().setPurchaseTimeName(CPSConstants.EMPTY_STRING);
		addNewCandidate.getProductVO().getPointOfSaleVO().setRestrictedSalesAgeLimitName(CPSConstants.EMPTY_STRING);
		model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
		return model;
	}

	/**
	 * handles the 'prodAndUpc' tab of the tab view.
	 *
	 * @param addNewCandidate
	 *            the addNewCandidate model.
	 * @param req
	 *            the http servlet request.
	 * @param resp
	 *            the http servlet response.
	 * @return the ModelAndView
	 * @throws Exception
	 *             the exception
	 */
	private ModelAndView modifyCandInternal(AddNewCandidate addNewCandidate, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
		setForm(req, addNewCandidate);
		req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
		// visible Activate button
		addNewCandidate.setEnableActiveButton(true);
		boolean viewMode = isViewMode(addNewCandidate);
		String candTypeList = addNewCandidate.getCandidateTypeList();
		// Check user choose only one candidate to view or modify
		if (addNewCandidate.getPendingCandidateTypes() != null
				&& addNewCandidate.getPendingCandidateTypes().isEmpty()) {
			// addNewCandidate.setCandidateType(EMPTY_STRING);
			if (CPSHelper.isEmpty(addNewCandidate.getCandidateType())) {
				if (CPSHelper.isNotEmpty(candTypeList)
						&& candTypeList.split(CPSConstants.COMMA)[0].equals(CPSConstants.NONE_MRT)) {
					addNewCandidate.setCandidateType(CPSConstants.NONE_MRT);
				} else {
					addNewCandidate.setCandidateType(CPSConstants.MRT);
				}
			}
		}
		/** Checking For MRT - Starts */
		if (addNewCandidate.isMrtActiveProduct() || addNewCandidate.getCandidateType().equals(CPSConstants.MRT)) {
			/*
			 * hide addNewCandidate.setMrtActiveProduct(true); khoapkl
			 */
			// addNewCandidate.setMrtActiveProduct(true);
			addNewCandidate.setPrintable(false);
			if (viewMode) {
				req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.VIEW_MRT);
			} else {
				req.setAttribute(CPSConstants.CURRENT_APP_NAME, CPSConstants.MODIFY_MRT);
			}
			handleModifyForMRT(addNewCandidate, viewMode, req);
			addNewCandidate.setHidMrtSwitch(true);
			addNewCandidate.setMrtViewMode(viewMode);
		} else {
			addNewCandidate.setMrtActiveProduct(false);
			/*
			 * identify mrt tab hidden
			 * 
			 * @author khoapkl
			 */
			addNewCandidate.setViewAddInforPage(false);
			// req.setAttribute(CURRENT_APP_NAME, MODIFY_CANDIDATE);
            try {
                addNewCandidate.setLabelFormats(getLabelFormatList()); // R2
            }catch (Exception ex){}
			handleModify(addNewCandidate, viewMode, req);
			addNewCandidate.setHidMrtSwitch(false);
		}
		addNewCandidate.setDummyProperty(BusinessConstants.EMPTY_STRING);
		model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
		return model;
	}

	/**
	 * Handle modify for mrt.
	 *
	 * @param addNewCandidate
	 *            the addNewCandidate model
	 * @param viewMode
	 *            the view mode
	 * @param req
	 *            the http servlet request
	 * @throws Exception
	 *             the exception
	 */
	private void handleModifyForMRT(AddNewCandidate addNewCandidate, boolean viewMode, HttpServletRequest req)
			throws Exception {
		addNewCandidate.setTabIndex(AddNewCandidate.TAB_MRT);
		addNewCandidate.setManageCandidateMode();
		this.setIntentIdentifier(addNewCandidate);
		/*
		 * Enable Additional Information tab
		 * 
		 * @author khoapkl
		 */
		addNewCandidate.setViewAddInforPage(true);
		addNewCandidate.setNormalProduct(false);
		String stringVal = null;
		stringVal = addNewCandidate.getSelectedProductId();// newly added
		List<String> prodIds = addNewCandidate.getPendingProdIds();
		List<String> candidateType = addNewCandidate.getPendingCandidateTypes();
		int unitTotalAttribute = 0;
		if (CPSHelper.isEmpty(prodIds)) {
			String resultArray = addNewCandidate.getSelectedProductId();// req.getParameter("SelectedAttributeList");
			if (null != resultArray) {
				StringTokenizer idList = new StringTokenizer(resultArray, CPSConstants.COMMA);
				stringVal = idList.nextToken();
				if (idList.hasMoreTokens()) {
					List<String> addlIds = new ArrayList<String>();
					while (idList.hasMoreTokens()) {
						addlIds.add(idList.nextToken());
					}
					addNewCandidate.setPendingProdIds(addlIds);
				}
			}
		}
		/*
		 * Loop candidate types and set into a variable. Purpose: user can view
		 * next candidate.
		 * 
		 * @author khoapkl
		 */
		@SuppressWarnings("unused")
		String candTpeVal = addNewCandidate.getCandidateTypeList();
		if (CPSHelper.isEmpty(candidateType)) {
			String resultArray = addNewCandidate.getCandidateTypeList();
			if (null != resultArray) {
				StringTokenizer candTypeList = new StringTokenizer(resultArray, CPSConstants.COMMA);
				candTpeVal = candTypeList.nextToken();
				if (candTypeList.hasMoreTokens()) {
					List<String> pendingCandidateTypes = new ArrayList<String>();
					while (candTypeList.hasMoreTokens()) {
						pendingCandidateTypes.add(candTypeList.nextToken());
					}
					addNewCandidate.setPendingCandidateTypes(pendingCandidateTypes);
					// Used for get next candidate type
					// addNewCandidate.setCandidateTypeList(pendingCandidateTypes.toString());
				}
			}
		}
		if (null != stringVal) {
			stringVal = stringVal.split(CPSConstants.COMMA)[0];
			// /get work status code from PS_ITEM_MASTER over ps_itm_id
			String statusCode = CPSConstant.STRING_EMPTY;
			if (addNewCandidate.getMrtvo() != null && addNewCandidate.getMrtvo().getCaseVO() != null
					&& addNewCandidate.getMrtvo().getCaseVO().getPsItemId() != null
					&& addNewCandidate.getMrtvo().getCaseVO().getPsItemId() > 0) {
				stringVal = addNewCandidate.getMrtvo().getCaseVO().getPsItemId().toString();
			}
			statusCode = getAddNewCandidateService().getPdSetupStatCd(CPSHelper.getIntegerValue(stringVal));
			addNewCandidate.setSelectedProductId(stringVal);
			MrtVO mrtVO = getAddNewCandidateService().fetchMRTProduct(stringVal);
			addNewCandidate.setMrtvo(mrtVO);
			addNewCandidate.getQuestionnarieVO().setSelectedOption("4");
			CaseVO caseVO = mrtVO.getCaseVO();
			caseVO.setCaseChkDigit(CPSHelper.calculateCheckDigit(caseVO.getCaseUPC()) + CPSConstants.EMPTY_STRING);
			caseVO.calculateMasterCube();
			caseVO.calculateShipCube();
			// FIX PIM 831
			// getCorrectInforVendorLoginMRT(caseVO, req);
			// END FIX
			addNewCandidate.getMrtvo().setCaseVO(caseVO);
			List<MRTUPCVO> mrtUpcList = addNewCandidate.getMrtvo().getMrtVOs();
			// thangdang fix printForm
			addNewCandidate.getMrtvo().setMrtVOPrints(mrtUpcList);
			List<VendorLocationVO> subVendorList = new ArrayList<VendorLocationVO>();
			String unitUPC = CPSConstants.EMPTY_STRING;
			ProductVO productVO = new ProductVO();
			MRTUPCVO mrtUpcVO = null;
			if (!mrtUpcList.isEmpty()) {
				for (MRTUPCVO mrtVOTemp : mrtUpcList) {
					productVO = new ProductVO();
					mrtUpcVO = new MRTUPCVO();
					unitUPC = mrtVOTemp.getUnitUPC();
					try {
						productVO = getAddNewCandidateService().getProductBasicForAddUpcMrt(unitUPC);
						this.correctUOM(productVO);
					} catch (CPSGeneralException e) {
						LOG.error(e.getMessage(), e);
					}
					if (null == productVO.getProdId()) {
						mrtUpcVO = getAddNewCandidateService().getMRTDetails(unitUPC);
						WorkRequest wr = mrtUpcVO.getProductVO().getWorkRequest();
						wr.setWorkStatusCode(statusCode);
						productVO.setWorkRequest(wr);
						if (mrtUpcVO.isSelected()) {
							productVO = mrtUpcVO.getProductVO();
							// PIM 831
							// if(BusinessUtil.isVendor(getUserRole())){
							// getCorrectInforVendorLogin(productVO, req);
							// }
							// end PIM 831
							addNewCandidate.setProductVO(productVO);
						}
					} else {
						mrtUpcVO.setApproval("No");
						mrtUpcVO.setDescription(productVO.getClassificationVO().getProdDescritpion());
						setItemCode(mrtUpcVO, productVO);
						mrtUpcVO.setProductVO(productVO);
						if (mrtUpcVO.isSelected()) {
							productVO = mrtUpcVO.getProductVO();
							// PIM 831
							// if(BusinessUtil.isVendor(getUserRole())){
							// getCorrectInforVendorLogin(productVO, req);
							// }
							// end PIM 831
							addNewCandidate.setProductVO(productVO);
						}
						WorkRequest wr = new WorkRequest();
						wr.setWorkStatusCode(statusCode);
						productVO.setWorkRequest(wr);
					}
					addNewCandidate.setProductVO(productVO);
					mrtUpcVO.setSellableUnits(mrtVOTemp.getSellableUnits());
					mrtUpcVO.setUnitUPC(unitUPC);
					mrtUpcVO.setUnitUPCCheckDigit(String.valueOf(CPSHelper.calculateCheckDigit(unitUPC)));
					mrtUpcVO.setMrtUPCSaved(mrtVOTemp.isMrtUPCSaved());
					addNewCandidate.getMrtvo().addMRTVO(mrtUpcVO);
					addNewCandidate.getMrtvo().removeMRTVO(mrtVOTemp.getUniqueId());
					// not sum for FakeUPC
					if (!CPSHelper.isFakeUPC(mrtUpcVO.getUnitUPC())) {
						unitTotalAttribute += Integer.parseInt(mrtVOTemp.getSellableUnits());
					}
					unitUPC = CPSConstants.EMPTY_STRING;
				}
			} else {
				WorkRequest wr = new WorkRequest();
				wr.setWorkStatusCode(statusCode);
				productVO.setWorkRequest(wr);
				// PIM 831
				// if(BusinessUtil.isVendor(getUserRole())){
				// getCorrectInforVendorLogin(productVO, req);
				// }
				// end PIM 831
				addNewCandidate.setProductVO(productVO);
			}
			addNewCandidate.getMrtvo().getMrtUpcVO().setUnitTotalAttribute(unitTotalAttribute);
			addNewCandidate.setChannels(getChannels());
			if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO())) {
				if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getChannelVal())) {
					subVendorList = setVendorListForMRT(addNewCandidate.getMrtvo().getMrtVOs(), addNewCandidate,
							addNewCandidate.getMrtvo().getCaseVO(), req);
				}
				// fix reset cost owner list when update brand
				addNewCandidate.setCostOwners(new ArrayList<BaseJSFVO>());
				// Fix 1289.
				addNewCandidate.setCostOwners(setCostOwnerValuesForMRT(addNewCandidate));
				addNewCandidate.getVendorVO().setCountryOfOriginList(getCountryOfOrigin());
				addNewCandidate.getVendorVO().setTop2TopList(getTop2Top());
				addNewCandidate.getVendorVO().setSeasonalityList(getSeasonality());
				addNewCandidate.getVendorVO().setOrderRestrictionList(getOrderRestriction());

				// Order Unit changes
				addNewCandidate.getVendorVO().setOrderUnitList(getOrderUnitList());

				addNewCandidate.getMrtvo().getCaseVO().setTouchTypeList(getTouchTypeCodes());
				addNewCandidate.getMrtvo().getCaseVO().setItemCategoryList(getItemCategoryList());
				// DRU
				addNewCandidate.getMrtvo().getCaseVO().setReadyUnits(getReadyUnitList());
				addNewCandidate.getMrtvo().getCaseVO().setOrientations(getOrientationList());
				// END DRU
				addNewCandidate.getMrtvo().getCaseVO().setPurchaseStatusList(getPurchaseStatusList());
			}
			addNewCandidate.getVendorVO().setVendorLocationList(subVendorList);
		} else {
			CPSMessage message = new CPSMessage("Please Select a candidate", ErrorSeverity.INFO);
			saveMessage(addNewCandidate, message);
		}
	}

    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_BACK_TO_SEARCH)
    public RedirectView backToSearch(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        this.setForm(req, addNewCandidate);
        // remove session
        if (req.getSession().getAttribute(AddNewCandidate.FORM_NAME) != null) {
            req.getSession().removeAttribute(AddNewCandidate.FORM_NAME);
        }
        if (req.getSession().getAttribute(AddNewCandidate.CURRENT_FORM_KEY) != null) {
            req.getSession().removeAttribute(CPSConstants.CURRENT_FORM_KEY);
        }
        // render to search form
        String renderForm = (String) req.getSession().getAttribute(CPSConstants.REDIRECT_FORM);

        RedirectView redirectView = new RedirectView();
        redirectView.setContextRelative(true);

        if (renderForm.equals(CPSConstants.EDI)) {
            redirectView.setUrl(RELATIVE_PATH_BACK_TO_EDI_SEARCH_PAGE);
        }else if (renderForm.equals(CPSConstants.CPS)) {
            redirectView.setUrl(RELATIVE_PATH_BACK_TO_CANDIDATE_SEARCH_PAGE);
        }else {
            redirectView.setUrl(RELATIVE_PATH_BACK_TO_PRODUCT_SEARCH_PAGE);
        }
        return redirectView;
    }
    /**
     * Update candidate message.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_UPDATE_CANDIDATE_MESSAGE)
    public ModelAndView updateCandidateMessage(AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate= getLastForm(req.getSession(), addNewCandidate);
        String errorMessage = addNewCandidate.getRejectComments();
        if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(errorMessage)) {
            if (addNewCandidate.getQuestionnarieVO().getSelectedOption() != null
                    && ("4").equals(addNewCandidate.getQuestionnarieVO().getSelectedOption())) {
                // DRU
                addNewCandidate.getMrtvo().getCaseVO().setReadyUnits(getReadyUnitList());
                addNewCandidate.getMrtvo().getCaseVO().setOrientations(getOrientationList());
                // END DRU
            }
            CPSMessage message = new CPSMessage(errorMessage, ErrorSeverity.VALIDATION);
            saveMessage(addNewCandidate, message);
        }
        ModelAndView model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_TEST_SCAN)
    public ModelAndView testScanNew(AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
        addNewCandidate.setUserRole(this.getUserRole());
        setForm(req, addNewCandidate);
        boolean hasScannableUPC = false;

        setInputForwardValue(req, "TestScanNew");
        String productType = CPSHelper
                .getTrimmedValue(addNewCandidate.getProductVO().getClassificationVO().getProductType());
        if (CPSConstant.SPLY.equalsIgnoreCase(productType) || StringUtils.EMPTY.equalsIgnoreCase(productType)) {
            if (CPSConstant.SPLY.equalsIgnoreCase(productType)) {
                addNewCandidate.setRejectComments("Test Scan is not possible for Non-Sellable Product");
            } else {
                addNewCandidate.setRejectComments("Test scan is not possible without saving a product");
            }
            addNewCandidate.setRejectClose(true);
        } else {
            boolean nonSavedUPC = false;
            List<UPCVO> upcvos = addNewCandidate.getProductVO().getUpcVO();
            for (UPCVO upcvo : upcvos) {
                if (0 == upcvo.getSeqNo() && CPSConstant.CHAR_Y == upcvo.getNewDataSw()) {
                    nonSavedUPC = true;
                    break;
                }
            }
            if (nonSavedUPC) {
                saveDetails(addNewCandidate, req, resp); // ActionForward
                // actionForward =
                nonSavedUPC = false;
            }
            List<UPCVO> upcVOList = null;
            upcvos = addNewCandidate.getProductVO().getUpcVO();
            if (null != upcvos && !upcvos.isEmpty()) {
                if (nonSavedUPC) {
                    addNewCandidate.setRejectComments("Please save the candidate to do Test Scan");
                    addNewCandidate.setRejectClose(true);
                } else {
                    // be sure ps_prod_id in UPCVO always existing
                    for (UPCVO upcvo : upcvos) {
                        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPsProdId())) {
                            upcvo.setPsProdId(addNewCandidate.getProductVO().getPsProdId());
                        }
                    }
                    upcVOList = getAddNewCandidateService().fetchTestScanUpc(upcvos);
                    addNewCandidate.clearUPCVOs();
                    if (!upcVOList.isEmpty()) {
                        hasScannableUPC = true;
                    }
                    for (UPCVO upcvo : upcVOList) {
                        if (CPSConstant.UPC.equalsIgnoreCase(upcvo.getUpcType())
                                || CPSConstant.HEB.equalsIgnoreCase(upcvo.getUpcType())) {
							/*
							 * Added
							 * '"HEB".equalsIgnoreCase(upcvo.getUpcType())'
							 * condition to make sure that HEB type upc are also
							 * made scannable .
							 */
                            if ('Y' == upcvo.getNewDataSw()) {
                                if (CPSHelper.isEmpty(upcvo.getTestScanUPC())) {
                                    upcvo.setUnitUpc(CPSHelper.getPadding(upcvo.getUnitUpc())
                                            + CPSHelper.calculateCheckDigit(upcvo.getUnitUpc()));
                                    addNewCandidate.addUpcVOs(upcvo);
                                }
                            }
                        }
                    }
                    addNewCandidate.setRejectClose(false);
                }
            } else {
                addNewCandidate.setRejectComments("NO UPC Values");
                addNewCandidate.setRejectClose(true);
            }
        }
        String userRole = getUserRole();
        if (BusinessConstants.ADMIN_ROLE.equalsIgnoreCase(userRole)
                || BusinessConstants.PIA_LEAD_ROLE.equalsIgnoreCase(userRole)) {
            addNewCandidate.setTestScanUserSwitch(true);
        } else {
            addNewCandidate.setTestScanUserSwitch(false);
        }
        if (addNewCandidate.getUpcVOs().isEmpty()) {
            if (hasScannableUPC == false) {
                CPSMessage message = new CPSMessage("All UPC's of the selected Candidate have been Testscaned",
                        ErrorSeverity.INFO);
                saveMessage(addNewCandidate, message);
            } else {
                CPSMessage message = new CPSMessage("The Selected Candidate doesn't have UPC's for Testscan",
                        ErrorSeverity.ERROR);
                saveMessage(addNewCandidate, message);
            }
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_TEST_SCAN_POPUP_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_REJECT_CAND_COMMENTS)
    public ModelAndView rejectCandComments(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setSession(req.getSession());
        addNewCandidate.setCurrentRequest(req);
        addNewCandidate.setUserRole(this.getUserRole());
        addNewCandidate.getMessages().clear();
        addNewCandidate.setRejectComments(StringUtils.EMPTY);
        ProductVO productVO = addNewCandidate.getProductVO();
        int productId = 0;
        if (CPSHelper.isNotEmpty(productVO.getPsProdId())) {
            productId = productVO.getPsProdId();
        }
        String userRole = getUserRole();
        if (productId == 0) {
            addNewCandidate.setRejectClose(true);
        } else if (BusinessUtil.isVendor(userRole)
                && (CPSConstants.WORKING_CODE.equalsIgnoreCase(productVO.getWorkRequest().getWorkStatusCode()))) {
            CPSMessage message = new CPSMessage(
                    "Only Candidates in Vendor Candidate Status can be rejected. The Current Status is Working Candidate",
                    ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
            addNewCandidate.setRejectClose(true);
        } else {
            addNewCandidate.setRejectClose(false);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_REJECT_CAND_COMMENT_POPUP_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
        return model;
    }

	private AddNewCandidate getConvertedModel(ManageCandidate manageCandidate) {
		AddNewCandidate addNewCandidate = new AddNewCandidate();
		if (CPSHelper.isNotEmpty(manageCandidate.getSelectedProductId())) {
			addNewCandidate.setSelectedProductId(manageCandidate.getSelectedProductId());
		}
		if (CPSHelper.isNotEmpty(manageCandidate.getCandidateTypeList())) {
			addNewCandidate.setCandidateTypeList(manageCandidate.getCandidateTypeList());
		}
		return addNewCandidate;
	}

    /**
     * Reject questionnaire.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_REJECT_QUESTIONNAIRE)
    public ModelAndView rejectQuestionnaire(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        setForm(req, addNewCandidate);
        ProductVO productVO = addNewCandidate.getProductVO();
        int productId = 0;
        if (CPSHelper.isNotEmpty(productVO.getPsProdId())) {
            productId = productVO.getPsProdId();
        }
        if (productId == 0) {
            CPSMessage message = new CPSMessage("Only saved candidate can be rejected", ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
            return model;
        } else if (BusinessUtil.isVendor(getUserRole())
                && (CPSConstants.WORKING_CODE.equalsIgnoreCase(productVO.getWorkRequest().getWorkStatusCode()))) {
            CPSMessage message = new CPSMessage(
                    "Only Candidates in Vendor Candidate Status can be rejected. The Current Status is Working Candidate",
                    ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE,addNewCandidate);
            return model;
        } else {
            addNewCandidate.clearViewOverRide();
            addNewCandidate.setRejectClose(false);
            addNewCandidate.setSelectedFunction(AddNewCandidate.ADD_NEWCANDIDATE);
            addNewCandidate.setTabIndex(0);
            addNewCandidate.getProductVO().setClassificationVO(new ProductClassificationVO());
            addNewCandidate.setSubCommodities(new ArrayList<BaseJSFVO>());
            addNewCandidate.setCommentsVOs(new HashMap<String, CommentsVO>());
            addNewCandidate.setMerchandizingTypes(new ArrayList<BaseJSFVO>());
            CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_REJECTED, ErrorSeverity.VALIDATION);
            saveMessage(addNewCandidate, message);
            model = new ModelAndView(RELATIVE_PATH_QUESTIONNAIRE_PAGE);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
            return model;
        }

    }
    /**
     * For saving the case details.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_SAVE_CASE_DETAILS)
    public ModelAndView saveCaseDetails(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        setForm(req, addNewCandidate);

        addNewCandidate.setTabIndex(AddNewCandidate.TAB_NEW_AUTH);
        addNewCandidate.setAddCandidateMode();
        if (null != addNewCandidate.getProductVO().getScaleVO()) {
            if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getScaleVO().getForceTare())
                    || (CPSConstant.STRING_0).equals(addNewCandidate.getProductVO().getScaleVO().getForceTare())) {
                addNewCandidate.getProductVO().getScaleVO().setForceTare(CPSConstant.STRING_N);
            } else if ((CPSConstant.STRING_1).equals(addNewCandidate.getProductVO().getScaleVO().getForceTare())) {
                addNewCandidate.getProductVO().getScaleVO().setForceTare(CPSConstant.STRING_Y);
            }
        }
        ProductVO productVO = getAddNewCandidateService().insertCaseDetails(addNewCandidate.getProductVO(),
                addNewCandidate.getQuestionnarieVO());
        productVO.setBactchUploadMode(addNewCandidate.getProductVO().isBactchUploadMode());
        addNewCandidate.setProductVO(productVO);
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
        CPSMessage message = new CPSMessage(CPSConstants.CANDIDATE_SAVED_SUCCESSFULLY, ErrorSeverity.INFO);
        saveMessage(addNewCandidate, message);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * Save attachments.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_SAVE_ATTACHMENTS)
    public ModelAndView saveAttachments(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);

        addNewCandidate.setTabIndex(AddNewCandidate.TAB_POW);
        addNewCandidate.setAddCandidateMode();
        ProductVO productVO = addNewCandidate.getProductVO();
        boolean newAttachment = false;
        List<AttachmentVO> attachmentVOList = productVO.getAttachmentVO();
        for (AttachmentVO attachmentVO : attachmentVOList) {
            if (0 == attachmentVO.getSeqNbr() && !attachmentVO.isExisted()) {
                newAttachment = true;
                break;
            }
        }
        long primaryUPC = 0;
        if (!addNewCandidate.isProduct()) {
            primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
        } else {
            if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                /*
                 * This case upc got when user clicked on 'Save MRT Case' button
                 * Called from DWR (AddNewCandidateDWR->addMRTCaseVO)
                 */
                primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
            } else {
                List<CaseVO> caseUPCVO = addNewCandidate.getProductVO().getCaseVOs();
                if (CPSHelper.isNotEmpty(caseUPCVO)) {
                    for (CaseVO caseVO : caseUPCVO) {
                        Map<String, CaseUPCVO> obj = caseVO.getCaseUpcVOs();
                        if (obj != null) {
                            List<CaseUPCVO> lstCaseUPCVO = new ArrayList<CaseUPCVO>(obj.values());
                            for (CaseUPCVO caseUPCVO2 : lstCaseUPCVO) {
                                if (caseUPCVO2.isPrimary()) {
                                    primaryUPC = CPSHelper.getLongValue(caseUPCVO2.getUnitUpc());
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
        String prodId = CPSConstant.STRING_0;
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPsProdId())) {
            prodId = CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId());
        } else if (CPSHelper.isNotEmpty(addNewCandidate.getSelectedProductId())
                && CPSHelper.isEmpty(addNewCandidate.getProductVO().getProdId())) {
            prodId = addNewCandidate.getSelectedProductId();
        }
        if (CPSHelper.isEmpty(prodId)) {
            prodId = CPSConstant.STRING_0;
        }
        if (newAttachment) {
            int workRequestId = getAddNewCandidateService().getWorkRequestId(prodId, primaryUPC);
            WorkRequest workRequest = new WorkRequest();
            workRequest.setWorkIdentifier(workRequestId);
            productVO.setWorkRequest(workRequest);
            List<AttachmentVO> list = getAddNewCandidateService().insertAttachment(productVO, primaryUPC);
            productVO.setAttachmentVO(list);
            addNewCandidate.setSavedProductVO(productVO);
            CPSMessage message = new CPSMessage("Attachments Saved Successfully", ErrorSeverity.INFO);
            saveMessage(addNewCandidate, message);
            if (addNewCandidate.isHoldingPendingProdIds()) {
                removeAndGetNextDetails(addNewCandidate, req, resp);
                addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
            }
            req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
        } else {
            CPSMessage message = new CPSMessage("No new Attachments to save", ErrorSeverity.VALIDATION);
            saveMessage(addNewCandidate, message);
        }
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * Removes the and get next details.
     *
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_REMOVE_AND_GET_NEXT_DETAILS)
    public ModelAndView removeAndGetNextDetails(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        if (addNewCandidate.isHoldingPendingProdIds()) {
            List<String> l = addNewCandidate.getPendingProdIds();
            String newProdId = (String) l.remove(0);
            addNewCandidate.setSelectedProductId(newProdId);
        }
        if (addNewCandidate.isHoldingPendingCandidateType()) {
            List l = addNewCandidate.getPendingCandidateTypes();
            String nxt = (String) l.remove(0);
            addNewCandidate.setCandidateType(nxt);
        }
        ModelAndView actionForward = saveDetails(addNewCandidate, req, resp);

        if (addNewCandidate.isProduct()) {
            modifyProduct(addNewCandidate, req, resp);
            // candidateForm.setProduct(false);
        } else {
            // clearViewMode(candidateForm);
            // candidateForm.setPrintable(false);
            // candidateForm.setEnableClose(true);
            // candidateForm.setModifyMode(true);
            // //be sure user can add UPC when switch to another tabs in Edit
            // Mode- Fix 1505
            // candidateForm.setUpcAdded(true);
            if (CPSHelper.isNotEmpty(addNewCandidate.getSelectedProductId()) && getAddNewCandidateService()
                    .checkPluReuseProd(Integer.valueOf(addNewCandidate.getSelectedProductId()))) {
                if (CPSHelper.isEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_PLU_REJECT_VALUE))) {
                    req.getSession().setAttribute(CPSConstants.MODIFY_PLU_REJECT_VALUE, CPSConstant.STRING_1);
                }
                this.viewCand(addNewCandidate, req, resp);
            } else {
                if (CPSHelper.isNotEmpty(req.getSession().getAttribute(CPSConstants.MODIFY_PLU_REJECT_VALUE))) {
                    req.getSession().removeAttribute(CPSConstants.MODIFY_PLU_REJECT_VALUE);
                }
                modifyCand(addNewCandidate, req, resp);
            }
        }

        return actionForward;
    }
    /**
     * View next.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_VIEW_NEXT)
    public ModelAndView viewNext(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        if (addNewCandidate.isEnableClose())
            clearViewMode(addNewCandidate);
        else
            setViewMode(addNewCandidate);
        if (addNewCandidate.isHoldingPendingProdIds()) {
            List l = addNewCandidate.getPendingProdIds();
            String nxt = (String) l.remove(0);
            addNewCandidate.setSelectedProductId(nxt);
        }
        /*
         * Get next candidate type
         *
         * @author khoapkl
         */
        if (addNewCandidate.isHoldingPendingCandidateType()) {
            List l = addNewCandidate.getPendingCandidateTypes();
            String nxt = (String) l.remove(0);
            addNewCandidate.setCandidateType(nxt);
        }
        if (addNewCandidate.isProduct() || addNewCandidate.isViewOnlyProductMRT()) {
            setForm(req, addNewCandidate);
            setInputForwardValue(req, RELATIVE_PATH_NEW_PRODUCT_PAGE);
            addNewCandidate.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
            addNewCandidate.setManageCandidateMode();
            addNewCandidate.setViewProduct();
            req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
            Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            addNewCandidate.getCostOwners().clear();
            return getViewProductDetails(addNewCandidate, req,CPSConstants. EMPTY_STRING);
        } else {
            addNewCandidate.setMrtActiveProduct(false);
            Object currentMode = req.getSession().getAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            if (currentMode != null)
                req.getSession().removeAttribute(CPSConstants.CURRENT_MODE_APP_NAME);
            req.getSession().setAttribute(CPSConstants.CURRENT_MODE_APP_NAME, CPSConstants.CPS);
            // return modifyCand(mapping, candidateForm, req, resp);
            return this.viewCand(addNewCandidate, req, resp);
        }
    }

    /**
     * Submit.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_SUBMIT)
    public ModelAndView submit(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        ModelAndView forward;
        String mrtString = addNewCandidate.getQuestionnarieVO().getSelectedOption();
        if ("4".equalsIgnoreCase(mrtString)) {
            forward = submitMRTCandidate(addNewCandidate, req, resp);
        } else {
            forward = submitCandidate(addNewCandidate, req, resp);
        }
        return forward;
    }
    /**
     * Submit mrt candidate.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_SUBMIT_MRT_CANDIDATE)
    public ModelAndView submitMRTCandidate(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        String returnPage = RELATIVE_PATH_NEW_PRODUCT_PAGE;
        boolean success = false;
        setInputForwardValue(req, returnPage);
        clearMessages(addNewCandidate);
        String productId = CPSHelper.getTrimmedValue(addNewCandidate.getMrtvo().getCaseVO().getPsItemId());
        String userRole = getUserRole();
        CPSMessage message = null;
        if (!CPSHelper.isEmpty(productId) && !"null".equalsIgnoreCase(productId)) {
            String mrtName = CPSConstants.EMPTY_STRING;
            String caseUPC = CPSConstants.EMPTY_STRING;
            MrtVO searchMrtVO = getAddNewCandidateService().fetchMRTProduct(productId);
            mrtName = searchMrtVO.getCaseVO().getCaseDescription();
            caseUPC = searchMrtVO.getCaseVO().getCaseUPC();
            String submitCheck = getAddNewCandidateService().submitMRTValidator(searchMrtVO, userRole);
            submitCheck = submitCheck.replace(CPSConstants.NEXT_LINE, CPSConstants.EMPTY_STRING).trim();
            if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(submitCheck)) {
                getAddNewCandidateService().submitMRTProduct(searchMrtVO, userRole);
                message = new CPSMessage(CPSConstants.CANDIDATE_SUBMITTED, ErrorSeverity.INFO);
                success = true;
            } else {
                String messageStr = "The following fields are mandatory for submitting  candidate  ";
                messageStr = messageStr + "  " + "CASE UPC [" + caseUPC + "] with Case Desription " + mrtName + " ,"
                        + "<BR>" + submitCheck + "<BR>";
                message = new CPSMessage(messageStr, ErrorSeverity.ERROR);
            }
        } else {
            message = new CPSMessage("Please setup the MRT Candidate before Submitting", ErrorSeverity.ERROR);
        }
        saveMessage(addNewCandidate, message);
        CaseVO caseVO = new CaseVO();
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        if (success) {
            returnPage = RELATIVE_PATH_QUESTIONNAIRE_PAGE;

        } else {
            returnPage = RELATIVE_PATH_NEW_PRODUCT_PAGE;

        }
        success = false;
        ModelAndView  model = new ModelAndView(returnPage);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * handles submit flow of all pages.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_SUBMIT_CANDIDATE)
    public ModelAndView submitCandidate(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        boolean success = false;
        String returnPage = RELATIVE_PATH_NEW_PRODUCT_PAGE;
        String userRole = getUserRole();
        setInputForwardValue(req, returnPage);
        CPSMessage message;
        validateSave(addNewCandidate);
        ProductVO savedProductVo = new ProductVO();
        ProductVO toBeSavedVO = new ProductVO();
        try {
            toBeSavedVO = getAddNewCandidateService()
                    .fetchProduct(CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId()), getUserRole());
        } catch (CPSGeneralException e) {
            message = new CPSMessage(e.getMessage(), ErrorSeverity.ERROR);
            clearMessages(addNewCandidate);
            saveMessage(addNewCandidate, message);
            ModelAndView  model = new ModelAndView(returnPage);
            model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
            return model;
        }
        // HungBang get Tax Cate Code when vendor
        if (CPSHelper.isEmpty(addNewCandidate.getProductVO().getPointOfSaleVO().getTaxCateCode())) {
            TaxCategoryVO taxCate = getCommonService()
                    .getTaxCateWrapBySubcom(addNewCandidate.getProductVO().getClassificationVO().getSubCommodity());
            if (CPSHelper.isNotEmpty(taxCate)) {
                if (CPSHelper.isNotEmpty(taxCate.getTxBltyDvrCode())) {
                    toBeSavedVO.getPointOfSaleVO().setTaxCateCode(taxCate.getTxBltyDvrCode().trim());
                }
            }
        }
        ScaleVO scaleVO = toBeSavedVO.getScaleVO();
        // preSave(candidateForm);
        String submitCheck = SubmitValidator.mandatoryCheck(toBeSavedVO);
        toBeSavedVO.setLstVendor(this.getLstVendorId(req));
        // HungBang fix selling restrictions
        if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getOriginSellingRestriction())) {
            toBeSavedVO.setOriginSellingRestriction(addNewCandidate.getProductVO().getOriginSellingRestriction());
        }
        // submitCheck = submitCheck + getAddNewCandidateService().validateImageAttribute(toBeSavedVO, false, null);

        submitCheck = submitCheck.replace("\n", CPSConstants.EMPTY_STRING).trim();

        // Fix 1197
        UserInfo userInfo = getUserInfo();
        WorkRequest workRqst = toBeSavedVO.getWorkRequest();
        workRqst.setVendorEmail(userInfo.getMail());
        String phone = userInfo.getAttributeValue("telephoneNumber");
        if (phone != null) {
            phone = CPSHelper.cleanPhoneNumber(phone);
            if (phone.length() >= 10) {
                workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                workRqst.setVendorPhoneNumber(phone.substring(3, 10));
            } else {
                workRqst.setVendorPhoneAreaCd(phone.substring(0, 3));
                workRqst.setVendorPhoneNumber(phone.substring(3, phone.length()));
            }
        }
        workRqst.setCandUpdtUID(userInfo.getUid());
        workRqst.setCandUpdtFirstName(userInfo.getAttributeValue("givenName"));
        workRqst.setCandUpdtLastName(userInfo.getAttributeValue("sn"));
        if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(submitCheck)) {
            savedProductVo = getAddNewCandidateService().submitProduct(toBeSavedVO, getUserRole());
            message = new CPSMessage(CPSConstants.CANDIDATE_SUBMITTED, ErrorSeverity.INFO);
            success = true;
        } else {
            savedProductVo = getAddNewCandidateService().saveProductDetails(toBeSavedVO, userRole);
            String messageStr = "The following fields are mandatory for submitting a candidate  ";
            messageStr = messageStr + "<BR>" + submitCheck + "<BR> Please enter and save these data before submitting.";
            message = new CPSMessage(messageStr, ErrorSeverity.ERROR);
        }
        CaseVO caseVO = new CaseVO();
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, caseVO);
        this.afterSave(addNewCandidate, savedProductVo, toBeSavedVO, scaleVO, req);

        if (null == addNewCandidate.getProductTypes() || addNewCandidate.getProductTypes().isEmpty()) {
            addNewCandidate.setProductTypes(getProductTypes());
        }
        clearMessages(addNewCandidate);
        saveMessage(addNewCandidate, message);
        if (success) {
            returnPage = RELATIVE_PATH_QUESTIONNAIRE_PAGE;

        } else {
            returnPage = RELATIVE_PATH_NEW_PRODUCT_PAGE;

        }
        success = false;
        ModelAndView  model = new ModelAndView(returnPage);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * Validate save.
     *
     * @param candidateForm
     *            the candidate form
     * @throws CPSBusinessException
     *             the CPS business exception
     */
    private void validateSave(AddNewCandidate candidateForm) throws CPSBusinessException {
        candidateForm.setTabIndex(AddNewCandidate.TAB_PROD_UPC);
        candidateForm.setAddCandidateMode();
        String ingSwt = CPSConstants.EMPTY_STRING;
        ingSwt = candidateForm.getScaleAttrib();
        if ("I".equalsIgnoreCase(ingSwt)) {
            candidateForm.getProductVO().getScaleVO().setIngredientSw(CPSConstant.CHAR_Y);
        } else {
            candidateForm.getProductVO().getScaleVO().setIngredientSw(CPSConstant.CHAR_N);
        }

        if (ProductVOHelper.isMandatoryFieldsEntered(candidateForm.getProductVO())) {
            CPSMessage message = new CPSMessage("Please enter the mandatory fields.", ErrorSeverity.VALIDATION);
            saveMessage(candidateForm, message);
        }
    }

    /**
     * Prints the summary.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_PRINT_SUMMARY)
    public ModelAndView printSummary(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {

        ProductVO productVO = null;
        setForm(req, addNewCandidate);
        CPSExportToExcel exportToExcel = new CPSExportToExcel();
        addNewCandidate.setRejectClose(false);
        addNewCandidate.setRejectComments(CPSConstants.EMPTY_STRING);
        List columnHeadings = null;
        List<CaseVO> caseVOList = addNewCandidate.getProductVO().getCaseVOs();

        String userRole = getUserRole();
        if (userRole.equals(BusinessConstants.REGISTERED_VENDOR_ROLE)
                || userRole.equals(BusinessConstants.UNREGISTERED_VENDOR_ROLE)) {
            columnHeadings = exportToExcel.getColumnHeadings(getHeadingsForVendors());
        } else {
            columnHeadings = exportToExcel.getColumnHeadings(getHeadings());
        }

        boolean vendorExists = false;
        for (CaseVO caseVO : caseVOList) {
            List<VendorVO> vendorVOList = caseVO.getVendorVOs();
            if (null != vendorVOList && !vendorVOList.isEmpty()) {
                vendorExists = true;
                break;
            }
        }

        List<PrintVO> printList = new ArrayList<PrintVO>();
        List<PrintVO> finalPrintList = new ArrayList<PrintVO>();

        if (vendorExists) {
            try {
                // productVO = getAddNewCandidateService().fetchProduct(prodId,
                // getUserRole());
                productVO = addNewCandidate.getProductVO();
                if (null != productVO) {
                    printList = PrintSummaryHelper.copyEntityToEntity(productVO);
                }
                for (PrintVO printVO : printList) {
                    finalPrintList.add(printVO);
                }
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
                addNewCandidate.setRejectClose(true);
                addNewCandidate.setRejectComments("This Item is already in Production");
            }

        } else {
            addNewCandidate.setRejectClose(true);
            addNewCandidate.setRejectComments("Candidate needs to have a vendor to Print Summary");
        }

        if (!finalPrintList.isEmpty()) {
            exportToExcel.exportToExcel(columnHeadings, finalPrintList, "PrintSummary", null, resp, req);
        }
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, getSelectedCaseVO(addNewCandidate));
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * Gets the headings.
     *
     * @return the headings
     */
    @SuppressWarnings("unchecked")
    private LinkedHashMap getHeadings() {
        LinkedHashMap map = new LinkedHashMap();
        map.put("Create Date", "createDate");
        map.put("Record Type", "recordType");
        map.put("Case ID", "caseID");
        map.put("Source", "source");
        map.put("Product", "productID");
        map.put("UPC", "caseUPC");
        map.put("Description", "description");
        map.put("Size", "size");
        map.put("Vendor", "vendor");
        map.put("Master Pack", "masterPack");
        map.put("Ship Pack", "shipPack");
        map.put("Unit Cost", "unitCost");
        map.put("Sugg Retail", "suggRetailFor");
        map.put("Actual Retail", "retailFor");
        map.put("Margin", "margin");
        map.put("Accept", "accept");
        return map;
    }
    /**
     * This method is for getting the heading in the Print Summary when the user
     * is a vendor.
     *
     * @return LinkedHashMap
     */
    @SuppressWarnings("unchecked")
    private LinkedHashMap getHeadingsForVendors() {
        LinkedHashMap map = new LinkedHashMap();
        map.put("Create Date", "createDate");
        map.put("Record Type", "recordType");
        map.put("Case ID", "caseID");
        map.put("Source", "source");
        map.put("Product", "productID");
        map.put("UPC", "caseUPC");
        map.put("Description", "description");
        map.put("Size", "size");
        map.put("Vendor", "vendor");
        map.put("Master Pack", "masterPack");
        map.put("Ship Pack", "shipPack");
        map.put("Unit Cost", "unitCost");
        map.put("Sugg Retail", "suggRetailFor");
        map.put("Accept", "accept");
        return map;
    }
    /**
     * Reset matrix margin.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_RESET_MATRIX_MARGIN)
    public ModelAndView resetMatrixMargin(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        CPSMessage message = new CPSMessage("The MatrixMargin is not available", ErrorSeverity.VALIDATION);
        saveMessage(addNewCandidate, message);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * Reset test scan.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_RESET_TEST_SCAN)
    public ModelAndView resetTestScan(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setRejectClose(false);
        CPSMessage message = new CPSMessage(addNewCandidate.getRejectComments(), ErrorSeverity.ERROR);
        saveMessage(addNewCandidate, message);
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
        VendorVO vendorVO = new VendorVO();
        req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
        // keep selected vendor VO in form so that it is accessible while saving
        // facilities
        addNewCandidate.setVendorVO(vendorVO);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }

    /**
     * Reset product.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_RESET_PRODUCT)
    public ModelAndView resetProduct(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        addNewCandidate.setRejectClose(false);
        if (null == addNewCandidate.getAuthorizeServiceMessage()
                || CPSConstants.EMPTY_STRING.equalsIgnoreCase(addNewCandidate.getAuthorizeServiceMessage())) {
            CPSMessage message = new CPSMessage(CPSConstants.AUTHORIZE_SERVICE_ERROR, ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
        } else {
            CPSMessage message = new CPSMessage(addNewCandidate.getAuthorizeServiceMessage(), ErrorSeverity.ERROR);
            saveMessage(addNewCandidate, message);
        }
        addNewCandidate.setAuthorizeServiceMessage(CPSConstants.EMPTY_STRING);
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, new CaseVO());
        VendorVO vendorVO = new VendorVO();
        req.setAttribute(CPSConstants.SELECTED_VENDOR_VO, vendorVO);
        // keep selected vendor VO in form so that it is accessible while saving
        // facilities
        addNewCandidate.setVendorVO(vendorVO);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * When clicking Upload button from audit record page.
     *
     * @param addNewCandidate
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws CPSSystemException
     *             the CPS system exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_FILE_UPLOAD)
    public ModelAndView fileUpload(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        setForm(req, addNewCandidate);
        addNewCandidate.setTabIndex(AddNewCandidate.TAB_POW);
        addNewCandidate.setAddCandidateMode();
        long megaBYTE = 1024L * 1024L;
//		boolean isUpload = true;
        Integer prodId = 0;
        // Call File Upload Helper to Upload File
        String uiFileNm = addNewCandidate.getTheFile().getOriginalFilename();
        if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(uiFileNm)) {
//			File fileToCreate = null;
            AntiVirus av = new ClamAVAntivirus();
            try {
                double fileSize = CPSHelper.getDoubleValue(String.valueOf(addNewCandidate.getTheFile().getSize()))
                        / megaBYTE;
                // check max size >8MB
                if (fileSize > CPSConstants.MAX_SIZE) {
                    CPSMessage message = new CPSMessage("File size should be less than 8MB", ErrorSeverity.VALIDATION);
                    saveMessage(addNewCandidate, message);
//					isUpload = false;
                } else if(CPSHelper.isEmpty(addNewCandidate.getTypeDocument())){
                    CPSMessage message = new CPSMessage("Type of document is mandatory", ErrorSeverity.VALIDATION);
                    saveMessage(addNewCandidate, message);
//					isUpload = false;
                } else if (av.virusCheck(new ByteArrayInputStream(addNewCandidate.getTheFile().getBytes()))) {
                    addNewCandidate.setTheFile(null);
                    throw new CPSSystemException("User Tried to Upload a Virus Infected File");
                } else {
                    // CALL image upload WS get clipId
                    AttachmentVO attchVO = new AttachmentVO();
                    attchVO.setTypeDocument(addNewCandidate.getTypeDocument());
                    attchVO.setDocExtTxt(addNewCandidate.getTheFile().getContentType());
                    attchVO.setTypeDocumentDes(CPSHelper.getDocumentCategoryCd(addNewCandidate.getDocCatList(), addNewCandidate.getTypeDocument()));
                    attchVO.setUiFileNm(uiFileNm);
                    attchVO.setDocumentContent(addNewCandidate.getTheFile().getBytes());
                    UserInfo uInfo = getUserInfo();
                    if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPsProdId())) {
                        prodId = addNewCandidate.getProductVO().getPsProdId();
                    } else if (CPSHelper.isNotEmpty(addNewCandidate.getSelectedProductId())
                            && CPSHelper.isEmpty(addNewCandidate.getProductVO().getProdId())) {
                        prodId = NumberUtils.toInt(addNewCandidate.getSelectedProductId());
                    }
                    if(!CPSConstant.UPLOAD_DOCUMENT_SDS.equalsIgnoreCase(addNewCandidate.getTypeDocument().trim())){
                        long primaryUPC = 0;
                        if (!addNewCandidate.isProduct()) {
                            primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                        } else {
                            if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                                /*
                                 * This case upc got when user clicked on 'Save MRT Case' button
                                 * Called from DWR (AddNewCandidateDWR->addMRTCaseVO)
                                 */
                                primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                            } else {
                                List<CaseVO> caseUPCVO = addNewCandidate.getProductVO().getCaseVOs();
                                if (CPSHelper.isNotEmpty(caseUPCVO)) {
                                    for (CaseVO caseVO : caseUPCVO) {
                                        Map<String, CaseUPCVO> obj = caseVO.getCaseUpcVOs();
                                        if (obj != null) {
                                            List<CaseUPCVO> lstCaseUPCVO = new ArrayList<CaseUPCVO>(obj.values());
                                            for (CaseUPCVO caseUPCVO2 : lstCaseUPCVO) {
                                                if (caseUPCVO2.isPrimary()) {
                                                    primaryUPC = CPSHelper.getLongValue(caseUPCVO2.getUnitUpc());
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        int workRequestId = getAddNewCandidateService().getWorkRequestId(String.valueOf(prodId), primaryUPC);
                        attchVO.setWorkRequestId(workRequestId);
                    }
                    String mess = this.getAddNewCandidateService().uploadDocument(prodId,attchVO, uInfo.getUid());
                    if(CPSHelper.isNotEmpty(mess)){
                        if(mess.contains(CPSConstant.REQUEST_NEW_UPC_UPLOAD_DOCUMENT)||mess.contains(BusinessConstants.UPDATE_DOCUMENT_FAILED)){
                            CPSMessage message = new CPSMessage(mess, ErrorSeverity.VALIDATION);
                            saveMessage(addNewCandidate, message);
                        } else {
                            attchVO.setClipId(mess);
                            attchVO.setStoredFileNm(mess);
                            attchVO.setFileDrtryPath(CPSConstant.STRING_EMPTY);
                            if(CPSConstant.UPLOAD_DOCUMENT_SDS.equalsIgnoreCase(addNewCandidate.getTypeDocument().trim())){
                                long primaryUPC = 0;
                                if (!addNewCandidate.isProduct()) {
                                    primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                                } else {
                                    if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                                        primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                                    }
                                }
                                addNewCandidate.getProductVO().setAttachmentVO(getAddNewCandidateService().fetchAttachmentHandle(String.valueOf(prodId), primaryUPC));
                                CPSMessage message = new CPSMessage("Attachments Saved Successfully", ErrorSeverity.INFO);
                                saveMessage(addNewCandidate, message);
                                Object fileUploadSession = req.getSession().getAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
                                if (fileUploadSession != null)
                                    req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
                                req.getSession().setAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION, addNewCandidate.getProductVO().getAttachmentVO());
                            } else {
                                List<AttachmentVO> attachmentVOList = addNewCandidate.getProductVO().getAttachmentVO();
                                attachmentVOList.add(attchVO);
                                addNewCandidate.getProductVO().setAttachmentVO(attachmentVOList);
                                addNewCandidate.setTypeDocument(CPSConstant.STRING_EMPTY);
                                return this.saveAttachments(addNewCandidate, req, resp);
                            }
                        }
                    }
                }
            } catch (AntiVirusException e) {
                LOG.error(e.getMessage(), e);
                CPSMessage message = new CPSMessage("Error connecting to AntiVirus server", ErrorSeverity.VALIDATION);
                saveMessage(addNewCandidate, message);
            } catch (Exception e) {
                LOG.error("Error in Uploading the File from Client to Server: " + e.getMessage(), e);
                //throw new CPSSystemException("Error in Uploading File", e);
                CPSMessage message = new CPSMessage(e.getMessage(), ErrorSeverity.VALIDATION);
                saveMessage(addNewCandidate, message);
            }
            // Create an AttachmentVO and add to the list as a new AttachmentVO
            // - Do
            // not save to database -
            // Save only when Product is saved - new attachmentVO does not have
            // any
            // Seq Number
            addNewCandidate.setTypeDocument("");

        } else {
            try {
                deleteAttachment( addNewCandidate, req, resp);
            } catch (Exception e) {
                LOG.error("Error in deleting the File from Client" + e.getMessage(), e);
                throw new CPSSystemException("Error in deleting the empty File", e);
            }
            addNewCandidate.setTypeDocument("");
            CPSMessage message = new CPSMessage("Please upload a file for attaching", ErrorSeverity.VALIDATION);
            saveMessage(addNewCandidate, message);
        }
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * This Function is called when the Attachment is Deleted -.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @return the action forward
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = RELATIVE_PATH_DELETE_ATTACHMENT)
    public ModelAndView deleteAttachment(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<AttachmentVO> attachmentVOList = addNewCandidate.getProductVO().getAttachmentVO();
        Integer workId = addNewCandidate.getProductVO().getWorkRequest().getWorkIdentifier();
        // Integer prodId = candidateForm.getProductVO().getPsProdId();
        // get the File to be Viewed
        String storedFileNm = req.getParameter(CPSConstants.STORED_FILE_NM);
        String typeDocumentHd  = req.getParameter(CPSConstants.TYPE_DOCUMENT_HD);
        if(storedFileNm!=null && typeDocumentHd!=null){
            for (AttachmentVO attchVO : attachmentVOList) {
                // Remove From Attachment VO Only if the File has not been saved yet
                if (storedFileNm.equals(attchVO.getStoredFileNm()) && typeDocumentHd.equals(attchVO.getTypeDocument())) {
                    attachmentVOList.remove(attchVO);
                    if (attchVO.isExisted() && CPSHelper.isNotEmpty(typeDocumentHd) && "OTHER".equalsIgnoreCase(typeDocumentHd.trim())) {
                        // Need to remove from Database Table
                        Integer seqNbr = attchVO.getSeqNbr();
                        long primaryUPC = 0;
                        if (!addNewCandidate.isProduct()) {
                            primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                        } else {
                            if (CPSHelper.isNotEmpty(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC())) {
                                /*
                                 * This case upc got when user clicked on 'Save MRT
                                 * Case' button Called from DWR
                                 * (AddNewCandidateDWR->addMRTCaseVO)
                                 */
                                primaryUPC = CPSHelper.getLongValue(addNewCandidate.getMrtvo().getCaseVO().getCaseUPC());
                            } else {
                                List<CaseVO> caseUPCVO = addNewCandidate.getProductVO().getCaseVOs();
                                if (CPSHelper.isNotEmpty(caseUPCVO)) {
                                    for (CaseVO caseVO : caseUPCVO) {
                                        Map<String, CaseUPCVO> obj = caseVO.getCaseUpcVOs();
                                        if (obj != null) {
                                            List<CaseUPCVO> lstCaseUPCVO = new ArrayList<CaseUPCVO>(obj.values());
                                            for (CaseUPCVO caseUPCVO2 : lstCaseUPCVO) {
                                                if (caseUPCVO2.isPrimary()) {
                                                    primaryUPC = CPSHelper.getLongValue(caseUPCVO2.getUnitUpc());
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        String prodId;
                        if (CPSHelper.isEmpty(addNewCandidate.getSelectedProductId())) {
                            prodId = CPSConstant.STRING_0;
                        } else {
                            prodId = addNewCandidate.getSelectedProductId();
                        }
                        // Get prodId when Introduce a new product
                        if ((CPSConstant.STRING_0).equals(prodId) && primaryUPC == 0) {
                            prodId = CPSHelper.getStringValue(addNewCandidate.getProductVO().getPsProdId());
                        }
                        getAddNewCandidateService().deleteAttachment(Integer.parseInt(prodId), workId, seqNbr, primaryUPC);
                    } else if (attchVO.isExisted() && CPSHelper.isNotEmpty(typeDocumentHd) && "SDS".equalsIgnoreCase(typeDocumentHd.trim())){
                        this.getAddNewCandidateService().deleteProductScnDoc(attchVO);
                    }
                    break;
                }
            }
        }
        Object fileUploadSession = req.getSession().getAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
        if (fileUploadSession != null) {
            req.getSession().removeAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION);
        }
        req.getSession().setAttribute(CPSConstants.CPS_UPLOAD_FILE_SESSION, attachmentVOList);
        addNewCandidate.getProductVO().setAttachmentVO(attachmentVOList);
        ModelAndView  model = new ModelAndView(RELATIVE_PATH_NEW_PRODUCT_PAGE);
        model.addObject(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE, addNewCandidate);
        return model;
    }
    /**
     * Check upc.
     *
     * @param unitUPC
     *            the unit upc
     * @return true, if successful
     * @throws CPSGeneralException
     *             the CPS general exception
     */
    public boolean checkUPC(String unitUPC) throws CPSGeneralException {
        boolean returnValue = true;
        // execute performance change function getProduct by function
        // checkExistingProductUPC
        // ProductVO productVO = getAddNewCandidateService().getProduct(unitUPC,
        // EMPTY_STRING, EMPTY_STRING);
        boolean checkProduct = getAddNewCandidateService().checkExistProdByUpcBinding5(unitUPC);
        // this lines code are redundant so they will deleted
        // this.correctUOM(productVO);

        if (!checkProduct) {
            boolean dataBaseCheckForUPC = getAddNewCandidateService().checkExistingUPC(unitUPC);
            if (dataBaseCheckForUPC) {
                returnValue = false;
            }
        } else {
            returnValue = false;
        }
        return returnValue;
    }
    /**
     * Gets the unit of measure list for batch.
     *
     * @return the unit of measure list for batch
     */
    public List<BaseJSFVO> getUnitOfMeasureListForBatch() {
        List<BaseJSFVO> uomList = null;
        try {
            uomList = getAppContextFunctions().getUnitOfMeasureList();
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            uomList = new ArrayList<BaseJSFVO>();
        }
        return uomList;
    }
    /**
     * Gets the cost owner for batch.
     *
     * @param brandId
     *            the brand id
     * @return the cost owner for batch
     * @throws Exception
     *             the exception
     */
    public List<BaseJSFVO> getCostOwnerForBatch(String brandId) throws Exception {
        List<BaseJSFVO> brandList = new ArrayList<BaseJSFVO>();
        try {
            if (!CPSHelper.isEmpty(brandId)) {
                brandList = getAddNewCandidateService().getCostOwnerbyBrand(CPSHelper.getIntegerValue(brandId));
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            brandList = new ArrayList<BaseJSFVO>();
        }
        return brandList;
    }

    /**
     * Gets the topto top for batch.
     *
     * @param costOwnerVal
     *            the cost owner val
     * @return the topto top for batch
     * @throws Exception
     *             the exception
     */
    public List<BaseJSFVO> getToptoTopForBatch(String costOwnerVal) throws Exception {
        List<BaseJSFVO> t2T = new ArrayList<BaseJSFVO>();
        try {
            if (!CPSHelper.isEmpty(costOwnerVal)) {
                t2T = getAddNewCandidateService().getT2TbyCostOwner(CPSHelper.getIntegerValue(costOwnerVal));
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            t2T = new ArrayList<BaseJSFVO>();
        }
        return t2T;
    }
    /**
     * Prints the conflict store.
     *
     * @param mapping
     *            the mapping
     * @param form
     *            the form
     * @param req
     *            the req
     * @param resp
     *            the resp
     * @throws Exception
     *             the exception
     */
    @RequestMapping(method = {RequestMethod.POST}, value = RELATIVE_PATH_PRINT_CONFLICT_STORE)
    public void printConflictStore(@ModelAttribute(ADD_NEW_CANDIDATE_MODEL_ATTRIBUTE) AddNewCandidate addNewCandidate, HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // List columnHeadings = new ArrayList();
        addNewCandidate.setSession(req.getSession());
        List<PrintConflictVO> printList = new ArrayList<PrintConflictVO>();
        setForm(req, addNewCandidate);
        CPSExportToExcel exportToExcel = new CPSExportToExcel();
        List<ConflictStoreVO> listConflictStore = addNewCandidate.getConflictStoreVOs();
        List columnHeadings = exportToExcel.getColumnHeadings(getHeadingPrintConflict());
        try {
            printList = PrintSummaryHelper.copyEntityToEntity(listConflictStore);
        } catch (IllegalAccessException e) {
            LOG.error(e.getMessage(), e);
        } catch (InvocationTargetException e) {
            LOG.error(e.getMessage(), e);
        }
        int printSummaryListSize = printList.size();
        if (printSummaryListSize > 0) {
            exportToExcel.exportToExcel(columnHeadings, printList, "PrintConflict", null, resp, req);
        }
        req.setAttribute(CPSConstants.SELECTED_CASE_VO, getSelectedCaseVO(addNewCandidate));
    }
    /**
     * Gets the heading print conflict.
     *
     * @return the heading print conflict
     */
    @SuppressWarnings("unchecked")
    private LinkedHashMap getHeadingPrintConflict() {
        LinkedHashMap map = new LinkedHashMap();
        map.put("Case Description", "caseDescription");
        map.put("Unit UPC", "unitUPC");
        map.put("CostGroup", "conflictCostGroup");
        map.put("Store", "conflictStoreId");
        map.put("Vendor Number 1", "conflictVNumber1");
        map.put("Vendor Name 1", "conflictVName1");
        map.put("List Cost 1", "conflictListCost1");
        map.put("Vendor Number 2", "conflictVNumber2");
        map.put("Vendor Name 2", "conflictVName2");
        map.put("List Cost 2", "conflictListCost2");
        return map;
    }
}