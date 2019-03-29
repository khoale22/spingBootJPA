package com.heb.operations.ui.framework.servlet;

import java.util.List;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;

public interface AppContextFunctions {

	public List<BaseJSFVO> getBdmList() throws CPSGeneralException;

	public List<BaseJSFVO> getProductTypes();

	public List<BaseJSFVO> getUpcTypeList();

	public List<BaseJSFVO> getUnitOfMeasureList();

	public List<BaseJSFVO> getTobaccoProdTypeList();

	public List<BaseJSFVO> getActionCodeList();

	public List<BaseJSFVO> getGraphicsCodeList();

	public List<BaseJSFVO> getRestrictedSalesAgeLimitList();

	public List<BaseJSFVO> getDrugSchedules();

	public List<BaseJSFVO> getTouchTypeCodes();

	public List<BaseJSFVO> getChannels();

	public List<BaseJSFVO> getCountryOfOrigin() throws CPSGeneralException;

	public List<BaseJSFVO> getSeasonality();

	public List<BaseJSFVO> getProdTypeChildren(String parntProdTypCd);

	public List<BaseJSFVO> getSeasonalityYr();

	public List<BaseJSFVO> getTop2Top();

	public List<BaseJSFVO> getNutrientList() throws CPSGeneralException;

	public List<BaseJSFVO> getItemCategory();

	public List<BaseJSFVO> getOrderRestriction();

	public List<BaseJSFVO> getPurchaseStatus();

	public List<BaseJSFVO> getLabelFormatList(); // R2

	public List<BaseJSFVO> getOrderUnitList();

	public List<BaseJSFVO> getSubCommodityList() throws CPSGeneralException;
	
	/**
	 * @author binhht
	 * @return
	 * @throws CPSGeneralException
	 */
	public List<BaseJSFVO> getTaxCategoryList() throws CPSGeneralException;

	public List<BaseJSFVO> getCommodityList() throws CPSGeneralException;

	public List<BaseJSFVO> getCommoditysBaseOnSub(String subCommondityId)
			throws CPSGeneralException;
 // DRU
	public List<BaseJSFVO> getReadyUnitList();
	public List<BaseJSFVO> getOrientationList();
}