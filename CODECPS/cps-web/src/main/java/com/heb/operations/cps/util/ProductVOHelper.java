package com.heb.operations.cps.util;

import java.util.ArrayList;
import java.util.List;

import com.heb.operations.cps.model.AddCandidate;
import org.apache.commons.lang.SerializationException;
import org.apache.commons.lang.SerializationUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.heb.operations.cps.vo.IngdVO;
import com.heb.operations.cps.vo.PharmacyVO;
import com.heb.operations.cps.vo.ProductVO;
import com.heb.operations.cps.vo.ScaleVO;
import com.heb.operations.cps.vo.UPCVO;
import com.heb.operations.cps.vo.ImageAttribute.AttrVO;
import com.heb.operations.cps.vo.ImageAttribute.DynamicExtentionAttributeVO;
import com.heb.operations.cps.vo.ImageAttribute.GroupAttrVO;
import com.heb.operations.cps.vo.ImageAttribute.ImageAttriVOHelper;
import com.heb.operations.cps.vo.ImageAttribute.ImageAttributeVO;
import com.heb.operations.cps.vo.ImageAttribute.NutritionBasicInfoVO;
import com.heb.operations.cps.vo.ImageAttribute.NutritionDetailVO;
import com.heb.operations.cps.vo.ImageAttribute.NutritionInfoVO;

public class ProductVOHelper {
	private static Logger LOG = Logger.getLogger(ProductVOHelper.class);

