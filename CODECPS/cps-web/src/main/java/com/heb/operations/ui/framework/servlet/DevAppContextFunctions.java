//package com.heb.operations.ui.framework.servlet;
//
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Properties;
//
//import com.heb.operations.business.framework.exeption.CPSGeneralException;
//import com.heb.operations.business.framework.vo.BaseJSFVO;
////import com.heb.operations.cps.services.AddNewCandidateLocal;
////import com.heb.operations.cps.services.CommonLocal;
//import com.heb.operations.cps.util.BeanLocator;
//import org.apache.log4j.Logger;
//import com.heb.operations.ui.framework.util.PropertyManager;
//
//public class DevAppContextFunctions implements AppContextFunctions {
//
//	private static final Logger log = Logger.getInstance();
//
//	private List<BaseJSFVO> bdmList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> subBrands = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> productTypes = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> upcTypeList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> unitOfMeasureList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> tobaccoProdTypeList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> actionCodeList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> graphicsCodeList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> restrictedSalesAgeLimitList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> drugSchedules = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> touchTypeCodes = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> channels = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> countryOfOrigin = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> seasonality = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> seasonalityYr = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> top2Top = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> brands = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> nutrientList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> itemCategory = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> orderRestriction = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> purchaseStatus = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> labelFormats = new ArrayList<BaseJSFVO>(); // R2
//	private List<BaseJSFVO> orderUnitList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> subComodityList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> comodityList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> readyUnitList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> orientationList = new ArrayList<BaseJSFVO>();
//	private List<BaseJSFVO> taxCategoryList = new ArrayList<BaseJSFVO>();
//	public DevAppContextFunctions() {
//		initServices();
//	}
//
//	private CommonLocal getCommonBean() {
//		return BeanLocator.getCommonBean();
//	}
//
//	private AddNewCandidateLocal getAddNewCandidateBean() {
//		return BeanLocator.getAddNewCandidateBean();
//	}
//
//	private void initServices() {
//		Properties p = PropertyManager.getInstance().getTableProperties();
//		try {
//			String uomTable = p.getProperty("UnitOfMeasure.table");
//			String tobaccoProductTable = p.getProperty("TobaccoProduct.table");
//			String actionCodeTable = p.getProperty("ActionCode.table");
//			String graphicsCodeTable = p.getProperty("GraphicsCode.table");
//			String restrictedAgeLimitTable = p
//					.getProperty("RestrictedAgeLimit.table");
//			String drugScheduleTable = p.getProperty("DrugSchedule.table");
//			String touchTypeTable = p.getProperty("TouchType.table");
//			String top2TopTable = p.getProperty("TopType.table");
//			String sesonalityTable = p.getProperty("Sesonality.table");
//			String countryOfOriginTable = p
//					.getProperty("CountryOfOrigin.table");
//			String subBrandTable = p.getProperty("SubBrand.table");
//			String brandTable = p.getProperty("Brand.table");
//
//			brands = new ArrayList<BaseJSFVO>();
//			subBrands = new ArrayList<BaseJSFVO>();
//			// bdmList = getCommonBean().getAllBDMs();
//			// subBrands = getCommonBean().getSubBrands();
//			subBrands = new ArrayList<BaseJSFVO>();
//			productTypes = getCommonBean().getProductTypes();
//			upcTypeList = getCommonBean().getUPCType();
//			unitOfMeasureList = getCommonBean().getUOMs();
//			tobaccoProdTypeList = getCommonBean().getTobaccoTypes();
//			actionCodeList = getCommonBean().getActionCodes();
//			graphicsCodeList = getCommonBean().getGraphicsCodes();
//			restrictedSalesAgeLimitList = getCommonBean()
//					.getRestrictedSalesAgeLimits();
//			drugSchedules = getCommonBean().getDrugSchedules();
//			touchTypeCodes = getCommonBean().getTouchTypeCodes();
//			channels = getAddNewCandidateBean().getChannels();
//
//			// top2Top =
//			// getAddNewCandidateBean().getCodeAndDescFromTable(top2TopTable);
//
//			seasonality = getCommonBean().getSeasonality();
//			nutrientList = getCommonBean().getNutrientList();
//			orderRestriction = getCommonBean().getOrderRestrictionList();
//			labelFormats = getCommonBean().getLabelFormats();
//			readyUnitList = getCommonBean().getReadyUnitList();
//			orientationList= getCommonBean().getOrientationList();
//			// countryOfOrigin
//			// =getAddNewCandidateBean().getCodeAndDescFromTable(countryOfOriginTable);
//
//		} catch (Exception e) {
//			log.fatal("Exception:-", e);
//		}
//	}
//
//	public List<BaseJSFVO> getActionCodeList() {
//		return actionCodeList;
//	}
//
//	public List<BaseJSFVO> getBdmList() {
//		return bdmList;
//	}
//
//	public List<BaseJSFVO> getChannels() {
//		return channels;
//	}
//
//	public List<BaseJSFVO> getCountryOfOrigin() {
//		return countryOfOrigin;
//	}
//
//	public List<BaseJSFVO> getDrugSchedules() {
//		return drugSchedules;
//	}
//
//	public List<BaseJSFVO> getGraphicsCodeList() {
//		return graphicsCodeList;
//	}
//
//	public List<BaseJSFVO> getProductTypes() {
//		return productTypes;
//	}
//
//	public List<BaseJSFVO> getRestrictedSalesAgeLimitList() {
//		return restrictedSalesAgeLimitList;
//	}
//
//	public List<BaseJSFVO> getSeasonality() {
//		return seasonality;
//	}
//
//	public List<BaseJSFVO> getSeasonalityYr() {
//		return seasonalityYr;
//	}
//
//	public List<BaseJSFVO> getSubBrands() {
//		return subBrands;
//	}
//
//	public List<BaseJSFVO> getTobaccoProdTypeList() {
//		return tobaccoProdTypeList;
//	}
//
//	public List<BaseJSFVO> getTop2Top() {
//		return top2Top;
//	}
//
//	public List<BaseJSFVO> getTouchTypeCodes() {
//		return touchTypeCodes;
//	}
//
//	public List<BaseJSFVO> getUnitOfMeasureList() {
//		return unitOfMeasureList;
//	}
//
//	public List<BaseJSFVO> getUpcTypeList() {
//		return upcTypeList;
//	}
//
//	public List<BaseJSFVO> getBrands() {
//		return brands;
//	}
//
//	public List<BaseJSFVO> getProdTypeChildren(String parntProdTypCd) {
//		// return
//		// getCommonEmbeddedLookUpFacade().getProdTypeChildren(parntProdTypCd);
//		return null;
//	}
//
//	public List<BaseJSFVO> getIngredients() {
//		return new ArrayList<BaseJSFVO>();
//	}
//
//	public List<BaseJSFVO> getNutrientList() throws CPSGeneralException {
//		return nutrientList;
//	}
//
//	public List<BaseJSFVO> getItemCategory() {
//		return itemCategory;
//	}
//
//	public List<BaseJSFVO> getOrderRestriction() {
//		return orderRestriction;
//	}
//
//	public List<BaseJSFVO> getPurchaseStatus() {
//		return purchaseStatus;
//	}
//
//	// R2 [
//	public List<BaseJSFVO> getLabelFormatList() {
//		return labelFormats;
//	}
//
//	// R2 ]
//
//	public List<BaseJSFVO> getOrderUnitList() {
//		return orderUnitList;
//	}
//
//	public List<BaseJSFVO> getSubCommodityList() {
//		return subComodityList;
//	}
//
//	public List<BaseJSFVO> getCommodityList() {
//		return comodityList;
//	}
//
//	public List<BaseJSFVO> getCommoditysBaseOnSub(String subCommondityId)
//			throws CPSGeneralException {
//		return getCommonBean().getCommoditysBaseOnSub(subCommondityId);
//	}
//	 public List<BaseJSFVO> getReadyUnitList(){
//		 return readyUnitList;
//	 }
//	 public List<BaseJSFVO> getOrientationList(){
//		 return orientationList;
//	 }
//
//	@Override
//	public List<BaseJSFVO> getTaxCategoryList() throws CPSGeneralException {
//	    return taxCategoryList;
//	}
//}