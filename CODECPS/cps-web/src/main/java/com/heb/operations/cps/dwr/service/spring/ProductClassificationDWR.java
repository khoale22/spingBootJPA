package com.heb.operations.cps.dwr.service.spring;

import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.ClassCommodityVO;
import com.heb.operations.business.framework.vo.CommoditySubCommVO;
import com.heb.operations.cps.model.AddNewCandidate;
import com.heb.operations.cps.util.CPSHelper;
import com.heb.operations.cps.util.CommonBridge;
import com.heb.operations.cps.vo.ApLocationVO;
import com.heb.operations.cps.vo.EDISearchResultVO;
import com.heb.operations.cps.vo.ObjAuthorization;
import com.heb.operations.ui.framework.dwr.custom.SpringFormCorrelatedService;
import com.heb.operations.ui.framework.dwr.service.AbstractSpringDWR;
import com.heb.operations.ui.framework.exception.CPSWebException;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContextFactory;

import java.util.*;

@SpringFormCorrelatedService(formName= AddNewCandidate.FORM_NAME)
public abstract class ProductClassificationDWR extends AbstractSpringDWR {
	private static final Logger LOG = Logger.getLogger(ProductClassificationDWR.class);

	/**
	 * @param bdmId
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 */
	public List<BaseJSFVO> getCommoditiesFromBDM(String bdmId) throws CPSGeneralException {
		Map<String, ClassCommodityVO> classComMap = null;
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		try {
			if (bdmId == null || bdmId.isEmpty()) {
				bdmId = "ALL";
			}
			classComMap = CommonBridge.getCommonServiceInstance().getCommoditiesForBDMFromCache(bdmId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		if (null != classComMap && !classComMap.isEmpty()) {
			getForm().setClassCommodityMap(classComMap);

			list.addAll(classComMap.values());
			CPSHelper.sortList(list);
		}
		return list;
	}

	/**
	 * @param classId
	 * @param commId
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 */
	public List<BaseJSFVO> getSubCommodities(String classId, String commId) throws CPSGeneralException {
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		Map<String, CommoditySubCommVO> commoditySubCommMap = CommonBridge.getCommonServiceInstance().getSubCommoditiesForClassCommodity(classId, commId);
		if (null != commoditySubCommMap && !commoditySubCommMap.isEmpty()) {
			getForm().setcommoditySubMap(commoditySubCommMap);
			getForm().setBrickMap(this.clearBrickMap(getForm().getBrickMap()));

			list.addAll(commoditySubCommMap.values());
			CPSHelper.sortList(list);
		}
		return list;
	}

	/**
	 * @param bdmId
	 * @return Object
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	public Object getCommoditiesFromBDMNoReturn(String bdmId) throws Exception {
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession().getAttribute(AddNewCandidate.FORM_NAME);
		addNewCandidate.setClassCommodityMap(new HashMap<String, ClassCommodityVO>());
		addNewCandidate.setcommoditySubMap(new HashMap<String, CommoditySubCommVO>());
		addNewCandidate.setBrickMap(this.clearBrickMap(getForm().getBrickMap()));
		Map<String, ClassCommodityVO> classComMap = CommonBridge.getCommonServiceInstance().getCommoditiesForBDM(bdmId);

		if (addNewCandidate == null) {
			addNewCandidate = new AddNewCandidate();
			WebContextFactory.get().getSession().setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}

		if (null != classComMap && classComMap.size() > 0) {
			addNewCandidate.setClassCommodityMap(classComMap);
		}

		Object ret = null;
		if (classComMap.size() == 0) {
			ret = new HashMap<String, String>();
			((Map<String, String>) ret).put("message", "No Commodities found.");
		} else {
			ret = new HashMap<String, List<BaseJSFVO>>();
			List<BaseJSFVO> originalUom = CommonBridge.getCommonServiceInstance().getUOMs();
			CPSHelper.sortList(originalUom);
			// SPRINT 22
			originalUom.add(0, new BaseJSFVO("NONE", "--Select--"));
			((Map<String, List<BaseJSFVO>>) ret).put("uoms", originalUom);
		}
		return ret;
	}

	/**
	 * @param classId
	 * @param commodityId
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 */
	public List<BaseJSFVO> getSubCommodityForClassCommodity(String classId, String commodityId) throws CPSGeneralException {
		Integer i = new Double(classId).intValue();
		String classTemp = String.valueOf(i);

		Map<String, CommoditySubCommVO> classSubComMap = CommonBridge.getCommonServiceInstance().getSubCommoditiesForClassCommodity(classTemp, commodityId);
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		if (null != classSubComMap) {
			getForm().setcommoditySubMap(classSubComMap);
			getForm().setBrickMap(this.clearBrickMap(getForm().getBrickMap()));
			list.addAll(classSubComMap.values());
		}

		return list;

	}

	public BaseJSFVO getClassForCommodity(String commodity) {
		return getForm().getClassForCommodity(commodity);
	}

	/**
	 * Initial BDM lists
	 * 
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author khoapkl
	 * @throws CPSWebException
	 */
	public List<BaseJSFVO> getAllBDMs() throws CPSGeneralException, CPSWebException {
		List<BaseJSFVO> bdms = CommonBridge.getCommonServiceInstance().getBDMsAsBaseJSFVOs();
		CPSHelper.sortList(bdms);
		return bdms;
	}

	/**
	 * Initial commodity lists
	 * 
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author khoapkl
	 * @throws CPSWebException
	 */
	public List<BaseJSFVO> getAllCommodities() throws CPSGeneralException, CPSWebException {
		List<BaseJSFVO> commodities = CommonBridge.getCommonServiceInstance().getCommoditysAsBaseJSFVOs();
		CPSHelper.sortList(commodities);
		return commodities;
	}

	/**
	 * Initial classes lists
	 * 
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author khoapkl
	 * @throws CPSWebException
	 */
	public List<BaseJSFVO> getAllClasses() throws CPSGeneralException, CPSWebException {
		List<BaseJSFVO> classes = CommonBridge.getCommonServiceInstance().getClassesAsBaseJSFVOs();
		CPSHelper.sortList(classes);
		return classes;
	}

	/**
	 * Initial Sub-Commodity list
	 * 
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author khoapkl
	 * @throws CPSWebException
	 */
	public List<BaseJSFVO> getAllSubCommodities() throws CPSGeneralException, CPSWebException {
		List<BaseJSFVO> subCommodities = CommonBridge.getCommonServiceInstance().getSubCommoditysAsBaseJSFVOs();
		CPSHelper.sortList(subCommodities);
		return subCommodities;
	}

	/**
	 * Initial Tax Category list
	 * 
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author BINHHT
	 * @throws CPSWebException
	 */
	public List<BaseJSFVO> getAllTaxCategories() throws CPSGeneralException, CPSWebException {
		List<BaseJSFVO> taxCategories = CommonBridge.getCommonServiceInstance().getTaxCategoryAsBaseJSFVOs();
		CPSHelper.sortList(taxCategories);
		return taxCategories;
	}

	/**
	 * Get the list of bdm when user changed a commodity
	 * 
	 * @param commodityId
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author khoapkl
	 */
	public List<BaseJSFVO> getBDMForCommodity(String commodityId) throws CPSGeneralException {
		return CommonBridge.getCommonServiceInstance().getBDMForCommodity(commodityId);
	}

	/**
	 * get a single class when user changed a commodity
	 * 
	 * @param commodityId
	 * @return BaseJSFVO
	 * @throws Exception
	 * @author khoapkl
	 */
	public BaseJSFVO getClassFromCommNoReturn(String commodityId) throws Exception {
		List<BaseJSFVO> classComMap = CommonBridge.getCommonServiceInstance().getClassForCommodity(commodityId);
		if (classComMap.isEmpty()) {
			return new BaseJSFVO("", "");
		} else {
			String classDesc = CPSHelper.getTrimmedValue(classComMap.get(0).getName());
			classDesc = classDesc.substring(0, classDesc.indexOf('['));
			return new BaseJSFVO(classComMap.get(0).getId(), classDesc);
		}
	}

	/**
	 * This method used to get commodity list when sub-commodity changed first
	 * 
	 * @param subCommodityId
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author khoapkl
	 */
	public List<BaseJSFVO> getCommodityForSubCommodity(String subCommodityId) throws CPSGeneralException {
		Collection<CommoditySubCommVO> lstSubCommodity = CommonBridge.getCommonServiceInstance().getAllCommoditySub();
		String commodity = "";
		if (lstSubCommodity != null && !lstSubCommodity.isEmpty()) {
			for (CommoditySubCommVO commoditySubCommVO : lstSubCommodity) {
				if (commoditySubCommVO.getId().equals(subCommodityId)) {
					commodity = commoditySubCommVO.getPdOmiComCd();
					break;
				}
			}
		}
		Map<String, ClassCommodityVO> classCommodityMap = CommonBridge.getCommonServiceInstance().getCommodityForSubCommodity(commodity);
		List<BaseJSFVO> list = new ArrayList<BaseJSFVO>();
		if (null != classCommodityMap && !classCommodityMap.isEmpty()) {
			getForm().getClassCommodityMap().clear();
			getForm().setClassCommodityMap(classCommodityMap);

			list.addAll(classCommodityMap.values());
			CPSHelper.sortList(list);
		}
		return list;
	}

	/**
	 * Get single bdm follow by commodityId. Data got from Web-service. This
	 * case happened when user changed a commodity first
	 * 
	 * @param commodityId
	 * @return BaseJSFVO
	 * @throws CPSGeneralException
	 * @author khoapkl
	 */
	public BaseJSFVO getSingleBDMForCommodity(String commodityId) throws CPSGeneralException {
		List<BaseJSFVO> bdms = CommonBridge.getCommonServiceInstance().getBDMForCommodity(commodityId);
		if (bdms != null && !bdms.isEmpty()) {
			String bdmName = bdms.get(0).getName();
			bdmName = CPSHelper.getTrimmedValue(bdmName.substring(0, bdmName.indexOf("[")));
			return new BaseJSFVO(bdms.get(0).getId(), bdmName);
		}
		return new BaseJSFVO("", "");
	}

	/**
	 * Get single commodities follow by subCommodityId. Data got from
	 * Web-service. This case happened when user changed a sub-commodity first
	 * 
	 * @param subCommodityId
	 * @return BaseJSFVO
	 * @throws CPSGeneralException
	 * @author khoapkl
	 */
	public BaseJSFVO getSingleCommodityForSubCommodity(String subCommodityId) throws CPSGeneralException {
		Collection<CommoditySubCommVO> lstSubCommodity = CommonBridge.getCommonServiceInstance().getAllCommoditySub();
		String commodityId = "";
		if (lstSubCommodity != null && !lstSubCommodity.isEmpty()) {
			for (CommoditySubCommVO commoditySubCommVO : lstSubCommodity) {
				if (commoditySubCommVO.getId().equals(subCommodityId)) {
					commodityId = commoditySubCommVO.getPdOmiComCd();
					break;
				}
			}
		}
		Map<String, ClassCommodityVO> classCommodityMap = CommonBridge.getCommonServiceInstance().getCommodityForSubCommodity(commodityId);
		if (classCommodityMap.get(commodityId) != null) {
			String commodityName = classCommodityMap.get(commodityId).getName();
			commodityName = CPSHelper.getTrimmedValue(commodityName.substring(0, commodityName.indexOf("[")));
			return new BaseJSFVO(commodityId, commodityName);
		}
		return new BaseJSFVO("", "");
	}

	/**
	 * Get single sub-commodities follow by classCode and commodityCode. Data
	 * got from Web-service. This case happened when user changing commodity
	 * 
	 * @param classId
	 * @param commodityId
	 * @return BaseJSFVO
	 * @throws CPSGeneralException
	 * @author khoapkl
	 */
	public BaseJSFVO getSingSubCommodityForClassCommodity(String classId, String commodityId) throws CPSGeneralException {
		Integer i = new Double(classId).intValue();
		String classTemp = String.valueOf(i);
		Map<String, CommoditySubCommVO> classSubComMap = CommonBridge.getCommonServiceInstance().getSubCommoditiesForClassCommodity(classTemp, commodityId);
		List<CommoditySubCommVO> subCommodity = new ArrayList<CommoditySubCommVO>(classSubComMap.values());
		if (subCommodity != null && !subCommodity.isEmpty()) {
			String subCommodityName = subCommodity.get(0).getName();
			subCommodityName = CPSHelper.getTrimmedValue(subCommodityName.substring(0, subCommodityName.indexOf('[')));
			return new BaseJSFVO(subCommodity.get(0).getId(), subCommodityName);
		}
		return new BaseJSFVO("", "");
	}

	/**
	 * Get single commodities follow by buyerCode. Data got from Web-service.
	 * This case happened when user changing buyer
	 * 
	 * @param bdmId
	 * @return BaseJSFVO
	 * @throws CPSGeneralException
	 * @author khoapkl
	 */
	public BaseJSFVO getSingleCommodityForBDM(String bdmId) throws CPSGeneralException {
		Map<String, ClassCommodityVO> classComMap = CommonBridge.getCommonServiceInstance().getCommoditiesForBDM(bdmId);
		List<ClassCommodityVO> commodity = new ArrayList<ClassCommodityVO>(classComMap.values());
		if (commodity != null && !commodity.isEmpty()) {
			String commodityName = commodity.get(0).getName();
			commodityName = CPSHelper.getTrimmedValue(commodityName.substring(0, commodityName.indexOf('[')));
			return new BaseJSFVO(commodity.get(0).getId(), commodityName);
		}
		return new BaseJSFVO("", "");
	}

	/**
	 * Get bdmcd from subcommodity This case happened when user changing
	 * subcommodity
	 * 
	 * @param subCommodityId
	 * @return BaseJSFVO
	 * @throws CPSGeneralException
	 * @author trungnv
	 */
	public BaseJSFVO getSingleBDMForSubCom(String subCommodityId) throws CPSGeneralException {
		return CommonBridge.getCommonServiceInstance().getBDMFromSubCommodity(subCommodityId);
	}

	/**
	 * validateDeptAndSubDept This case happened when user changing subcommodity
	 * 
	 * @param subCom
	 * @param bmCode
	 * @param arrCheckList
	 * @return ObjAuthorization
	 * @throws CPSGeneralException
	 * @author trungnv
	 */
	public ObjAuthorization validateDeptAndSubDept(String subCom, String bmCode, String[] arrCheckList) throws CPSGeneralException {

		List<EDISearchResultVO> listEDISearchResultVO = new ArrayList<EDISearchResultVO>();
		// get ps work request ,ps prod id from arrCheckList
		for (int i = 0; i < arrCheckList.length; i++) {
			String[] arrValues = arrCheckList[i].split("__");
			EDISearchResultVO ediSearchResultVO = new EDISearchResultVO();
			ediSearchResultVO.setPsWorkId(Integer.parseInt(arrValues[0].trim()));
			ediSearchResultVO.setPsProdId(Integer.parseInt(arrValues[1].trim()));
			ediSearchResultVO.setPsVendno(arrValues[2].trim());
			ediSearchResultVO.setUpcNo(arrValues[3].trim());
			ediSearchResultVO.setChannel(arrValues[4].trim());
			ediSearchResultVO.setPsItemId(arrValues[5].trim());
			listEDISearchResultVO.add(ediSearchResultVO);
		}

		// get list result and pass to commom validateDeptAndSubDept
		return CommonBridge.getCommonServiceInstance().validateAndFixVendorDeptSubDept(subCom, listEDISearchResultVO);

	}

	/**
	 * Get ALl AppLocation from cache
	 * 
	 * @return List<BaseJSFVO>
	 * @throws CPSGeneralException
	 * @author thangdang
	 * @throws CPSGeneralException
	 */
	public List<BaseJSFVO> getAllAppLocations() throws CPSGeneralException {
		List<BaseJSFVO> apLocations = CommonBridge.getCommonServiceInstance().getApLocationsAsBaseJSFVOs();
		CPSHelper.sortList(apLocations);
		return apLocations;
	}

	/**
	 * @param id
	 * @return ApLocationVO
	 * @throws CPSGeneralException
	 */
	public ApLocationVO appLocationInfo(String id) throws CPSGeneralException {
		return CommonBridge.getCommonServiceInstance().getApLocationDetail(id);
	}

	/**
	 * @param map
	 * @return Map<String, BaseJSFVO>
	 */
	public Map<String, BaseJSFVO> clearBrickMap(Map<String, BaseJSFVO> map) {
		Map<String, BaseJSFVO> mapRt = new HashMap<String, BaseJSFVO>();
		if (!map.isEmpty()) {
			for (Map.Entry<String, BaseJSFVO> entry : map.entrySet()) {
				if (entry.getValue().isIdInLabel()) {
					mapRt.put(entry.getKey(), entry.getValue());
				}
			}
		}
		return mapRt;
	}
}