	public static ProductVO copyProductVOtoProductVO(ProductVO productVO) {
		ProductVO newProductVO = new ProductVO();
		newProductVO.setWorkRequest(productVO.getWorkRequest());
		newProductVO.getClassificationVO().setProductType(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getProductType()));
		newProductVO.getClassificationVO().setProductTypeName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getProductTypeName()));
		newProductVO.getClassificationVO().setAlternateBdm(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getAlternateBdm()));
		newProductVO.getClassificationVO().setBdmName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getBdmName()));
		newProductVO.getClassificationVO().setCommodity(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getCommodity()));
		newProductVO.getClassificationVO().setCommodityName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getCommodityName()));
		newProductVO.getClassificationVO().setSubCommodity(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getSubCommodity()));
		newProductVO.getClassificationVO().setEligible(
				productVO.getClassificationVO().isEligible());
		newProductVO.getClassificationVO().setSubCommodityName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getSubCommodityName()));
		newProductVO.getClassificationVO().setBrick(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getBrick()));
		newProductVO.getClassificationVO().setBrickOrg(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getBrickOrg()));
		newProductVO.getClassificationVO().setBrickName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getBrickName()));
		newProductVO.getClassificationVO().setClassDesc(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getClassDesc()));
		newProductVO.getClassificationVO().setClassField(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getClassField()));
		newProductVO.getClassificationVO().setProdDescritpion(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getProdDescritpion()));
		newProductVO.getClassificationVO().setComments(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getComments()));
		newProductVO.getClassificationVO().setUserComments(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getUserComments()));
		newProductVO.getClassificationVO().setMerchandizeType(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getMerchandizeType()));
		newProductVO.getClassificationVO().setMerchandizeName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getMerchandizeName()));
		newProductVO.getClassificationVO().setBrand(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getBrand()));
		newProductVO.getClassificationVO().setBrandName(
				CPSHelper.getTrimmedValue(productVO.getClassificationVO()
						.getBrandName()));
		newProductVO.getShelfEdgeVO().setPackaging(
				CPSHelper.getTrimmedValue(productVO.getShelfEdgeVO()
						.getPackaging()));
		newProductVO.getShelfEdgeVO().setCustFrndlyDescription1(
				CPSHelper.getTrimmedValue(productVO.getShelfEdgeVO()
						.getCustFrndlyDescription1()));
		newProductVO.getShelfEdgeVO().setCustFrndlyDescription2(
				CPSHelper.getTrimmedValue(productVO.getShelfEdgeVO()
						.getCustFrndlyDescription2()));
		newProductVO.getShelfEdgeVO().setScanDesc(
				CPSHelper.getTrimmedValue(productVO.getShelfEdgeVO()
						.getScanDesc()));

		// trungnv add pim 450
		newProductVO.getPhysicalAttributeVO().setStyle(
				CPSHelper.getTrimmedValue(productVO.getPhysicalAttributeVO()
						.getStyle()));
		newProductVO.getPhysicalAttributeVO().setModel(
				CPSHelper.getTrimmedValue(productVO.getPhysicalAttributeVO()
						.getModel()));
		newProductVO.getPhysicalAttributeVO().setColor(
				CPSHelper.getTrimmedValue(productVO.getPhysicalAttributeVO()
						.getColor()));

		// Fix production issue. Ignore FSA
		/*
		 * newProductVO.getPharmacyVO().setFSA(CPSHelper.getTrimmedValue(
		 * productVO .getPharmacyVO().getFSA()));
		 */

		/**
		 * Commented out the following lines to ignore PSE and PSE GRams
		 */
		/*
		 * newProductVO.getPointOfSaleVO().setPse(CPSHelper.getTrimmedValue(
		 * productVO.getPointOfSaleVO().getPse()));
		 * newProductVO.getPointOfSaleVO
		 * ().setPseGrams(CPSHelper.getTrimmedValue(
		 * productVO.getPharmacyVO().getPseGrams()));
		 */
		newProductVO.getPharmacyVO().setDrugSchedule(
				CPSHelper.getTrimmedValue(productVO.getPharmacyVO()
						.getDrugSchedule()));
		newProductVO.getPharmacyVO().setDrugNmCd(
				CPSHelper.getTrimmedValue(productVO.getPharmacyVO()
						.getDrugNmCd()));

		newProductVO.getPharmacyVO().setNdc(
				CPSHelper.getTrimmedValue(productVO.getPharmacyVO().getNdc()));
		newProductVO.getPharmacyVO().setAvgCost(
				CPSHelper.getTrimmedValue(productVO.getPharmacyVO()
						.getAvgCost()));
		newProductVO.getPharmacyVO().setDirectCost(
				CPSHelper.getTrimmedValue(productVO.getPharmacyVO()
						.getDirectCost()));
		// trungnv fix 482
		newProductVO.getPointOfSaleVO()
				.setPse(CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getPse()));
		newProductVO.getPointOfSaleVO().setFamilyCode1(
				CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getFamilyCode1()));
		newProductVO.getPointOfSaleVO().setFamilyCode2(
				CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getFamilyCode2()));
		newProductVO.getPointOfSaleVO().setPssDept(
				CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getPssDept()));

		newProductVO.getPointOfSaleVO().setQualifyConditionCode(
				CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getQualifyConditionCode()));
		// newProductVO.getPointOfSaleVO().setRestrictedSalesAgeLimit(CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO().getRestrictedSalesAgeLimit()));
		// newProductVO.getPointOfSaleVO().setPurchaseTime(CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO().getPurchaseTime()));
		// newProductVO.getPointOfSaleVO().setPurchaseTimeName(CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO().getPurchaseTimeName()));
		// trungnv fix pim 450
		newProductVO.getPointOfSaleVO().setRating(
				CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getRating()));
		newProductVO.getPointOfSaleVO().setDepositUPC(
				CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO()
						.getDepositUPC()));
		// PIM-1339
		// newProductVO.getPointOfSaleVO().setLaborCategory(CPSHelper.getTrimmedValue(productVO.getPointOfSaleVO().getLaborCategory()));
		// Deepu - setting values of booleans for bug no 457 Starts
		newProductVO.getPointOfSaleVO().setDrugFactPanel(
				productVO.getPointOfSaleVO().isDrugFactPanel());
		newProductVO.getPointOfSaleVO().setQntityRestricted(
				productVO.getPointOfSaleVO().isQntityRestricted());
		newProductVO.getPointOfSaleVO().setTaxable(
				productVO.getPointOfSaleVO().isTaxable());
		// trungnv fix pim482
		newProductVO.getPointOfSaleVO().setFsa(
				productVO.getPointOfSaleVO().isFsa());
		//PIM-1484
		newProductVO.getPointOfSaleVO().setShowClrsSw(
				productVO.getPointOfSaleVO().isShowClrsSw());
		newProductVO.getPointOfSaleVO().setFdaMenuLabelingStatus(productVO.getPointOfSaleVO().getFdaMenuLabelingStatus());
		newProductVO.getPointOfSaleVO().setFoodStamp(
				productVO.getPointOfSaleVO().isFoodStamp());
		newProductVO.getPointOfSaleVO().setTaxableDefault(
				productVO.getPointOfSaleVO().isTaxableDefault());
		newProductVO.getPointOfSaleVO().setFoodStampDefault(
				productVO.getPointOfSaleVO().isFoodStampDefault());
		newProductVO.getPointOfSaleVO().setAbusiveVolatileChemical(
				productVO.getPointOfSaleVO().isAbusiveVolatileChemical());
		// For Tax Category
		newProductVO.getPointOfSaleVO().setTaxCateCode(
				productVO.getPointOfSaleVO().getTaxCateCode());
		newProductVO.getPointOfSaleVO().setTaxCateName(
				productVO.getPointOfSaleVO().getTaxCateName());
		newProductVO.getPointOfSaleVO().setListTaxCategory(
				productVO.getPointOfSaleVO().getListTaxCategory());
		newProductVO.getPointOfSaleVO().setListTaxCategoryDistinct(
				productVO.getPointOfSaleVO().getListTaxCategoryDistinct());
		newProductVO.getRetailVO().setWeightFlag(
				productVO.getRetailVO().isWeightFlag());
		// Deepu - setting values of booleans for bug no 457 Ends
		newProductVO.getRetailVO()
				.setPrePrice(
						CPSHelper.getTrimmedValue(productVO.getRetailVO()
								.getPrePrice()));
		newProductVO.getRetailVO()
				.setForPrice(
						CPSHelper.getTrimmedValue(productVO.getRetailVO()
								.getForPrice()));
		newProductVO.getRetailVO().setOffPreprice(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getOffPreprice()));
		newProductVO.getRetailVO()
				.setCentsOff(
						CPSHelper.getTrimmedValue(productVO.getRetailVO()
								.getCentsOff()));
		newProductVO.getRetailVO().setRetailLinkTo(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getRetailLinkTo()));
		newProductVO.getRetailVO().setRetailLinkNum(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getRetailLinkNum()));
		newProductVO.getRetailVO().setRetail(
				CPSHelper.getTrimmedValue(productVO.getRetailVO().getRetail()));
		newProductVO.getRetailVO().setRetailFor(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getRetailFor()));
		newProductVO.getRetailVO().setCriticalItem(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getCriticalItem()));
		newProductVO.getRetailVO().setCriticalItemName(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getCriticalItemName()));
		newProductVO.getRetailVO().setRetailRadio(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getRetailRadio()));
		newProductVO.getRetailVO().setSuggRetail(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getSuggRetail()));
		newProductVO.getRetailVO().setTobaccoTax(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getTobaccoTax()));
		newProductVO.getRetailVO().setSuggforPrice(
				CPSHelper.getTrimmedValue(productVO.getRetailVO()
						.getSuggforPrice()));
		newProductVO.getRetailLinkVO().setRetailLinkNum(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getRetailLinkNum()));
		newProductVO.getRetailLinkVO().setUpcType(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getUpcType()));
		newProductVO.getRetailLinkVO().setUnitUpc(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getUnitUpc()));
		newProductVO.getRetailLinkVO().setCommodity(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getCommodity()));
		newProductVO.getRetailLinkVO().setSubCommodity(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getSubCommodity()));
		newProductVO.getRetailLinkVO().setProdDesc(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getProdDesc()));
		newProductVO.getRetailLinkVO().setUnitRetail(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getUnitRetail()));
		newProductVO.getRetailLinkVO().setUnitRetailFor(
				CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
						.getUnitRetailFor()));
		newProductVO.getRetailLinkVO()
				.setSize(
						CPSHelper.getTrimmedValue(productVO.getRetailLinkVO()
								.getSize()));
		newProductVO.getTobaccoVO().setSelTobaccoProdtype(
				CPSHelper.getTrimmedValue(productVO.getTobaccoVO()
						.getSelTobaccoProdtype()));
		newProductVO.getTobaccoVO().setUnstampedSwitch(
				CPSHelper.getTrimmedValue(productVO.getTobaccoVO()
						.getUnstampedSwitch()));
		newProductVO.getTobaccoVO().setTaxAmount(
				CPSHelper.getTrimmedValue(productVO.getTobaccoVO()
						.getTaxAmount()));
		newProductVO.setPrimaryUPC(productVO.getPrimaryUPC());
		newProductVO.setNewDataSw(productVO.getNewDataSw());
		if (CPSHelper.isNotEmpty(productVO.getUpcVO())) {
			List<UPCVO> lstVo = productVO.getUpcVO();
			for (UPCVO upcvo : lstVo) {
				String desc = upcvo.getSubBrandDesc();
				if (CPSHelper.isNotEmpty(desc)) {
					if (desc.lastIndexOf("[") > -1) {
						String subId = desc.substring(
								desc.lastIndexOf("[") + 1,
								desc.lastIndexOf("]"));
						if (CPSHelper.isNotEmpty(upcvo.getSubBrand())) {
							if (subId.trim().equals(upcvo.getSubBrand().trim())) {
								desc = desc.substring(0, desc.indexOf("["));
								upcvo.setSubBrandDesc(desc);
							}
						}
					}
				}
				if (CPSHelper.isEmpty(newProductVO.getPointOfSaleVO().getPse())) {
					upcvo.setPseGram("");
				}

			}
			newProductVO.setUpcVO(productVO.getUpcVO());

		}

		if (CPSHelper.isNotEmpty(productVO.getCommentsVO())) {
			newProductVO.setCommentsVO(productVO.getCommentsVO());
		}

		if (CPSHelper.isNotEmpty(productVO.getScaleVO())) {
			// R2 [
			// newProductVO.setScaleVO(productVO.getScaleVO());
			newProductVO.getScaleVO().setIngStatementNumber(
					productVO.getScaleVO().getIngStatementNumber());
			newProductVO.getScaleVO().setShelfLifeDays(
					productVO.getScaleVO().getShelfLifeDays());
			newProductVO.getScaleVO().setServiceCounterTare(
					productVO.getScaleVO().getServiceCounterTare());
			newProductVO.getScaleVO().setNutStatementNumber(
					productVO.getScaleVO().getNutStatementNumber());
			newProductVO.getScaleVO().setActionCode(
					productVO.getScaleVO().getActionCode());
			newProductVO.getScaleVO().setActionCodeDesc(
					productVO.getScaleVO().getActionCodeDesc());
			newProductVO.getScaleVO().setGraphicsCode(
					productVO.getScaleVO().getGraphicsCode());
			newProductVO.getScaleVO().setGraphicsCodeDesc(
					productVO.getScaleVO().getGraphicsCodeDesc());
			newProductVO.getScaleVO().setForceTare(
					productVO.getScaleVO().getForceTare());
			newProductVO.getScaleVO().setPrePackTare(
					productVO.getScaleVO().getPrePackTare());
			newProductVO.getScaleVO().setEngDescLine1(
					productVO.getScaleVO().getEngDescLine1());
			newProductVO.getScaleVO().setEngDescLine2(
					productVO.getScaleVO().getEngDescLine2());
			/*
			 * added by HoangVT: spaDescLine1, spaDescLine2, grade number, net
			 * weight date: 10.May.2010 Enhancement: new scale fields [defect
			 * 1013]
			 */
			newProductVO.getScaleVO().setSpaDescLine1(
					productVO.getScaleVO().getSpaDescLine1());
			newProductVO.getScaleVO().setSpaDescLine2(
					productVO.getScaleVO().getSpaDescLine2());
			newProductVO.getScaleVO().setGradeNbr(
					productVO.getScaleVO().getGradeNbr());
			newProductVO.getScaleVO().setNetWt(
					productVO.getScaleVO().getNetWt());

			newProductVO.getScaleVO().setLabelFormat1(
					productVO.getScaleVO().getLabelFormat1());
			newProductVO.getScaleVO().setLabelFormat2(
					productVO.getScaleVO().getLabelFormat2());
			newProductVO.getScaleVO().setLabelFormat1Desc(
					productVO.getScaleVO().getLabelFormat1Desc());
			newProductVO.getScaleVO().setLabelFormat2Desc(
					productVO.getScaleVO().getLabelFormat2Desc());
			// R2 ]
			/*
			 * added by HungBang: engDescLine3,engDescLine4,engDesc1,engDesc2,
			 * mechTenz
			 */

			newProductVO.getScaleVO().setEngDescLine3(
					productVO.getScaleVO().getEngDescLine3());
			newProductVO.getScaleVO().setEngDescLine4(
					productVO.getScaleVO().getEngDescLine4());
			newProductVO.getScaleVO().setEngDesc1(
					productVO.getScaleVO().getEngDesc1());
			newProductVO.getScaleVO().setEngDesc2(
					productVO.getScaleVO().getEngDesc2());
			newProductVO.getScaleVO().setMechTenz(
					productVO.getScaleVO().isMechTenz());
		}

		if (CPSHelper.isNotEmpty(productVO.getAttachmentVO())) {
			newProductVO.setAttachmentVO(productVO.getAttachmentVO());
		}

		newProductVO.setProdId(productVO.getProdId());
		newProductVO.setCopiedProdid(productVO.getCopiedProdid());
		newProductVO.setPsProdId(productVO.getPsProdId());
		newProductVO.setBactchUploadMode(productVO.isBactchUploadMode());
		// deepu - caseVOs are set here for getting values in the auth & dist
		// page when coming from the pro & upc page second time
		ProductVO.copyCaseVOMap(productVO, newProductVO);

		try {
			ImageAttributeVO imageAttributeVO = (ImageAttributeVO) SerializationUtils
					.clone(productVO.getImageAttVO());
			newProductVO.setImageAttVO(imageAttributeVO);
		} catch (SerializationException e) {
			LOG.error(e.getMessage(), e);
		}
		newProductVO.setImageAttCopyProduct(productVO.getImageAttCopyProduct());

		if (CPSHelper.isNotEmpty(productVO.getImageAttCopyProduct())) {
		}

		newProductVO.setCopyImageAttributeProd(productVO
				.isCopyImageAttributeProd());
		// BeanUtils.copyProperties(imageAttributeVO,
		// productVO.getImageAttVO());

		// newProductVO.setImageAttVO(copyImageAttribute(productVO));
		// Hung fix bug 43
		if (CPSHelper.isNotEmpty(productVO.getOriginSellingRestriction())) {
			newProductVO.setOriginSellingRestriction(productVO
					.getOriginSellingRestriction());
		}

		if (CPSHelper.isNotEmpty(productVO.getPointOfSaleVO().getLstRating())) {
			newProductVO.getPointOfSaleVO().setLstRating(
					productVO.getPointOfSaleVO().getLstRating());
		}
		if (CPSHelper.isNotEmpty(productVO.getPointOfSaleVO()
				.getLstSellingRestrictions())) {
			newProductVO.getPointOfSaleVO().setLstSellingRestrictions(
					productVO.getPointOfSaleVO().getLstSellingRestrictions());
		}
		// modified product by HungBang
		newProductVO.setScaleUPC(productVO.isScaleUPC());
		// sprint - 23
		if (CPSHelper.isNotEmpty(productVO.getUpcKitVOs())) {
			newProductVO.setUpcKitVOs(productVO.getUpcKitVOs());
		}
		newProductVO.setActiveProductKit(productVO.isActiveProductKit());
		return newProductVO;
	}

	public static boolean entitySaved(ProductVO newProductVO,
			ProductVO savedProductVO, int tabIndexCurrent) {
		// Properties of saved Product
		String savedProductType = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getProductType());
		String savedBDM = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getAlternateBdm());
		String savedCommodity = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getCommodity());
		String savedSubCommodity = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getSubCommodity());
		String savedBrick = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getBrick());
		String savedClassField = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getClassField());
		String savedProdDesc = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getProdDescritpion());
		String savedMerchType = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getMerchandizeType());
		String savedBrand = CPSHelper.getTrimmedValue(savedProductVO
				.getClassificationVO().getBrand());
		String savedPackaging = CPSHelper.getTrimmedValue(savedProductVO
				.getShelfEdgeVO().getPackaging());
		String savedCustFrndlyDescription1 = CPSHelper
				.getTrimmedValue(savedProductVO.getShelfEdgeVO()
						.getCustFrndlyDescription1());
		String savedCustFrndlyDescription2 = CPSHelper
				.getTrimmedValue(savedProductVO.getShelfEdgeVO()
						.getCustFrndlyDescription2());
		String savedScanDesc = CPSHelper.getTrimmedValue(savedProductVO
				.getShelfEdgeVO().getScanDesc());
		String savedFamilyCode1 = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getFamilyCode1());
		String savedFamilyCode2 = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getFamilyCode2());
		String savedPssDept = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getPssDept());
		// String savedRestrictedSalesAgeLimit =
		// CPSHelper.getTrimmedValue(savedProductVO.getPointOfSaleVO().getRestrictedSalesAgeLimit());
		// String savedPurchaseTime =
		// CPSHelper.getTrimmedValue(savedProductVO.getPointOfSaleVO().getPurchaseTime());
		String savedDepositUPC = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getDepositUPC());
		// Tax Category
		String savedTaxCateCode = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getTaxCateCode());
		String savedTaxCateName = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getTaxCateName());
		// --------------
		// check savedLaborCategory ="" then default on UI is 01 so change
		// LaborCategory to 01
		// String savedLaborCategory =
		// CPSHelper.isEmpty(savedProductVO.getPointOfSaleVO().getLaborCategory())
		// ? "01" :
		// CPSHelper.getTrimmedValue(savedProductVO.getPointOfSaleVO().getLaborCategory());
		// hung add saved Qualify condition
		String savedQualifyCd = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getQualifyConditionCode());

		String savedPrePrice = savedProductVO.getRetailVO().getPrePrice();
		String savedForPrice = savedProductVO.getRetailVO().getForPrice();
		String savedOffPreprice = savedProductVO.getRetailVO().getOffPreprice();
		String savedCentsOff = savedProductVO.getRetailVO().getCentsOff();
		String savedRetailLinkTo = CPSHelper.getTrimmedValue(savedProductVO
				.getRetailVO().getRetailLinkTo());
		String savedRetail = CPSHelper.getTrimmedValue(savedProductVO
				.getRetailVO().getRetail());
		String savedRetailFor = savedProductVO.getRetailVO().getRetailFor();
		String savedCriticalItem = CPSHelper.getTrimmedValue(savedProductVO
				.getRetailVO().getCriticalItem());
		String savedRetailRadio = CPSHelper.getTrimmedValue(savedProductVO
				.getRetailVO().getRetailRadio());
		String savedSuggRetail = CPSHelper.getTrimmedValue(savedProductVO
				.getRetailVO().getSuggRetail());
		String savedTobaccoTax = CPSHelper.getTrimmedValue(savedProductVO
				.getRetailVO().getTobaccoTax());
		String savedSuggforPrice = savedProductVO.getRetailVO()
				.getSuggforPrice();
		/*
		 * String savedRetailLinkNum =
		 * CPSHelper.getTrimmedValue(savedProductVO.getRetailLinkVO
		 * ().getRetailLinkNum()); String savedUpcType =
		 * CPSHelper.getTrimmedValue
		 * (savedProductVO.getRetailLinkVO().getUpcType()); String savedUnitUpc
		 * =
		 * CPSHelper.getTrimmedValue(savedProductVO.getRetailLinkVO().getUnitUpc
		 * ()); String savedCommodity1 =
		 * CPSHelper.getTrimmedValue(savedProductVO
		 * .getRetailLinkVO().getCommodity()); String savedSubCommodity1 =
		 * CPSHelper
		 * .getTrimmedValue(savedProductVO.getRetailLinkVO().getSubCommodity());
		 * String savedProdDesc1 =
		 * CPSHelper.getTrimmedValue(savedProductVO.getRetailLinkVO
		 * ().getProdDesc()); String savedUnitRetail =
		 * CPSHelper.getTrimmedValue(
		 * savedProductVO.getRetailLinkVO().getUnitRetail()); String
		 * savedUnitRetailFor =
		 * savedProductVO.getRetailLinkVO().getUnitRetailFor(); String savedSize
		 * =
		 * CPSHelper.getTrimmedValue(savedProductVO.getRetailLinkVO().getSize()
		 * );
		 */
		// R2 [
		// String savedScaleDesc =
		// CPSHelper.getTrimmedValue(savedProductVO.getScaleVO().getScaleDesc());
		// String savedActionCode =
		// CPSHelper.getTrimmedValue(savedProductVO.getScaleVO().getActionCode());
		// String savedGraphicsCode =CPSHelper.getTrimmedValue(
		// savedProductVO.getScaleVO().getGraphicsCode());
		// String savedNutriStmt =
		// CPSHelper.getTrimmedValue(savedProductVO.getScaleVO().getNutriStmt());
		// R2 ]
		/*
		 * String savedSelTobaccoProdtype =
		 * savedProductVO.getTobaccoVO().getSelTobaccoProdtype(); String
		 * savedUnstampedSwitch =
		 * savedProductVO.getTobaccoVO().getUnstampedSwitch(); String
		 * savedTaxAmount = savedProductVO.getTobaccoVO().getTaxAmount();
		 */

		// R2 [
		String savedIngNumber = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getIngStatementNumber());
		String savedShelfLifeDays = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getShelfLifeDays());
		String savedCounterTare = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getServiceCounterTare());
		String savedNutNumber = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getNutStatementNumber());
		String savedActionCd = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getActionCode());
		String savedGraphicsCd = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getGraphicsCode());
		String savedForceTare = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getForceTare());
		String savedPrePackTare = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getPrePackTare());
		String savedDesc1 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getEngDescLine1());
		String savedDesc2 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getEngDescLine2());
		// HoangVT
		String savedSpaDesc1 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getSpaDescLine1());
		String savedSpaDesc2 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getSpaDescLine2());
		String savedGradeNbr = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getGradeNbr());
		String savedNetWt = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getNetWt());
		// HungBang 19.Jan.2016
		String savedEngDescLine3 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getEngDescLine3());
		String savedEngDescLine4 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getEngDescLine4());
		String savedDescEng1 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getEngDesc1());
		String savedDescEng2 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getEngDesc2());

		String savedLabel1 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getLabelFormat1());
		String savedLabel2 = CPSHelper.getTrimmedValue(savedProductVO
				.getScaleVO().getLabelFormat2());
		// R2 ]
		// trungnv add pim450
		String style = CPSHelper.getTrimmedValue(savedProductVO
				.getPhysicalAttributeVO().getStyle());
		String model = CPSHelper.getTrimmedValue(savedProductVO
				.getPhysicalAttributeVO().getModel());
		String color = CPSHelper.getTrimmedValue(savedProductVO
				.getPhysicalAttributeVO().getColor());
		String rating = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getRating());

		// trungnv fix 482
		String savedPse = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getPse());
		// Properties of new Product
		String newProductType = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getProductType());
		String newBDM = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getAlternateBdm());
		String newCommodity = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getCommodity());
		String newSubCommodity = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getSubCommodity());
		String newBrick = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getBrick());
		String newClassField = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getClassField());
		String newProdDesc = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getProdDescritpion());
		String newMerchType = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getMerchandizeType());
		String newBrand = CPSHelper.getTrimmedValue(newProductVO
				.getClassificationVO().getBrand());
		String newPackaging = CPSHelper.getTrimmedValue(newProductVO
				.getShelfEdgeVO().getPackaging());
		String newCustFrndlyDescription1 = CPSHelper
				.getTrimmedValue(newProductVO.getShelfEdgeVO()
						.getCustFrndlyDescription1());
		String newCustFrndlyDescription2 = CPSHelper
				.getTrimmedValue(newProductVO.getShelfEdgeVO()
						.getCustFrndlyDescription2());
		String newScanDesc = CPSHelper.getTrimmedValue(newProductVO
				.getShelfEdgeVO().getScanDesc());
		String newFamilyCode1 = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getFamilyCode1());
		String newFamilyCode2 = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getFamilyCode2());
		String newPssDept = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getPssDept());

		// hung add new qualify condition
		String newQualifyCd = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getQualifyConditionCode());
		// String newRestrictedSalesAgeLimit =
		// CPSHelper.getTrimmedValue(newProductVO.getPointOfSaleVO().getRestrictedSalesAgeLimit());
		// String newPurchaseTime =
		// CPSHelper.getTrimmedValue(newProductVO.getPointOfSaleVO().getPurchaseTime());
		String newDepositUPC = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getDepositUPC());
		String newTaxCateCode = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getTaxCateCode());
		String newTaxCateName = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getTaxCateName());
		String newLaborCategory = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getLaborCategory());
		String newPrePrice = newProductVO.getRetailVO().getPrePrice();
		String newForPrice = newProductVO.getRetailVO().getForPrice();
		String newOffPreprice = newProductVO.getRetailVO().getOffPreprice();
		String newCentsOff = newProductVO.getRetailVO().getCentsOff();
		String newRetailLinkTo = CPSHelper.getTrimmedValue(newProductVO
				.getRetailVO().getRetailLinkTo());
		String newRetail = CPSHelper.getTrimmedValue(newProductVO.getRetailVO()
				.getRetail());
		String newRetailFor = newProductVO.getRetailVO().getRetailFor();
		String newCriticalItem = CPSHelper.getTrimmedValue(newProductVO
				.getRetailVO().getCriticalItem());
		String newRetailRadio = CPSHelper.getTrimmedValue(newProductVO
				.getRetailVO().getRetailRadio());
		String newSuggRetail = CPSHelper.getTrimmedValue(newProductVO
				.getRetailVO().getSuggRetail());
		String newTobaccoTax = CPSHelper.getTrimmedValue(newProductVO
				.getRetailVO().getTobaccoTax());
		String newSuggforPrice = newProductVO.getRetailVO().getSuggforPrice();
		/*
		 * String newRetailLinkNum =
		 * CPSHelper.getTrimmedValue(newProductVO.getRetailLinkVO
		 * ().getRetailLinkNum()); String newUpcType =
		 * CPSHelper.getTrimmedValue(
		 * newProductVO.getRetailLinkVO().getUpcType()); String newUnitUpc =
		 * CPSHelper
		 * .getTrimmedValue(newProductVO.getRetailLinkVO().getUnitUpc()); String
		 * newCommodity1 =
		 * CPSHelper.getTrimmedValue(newProductVO.getRetailLinkVO
		 * ().getCommodity()); String newSubCommodity1 =
		 * CPSHelper.getTrimmedValue
		 * (newProductVO.getRetailLinkVO().getSubCommodity()); String
		 * newProdDesc1 =
		 * CPSHelper.getTrimmedValue(newProductVO.getRetailLinkVO(
		 * ).getProdDesc()); String newUnitRetail =
		 * CPSHelper.getTrimmedValue(newProductVO
		 * .getRetailLinkVO().getUnitRetail()); String newUnitRetailFor =
		 * newProductVO.getRetailLinkVO().getUnitRetailFor(); String newSize =
		 * CPSHelper.getTrimmedValue(newProductVO.getRetailLinkVO().getSize());
		 */
		// R2 [
		// String newScaleDesc =
		// CPSHelper.getTrimmedValue(newProductVO.getScaleVO().getScaleDesc());
		// String newActionCode =
		// CPSHelper.getTrimmedValue(newProductVO.getScaleVO().getActionCode());
		// String newGraphicsCode =
		// CPSHelper.getTrimmedValue(newProductVO.getScaleVO().getGraphicsCode());
		// String newNutriStmt =
		// CPSHelper.getTrimmedValue(newProductVO.getScaleVO().getNutriStmt());
		// R2 ]

		// R2 [
		String newIngNumber = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getIngStatementNumber());
		String newShelfLifeDays = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getShelfLifeDays());
		String newCounterTare = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getServiceCounterTare());
		String newNutNumber = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getNutStatementNumber());
		String newActionCd = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getActionCode());
		String newGraphicsCd = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getGraphicsCode());
		String newForceTare = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getForceTare());
		String newPrePackTare = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getPrePackTare());
		String newDesc1 = CPSHelper.getTrimmedValue(newProductVO.getScaleVO()
				.getEngDescLine1());
		String newDesc2 = CPSHelper.getTrimmedValue(newProductVO.getScaleVO()
				.getEngDescLine2());
		// HoangVT
		String newSpaDesc1 = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getSpaDescLine1());
		String newSpaDesc2 = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getSpaDescLine2());
		String newGradeNbr = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getGradeNbr());
		String newNetWt = CPSHelper.getTrimmedValue(newProductVO.getScaleVO()
				.getNetWt());
		// HungBang 19.jan.2016
		String newEngDescLine3 = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getEngDescLine3());
		String newEngDescLine4 = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getEngDescLine4());
		String newDescEng1 = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getEngDesc1());
		String newDescEng2 = CPSHelper.getTrimmedValue(newProductVO
				.getScaleVO().getEngDesc2());

		String newLabel1 = CPSHelper.getTrimmedValue(newProductVO.getScaleVO()
				.getLabelFormat1());
		String newLabel2 = CPSHelper.getTrimmedValue(newProductVO.getScaleVO()
				.getLabelFormat2());
		// R2 ]
		// trungnv pim 450
		String newStyle = CPSHelper.getTrimmedValue(newProductVO
				.getPhysicalAttributeVO().getStyle());
		String newModel = CPSHelper.getTrimmedValue(newProductVO
				.getPhysicalAttributeVO().getModel());
		String newColor = CPSHelper.getTrimmedValue(newProductVO
				.getPhysicalAttributeVO().getColor());
		String newRating = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getRating());

		// imageAttributeChanged check change
		boolean flagChek = false;
		if (AddCandidate.TAB_IMG_ATTR == tabIndexCurrent) {
			flagChek = imageAttributeChanged(newProductVO, savedProductVO);
		}
		// trungnv fix pim 482
		String newPse = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getPse());
		List<UPCVO> upcVos = newProductVO.getUpcVO();
		for (UPCVO upcvo : upcVos) {
			if (upcvo.getSeqNo() == 0 || upcvo.isEditFlag()) {
				return true;
			}
		}
		List<UPCVO> savedupcVos = savedProductVO.getUpcVO();
		if (CPSHelper.isNotEmpty(savedupcVos) && CPSHelper.isNotEmpty(upcVos)) {
			if (savedupcVos.size() != upcVos.size()) {
				return true;
			}
		}

		// hung add list rating and selling restrictions
		List<String> savedRatings = savedProductVO.getPointOfSaleVO()
				.getLstRating();
		List<String> newRatings = newProductVO.getPointOfSaleVO()
				.getLstRating();
		if ((savedRatings != null || CPSHelper.isNotEmpty(savedRatings))
				&& CPSHelper.isNotEmpty(newRatings)) {
			if (savedRatings.size() != newRatings.size()) {
				return true;
			}
		}
		if (CPSHelper.isNotEmpty(savedProductVO.getOriginSellingRestriction())
				&& CPSHelper.isNotEmpty(newProductVO
						.getJsonSellingRestriction())) {
			if (!ProductEntityConverter.compareJsonSellingList(
					newProductVO.getJsonSellingRestriction(),
					savedProductVO.getOriginSellingRestriction())) {
				return true;
			}
		}
		if (CPSHelper.checkEqualValue(savedProductType, newProductType)
				&& CPSHelper.checkEqualValue(savedBDM, newBDM)
				&& CPSHelper.checkEqualValue(savedCommodity, newCommodity)
				&& CPSHelper
						.checkEqualValue(savedSubCommodity, newSubCommodity)
				&& CPSHelper.checkEqualValue(savedBrick, newBrick)
				&& CPSHelper.checkEqualValue(savedClassField, newClassField)
				&& CPSHelper.checkEqualValue(savedProdDesc, newProdDesc)
				&& CPSHelper.checkEqualValue(savedMerchType, newMerchType)
				&& CPSHelper.checkEqualValue(savedBrand, newBrand)
				&& CPSHelper.checkEqualValue(savedPackaging, newPackaging)
				&& CPSHelper.checkEqualValue(savedCustFrndlyDescription1,
						newCustFrndlyDescription1)
				&& CPSHelper.checkEqualValue(savedCustFrndlyDescription2,
						newCustFrndlyDescription2)
				&& CPSHelper.checkEqualValue(savedScanDesc, newScanDesc)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedFamilyCode1),
						CPSHelper.getStringForZero(newFamilyCode1))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedFamilyCode2),
						CPSHelper.getStringForZero(newFamilyCode2))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedPssDept),
						CPSHelper.getStringForZero(newPssDept))
				// &&
				// CPSHelper.checkEqualValue(savedRestrictedSalesAgeLimit,newRestrictedSalesAgeLimit)
				// &&
				// CPSHelper.checkEqualValue(savedPurchaseTime,newPurchaseTime)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedDepositUPC),
						CPSHelper.getStringForZero(newDepositUPC))
				&& CPSHelper.checkEqualValue(savedTaxCateCode, newTaxCateCode)
				&& CPSHelper.checkEqualValue(savedTaxCateName, newTaxCateName)
				// && CPSHelper.checkEqualValue(savedLaborCategory,
				// newLaborCategory)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedPrePrice),
						CPSHelper.getStringForZero(newPrePrice))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedForPrice),
						CPSHelper.getStringForZero(newForPrice))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedOffPreprice),
						CPSHelper.getStringForZero(newOffPreprice))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedCentsOff),
						CPSHelper.getStringForZero(newCentsOff))
				&& CPSHelper
						.checkEqualValue(savedRetailLinkTo, newRetailLinkTo)
				&& CPSHelper.checkEqualValue(savedRetail, newRetail)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedRetailFor),
						CPSHelper.getStringForZero(newRetailFor))
				&& CPSHelper
						.checkEqualValue(savedCriticalItem, newCriticalItem)
				&& CPSHelper.checkEqualValue(savedRetailRadio, newRetailRadio)
				&& CPSHelper.checkEqualValue(savedSuggRetail, newSuggRetail)
				&& CPSHelper.checkEqualValue(savedTobaccoTax, newTobaccoTax)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedSuggforPrice),
						CPSHelper.getStringForZero(newSuggforPrice))
				/*
				 * &&
				 * CPSHelper.checkEqualValue(savedRetailLinkNum,newRetailLinkNum
				 * ) && CPSHelper.checkEqualValue(savedUpcType,newUpcType) &&
				 * CPSHelper.checkEqualValue(savedUnitUpc,newUnitUpc) &&
				 * CPSHelper.checkEqualValue(savedCommodity1,newCommodity1) &&
				 * CPSHelper
				 * .checkEqualValue(savedSubCommodity1,newSubCommodity1) &&
				 * CPSHelper.checkEqualValue(savedProdDesc1,newProdDesc1) &&
				 * CPSHelper.checkEqualValue(savedUnitRetail,newUnitRetail) &&
				 * CPSHelper .checkEqualValue(CPSHelper.getStringForZero(
				 * savedUnitRetailFor
				 * ),CPSHelper.getStringForZero(newUnitRetailFor)) &&
				 * CPSHelper.checkEqualValue(savedSize,newSize)
				 */
				// R2 [
				// && CPSHelper.checkEqualValue(savedScaleDesc,newScaleDesc)
				// &&
				// CPSHelper.checkEqualValue(CPSHelper.getStringForZero(savedActionCode),CPSHelper.getStringForZero(newActionCode))
				// &&
				// CPSHelper.checkEqualValue(CPSHelper.getStringForZero(savedGraphicsCode),CPSHelper.getStringForZero(newGraphicsCode))
				// &&
				// CPSHelper.checkEqualValue(CPSHelper.getStringForZero(savedNutriStmt),CPSHelper.getStringForZero(newNutriStmt))
				// R2 ]
				// R2 [
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedIngNumber),
						CPSHelper.getStringForZero(newIngNumber))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedShelfLifeDays),
						CPSHelper.getStringForZero(newShelfLifeDays))
				// Fix 1302
				// &&
				// CPSHelper.checkEqualValue(CPSHelper.getStringForZero(savedCounterTare),CPSHelper.getStringForZero(newCounterTare))
				&& CPSHelper.checkEqualValue(savedCounterTare, newCounterTare)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedNutNumber),
						CPSHelper.getStringForZero(newNutNumber))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedActionCd),
						CPSHelper.getStringForZero(newActionCd))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedGraphicsCd),
						CPSHelper.getStringForZero(newGraphicsCd))
				// Fix 1302
				// &&
				// CPSHelper.checkEqualValue(CPSHelper.getStringForZero(savedPrePackTare),CPSHelper.getStringForZero(newPrePackTare))
				&& CPSHelper.checkEqualValue(savedPrePackTare, newPrePackTare)
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedLabel1),
						CPSHelper.getStringForZero(newLabel1))
				&& CPSHelper.checkEqualValue(
						CPSHelper.getStringForZero(savedLabel2),
						CPSHelper.getStringForZero(newLabel2))
				&& CPSHelper.checkEqualValue(savedForceTare, newForceTare)
				&& CPSHelper.checkEqualValue(savedDesc1, newDesc1)
				&& CPSHelper.checkEqualValue(savedDesc2, newDesc2)
				// HoangVT
				&& CPSHelper.checkEqualValue(savedSpaDesc1, newSpaDesc1)
				&& CPSHelper.checkEqualValue(savedSpaDesc2, newSpaDesc2)
				&& CPSHelper.checkEqualValue(savedGradeNbr, newGradeNbr)
				&& CPSHelper.checkEqualValue(savedNetWt, newNetWt)
				// HungBang 19.Jan.2016
				&& CPSHelper
						.checkEqualValue(savedEngDescLine3, newEngDescLine3)
				&& CPSHelper
						.checkEqualValue(savedEngDescLine4, newEngDescLine4)
				&& CPSHelper.checkEqualValue(savedDescEng1, newDescEng1)
				&& CPSHelper.checkEqualValue(savedDescEng2, newDescEng2)
				&& newProductVO.getScaleVO().isMechTenz() == savedProductVO
						.getScaleVO().isMechTenz()

				// Hung
				&& CPSHelper.checkEqualValue(savedQualifyCd, newQualifyCd)
				// R2 ]
				&& !isPharmacyEntered(newClassField,
						savedProductVO.getPharmacyVO(),
						newProductVO.getPharmacyVO())
				&& newProductVO.getPointOfSaleVO().isFoodStamp() == savedProductVO
						.getPointOfSaleVO().isFoodStamp()
				&& newProductVO.getPointOfSaleVO().isAbusiveVolatileChemical() == savedProductVO
						.getPointOfSaleVO().isAbusiveVolatileChemical()
				&& newProductVO.getPointOfSaleVO().isQntityRestricted() == savedProductVO
						.getPointOfSaleVO().isQntityRestricted()
				&& newProductVO.getPointOfSaleVO().isDrugFactPanel() == savedProductVO
						.getPointOfSaleVO().isDrugFactPanel()
				&& newProductVO.getPointOfSaleVO().isTaxable() == savedProductVO
						.getPointOfSaleVO().isTaxable()
				&& newProductVO.getPointOfSaleVO().isFsa() == savedProductVO
						.getPointOfSaleVO().isFsa()
				// hung add
				&& newProductVO
						.getPointOfSaleVO()
						.getQualifyConditionCode()
						.equals(savedProductVO.getPointOfSaleVO()
								.getQualifyConditionCode())
				&& newProductVO.getRetailVO().isWeightFlag() == savedProductVO
						.getRetailVO().isWeightFlag()
				&& CPSHelper.checkEqualValue(style, newStyle)
				&& CPSHelper.checkEqualValue(model, newModel)
				&& CPSHelper.checkEqualValue(color, newColor)
				&& CPSHelper.checkEqualValue(rating, newRating)
				&& CPSHelper.checkEqualValue(savedPse, newPse) && newProductVO.getPointOfSaleVO().isShowClrsSw()==savedProductVO.getPointOfSaleVO().isShowClrsSw() && !flagChek) {
			return false;
		} else {
			return true;
		}
	}

	private static boolean isPharmacyEntered(String newClassField,
			PharmacyVO savedPharmacyVO, PharmacyVO newPharmacyVO) {
		if ("32".equals(newClassField) || "34".equals(newClassField)
				|| "68".equals(newClassField) || "69".equals(newClassField)) {
			// Fix production issue. Ignore FSA
			// String savedFSA =
			// CPSHelper.getTrimmedValue(savedPharmacyVO.getFSA());
			/*
			 * String savedPSE =
			 * CPSHelper.getTrimmedValue(savedPharmacyVO.getPSE()); String
			 * savedPseGrams =
			 * CPSHelper.getTrimmedValue(savedPharmacyVO.getPseGrams());
			 */

			String savedDrugSchedule = CPSHelper
					.getTrimmedValue(savedPharmacyVO.getDrugSchedule());
			String savedDrugAbb = CPSHelper.getTrimmedValue(savedPharmacyVO
					.getDrugNmCd());

			String savedNdc = CPSHelper.getTrimmedValue(savedPharmacyVO
					.getNdc());
			String savedAvgCost = CPSHelper.getTrimmedValue(savedPharmacyVO
					.getAvgCost());
			String savedDirectCost = CPSHelper.getTrimmedValue(savedPharmacyVO
					.getDirectCost());

			// Fix production issue. Ignore FSA
			// String newFSA =
			// CPSHelper.getTrimmedValue(newPharmacyVO.getFSA());
			/*
			 * String newPSE =
			 * CPSHelper.getTrimmedValue(newPharmacyVO.getPSE()); String
			 * newPseGrams =
			 * CPSHelper.getTrimmedValue(newPharmacyVO.getPseGrams());
			 */

			String newDrugSchedule = CPSHelper.getTrimmedValue(newPharmacyVO
					.getDrugSchedule());
			String newDrugAbb = CPSHelper.getTrimmedValue(newPharmacyVO
					.getDrugNmCd());

			String newNdc = CPSHelper.getTrimmedValue(newPharmacyVO.getNdc());
			String newAvgCost = CPSHelper.getTrimmedValue(newPharmacyVO
					.getAvgCost());
			String newDirectCost = CPSHelper.getTrimmedValue(newPharmacyVO
					.getDirectCost());
			/**
			 * Commented out some conditions to ignore PSA, FSA and PSE Grams
			 * 
			 */
			if (CPSHelper.checkEqualValue(savedDrugSchedule, newDrugSchedule)
					/*
					 * && CPSHelper.checkEqualValue(savedFSA,newFSA) &&
					 * CPSHelper.checkEqualValue(savedPSE,newPSE) &&
					 * CPSHelper.checkEqualValue
					 * (CPSHelper.getStringForZero(savedPseGrams),newPseGrams)
					 */
					&& CPSHelper.checkEqualValue(savedDrugAbb, newDrugAbb)
					&& CPSHelper.checkEqualValue(savedNdc, newNdc)
					&& CPSHelper.checkEqualValue(
							CPSHelper.getStringForZero(savedAvgCost),
							newAvgCost)
					&& CPSHelper.checkEqualValue(
							CPSHelper.getStringForZero(savedDirectCost),
							newDirectCost)) {
				return false;
			} else {
				return true;
			}
		}
		return false;
	}

	public static boolean isMandatoryFieldsEntered(ProductVO productVO) {
		if (CPSHelper.isEmpty(productVO.getClassificationVO()
				.getProdDescritpion())
				|| CPSHelper.isEmpty(productVO.getClassificationVO()
						.getAlternateBdm())
				|| CPSHelper.isEmpty(productVO.getClassificationVO()
						.getCommodity())
				|| CPSHelper.isEmpty(productVO.getClassificationVO()
						.getSubCommodity())
				|| (CPSHelper.isEmpty(productVO.getClassificationVO()
						.getProductType()) && productVO.getWorkRequest().getIntentIdentifier() != 12 && productVO.isActiveProductKit())
				|| CPSHelper.isEmpty(productVO.getClassificationVO()
						.getMerchandizeType())) {
			return true;
		} else {
			return false;
		}

	}

	public static boolean isScaleEntered(ScaleVO newScaleVO,
			ScaleVO savedScaleVo) {

		if (CPSHelper.checkEqualValue(newScaleVO.getActionCode(),
				savedScaleVo.getActionCode())
				&& CPSHelper.checkEqualValue(newScaleVO.getGraphicsCode(),
						savedScaleVo.getGraphicsCode())
				&& CPSHelper.checkEqualValue(newScaleVO.getNutriStmt(),
						savedScaleVo.getNutriStmt())
				&& CPSHelper.checkEqualValue(newScaleVO.getScaleDesc(),
						savedScaleVo.getScaleDesc())
				&& isIngredientAdded(newScaleVO, savedScaleVo)) {
			/* && !isIngredientAdded(newScaleVO, savedScaleVo)){ */// previous
			// code
			// commented
			return false;
		} else {
			return true;
		}
	}

	public static boolean isIngredientAdded(ScaleVO newScaleVO,
			ScaleVO savedScaleVo) {
		List<IngdVO> list1 = newScaleVO.getIngdVOList();
		List<IngdVO> list2 = savedScaleVo.getIngdVOList();
		if (list1.size() != list2.size()) {
			return true;
		}
		OuterLoop: for (IngdVO ingdVO : list1) {
			for (IngdVO vo2 : list2) {
				if (vo2.getIngdCode().equals(ingdVO.getIngdCode())) {
					continue OuterLoop;
				}
			}
			return true;
		}
		return false;
	}

	private static boolean containsScaleUPC(ProductVO productVO) {
		if (productVO != null) {
			List<UPCVO> upcs = productVO.getUpcVO();
			for (UPCVO upcvo : upcs) {
				if (CPSHelper.checkEqualValue(upcvo.getUpcType(), "PLU")
						&& upcvo.getUnitUpc().startsWith("002")) {
					return true;
				}
			}
		}
		return false;
	}

	public static boolean pssChanged(ProductVO newProductVO,
			ProductVO savedProductVO) {
		String savedPssDept = CPSHelper.getTrimmedValue(savedProductVO
				.getPointOfSaleVO().getPssDept());
		String newPssDept = CPSHelper.getTrimmedValue(newProductVO
				.getPointOfSaleVO().getPssDept());
		if (CPSHelper.checkEqualValue(CPSHelper.getStringForZero(savedPssDept),
				CPSHelper.getStringForZero(newPssDept))) {
			return false;
		}
		return true;
	}

	public static boolean isRequired(ProductVO productVO) {
		return true;
	}

	public static boolean imageAttributeChanged(ProductVO newProductVO,
			ProductVO savedProductVO) {
		// boolean flag = true;
		boolean flagBrick = false;
		boolean flagExt = false;
		boolean flagNutrient = false;
		boolean flagExpectDt = false;
		boolean flagRoman = false;
		boolean flagDisplay = false;
		// newProductVO.getImageAttVO().setChangeRomanceCopy(true);
		// newProductVO.getImageAttVO().setChangeDisplayName(true);
		if (!CPSHelper.checkEqualValue(newProductVO.getImageAttVO()
				.getRomanceCopy(), savedProductVO.getImageAttVO()
				.getRomanceCopy())) {
			flagRoman = true;
			newProductVO.getImageAttVO().setChangeRomanceCopy(true);
		}
		if (!CPSHelper.checkEqualValue(newProductVO.getImageAttVO()
				.getDisplayName(), savedProductVO.getImageAttVO()
				.getDisplayName())) {
			flagDisplay = true;
			newProductVO.getImageAttVO().setChangeDisplayName(true);
		}

		if (!CPSHelper.checkEqualValue(newProductVO.getImageAttVO()
				.getImageExpectDt(), savedProductVO.getImageAttVO()
				.getImageExpectDt())) {
			// flag = true;
			flagExpectDt = true;
			newProductVO.getImageAttVO().setChangeImageExpectDt(true);
		}
		if (newProductVO.getImageAttVO().getExtendAttrWrapper() != null
				&& newProductVO.getImageAttVO().getExtendAttrWrapper()
						.getDynamicExtention() != null) {
			flagExt = updateFlagChange(newProductVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention(),
					savedProductVO.getImageAttVO().getExtendAttrWrapper()
							.getDynamicExtention());
		}
		if (newProductVO.getImageAttVO().getBrick() != null) {
			flagBrick = updateFlagChange(newProductVO.getImageAttVO()
					.getBrick(), savedProductVO.getImageAttVO().getBrick());
		}
		if (newProductVO.getImageAttVO().getNutriInfoVO() != null) {
			flagNutrient = updateFlagChangeNitrient(newProductVO
					.getImageAttVO().getNutriInfoVO(), savedProductVO
					.getImageAttVO().getNutriInfoVO());
		}
		// return flag || flagExpectDt || flagBrick || flagExt || flagNutrient;
		return flagExpectDt || flagBrick || flagExt || flagNutrient
				|| flagRoman || flagDisplay;
	}

	public static boolean isMadatoryFieldImageAttribute(
			ImageAttributeVO imageAttributeVO) {
		boolean flag = false;
		if (imageAttributeVO.getExtendAttrWrapper() != null
				&& imageAttributeVO.getExtendAttrWrapper()
						.getDynamicExtention() != null) {
			for (AttrVO atrVO : imageAttributeVO.getExtendAttrWrapper()
					.getDynamicExtention().getExtendAttrVO().getLstSingle()) {
				if (atrVO.isChanged() && atrVO.isRequired()
						&& CPSHelper.isEmpty(atrVO.getAttrValTxt())) {
					flag = true;
					break;
				}
			}
			for (GroupAttrVO groupAttrVO : imageAttributeVO
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO.getComponentType() != null
						&& CPSConstant.SINGLE_ENTY_VALUE.equals(groupAttrVO
								.getComponentType())) {
					for (AttrVO atrVO : groupAttrVO.getLstAttr()) {
						if (atrVO.isChanged() && atrVO.isRequired()
								&& CPSHelper.isEmpty(atrVO.getAttrValTxt())) {
							flag = true;
							break;
						}
					}
				}

			}
		}
		if (imageAttributeVO.getBrick() != null) {
			for (AttrVO atrVO : imageAttributeVO.getBrick().getExtendAttrVO()
					.getLstSingle()) {
				if (atrVO.isChanged() && atrVO.isRequired()
						&& CPSHelper.isEmpty(atrVO.getAttrValTxt())) {
					flag = true;
					break;
				}
			}
			for (GroupAttrVO groupAttrVO : imageAttributeVO.getBrick()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO.getComponentType() != null
						&& CPSConstant.SINGLE_ENTY_VALUE.equals(groupAttrVO
								.getComponentType())) {
					for (AttrVO atrVO : groupAttrVO.getLstAttr()) {
						if (atrVO.isChanged() && atrVO.isRequired()
								&& CPSHelper.isEmpty(atrVO.getAttrValTxt())) {
							flag = true;
							break;
						}
					}
				}

			}
		}
		return flag;
	}

	private static boolean updateFlagChange(
			DynamicExtentionAttributeVO newDynamicExtentionAttributeVO,
			DynamicExtentionAttributeVO savedDynamicExtentionAttributeVO) {
		boolean flag = false;
		for (AttrVO newAttrVO : newDynamicExtentionAttributeVO
				.getExtendAttrVO().getLstSingle()) {
			for (AttrVO savedAttrVO : savedDynamicExtentionAttributeVO
					.getExtendAttrVO().getLstSingle()) {
				if (newAttrVO.getAttrId().equals(savedAttrVO.getAttrId())) {
					newAttrVO.setAttrValTxt(StringEscapeUtils
							.unescapeHtml(newAttrVO.getAttrValTxt()));
					newAttrVO.setAttrCd(StringEscapeUtils
							.unescapeHtml(newAttrVO.getAttrCd()));
					if (!CPSHelper.checkEqualValue(newAttrVO.getAttrValTxt(),
							savedAttrVO.getAttrValTxt())) {
						newAttrVO.setChanged(true);
						flag = true;
					}
					if (newAttrVO.isLoaded()) {
						newAttrVO.setChanged(true);
						flag = true;
					}
					break;
				}
			}
		}

		for (GroupAttrVO newGroupAttrVO : newDynamicExtentionAttributeVO
				.getExtendAttrVO().getLstGrp()) {
			if (newGroupAttrVO.getComponentType() != null
					&& newGroupAttrVO.getComponentType().equals(
							CPSConstant.MULTI_ENTY_VALUE)) {
				for (GroupAttrVO savedGroupAttrVO : savedDynamicExtentionAttributeVO
						.getExtendAttrVO().getLstGrp()) {
					if (newGroupAttrVO.getGroupId().equals(
							savedGroupAttrVO.getGroupId())) {
						newGroupAttrVO.setJsonDataUpdate(StringEscapeUtils
								.unescapeHtml(newGroupAttrVO
										.getJsonDataUpdate()));
						if (!CPSHelper.checkEqualValue(
								newGroupAttrVO.getJsonDataUpdate(),
								savedGroupAttrVO.getJsonDataUpdate())) {
							newGroupAttrVO.setChanged(true);
							flag = true;
						}
						if (newGroupAttrVO.isLoadedGrp()) {
							newGroupAttrVO.setChanged(true);
							flag = true;
						}
						break;
					}
				}

			} else {
				for (GroupAttrVO savedGroupAttrVO : savedDynamicExtentionAttributeVO
						.getExtendAttrVO().getLstGrp()) {
					if (newGroupAttrVO.getGroupId().equals(
							savedGroupAttrVO.getGroupId())) {
						if (newGroupAttrVO.getLstAttr() != null
								&& newGroupAttrVO.getLstAttr().size() == 2) {
							newGroupAttrVO
									.getLstAttr()
									.get(0)
									.setAttrValTxt(
											StringEscapeUtils
													.unescapeHtml(newGroupAttrVO
															.getLstAttr()
															.get(0)
															.getAttrValTxt()));
							newGroupAttrVO
									.getLstAttr()
									.get(0)
									.setAttrCd(
											StringEscapeUtils
													.unescapeHtml(newGroupAttrVO
															.getLstAttr()
															.get(0).getAttrCd()));
							if (!CPSHelper.checkEqualValue(newGroupAttrVO
									.getLstAttr().get(0).getAttrValTxt(),
									savedGroupAttrVO.getLstAttr().get(0)
											.getAttrValTxt())) {
								newGroupAttrVO.setChanged(true);
								newGroupAttrVO.getLstAttr().get(0)
										.setChanged(true);
								flag = true;
							}
							newGroupAttrVO
									.getLstAttr()
									.get(1)
									.setAttrValTxt(
											StringEscapeUtils
													.unescapeHtml(newGroupAttrVO
															.getLstAttr()
															.get(1)
															.getAttrValTxt()));
							newGroupAttrVO
									.getLstAttr()
									.get(1)
									.setAttrCd(
											StringEscapeUtils
													.unescapeHtml(newGroupAttrVO
															.getLstAttr()
															.get(1).getAttrCd()));
							if (!CPSHelper.checkEqualValue(newGroupAttrVO
									.getLstAttr().get(1).getAttrValTxt(),
									savedGroupAttrVO.getLstAttr().get(1)
											.getAttrValTxt())) {
								newGroupAttrVO.setChanged(true);
								newGroupAttrVO.getLstAttr().get(1)
										.setChanged(true);
								flag = true;
							}
							if (newGroupAttrVO.isLoadedGrp()) {
								newGroupAttrVO.setChanged(true);
								newGroupAttrVO.getLstAttr().get(1)
										.setChanged(true);
								newGroupAttrVO.getLstAttr().get(0)
										.setChanged(true);
								flag = true;
							}
						}
						break;
					}
				}
			}
		}
		return flag;
	}

	public static void clearChangeDynamicAttr(ProductVO productVO,
			ProductVO saveProductVO) {
		clearChangeDynAttrExtTab(productVO, saveProductVO);
		clearChangeDynAttrBrickTab(productVO, saveProductVO);
	}

	public static void clearChangeDynAttrExtTab(ProductVO productVO,
			ProductVO saveProductVO) {
		if (productVO.getImageAttVO().getExtendAttrWrapper() != null
				&& productVO.getImageAttVO().getExtendAttrWrapper()
						.getDynamicExtention() != null) {
			for (AttrVO attrVO : productVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstSingle()) {
				if (attrVO != null) {
					attrVO.setChanged(false);
				}
			}
			for (GroupAttrVO groupAttrVO : productVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO != null) {
					groupAttrVO.setChanged(false);
					groupAttrVO.setJsonDataOri(groupAttrVO.getJsonDataUpdate());
					for (AttrVO attrVO : groupAttrVO.getLstAttr()) {
						if (attrVO != null) {
							attrVO.setChanged(false);
						}
					}
				}
			}
		}
		if (saveProductVO.getImageAttVO().getExtendAttrWrapper() != null
				&& saveProductVO.getImageAttVO().getExtendAttrWrapper()
						.getDynamicExtention() != null) {
			for (AttrVO attrVO : saveProductVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstSingle()) {
				if (attrVO != null) {
					attrVO.setAttrValTxt("");
				}
			}
			for (GroupAttrVO groupAttrVO : saveProductVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO != null) {
					for (AttrVO attrVO : groupAttrVO.getLstAttr()) {
						if (attrVO != null) {
							attrVO.setAttrValTxt("");
						}
					}
				}
			}
		}
	}

	public static void clearChangeDynAttrBrickTab(ProductVO productVO,
			ProductVO saveProductVO) {
		if (productVO.getImageAttVO().getBrick() != null) {
			for (AttrVO attrVO : productVO.getImageAttVO().getBrick()
					.getExtendAttrVO().getLstSingle()) {
				if (attrVO != null) {
					attrVO.setChanged(false);
				}
			}
			for (GroupAttrVO groupAttrVO : productVO.getImageAttVO().getBrick()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO != null) {
					groupAttrVO.setChanged(false);
					groupAttrVO.setJsonDataOri(groupAttrVO.getJsonDataUpdate());
					for (AttrVO attrVO : groupAttrVO.getLstAttr()) {
						if (attrVO != null) {
							attrVO.setChanged(false);
						}
					}
				}
			}
		}
		if (saveProductVO.getImageAttVO().getExtendAttrWrapper() != null
				&& saveProductVO.getImageAttVO().getExtendAttrWrapper()
						.getDynamicExtention() != null) {
			for (AttrVO attrVO : saveProductVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstSingle()) {
				if (attrVO != null) {
					attrVO.setAttrValTxt("");
				}
			}
			for (GroupAttrVO groupAttrVO : saveProductVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO != null) {
					for (AttrVO attrVO : groupAttrVO.getLstAttr()) {
						if (attrVO != null) {
							attrVO.setAttrValTxt("");
						}
					}
				}
			}
		}
	}

	public static void clearChangeDynAttrNutrtInfor(ProductVO productVO) {
		if (null != productVO.getImageAttVO().getNutriInfoVO()
				&& null != productVO.getImageAttVO().getNutriInfoVO()
						.getNutriBasicInfoVO()) {
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setFatMilkContentChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setDailyIntakeRefChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setHouseHoldSizeChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setNutriClaimChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setPreStateChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setServingSizeChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setUomChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setSrcSysId(CPSConstant.STRING_4);
		}

	}

	public static void clearChangeImageAttr(ProductVO productVO) {
		productVO.getImageAttVO().setChangeDisplayName(false);
		productVO.getImageAttVO().setChangeRomanceCopy(false);
		productVO.getImageAttVO().setChangeImageExpectDt(false);
		if (productVO.getImageAttVO().getExtendAttrWrapper() != null
				&& productVO.getImageAttVO().getExtendAttrWrapper()
						.getDynamicExtention() != null) {
			for (AttrVO attrVO : productVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstSingle()) {
				if (attrVO != null) {
					attrVO.setChanged(false);
					attrVO.setLoaded(false);
				}
			}
			for (GroupAttrVO groupAttrVO : productVO.getImageAttVO()
					.getExtendAttrWrapper().getDynamicExtention()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO != null) {
					groupAttrVO.setChanged(false);
					groupAttrVO.setJsonDataOri(groupAttrVO.getJsonDataUpdate());
					for (AttrVO attrVO : groupAttrVO.getLstAttr()) {
						if (attrVO != null) {
							attrVO.setChanged(false);
							attrVO.setLoaded(false);
						}
					}
				}
			}
		}
		if (productVO.getImageAttVO().getBrick() != null) {
			for (AttrVO attrVO : productVO.getImageAttVO().getBrick()
					.getExtendAttrVO().getLstSingle()) {
				if (attrVO != null) {
					attrVO.setChanged(false);
					attrVO.setLoaded(false);
				}
			}
			for (GroupAttrVO groupAttrVO : productVO.getImageAttVO().getBrick()
					.getExtendAttrVO().getLstGrp()) {
				if (groupAttrVO != null) {
					groupAttrVO.setChanged(false);
					groupAttrVO.setLoadedGrp(false);
					groupAttrVO.setJsonDataOri(groupAttrVO.getJsonDataUpdate());
					for (AttrVO attrVO : groupAttrVO.getLstAttr()) {
						if (attrVO != null) {
							attrVO.setChanged(false);
							attrVO.setLoaded(false);
						}
					}
				}
			}
		}
		if (productVO.getImageAttVO().getNutriInfoVO() != null) {
			boolean checkAsPre = false;
			if (CPSHelper.isNotEmpty(productVO.getImageAttVO().getNutriInfoVO()
					.getNutriBasicInfoVO().getProdValDes())) {
				checkAsPre = true;
			}
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setFatMilkContentChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setDailyIntakeRefChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setHouseHoldSizeChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setNutriClaimChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setPreStateChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setServingSizeChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setUomChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setSrcSysId(CPSConstant.STRING_4);
			if (productVO.getImageAttVO().getNutriInfoVO()
					.isNutritionDetailChanged()) {
				productVO.getImageAttVO().getNutriInfoVO()
						.setNutritionDetailChanged(false);
				if (CPSHelper.isNotEmpty(productVO.getImageAttVO()
						.getNutriInfoVO().getJsonNutriDataGrid())) {
					try {
						JSONArray jsonArrayUpdate = (JSONArray) new JSONParser()
								.parse(productVO.getImageAttVO()
										.getNutriInfoVO()
										.getJsonNutriDataGrid());
						JSONObject jsonObjectUpdate;
						List<NutritionDetailVO> lstNutriDetailVO = new ArrayList<NutritionDetailVO>();
						NutritionDetailVO nutriDetail = null;
						int key = 1;
						String nutritionIdStr;
						for (int i = 0; i < jsonArrayUpdate.size(); i++) {
							jsonObjectUpdate = (JSONObject) jsonArrayUpdate
									.get(i);
							if (!checkAsPre) {
								if ((!CPSHelper.getTrimmedValue(
										jsonObjectUpdate.get("dailyValuePre"))
										.equals("") && !CPSHelper
										.getTrimmedValue(
												jsonObjectUpdate
														.get("dailyValuePre"))
										.equals("-1"))
										|| (!CPSHelper
												.getTrimmedValue(
														jsonObjectUpdate
																.get("nutriQuantityPre"))
												.equals("") && !CPSHelper
												.getTrimmedValue(
														jsonObjectUpdate
																.get("nutriQuantityPre"))
												.equals("-1"))) {
									checkAsPre = true;
								}
							}
							if (CPSHelper.isNotEmpty(jsonObjectUpdate
									.get("nutritionId"))) {
								nutriDetail = new NutritionDetailVO();
								nutritionIdStr = CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutritionId"));
								if (CPSHelper.isNotEmpty(nutritionIdStr)) {
									nutriDetail.setNutritionId(CPSHelper
											.getIntegerValue(nutritionIdStr));
								}
								nutriDetail.setNutritionName(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutrientTypeTxt")));
								nutriDetail.setNutriQuantity(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutriQuantity")));
								nutriDetail.setNutriQuantityPre(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutriQuantityPre")));
								nutriDetail.setServingSizeUOMCD(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("servingSizeUOMCD")));
								nutriDetail.setServingSizeUOMCDAsPre(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("servingSizeUOMCDPre")));
								nutriDetail.setServingSizeUOMDesc(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("sizeUomTxt")));
								nutriDetail
										.setServingSizeUOMDescAsPre(CPSHelper
												.getTrimmedValue(jsonObjectUpdate
														.get("sizeUomTxtPre")));
								nutriDetail.setNutritionMeasr(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutritionMeasr")));
								nutriDetail.setDailyValue(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("dailyValuePac")));
								nutriDetail.setDailyValueAsPre(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("dailyValuePre")));
								nutriDetail.setIsOrContainer(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("isOrContainer")));
								nutriDetail
										.setServingSizeUOMDescAsPre(CPSHelper
												.getTrimmedValue(jsonObjectUpdate
														.get("sizeUomTxtPre")));
								nutriDetail.setChanged(false);
								nutriDetail.setKeyNutrition(key);
								nutriDetail.setRowUni(key);
								key++;
								lstNutriDetailVO.add(nutriDetail);
							} else {
								nutriDetail = new NutritionDetailVO();
								// nutriDetail.setNutritionId();
								nutriDetail.setNutritionName(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutrientTypeTxt")));
								nutriDetail.setNutriQuantity(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutriQuantity")));
								nutriDetail.setNutriQuantityPre(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutriQuantityPre")));
								nutriDetail.setServingSizeUOMCD(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("servingSizeUOMCD")));
								nutriDetail.setServingSizeUOMCDAsPre(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("servingSizeUOMCDPre")));
								nutriDetail.setServingSizeUOMDesc(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("sizeUomTxt")));
								nutriDetail
										.setServingSizeUOMDescAsPre(CPSHelper
												.getTrimmedValue(jsonObjectUpdate
														.get("sizeUomTxtPre")));
								nutriDetail.setNutritionMeasr(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("nutritionMeasr")));
								nutriDetail.setDailyValue(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("dailyValuePac")));
								nutriDetail.setDailyValueAsPre(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("dailyValuePre")));
								nutriDetail.setIsOrContainer(CPSHelper
										.getTrimmedValue(jsonObjectUpdate
												.get("isOrContainer")));
								nutriDetail
										.setServingSizeUOMDescAsPre(CPSHelper
												.getTrimmedValue(jsonObjectUpdate
														.get("sizeUomTxtPre")));
								nutriDetail.setRowUni(key);
								key++;
								lstNutriDetailVO.add(nutriDetail);
							}
						}
						productVO.getImageAttVO().getNutriInfoVO()
								.setLstNutriDatagrid(lstNutriDetailVO);
						productVO.getImageAttVO().getNutriInfoVO()
								.getNutriBasicInfoVO()
								.setChBoxAsPre(checkAsPre);
						productVO
								.getImageAttVO()
								.getNutriInfoVO()
								.setJsonNutriDataGrid(
										ExtendAndBrickAttrHelper
												.buildDataNutritionDetaiToJson(productVO
														.getImageAttVO()
														.getNutriInfoVO()
														.getLstNutriDatagrid()));
						if (CPSHelper.isNotEmpty(lstNutriDetailVO)) {
							productVO
									.getImageAttVO()
									.getNutriInfoVO()
									.setMaxNutrientDetails(
											lstNutriDetailVO.size() + 1);
						} else {
							productVO
									.getImageAttVO()
									.getNutriInfoVO()
									.setMaxNutrientDetails(
											CPSConstant.NUMBER_ONE);
						}
					} catch (org.json.simple.parser.ParseException e) {
						LOG.error(e.getMessage(), e);
					}
				} else {
					productVO
							.getImageAttVO()
							.getNutriInfoVO()
							.setLstNutriDatagrid(
									new ArrayList<NutritionDetailVO>());
					productVO.getImageAttVO().getNutriInfoVO()
							.setMaxNutrientDetails(CPSConstant.NUMBER_ONE);
				}
			}
			productVO
					.getImageAttVO()
					.getNutriInfoVO()
					.getNutriBasicInfoVO()
					.setNutriClaimOris(
							productVO.getImageAttVO().getNutriInfoVO()
									.getNutriBasicInfoVO().getNutriClaims());
			try {
				productVO.getImageAttVO().setNutriInfoVOOrigin(
						(NutritionInfoVO) SerializationUtils.clone(productVO
								.getImageAttVO().getNutriInfoVO()));
			} catch (SerializationException e) {
				LOG.error(e.getMessage(), e);
			}
			// alwaysSetDisplayName
			ImageAttriVOHelper.alwaysSetDisplayName(productVO.getImageAttVO());
		}
	}

	public static void removeNutrienImageAttr(ProductVO productVO) {
		if (productVO.getImageAttVO().getNutriInfoVO() != null) {
			productVO.getImageAttVO().getNutriInfoVO()
					.setNutriBasicInfoVO(new NutritionBasicInfoVO());
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setFatMilkContentChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setDailyIntakeRefChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setHouseHoldSizeChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setNutriClaimChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setPreStateChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setServingSizeChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setUomChanged(false);
			// productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO().setSrcSysId(CPSConstant.STRING_4);
			// if
			// (productVO.getImageAttVO().getNutriInfoVO().isNutritionDetailChanged())
			// {
			productVO.getImageAttVO().getNutriInfoVO()
					.setNutritionDetailChanged(false);
			productVO.getImageAttVO().getNutriInfoVO().setJsonNutriDataGrid("");
			// if
			// (CPSHelper.isNotEmpty(productVO.getImageAttVO().getNutriInfoVO().getJsonNutriDataGrid()))
			// {
			// try {
			// JSONArray jsonArrayUpdate = (JSONArray) new
			// JSONParser().parse(productVO.getImageAttVO().getNutriInfoVO().getJsonNutriDataGrid());
			// JSONObject jsonObjectUpdate;
			// List<NutritionDetailVO> lstNutriDetailVO = new
			// ArrayList<NutritionDetailVO>();
			// NutritionDetailVO nutriDetail = null;
			// int key = 1;
			// String nutritionIdStr;
			// for (int i = 0; i < jsonArrayUpdate.size(); i++) {
			// jsonObjectUpdate = (JSONObject) jsonArrayUpdate.get(i);
			// if (CPSHelper.isNotEmpty(jsonObjectUpdate.get("nutritionId"))) {
			// nutriDetail = new NutritionDetailVO();
			// nutritionIdStr =
			// CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutritionId"));
			// if(CPSHelper.isNotEmpty(nutritionIdStr)){
			// nutriDetail.setNutritionId(CPSHelper.getIntegerValue(nutritionIdStr));
			// }
			// nutriDetail.setNutritionName(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutrientTypeTxt")));
			// nutriDetail.setNutriQuantity(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutriQuantity")));
			// nutriDetail.setServingSizeUOMCD(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("servingSizeUOMCD")));
			// nutriDetail.setServingSizeUOMDesc(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("sizeUomTxt")));
			// nutriDetail.setNutritionMeasr(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutritionMeasr")));
			// nutriDetail.setDailyValue(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("dailyValue")));
			// nutriDetail.setIsOrContainer(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("isOrContainer")));
			// nutriDetail.setChanged(false);
			// nutriDetail.setKeyNutrition(key);
			// key++;
			// lstNutriDetailVO.add(nutriDetail);
			// } else {
			// nutriDetail = new NutritionDetailVO();
			// // nutriDetail.setNutritionId();
			// nutriDetail.setNutritionName(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutrientTypeTxt")));
			// nutriDetail.setNutriQuantity(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutriQuantity")));
			// nutriDetail.setServingSizeUOMCD(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("servingSizeUOMCD")));
			// nutriDetail.setServingSizeUOMDesc(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("sizeUomTxt")));
			// nutriDetail.setNutritionMeasr(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("nutritionMeasr")));
			// nutriDetail.setDailyValue(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("dailyValue")));
			// nutriDetail.setIsOrContainer(CPSHelper.getTrimmedValue(jsonObjectUpdate.get("isOrContainer")));
			// nutriDetail.setChanged(false);
			// nutriDetail.setKeyNutrition(key);
			// key++;
			// lstNutriDetailVO.add(nutriDetail);
			// }
			// }
			// productVO.getImageAttVO().getNutriInfoVO().setLstNutriDatagrid(lstNutriDetailVO);
			// productVO.getImageAttVO().getNutriInfoVO()
			// .setJsonNutriDataGrid(ExtendAndBrickAttrHelper.buildDataNutritionDetaiToJson(productVO.getImageAttVO().getNutriInfoVO().getLstNutriDatagrid()));
			// if (CPSHelper.isNotEmpty(lstNutriDetailVO)) {
			// productVO.getImageAttVO().getNutriInfoVO().setMaxNutrientDetails(lstNutriDetailVO.size()
			// + 1);
			// } else {
			// productVO.getImageAttVO().getNutriInfoVO().setMaxNutrientDetails(CPSConstant.NUMBER_ONE);
			// }
			// } catch (org.json.simple.parser.ParseException e) {
			// LOG.error(e.getMessage(), e);
			// }
			// } else {
			productVO.getImageAttVO().getNutriInfoVO()
					.setLstNutriDatagrid(new ArrayList<NutritionDetailVO>());
			productVO.getImageAttVO().getNutriInfoVO()
					.setMaxNutrientDetails(CPSConstant.NUMBER_ONE);
			// }
			// }
			productVO.getImageAttVO().getNutriInfoVO().getNutriBasicInfoVO()
					.setNutriClaimOris("");
			try {
				productVO.getImageAttVO().setNutriInfoVOOrigin(
						(NutritionInfoVO) SerializationUtils.clone(productVO
								.getImageAttVO().getNutriInfoVO()));
			} catch (SerializationException e) {
				LOG.error(e.getMessage(), e);
			}
		}
	}

	private static boolean updateFlagChangeNitrient(
			NutritionInfoVO nutritionInfoVO, NutritionInfoVO nutritionInfoVOOri) {
		boolean flag = false;
		if (nutritionInfoVO != null) {

			if (CPSHelper.isNotEmpty(nutritionInfoVO.getJsonNutriDataGrid())) {
				nutritionInfoVO.setJsonNutriDataGrid(StringEscapeUtils
						.unescapeHtml(nutritionInfoVO.getJsonNutriDataGrid()));
			}
			if (nutritionInfoVO.getNutriBasicInfoVO() != null) {
				// if
				// (!CPSHelper.checkEqualValue(nutritionInfoVO.getNutriBasicInfoVO().getNutriClaims(),
				// nutritionInfoVOOri.getNutriBasicInfoVO().getNutriClaims())) {
				// nutritionInfoVO.getNutriBasicInfoVO().setNutriClaimChanged(true);
				// nutritionInfoVO.getNutriBasicInfoVO().setNutriClaimOris(nutritionInfoVOOri.getNutriBasicInfoVO().getNutriClaims());
				// flag = true;
				// }
				if (!CPSHelper.checkEqualValue(nutritionInfoVO
						.getNutriBasicInfoVO().getServingSize(),
						nutritionInfoVOOri.getNutriBasicInfoVO()
								.getServingSize())) {
					nutritionInfoVO.getNutriBasicInfoVO().setServingSize(
							StringEscapeUtils.unescapeHtml(nutritionInfoVO
									.getNutriBasicInfoVO().getServingSize()));
					nutritionInfoVO.getNutriBasicInfoVO()
							.setServingSizeChanged(true);
					flag = true;
				}
				if (!CPSHelper.checkEqualValue(nutritionInfoVO
						.getNutriBasicInfoVO().getServingSizeUOMCD(),
						nutritionInfoVOOri.getNutriBasicInfoVO()
								.getServingSizeUOMCD())) {
					nutritionInfoVO.getNutriBasicInfoVO().setUomChanged(true);
					flag = true;
				}
				if (!CPSHelper.checkEqualValue(nutritionInfoVO
						.getNutriBasicInfoVO().getHouseHoldSize(),
						nutritionInfoVOOri.getNutriBasicInfoVO()
								.getHouseHoldSize())) {
					nutritionInfoVO.getNutriBasicInfoVO()
							.setHouseHoldSizeChanged(true);
					flag = true;
				}
				if (!CPSHelper.checkEqualValue(nutritionInfoVO
						.getNutriBasicInfoVO().getPreState(),
						nutritionInfoVOOri.getNutriBasicInfoVO().getPreState())) {
					nutritionInfoVO.getNutriBasicInfoVO().setPreStateChanged(
							true);
					flag = true;
				}
				if (!CPSHelper.checkEqualValue(nutritionInfoVO
						.getNutriBasicInfoVO().getDailyIntakeRef(),
						nutritionInfoVOOri.getNutriBasicInfoVO()
								.getDailyIntakeRef())) {
					nutritionInfoVO.getNutriBasicInfoVO()
							.setDailyIntakeRefChanged(true);
					flag = true;
				}
				if (!CPSHelper.checkEqualValue(nutritionInfoVO
						.getNutriBasicInfoVO().getFatMilkContent(),
						nutritionInfoVOOri.getNutriBasicInfoVO()
								.getFatMilkContent())) {
					nutritionInfoVO.getNutriBasicInfoVO()
							.setFatMilkContentChanged(true);
					flag = true;
				}
				if (CPSHelper
						.isNotEmpty(nutritionInfoVO.getJsonNutriDataGrid())
						&& CPSHelper.isNotEmpty(nutritionInfoVOOri
								.getLstNutriDatagrid())) {
					if (!nutritionInfoVO
							.getNutriBasicInfoVO()
							.getSrcSysId()
							.equals(nutritionInfoVOOri.getNutriBasicInfoVO()
									.getSrcSysId())) {
						nutritionInfoVO.setNutritionDetailChanged(true);
						flag = true;
					}

					if (nutritionInfoVO.getJsonNutriDataGrid().indexOf(
							"\"changed\":true") > 0) {
						nutritionInfoVO.setNutritionDetailChanged(true);
						flag = true;
					} else {
						try {
							boolean flagExist = false;
							JSONArray jsonArrayUpdate = (JSONArray) new JSONParser()
									.parse(nutritionInfoVO
											.getJsonNutriDataGrid());
							JSONObject jsonObjectUpdate;
							for (NutritionDetailVO nutritionDetailVO : nutritionInfoVOOri
									.getLstNutriDatagrid()) {
								flagExist = false;
								for (int i = 0; i < jsonArrayUpdate.size(); i++) {
									jsonObjectUpdate = (JSONObject) jsonArrayUpdate
											.get(i);
									if (CPSHelper.isNotEmpty(String
											.valueOf(jsonObjectUpdate
													.get("nutritionId")))) {
										if (Integer.valueOf(
												String.valueOf(jsonObjectUpdate
														.get("nutritionId")))
												.equals(nutritionDetailVO
														.getNutritionId())) {
											flagExist = true;
											break;
										}
									} else {
										if (CPSHelper.isEmpty(nutritionDetailVO
												.getNutritionId())) {
											flagExist = true;
											break;
										}
									}

								}
								if (!flagExist) {
									nutritionInfoVO
											.setNutritionDetailChanged(true);
									flag = true;
									break;
								}
							}
						} catch (org.json.simple.parser.ParseException e) {
							LOG.error(e.getMessage(), e);
						}
					}
				} else if (CPSHelper.isNotEmpty(nutritionInfoVO
						.getJsonNutriDataGrid())) {
					nutritionInfoVO.setNutritionDetailChanged(true);
					flag = true;
				} else if (CPSHelper.isNotEmpty(nutritionInfoVOOri
						.getLstNutriDatagrid())) {
					nutritionInfoVO.setNutritionDetailChanged(true);
					flag = true;
				}

			}
		}
		return flag;
	}
}
