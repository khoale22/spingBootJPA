package com.heb.operations.ui.framework.servlet;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.ui.framework.exception.CPSWebException;

public class CPSApplicationContext {
	
	private static CPSApplicationContext context;
	private static Logger LOG = Logger.getLogger(CPSApplicationContext.class);
	private Properties help;
	private AppContextFunctions functions;
	
	private CPSApplicationContext(){
		
	}
	
	public static synchronized CPSApplicationContext getInstance() throws CPSWebException{
		if(null == context){
			context = new CPSApplicationContext();
			context.init();
		}
		return context;
	}

	private void init() throws CPSWebException {
		help = new Properties();
		
		InputStream is = null;
		try {
			is = this.getClass().getClassLoader().getResourceAsStream("HelpMessages.properties");
			help.load(is);
			/*if(Environment.isDevelopmentEnv()){
				this.functions = new DevAppContextthis.functions();
			}else if(Environment.isProductionEnv()){
			}*/
			this.functions = new ProdAppContextFunctions();
				
			
		} catch (FileNotFoundException e) {
//			LOG.fatal("Exception:-", e);
			throw new CPSWebException(e);
		} catch (IOException e) {
//			LOG.fatal("Exception:-", e);
			throw new CPSWebException(e);
		}
		finally {
			try{
			    if(is != null){
				is.close();
			    }
			}catch(IOException io){
				LOG.error("Unable to close properties file.", io);
			}
		}
	}
	
//	private CommonLocal getCommonBean(){
//		return BeanLocator.getCommonBean();
//	}
//	
//	private AddNewCandidateLocal getAddNewCandidateBean(){
//		return BeanLocator.getAddNewCandidateBean();
//	}

	public Properties getHelp() {
		return help;
	}

	public List<BaseJSFVO> getBdmList() throws CPSGeneralException{
		return this.functions.getBdmList();
	}



	public List<BaseJSFVO> getProductTypes() {
		return this.functions.getProductTypes();
	}
	
	public List<BaseJSFVO> getProdTypeChildren(String parntProdTypCd){
		return this.functions.getProdTypeChildren(parntProdTypCd);
	}

	public List<BaseJSFVO> getUpcTypeList() {
		return this.functions.getUpcTypeList();
	}

	public List<BaseJSFVO> getUnitOfMeasureList() {
//		return unitOfMeasureList;
		return this.functions.getUnitOfMeasureList();
	}

	public List<BaseJSFVO> getTobaccoProdTypeList() {
//		return tobaccoProdTypeList;
		return this.functions.getTobaccoProdTypeList();
	}

	public List<BaseJSFVO> getActionCodeList() {
//		return actionCodeList;
		return this.functions.getActionCodeList();
	}

	public List<BaseJSFVO> getGraphicsCodeList() {
//		return graphicsCodeList;
		return this.functions.getGraphicsCodeList();
	}

	public List<BaseJSFVO> getRestrictedSalesAgeLimitList() {
//		return restrictedSalesAgeLimitList;
		return this.functions.getRestrictedSalesAgeLimitList();
	}

	public List<BaseJSFVO> getDrugSchedules() {
//		return drugSchedules;
		return this.functions.getDrugSchedules();
	}

	public List<BaseJSFVO> getTouchTypeCodes() {
//		return touchTypeCodes;
		return this.functions.getTouchTypeCodes();
	}

	public List<BaseJSFVO> getChannels() {
//		return channels;
		return this.functions.getChannels();
	}

	public List<BaseJSFVO> getCountryOfOrigin() throws CPSGeneralException {
//		return countryOfOrigin;
		return this.functions.getCountryOfOrigin();
	}

	public List<BaseJSFVO> getSeasonality() {
//		return seasonality;
		return this.functions.getSeasonality();
	}

	public List<BaseJSFVO> getSeasonalityYr() {
		return this.functions.getSeasonalityYr();
	}

	public List<BaseJSFVO> getTop2Top() {
		return this.functions.getTop2Top();
	}
	
	
	public List<BaseJSFVO> getNutrientList() throws CPSGeneralException {
		return this.functions.getNutrientList();
	}

	public List<BaseJSFVO> getItemCategory() {
		return this.functions.getItemCategory();
	}

	public List<BaseJSFVO> getOrderRestriction() {
		 return this.functions.getOrderRestriction();
	}

	public List<BaseJSFVO> getPurchaseStatus() {
		return this.functions.getPurchaseStatus();
	}

	// R2 [
	public List<BaseJSFVO> getLabelFormatList() {
		return this.functions.getLabelFormatList();
	}
	// R2 ]

	//Order unit changes
	public List<BaseJSFVO> getOrderUnitList() {
		return this.functions.getOrderUnitList();
	}
	public List<BaseJSFVO> getSubCommodityList() throws CPSGeneralException {
		return this.functions.getSubCommodityList();
	}
	
	/**
	 * Get Tax Categories
	 * @author binhht
	 * @return
	 * @throws CPSGeneralException
	 */
	public List<BaseJSFVO> getTaxCategoryList() throws CPSGeneralException {
		return this.functions.getTaxCategoryList();
	}	

	public List<BaseJSFVO> getCommodityList() throws CPSGeneralException {
		return this.functions.getCommodityList();
	}
	// DRU
	public List<BaseJSFVO> getReadyUnitList(){
		return this.functions.getReadyUnitList();
	}
	public List<BaseJSFVO> getOrientationList(){
		return this.functions.getOrientationList();
	}
}