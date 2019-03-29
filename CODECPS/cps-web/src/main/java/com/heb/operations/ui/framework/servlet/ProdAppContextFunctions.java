package com.heb.operations.ui.framework.servlet;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.cps.services.AddNewCandidateService;
import com.heb.operations.cps.services.CommonService;
import com.heb.operations.cps.util.CPSHelper;

@Service
public class ProdAppContextFunctions implements AppContextFunctions {

    private static final Logger log = Logger.getLogger(ProdAppContextFunctions.class);

    private List<BaseJSFVO> seasonalityYr = new ArrayList<BaseJSFVO>();
    private List<BaseJSFVO> top2Top = new ArrayList<BaseJSFVO>();

    public ProdAppContextFunctions() {
    }

    @Autowired
    CommonService commonService;

    @Autowired
    AddNewCandidateService addNewCandidateService;

    public List<BaseJSFVO> getBdmList() throws CPSGeneralException {
	return commonService.getBDMsAsBaseJSFVOs();
    }

    public List<BaseJSFVO> getProductTypes() {
	return commonService.getProductTypes();
    }

    public List<BaseJSFVO> getUpcTypeList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getUPCType();
	} catch (Exception ex) {
	    log.error("Exception:-", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getUnitOfMeasureList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getUOMs();
	} catch (Exception ex) {
	    log.error("Exception:-", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getTobaccoProdTypeList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getTobaccoTypes();
	} catch (Exception ex) {
	    log.error("Exception:-", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getActionCodeList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getActionCodes();
	} catch (Exception ex) {
	    log.error("Exception:-", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getGraphicsCodeList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getGraphicsCodes();
	} catch (Exception ex) {
	    log.error("Exception:-", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getRestrictedSalesAgeLimitList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getRestrictedSalesAgeLimits();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getDrugSchedules() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getDrugSchedules();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getTouchTypeCodes() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getTouchTypeCodes();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getChannels() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = addNewCandidateService.getChannels();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getCountryOfOrigin() throws CPSGeneralException {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getCountryList();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getNutrientList() throws CPSGeneralException {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getNutrientList();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getSeasonality() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getSeasonality();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getSeasonalityYr() {
	return seasonalityYr;
    }

    public List<BaseJSFVO> getTop2Top() {
	CPSHelper.insertBlankSelect(top2Top);
	return top2Top;
    }

    public List<BaseJSFVO> getProdTypeChildren(String parntProdTypCd) {
	return commonService.getProductTypeChildren(parntProdTypCd);
    }

    public List<BaseJSFVO> getItemCategory() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getItemCategory();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getOrderRestriction() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getOrderRestrictionList();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getPurchaseStatus() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getPurchaseStatus();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    // R2 [
    public List<BaseJSFVO> getLabelFormatList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getLabelFormats();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    // R2 ]

    public List<BaseJSFVO> getOrderUnitList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getOrderUnitList();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getSubCommodityList() throws CPSGeneralException {
	return commonService.getSubCommoditysAsBaseJSFVOs();
    }

    /**
     * Get Tax Categories
     * @author binhht
     * 
     */
    public List<BaseJSFVO> getTaxCategoryList() throws CPSGeneralException {
	return commonService.getTaxCategoryAsBaseJSFVOs();
    }

    public List<BaseJSFVO> getCommodityList() throws CPSGeneralException {
	return commonService.getCommoditysAsBaseJSFVOs();
    }

    public List<BaseJSFVO> getCommoditysBaseOnSub(String subCommondityId) throws CPSGeneralException {
	return commonService.getCommoditysBaseOnSub(subCommondityId);
    }

    public List<BaseJSFVO> getReadyUnitList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getReadyUnitList();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }

    public List<BaseJSFVO> getOrientationList() {
	List<BaseJSFVO> ret = null;
	try {
	    ret = commonService.getOrientationList();
	} catch (Exception ex) {
	    log.error("Exception", ex);
	}
	return ret;
    }
}
