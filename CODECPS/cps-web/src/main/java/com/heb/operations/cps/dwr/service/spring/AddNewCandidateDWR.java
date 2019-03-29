package com.heb.operations.cps.dwr.service.spring;

import com.heb.jaf.security.UserInfo;
import com.heb.operations.business.framework.exeption.CPSBusinessException;
import com.heb.operations.business.framework.exeption.CPSGeneralException;
import com.heb.operations.business.framework.exeption.CPSMessage;
import com.heb.operations.business.framework.exeption.CPSMessage.ErrorSeverity;
import com.heb.operations.business.framework.exeption.CPSSystemException;
import com.heb.operations.business.framework.vo.*;
import com.heb.operations.cps.batchUpload.BatchUpLoad;
import com.heb.operations.cps.database.entities.PdNisCntlTab;
import com.heb.operations.cps.ejb.vo.CodeDescVO;
import com.heb.operations.cps.ejb.webservice.WarehouseService.GetWarehouseListByVendor_Request.VendorList;
import com.heb.operations.cps.model.AddNewCandidate;
import com.heb.operations.cps.util.*;
import com.heb.operations.cps.vo.*;
import com.heb.operations.cps.vo.ImageAttribute.ImageAttriVOHelper;
import com.heb.operations.cps.vo.ImageAttribute.NutritionInfoVO;
import com.heb.operations.ui.framework.dwr.custom.SpringFormCorrelatedService;
import com.heb.operations.ui.framework.exception.CPSWebException;
import org.apache.log4j.Logger;
import org.directwebremoting.WebContextFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.*;

@SpringFormCorrelatedService(formName= AddNewCandidate.FORM_NAME)
public class AddNewCandidateDWR extends ProductClassificationDWR {

	private static final Logger LOG = Logger.getLogger(AddNewCandidateDWR.class);

	@SuppressWarnings("unused")
	private static final String CPS_INDEX_BEAN = "CPSIndexBean";

	public static final String NO_DESCRIPTION = "Not Existing -Please Add";

	public static final String ERR_VENDOR_LIST = "Error in get Vendor Location  list";

	private static final String STRING_706 = "706";

	private static final String ERROR_MORPH = "A/P Vendor does not exist for the WHS.";

	private static final String MORPH = "MORPH";

	private static final String NO_MORPHING = "no_morphing";

	private static final String STRING_1 = "1";

	private static final String STRING_101 = "101";

	private static final String ERROR_101 = "Please select a Vendor authorized to WHS 101.";

	@Override
	protected AddNewCandidate getForm() {
		return (AddNewCandidate) this.getForm(AddNewCandidate.FORM_NAME);
	}

	/**
	 *
	 * @return UPCVO
	 */
	public UPCVO getPLU() {
		ProductVO productVO = this.getForm().getProductVO();
		UPCVO pluUPC = null;
		if (productVO != null) {
			List<UPCVO> upcs = productVO.getUpcVO();
			for (UPCVO upcvo : upcs) {
				if (upcvo.getUnitUpc().startsWith("002")
						&& upcvo.getUnitUpc().endsWith("00000")) {
					pluUPC = upcvo;
					break;
				}
			}
		}
		return pluUPC;
	}

	public String getProductDescription() {
		String productDesc = EMPTY_STRING;
		if (this.getForm().getProductVO() != null
				&& this.getForm().getProductVO().getClassificationVO() != null
				&& this.getForm().getProductVO().getClassificationVO()
						.getProdDescritpion() != null) {
			productDesc = this.getForm().getProductVO().getClassificationVO()
					.getProdDescritpion().toUpperCase();
		}
		return productDesc;
	}

	public List<BaseJSFVO> getMerchandizeForProductType(String prodType)
			throws CPSWebException {
		List<BaseJSFVO> ret = new ArrayList<BaseJSFVO>();
		List<BaseJSFVO> values = CommonBridge.getCommonServiceInstance()
				.getProductTypeChildren(prodType);
		ret.addAll(values);
		this.getForm().setMerchandizingTypes(ret);
		return ret;

	}

	public CaseVO getCaseVO() {
		return new CaseVO();
	}

	private String getChannel(final String merch) {
		String channel = EMPTY_STRING;
		if ("Rental".equalsIgnoreCase(merch)
				|| "Cross Dock".equalsIgnoreCase(merch)) {
			channel = "WHSE.";
		} else if ("Wrap".equalsIgnoreCase(merch)
				|| "Coupon".equalsIgnoreCase(merch)
				|| "Tax".equalsIgnoreCase(merch)
				|| "Freight".equalsIgnoreCase(merch)) {
			channel = "DSD.";
		} else {
			channel = "DSD or WHSE or BOTH.";
		}
		return channel;
	}

	/**
	 * Following validation needs to happen on selecting a case. Whenever the
	 * below condition is not met an error message should be displayed RNTL =
	 * Whse WRAP = DSD INGRD = DSD DSPLAY = Whse CPN = DSD PRMO = Whse SHPR =
	 * Whse SUPPLY = DSD,Whse,Both XDOCK = DSD BASIC = DSD,Whse,Both FREIGHT =
	 * DSD TAX = DSD
	 *
	 * @param caseVO
	 * @throws CPSGeneralException
	 */
	private void validateCase(CaseVO caseVO) throws Exception {
		final String channel = caseVO.getChannelVal();
		final String merch = this.getForm().getProductVO()
				.getClassificationVO().getMerchandizeName();
		final String msg = "Invalid Channel type for the selected merchandise type. ";
		if (CPSConstants.CHANNEL_WHS.equalsIgnoreCase(channel)) {
			if (!("Rental".equalsIgnoreCase(merch)
					|| "Ingredient".equalsIgnoreCase(merch)
					|| "Display".equalsIgnoreCase(merch)
					|| "Promo".equalsIgnoreCase(merch)
					|| "Shipper".equalsIgnoreCase(merch)
					|| "Supply".equalsIgnoreCase(merch)
					|| "Sell".equalsIgnoreCase(merch)
					|| "Cross Dock".equalsIgnoreCase(merch) || "Basic"
						.equalsIgnoreCase(merch))) {
				StringBuffer message = new StringBuffer(msg)
						.append("\nFor selected merchandise ").append(merch)
						.append(", valid channel is ")
						.append(this.getChannel(merch));
				throw new Exception(message.toString());
			}
		} else if (CPSConstants.CHANNEL_DSD.equalsIgnoreCase(channel)) {
			if (!("Wrap".equalsIgnoreCase(merch)
					|| "Ingredient".equalsIgnoreCase(merch)
					|| "Display".equalsIgnoreCase(merch)
					|| "Coupon".equalsIgnoreCase(merch)
					|| "Promo".equalsIgnoreCase(merch)
					|| "Shipper".equalsIgnoreCase(merch)
					|| "Supply".equalsIgnoreCase(merch)
					|| "Sell".equalsIgnoreCase(merch)
					|| "Basic".equalsIgnoreCase(merch)
					|| "Tax".equalsIgnoreCase(merch) || "Freight"
						.equalsIgnoreCase(merch))) {
				StringBuffer message = new StringBuffer(msg)
						.append("\nFor selected merchandise ").append(merch)
						.append(", valid channel is ")
						.append(this.getChannel(merch));
				throw new Exception(message.toString());
			}
		} else if (CPSConstants.CHANNEL_BOTH.equalsIgnoreCase(channel)) {
			if (!("Display".equalsIgnoreCase(merch)
					|| "Promo".equalsIgnoreCase(merch)
					|| "Shipper".equalsIgnoreCase(merch)
					|| "Supply".equalsIgnoreCase(merch)
					|| "Sell".equalsIgnoreCase(merch)
					|| "Basic".equalsIgnoreCase(merch) || "Ingredient"
						.equalsIgnoreCase(merch))) {
				StringBuffer message = new StringBuffer(msg)
						.append("\nFor selected merchandise ").append(merch)
						.append(", valid channel is ")
						.append(this.getChannel(merch));
				throw new Exception(message.toString());
			}
		}
	}

	public CaseVO addCaseVO(CaseVO caseVO) throws CPSGeneralException,
			Exception {
		this.initCaseVOUpcs(caseVO);
		this.fillAllUPCValues(caseVO);
		// resetCaseUPCNewData(caseVO);

		/* Activation fields setting */
		caseVO.setMerchandizeType(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getMerchandizeType()));
		caseVO.setCommodityCode(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getCommodity()));
		caseVO.setSubCommodityCode(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getSubCommodity()));
		caseVO.setPssDept(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getPointOfSaleVO().getPssDept()));
		caseVO.setClassCode(this.getForm().getProductVO().getClassificationVO()
				.getClassField());
		ClassCommodityVO classComVO = this.getForm().getClassCommodityVO(
				CPSHelper.getTrimmedValue(this.getForm().getProductVO()
						.getClassificationVO().getCommodity()));
		if (null != classComVO) {
			caseVO.setDeptId(CPSHelper.getTrimmedValue(classComVO.getDeptId()));
			caseVO.setSubDeptId(CPSHelper.getTrimmedValue(classComVO
					.getSubDeptId()));
		}
		// Fix DepositSw
		if (CPSHelper.isNotEmpty(this.getForm().getProductVO()
				.getPointOfSaleVO().getDepositUPC())) {
			caseVO.setDepositSw(CPSConstant.CHAR_Y);
		} else {
			caseVO.setDepositSw(CPSConstant.CHAR_N);
		}
		// End Fix DepositSw
		this.validateCase(caseVO);
		/*
		 * Create a new work request when work request is empty
		 */
		CaseVO retCaseVO = new CaseVO();
		if (CPSHelper.isEmpty(this.getForm().getProductVO().getPsProdId())
				|| (this.getForm().getProductVO().getPsProdId() == 0)) {
			throw new CPSBusinessException(new CPSMessage(
					"Please create candidate before save case",
					ErrorSeverity.ERROR));
		} else {
			if (CPSHelper.isEmpty(this.getForm().getProductVO()
					.getWorkRequest().getWorkIdentifier())) {
				this.getForm()
						.getProductVO()
						.getWorkRequest()
						.setStatChangeReasonId(
								BusinessConstants.WORK_STATUS_CHANGE_REASON);
				WorkRequest wr = CommonBridge
						.getAddNewCandidateServiceInstance().insertWorkRequest(
								this.getForm().getProductVO());
				if (CPSHelper.isNotEmpty(wr)) {
					this.getForm().getProductVO().setWorkRequest(wr);
				}
			}
			retCaseVO = CommonBridge.getAddNewCandidateServiceInstance()
					.insertCaseToProduct(this.getForm().getProductVO(), caseVO,
							this.getForm().getQuestionnarieVO());
			retCaseVO.setCodeDate(caseVO.isCodeDate());
			retCaseVO.setChannel(caseVO.getChannel());
			retCaseVO.setCaseChkDigit(String.valueOf(CPSHelper.calculateCheckDigit(caseVO
					.getCaseUPC())));
			if (retCaseVO.getNewDataSw() == CPSConstant.CHAR_Y) {
				retCaseVO.setCaseViewOverride(false);
			}

			String uniqId = CPSHelper.getUniqueId(caseVO);
			retCaseVO.setUniqueId(uniqId);
			retCaseVO.setWorkRequest(this.getForm().getProductVO()
					.getWorkRequest());
			this.getForm().getProductVO()
					.setCaseVO(retCaseVO.getUniqueId(), retCaseVO);

			return retCaseVO;
			/*
			 * if("DSD".equalsIgnoreCase(retCaseVO.getChannelVal())){
			 * retCaseVO.setPurchaseStatus("A"); }
			 */
		}
	}

	public CaseVO addCaseVOForMorph(CaseVO caseVO) throws CPSGeneralException,
			Exception {
		// this.initCaseVOUpcs(caseVO);
		this.fillAllUPCValues(caseVO);
		// resetCaseUPCNewData(caseVO);

		/* Activation fields setting */
		caseVO.setMerchandizeType(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getMerchandizeType()));
		caseVO.setCommodityCode(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getCommodity()));
		caseVO.setSubCommodityCode(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getSubCommodity()));
		caseVO.setPssDept(CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getPointOfSaleVO().getPssDept()));
		caseVO.setClassCode(this.getForm().getProductVO().getClassificationVO()
				.getClassField());
		ClassCommodityVO classComVO = this.getForm().getClassCommodityVO(
				CPSHelper.getTrimmedValue(this.getForm().getProductVO()
						.getClassificationVO().getCommodity()));
		if (null != classComVO) {
			caseVO.setDeptId(CPSHelper.getTrimmedValue(classComVO.getDeptId()));
			caseVO.setSubDeptId(CPSHelper.getTrimmedValue(classComVO
					.getSubDeptId()));
		}
		// Fix DepositSw
		if (CPSHelper.isNotEmpty(this.getForm().getProductVO()
				.getPointOfSaleVO().getDepositUPC())) {
			caseVO.setDepositSw(CPSConstant.CHAR_Y);
		} else {
			caseVO.setDepositSw(CPSConstant.CHAR_N);
		}
		// End Fix DepositSw
		this.validateCase(caseVO);
		/*
		 * Create a new work request when work request is empty
		 */
		CaseVO retCaseVO = new CaseVO();
		if (CPSHelper.isEmpty(this.getForm().getProductVO().getPsProdId())
				|| (this.getForm().getProductVO().getPsProdId() == 0)) {
			throw new CPSBusinessException(new CPSMessage(
					"Please create candidate before save case",
					ErrorSeverity.ERROR));
		} else {
			if (CPSHelper.isEmpty(this.getForm().getProductVO()
					.getWorkRequest().getWorkIdentifier())) {
				this.getForm()
						.getProductVO()
						.getWorkRequest()
						.setStatChangeReasonId(
								BusinessConstants.WORK_STATUS_CHANGE_REASON);
				WorkRequest wr = CommonBridge
						.getAddNewCandidateServiceInstance().insertWorkRequest(
								this.getForm().getProductVO());
				if (CPSHelper.isNotEmpty(wr)) {
					this.getForm().getProductVO().setWorkRequest(wr);
				}
			}
			retCaseVO = CommonBridge.getAddNewCandidateServiceInstance()
					.insertCaseToProduct(this.getForm().getProductVO(), caseVO,
							this.getForm().getQuestionnarieVO());
			retCaseVO.setCodeDate(caseVO.isCodeDate());
			retCaseVO.setChannel(caseVO.getChannel());
			retCaseVO.setCaseChkDigit(String.valueOf(CPSHelper.calculateCheckDigit(caseVO
					.getCaseUPC())));
			if (retCaseVO.getNewDataSw() == CPSConstant.CHAR_Y) {
				retCaseVO.setCaseViewOverride(false);
			}
			String uniqId = CPSHelper.getUniqueId(caseVO);
			retCaseVO.setUniqueId(uniqId);
			retCaseVO.setWorkRequest(this.getForm().getProductVO()
					.getWorkRequest());
			this.getForm().getProductVO()
					.setCaseVO(retCaseVO.getUniqueId(), retCaseVO);
			return retCaseVO;
			/*
			 * if("DSD".equalsIgnoreCase(retCaseVO.getChannelVal())){
			 * retCaseVO.setPurchaseStatus("A"); }
			 */
		}
	}

	@SuppressWarnings("unused")
	private void copyCaseUPCToCaseUPC(CaseVO from, CaseVO to) {
		List<CaseUPCVO> vosFrom = from.getCaseUPCVOs();
		List<CaseUPCVO> vosTo = to.getCaseUPCVOs();
		for (CaseUPCVO upcVOTo : vosTo) {
			for (CaseUPCVO upcVOFrom : vosFrom) {
				if (upcVOFrom.getUnitUpc().equals(upcVOTo.getUnitUpc())) {
					upcVOFrom.setLinked(upcVOTo.isLinked());
					upcVOFrom.setWorkRequest(upcVOTo.getWorkRequest());
					upcVOFrom.setPrimary(upcVOTo.isPrimary());
					upcVOFrom.setSize(upcVOTo.getSize());
					upcVOFrom.setUnitMeasureCode(upcVOTo.getUnitMeasureCode());
					upcVOFrom.setUnitMeasureDesc(upcVOTo.getUnitMeasureDesc());
					upcVOFrom.setUpcType(upcVOTo.getUpcType());
					upcVOFrom.setSeqNumber(upcVOTo.getSeqNumber());
					upcVOFrom.setNewDataSw(upcVOTo.getNewDataSw());
				}
			}
		}
	}

	private void initCaseVOUpcs(CaseVO caseVO) {
		if (null != caseVO) {
			if (null != this.getForm().getCaseVO()) {
				List<CaseUPCVO> list = this.getForm().getCaseVO()
						.getCaseUPCVOs();
				for (CaseUPCVO caseUPCVO : list) {
					caseVO.addCaseUPCVO(caseUPCVO);
				}
			}
		}
	}

	private void fillAllUPCValues(CaseVO caseVO) {
		if (CPSHelper.isNotEmpty(caseVO)) {
			String upcs = caseVO.getUpcValues();
			String primaryUpc = caseVO.getPrimaryUpcUniqueId();
			if (CPSHelper.isNotEmpty(upcs)) {
				String[] upcArray = upcs.split(",");
				List<String> upcList = Arrays.asList(upcArray);
				List<CaseUPCVO> list = caseVO.getCaseUPCVOs();
				for (CaseUPCVO caseUPCVO : list) {
					String s = caseUPCVO.getUnitUpc();
					if (upcList.contains(s)) {
						caseUPCVO.setLinked(true);
						if (CPSHelper.isNotEmpty(primaryUpc)
								&& primaryUpc.trim().equals(
										caseUPCVO.getUnitUpc())) {
							caseUPCVO.setPrimary(true);
						} else {
							caseUPCVO.setPrimary(false);
						}
					} else {
						caseUPCVO.setLinked(false);
						caseUPCVO.setPrimary(false);
					}
				}
			} else {
				this.resetCaseUPCVO(caseVO);
			}
		}
	}

	private void resetCaseUPCVO(CaseVO caseVO) {
		List<CaseUPCVO> list = caseVO.getCaseUPCVOs();
		if (CPSHelper.isNotEmpty(list)) {
			for (CaseUPCVO caseUPCVO : list) {
				caseUPCVO.setLinked(false);
				caseUPCVO.setPrimary(false);
			}
		}
	}

	public boolean isExistingProductAndCase(String uniqueId) {
		AddNewCandidate addNewCandidate = this.getForm();
		ProductVO productVO = addNewCandidate.getProductVO();
		CaseVO caseVO = productVO.getCaseVO(uniqueId);
		boolean returnVal = false;
		returnVal = (productVO.getNewDataSw() == CPSConstant.CHAR_N && caseVO.getNewDataSw() == CPSConstant.CHAR_N);
		return returnVal;
	}

	private String getCube(final String height, final String width,
			final String length) {
		String strCube = EMPTY_STRING;
		if (CPSHelper.isNotEmpty(height) && CPSHelper.isNotEmpty(width)
				&& CPSHelper.isNotEmpty(length)) {
			Double dHeight = Double.valueOf(height);
			Double dWidth = Double.valueOf(width);
			Double dLength = Double.valueOf(length);
			double result = ((dHeight * dWidth * dLength) / 1728);
			double newres = Math.round(result * 100);
			result = newres / 100;
			if (result < 99999.99) {
				double zero = 0.0D;
				if (result == zero) {
					if (dHeight != zero && dWidth != zero && dLength != zero) {
						result = 0.001;
					}
				}
				strCube = String.valueOf(result);
			}
		}
		return strCube;
	}

	public CaseVO saveCaseVO(String uniqueId, CaseVO caseVO)
			throws CPSGeneralException {
		CaseVO newCaseVO = new CaseVO();
		CaseVO saveCaseVO = this.getExistingCaseVO(uniqueId);
		// reset WHS(DSDeDC) to WHS
		if (CPSHelper.isNotEmpty(saveCaseVO)) {
			if (CHANNEL_WHSDSD.equals(CPSHelper.getTrimmedValue(saveCaseVO
					.getChannel()))) {
				saveCaseVO.setChannel(CHANNEL_WHS);
			}
		}
		if (CPSHelper.isNotEmpty(caseVO)) {
			if (CHANNEL_WHSDSD.equals(CPSHelper.getTrimmedValue(caseVO
					.getChannel()))) {
				caseVO.setChannel(CHANNEL_WHS);
			}
		}

		String newMasterPack = caseVO.getMasterPack();
		String oldMasterPack = saveCaseVO.getMasterPack();

		if (CaseVOHelper.entitySaved(caseVO, saveCaseVO)) {
			this.copyCaseVOToCaseVO(saveCaseVO, caseVO);
			this.fillAllUPCValues(saveCaseVO);

			/* Activation fields setting */
			saveCaseVO.setMerchandizeType(CPSHelper.getTrimmedValue(this
					.getForm().getProductVO().getClassificationVO()
					.getMerchandizeType()));
			saveCaseVO.setCommodityCode(CPSHelper.getTrimmedValue(this
					.getForm().getProductVO().getClassificationVO()
					.getCommodity()));
			saveCaseVO.setSubCommodityCode(CPSHelper.getTrimmedValue(this
					.getForm().getProductVO().getClassificationVO()
					.getSubCommodity()));
			saveCaseVO.setClassCode(CPSHelper.getTrimmedValue(this.getForm()
					.getProductVO().getClassificationVO().getClassField()));
			saveCaseVO.setPssDept(CPSHelper.getTrimmedValue(this.getForm()
					.getProductVO().getPointOfSaleVO().getPssDept()));
			ClassCommodityVO classComVO = this.getForm().getClassCommodityVO(
					CPSHelper.getTrimmedValue(this.getForm().getProductVO()
							.getClassificationVO().getCommodity()));
			if (null != classComVO) {
				saveCaseVO.setDeptId(CPSHelper.getTrimmedValue(classComVO
						.getDeptId()));
				saveCaseVO.setSubDeptId(CPSHelper.getTrimmedValue(classComVO
						.getSubDeptId()));
			}
			for (VendorVO vendorVO : saveCaseVO.getVendorVOs()) {
				vendorVO.setChannel(saveCaseVO.getChannel());
				vendorVO.setChannelVal(saveCaseVO.getChannelVal());
			}

			// Calculate master cube.
			if (CPSConstants.CHANNEL_WHS.equalsIgnoreCase(caseVO
					.getChannelVal())
					|| CPSConstants.CHANNEL_BOTH.equalsIgnoreCase(caseVO
							.getChannelVal())) {
				saveCaseVO.setMasterCube(this.getCube(
						saveCaseVO.getMasterHeight(),
						saveCaseVO.getMasterWidth(),
						saveCaseVO.getMasterLength()));
				saveCaseVO.setShipCube(this.getCube(saveCaseVO.getShipHeight(),
						saveCaseVO.getShipWidth(), saveCaseVO.getShipLength()));
			}
			CaseVO savedCaseVO = CommonBridge
					.getAddNewCandidateServiceInstance().insertCaseToProduct(
							this.getForm().getProductVO(), saveCaseVO,
							this.getForm().getQuestionnarieVO());
			// set view for WHSeDC
			boolean flag = CommonBridge.getAddNewCandidateServiceInstance()
					.checkRltMrpBasedOnPsItemIdChild(savedCaseVO.getPsItemId());
			if (!flag) {
				CPSHelper.setChannelForMorph(savedCaseVO);
			}
			// calculate list cost again
			if (!CPSHelper.checkEqualValue(newMasterPack, oldMasterPack)) {
				VendorVO vendorVO2 = getVendorMorph(savedCaseVO,
						savedCaseVO.getVendorVOs());
				try {
					if (CPSHelper.isNotEmpty(vendorVO2)) {
						calculateListCostForeDc(savedCaseVO, vendorVO2);
					}
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
				}
			}
			newCaseVO = CaseVOHelper.copyCaseVOtoCaseVO(savedCaseVO);
			// Albin - to be removed later after clarification
			newCaseVO.setCodeDate(caseVO.isCodeDate());
			newCaseVO.setUniqueId(uniqueId);
		}
		return newCaseVO;

	}

	private void copyCaseVOToCaseVO(CaseVO to, CaseVO from) {
		to.setCaseDescription(from.getCaseDescription());
		to.setUnitFactor(from.getUnitFactor());
		to.setCaseUPC(from.getCaseUPC());
		to.setMaxShelfLifeDays(from.getMaxShelfLifeDays());
		to.setInboundSpecificationDays(from.getInboundSpecificationDays());
		to.setReactionDays(from.getReactionDays());
		to.setGuaranteetoStoreDays(from.getGuaranteetoStoreDays());
		to.setChannel(from.getChannel());
		to.setChannelVal(from.getChannelVal());
		to.setMasterPack(from.getMasterPack());
		//saveCaseVO.setMasterCube(caseVO.getMasterCube());
		to.setMasterHeight(from.getMasterHeight());
		to.setMasterLength(from.getMasterLength());
		to.setMasterWeight(from.getMasterWeight());
		to.setMasterWidth(from.getMasterWidth());
		to.setShipPack(from.getShipPack());
		to.setShipLength(from.getShipLength());
		// saveCaseVO.setShipCube(caseVO.getShipCube());
		to.setShipHeight(from.getShipHeight());
		to.setShipWeight(from.getShipWeight());
		to.setShipWidth(from.getShipWidth());
		to.setVariableWeight(from.isVariableWeight());
		to.setCatchWeight(from.isCatchWeight());
		// setting aplpicable upc values
		to.setPrimaryUpcUniqueId(from.getPrimaryUpcUniqueId());
		to.setUpcValues(from.getUpcValues());
		to.setOneTouch(from.getOneTouch());
		to.setItemId(from.getItemId());
		to.setItemCategory(from.getItemCategory());
		to.setMaxShip(from.getMaxShip());
		to.setPurchaseStatus(from.getPurchaseStatus());
		to.setMrt(from.getMrt());
		// DRU
		to.setDsplyDryPalSw(from.isDsplyDryPalSw());
		to.setSrsAffTypCd(from.getSrsAffTypCd());
		to.setProdFcngNbr(from.getProdFcngNbr());
		to.setProdRowDeepNbr(from.getProdRowDeepNbr());
		to.setProdRowHiNbr(from.getProdRowHiNbr());
		to.setDepositSw(from.getDepositSw());
		if (from.isDsplyDryPalSw())
			to.setNbrOfOrintNbr(from.getNbrOfOrintNbr());
		else {
			to.setNbrOfOrintNbr(null);
		}
		// END DRU
	}

	// Save the MRT upc's and cases

	public CaseVO addMRTCaseVO(CaseVO caseVO) throws Exception {
		// orgCaseVO - For preserving original CaseVO object
		CaseVO orgCaseVO = this.getForm().getMrtvo().getCaseVO();
		caseVO.setMessage(CPSConstants.EMPTY_STRING);

		// if(CaseVOHelper.entitySaved(caseVO,
		// this.getForm().getMrtvo().getCaseVO())){ Fix 1237. This check is not
		// required
		List<MRTUPCVO> mrtVOList = this.getForm().getMrtvo().getMrtVOs();
		int mrtVOListSize = mrtVOList.size();
		if (mrtVOListSize > 0) {
			caseVO = this.setMRTCaseProdValues(caseVO, mrtVOList);

			// if(checkDRU(caseVO)){
			if (CaseVOHelper.entityMRTCaseSaved(this.getForm().getMrtvo()
					.getSavedCaseVO(), this.getForm().getMrtvo()
					.getSavedCaseVO())) {
				Integer psItmId = this.getForm().getMrtvo().getCaseVO()
						.getPsItemId();
				caseVO.setMessage(CPSConstants.EMPTY_STRING);
				if (null != psItmId && 0 != psItmId) {
					caseVO.setPsItemId(psItmId);
				}
				// Fetching the VendorVO from orgCaseVO and set to the new
				// caseVO
				for (VendorVO vndrs : orgCaseVO.getVendorVOs()) {
					caseVO.setVendorVO(vndrs.getUniqueId(), vndrs);
				}

				if (CPSConstants.CHANNEL_WHS.equalsIgnoreCase(caseVO
						.getChannelVal())
						|| CPSConstants.CHANNEL_BOTH.equalsIgnoreCase(caseVO
								.getChannelVal())) {
					caseVO.setMasterCube(this.getCube(caseVO.getMasterHeight(),
							caseVO.getMasterWidth(), caseVO.getMasterLength()));
					caseVO.setShipCube(this.getCube(caseVO.getShipHeight(),
							caseVO.getShipWidth(), caseVO.getShipLength()));
				}

				// fix #27858
				caseVO.setReadyUnits(orgCaseVO.getReadyUnits());
				caseVO.setOrientations(orgCaseVO.getOrientations());

				this.getForm().getMrtvo().setCaseVO(caseVO);
				int workRequestId = 0;


				if(CPSHelper.isNotEmpty(caseVO.getWorkRequest())){
					workRequestId = caseVO.getWorkRequest().getWorkIdentifier();
				}

//				if (CPSHelper.isNotEmpty(caseVO.getCaseUPC())
//						&& !(CPSConstant.STRING_0).equals(caseVO.getCaseUPC())) {
//					List<PsItemMaster> psItemMasters = CommonBridge
//							.getAddNewCandidateServiceInstance()
//							.getItemIdByOrderingUPC(
//									CPSHelper.getLongValue(caseVO.getCaseUPC()));
//					if (psItemMasters != null && !psItemMasters.isEmpty()) {
//						if (CPSHelper.isNotEmpty(psItemMasters)) {
//							for (PsItemMaster psItemMaster : psItemMasters) {
//								workRequestId = psItemMaster.getPsWorkRqst()
//										.getPsWorkId();
//								break;
//							}
//						}
//					}
//				}
				// Fix 1197
				UserInfo userInfo = getUserInfo();
				WorkRequest workRqst = new WorkRequest();
				if (workRequestId > 0) {
					workRqst.setWorkIdentifier(workRequestId);
				}
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
				CaseVO retCaseVO = CommonBridge
						.getAddNewCandidateServiceInstance().insertCaseToMRT(
								caseVO, mrtVOList, getUserRole(), workRqst);
				for (MRTUPCVO mrtUpcVo : this.getForm().getMrtvo().getMrtVOs()) {
					mrtUpcVo.setMrtUPCSaved(true);
				}
				this.getForm().getMrtvo()
						.setWorkRequest(retCaseVO.getWorkRequest());
				this.getForm()
						.getMrtvo()
						.setSavedCaseVO(
								CaseVOHelper.copyCaseVOtoCaseVO(retCaseVO));
				this.getForm().getMrtvo().getCaseVO()
						.setPsItemId(retCaseVO.getPsItemId());
				if (CPSConstants.CHANNEL_WHS.equalsIgnoreCase(caseVO
						.getChannelVal())
						|| CPSConstants.CHANNEL_BOTH.equalsIgnoreCase(caseVO
								.getChannelVal())) {
					this.getForm().setShowImport(true);
					this.setVendorValuesForMRT(caseVO.getChannel());
				}
			}
			// }
		} else {
			caseVO.setMessage("Please insert atleast one UPC");
		}
		return caseVO;
	}

	private CaseVO setMRTCaseProdValues(CaseVO caseVO, List<MRTUPCVO> mrtVOList) {
		for (MRTUPCVO mrtupcvo : mrtVOList) {
			// Fix 1229
			if (CPSHelper.isNotEmpty(mrtupcvo.getDescription())
					&& !mrtupcvo.getDescription().equalsIgnoreCase(
							NO_DESCRIPTION)
					&& !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())
					&& !(EMPTY_STRING).equals(mrtupcvo.getDescription())) {
				caseVO.setMerchandizeType(CPSHelper.getTrimmedValue(mrtupcvo
						.getProductVO().getClassificationVO()
						.getMerchandizeType()));
				caseVO.setCommodityCode(CPSHelper.getTrimmedValue(mrtupcvo
						.getProductVO().getClassificationVO().getCommodity()));
				caseVO.setSubCommodityCode(CPSHelper
						.getTrimmedValue(mrtupcvo.getProductVO()
								.getClassificationVO().getSubCommodity()));
				caseVO.setPssDept(CPSHelper.getTrimmedValue(mrtupcvo
						.getProductVO().getPointOfSaleVO().getPssDept()));
				caseVO.setClassCode(mrtupcvo.getProductVO()
						.getClassificationVO().getClassField());
				ClassCommodityVO classComVO = this.getForm()
						.getClassCommodityVO(
								CPSHelper.getTrimmedValue(mrtupcvo
										.getProductVO().getClassificationVO()
										.getCommodity()));
				if (null != classComVO) {
					caseVO.setDeptId(CPSHelper.getTrimmedValue(classComVO
							.getDeptId()));
					caseVO.setSubDeptId(CPSHelper.getTrimmedValue(classComVO
							.getSubDeptId()));
				}
				// For setting the ordering UPC values to MRT - Starts
				this.setOrderingUPCValue(mrtupcvo, caseVO);
				// For setting the ordering UPC values to MRT - Ends
				break;
			}
		}
		return caseVO;
	}

	private void setOrderingUPCValue(MRTUPCVO mrtupcvo, CaseVO caseVO) {
		List<CaseVO> caseVOs = mrtupcvo.getProductVO().getCaseVOs();
		int orderTemp = 0;
		for (CaseVO caseVO2 : caseVOs) {
			if (CPSHelper.isNotEmpty(caseVO2.getOrderingUPC())) {
				caseVO.setOrderingUPC(caseVO2.getOrderingUPC());
				break;
			}
		}
		if (CPSHelper.isEmpty(caseVO.getOrderingUPC())) {
			for (CaseVO caseVO2 : caseVOs) {
				List<CaseUPCVO> upcVOs = caseVO2.getCaseUPCVOs();
				if (CPSHelper.isNotEmpty(upcVOs)) {
					for (CaseUPCVO caseUPCVO : upcVOs) {
						if (caseUPCVO.isPrimary()) {
							caseVO.setOrderingUPC(caseUPCVO.getUnitUpc());
							orderTemp = 1;
							break;
						}
					}
				}
				if (orderTemp == 1)
					break;
			}
		}
	}

	public VendorVO addMRTVendorVO(VendorVO vendorVO)
			throws CPSGeneralException {
		CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();
		List<VendorVO> vendorVOs = caseVO.getVendorVOs();

		if (CPSHelper.isNotEmpty(vendorVOs)) {
			for (VendorVO existingVendorVO : vendorVOs) {
				String vendorNo = null;
				if (BusinessConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(existingVendorVO
						.getVendorLocationTypeCode())) {
					if (CPSHelper.getStringValue(existingVendorVO
							.getVendorLocNumber()) != null
							&& CPSHelper.getStringValue(
									existingVendorVO.getVendorLocNumber())
									.length() > 6) {
						vendorNo = CPSHelper.getStringValue(
								existingVendorVO.getVendorLocNumber())
								.substring(2);
					} else {
						vendorNo = CPSHelper
								.getFormatVendorNumber(String
										.valueOf(existingVendorVO
												.getVendorLocNumber()));
					}
				} else {
					vendorNo = CPSHelper.getStringValue(existingVendorVO
							.getVendorLocNumber());
				}
				if (CPSHelper.checkEqualValue(vendorNo,
						vendorVO.getVendorLocationVal())) {
					throw new CPSBusinessException(
							new CPSMessage(
									"Vendor details already Exists, try saving another Vendor ",
									ErrorSeverity.ERROR));
				}
			}
		}

		if (CPSHelper.isEmpty(vendorVO.getVendorLocationVal())) {
			throw new CPSBusinessException(new CPSMessage(
					"Select a Vendor to save the vendor", ErrorSeverity.ERROR));
		}else{

			if (null != caseVO) {
				String channel = CPSWebUtil
						.getChannelValForService(caseVO.getChannelVal());
				if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(channel)) {
						VendorList vendorList = new VendorList(null, null,
								CPSHelper.getIntegerValue(vendorVO.getVendorLocationVal()));
						List<WareHouseVO> facilityList = CommonBridge
								.getCommonServiceInstance().getWareHouseList(vendorList, caseVO.getClassCode());
						if (CPSHelper.isEmpty(facilityList)) {
							throw new CPSBusinessException(
									new CPSMessage(
											"There is no warehouse in class "+ caseVO.getClassCode()+ " for bicep "+vendorVO.getVendorLocationVal(),
											ErrorSeverity.ERROR));
					}
				}
			}
		}

		// for Authorization Purpose - Starts Here
		this.clearAuthorizationValues();
		// for Authorization Purpose - Ends Here

		this.defaultVendorVO(vendorVO);
		if (CPSHelper.isEmpty(vendorVO.getCostOwner())) {
			vendorVO.setCostOwner(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(vendorVO.getCountryOfOrigin())) {
			vendorVO.setCountryOfOrigin(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(vendorVO.getTop2Top())) {
			vendorVO.setTop2Top(CPSConstants.EMPTY_STRING);
		}
		// Added condition for setting costOwner and top2top to unassigned
		String prodType = CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getProductType());
		String brand = CPSHelper.getTrimmedValue(this.getForm().getProductVO()
				.getClassificationVO().getBrand());
		if ("SPLY".equalsIgnoreCase(prodType)
				&& CPSConstant.STRING_0.equalsIgnoreCase(brand)) {
			if (null == vendorVO.getCostOwner()
					|| (null == vendorVO.getCostOwnerVal() || EMPTY_STRING
							.equals(vendorVO.getCostOwnerVal()))) {
				vendorVO.setCostOwner(BusinessConstants.UNASSIGNED);
				vendorVO.setCostOwnerVal(CPSConstant.STRING_0);
			}
			if (null == vendorVO.getTop2Top()
					|| (null == vendorVO.getTop2TopVal() || EMPTY_STRING
							.equals(vendorVO.getTop2TopVal()))) {
				vendorVO.setTop2Top(BusinessConstants.UNASSIGNED);
				vendorVO.setTop2TopVal(CPSConstant.STRING_0);
			}
		}
		String chnlVal = CPSConstants.EMPTY_STRING;
		if (null != caseVO) {
			vendorVO.setChannel(caseVO.getChannel());
			vendorVO.setChannelVal(caseVO.getChannelVal());
			caseVO.addVendorVO(vendorVO);
			chnlVal = CPSWebUtil
					.getChannelValForService(caseVO.getChannelVal());
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
		}
		if (null != vendorVO.getVendorLocationVal()) {

			if (null != getForm().getVendorVO().getVendorLocationForId(
					vendorVO.getVendorLocationVal())) {
				if (null != getForm()
						.getVendorVO()
						.getVendorLocationForId(vendorVO.getVendorLocationVal())
						.getVendorLocationType()) {
					vendorVO.setVendorLocationTypeCode(getForm()
							.getVendorVO()
							.getVendorLocationForId(
									vendorVO.getVendorLocationVal())
							.getVendorLocationType());
					// Add vendLocTypeCode
					if (vendorVO.getVendorLocTypeCode() == null) {
						vendorVO.setVendorLocTypeCode(vendorVO
								.getVendorLocationTypeCode());
					}
				}
			} else {
				throw new CPSBusinessException(
						new CPSMessage(
								"Selected Vendor is invalid. Please try another vendor",
								ErrorSeverity.ERROR));
			}
			if (null != getForm().getVendorVO()
					.getVendorLocationForId(vendorVO.getVendorLocationVal())
					.getVendorId()) {
				vendorVO.setVendorLocNumber(CPSHelper.getIntegerValue(getForm()
						.getVendorVO()
						.getVendorLocationForId(vendorVO.getVendorLocationVal())
						.getVendorId()));
			}
		}
		VendorVO retVendorVO = CommonBridge.getAddNewCandidateServiceInstance()
				.insertVendorToCase(caseVO, vendorVO,
						this.getForm().getProductVO());
		retVendorVO.setImportd(vendorVO.getImportd());
		retVendorVO.setChannel(caseVO.getChannelVal());
		retVendorVO.setChannelVal(caseVO.getChannelVal());
		if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(chnlVal)) {
			if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
				retVendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
				retVendorVO.setMasterPack(caseVO.getMasterPack());
			} else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {

				retVendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
				retVendorVO.setShipPack(caseVO.getShipPack());
			} else {

				retVendorVO.setChannelVal(CPSConstants.CHANNEL_BOTH);
				retVendorVO.setShipPack(caseVO.getShipPack());
				vendorVO.setMasterPack(caseVO.getMasterPack());
			}
		}
		retVendorVO.setMasterPack(caseVO.getMasterPack());
		retVendorVO.setShipPack(caseVO.getShipPack());
		retVendorVO.setUnitCostLabel(vendorVO.getUnitCostLabel());
		retVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
		retVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());
		retVendorVO.setVendorLocationVal(vendorVO.getVendorLocationVal());
		if (CPSHelper.isEmpty(retVendorVO.getCostOwner())) {
			retVendorVO.setCostOwner(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(retVendorVO.getCountryOfOrigin())) {
			retVendorVO.setCountryOfOrigin(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(retVendorVO.getTop2Top())) {
			retVendorVO.setTop2Top(CPSConstants.EMPTY_STRING);
		}
		caseVO.removeVendorVO(vendorVO.getUniqueId());
		caseVO.setVendorVO(retVendorVO.getUniqueId(), retVendorVO);

		// for Authorization Purpose - Starts Here
		// Unhandled exception may occur if commodity is null
		String deptNbr = EMPTY_STRING;
		String subDeptNbdr = EMPTY_STRING;
		if (CPSHelper.isEmpty(this.getForm().getProductVO()
				.getClassificationVO())
				|| CPSHelper.isEmpty(this.getForm().getProductVO()
						.getClassificationVO().getCommodity())) {
			deptNbr = caseVO.getDeptId();
			subDeptNbdr = caseVO.getSubDeptId();
		} else {
			if (this.getForm().getClassCommodityVO(
					this.getForm().getProductVO().getClassificationVO()
							.getCommodity()) != null) {
				deptNbr = this
						.getForm()
						.getClassCommodityVO(
								this.getForm().getProductVO()
										.getClassificationVO().getCommodity())
						.getDeptId();
				subDeptNbdr = this
						.getForm()
						.getClassCommodityVO(
								this.getForm().getProductVO()
										.getClassificationVO().getCommodity())
						.getSubDeptId();
			} else {
				deptNbr = caseVO.getDeptId();
				subDeptNbdr = caseVO.getSubDeptId();
			}
		}
		this.setDefaultValuesForAuthorization(caseVO, retVendorVO, deptNbr,
				subDeptNbdr);
		String defaultAuth = defaultAuthorizationForMRT();
		retVendorVO.setConflict(defaultAuth);
		// for Authorization Purpose - Ends Here

		return retVendorVO;
	}

	public VendorVO saveVendorVOForMRT(VendorVO vendorVO, String vendorUniqueId)
			throws CPSGeneralException {
		this.getForm().setRejectClose(false);
		this.getForm().setRejectComments(EMPTY_STRING);
		CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();
		List<VendorVO> vendorVOs = caseVO.getVendorVOs();
		if (CPSHelper.isNotEmpty(vendorVOs)) {
			for (VendorVO existingVendorVO : vendorVOs) {
				String vendorNo = existingVendorVO.getVendorLocationVal();
				if (!CPSHelper.isEmpty(vendorNo)) {
					if ((BusinessConstants.CHANNEL_WHS_CODE).equalsIgnoreCase(existingVendorVO
							.getVendorLocationTypeCode())
							&& existingVendorVO.getOriginalVendorLocNumber() == existingVendorVO
									.getVendorLocNumber()) {
						vendorNo = vendorNo.substring(2);// get rid of whse id
						// if it
						// exists in vendor loc
						// number.
					}

					if (Integer.valueOf(vendorNo) == Integer.valueOf(vendorVO
							.getVendorLocNumber())) {
						throw new CPSBusinessException(
								new CPSMessage(
										"Vendor details already Exists, try saving another Vendor ",
										ErrorSeverity.ERROR));
					}
				}
			}
		}

		VendorVO existingVendorVO = caseVO.getVendorVO(vendorUniqueId);
		if (this.isTobeSaved(existingVendorVO, vendorVO)) {
			this.defaultVendorVO(vendorVO);
			this.copyVendorVOtoVO(vendorVO, existingVendorVO);
			String chnlVal = CPSWebUtil
					.getChannelValForService(existingVendorVO.getChannelVal());

			// Added condition for setting costOwner and top2top to unassigned
			String prodType = CPSHelper.getTrimmedValue(this.getForm()
					.getProductVO().getClassificationVO().getProductType());
			String brand = CPSHelper.getTrimmedValue(this.getForm()
					.getProductVO().getClassificationVO().getBrand());
			if ("SPLY".equalsIgnoreCase(prodType)
					&& CPSConstant.STRING_0.equalsIgnoreCase(brand)) {
				if (null == existingVendorVO.getCostOwner()
						|| (null == existingVendorVO.getCostOwnerVal() || EMPTY_STRING
								.equals(existingVendorVO.getCostOwnerVal()))) {
					existingVendorVO.setCostOwner(BusinessConstants.UNASSIGNED);
					existingVendorVO.setCostOwnerVal(CPSConstant.STRING_0);
				}
				if (null == existingVendorVO.getTop2Top()
						|| (null == existingVendorVO.getTop2TopVal() || EMPTY_STRING
								.equals(existingVendorVO.getTop2TopVal()))) {
					existingVendorVO.setTop2Top(BusinessConstants.UNASSIGNED);
					existingVendorVO.setTop2TopVal(CPSConstant.STRING_0);
				}
			}
			if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
				existingVendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
				existingVendorVO.setMasterPack(vendorVO.getMasterPack());
			} else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
				existingVendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
				existingVendorVO.setShipPack(vendorVO.getShipPack());
			} else {
				existingVendorVO.setChannelVal(CPSConstants.CHANNEL_BOTH);
				existingVendorVO.setShipPack(vendorVO.getShipPack());
				existingVendorVO.setMasterPack(vendorVO.getMasterPack());
			}
			VendorLocationVO locationVO = this.getForm().getVendorVO()
					.getVendorLocationForId(vendorVO.getVendorLocationVal());
			if (null != locationVO) {
				existingVendorVO.setVendorLocationTypeCode(locationVO
						.getVendorLocationType());
				// Add vendLocTypeCode
				if (existingVendorVO.getVendorLocTypeCode() == null) {
					existingVendorVO.setVendorLocTypeCode(vendorVO
							.getVendorLocationTypeCode());
				}
				existingVendorVO.setVendorLocNumber(CPSHelper
						.getIntegerValue(locationVO.getVendorId()));
			}
			VendorVO vendorVO2 = CommonBridge
					.getAddNewCandidateServiceInstance().insertVendorToCase(
							caseVO, caseVO.getVendorVO(vendorUniqueId),
							this.getForm().getProductVO());
			this.getForm().getMrtvo().getCaseVO()
					.setVendorVO(vendorUniqueId, vendorVO2);
			return vendorVO2;
		}
		existingVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
		existingVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());
		return existingVendorVO;
	}

	public VendorVO removeVendorForMRT(String vendorUniqeId)
			throws CPSGeneralException {
		CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();
		CommonBridge.getAddNewCandidateServiceInstance().deleteVendorFromCase(
				caseVO, caseVO.removeVendorVO(vendorUniqeId));
		return caseVO.removeVendorVO(vendorUniqeId);
	}

	public VendorVO addVendorVO(VendorVO vendorVO, String caseVOId)
			throws CPSGeneralException {
		if (CPSHelper.isEmpty(vendorVO.getVendorLocationVal())) {
			throw new CPSBusinessException(new CPSMessage(
					"Select a Vendor to save the vendor", ErrorSeverity.ERROR));
		}
		// for Authorization Purpose - Starts Here
		this.clearAuthorizationValues();
		// for Authorization Purpose - Ends Here
		CaseVO caseVO = this.getExistingCaseVO(caseVOId);
		boolean flagMorph = CommonBridge.getAddNewCandidateServiceInstance()
				.checkRltMrpBasedOnPsItemIdChild(caseVO.getPsItemId());
		if (!flagMorph) {
			throw new CPSBusinessException(new CPSMessage(
					"Cannot add new vendor for an eDC item.",
					ErrorSeverity.ERROR));
		}

		List<VendorVO> vendorVOs = caseVO.getVendorVOs();
		if (CPSHelper.isNotEmpty(vendorVOs)) {
			for (VendorVO existingVendorVO : vendorVOs) {
				String vendorNo = null;
				if (BusinessConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(existingVendorVO
						.getVendorLocationTypeCode())) {
					if (CPSHelper.getStringValue(existingVendorVO
							.getVendorLocNumber()) != null
							&& CPSHelper.getStringValue(
									existingVendorVO.getVendorLocNumber())
									.length() > 6) {
						vendorNo = CPSHelper.getStringValue(
								existingVendorVO.getVendorLocNumber())
								.substring(2);
					} else {
						vendorNo = CPSHelper
								.getFormatVendorNumber(String
										.valueOf(existingVendorVO
												.getVendorLocNumber()));
					}
				} else {
					vendorNo = CPSHelper.getStringValue(existingVendorVO
							.getVendorLocNumber());
				}

				if (CPSHelper.checkEqualValue(vendorNo,
						vendorVO.getVendorLocationVal())) {
					throw new CPSBusinessException(
							new CPSMessage(
									"Vendor details already Exists, try saving another Vendor ",
									ErrorSeverity.ERROR));
				}
			}
		}
		if (CPSHelper.isEmpty(caseVO.getPsItemId())) {
			throw new CPSBusinessException(new CPSMessage(
					"Please create candidate before save vendor",
					ErrorSeverity.ERROR));
		}
		this.defaultVendorVO(vendorVO);
		if (null != caseVO) {
			vendorVO.setChannelVal(caseVO.getChannelVal());
			vendorVO.setChannel(caseVO.getChannel());
			caseVO.addVendorVO(vendorVO);
		}
		String chnlVal = CPSWebUtil.getChannelValForService(caseVO
				.getChannelVal());

		String deptNbr = null;
		String subDeptNbdr = null;

		// 958 enhancements
		if (CPSHelper.isNotEmpty(vendorVO.getDept())
				&& CPSHelper.isNotEmpty(vendorVO.getSubDeptId())) {
			deptNbr = vendorVO.getDept();
			subDeptNbdr = vendorVO.getSubDeptId();
		} else {
			deptNbr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getDeptId();
			subDeptNbdr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getSubDeptId();
		}

		// Added condition for setting costOwner and top2top to unassigned
		String prodType = CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getProductType());
		String brand = CPSHelper.getTrimmedValue(this.getForm().getProductVO()
				.getClassificationVO().getBrand());
		if ("SPLY".equalsIgnoreCase(prodType)
				&& CPSConstant.STRING_0.equalsIgnoreCase(brand)) {
			if (null == vendorVO.getCostOwner()
					|| (null == vendorVO.getCostOwnerVal() || EMPTY_STRING
							.equals(vendorVO.getCostOwnerVal()))) {
				vendorVO.setCostOwner(BusinessConstants.UNASSIGNED);
				vendorVO.setCostOwnerVal(CPSConstant.STRING_0);
			}
			if (null == vendorVO.getTop2Top()
					|| (null == vendorVO.getTop2TopVal() || EMPTY_STRING
							.equals(vendorVO.getTop2TopVal()))) {
				vendorVO.setTop2Top(BusinessConstants.UNASSIGNED);
				vendorVO.setTop2TopVal(CPSConstant.STRING_0);
			}
		}
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

		if (null != vendorVO
				&& CPSHelper.isNotEmpty(vendorVO.getVendorLocationVal())) {

			if (getForm().getVendorVO().getVendorLocationForId(
					vendorVO.getVendorLocationVal()) != null) {
				if (null != getForm()
						.getVendorVO()
						.getVendorLocationForId(vendorVO.getVendorLocationVal())
						.getVendorLocationType()) {
					vendorVO.setVendorLocationTypeCode(getForm()
							.getVendorVO()
							.getVendorLocationForId(
									vendorVO.getVendorLocationVal())
							.getVendorLocationType());
					// Add vendLocTypeCode
					if (vendorVO.getVendorLocTypeCode() == null) {
						vendorVO.setVendorLocTypeCode(vendorVO
								.getVendorLocationTypeCode());
					}
				}
			} else {

				throw new CPSBusinessException(
						new CPSMessage(
								"Selected Vendor is invalid. Please try another vendor",
								ErrorSeverity.ERROR));

			}
			if (null != getForm().getVendorVO()
					.getVendorLocationForId(vendorVO.getVendorLocationVal())
					.getVendorId()) {
				vendorVO.setVendorLocNumber(CPSHelper.getIntegerValue(getForm()
						.getVendorVO()
						.getVendorLocationForId(vendorVO.getVendorLocationVal())
						.getVendorId()));
			}

		}

		VendorVO retVendorVO = new VendorVO();
		try {
			retVendorVO = CommonBridge.getAddNewCandidateServiceInstance()
					.insertVendorToCase(caseVO, vendorVO,
							this.getForm().getProductVO());
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getMessage(), e);
		}

		retVendorVO.setImportd(vendorVO.getImportd());
		retVendorVO.setChannel(caseVO.getChannel());
		retVendorVO.setChannelVal(caseVO.getChannelVal());
		if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
			retVendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
			retVendorVO.setMasterPack(caseVO.getMasterPack());
		} else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {

			retVendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
			retVendorVO.setShipPack(caseVO.getShipPack());
		} else {

			retVendorVO.setChannelVal(CPSConstants.CHANNEL_BOTH);
			retVendorVO.setShipPack(caseVO.getShipPack());
			retVendorVO.setMasterPack(caseVO.getMasterPack());
		}

		retVendorVO.setMasterPack(caseVO.getMasterPack());
		retVendorVO.setShipPack(caseVO.getShipPack());
		retVendorVO.setUnitCostLabel(vendorVO.getUnitCostLabel());
		retVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
		retVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());
		retVendorVO.setVendorLocationVal(vendorVO.getVendorLocationVal());
		if (retVendorVO.getNewDataSw() == CPSConstant.CHAR_Y) {
			retVendorVO.setVendorViewOverride(false);
		}
		caseVO.removeVendorVO(vendorVO.getUniqueId());
		caseVO.setVendorVO(retVendorVO.getUniqueId(), retVendorVO);

		// for Authorization Purpose - Starts Here
		this.setDefaultValuesForAuthorization(caseVO, retVendorVO, deptNbr,
				subDeptNbdr);
		// comment because app run very slow. Will uncomment after test done
		// morph. HB
		String defaultAuth = defaultAuthorization();
		retVendorVO.setConflict(defaultAuth);

		// for Authorization Purpose - Ends Here

		return retVendorVO;
	}

	private void clearAuthorizationValues() {
		this.getForm().setItemID(EMPTY_STRING);
		this.getForm().setVendorId(EMPTY_STRING);
		this.getForm().setListCost(EMPTY_STRING);
		this.getForm().setAuthDeptNo(EMPTY_STRING);
		this.getForm().setAuthSubDeptNo(EMPTY_STRING);
	}

	private void setDefaultValuesForAuthorization(CaseVO caseVO,
			VendorVO retVendorVO, String deptNbr, String subDeptNbr) {
		if (null != caseVO) {
			this.getForm().setItemID(
					CPSHelper.getTrimmedValue(CPSHelper.getStringValue(caseVO
							.getPsItemId())));
		}
		if (null != retVendorVO) {
			String vendLocNumber = CPSHelper.getTrimmedValue(CPSHelper
					.getStringValue(retVendorVO.getVendorLocNumber()));
			if (!"D".equalsIgnoreCase(retVendorVO.getVendorLocationTypeCode())
					&& null != vendLocNumber && vendLocNumber.length() > 6) {
				vendLocNumber = vendLocNumber.substring(2,
						vendLocNumber.length());
			}


			this.getForm()
					.setVendorId(CPSHelper.getTrimmedValue(vendLocNumber));
			this.getForm().setListCost(
					CPSHelper.getTrimmedValue(retVendorVO.getListCost()));
			this.getForm().setAuthTypeCode(
					CPSHelper.getTrimmedValue(retVendorVO
							.getVendorLocTypeCode()));
		}
		if (CPSHelper.isNotEmpty(deptNbr) && deptNbr.length() < 2) {
			deptNbr = CPSHelper.getTrimmedValue(new StringBuilder(ZERO_STRING)
					.append(deptNbr).toString());
		}
		this.getForm().setAuthDeptNo(deptNbr);
		subDeptNbr = (null != subDeptNbr || !EMPTY_STRING
				.equalsIgnoreCase(subDeptNbr)) ? subDeptNbr : EMPTY_STRING;
		this.getForm().setAuthSubDeptNo(subDeptNbr);
	}

	public VendorVO saveVendorVO(VendorVO vendorVO, String vendorUniqueId,
			String caseUniqeId) throws CPSGeneralException {
		String psItemChild = null;
		CaseVO caseVo = this.getForm().getProductVO().getCaseVO(caseUniqeId);
		if (CPSHelper.isEmpty(caseVo)) {
			List<CaseVO> caseVOs = this.getForm().getProductVO().getCaseVOs();
			for (CaseVO eachCaseVO : caseVOs) {
				if (caseUniqeId.equalsIgnoreCase(eachCaseVO.getUniqueId())) {
					caseVo = eachCaseVO;
					break;
				}
			}
		}
		List<VendorVO> vendorVOs = caseVo.getVendorVOs();
		if (CPSHelper.isNotEmpty(vendorVOs)) {
			boolean existingVD = false;
			String vendorNumber = CPSHelper.getFormatVendorNumber(vendorVO
					.getVendorLocationVal());
			String vendorLocation = vendorVO.getVendorLocation();
			if (vendorLocation.indexOf('[') > 0) {
				vendorLocation = vendorLocation.substring(0,
						vendorLocation.indexOf('['));
				vendorLocation = vendorLocation.trim();
			}
			for (VendorVO existingVendorVO : vendorVOs) {
				// check: vendorNo & vendorLocation
				String tempVendorNumber = CPSHelper
						.getFormatVendorNumber(CPSHelper
								.getStringValue(existingVendorVO
										.getVendorLocNumber()));
				String tempVendorLocation = existingVendorVO
						.getVendorLocation();
				if (vendorNumber.equalsIgnoreCase(tempVendorNumber)
						&& vendorLocation.equalsIgnoreCase(tempVendorLocation)
						&& !existingVendorVO.getUniqueId().equalsIgnoreCase(
								vendorUniqueId)) {
					existingVD = true;
					break;
				}
			}
			if (existingVD) {
				throw new CPSBusinessException(
						new CPSMessage(
								"Vendor details already Exists, try saving another Vendor ",
								ErrorSeverity.ERROR));
			}
		}
		VendorVO existingVendorVO = this.getExistingVendorVO(vendorUniqueId,
				caseUniqeId);
		validateMarginAndPennyProfit(caseVo, existingVendorVO);
		if (this.isTobeSaved(existingVendorVO, vendorVO)) {
			if (!CPSHelper.isEqual(existingVendorVO.getVendorLocationVal(),
					vendorVO.getVendorLocationVal())) {
				List<VendorVO> vendors = new ArrayList<VendorVO>();
				vendors.add(existingVendorVO);
				VendorVO vendorMorph = getVendorMorph(caseVo, vendors);
				List<Integer> vendLocNbrs = new ArrayList<Integer>();
				vendLocNbrs.add(Integer.parseInt(vendorVO
						.getVendorLocationVal()));
				List<Object[]> vendorStores = CommonBridge
						.getAddNewCandidateServiceInstance()
						.getVendorStoresByStore706(caseVo.getPsItemId(),
								vendLocNbrs);
				if (CPSHelper.isEmpty(vendorStores) && !CPSHelper.isEmpty(vendorMorph)) {
					psItemChild = removeChildCase(caseVo);
				}
			}

			this.defaultVendorVO(vendorVO);

			// when you change the vendorNumber, delete the old vendor and add
			// new
			String existingVendNum = CPSHelper.getStringValue(existingVendorVO
					.getVendorLocNumber());
			existingVendNum = CPSHelper.checkVendorNumber(existingVendNum);
			if (CPSHelper.isNotEmpty(existingVendNum)
					&& existingVendNum.length() > 6) {
				existingVendNum = existingVendNum.substring(2);
			}
			if (!existingVendNum.equals(CPSHelper.checkVendorNumber(vendorVO
					.getVendorLocationVal()))) {
				// delete the existing vendor and add a new one
				removeVendorBeforeSave(vendorUniqueId, caseUniqeId);
			}
			this.copyVendorVOtoVO(vendorVO, existingVendorVO);
			if (CPSHelper.isEmpty(existingVendorVO.getChannelVal())) {
				if (caseVo.getChannel().equals(CPSConstants.CHANNEL_DSD)) {
					existingVendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
				} else if (caseVo.getChannel().equals(CPSConstants.CHANNEL_WHS)) {
					existingVendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
				}
			}
			String chnlVal = CPSWebUtil
					.getChannelValForService(existingVendorVO.getChannelVal());

			String deptNbr = null;
			String subDeptNbdr = null;

			// 958 enhancements
			if (CPSHelper.isNotEmpty(existingVendorVO.getDept())
					&& CPSHelper.isNotEmpty(existingVendorVO.getSubDeptId())) {
				deptNbr = existingVendorVO.getDept();
				subDeptNbdr = existingVendorVO.getSubDeptId();
			} else {
				deptNbr = this
						.getForm()
						.getClassCommodityVO(
								this.getForm().getProductVO()
										.getClassificationVO().getCommodity())
						.getDeptId();
				subDeptNbdr = this
						.getForm()
						.getClassCommodityVO(
								this.getForm().getProductVO()
										.getClassificationVO().getCommodity())
						.getSubDeptId();
			}
			String classField = this.getForm().getProductVO()
					.getClassificationVO().getClassField();
			String commodityVal = this.getForm().getProductVO()
					.getClassificationVO().getCommodity();

			// Added condition for setting costOwner and top2top to unassigned
			String prodType = CPSHelper.getTrimmedValue(this.getForm()
					.getProductVO().getClassificationVO().getProductType());
			String brand = CPSHelper.getTrimmedValue(this.getForm()
					.getProductVO().getClassificationVO().getBrand());
			if ("SPLY".equalsIgnoreCase(prodType)
					&& CPSConstant.STRING_0.equalsIgnoreCase(brand)) {
				if (null == existingVendorVO.getCostOwner()
						|| (null == existingVendorVO.getCostOwnerVal() || EMPTY_STRING
								.equals(existingVendorVO.getCostOwnerVal()))) {
					existingVendorVO.setCostOwner(BusinessConstants.UNASSIGNED);
					existingVendorVO.setCostOwnerVal(CPSConstant.STRING_0);
				}
				if (null == existingVendorVO.getTop2Top()
						|| (null == existingVendorVO.getTop2TopVal() || EMPTY_STRING
								.equals(existingVendorVO.getTop2TopVal()))) {
					existingVendorVO.setTop2Top(BusinessConstants.UNASSIGNED);
					existingVendorVO.setTop2TopVal(CPSConstant.STRING_0);
				}
			}

			if (CPSConstants.CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
				this.getForm().updateVendorList(deptNbr, subDeptNbdr,
						classField, null, chnlVal);
				existingVendorVO.setChannelVal(CPSConstants.CHANNEL_DSD);
				existingVendorVO.setMasterPack(vendorVO.getMasterPack());
			} else if (CPSConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
				this.getForm().updateVendorList(null, null, classField,
						commodityVal, chnlVal);
				existingVendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
				existingVendorVO.setShipPack(vendorVO.getShipPack());
			} else {
				this.getForm().updateVendorList(deptNbr, subDeptNbdr,
						classField, commodityVal, chnlVal);
				existingVendorVO.setChannelVal(CPSConstants.CHANNEL_BOTH);
				existingVendorVO.setShipPack(vendorVO.getShipPack());
				existingVendorVO.setMasterPack(vendorVO.getMasterPack());
			}
			VendorLocationVO locationVO = this.getForm().getVendorVO()
					.getVendorLocationForId(vendorVO.getVendorLocationVal());
			if (null != locationVO) {
				existingVendorVO.setVendorLocationTypeCode(locationVO
						.getVendorLocationType());
				// Add vendLocTypeCode
				if (existingVendorVO.getVendorLocTypeCode() == null) {
					existingVendorVO.setVendorLocTypeCode(vendorVO
							.getVendorLocationTypeCode());
				}
				existingVendorVO.setVendorLocNumber(CPSHelper
						.getIntegerValue(locationVO.getVendorId()));
			}

			existingVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
			existingVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());
			CaseVO temporaryCaseVO = this.getExistingCaseVO(caseUniqeId);

			VendorVO vendorVO2 = CommonBridge
					.getAddNewCandidateServiceInstance().insertVendorToCase(
							temporaryCaseVO, existingVendorVO,
							this.getForm().getProductVO());

			vendorVO2.setVendorLocationVal(vendorVO.getVendorLocationVal());
			CaseVO caseVO = this.getExistingCaseVO(caseUniqeId);
			caseVO.setVendorVO(vendorUniqueId, vendorVO2);

			/* Sellappan Added Default authorization on modify */
			// default store auth is required only when a new vendor is added
			if (!existingVendNum.equals(CPSHelper.checkVendorNumber(vendorVO
					.getVendorLocationVal()))) {
				this.setDefaultValuesForAuthorization(caseVO, vendorVO2,
						deptNbr, subDeptNbdr);
				String defaultAuth = defaultAuthorization();
				vendorVO2.setConflict(defaultAuth);
			}
			/* Default Authorization ends */

			try {
				calculateListCostForeDc(caseVO, vendorVO2);
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
			validateMarginAndPennyProfit(caseVO, vendorVO2);
			if (CPSHelper.isNotEmpty(psItemChild)) {
				vendorVO2.setPsItemWHSeDC(psItemChild);
			}
			return vendorVO2;
		}
		existingVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
		existingVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());
		if (existingVendorVO.isItemCodeRadio()) {
			existingVendorVO.setCostLink(null);
		} else {
			existingVendorVO.setCostLink(vendorVO.getCostLink());
		}
		return existingVendorVO;
	}

	private void calculateListCostForeDc(CaseVO caseCurrent, VendorVO vendorVO2) {
		Integer psItemChild = getChildRelationalMorph(caseCurrent.getPsItemId());
		if (CPSHelper.isEmpty(psItemChild)) {
			return;
		}
		List<CaseVO> caseLst = this.getForm().getProductVO().getCaseVOs();
		for (CaseVO caseVOTemp : caseLst) {
			if (caseVOTemp.getPsItemId().equals(psItemChild)) {

				List<VendorVO> vendors = caseVOTemp.getVendorVOs();

				String apNbr = getApNbrBasedOnVendNo(vendorVO2
						.getVendorLocationVal());
				for (VendorVO vendorVO : vendors) {
					VendorLocDeptVO vendorLocDept = CommonBridge
							.getCommonServiceInstance().getVendorFromCache(
									"W-" + vendorVO.getVendorLocationVal());
					if (vendorLocDept != null
							&& CPSHelper.isNotEmpty(vendorLocDept.getApNbr())
							&& CPSHelper.getTrimmedValue(
									vendorLocDept.getApNbr()).equals(apNbr)) {
						BigDecimal mPack = CPSHelper
								.getBigdecimalValue(caseCurrent.getMasterPack());
						BigDecimal dsdListCost = CPSHelper
								.getBigdecimalValue(vendorVO2
										.getListCostFormatted());
						BigDecimal eDCListCost = null;
						if (mPack != null
								&& BigDecimal.ZERO.compareTo(mPack) == -1) {
							eDCListCost = dsdListCost.divide(mPack, 4,
									RoundingMode.HALF_EVEN);
						}
						if (mPack != null
								&& BigDecimal.ZERO.compareTo(mPack) == 0) {
							vendorVO.setListCost(EMPTY_STRING);
							vendorVO.setUnitCost(EMPTY_STRING);
							vendorVO.setUnitCostLabel(EMPTY_STRING);
						}
						if (eDCListCost != null) {
							vendorVO.setListCost(eDCListCost.toString());
							vendorVO.setUnitCost(eDCListCost.toString());
							vendorVO.setUnitCostLabel(eDCListCost.toString());
						}
						try {
							CommonBridge.getAddNewCandidateServiceInstance()
									.updateVendorWHSeDC(
											caseVOTemp.getPsItemId(), vendorVO);
						} catch (Exception e) {
							LOG.error(e.getMessage(), e);
						}
						break;
					}
				}
				break;
			}
		}

	}

	private VendorVO getCurrentVendorAuth706(List<VendorVO> vendorVos,
			boolean unAuthorizedStore706, int psItemId,
			List<VendorVO> currentVendorVos, String selectedVendorId) {
		VendorVO currentVendorAuth706 = null;
		VendorVO vendorSelected = null;
		List<Integer> vendLocNbrs = new ArrayList<Integer>();
		Map<String, VendorVO> vendorMap = new HashMap<String, VendorVO>();
		Map<Integer, BigDecimal> existVendor = new HashMap<Integer, BigDecimal>();
		int count = 0;
		BigDecimal listCost = BigDecimal.ZERO;
		BigDecimal currentVendListCost = BigDecimal.ZERO;
		if (CPSHelper.isNotEmpty(selectedVendorId)) {
			vendLocNbrs.add(Integer.parseInt(selectedVendorId));
			List<Object[]> vendorStores = CommonBridge
					.getAddNewCandidateServiceInstance()
					.getVendorStoresByStore706(psItemId, vendLocNbrs);
			if (CPSHelper.isNotEmpty(vendorStores)) {
				currentVendListCost = CPSHelper.getBigdecimalValue(
						CPSHelper.getTrimmedValue(vendorStores.get(0)[2]));
				int compareData = CPSHelper.getBigdecimalValue(
						CPSHelper.getTrimmedValue(vendorStores.get(0)[2]))
						.compareTo(BigDecimal.ZERO);
				if (compareData == 1) {
					for (VendorVO vendor : currentVendorVos) {
						if (selectedVendorId.equalsIgnoreCase(String
								.valueOf(vendor.getVendorLocNumber()))) {
							vendorSelected = vendor;
							break;
						}
					}
				}
			}
			if(CPSHelper.isNotEmpty(vendorVos) && vendorVos.size()==1 && CPSHelper.isNotEmpty(vendorSelected)) {
				if(vendorSelected.getVendorLocNumber()==vendorVos.get(0).getVendorLocNumber()) {
					return vendorSelected;
				}
			}
		}
		vendLocNbrs = new ArrayList<Integer>();
		for (VendorVO vendor : vendorVos) {
			vendLocNbrs.add(vendor.getVendorLocNumber());
			vendorMap.put(String.valueOf(vendor.getVendorLocNumber()), vendor);
		}
		List<Object[]> vendorStores = CommonBridge
				.getAddNewCandidateServiceInstance().getVendorStoresByStore706(
						psItemId, vendLocNbrs);
		if (CPSHelper.isNotEmpty(vendorStores)) {
			for (Object obj[] : vendorStores) {
				int compareData = CPSHelper.getBigdecimalValue(
						CPSHelper.getTrimmedValue(obj[2])).compareTo(
						BigDecimal.ZERO);
				currentVendorAuth706 = vendorMap.get(CPSHelper
						.getTrimmedValue(obj[0]));
				if (currentVendorAuth706 != null) {
					if (vendLocNbrs.size() > 1) {
						// one of them does not unauthorized
						if (compareData == 1) {
							currentVendorAuth706.setVendorLocNumber(CPSHelper
									.getIntegerValue(CPSHelper
											.getTrimmedValue(obj[0])));
							if(vendorSelected!=null) {
								return vendorSelected;
							}
							break;
						} else {
							count++;
							existVendor
									.put(CPSHelper.getIntegerValue(CPSHelper
											.getTrimmedValue(obj[0])), CPSHelper
											.getBigdecimalValue(CPSHelper
													.getTrimmedValue(vendorStores
															.get(0)[2])));
						}
					} else {
							currentVendorAuth706.setVendorLocNumber(CPSHelper
									.getIntegerValue(CPSHelper
											.getTrimmedValue(obj[0])));
							listCost = CPSHelper.getBigdecimalValue(CPSHelper
									.getTrimmedValue(vendorStores.get(0)[2]));
							break;
					}
				}
			}
			// All vendors (>2 vendors) removed store 706 and then One of them
			// is adding to store 706.
			if (count > 0 && count == currentVendorVos.size() - 1) {
				// All Vendors (Except Vendor Selected) have List Cost ===0
				int compareData = CPSHelper.getBigdecimalValue(
						currentVendListCost).compareTo(BigDecimal.ZERO);
				for (VendorVO vendor : currentVendorVos) {
					if (compareData == 0) {
						currentVendorAuth706 = null;
						break;
					} else {
						if (selectedVendorId.equalsIgnoreCase(String
								.valueOf(vendor.getVendorLocNumber()))) {
							currentVendorAuth706 = vendor;
							break;
						}
					}
				}
				// If All vendors ready for add Store 706 and delete one of
				// them, No Morph here.
			} else if (count > 0 && count == currentVendorVos.size()) {
				currentVendorAuth706 = null;
			}
			// There are two vendors, Removing to store 706 at first vendor and
			// Store 706 removed at second vendor. No morph at here.
			if (vendLocNbrs.size() == 1
					&& currentVendorVos.size() == 2
					&& currentVendorAuth706 != null
					&& CPSHelper.isNotEmpty(selectedVendorId)
					&& currentVendorAuth706.getVendorLocNumber() != Integer
							.parseInt(selectedVendorId)) {
				vendLocNbrs = new ArrayList<Integer>();
				for (VendorVO vendor : currentVendorVos) {
					// List Cost of Vendor Selected==0 and List Cost of Remain
					// Vendor==0--> No morph
					if (currentVendListCost.compareTo(BigDecimal.ZERO) == 0
							&& listCost.compareTo(BigDecimal.ZERO) == 0) {
						return null;
					} else if (currentVendListCost.compareTo(BigDecimal.ZERO) == 1
							&& listCost.compareTo(BigDecimal.ZERO) == 0) {
						if (selectedVendorId.equalsIgnoreCase(String
								.valueOf(vendor.getVendorLocNumber()))) {
							return vendor;
						}
					}
				}
			} else if (vendorStores.size() == 1 && currentVendorAuth706 != null
					&& count == 1) {
				if(currentVendListCost.compareTo(BigDecimal.ZERO) == 1) {
					return vendorSelected;
				} else {
					Set<Integer> setKeys = existVendor.keySet();
					Iterator<Integer> iter = setKeys.iterator();
					while (iter.hasNext()) {
						if (vendorMap.get(iter.next()) != null) {
							currentVendorAuth706 = null;
							break;
						}
					}
				}
			} else if (vendLocNbrs.size() == 1 && currentVendorAuth706 != null
					&& listCost.compareTo(BigDecimal.ZERO) == 0) {
				currentVendorAuth706 = null;
			}
			if (currentVendorAuth706 != null
					&& CPSHelper.isNotEmpty(existVendor)) {
				BigDecimal listCost706 = existVendor.get(currentVendorAuth706
						.getVendorLocNumber());
				if(listCost706!=null) {
					if(currentVendListCost.compareTo(BigDecimal.ZERO) == 1) {
						currentVendorAuth706 = vendorSelected;
					} else if(listCost706.compareTo(BigDecimal.ZERO) ==0) {
						currentVendorAuth706 = null;
					}
				} else if(vendorSelected!=null){
					return vendorSelected;
				}
			}
		} else {
			currentVendorAuth706 = vendorSelected;
		}
		return currentVendorAuth706;
	}

	private VendorVO getExistingVendorVO(String vendorUniqueId,
			String caseUniqeId) {
		CaseVO saveCaseVO = this.getExistingCaseVO(caseUniqeId);
		List<VendorVO> vendorVOlist = saveCaseVO.getVendorVOs();
		VendorVO saveVendorVO = new VendorVO();
		for (VendorVO vendorVO : vendorVOlist) {
			if (CPSHelper.getTrimmedValue(vendorUniqueId).equalsIgnoreCase(
					CPSHelper.getTrimmedValue(vendorVO.getUniqueId()))) {
				saveVendorVO = vendorVO;
				break;
			}
		}
		return saveVendorVO;
	}

	private CaseVO getExistingCaseVO(String uniqueId) {
		List<CaseVO> caseVOList = this.getForm().getProductVO().getCaseVOs();
		CaseVO saveCaseVO = new CaseVO();
		for (CaseVO eachCaseVO : caseVOList) {
			if (uniqueId.equalsIgnoreCase(eachCaseVO.getUniqueId())) {
				saveCaseVO = eachCaseVO;
				break;
			}
		}
		return saveCaseVO;
	}

	private void defaultVendorVO(VendorVO vendorVO) {
		if (CPSHelper.isEmpty(vendorVO.getCostOwnerVal())) {
			vendorVO.setCostOwner(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(vendorVO.getCountryOfOriginVal())) {
			vendorVO.setCountryOfOrigin(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(vendorVO.getTop2TopVal())) {
			vendorVO.setTop2Top(CPSConstants.EMPTY_STRING);
		}
		if (CPSHelper.isEmpty(vendorVO.getOrderRestrictionVal())) {
			vendorVO.setOrderRestriction(CPSConstants.EMPTY_STRING);
		}
	}

	private boolean isTobeSaved(VendorVO existing, VendorVO latest) {
		if (latest.getImportd() != null
				&& ("true").equalsIgnoreCase(latest.getImportd())) {
			return !(CPSHelper.isEqual(existing.getCostLink(),
					latest.getCostLink())
					&& CPSHelper.isEqual(existing.getCostOwner(),
							latest.getCostOwner())
					&& CPSHelper.isEqual(existing.getCostOwnerVal(),
							latest.getCostOwnerVal())
					&& CPSHelper.isEqual(existing.getCountryOfOrigin(),
							latest.getCountryOfOrigin())
					&& CPSHelper.isEqual(existing.getCountryOfOriginVal(),
							latest.getCountryOfOriginVal())
					&& CPSHelper.isEqual(existing.isDealOffered(),
							latest.isDealOffered())
					&& CPSHelper.isEqual(existing.isGuarenteedSale(),
							latest.isGuarenteedSale())
					&& CPSHelper.isEqual(existing.getImportd(),
							latest.getImportd())
					&& CPSHelper.isEqual(existing.getListCost(),
							latest.getListCost())
					&& CPSHelper.isEqual(existing.getSeasonality(),
							latest.getSeasonality())
					&& CPSHelper.isEqual(existing.getSeasonalityVal(),
							latest.getSeasonalityVal())
					&& CPSHelper.isEqual(existing.getSeasonalityYr(),
							latest.getSeasonalityYr())
					&& CPSHelper.isEqual(existing.getTop2Top(),
							latest.getTop2Top())
					&& CPSHelper.isEqual(existing.getTop2TopVal(),
							latest.getTop2TopVal())
					&& CPSHelper.isEqual(existing.getUnitCost(),
							latest.getUnitCost())
					&& CPSHelper.isEqual(existing.getVendorLocation(),
							latest.getVendorLocation())
					&& CPSHelper.isEqual(existing.getVendorLocationVal(),
							latest.getVendorLocationVal())
					&& CPSHelper.isEqual(existing.getVendorTie(),
							latest.getVendorTie())
					&& CPSHelper.isEqual(existing.getVendorTier(),
							latest.getVendorTier())
					&& CPSHelper.isEqual(existing.getVpc(), latest.getVpc())
					&& CPSHelper.isEqual(existing.getUnitCostLabel(),
							latest.getUnitCostLabel())
					&& CPSHelper.isEqual(existing.getExpectedWeeklyMvt(),
							latest.getExpectedWeeklyMvt())
					&& CPSHelper.isEqual(existing.getOrderRestriction(),
							latest.getOrderRestriction())
					&& CPSHelper.isEqual(existing.getOrderRestrictionVal(),
							latest.getOrderRestrictionVal())
					&& CPSHelper.isEqual(existing.getOrderUnit(),
							latest.getOrderUnit())
					&& CPSHelper.isEqual(existing.getPssDept(),
							latest.getPssDept())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getContainerSize(), latest.getImportVO()
							.getContainerSize())
					&& CPSHelper.isEqual(existing.getImportVO().getIncoTerms(),
							latest.getImportVO().getIncoTerms())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getPickupPoint(), latest.getImportVO()
							.getPickupPoint())
					&& CPSHelper.isEqual(existing.getImportVO().getDuty(),
							latest.getImportVO().getDuty())
					&& CPSHelper.isEqual(existing.getImportVO().getDutyInfo(),
							latest.getImportVO().getDutyInfo())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getMinimumQtyFormatted(), latest.getImportVO()
							.getMinimumQtyFormatted())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getMinimumType(), latest.getImportVO()
							.getMinimumType())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getHtsFormatted(), latest.getImportVO()
							.getHtsFormatted())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getHts2Formatted(), latest.getImportVO()
							.getHts2Formatted())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getHts3Formatted(), latest.getImportVO()
							.getHts3Formatted())
					&& CPSHelper.isEqual(existing.getImportVO().getColor(),
							latest.getImportVO().getColor())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getAgentPercFormatted(), latest.getImportVO()
							.getAgentPercFormatted())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getCartonMarketing(), latest.getImportVO()
							.getCartonMarketing())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getRateFormatted(), latest.getImportVO()
							.getRateFormatted())
					&& CPSHelper.isEqual(existing.getImportVO().getFreight(),
							latest.getImportVO().getFreight())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getProrationDate(), latest.getImportVO()
							.getProrationDate())
					&& CPSHelper.isEqual(existing.getImportVO()
							.getInstoreDate(), latest.getImportVO()
							.getInstoreDate()) && CPSHelper.isEqual(existing
					.getImportVO().getWhseFlushDate(), latest.getImportVO()
					.getWhseFlushDate()));
		} else {
			return !(CPSHelper.isEqual(existing.getCostLink(),
					latest.getCostLink())
					&& CPSHelper.isEqual(existing.getCostOwner(),
							latest.getCostOwner())
					&& CPSHelper.isEqual(existing.getCostOwnerVal(),
							latest.getCostOwnerVal())
					&& CPSHelper.isEqual(existing.getCountryOfOrigin(),
							latest.getCountryOfOrigin())
					&& CPSHelper.isEqual(existing.getCountryOfOriginVal(),
							latest.getCountryOfOriginVal())
					&& CPSHelper.isEqual(existing.isDealOffered(),
							latest.isDealOffered())
					&& CPSHelper.isEqual(existing.isGuarenteedSale(),
							latest.isGuarenteedSale())
					&& CPSHelper.isEqual(existing.getImportd(),
							latest.getImportd())
					&& CPSHelper.isEqual(existing.getListCost(),
							latest.getListCost())
					&& CPSHelper.isEqual(existing.getSeasonality(),
							latest.getSeasonality())
					&& CPSHelper.isEqual(existing.getSeasonalityVal(),
							latest.getSeasonalityVal())
					&& CPSHelper.isEqual(existing.getSeasonalityYr(),
							latest.getSeasonalityYr())
					&& CPSHelper.isEqual(existing.getTop2Top(),
							latest.getTop2Top())
					&& CPSHelper.isEqual(existing.getTop2TopVal(),
							latest.getTop2TopVal())
					&& CPSHelper.isEqual(existing.getUnitCost(),
							latest.getUnitCost())
					&& CPSHelper.isEqual(existing.getVendorLocation(),
							latest.getVendorLocation())
					&& CPSHelper.isEqual(existing.getVendorLocationVal(),
							latest.getVendorLocationVal())
					&& CPSHelper.isEqual(existing.getVendorTie(),
							latest.getVendorTie())
					&& CPSHelper.isEqual(existing.getVendorTier(),
							latest.getVendorTier())
					&& CPSHelper.isEqual(existing.getVpc(), latest.getVpc())
					&& CPSHelper.isEqual(existing.getUnitCostLabel(),
							latest.getUnitCostLabel())
					&& CPSHelper.isEqual(existing.getExpectedWeeklyMvt(),
							latest.getExpectedWeeklyMvt())
					&& CPSHelper.isEqual(existing.getOrderRestriction(),
							latest.getOrderRestriction())
					&& CPSHelper.isEqual(existing.getOrderRestrictionVal(),
							latest.getOrderRestrictionVal())
					&& CPSHelper.isEqual(existing.getOrderUnit(),
							latest.getOrderUnit()) && CPSHelper.isEqual(
					existing.getPssDept(), latest.getPssDept()));
		}
	}

	private void copyVendorVOtoVO(VendorVO from, VendorVO to) {
		to.setCostLink(from.getCostLink());
		to.setCostLinkRadio(from.isCostLinkRadio());
		to.setItemCodeRadio(from.isItemCodeRadio());
		to.setCostOwner(from.getCostOwner());
		to.setCostOwnerVal(from.getCostOwnerVal());
		to.setCountryOfOrigin(from.getCountryOfOrigin());
		to.setCountryOfOriginVal(from.getCountryOfOriginVal());
		to.setDealOffered(from.isDealOffered());
		to.setGuarenteedSale(from.isGuarenteedSale());
		to.setImportd(from.getImportd());
		to.setListCost(from.getListCost());
		to.setSeasonality(from.getSeasonality());
		to.setSeasonalityVal(from.getSeasonalityVal());
		to.setSeasonalityYr(from.getSeasonalityYr());
		to.setTop2Top(from.getTop2Top());
		to.setTop2TopVal(from.getTop2TopVal());
		to.setUnitCost(from.getUnitCost());
		to.setUnitCost(from.getUnitCost());
		to.setVendorLocation(from.getVendorLocation());
		to.setVendorLocationVal(from.getVendorLocationVal());
		to.setVendorTie(from.getVendorTie());
		to.setVendorTier(from.getVendorTier());
		to.setVpc(from.getVpc());
		to.setUnitCostLabel(from.getUnitCostLabel());
		to.setExpectedWeeklyMvt(from.getExpectedWeeklyMvt());
		to.setOrderRestriction(from.getOrderRestriction());
		to.setOrderRestrictionVal(from.getOrderRestrictionVal());
		// Order Unit changes
		to.setOrderUnit(from.getOrderUnit());
		// 958 enhancements
		to.setSubDept(from.getSubDept());
		// 958 PSS
		to.setPssDept(from.getPssDept());
		to.getImportVO()
				.setContainerSize(from.getImportVO().getContainerSize());
		to.getImportVO().setColor(from.getImportVO().getColor());
		to.getImportVO().setMinimumType(from.getImportVO().getMinimumType());
		to.getImportVO().setAgentPerc(from.getImportVO().getAgentPerc());
		to.getImportVO().setPickupPoint(from.getImportVO().getPickupPoint());
		to.getImportVO().setIncoTerms(from.getImportVO().getIncoTerms());
		to.getImportVO().setInstoreDate(from.getImportVO().getInstoreDate());
		to.getImportVO()
				.setWhseFlushDate(from.getImportVO().getWhseFlushDate());
		to.getImportVO().setFreight(from.getImportVO().getFreight());
		to.getImportVO()
				.setProrationDate(from.getImportVO().getProrationDate());
		to.getImportVO().setHts(from.getImportVO().getHts());
		to.getImportVO().setCartonMarketing(
				from.getImportVO().getCartonMarketing());
		to.getImportVO().setMinimumQty(from.getImportVO().getMinimumQty());
		to.getImportVO().setRate(from.getImportVO().getRate());
		to.getImportVO().setDuty(from.getImportVO().getDuty());

		// R2 enhancement
		to.getImportVO().setHts2(from.getImportVO().getHts2());
		to.getImportVO().setHts3(from.getImportVO().getHts3());
		to.getImportVO().setFactoryIDs(from.getImportVO().getFactoryIDs());
		// End R2 enhancement

		// Add season and sellYear
		to.getImportVO().setSeason(from.getImportVO().getSeason());
		to.getImportVO().setSellYear(from.getImportVO().getSellYear());
		// end add sellYear
		// add dutyInfo
		to.getImportVO().setDutyInfo(from.getImportVO().getDutyInfo());

	}

	public VendorVO removeVendorBeforeSave(String vendorUniqeId,
			String caseUniqueId) throws CPSGeneralException {
		CaseVO caseVO = this.getForm().getProductVO().getCaseVO(caseUniqueId);
		if (null == caseVO) {
			caseVO = this.getExistingCaseVO(caseUniqueId);
		}

		VendorVO vendorVO = caseVO.removeVendorVO(vendorUniqeId);
		if (CPSHelper.isNotEmpty(vendorVO)) {
			// Fix PIM 153
			try {
				CommonBridge.getAddNewCandidateServiceInstance()
						.deleteVendorNewFromCase(
								this.getForm().getProductVO().getPsProdId(),
								caseVO, vendorVO);
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return vendorVO;
	}

	public VendorVO removeVendor(String vendorUniqeId, String caseUniqueId)
			throws CPSGeneralException {
		CaseVO caseVO = this.getForm().getProductVO().getCaseVO(caseUniqueId);
		if (null == caseVO) {
			caseVO = this.getExistingCaseVO(caseUniqueId);
		}
		VendorVO vendorVOCurrent = caseVO.getVendorVO(vendorUniqeId);
		List<VendorVO> vendorVOs = new ArrayList<VendorVO>();
		vendorVOs.add(vendorVOCurrent);
		VendorVO vendMor = getVendorMorph(caseVO, vendorVOs);
		VendorVO vendorVO = caseVO.removeVendorVO(vendorUniqeId);
		if (CPSHelper.isNotEmpty(vendorVO)) {
			// Fix PIM 153
			try {
				CommonBridge.getAddNewCandidateServiceInstance()
						.deleteVendorNewFromCase(
								this.getForm().getProductVO().getPsProdId(),
								caseVO, vendorVO);
				String result = EMPTY_STRING;
				if (CPSHelper.isNotEmpty(vendMor)) {
					result = removeChildCase(caseVO);
				}
				if (CPSHelper.isNotEmpty(result)) {
					vendorVO.setPsItemWHSeDC(result);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return vendorVO;
	}

	private String removeChildCase(CaseVO caseVO) {
		List<CaseVO> caseVOList = this.getForm().getProductVO().getCaseVOs();
		try {
			CaseVO childCase = getCaseVOBasedOnRltShip(caseVO, caseVOList);
			if (CPSHelper.isNotEmpty(childCase)) {
				Integer psitem = childCase.getPsItemId();
				String childCaseUniqueId = childCase.getUniqueId();
				Number primaryScanCode = CommonBridge
						.getAddNewCandidateServiceInstance()
						.deleteCaseFromProduct(this.getForm().getProductVO(),
								childCase);
				this.getForm().getProductVO().setPrimaryUPC(primaryScanCode);
				this.getForm().getProductVO().removeCaseVO(childCaseUniqueId);
				return CPSHelper.getTrimmedValue(psitem);
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return EMPTY_STRING;
	}

	private VendorVO getVendorMorph(CaseVO caseVO,
			List<VendorVO> vendorVOCurrents) {
		List<CaseVO> caseVOList = this.getForm().getProductVO().getCaseVOs();
		CaseVO childCaseVO = null;
		try {
			childCaseVO = getCaseVOBasedOnRltShip(caseVO, caseVOList);
			if (CPSHelper.isNotEmpty(childCaseVO)) {
				List<VendorVO> vendorVOeDC = childCaseVO.getVendorVOs();
				VendorLocDeptVO vendLocDept = CommonBridge
						.getCommonServiceInstance().getVendorFromCache(
								"W-"
										+ vendorVOeDC.get(0)
												.getVendorLocationVal());
				if (CPSHelper.isNotEmpty(vendLocDept)) {
					if (vendorVOCurrents.size() == 1) {
						if (vendorVOCurrents
								.get(0)
								.getVendorLocationVal()
								.equals(CPSHelper.getTrimmedValue(vendLocDept
										.getApNbr()))) {
							return vendorVOCurrents.get(0);
						}
					} else if (vendorVOCurrents.size() > 1) {
						for (VendorVO vendorVOCurrent : vendorVOCurrents) {
							if (vendorVOCurrent.getVendorLocationVal().equals(
									CPSHelper.getTrimmedValue(vendLocDept
											.getApNbr()))) {
								return vendorVOCurrent;
							}
						}
					}
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}
		return null;
	}

	public CaseVO getCaseVOBasedOnRltShip(CaseVO parrentCaseVO,
			List<CaseVO> caseVOList) throws CPSBusinessException {
		CaseVO caseVO = null;
		if (CHANNEL_DSD.equals(parrentCaseVO.getChannel())) {
			Integer childPsItemId = getChildRelationalMorph(parrentCaseVO
					.getPsItemId());
			if (CPSHelper.isNotEmpty(childPsItemId)) {
				for (CaseVO eachCaseVO : caseVOList) {
					if (eachCaseVO.getPsItemId().equals(childPsItemId)) {
						caseVO = eachCaseVO;
						break;
					}
				}
				return caseVO;
			}
		}

		return null;
	}

	private Integer getChildRelationalMorph(Integer psItemId) {
		return CommonBridge.getAddNewCandidateServiceInstance()
				.getPsItemIdChild(psItemId);
	}

	public CaseVO removeCaseVO(String caseUniqueId)
			throws CPSBusinessException, CPSSystemException {
		List<CaseVO> caseVOList = this.getForm().getProductVO().getCaseVOs();
		CaseVO caseVO = new CaseVO();
		for (CaseVO eachCaseVO : caseVOList) {
			if (eachCaseVO.getUniqueId().equalsIgnoreCase(caseUniqueId)) {
				caseVO = eachCaseVO;
			}
		}
		if (caseVO.getNewDataSw() == CPSConstant.CHAR_N) {
			throw new CPSBusinessException(new CPSMessage(
					"Existing Case Cannot be deleted.", ErrorSeverity.ERROR));
		}

		if (CHANNEL_WHSDSD
				.equals(CPSHelper.getTrimmedValue(caseVO.getChannel()))) {
			CPSHelper.getChannelForMorph(caseVO);
		}
		String result = removeCaseVOeDCBasedOnCaseVO(caseVO, caseVOList);
		Number primaryScanCode = CommonBridge
				.getAddNewCandidateServiceInstance().deleteCaseFromProduct(
						this.getForm().getProductVO(), caseVO);
		this.getForm().getProductVO().setPrimaryUPC(primaryScanCode);

		this.getForm().getProductVO().removeCaseVO(caseUniqueId);
		if (CPSHelper.isNotEmpty(caseVO) && CPSHelper.isNotEmpty(result)) {
			caseVO.setRmCaseChild(result);
		}
		return caseVO;
	}

	private String removeCaseVOeDCBasedOnCaseVO(CaseVO caseVO,
			List<CaseVO> caseVOList) {
		if (CHANNEL_DSD.equals(CPSHelper.getTrimmedValue(caseVO.getChannel()))) {
			Integer childPsItmId = this.getChildRelationalMorph(caseVO
					.getPsItemId());
			CaseVO childCase = null;
			if (CPSHelper.isNotEmpty(childPsItmId)) {
				try {
					childCase = getCaseVOBasedOnRltShip(caseVO, caseVOList);
				} catch (CPSBusinessException e) {
					LOG.error(e.getMessage(), e);
				}
				if (CPSHelper.isNotEmpty(childCase)) {
					String childUniqueId = childCase.getUniqueId();
					CPSHelper.getChannelForMorph(childCase);
					try {
						CommonBridge.getAddNewCandidateServiceInstance()
								.deleteCaseFromProduct(
										this.getForm().getProductVO(),
										childCase);
						this.getForm().getProductVO()
								.removeCaseVO(childUniqueId);
						return CPSHelper.getTrimmedValue(childPsItmId);
					} catch (Exception e) {
						LOG.error(e.getMessage(), e);
					}
				}
			}
		}
		return null;
	}

	// @SuppressWarnings("unchecked")
	public IngdVO addIngdVO(String ingdCode, String ingdDesc, String seqNo)
			throws CPSGeneralException {

		if (CPSHelper.isEmpty(seqNo) || CPSHelper.isEmpty(ingdCode)) {
			throw new CPSBusinessException(
					new CPSMessage(
							"Please enter both Ingredient Statement and Sequence Number",
							ErrorSeverity.VALIDATION));
		}
		IngdVO ingdVO = new IngdVO();

		boolean check = false;

		List<IngdVO> ingdList = this.getForm().getProductVO().getScaleVO()
				.getIngdVOList();
		if (ingdList.size() > 0 && !ingdList.isEmpty()) {
			check = CPSWebUtil.isExistIngredient(ingdList, ingdCode);
		}
		if (!check) {
			ingdVO.setIngdCode(ingdCode);
			Map map = getCachedResults(ADD_CAND_INGREDIENT_TYPEAHEAD_ID);
			if (null != map) {
				String desc = (String) map.get(ingdVO.getIngdCode());
				ingdVO.setIngdDesc(desc + "[" + ingdVO.getIngdCode() + "]");
			}
			ingdVO.setSeqNo(seqNo);
			this.getForm().getProductVO().getScaleVO().addIngdVO(ingdVO);
		} else {
			throw new CPSBusinessException(new CPSMessage(
					"Ingredient Already Exists !!", ErrorSeverity.VALIDATION));
		}

		return ingdVO;

	}

	public IngdVO removeIngdVOFromSecond(String uniqueId) {
		return this.getForm().getProductVO().getScaleVO()
				.removeIngdVO(uniqueId);
	}

	public String randomNumberGenerator(String upcType, String productTypeValue)
			throws Exception {

		String returnString = EMPTY_STRING;

		int num1 = 1000000;
		int num2 = 9999999;
		double generator = Math.random() * (num2 - num1);
		generator = Math.round(num1 + generator);
		Double double1 = new Double(generator);
		long long1 = double1.longValue();
		returnString = Long.toString(long1) + "000";

		if ("ITUPC".equalsIgnoreCase(upcType)) {
			returnString = "-" + Long.toString(long1) + "000004";
		}

		return returnString;

	}

	// @SuppressWarnings("unchecked")
	public UPCVO addUPC(String upcType, String unitUpc1, String unitUpc12,
			boolean upcScenario, String unitSize, String unitMeasureDesc,
			String unitMeasureCode, String length, String width, String height,
			String size, String subBrand, String productType, String wic,
			String subName) throws Exception {
		boolean check = false;
		boolean dataBaseCheckForUPC = false;
		boolean itemMasterCheck = false;
		boolean flagUpdate = false;
		int statusCode = -2;
		unitUpc1 = (null == unitUpc1) ? CPSConstants.EMPTY_STRING : unitUpc1;
		String checkDigit = (null == unitUpc12) ? CPSConstants.EMPTY_STRING
				: unitUpc12;
		boolean checkDigitFlag = false;
		boolean itmCodeUPC = false;
		String checkDSVItem = null;
		// No check digit for ITMUPC.
		// No check DSV for ITMUPC
		if (!"ITUPC".equals(upcType)) {
			checkDigitFlag = this.isChkDigit(unitUpc1, checkDigit);
			checkDSVItem = CommonBridge.getCommonServiceInstance().checkDSV(
					unitUpc1);
		} else {
			checkDigitFlag = true;
			itmCodeUPC = true;
		}

		UPCVO upcvo = new UPCVO();
		upcvo.setMessage(CPSConstants.EMPTY_STRING);
		if (this.mandatoryFieldCheck(upcType, unitUpc1, unitSize, size,
				unitMeasureCode)) {
			List<String> list = new ArrayList<String>();
			String bufferMessage = getMessage(upcType, unitUpc1, unitSize,
					size, unitMeasureCode, list);
			upcvo.setMessage("Please enter " + bufferMessage + " fields");
			if (!list.isEmpty()) {
				upcvo.setFieldName(list.get(0));
			}
			return upcvo;
		} else {
			Object[] resultsWs;
			Boolean isExistsInProduction = Boolean.FALSE;

			// Check for duplicate upc for all UPC's other than ITMUPC
			if (!itmCodeUPC) {
				List<UPCVO> upcList = new ArrayList<UPCVO>();
				if (null != this.getForm().getProductVO()
						&& null != this.getForm().getProductVO().getUpcVO()) {
					upcList = this.getForm().getProductVO().getUpcVO();
				}
				if (upcList.size() > 0 && !upcList.isEmpty()) {
					check = CPSWebUtil.isExistUpc(upcList, unitUpc1);
				}
				try {
					resultsWs = CommonBridge
							.getAddNewCandidateServiceInstance()
							.checkExistingProductUPC(unitUpc1);
					if(resultsWs!=null && resultsWs[2] != null && String.valueOf(resultsWs[2]).equals(BusinessConstants.SERVICE_ERROR_RECORDS_FAILED)){
						throw new CPSSystemException(new CPSMessage(BusinessConstants.SERVICE_ERROR, ErrorSeverity.ERROR));
					}
				} catch (CPSSystemException e) {
					LOG.error(e.getMessage(), e);
					CPSMessage msg = e.getCPSMessage();
					String errMsg = "Service Error";
					if (CPSHelper.isNotEmpty(msg)) {
						errMsg = msg.getMessage();
					}
					throw new CPSSystemException(new CPSMessage(errMsg,
							ErrorSeverity.ERROR));
				}
				if(resultsWs!=null) {
					isExistsInProduction = (Boolean) resultsWs[0];
					//Sprint - 23
					if(isExistsInProduction==Boolean.TRUE) {
						Set<Integer> prodIds =  new HashSet<Integer>();
						prodIds.add((Integer)resultsWs[1]);
						Map<Integer, Boolean> upcKits = CommonBridge
						.getAddNewCandidateServiceInstance().getKitComponentsActiveProduct(prodIds);
						if(CPSHelper.isNotEmpty(upcKits) && upcKits.size()>0) {
							upcvo.setMessage("A kit UPC cannot be added to another candidate/product.");
							return upcvo;
						}
					} else {
				if (isExistsInProduction == Boolean.FALSE) {
					statusCode = CommonBridge
							.getAddNewCandidateServiceInstance()
							.checkExistingUPCType(unitUpc1);
					if (checkFormatPLU(unitUpc1)) {
						if (statusCode == 103 || statusCode == 107
								|| statusCode == 109) {
							dataBaseCheckForUPC = true;
						} else {
							unitUpc1 = CPSHelper.getPadding(unitUpc1);
							String strUpc = EMPTY_STRING;
							String strUPCTemp = EMPTY_STRING;
							if (unitUpc1.startsWith("002")
									&& unitUpc1.endsWith("00000")) {
								strUpc = unitUpc1.substring(3,
										unitUpc1.length() - 5);
								strUPCTemp = "00000000" + strUpc;
							} else if (unitUpc1.startsWith("00000000")) {
								strUpc = unitUpc1.substring(8);
								strUPCTemp = "002" + strUpc + "00000";
							}
							statusCode = CommonBridge
									.getAddNewCandidateServiceInstance()
									.checkExistingUPCType(strUPCTemp);
							if (statusCode == 103 || statusCode == 107
									|| statusCode == 109) {
								Integer psProdIdNew = CommonBridge
										.getAddNewCandidateServiceInstance()
										.getCandidateByUpc(strUPCTemp);
								// get UPC true. HungBang Added QC 2026.
								// 03.Mar.2016
								if (CPSHelper.isEmpty(this.getForm()
										.getProductVO().getPsProdId())
										|| (!psProdIdNew.equals(this.getForm()
												.getProductVO().getPsProdId()))) {
									unitUpc1 = strUPCTemp;
									dataBaseCheckForUPC = true;
								}
							}
						}
					} else {
						if (statusCode == 103 || statusCode == 107
								|| statusCode == 109 || statusCode == 105) {
							dataBaseCheckForUPC = true;
						}
						// Fix 511. check in PS_ITEM_MASTER
						if (!dataBaseCheckForUPC) {
							itemMasterCheck = CommonBridge
									.getAddNewCandidateServiceInstance()
									.checkUPCDeleteExistsInItemMaster(unitUpc1);
						}
					}
				}
			}
				}
			}
			if (!check && checkDigitFlag && !dataBaseCheckForUPC
					&& isExistsInProduction == Boolean.FALSE
					&& !itemMasterCheck && (CPSHelper.isEmpty(checkDSVItem))) {
				if (itmCodeUPC) {
					upcvo.setUnitUpc(randomNumberGenerator(upcType,
							EMPTY_STRING));
				} else {
					upcvo.setUnitUpc(CPSHelper.getPadding(unitUpc1));
				}
				upcvo.setUnitUpc10(checkDigit);
				upcvo.setUpcType(upcType);
				upcvo.setLength(length);
				upcvo.setHeight(height);
				upcvo.setWidth(width);
				upcvo.setSize(size);
				upcvo.setSubBrand(subBrand);
				if (upcScenario)
					upcvo.setBonus(true);
				else
					upcvo.setBonus(false);
				upcvo.setUnitSize(unitSize);
				upcvo.setUnitMeasureDesc(unitMeasureDesc);
				upcvo.setUnitMeasureCode(unitMeasureCode);
				if (CPSHelper.isEmpty(subBrand)) {
					upcvo.setSubBrandDesc(EMPTY_STRING);
				} else {
					upcvo.setSubBrandDesc(subName);
				}

				if (CPSHelper.isNotEmpty(wic)) {
					upcvo.setWic(wic);
					try {
						if (Long.parseLong(wic) > 0) {
							upcvo.setWicUPC(true);
						}
					} catch (NumberFormatException num) {
						upcvo.setWicUPC(false);
					}
				}
				this.getForm().getProductVO().addUpcVO(upcvo);

				if (this.containsScaleUPC()) {
					upcvo.setContainsScaleUPC(CPSConstant.CHAR_Y);
					this.getForm().getProductVO().getScaleVO().setScaleSw(CPSConstant.CHAR_Y);
					this.getForm().getProductVO().setScaleUPC(true);
					this.getForm().getProductVO().setOnlyCheckerUPC(false);
					this.getForm().setScaleAttrib("I");

				} else {
					upcvo.setContainsScaleUPC(CPSConstant.CHAR_N);
				}

				if (this.getForm().isMrtUpcAdded()) {
					this.getForm().setMrtUpcAdded(false);
				}
				// Fix PIM-452
				// HungBang Scale Session
				if (checkFormatPLU(unitUpc1)) {
					updatePluAndScaleExits(unitUpc1, flagUpdate);
				}
				//PIM-1484
				if(this.getForm().getProductVO()!=null && this.getForm().getProductVO().getPointOfSaleVO()!=null && this.getForm().getProductVO().getPointOfSaleVO().getFdaMenuLabelingStatus().equalsIgnoreCase(BusinessConstants.PENDING_NUTRITION)) {
					List<BigInteger> scnCdIds = new ArrayList<BigInteger>();
					String fdaMenuLablingStatus = BusinessConstants.PENDING_NUTRITION;
					if(CPSHelper.isValidNumber(upcvo.getUnitUpc()) && this.getForm().getProductVO().getWorkRequest()!=null && this.getForm().getProductVO().getPsProdId() !=null) {
						scnCdIds.add(new BigInteger(upcvo.getUnitUpc()));
						fdaMenuLablingStatus = CommonBridge.getAddNewCandidateServiceInstance().getFdaMenuLabelingStatus(this.getForm().getProductVO().getWorkRequest().getWorkIdentifier(), false, scnCdIds,this.getForm()
								.getProductVO().getPsProdId());
					}
					upcvo.setFdaMenuLabelingStatus(fdaMenuLablingStatus);
				} else {
					upcvo.setFdaMenuLabelingStatus(BusinessConstants.NUTRITION_AVAILABLE);
				}
				// End Fix
				upcvo.setMessage("SUCCESS");
				return upcvo;
			} else {
				if (!checkDigitFlag) {

					upcvo

					.setMessage("InValid Check Digit. Please Re-enter the UPC/Checkdigit Value");
				} else if (CPSHelper.isNotEmpty(checkDSVItem)) {
					upcvo.setMessageCheckDSV(checkDSVItem);
				} else {
					if (dataBaseCheckForUPC) {
						upcvo.setMessage(String.valueOf(statusCode));
					} else if (itemMasterCheck) {
						upcvo.setMessage("UPC Exists. Please enter another UPC");
					} else if (isExistsInProduction == null) {
						// Fix PIM-452
						if (!flagUpdate) {
							if (checkFormatPLU(unitUpc1)) {
								updatePluAndScaleExits(unitUpc1, flagUpdate);
							}
						}
						// End Fix
						upcvo.setMessage("Application could not determine if UPC already exists");
					} else {
						// Fix PIM-452
						if (!flagUpdate) {
							if (checkFormatPLU(unitUpc1)) {
								updatePluAndScaleExits(unitUpc1, flagUpdate);
							}
						}
						// End Fix
						upcvo.setMessage("UPCEXISTS");
					}
				}
				upcvo.setUnitUpc(unitUpc1);
				return upcvo;
			}
		}
	}

	private boolean checkFormatPLU(String unitUpc1) {
		unitUpc1 = CPSHelper.getPadding(unitUpc1);
		return (unitUpc1.startsWith("002") && unitUpc1.endsWith("00000"))
				|| (unitUpc1.startsWith("00000000"));
	}

	private void updatePluAndScaleExits(String unitUpc1, boolean flagUpdate)
			throws CPSGeneralException {
		flagUpdate = true;
		String strUpc = EMPTY_STRING;
		String pluType = "S";
		if (unitUpc1.startsWith("002") && unitUpc1.endsWith("00000")) {
			strUpc = unitUpc1.substring(3, unitUpc1.length() - 5);
			pluType = "S";
		} else if (unitUpc1.startsWith("00000000")) {
			strUpc = unitUpc1.substring(8);
			pluType = "C";
		}
		if (CPSHelper.isNotEmpty(strUpc)) {
			CommonBridge.getAddNewCandidateServiceInstance().updatePluExists(
					Integer.valueOf(strUpc), pluType);
		}

	}

	private String getMessage(String upcType, String unitUpc1, String unitSize,
			String size, String unitMeasureCode, List<String> list) {
		StringBuffer missingField = new StringBuffer();
		missingField.append(CPSConstants.EMPTY_STRING);
		String check = ZERO_STRING;
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(upcType)
				|| "--Select--".equalsIgnoreCase(upcType) || null == upcType) {
			missingField.append("UPC Type");
			check = "1";
			list.add("upcType1");
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(unitUpc1)) {
			if ("1".equalsIgnoreCase(check)) {
				missingField.append(",");
			}
			missingField.append("Unit UPC ");
			check = "1";
			list.add("unitUpc1");
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(unitSize)) {
			if ("1".equalsIgnoreCase(check)) {
				missingField.append(",");
			}
			missingField.append("Unit Size ");
			check = "1";
			list.add("unitSize1");
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(size)) {
			if ("1".equalsIgnoreCase(check)) {
				missingField.append(",");
			}
			missingField.append("Size ");
			check = "1";
			list.add("size");
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(unitMeasureCode)) {
			if ("1".equalsIgnoreCase(check)) {
				missingField.append(",");
			}
			missingField.append("Unit of Measure ");
			list.add("unitOfMeasure1");
		}
		return missingField.toString();
	}

	private boolean mandatoryFieldCheck(String upcType, String unitUpc1,
			String unitSize, String size, String unitMeasureCode) {
		boolean success = false;
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(upcType)
				|| "--Select--".equalsIgnoreCase(upcType)
				|| CPSConstants.EMPTY_STRING.equalsIgnoreCase(unitUpc1)
				|| CPSConstants.EMPTY_STRING.equalsIgnoreCase(unitMeasureCode)
				|| CPSConstants.EMPTY_STRING.equals(unitSize)
				|| CPSConstants.EMPTY_STRING.equalsIgnoreCase(size)) {
			success = true;
		}
		return success;
	}

	public String validateDepositUPC(String depositUPC) throws Exception {
		String returnString = "Fails";
		if (null != depositUPC && !CPSConstants.EMPTY_STRING.equals(depositUPC)) {
			try {
				if (CommonBridge.getAddNewCandidateServiceInstance()
						.checkExistProdByUpcBinding5(depositUPC)) {
					returnString = "Success";
				}
			} catch (CPSGeneralException e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return returnString;
	}

	public MRTUPCVO showMRT(String unitUpc, String unitUpcCheckDigit,
			String sellableUnits) throws Exception {
		MRTUPCVO mrtVO = new MRTUPCVO();
		ProductVO productVO = new ProductVO();
		boolean check = true;
		boolean fakePredigitUPC = false;
		unitUpc = (null == unitUpc) ? CPSConstants.EMPTY_STRING : CPSHelper
				.getPadding(unitUpc);
		unitUpcCheckDigit = (null == unitUpcCheckDigit) ? CPSConstants.EMPTY_STRING
				: unitUpcCheckDigit;
		sellableUnits = (null == sellableUnits || CPSConstants.EMPTY_STRING
				.equalsIgnoreCase(sellableUnits)) ? CPSConstant.STRING_0
				: sellableUnits;
		mrtVO.setMessage(CPSConstants.EMPTY_STRING);
		if (CPSConstants.EMPTY_STRING.equals(unitUpc)) {
			mrtVO.setMessage("Please enter UPC Value");
		} else {
			// Fix 1274
			fakePredigitUPC = CPSHelper.isFakePredigitUPC(unitUpc);
			if (!fakePredigitUPC) {
				List<MRTUPCVO> mrtList = this.getForm().getMrtvo().getMrtVOs();
				check = CPSWebUtil.isExistingUpc(mrtList, unitUpc);
				boolean flagWebService = true;
				if (check && this.isValidCheckDigit(unitUpc, unitUpcCheckDigit)) {
					try {
						productVO = CommonBridge
								.getAddNewCandidateServiceInstance()
								.getProductBasicForAddUpcMrt(unitUpc);
						flagWebService = true;
					} catch (CPSBusinessException e) {
						LOG.error(e.getMessage(), e);
					} catch (CPSSystemException ex) {
						LOG.error(ex.getMessage(), ex);
						mrtVO.setApproval("No");
						flagWebService = false;
						mrtVO.setDescription(EMPTY_STRING);
					}
					//Sprint - 23
					if (flagWebService && productVO.isActiveProductKit()) {
						mrtVO.setMessage("A kit cannot be part of an MRT.");
					} else {
						if (null == productVO.getProdId() && flagWebService) {
							mrtVO = CommonBridge
									.getAddNewCandidateServiceInstance()
									.getMRTDetails(unitUpc);
							if(mrtVO.getProductVO()!=null && mrtVO.getProductVO().getWorkRequest().getIntentIdentifier()==12) {
								mrtVO.setMessage("A kit cannot be part of an MRT.");
								return mrtVO;
							} else {
								this.getForm().setProductVO(mrtVO.getProductVO());
							}
						} else {
							mrtVO.setApproval("No");
							if (flagWebService) {
								mrtVO.setDescription(productVO
										.getClassificationVO().getProdDescritpion());
							}
							setItemCode(mrtVO, productVO);
							mrtVO.setProductVO(productVO);
							this.getForm().setProductVO(mrtVO.getProductVO());
						}
						mrtVO.setUnitUPC(unitUpc);
						mrtVO.setUnitUPCCheckDigit(unitUpcCheckDigit);
						/*
						 * Check validation number for sellable unit and calculate
						 * total.
						 *
						 * @author khoapkl
						 */
						if (CPSHelper.isValidNumber(sellableUnits)
								&& !CPSHelper.isFakeUPC(mrtVO.getUnitUPC())) {
							mrtVO.setUnitTotalAttribute((Integer
									.parseInt(sellableUnits) + this.getForm()
									.getMrtvo().getMrtUpcVO()
									.getUnitTotalAttribute()));
						} else if (CPSHelper.isValidNumber(sellableUnits)) {
							mrtVO.setUnitTotalAttribute(this.getForm().getMrtvo()
									.getMrtUpcVO().getUnitTotalAttribute());
						}
						this.getForm()
								.getMrtvo()
								.getMrtUpcVO()
								.setUnitTotalAttribute(
										mrtVO.getUnitTotalAttribute());
						mrtVO.setSellableUnits(sellableUnits);
						this.getForm().getMrtvo().addMRTVO(mrtVO);
						// PIM 779
						mrtVO.setMrtUPCSaved(true);
						if (CPSHelper.isNotEmpty(mrtVO.getDescription())
								&& !mrtVO.getDescription().equalsIgnoreCase(
										NO_DESCRIPTION)
								&& !CPSHelper.isFakeUPC(mrtVO.getUnitUPC())
								&& !EMPTY_STRING.equals(mrtVO.getDescription())) {
							mrtVO.setSelected(true);
						}
						addMRTChild(mrtVO);
						mrtVO.setExistingMRT(this.getForm().getMrtvo()
								.isExistingMRT());

						// Fix 1289. If upc is added after the case is saved, update
						// the vendor list
						CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();
						if (CPSHelper.isNotEmpty(caseVO)
								&& CPSHelper.isNotEmpty(caseVO.getChannel())) {
							this.setVendorValuesForMRT(caseVO.getChannel());
						}
					}
				} else {
					if (check) {
						mrtVO.setMessage("InValid Check Digit. Please Re-enter the UPC/Checkdigit Value");
					} else {
						mrtVO.setMessage("Existing UPC");
					}
				}
			} else {
				mrtVO.setMessage("Parent fake pre-digit UPC cannot be entered. Please enter another UPC");
			}

		}
		return mrtVO;
	}

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
				if (productVO.getCaseVOs().get(0).getChannelVal().trim()
						.equalsIgnoreCase(CPSConstants.CHANNEL_DSD)) {
					mrtVO.setItemCode(CPSConstants.CHANNEL_DSD);
				} else {
					mrtVO.setItemCode(productVO.getCaseVOs().get(0).getItemId()
							+ CPSConstants.EMPTY_STRING);
				}
			}
		}
	}

	public String setVendorValuesForMRTCheck(String channel)
			throws CPSGeneralException {
		String returnString = "Fails";
		if (null == channel || CPSConstants.EMPTY_STRING.equals(channel.trim())) {
			return returnString;
		}
		if (null != this.getForm() && null != this.getForm().getMrtvo()) {
			List<MRTUPCVO> mrtList = this.getForm().getMrtvo().getMrtVOs();
			if (null != mrtList && !mrtList.isEmpty()) {
				returnString = "Success";
			}
		}

		return returnString;
	}

	@SuppressWarnings("unchecked")
	public List<BaseJSFVO> setVendorValuesForMRT(String channel) throws CPSGeneralException {
		String chnlVal = EMPTY_STRING;
		if (null == channel || CPSConstants.EMPTY_STRING.equals(channel.trim())) {
			return new ArrayList<BaseJSFVO>();
		}
		chnlVal = CPSWebUtil.getChannelValForService(channel);
		List<MRTUPCVO> mrtList = this.getForm().getMrtvo().getMrtVOs();
		Set<BaseJSFVO> vos = new HashSet<BaseJSFVO>();
		List<VendorLocationVO> vendorList = new ArrayList<VendorLocationVO>();

		for (MRTUPCVO mrtupcvo : mrtList) {
			// Fix 1229
			if (CPSHelper.isNotEmpty(mrtupcvo.getDescription()) && !mrtupcvo.getDescription().equalsIgnoreCase(NO_DESCRIPTION)
					&& !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC()) && !(EMPTY_STRING).equals(mrtupcvo.getDescription())) {
				try {
					this.getForm().setProductVO(mrtupcvo.getProductVO());
					try {
						this.initProductVO(mrtupcvo);
					} catch (Exception e) {
					}
					vendorList.addAll(this.setVendorValuesForMRT(chnlVal,mrtupcvo));
				} catch (Exception e) {
				}
			}
		}



		// Fix 1289
		this.getForm().getVendorVO().setVendorLocationList(vendorList);
		List<BaseJSFVO> result = new ArrayList<BaseJSFVO>();
		if (!vendorList.isEmpty()) {
			vos.addAll(VendorLocationVO.toBaseJSFVOList(vendorList));
			result.addAll(vos);
			Collections.sort(result);
			result = CPSHelper.insertBlankSelect(result);
		}

		return result;
	}


	private List<VendorLocationVO> filterDSDVendorFromListOnly(List<VendorLocationVO> vendorList) {
		// TODO Auto-generated method stub
		List<VendorLocationVO> vendorListRe = new ArrayList<VendorLocationVO>();

		for (VendorLocationVO vendorLocationVO : vendorList) {

			if(vendorLocationVO.getVendorLocationType().equals(CPSConstants.CHANEL_DSD)){
				vendorListRe.add(vendorLocationVO);
			}
		}
		return vendorListRe;
	}

	public String setVendorValuesForMRTTemp(String channel) throws CPSGeneralException {
		String chnlVal = EMPTY_STRING;
		String str = EMPTY_STRING;
		chnlVal = CPSWebUtil.getChannelValForService(channel);
		List<MRTUPCVO> mrtList = this.getForm().getMrtvo().getMrtVOs();
		List<VendorLocationVO> vendorList = new ArrayList<VendorLocationVO>();
		for (MRTUPCVO mrtupcvo : mrtList) {
			// Fix 1229
			if (CPSHelper.isNotEmpty(mrtupcvo.getDescription()) && !mrtupcvo.getDescription().equalsIgnoreCase(NO_DESCRIPTION)
					&& !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC()) && !EMPTY_STRING.equals(mrtupcvo.getDescription())) {
				try {
					this.getForm().setProductVO(mrtupcvo.getProductVO());
					try {
						this.initProductVO(mrtupcvo);
					} catch (Exception e) {
						LOG.error(e.getMessage(), e);
					}
					vendorList.addAll(this.setVendorValuesForMRT(chnlVal, mrtupcvo));
					str = "success";
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
					str = "fails";
				}
			}
		}
		// Fix 1289
		this.getForm().getVendorVO().setVendorLocationList(vendorList);
		return str;
	}

	// @SuppressWarnings("unchecked")
	private List<VendorLocationVO> setVendorValuesForMRT(String chnlVal, MRTUPCVO mrtupcvo) throws CPSGeneralException {
		List<VendorLocationVO> vos;
		try {
			String deptNbr = this.getForm().getClassCommodityVO(mrtupcvo.getProductVO().getClassificationVO().getCommodity()).getDeptId();
			String subDeptNbdr = this.getForm().getClassCommodityVO(mrtupcvo.getProductVO().getClassificationVO().getCommodity()).getSubDeptId();
			String classField = mrtupcvo.getProductVO().getClassificationVO().getClassField();
			String commodityVal = mrtupcvo.getProductVO().getClassificationVO().getCommodity();

			String mrtCasePckClss = EMPTY_STRING;

			if(CPSHelper.isNotEmpty(this.getForm().getMrtvo()) && CPSHelper.isNotEmpty(this.getForm().getMrtvo().getCaseVO())){
				mrtCasePckClss = this.getForm().getMrtvo().getCaseVO().getClassCode();
			}
			if (CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
				this.getForm().updateVendorList(deptNbr, subDeptNbdr,classField, null, chnlVal);
			} else if (CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
				if((!CPSHelper.isEmpty(mrtCasePckClss) && mrtCasePckClss.equals(classField)) || CPSHelper.isEmpty(mrtCasePckClss)){
					this.getForm().updateVendorList(null, null, classField,commodityVal, chnlVal);
				}
			} else {
				this.getForm().updateVendorList(deptNbr, subDeptNbdr,classField, commodityVal, chnlVal);

				if(!CPSHelper.isEmpty(mrtCasePckClss) && !mrtCasePckClss.equals(classField)){
					List<VendorLocationVO> tmpLst = filterDSDVendorFromListOnly(this.getForm().getVendorVO().getVendorLocationList());
					this.getForm().getVendorVO().setVendorLocationList(tmpLst);
				}
			}
			vos = this.getForm().getVendorVO().getVendorLocationList();
			mrtupcvo.setSelected(true);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			vos = new ArrayList<VendorLocationVO>();
		}
		return vos;
	}

	@SuppressWarnings("unchecked")
	public List<BaseJSFVO> setCostOwnerValuesForMRT() {
		List<MRTUPCVO> mrtList = this.getForm().getMrtvo().getMrtVOs();
		List<BaseJSFVO> mrtCostOwners = new ArrayList<BaseJSFVO>();
		List<BaseJSFVO> costOwner = null;
		// fix reset cost owner list when update brand
		this.getForm().setCostOwners(new ArrayList<BaseJSFVO>());
		for (MRTUPCVO mrtupcvo : mrtList) {
			// Fix 1229
			if (CPSHelper.isNotEmpty(mrtupcvo.getDescription())
					&& !mrtupcvo.getDescription().equalsIgnoreCase(
							NO_DESCRIPTION)
					&& !CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())
					&& !(EMPTY_STRING).equals(mrtupcvo.getDescription())) {
				try {
					costOwner = new ArrayList<BaseJSFVO>();
					String brandId = mrtupcvo.getProductVO()
							.getClassificationVO().getBrand();
					if (CPSHelper.isNotEmpty(brandId)) {
						costOwner = updateMRTCostOwner(brandId);
					}
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
				}
				// Fix 1289
				if (CPSHelper.isNotEmpty(costOwner)) {
					mrtCostOwners.addAll(costOwner);
				}
			}
		}
		// Fix 1289
		mrtCostOwners = CPSHelper.getUniqueList(mrtCostOwners);
		this.getForm().setCostOwners(mrtCostOwners);
		return CPSHelper.insertBlankSelect(mrtCostOwners);
	}

	public List<BaseJSFVO> updateMRTCostOwner(String brandId)
			throws CPSGeneralException {
		Integer brand = CPSHelper.getIntegerValue(brandId);
		return CommonBridge
				.getAddNewCandidateServiceInstance().getCostOwnerbyBrand(brand);
	}

	private void initProductVO(MRTUPCVO mrtupcvo) throws CPSGeneralException {

		ProductVO productVO = mrtupcvo.getProductVO();
		Map<String, ClassCommodityVO> existingMap = this.getForm()
				.getClassCommodityMap();

		Map<String, ClassCommodityVO> map = CommonBridge
				.getCommonServiceInstance().getCommoditiesForBDM(
						productVO.getClassificationVO().getAlternateBdm());

		if (CPSHelper.isNotEmpty(existingMap)) {
			if (CPSHelper.isEmpty(map)) {
				map = new HashMap<String, ClassCommodityVO>();
			}
			map.putAll(existingMap);
		}
		this.getForm().setClassCommodityMap(map);
		this.getForm().setBrickMap(
				this.clearBrickMap(this.getForm().getBrickMap()));
		this.initClassField(productVO);
	}

	private void initClassField(ProductVO productVO) {
		String commCode = productVO.getClassificationVO().getCommodity();
		BaseJSFVO classVO = (BaseJSFVO) this.getForm().getClassForCommodity(
				commCode);
		productVO.getClassificationVO().setClassField(classVO.getId());
		productVO.getClassificationVO().setClassDesc(
				classVO.getName() + " [" + classVO.getId() + "]");

	}

	private boolean isValidCheckDigit(String unitUpc, String unitUpcCheckDigit) {
		boolean success = false;
		int checkDigit = CPSHelper.calculateCheckDigit(unitUpc);
		if (unitUpcCheckDigit.equalsIgnoreCase(CPSHelper
				.getTrimmedValue(checkDigit)))
			success = true;
		return success;
	}

	private boolean isChkDigit(String unitUpc1, String checkDigit) {
		boolean success = false;
		/**
		 * if the candidate is non-sellable then there in no need of check
		 * digit.
		 */
		int checkDig = CPSHelper.calculateCheckDigit(unitUpc1);
		if (checkDigit.equalsIgnoreCase(CPSHelper.getTrimmedValue(CPSHelper
				.getStringValue(checkDig))))
			success = true;
		return success;
	}


	/**
	 * This method is for tracking the UPC if the entered UPC is wrong for more
	 * than two times
	 */
	public UPCVO verifyCheckDigit(String unitUpc, String unitUpcCheckDigit) {
		boolean firstCheck = true;
		AddNewCandidate addNewCandidate = this.getForm();
		UPCVO upcvo = new UPCVO();
		if (CPSHelper.isNotEmpty(unitUpc)) {
			unitUpc = unitUpc.trim();
		}
		if (!unitUpc.matches("[0-9]+") || !unitUpcCheckDigit.matches("[0-9]+")) {
			upcvo.setMessage("numberFormatError");
			return upcvo;
		}
		firstCheck = this.isValidCheckDigit(unitUpc, unitUpcCheckDigit);
		if (!firstCheck && false == addNewCandidate.isUpcCheck()) {
			addNewCandidate.setUpcCheck(true);
			upcvo.setMessage("firstTimeError");
			return upcvo;
		} else if (!firstCheck && true == addNewCandidate.isUpcCheck()) {
			addNewCandidate.setUpcCheck(false);
			upcvo.setMessage("secondTimeError");
			upcvo.setUnitUpc(unitUpc);
			upcvo.setWorkRequest(addNewCandidate.getProductVO().getWorkRequest());
			return upcvo;
		} else {
			upcvo.setMessage("correctCheckDigit");
			return upcvo;
		}

	}

	// END - Defect #33 Merged with US Tech.

	/**
	 * This method is for tracking the UPC if the entered UPC is wrong for more
	 * than two times
	 */
	public boolean verifyCheckDigitForCase(String unitUpc,
			String unitUpcCheckDigit) {
		boolean valid = true;

		if (!unitUpc.matches("[0-9]+") || !unitUpcCheckDigit.matches("[0-9]+")) {
			valid = false;
		} else {
			valid = this.isValidCheckDigit(unitUpc, unitUpcCheckDigit);
		}
		return valid;
	}

	// To delete the UPC(MRT) from the data table
	public MRTUPCVO purgeMRT(String uniqueId) throws Exception {
		Integer psItmId = this.getForm().getMrtvo().getCaseVO().getPsItemId();
		MRTUPCVO mrtupcvo = this.getForm().getMrtvo().getMrtVO(uniqueId);
		if (mrtupcvo.isMrtUPCSaved()) {
			if (null != psItmId && 0 != psItmId) {
				CommonBridge.getAddNewCandidateServiceInstance().purgeMrtUpc(
						mrtupcvo, psItmId);
			}
		}
		/*
		 * update unit total attribute after remove
		 *
		 * @author khoapkl
		 */
		if (!CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())) {
			mrtupcvo.setUnitTotalAttribute(this.getForm().getMrtvo()
					.getMrtUpcVO().getUnitTotalAttribute()
					- Integer.parseInt(mrtupcvo.getSellableUnits()));
		}
		if (!CPSHelper.isFakeUPC(mrtupcvo.getUnitUPC())) {
			this.getForm().getMrtvo().getMrtUpcVO()
					.setUnitTotalAttribute(mrtupcvo.getUnitTotalAttribute());
		}
		// Fix 1289. If upc is deleted after the case is saved, update the
		// vendor list
		CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();
		if (CPSHelper.isNotEmpty(caseVO)
				&& CPSHelper.isNotEmpty(caseVO.getChannel())) {
			this.setVendorValuesForMRT(caseVO.getChannel());
		}
		MRTUPCVO mrtUpcVO = this.getForm().getMrtvo().removeMRTVO(uniqueId);
		if (null != this.getForm().getMrtvo().getMrtVOPrints()
				&& !this.getForm().getMrtvo().getMrtVOPrints().isEmpty()) {
			this.getForm().getMrtvo().getMrtVOPrints().remove(mrtUpcVO);
		}
		return mrtUpcVO;
	}

	public CaseItemVO addMRT(int caseID, String caseDescription,
			String avgWHSCost) {
		CaseItemVO itemVO = new CaseItemVO();
		itemVO.setCaseID(caseID);
		itemVO.setCaseDescription(caseDescription);
		// itemVO.setCriticalItemInd(criticalItemInd);
		itemVO.setAvgWHSCost(avgWHSCost);
		this.getForm().addCaseItems(itemVO);
		return itemVO;
	}

	public CaseItemVO removeMRT(String uniqueId) {
		return this.getForm().removeCaseItemVO(uniqueId);
	}

	public UPCVO removeUPC(String temp) throws Exception {
		ProductVO productVO = this.getForm().getProductVO();
		UPCVO upcvo = productVO.getUpcVO(temp);
		int prodid = upcvo.getPsProdId();
		if (0 != prodid) {
			CommonBridge.getAddNewCandidateServiceInstance().purgeUpcVo(upcvo);
			if (productVO.getPrimaryUPC() != null
					&& Long.parseLong(upcvo.getUnitUpc()) == productVO
							.getPrimaryUPC().longValue()) {
				productVO.setPrimaryUPC(null);
			}
		}
		upcvo = productVO.removeUPC(temp);
		try {
			CommonBridge.getAddNewCandidateServiceInstance().purgePluUpc(upcvo,
					productVO.getUpcVO());
			//PIM-1484
			if(this.getForm().getProductVO()!=null && this.getForm().getProductVO().getPointOfSaleVO()!=null && this.getForm().getProductVO().getPointOfSaleVO().getFdaMenuLabelingStatus().equalsIgnoreCase(BusinessConstants.NUTRITION_AVAILABLE)) {
				List<BigInteger> scnCdIds = new ArrayList<BigInteger>();
				String fdaMenuLablingStatus = BusinessConstants.NUTRITION_AVAILABLE;
				if(CPSHelper.isValidNumber(upcvo.getUnitUpc())) {
					scnCdIds.add(new BigInteger(upcvo.getUnitUpc()));
					fdaMenuLablingStatus = CommonBridge.getAddNewCandidateServiceInstance().getFdaMenuLabelingStatus(this.getForm().getProductVO().getWorkRequest().getWorkIdentifier(), false, scnCdIds,this.getForm()
							.getProductVO().getPsProdId());
				}
				upcvo.setFdaMenuLabelingStatus(fdaMenuLablingStatus);
			}
			//PIM 1218
			CommonBridge.getAddNewCandidateServiceInstance().deleteAllDocByProductScn(upcvo.getUnitUpc());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		if (this.getForm().getCaseVO() != null) {
			List<CaseVO> caseVOs = productVO.getCaseVOs();
			for (CaseVO caseVO : caseVOs) {
				caseVO.removeCaseUpcVOs(upcvo.getUnitUpc());
			}
		}
		if (this.containsScaleUPC()) {
			upcvo.setContainsScaleUPC(CPSConstant.CHAR_Y);
		} else {
			upcvo.setContainsScaleUPC(CPSConstant.CHAR_N);
		}
		return upcvo;
	}

	public List<String> changeListCost(String uniqueId, String listCost) {
		String cstGrp = this.getForm().getStoreVO(uniqueId).getCostGroup();
		List<String> uniqIds = new ArrayList<String>();
		for (StoreVO storeVO : this.getForm().getStoreVOs()) {
			String costGrp = storeVO.getCostGroup();
			if (null != costGrp && costGrp.equals(cstGrp)) {
				uniqIds.add(storeVO.getUniqueId());
				storeVO.setListCost(listCost);
			}
		}
		return uniqIds;
	}

	public List<String> changeListCostByCostGp(String costGroup, String listCost) {
		List<String> uniqIds = new ArrayList<String>();
		for (StoreVO storeVO : this.getForm().getStoreVOs()) {
			String costGrp = storeVO.getCostGroup();
			if (null != costGrp && costGrp.equals(costGroup)) {
				/*
				 * R2 - Update all stores in a cost group if Cost changed at
				 * group level (including untied stores). All untied stores get
				 * added again.
				 */
				uniqIds.add(storeVO.getUniqueId());
				if (CPSHelper.checkEqualValue(listCost, "0.000")) {
					storeVO.setStoreRemoved(true);
				} else {
					storeVO.setStoreRemoved(false);
				}
				storeVO.setListCost(listCost);
			}
		}
		return uniqIds;
	}

	public List<String> updateListCostByCost(String uniqueId, String listCost) {
		List<String> uniqIds = new ArrayList<String>();
		/*
		 * Modified for R2: If a store's cost is updated update all tied stores
		 * in that cost group. If the current store is untied, tie it too.
		 */
		StoreVO currentStore = this.getForm().getStoreVO(uniqueId);// Defect #
		// 796
		if (currentStore != null && !CPSHelper.isEmpty(listCost)
				&& Float.parseFloat(listCost) != 0) {
			for (StoreVO storeVO : this.getForm().getStoreVOs()) {
				if (storeVO.getCostGroup().equals(currentStore.getCostGroup())) {
					if (uniqueId.equalsIgnoreCase(storeVO.getUniqueId())) {
						uniqIds.add(storeVO.getUniqueId());
						// Defect #1004
						if (!storeVO.isStoreRemoved()) {
							storeVO.setListCost(listCost);
						}
					} else {
						if (!storeVO.isStoreRemoved()) {
							storeVO.setListCost(listCost);
							uniqIds.add(storeVO.getUniqueId());
						}
					}
				}
			}
		}
		return uniqIds;
	}

	public boolean removeStore(String uniqueId) {
		StoreVO stoVO = this.getForm().getStoreVO(uniqueId);
		if (null != stoVO) {
			stoVO.removeStore();
			return true;
		}
		return false;
	}

	public boolean removeAllStore(String uniqueId) {
		String[] arrUniqueId = uniqueId.split(COMMA);
		int count = 0;
		for (String uniqId : arrUniqueId) {
			StoreVO stoVO = this.getForm().getStoreVO(uniqId);
			if (null != stoVO) {
				stoVO.removeStore();
				count++;
			}
		}
		if (count == arrUniqueId.length)
			return true;
		return false;
	}

	public String addStore(String uniqueId) {
		String returnValue = EMPTY_STRING;
		StoreVO stoVO = this.getForm().getStoreVO(uniqueId);
		if (null != stoVO) {
			String costGroup = stoVO.getCostGroup();
			String listCost = CPSConstant.STRING_0;
			List<StoreVO> stoVOList = this.getForm().getStoreVOs();
			for (StoreVO storeVO : stoVOList) {
				if (storeVO.getCostGroup().equalsIgnoreCase(costGroup)) {
					Float storeVOListCost = new Float(storeVO.getListCost());
					Float compareListCost = new Float(0);
					if (!storeVOListCost.equals(compareListCost)) {
						listCost = CPSHelper.getTrimmedValue(storeVO
								.getListCost());
						break;
					}
				}
			}
			if ((CPSConstant.STRING_0).equalsIgnoreCase(listCost)) {
				listCost = this.getForm().getListCost();
			}
			stoVO.addStore();
			stoVO.setListCost(listCost);
			returnValue = listCost;
		}
		return returnValue;
	}

	// Removed Agrs : boolean isNewVendor. Related to 706 Auto Authorize.
	// HungBang. 18 May 2016
	@SuppressWarnings("unused")
	public String setStoreDetails(String caseCurrentSelected,
			boolean addingStore706) throws CPSGeneralException {
		String returnValue = "fails";
		String itemIdStr = EMPTY_STRING;
		List<StoreVO> stoVOList = this.getForm().getStoreVOs();
		List<ConflictStoreVO> conflictList = this.conflictStore(stoVOList);
		CaseVO caseItemCurrent = this.getExistingCaseVO(caseCurrentSelected);
		Integer psItemId = null;
		String storeId = null;
		BigDecimal listCost = null;
		boolean contain706 = false;
		boolean check = CommonBridge.getAddNewCandidateServiceInstance()
				.insertStoreData(stoVOList, null);
		if (check) {
			returnValue = EMPTY_STRING;
			int currentVendLocNbr = 0;
			boolean startDeleteEDC = false;
			int count = 0;
			List<Integer> vendLocNbrs = new ArrayList<>();
			Iterator<StoreVO> iterator = stoVOList.iterator();
			while (iterator.hasNext()) {
				StoreVO storeVO = (StoreVO) iterator.next();
				storeId = CPSHelper.getStringValue(storeVO.getStoreId());
				if (CPSHelper.getTrimmedValue(storeId).equals(STRING_706)) {
					currentVendLocNbr = Integer.parseInt(storeVO
							.getVendorNumber());
					listCost = CPSHelper.getBigdecimalValue(storeVO
							.getListCost());
					contain706 = true;
					psItemId = (new BigInteger(storeVO.getItemId())).intValue();
					break;
				}
			}
			if (CPSHelper.isNotEmpty(caseItemCurrent.getVendorVOs())) {
				for (VendorVO vendor : caseItemCurrent.getVendorVOs()) {
					if (vendor.getVendorLocNumber() != currentVendLocNbr) {
						vendLocNbrs.add(vendor.getVendorLocNumber());
					}
				}
			}
			if (CPSHelper.isNotEmpty(vendLocNbrs)) {
				List<Object[]> vendorStores = CommonBridge
						.getAddNewCandidateServiceInstance()
						.getVendorStoresByStore706(psItemId, vendLocNbrs);
				if (CPSHelper.isNotEmpty(vendorStores)) {
					for (Object obj[] : vendorStores) {
						count++;
						int compareData = CPSHelper.getBigdecimalValue(
								CPSHelper.getTrimmedValue(obj[2])).compareTo(
								BigDecimal.ZERO);
						int listCostCompare = listCost
								.compareTo(BigDecimal.ZERO);
						if ((listCostCompare == 1 && compareData == 0)
								|| (listCostCompare == 0 && compareData == 1)
								|| (listCostCompare == 0 && compareData == 0)) {
							startDeleteEDC = true;
							break;
						}
					}
				}
			}

			if (count < caseItemCurrent.getVendorVOs().size() - 1
					|| startDeleteEDC
					|| (caseItemCurrent.getVendorVOs().size() == 1 && contain706)) {
				startDeleteEDC = true;
			}

			if (CPSHelper.isNotEmpty(psItemId) && startDeleteEDC
					&& addingStore706) {
				itemIdStr = removeCaseItemWHSeDC(psItemId,
						String.valueOf(currentVendLocNbr));
			}
		}
		if (!conflictList.isEmpty()) {
			this.getForm().setConflictStoreVOs(conflictList);
			this.getForm().setRejectClose(false);
			returnValue = "conflict" + itemIdStr;
		} else {
			returnValue = itemIdStr;
		}
		return returnValue;
	}

	private String removeCaseItemWHSeDC(Integer psItemId, String vendorNo) {
		String returnVal = EMPTY_STRING;
		Integer psItemChild = getChildRelationalMorph(psItemId);
		if (CPSHelper.isNotEmpty(psItemChild)) {
			CaseVO childCase = findCaseVOBasedOnId(psItemChild);
			if (CPSHelper.isNotEmpty(childCase)) {
				List<VendorVO> vendorVOeDC = childCase.getVendorVOs();
				VendorLocDeptVO vendLocDept = CommonBridge
						.getCommonServiceInstance().getVendorFromCache(
								"W-"
										+ vendorVOeDC.get(0)
												.getVendorLocationVal());
				Number primaryScanCode;
				try {
					if (vendLocDept != null
							&& CPSHelper.getTrimmedValue(vendorNo).equals(
									CPSHelper.getTrimmedValue(vendLocDept
											.getApNbr()))) {
						primaryScanCode = CommonBridge
								.getAddNewCandidateServiceInstance()
								.deleteCaseFromProduct(
										this.getForm().getProductVO(),
										childCase);
						this.getForm().getProductVO()
								.setPrimaryUPC(primaryScanCode);
						this.getForm().getProductVO()
								.removeCaseVO(childCase.getUniqueId());
						returnVal = CPSHelper.getTrimmedValue(psItemChild);
					}
				} catch (CPSBusinessException e) {
					LOG.error(e.getMessage(), e);
				}
			}
		}
		return returnVal;
	}

	private CaseVO findCaseVOBasedOnId(Integer psItemId) {
		CaseVO caseVO = null;
		for (CaseVO casevoTemp : this.getForm().getProductVO().getCaseVOs()) {
			if (psItemId.equals(casevoTemp.getPsItemId())) {
				caseVO = casevoTemp;
				break;
			}
		}
		return caseVO;
	}

	public String conflictStoreUpdate(List<String> listCostStore1,
			List<String> listCostStore2) throws CPSGeneralException {
		String returnValue = "fails";
		List<ConflictStoreVO> conflictList = this.getForm()
				.getConflictStoreVOs();
		List<StoreVO> savedList = new ArrayList<StoreVO>();
		int k = 0;
		boolean check = false;
		this.getForm().setRejectClose(false);
		this.getForm().setRejectComments(EMPTY_STRING);
		double conflictListCostInt1;
		double conflictListCostInt2;
		int index = 0;
		for (ConflictStoreVO conflictStoreVO : conflictList) {
			if ((!CPSHelper.isEmpty(conflictStoreVO.getConflictListCost1()) && Float
					.parseFloat(conflictStoreVO.getConflictListCost1()) != 0)
					|| (!CPSHelper.isEmpty(conflictStoreVO
							.getConflictListCost2()) && Float
							.parseFloat(conflictStoreVO.getConflictListCost2()) != 0)) {
				conflictListCostInt1 = 0;
				conflictListCostInt2 = 0;

				StoreVO storeVO = new StoreVO();
				if (CPSHelper
						.isNumeric(conflictStoreVO.getConflictCostGroup1()) && !CPSHelper.getTrimmedValue(conflictStoreVO.getNew1()).equalsIgnoreCase("N")) {
					storeVO.setItemId(conflictStoreVO.getConflictItemId());
					storeVO.setVendorNumber(conflictStoreVO
							.getConflictVNumber1());
					storeVO.setCostGroup(conflictStoreVO
							.getConflictCostGroup1());
					if (null != listCostStore1.get(index)
							&& !listCostStore1.get(index).isEmpty()) {
						conflictListCostInt1 = Double.valueOf(CPSHelper
								.getTrimmedValue(listCostStore1.get(index)));
					}
					storeVO.setListCost(String.valueOf(conflictListCostInt1));
					if (0 >= conflictListCostInt1) {
						storeVO.setStoreRemoved(true);
					} else {
						storeVO.setStoreRemoved(false);
					}
					storeVO.setStoreId(conflictStoreVO.getConflictStoreId());
					savedList.add(storeVO);
				}
				if (CPSHelper
						.isNumeric(conflictStoreVO.getConflictCostGroup2()) && !CPSHelper.getTrimmedValue(conflictStoreVO.getNew2()).equalsIgnoreCase("N")) {
					storeVO = new StoreVO();
					storeVO.setItemId(conflictStoreVO.getConflictItemId());
					storeVO.setVendorNumber(conflictStoreVO
							.getConflictVNumber2());
					storeVO.setCostGroup(conflictStoreVO
							.getConflictCostGroup2());
					if (null != listCostStore2.get(index)
							&& !listCostStore2.get(index).isEmpty()) {
						conflictListCostInt2 = Double.valueOf(CPSHelper
								.getTrimmedValue(listCostStore2.get(index)));
					}
					storeVO.setListCost(String.valueOf(conflictListCostInt2));
					if (0 >= conflictListCostInt2) {
						storeVO.setStoreRemoved(true);
					} else {
						storeVO.setStoreRemoved(false);
					}
					storeVO.setStoreId(conflictStoreVO.getConflictStoreId());
					savedList.add(storeVO);
				}
			} else {
				k++;
				this.getForm().setRejectComments("C");
				this.getForm().setRejectClose(false);
			}
			index++;
		}
		if (k == 0) {
			// Saving the conflict data to database
			// HB-S21
			check = CommonBridge.getAddNewCandidateServiceInstance()
					.insertStoreData(savedList, null);
			if (check) {
				this.getForm().setRejectClose(true);
				returnValue = "success";
			}
		}
		return returnValue;
	}

	private List<ConflictStoreVO> conflictStore(List<StoreVO> stoVOList)
			throws CPSSystemException {
		List<StoreVO> list = new ArrayList<StoreVO>();
		List<BaseJSFVO> storeIDs = new ArrayList<BaseJSFVO>();
		List<ConflictStoreVO> conflictStoreVO = new ArrayList<ConflictStoreVO>();
		for (StoreVO storeVO : stoVOList) {
			StoreVO storeVO1 = new StoreVO();
			String storeId = CPSHelper.getStringValue(storeVO.getStoreId());
			BaseJSFVO baseJSFVO = new BaseJSFVO(storeId, storeId);
			if (!storeIDs.contains(baseJSFVO) && !storeVO.isStoreRemoved()) {
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
				conflictStoreVO = CommonBridge
						.getAddNewCandidateServiceInstance().conflictStoreData(
								list);
			} catch (CPSBusinessException e) {
				LOG.error(e.getMessage(), e);
				conflictStoreVO = new ArrayList<ConflictStoreVO>();
			}
		}
		return conflictStoreVO;
	}

	public Vendor addVendor(String vendorName, String vpc, String gsales,
			String dealOffered, String listCost, String unitCost,
			String costOwner, String top2Top, String countryOfOrigin,
			String seasonality, String seasonalityYear) {
		Vendor vendor = new Vendor();
		vendor.setVendorName(vendorName);
		// vendor.setVendorNumber(vendorId);
		vendor.setVendorProductCode(vpc);
		vendor.setGuarenteedSales(gsales);
		vendor.setDealBeingOffered(dealOffered);
		vendor.setListCost(listCost);
		vendor.setUnitCost(unitCost);
		vendor.setCostOwner(costOwner);
		vendor.setTop2Top(top2Top);
		vendor.setCountryOfOrigin(countryOfOrigin);
		vendor.setSeasonality(seasonality);
		vendor.setSeasonalityYear(seasonalityYear);
		this.getForm().addVendors(vendor);
		return vendor;
	}

	public String getCommentsFromVO(String uniqueId) {
		List<CommentsVO> commentsVO = this.getForm().getProductVO()
				.getCommentsVO();
		String userComments = null;
		for (int i = 0; i < commentsVO.size(); i++) {
			if (uniqueId.equals(commentsVO.get(i).getUniqueId())) {
				userComments = commentsVO.get(i).getComments();
			}
		}
		return userComments;
	}

	public String generatePLU(String pluType, String pluRange)
			throws CPSGeneralException {
		if (CPSHelper.isEmpty(pluType) || CPSHelper.isEmpty(pluRange)) {
			return "Please select both PLU Type & Range";
		}
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (CPSHelper.isNotEmpty(addNewCandidate.getPluRangeOlds())
				&& !pluRange.equals(addNewCandidate.getPluRangeOlds())) {
			addNewCandidate.setLstPluGenerates(new ArrayList<Integer>());
		}
		addNewCandidate.setPluRangeOlds(pluRange);
		String genPLUTxt = EMPTY_STRING;
		Integer generatePLUprevious = 0;
		if (addNewCandidate.getLstPluGenerates() != null
				&& !addNewCandidate.getLstPluGenerates().isEmpty()) {
			generatePLUprevious = addNewCandidate.getLstPluGenerates().get(
					addNewCandidate.getLstPluGenerates().size() - 1);
		}
		Integer genPlu = CommonBridge.getAddNewCandidateServiceInstance()
				.generatePLU(pluType, CPSHelper.getIntegerValue(pluRange),
						generatePLUprevious);
		String generatedPLU = EMPTY_STRING;
		if (CPSHelper.isNotEmpty(genPlu)) {
			genPLUTxt = this.convertStringLength(CPSHelper
					.getTrimmedValue(CPSHelper.getStringValue(genPlu)));
			if (!addNewCandidate.getLstPluGenerates().contains(genPlu)) {
				addNewCandidate.getLstPluGenerates().add(genPlu);
			} else if (!addNewCandidate.getLstPluGenerates().isEmpty()
					&& addNewCandidate.getLstPluGenerates().contains(genPlu)
					&& addNewCandidate.getLstPluGenerates().get(0).equals(genPlu)) {
				addNewCandidate.setLstPluGenerates(new ArrayList<Integer>());
				addNewCandidate.getLstPluGenerates().add(genPlu);
			} else {
				addNewCandidate.setLstPluGenerates(new ArrayList<Integer>());
			}
		}
		int checkDigit = 0;
		int checkDigit1 = 0;
		if (CPSHelper.isEmpty(genPLUTxt)
				|| (CPSConstant.STRING_0).equals(CPSHelper
						.getStringValue(genPlu))) {
			return "The PLU for the Selected Range is not Available, Please select another Range";
		}
		if ("C".equalsIgnoreCase(pluType)) {
			generatedPLU = "00000000" + genPLUTxt;
		} else if ("S".equalsIgnoreCase(pluType)) {
			generatedPLU = "002" + genPLUTxt + "00000";
		} else if ("B".equalsIgnoreCase(pluType)) {
			generatedPLU = "00000000" + genPLUTxt + "-002" + genPLUTxt
					+ "00000";
			checkDigit = CPSHelper.calculateCheckDigit("00000000" + genPLUTxt);
			checkDigit1 = CPSHelper.calculateCheckDigit("002" + genPLUTxt
					+ "00000");
		}
		if (!"B".equalsIgnoreCase(pluType)) {
			checkDigit = CPSHelper.calculateCheckDigit(generatedPLU);
		}

		generatedPLU += "," + checkDigit + "," + checkDigit1;
		this.getForm().getUpcvo().setGeneratedPLU(generatedPLU);
		return generatedPLU;
	}

	private String convertStringLength(String value) {
		int lent = value.length();
		if (lent < 5 && lent > 0) {
			value = "00000" + value;
			value = value.substring(lent, value.length());
		}
		return value;
	}

	@SuppressWarnings("unchecked")
	public List<BaseJSFVO> getPssDept(String classCode)
			throws CPSGeneralException {
		BigDecimal ccDec = new BigDecimal(classCode);

		List<BaseJSFVO> pssDeptList = CommonBridge.getCommonServiceInstance()
				.getDeptNumbersForClassCode(ccDec);
		this.getForm().setPssList(pssDeptList);
		this.getForm().setPssList(
				CPSHelper.insertBlankSelect(this.getForm().getPssList()));
		return pssDeptList;
	}

	@SuppressWarnings("unchecked")
	private boolean isFoundOne(AddNewCandidate addNewCandidate, String commId,
			BaseJSFVO cls) throws Exception {
		List<VendorLocDeptVO> whseVendors = CommonBridge
				.getCommonServiceInstance().getVendorLocationListFromCache(
						null, null, cls.getId(), null, BusinessConstants.CHANNEL_WHS_CODE);
		Map<String, List<VendorLocationVO>> vendMap = (Map<String, List<VendorLocationVO>>) WebContextFactory
				.get().getSession().getAttribute("vendorMap");
		if (vendMap == null) {
			throw new Exception("vendMap is null");
		}
		boolean foundOne = false;
		if (vendMap != null) {
			List<VendorLocationVO> whsLst = vendMap.get("whsLst");
			if (whsLst != null && whseVendors != null) {
				Iterator<VendorLocDeptVO> whseVendorIterator = whseVendors
						.iterator();
				int size = whsLst.size();
				outer: while (whseVendorIterator.hasNext()) {
					VendorLocDeptVO vendorLocDeptVO = whseVendorIterator.next();
					for (int index = 0; index < size; index++) {
						VendorLocationVO vendorLocationVO = whsLst.get(index);
						if (vendorLocationVO.getVendorId().equals(
								vendorLocDeptVO.getVendorLocationNumber())) {
							foundOne = true;
							break outer;
						}
					}
				}
			}
		}
		ClassCommodityVO classVO = addNewCandidate.getClassCommodityVO(commId);
		String deptId = classVO.getDeptId();
		String subDept = classVO.getSubDeptId();
		if (foundOne == false) {
			List<VendorLocDeptVO> dsdVendors = CommonBridge
					.getCommonServiceInstance().getVendorLocationListFromCache(
							deptId, subDept, cls.getId(), null, "D");
			if (dsdVendors != null) {
				if (vendMap != null) {
					List<VendorLocationVO> dsdLst = vendMap.get("dsdLst");
					if (dsdLst != null) {
						Iterator<VendorLocDeptVO> dsdVendorIterator = dsdVendors
								.iterator();
						int size = dsdLst.size();
						outer: while (dsdVendorIterator.hasNext()) {
							VendorLocDeptVO vendorLocDeptVO = dsdVendorIterator
									.next();
							for (int index = 0; index < size; index++) {
								VendorLocationVO vendorLocationVO = dsdLst
										.get(index);
								if (vendorLocationVO.getVendorId().equals(
										vendorLocDeptVO
												.getVendorLocationNumber())) {
									foundOne = true;
									break outer;
								}
							}
						}
					}
				}
			}
		}
		return foundOne;
	}

	@SuppressWarnings("unchecked")
	public Map getClassSubCommPSSForCommodity(String commId) throws Exception {
		Map ret = new HashMap();
		BaseJSFVO cls = getClassForCommodity(commId);
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		/**
		 * for a given class cls - get the list of vendors from - cache
		 * {Warehouse cache and DSD cache}. if the loggedin vendor is there in
		 * the list then OK else give error message -
		 * "You are not authorized to setup products under this Class."
		 *
		 */
		if (isVendor()) {
			try {
				boolean foundOne = this.isFoundOne(addNewCandidate, commId, cls);
				if (!foundOne) {
					ret.put("ERR",
							"You are not authorized to setup products under this Class.");
					return ret;
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				if (!("vendMap is null").equalsIgnoreCase(e.getMessage())) {
					throw e;
				}
			}

		}

		if (addNewCandidate == null) {
			addNewCandidate = new AddNewCandidate();
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}
		getSubCommodityForClassCommodity(cls.getId(), commId);
		ProductVO productVO = addNewCandidate.getProductVO();

		ClassCommodityVO scale = (this.getForm().getClassCommodityMap()
				.get(commId));
		productVO.getClassificationVO().setClassField(cls.getId());
		productVO.getClassificationVO().setClassDesc(
				new StringBuilder(cls.getName()).append(" [")
						.append(cls.getId()).append("]").toString());

		List<BaseJSFVO> pssDeptList = new ArrayList<BaseJSFVO>();
		if (this.getForm().getClassCommodityVO(commId) != null) {
			String deptNbr = this.getForm().getClassCommodityVO(commId)
					.getDeptId();
			String subDeptNbdr = this.getForm().getClassCommodityVO(commId)
					.getSubDeptId();
			if (CPSHelper.isNotEmpty(deptNbr)
					&& CPSHelper.isNotEmpty(subDeptNbdr)) {
				try {
					pssDeptList = CommonBridge.getCommonServiceInstance()
							.getDeptNumbersForDeptSubDept(deptNbr, subDeptNbdr);
				} catch (CPSGeneralException e) {
					ret.put("ERRORWS", e.getMessage());
				}
			}
			pssDeptList = setDefault(pssDeptList, this.getForm()
					.getClassCommodityVO(commId).getPssDept());
		}
		addNewCandidate.setPssList(pssDeptList);

		ret.put("UOMS", getUOMFromSubCommodity(CPSConstant.STRING_EMPTY));
		ret.put("CLS", cls);
		ret.put("PSS", pssDeptList);
		ret.put("SCA", scale.getScale());
		ret.put("DEP", scale.getPssDept());
		return ret;

	}

	@SuppressWarnings("unchecked")
	public Map getCodesForSubCommodity(String subCommId) throws Exception {

		Map ret = new HashMap();

		AddNewCandidate addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession().getAttribute(AddNewCandidate.FORM_NAME);

		if (addNewCandidate == null) {
			addNewCandidate = new AddNewCandidate();
			WebContextFactory.get().getSession().setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}

		addNewCandidate.setBrickMap(clearBrickMap(addNewCandidate.getBrickMap()));

		CommoditySubCommVO codes = this.getForm().getcommoditySubMap()
				.get(subCommId);

		if (codes == null) {
			addNewCandidate.setClassCommodityMap(new HashMap<String, ClassCommodityVO>());
			addNewCandidate.setcommoditySubMap(new HashMap<String, CommoditySubCommVO>());
			throw new Exception(
					"Sorry, you got ahead of us.  Please double check Commodity and Sub Commodity");
		}

		ret.put("CTC", codes.getCrgTaxCd());
		ret.put("FSC", codes.getFdStampCd());
		ret.put("LCC", codes.getLbrCatCd());

		return ret;

	}

	public Map<String, List<BaseJSFVO>> getPOSAcctLists() {

		Object o = this.getForm();

		List<BaseJSFVO> rsal = null;
		List<BaseJSFVO> purchTimes = null;
		List<BaseJSFVO> laborCodes = null;

		AddNewCandidate addNewCandidate = null;

		if (o != null && o instanceof AddNewCandidate) {
			addNewCandidate = (AddNewCandidate) o;
		}

		if (addNewCandidate != null) {

			if ((addNewCandidate.getRestrictedSalesAgeLimitList() != null)
					&& (!addNewCandidate.getRestrictedSalesAgeLimitList().isEmpty())) {
				rsal = addNewCandidate.getRestrictedSalesAgeLimitList();
			}

			if ((addNewCandidate.getPurchaseTimeList() != null)
					&& (!addNewCandidate.getPurchaseTimeList().isEmpty())) {
				purchTimes = addNewCandidate.getPurchaseTimeList();
			}

			if ((addNewCandidate.getLaborCategoryList() != null)
					&& (!addNewCandidate.getLaborCategoryList().isEmpty())) {
				laborCodes = addNewCandidate.getLaborCategoryList();
			}

		}

		if ((rsal == null) || (purchTimes == null) || (laborCodes == null)) {
			if (rsal == null) {
				try {
					rsal = CommonBridge.getCommonServiceInstance()
							.getRestrictedSalesAgeLimits();
				} catch (Exception ex) {
					LOG.error(ex.getMessage(), ex);
				}
				if (addNewCandidate != null) {
					addNewCandidate.setRestrictedSalesAgeLimitList(rsal);
				}

			}
			if (purchTimes == null) {
				try {
					purchTimes = CommonBridge.getCommonServiceInstance()
							.getPurchaseTimeList();
					if (addNewCandidate != null) {
						addNewCandidate.setPurchaseTimeList(purchTimes);
					}
				} catch (Exception ex) {
					LOG.error("Exception:-", ex);
				}

			}
			if (laborCodes == null) {
					LOG.warn("Please implement labor categories.");
			}
		}

		Map<String, List<BaseJSFVO>> ret = new HashMap<String, List<BaseJSFVO>>();
		ret.put("RSAL", rsal);
		ret.put("PURCH_TIMES", purchTimes);
		ret.put("LABOR_CATS", laborCodes);

		return ret;
	}

	public Map<String, List<BaseJSFVO>> getUPCLists() throws CPSWebException,
			CPSBusinessException {

		Object o = this.getForm();

		List<BaseJSFVO> uoms = null;
		List<BaseJSFVO> upcTypes = null;

		AddNewCandidate addNewCandidate = null;
		String subCommodity = CPSConstant.STRING_EMPTY;
		if ((o != null) && (o instanceof AddNewCandidate)) {
			addNewCandidate = (AddNewCandidate) o;
		}

		if (addNewCandidate != null) {

			if ((addNewCandidate.getUpcType() != null)
					&& (!addNewCandidate.getUpcType().isEmpty())) {
				upcTypes = addNewCandidate.getUpcType();
			}

			if ((addNewCandidate.getUnitsOfMeasure() != null)
					&& (!addNewCandidate.getUnitsOfMeasure().isEmpty())) {
				uoms = addNewCandidate.getUnitsOfMeasure();
			}
			if (addNewCandidate.getProductVO() != null
					&& addNewCandidate.getProductVO().getClassificationVO() != null
					&& addNewCandidate.getProductVO().getClassificationVO()
							.getSubCommodity() != null) {
				subCommodity = addNewCandidate.getProductVO().getClassificationVO()
						.getSubCommodity();
			}

		}

		if ((uoms == null) || (upcTypes == null)) {
			if (uoms == null) {
				// SPRINT 22
				uoms = getUOMFromSubCommodity(subCommodity);
				if (addNewCandidate != null) {
					addNewCandidate.setUnitsOfMeasure(uoms);
				}
			}
			if (upcTypes == null) {
				try {
					upcTypes = CommonBridge.getCommonServiceInstance()
							.getUPCType();
				} catch (CPSGeneralException e) {
					LOG.error(e.getMessage(), e);
				}
				if (addNewCandidate != null) {
					if (addNewCandidate.isNonSellable()) {
						upcTypes = this.buildNonSellableUPCTypeList(upcTypes);
					}
					addNewCandidate.setUpcType(upcTypes);
				}
			}
		}

		Map<String, List<BaseJSFVO>> ret = new HashMap<String, List<BaseJSFVO>>();
		ret.put("UOMS", uoms);
		ret.put("UPC_TYPES", upcTypes);
		return ret;
	}

	private List<BaseJSFVO> buildNonSellableUPCTypeList(List<BaseJSFVO> upcTypes) {
		List<BaseJSFVO> nonSellableUPC = new ArrayList<BaseJSFVO>();
		if (upcTypes != null) {
			for (BaseJSFVO baseJSFVO : upcTypes) {
				if ("ITUPC".equalsIgnoreCase(baseJSFVO.getId())
						|| "04UPC".equalsIgnoreCase(baseJSFVO.getId())) {
					nonSellableUPC.add(baseJSFVO);
				}
			}

		}
		return nonSellableUPC;
	}

	@SuppressWarnings("unchecked")
	public Map<String, List<BaseJSFVO>> getUPCListsForProduct(String prodType)
			throws CPSWebException, CPSBusinessException {

		Object o = this.getForm();

		List<BaseJSFVO> upcTypes = null;

		AddNewCandidate addNewCandidate = null;

		if ((o != null) && (o instanceof AddNewCandidate)) {
			addNewCandidate = (AddNewCandidate) o;
		}

		try {
			upcTypes = CommonBridge.getCommonServiceInstance().getUPCType();
		} catch (CPSGeneralException e) {
			LOG.error("Exception:-", e);
		}
		if (addNewCandidate != null) {
			addNewCandidate.setUpcType(upcTypes);
		}

		Map<String, List<BaseJSFVO>> ret = new HashMap<String, List<BaseJSFVO>>();
		ret.put("UPC_TYPES", CPSHelper.insertBlankSelect(upcTypes));

		return ret;
	}

	@SuppressWarnings("unchecked")
	public Map<String, List<BaseJSFVO>> getPharmacyAttribLists() {

		Object o = this.getForm();

		List<BaseJSFVO> drugSchedules = null;
		List<BaseJSFVO> drugAbb = null;

		AddNewCandidate addNewCandidate = null;

		if ((o != null) && (o instanceof AddNewCandidate)) {
			addNewCandidate = (AddNewCandidate) o;
		}

		if (addNewCandidate != null) {

			if ((addNewCandidate.getDrugSchedules() != null)
					&& (!addNewCandidate.getDrugSchedules().isEmpty())) {
				drugSchedules = addNewCandidate.getDrugSchedules();
			}
			if ((addNewCandidate.getDrugAbb() != null)
					&& (!addNewCandidate.getDrugAbb().isEmpty())) {
				drugAbb = addNewCandidate.getDrugAbb();
			}

		}
		if (drugSchedules == null) {
			try {
				drugSchedules = CommonBridge.getCommonServiceInstance()
						.getDrugSchedules();
			} catch (Exception ex) {
				LOG.error("Exception:-", ex);
			}

			if (addNewCandidate != null) {
				addNewCandidate.setDrugSchedules(CPSHelper
						.insertBlankSelect(drugSchedules));
			}
		}

		if (drugAbb == null) {
			try {
				drugAbb = CommonBridge.getCommonServiceInstance()
						.getDrugNameTypes();
				drugAbb = CPSHelper.insertBlankSelect(drugAbb);
			} catch (Exception ex) {
				LOG.error("Exception:-", ex);
			}

			if (addNewCandidate != null) {
				addNewCandidate.setDrugAbb(drugAbb);
			}
		}

		Map<String, List<BaseJSFVO>> ret = new HashMap<String, List<BaseJSFVO>>();
		ret.put("DRUG_SCHEDULES", drugSchedules);
		ret.put("DRUG_ABBR", drugAbb);

		return ret;
	}

	public Map<String, List<BaseJSFVO>> getScaleAttribLists() {

		Object o = this.getForm();

		List<BaseJSFVO> gCode = null;
		List<BaseJSFVO> aCode = null;
		List<BaseJSFVO> nutriStmt = null;

		AddNewCandidate addNewCandidate = null;

		if ((o != null) && (o instanceof AddNewCandidate)) {
			addNewCandidate = (AddNewCandidate) o;
		}

		if (addNewCandidate != null) {

			if ((addNewCandidate.getActionCode() != null)
					&& (!addNewCandidate.getActionCode().isEmpty())) {
				aCode = addNewCandidate.getActionCode();
			}

			if ((addNewCandidate.getGraphicsCode() != null)
					&& (!addNewCandidate.getGraphicsCode().isEmpty())) {
				gCode = addNewCandidate.getGraphicsCode();
			}
			if ((addNewCandidate.getNutrientList() != null)
					&& !addNewCandidate.getNutrientList().isEmpty()) {
				nutriStmt = addNewCandidate.getNutrientList();
			}

		}

		if ((aCode == null) || (gCode == null) || (nutriStmt == null)) {
			if (aCode == null) {
				try {
					aCode = CommonBridge.getCommonServiceInstance()
							.getActionCodes();
				} catch (Exception ex) {
					LOG.error("Exception:-", ex);
				}
				if (addNewCandidate != null) {
					addNewCandidate.setActionCode(aCode);
				}

			}
			if (gCode == null) {
				try {
					gCode = CommonBridge.getCommonServiceInstance()
							.getGraphicsCodes();
				} catch (Exception ex) {
					LOG.error("Exception:-", ex);
				}
				if (addNewCandidate != null) {
					addNewCandidate.setGraphicsCode(gCode);
				}
			}

			if (nutriStmt == null) {
				try {
					nutriStmt = CommonBridge.getCommonServiceInstance()
							.getNutrientList();
				} catch (Exception ex) {
					LOG.error("Exception:-", ex);
				}
				if (addNewCandidate != null) {
					addNewCandidate.setNutrientList(nutriStmt);
				}

			}
		}

		Map<String, List<BaseJSFVO>> ret = new HashMap<String, List<BaseJSFVO>>();
		ret.put("ACTION_CODE", aCode);
		ret.put("GRAPHICS_CODE", gCode);
		ret.put("NUTRITION_STMT", nutriStmt);

		return ret;
	}

	public Map<String, List<BaseJSFVO>> getTobaccoAttribLists() {

		Object o = this.getForm();

		List<BaseJSFVO> tpType = null;

		AddNewCandidate addNewCandidate = null;

		if ((o != null) && (o instanceof AddNewCandidate)) {
			addNewCandidate = (AddNewCandidate) o;
		}

		if (addNewCandidate != null) {

			if ((addNewCandidate.getTobaccoProdtype() != null)
					&& (!addNewCandidate.getTobaccoProdtype().isEmpty())) {
				tpType = addNewCandidate.getTobaccoProdtype();
			}

		}

		if (tpType == null) {
			try {
				tpType = CommonBridge.getCommonServiceInstance()
						.getTobaccoTypes();
			} catch (Exception ex) {
				LOG.error("Exception:-", ex);
			}
			if (addNewCandidate != null) {
				addNewCandidate.setTobaccoProdtype(tpType);
			}

		}

		Map<String, List<BaseJSFVO>> ret = new HashMap<String, List<BaseJSFVO>>();
		ret.put("TOB_PROD_TYPES", tpType);

		return ret;
	}

	public String mail(String data1, String data2, String data3, String data4,
			String data5, String ccList) throws AddressException,
			MessagingException {
		String returnValue = EMPTY_STRING;
		Resource resource = new ClassPathResource(
				CPSHelper.getProfileActivePath() + "/EmailResource.properties");
		Properties serviceProps;
		String from = CPSConstant.STRING_EMPTY;
		String toAddr = CPSConstant.STRING_EMPTY;
		try {
			serviceProps = PropertiesLoaderUtils.loadProperties(resource);
			from = serviceProps.getProperty("email.from");
			toAddr = serviceProps.getProperty("email.to");
		} catch (IOException e) {
			LOG.warn("No information email specified in system props.");
		}

		UserInfo info = getUserInfo();// (UserInfo)
		// WebContextFactory.get().getHttpServletRequest().getSession().getAttribute(userInfoKey);
		// trungnv add mail of user login to CCLIST
		ccList = info.getMail() + ";" + ccList;
		String mailMessage = this.setMailMessage(data1, data2, data3, data4,
				data5, ccList, info.getUserName(), info);
		try {
			CommonBridge.getCommonServiceInstance().sendEmail(toAddr, from,
					"New Attribute Request", mailMessage);
			returnValue = "Mail sent successfully";
		} catch (Exception e) {
			returnValue = "Sent fail";
			LOG.error(e.getMessage(), e);
		}
		return returnValue;
	}

	private String setMailMessage(String data1, String data2, String data3,
			String data4, String data5, String ccList, String userId,
			UserInfo userInfo) {
		StringBuffer mailMessageBuffer = new StringBuffer();
		StringBuffer eMailInfo = new StringBuffer(EMPTY_STRING);
		if (data5 != null && (data5.contains("\r") || data5.contains("\n"))) {
			data5 = data5.replaceAll("\r", "</p>".concat("<p>"));
			data5 = "<p>".concat(data5).concat("</p>");
		}
		if (userInfo != null) {
			eMailInfo
					.append("<tr><td width='25%' align='left'>Requested Email ID:</td><td width='75%' align='left'>")
					.append(ccList).append("</td></tr>");
		}
		mailMessageBuffer
				.append(" <html><head><style type='text/css'>thead {color:green}tbody {color:blue}table {table-layout:fixed; width:400px;}table td {word-wrap:break-word;}</style></head><body>")
				.append("<table border='0'><tr><td width='25%' align='left'>Requested User ID:</td><td width='75%' align='left'>")
				.append(userId)
				.append("</td></tr>")
				.append(eMailInfo)
				.append("</table>")
				.append("<table border='0'><thead width=100%><tr><th width='40%' align='center'><h3>Attribute</h3></th><th width='60%' align='center'><h3>Value</h3></th></tr></thead>")
				.append("<tbody><tr><td width='40%' align='center'>Cost owner</td>")
				.append("<td width='60%' align='center'>")
				.append(data1)
				.append("</td></tr><tr><td width='40%' align='center'> Brand</td>")
				.append("<td width='60%' align='center'>")
				.append(data2)
				.append("</td></tr><tr><td width='40%' align='center'>Top 2 top</td>")
				.append("<td width='60%' align='center'>")
				.append(data3)
				.append("</td></tr><tr><td width='40%' align='left'>H-E-B Vendor #</td>")
				.append("<td width='60%' align='center'>").append(data4)
				.append("</td></tr><tr><td width='40%' align='left'>Note</td>")
				.append("<td width='60%' align='left'>").append(data5)
				.append("</td></tr></tbody></table>");
		mailMessageBuffer.append("</body></html>");
		return mailMessageBuffer.toString();

	}

	private List<VendorLocationVO> getCorrectedVendorList(String deptNbr,
			String subDept, String chnlVal, String classField)
			throws CPSGeneralException {

		List<VendorLocationVO> sessionVendors = this.getForm().getVendorVO()
				.getVendorLocationList();
		List<VendorLocDeptVO> cachedVendors = null;
		if (CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
			cachedVendors = CommonBridge.getCommonServiceInstance()
					.getVendorLocationListFromCache(deptNbr, subDept,
							classField, null, "D");
		} else if (CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
			cachedVendors = CommonBridge.getCommonServiceInstance()
					.getVendorLocationListFromCache(null, null, classField,
							null, BusinessConstants.CHANNEL_WHS_CODE);
		} else {
			cachedVendors = CommonBridge.getCommonServiceInstance()
					.getVendorLocationListFromCache(deptNbr, subDept,
							classField, null, "D");
			cachedVendors.addAll(CommonBridge.getCommonServiceInstance()
					.getVendorLocationListFromCache(null, null, classField,
							null, BusinessConstants.CHANNEL_WHS_CODE));
		}

		List<VendorLocationVO> actualVendors = new ArrayList<VendorLocationVO>();

		if (sessionVendors != null && cachedVendors != null) {
			Iterator<VendorLocationVO> sessionVendorIterator = sessionVendors
					.iterator();
			while (sessionVendorIterator.hasNext()) {
				VendorLocationVO sessionVendorLocationVO = sessionVendorIterator
						.next();
				int size = cachedVendors.size();
				for (int index = 0; index < size; index++) {
					VendorLocDeptVO cachedVendorLocDeptVO = cachedVendors
							.get(index);
					if (sessionVendorLocationVO.getVendorId().equals(
							cachedVendorLocDeptVO.getVendorLocationNumber())) {
						actualVendors.add(sessionVendorLocationVO);
					}
				}
			}
		}
		return actualVendors;
	}

	// @SuppressWarnings("unchecked")
	public Object getVendorLocationList(String channel) throws CPSGeneralException {
		String chnlVal = CPSWebUtil.getChannelValForService(channel);
		StringBuilder reMess = new StringBuilder();
		Object ret = null;
		String deptNbr = null;
		String subDeptNbdr = null;
		if (null != this.getForm().getProductVO().getClassificationVO().getCommodity() && null != this.getForm().getClassCommodityVO(this.getForm().getProductVO().getClassificationVO().getCommodity())) {
			deptNbr = this.getForm().getClassCommodityVO(this.getForm().getProductVO().getClassificationVO().getCommodity()).getDeptId();
			subDeptNbdr = this.getForm().getClassCommodityVO(this.getForm().getProductVO().getClassificationVO().getCommodity()).getSubDeptId();
		}

		String classField = this.getForm().getProductVO().getClassificationVO().getClassField();
		String commodityVal = this.getForm().getProductVO().getClassificationVO().getCommodity();

		if (CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
			commodityVal = null;
		} else if (CHANNEL_WHS_CODE.equalsIgnoreCase(chnlVal)) {
			deptNbr = null;
			subDeptNbdr = null;
		}

		try {
			this.getForm().updateVendorList(deptNbr, subDeptNbdr, classField,commodityVal, chnlVal);
			ret = new HashMap<String, List<VendorLocationVO>>();
			if (CPSHelper.andCondition(this.getForm() != null, this.getForm().getVendorVO() != null)) {
				((Map<String, List<VendorLocationVO>>) ret).put("VEND", this.getForm().getVendorVO().getVendorLocationList());

			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			ret = new HashMap<String, String>();
			reMess.append(ERR_VENDOR_LIST).append(e.getMessage());
			((Map<String, String>) ret).put("ERR", reMess.toString());
		}

		/**added below line to make sure that the vendor list is correct.*/
		if (isVendor()) {
			try {
				this.getForm().getVendorVO().setVendorLocationList(this.getCorrectedVendorList(deptNbr,subDeptNbdr, chnlVal, classField));
				if (CPSHelper.andCondition(this.getForm() != null, this.getForm().getVendorVO() != null)) {
					((Map<String, List<VendorLocationVO>>) ret).put("VEND",this.getForm().getVendorVO().getVendorLocationList());
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				ret = new HashMap<String, String>();
				reMess.append(ERR_VENDOR_LIST).append(e.getMessage());
				((Map<String, String>) ret).put("ERR", reMess.toString());
			}
		}
		return ret;
	}

	@SuppressWarnings("unused")
	public void updateVendorLocListForDSD() throws CPSGeneralException {
		String chnlVal = CPSWebUtil
				.getChannelValForService(CPSConstants.CHANNEL_DSD);

		String deptNbr = null;
		String subDeptNbdr = null;
		if (null != this.getForm().getProductVO().getClassificationVO()
				.getCommodity()
				&& null != this.getForm().getClassCommodityVO(
						this.getForm().getProductVO().getClassificationVO()
								.getCommodity())) {
			deptNbr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getDeptId();
			subDeptNbdr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getSubDeptId();
		}

		String classField = this.getForm().getProductVO().getClassificationVO()
				.getClassField();
		String commodityVal = this.getForm().getProductVO()
				.getClassificationVO().getCommodity();
		this.getForm().updateVendorList(deptNbr, subDeptNbdr, classField, null,
				chnlVal);
	}

	public void updateVendorLocListForWHS() throws CPSGeneralException {
		String chnlVal = CPSWebUtil
				.getChannelValForService(CPSConstants.CHANNEL_WHS);
		this.getForm().updateVendorList(
				null,
				null,
				this.getForm().getProductVO().getClassificationVO()
						.getClassField(),
				this.getForm().getProductVO().getClassificationVO()
						.getCommodity(), chnlVal);
	}

	public void updateVendorLocListForBOTH() throws CPSGeneralException {
		String chnlVal = CPSWebUtil
				.getChannelValForService(CPSConstants.CHANNEL_BOTH);
		String deptNbr = null;
		String subDeptNbdr = null;
		if (null != this.getForm().getProductVO().getClassificationVO()
				.getCommodity()
				&& null != this.getForm().getClassCommodityVO(
						this.getForm().getProductVO().getClassificationVO()
								.getCommodity())) {
			deptNbr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getDeptId();
			subDeptNbdr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getSubDeptId();
		}
		this.getForm().updateVendorList(
				deptNbr,
				subDeptNbdr,
				this.getForm().getProductVO().getClassificationVO()
						.getClassField(),
				this.getForm().getProductVO().getClassificationVO()
						.getCommodity(), chnlVal);
	}

	public String checkBicepInLstBicep(String vendorId, String uniqueVendorId,
			String uniqueCaseId) {
		String msgError = EMPTY_STRING;
		String vendorNumber = CPSHelper.checkVendorNumber(vendorId);
		VendorVO vendorCurrent = null;
		VendorLocDeptVO vendorLocDeptCurrent = null;
		if (CPSHelper.isNotEmpty(uniqueCaseId)
				&& CPSHelper.isNotEmpty(uniqueVendorId)) {
			vendorCurrent = getExistingVendorVO(uniqueVendorId, uniqueCaseId);
		}
		if (CPSHelper.isNotEmpty(vendorCurrent)) {
			vendorLocDeptCurrent = CommonBridge.getCommonServiceInstance()
					.getVendorFromCache(
							"W-" + vendorCurrent.getVendorLocationVal());
		}

		VendorLocDeptVO vendorLocDeptNew = CommonBridge
				.getCommonServiceInstance().getVendorFromCache(
						"W-" + vendorNumber);
		if (CPSHelper.isNotEmpty(vendorLocDeptCurrent)
				&& CPSHelper.isNotEmpty(vendorLocDeptNew)) {
			if (CPSHelper.getTrimmedValue(vendorLocDeptCurrent.getApNbr())
					.equals(CPSHelper.getTrimmedValue(vendorLocDeptNew
							.getApNbr()))) {
				List<WareHouseVO> lstBicepByApNbr = getBicepVendLst(
						vendorLocDeptCurrent.getApNbr(), this.getForm()
								.getProductVO().getClassificationVO()
								.getClassField());
				if (CPSHelper.isNotEmpty(lstBicepByApNbr)) {
					for (WareHouseVO wareHouseVO : lstBicepByApNbr) {
						if (vendorNumber.equals(CPSHelper
								.getTrimmedValue(wareHouseVO
										.getVendorWHSNumber()))
								&& !STRING_101.equals(CPSHelper
										.getTrimmedValue(wareHouseVO
												.getVendorNumber()))) {
							msgError = ERROR_101;
						}
					}
				}
			} else {
				msgError = ERROR_MORPH;
			}
		}
		return msgError;
	}

	private List<WareHouseVO> getBicepVendLst(Integer apNbr, String classField) {
		try {
			return CommonBridge.getAddNewCandidateServiceInstance()
					.getLstBicepVendor(CPSHelper.getStringValue(apNbr),
							classField);
		} catch (CPSGeneralException e) {
			LOG.error("ERROR: Can not get Bicep list based on Ap_Nbr.", e);
		}
		return null;
	}

	public String getVendorChannelType(String vendorId) {
		String channelValue = EMPTY_STRING;
		Integer iVendorId = null;

		if (CPSHelper.isNotEmpty(vendorId)) {
			iVendorId = Integer.valueOf(vendorId.trim());
			List<VendorLocationVO> vendors = new ArrayList<VendorLocationVO>();
			if (this.getForm() != null && this.getForm().getVendorVO() != null) {
				vendors = this.getForm().getVendorVO().getVendorLocationList();
			}
			if (vendors != null && !vendors.isEmpty()) {
				for (VendorLocationVO v : vendors) {
					if (Integer.valueOf(v.getVendorId()).equals(iVendorId)
							&& CPSHelper.isNotEmpty(v.getVendorLocationType())) {
						channelValue = v.getVendorLocationType().trim();
						break;
					}
				}
			}
			if (CPSHelper.isEmpty(channelValue)) {
				// Vendor login will not have all vendors.. so just getting the
				// value from cache to double check
				// Useful while copy/modifying products.
				String deptNbr = null;
				String subDeptNbdr = null;
				if (null != this.getForm().getProductVO().getClassificationVO()
						.getCommodity()
						&& null != this.getForm().getClassCommodityVO(
								this.getForm().getProductVO()
										.getClassificationVO().getCommodity())) {
					deptNbr = this
							.getForm()
							.getClassCommodityVO(
									this.getForm().getProductVO()
											.getClassificationVO()
											.getCommodity()).getDeptId();
					subDeptNbdr = this
							.getForm()
							.getClassCommodityVO(
									this.getForm().getProductVO()
											.getClassificationVO()
											.getCommodity()).getSubDeptId();
				}
				String classField = this.getForm().getProductVO()
						.getClassificationVO().getClassField();
				String commodityVal = this.getForm().getProductVO()
						.getClassificationVO().getCommodity();
				try {
					List<VendorLocationVO> cacheList = this
							.getForm()
							.getSessionVO()
							.getVendorLocationVOs(deptNbr, subDeptNbdr,
									classField, commodityVal, "BOTH");
					for (VendorLocationVO v : cacheList) {
						if (Integer.valueOf(v.getVendorId()).equals(iVendorId)
								&& CPSHelper.isNotEmpty(v
										.getVendorLocationType())) {
							channelValue = v.getVendorLocationType().trim();
							break;
						}
					}
				} catch (CPSGeneralException e) {
					LOG.error("Unable to get vendor list", e);
				}

			}
			if (CPSHelper.isEmpty(channelValue)) {
				try {
					channelValue = CommonBridge.getCommonServiceInstance()
							.getVendorChannel(iVendorId);
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
				}

			}
		}
		return channelValue;
	}

	// @SuppressWarnings({ "unused", "unchecked" })
	public String saveWhareHouseDetails(List<String> selectedList)
			throws CPSGeneralException {
		String returnString = EMPTY_STRING;
		List<WareHouseVO> wareHouseList = this.getForm().getWareHouseList();
		List<WareHouseVO> wareHouseListTemp = new ArrayList<WareHouseVO>();
		for (WareHouseVO wareHouse : wareHouseList) {
			if (selectedList.contains(wareHouse.getWhareHouseid())) {
				wareHouseListTemp.add(wareHouse);
			}
		}
		String psItemId = this.getForm().getItemID();
		int itemid = CPSHelper.getIntegerValue(psItemId);
		String vendorNumber = this.getForm().getVendorId();
		String vendorType = getVendorChannelType(vendorNumber);
		String classCode = this.getForm().getProductVO().getClassCommodityVO().getClassCode();
		if (CPSHelper.isEmpty(vendorType)) {
			vendorType = BusinessConstants.CHANNEL_WHS_CODE;
		}

		if(120 ==this.getForm().getTabIndex()){
			classCode = this.getForm().getMrtvo().getCaseVO().getClassCode();
		}
		CommonBridge.getAddNewCandidateServiceInstance().insertAuthorizeWHS(
				itemid, vendorNumber, vendorType, wareHouseListTemp, false,classCode);
		returnString = "Data successfully saved";
		return returnString;
	}

	public boolean seasonalityDateCheck(String seasonalityDateString)
			throws Exception {
		boolean returnString = false;
		int seasonalityYear = Integer.parseInt(seasonalityDateString);
		returnString = CPSWebUtil.dateValidation(seasonalityYear);
		return returnString;
	}

	public String saveTestScan(List<TestScanVO> dataList)
			throws CPSGeneralException {
		String returnValue = EMPTY_STRING;
		boolean flag = CommonBridge.getAddNewCandidateServiceInstance()
				.insertTestScan(dataList, getUserInfo().getUserName());
		if (flag) {
			this.updateProductVO(dataList);
			returnValue = "Test Scan Successfully Saved";

		} else {
			returnValue = "Test Scan Saving Fails";
		}
		return returnValue;
	}

	private String getUPCWithChkDigit(String unitUPC) {
		return CPSHelper.getPadding(unitUPC)
				+ CPSHelper.calculateCheckDigit(unitUPC);
	}

	private void updateProductVO(List<TestScanVO> dataList) {
		if(this.getForm() != null){
			ProductVO productVO = this.getForm().getProductVO();
			if (null != productVO) {
				for (UPCVO upcvo : productVO.getUpcVO()) {
					for (TestScanVO testScanVO : dataList) {
						if (upcvo.getUnitUpc().equalsIgnoreCase(
								testScanVO.getUnitUPC())
								|| testScanVO.getUnitUPC()
										.equalsIgnoreCase(
												this.getUPCWithChkDigit(upcvo
														.getUnitUpc()))) {
							if ("UPC".equalsIgnoreCase(testScanVO.getUpcType())
									|| "HEB".equalsIgnoreCase(testScanVO
											.getUpcType())) {
								upcvo.setTestScanUPC(testScanVO.getUnitUPC());
							}
							if (testScanVO.isOverRiddenFlag()) {
								upcvo.setTestScanOverridenStatus(CPSConstant.CHAR_Y);
							} else {
								upcvo.setTestScanOverridenStatus(CPSConstant.CHAR_N);
							}
						}
					}
				}
			}
		}
	}

	/**
	 * called by the JSPs to figure out if test scan is needed. Its return value
	 * is then used to enable or disable the test scan button
	 *
	 * @return true of test scan is needed
	 */
	public boolean isTestScanNeeded() {
		return this.getForm().isTestScanNeeded();
	}

	public String getListCost(String costLink, String vendorId, String check,
			String caseID) {
		String returnValue = EMPTY_STRING;
		if (!CPSHelper.isEmpty(costLink)) {
			costLink = costLink.trim();
		}
		String commodityCode = this.getForm().getProductVO()
				.getClassificationVO().getCommodity();

		CaseVO caseVO = null;
		if (CPSHelper.isNotEmpty(caseID) && caseID.equals("-1")) {
			if (this.getForm().isHidMrtSwitch()) {
				caseVO = this.getForm().getMrtvo().getCaseVO();
			}
		} else {
			caseVO = this.getExistingCaseVO(caseID);
		}
		if(caseVO == null){
			return "Unable to fetch Cost Link info. Please try after saving the Case";
		}
		String currentShipPack = caseVO.getShipPack();
		if (("3").equals(check) || ("4").equals(check)) {
			if (CPSHelper.isNotEmpty(caseVO.getMasterPack())) {
				currentShipPack = caseVO.getMasterPack().trim();
			}
			try {
				if(!CPSHelper.isValidNumber(costLink)) {
					returnValue = "Cost Link#/UPC must be a numeric value";
				} else {
					//Get List Cost by Cost Link, DSD
					if (("3").equals(check)) {
						returnValue = CommonBridge
								.getAddNewCandidateServiceInstance()
								.getListCostByCostLinkId(costLink, check, commodityCode,
										currentShipPack, vendorId);
					} else {
						returnValue = CommonBridge
								.getAddNewCandidateServiceInstance()
								.getListCostFromUPCForDSD(costLink, check,
										commodityCode, currentShipPack, vendorId);
					}
				}
			} catch (CPSSystemException e) {
				LOG.error(e.getMessage(), e);
				if (e.getMessage() == null) {
					return "Service Error";
				} else {
					return e.getMessage();
				}

			} catch (CPSBusinessException e) {
				LOG.error(e.getMessage(), e);
				List<CPSMessage> list = e.getMessages();
				String mess = "Service Error";
				if (list != null && !list.isEmpty()) {
					for (CPSMessage message : list) {
						mess = message.getMessage();
						break;
					}
				}
				return mess;
			} catch (CPSGeneralException e) {
				LOG.error(e.getMessage(), e);
				return "Service Error";
			}
		} else {
			if(!CPSHelper.isValidNumber(costLink)) {
				returnValue = "Cost Link#/Item Code must be a numeric value";
			} else {
				try{
					returnValue = CommonBridge.getAddNewCandidateServiceInstance()
						.getListCostByCostLinkId(costLink, check,commodityCode,currentShipPack,vendorId);
				} catch(Exception e) {
					LOG.error(e.getMessage(), e);
				}
			}
		}
		if (CPSHelper.isNumeric(returnValue)) {
			returnValue = CPSHelper.roundToFourDecimal(returnValue);
		}
		return returnValue;
	}

	// *****************************For Generating The HEB-UPC
	// ***************************
	public String generateHEBUPC() throws Exception {
		String returnString = CommonBridge.getAddNewCandidateServiceInstance()
				.getGeneratedHEBUPC();
		int checkDigit = CPSHelper.calculateCheckDigit(returnString);
		returnString = returnString + "," + checkDigit;
		return returnString;

	}

	public void updateCostOwner(String brandId) throws CPSGeneralException {
		// fix reset cost owner list when update brand
		this.getForm().setCostOwners(new ArrayList<BaseJSFVO>());
		Integer brand = CPSHelper.getIntegerValue(brandId);
		List<BaseJSFVO> brandList = CommonBridge
				.getAddNewCandidateServiceInstance().getCostOwnerbyBrand(brand);
		if (null != brandList && !brandList.isEmpty()) {
			this.getForm().setCostOwners(brandList);
		} else {
			throw new CPSBusinessException(new CPSMessage(
					"Cost Owner is not available for the selected Brand",
					ErrorSeverity.ERROR));
		}

	}

	public List<BaseJSFVO> updateTop2Top(String cstOwner)
			throws CPSGeneralException {
		Integer cstOwnerValue = CPSHelper.getIntegerValue(cstOwner);
		List<BaseJSFVO> t2T = new ArrayList<BaseJSFVO>();
		if(CPSHelper.isEmpty(cstOwner)) {
			t2T = CPSHelper.insertBlankSelect(t2T);
		} else {
			t2T = CommonBridge.getAddNewCandidateServiceInstance().getT2TbyCostOwner(cstOwnerValue);
		}
		this.getForm().setTopToTops(t2T);
		return t2T;
	}

	public void batchSessionClearing() throws IOException {
		AddNewCandidate addNewCandidate = this.getForm();
		HttpServletRequest req = WebContextFactory.get()
				.getHttpServletRequest();
		String sessionId = addNewCandidate.getBatchErrorSessionId();
		BatchUpLoad batchUpLoad = new BatchUpLoad();
		if (null != sessionId
				&& CPSConstants.EMPTY_STRING.equalsIgnoreCase(sessionId)) {
			batchUpLoad.batchErrorSessionClearing(sessionId, req);
			addNewCandidate.setBatchErrorSessionId(CPSConstants.EMPTY_STRING);
		}
	}

	public String getMarginPercent(String criticalItem, String subComCode)
			throws CPSGeneralException {

		String margin = CPSConstants.EMPTY_STRING;
		String maxMargin = CPSConstants.EMPTY_STRING;
		String minMargin = CPSConstants.EMPTY_STRING;

		String subComCd = CPSHelper.getTrimmedValue(subComCode);

		Map<String, List<BigDecimal>> marginMap = CommonBridge
				.getAddNewCandidateServiceInstance().getMatrixMarginList(
						subComCd, null);

		List<BigDecimal> normalList = marginMap
				.get(BusinessConstants.NORMAL_QTY);
		List<BigDecimal> seasonalList = marginMap
				.get(BusinessConstants.SEASONAL_QTY);
		List<BigDecimal> profitList = marginMap
				.get(BusinessConstants.PROFIT_QTY);

		if (BusinessConstants.NORMAL_QTY.equalsIgnoreCase(criticalItem)
				&& CPSHelper.isNotEmpty(normalList)) {
			maxMargin = CPSHelper.getStringValue(CPSHelper
					.getMaxPercentage(normalList));
			minMargin = CPSHelper.getStringValue(CPSHelper
					.getMinPercentage(normalList));
			this.getForm().setMaxMargin(maxMargin);
			this.getForm().setMinMargin(minMargin);

			margin = CPSHelper.getStringValue(CPSHelper.findMode(normalList));

			this.getForm().getProductVO().getRetailVO()
					.setMarginPercent(CPSHelper.getIntegerValue(margin));
		}

		if (BusinessConstants.SEASONAL_QTY.equalsIgnoreCase(criticalItem)
				&& CPSHelper.isNotEmpty(seasonalList)) {
			maxMargin = CPSHelper.getStringValue(CPSHelper
					.getMaxPercentage(seasonalList));
			minMargin = CPSHelper.getStringValue(CPSHelper
					.getMinPercentage(seasonalList));
			this.getForm().setMaxMargin(maxMargin);
			this.getForm().setMinMargin(minMargin);

			margin = CPSHelper.getStringValue(CPSHelper.findMode(seasonalList));

			this.getForm().getProductVO().getRetailVO()
					.setMarginPercent(CPSHelper.getIntegerValue(margin));
		}
		if (BusinessConstants.PROFIT_QTY.equalsIgnoreCase(criticalItem)
				&& CPSHelper.isNotEmpty(profitList)) {
			maxMargin = CPSHelper.getStringValue(CPSHelper
					.getMaxPercentage(profitList));
			minMargin = CPSHelper.getStringValue(CPSHelper
					.getMinPercentage(profitList));
			this.getForm().setMaxMargin(maxMargin);
			this.getForm().setMinMargin(minMargin);

			margin = CPSHelper.getStringValue(CPSHelper.findMode(profitList));

			this.getForm().getProductVO().getRetailVO()
					.setMarginPercent(CPSHelper.getIntegerValue(margin));
		}

		return margin;
	}

	public Double getCalRetail(String vendorList) {

		double retail;
		int margin = this.getForm().getProductVO().getRetailVO()
				.getMarginPercent();
		this.getForm().setVendorListCost(vendorList);
		/*
		 * retail = (CPSHelper.getFormattedDecimal(vendorList) * 100) / (100 -
		 * (margin));
		 */
		try {
			retail = (CPSHelper.getDoubleValue(vendorList) * 100)
					/ (100 - (margin));
			retail = new Double((Math.round(retail * 100))).doubleValue() / 100;
		} catch (NumberFormatException e) {
			retail = new Double(0);
		} catch (Exception e1) {
			LOG.error("Exception:-" + e1.getMessage(), e1);
			retail = new Double(0);
		}
		return retail;
	}

	public String getDisplayInfoForMerchType(String merchTypeParam) {
		String merchType = CPSHelper.getTrimmedValue(merchTypeParam);
		try {
			HttpServletRequest req = WebContextFactory.get()
					.getHttpServletRequest();
			// req.getSession().getAttribute(name)
			boolean isVendor = ((req.isUserInRole("UVEND")) || (req
					.isUserInRole("RVEND")));
			String ret = "none";
			if (merchType.contains("Select")) {
				// do nothing
			} else if (!isVendor) {
				if (((CPSConstant.STRING_0).equals(merchType))
						|| (("PRMO").equals(merchType))
						|| (("8").equals(merchType))
						|| (("4").equals(merchType))
						|| (("SHPR").equals(merchType))
						|| (("XDK").equals(merchType))) {
					ret = "mtGroup1";
				} else if (("9").equals(merchType)) {
					ret = "mtGroup2";
				} else {
					ret = "mtGroup3";
				}
			} else {
				if (((CPSConstant.STRING_0).equals(merchType))
						|| (("PRMO").equals(merchType))
						|| (("8").equals(merchType))
						|| (("4").equals(merchType))
						|| (("SHPR").equals(merchType))
						|| (("XDK").equals(merchType))) {
					ret = "mtGroup4";
				} else if (("9").equals(merchType)) {
					ret = "mtGroup5";
				} else {
					ret = "mtGroup6";
				}
			}
			return ret;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return EMPTY_STRING;
	}

	@SuppressWarnings({ "unchecked" })
	public Map updateMargin(String criticalItem, String subComCode,
			String retailFor) throws CPSGeneralException {

		double updatedMargin = new Double(0);
		double updatedRetail = new Double(0);
		Map ret = new HashMap();
		String vendorList = this.getForm().getVendorListCost();
		try {
			updatedRetail = CPSHelper.getDoubleValue(retailFor);
			updatedMargin = ((updatedRetail - CPSHelper
					.getDoubleValue(vendorList)) * 100) / updatedRetail;
			updatedRetail = new Double((Math.round(updatedRetail * 100)))
					.doubleValue() / 100;
			updatedMargin = new Double((Math.round(updatedMargin * 100)))
					.doubleValue() / 100;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			updatedMargin = new Double(0);
		}
		ret.put("MAX", this.getForm().getMaxMargin());
		ret.put("MIN", this.getForm().getMinMargin());
		ret.put("MARGIN", updatedMargin);
		ret.put("RETAIL", updatedRetail);
		return ret;
	}

	public String defaultAuthorization() throws CPSGeneralException {
		String returnValue = EMPTY_STRING;
		String vendorLocCode = CPSHelper.getTrimmedValue(this.getForm()
				.getAuthTypeCode());
		if (CHANNEL_DSD_CODE.equalsIgnoreCase(vendorLocCode)) {
			returnValue = this.setDefaultStoreAuthorization();
		} else {
			returnValue = setDefaultWHSAuthorization();
		}
		return returnValue;
	}


	public String defaultAuthorizationForMRT() throws CPSGeneralException {
		String returnValue = EMPTY_STRING;
		String vendorLocCode = CPSHelper.getTrimmedValue(this.getForm()
				.getAuthTypeCode());
		if (CHANNEL_DSD_CODE.equalsIgnoreCase(vendorLocCode)) {
			returnValue = this.setDefaultStoreAuthorization();
		} else {
			returnValue = setDefaultWHSAuthorizationForMRT();
		}
		return returnValue;
	}

	@SuppressWarnings("unused")
	private String setDefaultWHSeDCAuthorization() {
		String returnValue = EMPTY_STRING;
		String itemId = this.getForm().getItemID();
		String uniquevendorId = this.getForm().getVendorId();
		VendorList vendorList = new VendorList(null, null,
				CPSHelper.getIntegerValue(uniquevendorId));
		String vendorType = getVendorChannelType(uniquevendorId);
		String classCode = this.getForm().getProductVO().getClassificationVO().getClassField();
		returnValue = autoAuthorizeWarehouse(uniquevendorId, itemId, vendorType, classCode, vendorList, true);
		return returnValue;
	}

	private String setDefaultWHSAuthorization() {
		String returnValue = EMPTY_STRING;
		String itemId = this.getForm().getItemID();
		String uniquevendorId = this.getForm().getVendorId();
		VendorList vendorList = new VendorList(null, null,
				CPSHelper.getIntegerValue(uniquevendorId));
		String vendorType = getVendorChannelType(uniquevendorId);
		String classCode = this.getForm().getProductVO().getClassificationVO().getClassField();
		returnValue = autoAuthorizeWarehouse(uniquevendorId, itemId, vendorType, classCode, vendorList, false);
		return returnValue;
	}



	private String setDefaultWHSAuthorizationForMRT() {
		String returnValue = EMPTY_STRING;
		String itemId = this.getForm().getItemID();
		String uniquevendorId = this.getForm().getVendorId();
		VendorList vendorList = new VendorList(null, null,
				CPSHelper.getIntegerValue(uniquevendorId));
		String vendorType = getVendorChannelType(uniquevendorId);

		String classCode = CPSConstant.STRING_EMPTY;
		if(this.getForm().getMrtvo()!=null && this.getForm().getMrtvo().getCaseVO()!=null){
			classCode = this.getForm().getMrtvo().getCaseVO().getClassCode();
		}
		returnValue = autoAuthorizeWarehouse(uniquevendorId, itemId, vendorType, classCode, vendorList,false);
		return returnValue;
	}


	private String autoAuthorizeWarehouse(String uniquevendorId, String itemId,String  vendorType, String classCode, VendorList vendorList, boolean isAuthorizeMorph){
		String returnValue = EMPTY_STRING;

		// Fetch the warehouse details from service - Ends
		// saving the wareHouse details - Starts
		int psItemid = CPSHelper.getIntegerValue(itemId);
		try {

			List<WareHouseVO> facilityList = CommonBridge
					.getCommonServiceInstance().getWareHouseList(vendorList, classCode);
			if (CPSHelper.isNotEmpty(facilityList)) {
			List<WareHouseVO> wareHouseListTemp = getWareHouseList(facilityList,
					CPSHelper.getTrimmedValue(uniquevendorId), itemId,
					vendorType);
			List<WareHouseVO> list = new ArrayList<WareHouseVO>();
			for (WareHouseVO wareHouseVO : wareHouseListTemp) {
				if(isAuthorizeMorph){
					if ("101".equals(CPSHelper.getTrimmedValue(wareHouseVO
							.getFacilityNumber()))) {
						wareHouseVO.setCheck(true);
					} else {
						wareHouseVO.setCheck(false);
					}
				}else{
					wareHouseVO.setCheck(true);
				}

				wareHouseVO.setVendorWHSNumber(CPSHelper
						.getTrimmedValue(uniquevendorId));
				list.add(wareHouseVO);
			}
			List<WareHouseVO> savedList = CommonBridge
					.getAddNewCandidateServiceInstance()
					.insertAuthorizeWHS(psItemid, uniquevendorId,
							vendorType, list, true, classCode);
			}
		} catch (CPSBusinessException e) {
			// TODO Auto-generated catch block
			LOG.error(e.getMessage(), e);
			List<CPSMessage> msgList = e.getMessages();
			String messg = AUTHORIZE_SERVICE_ERROR;
			for (CPSMessage msg : msgList) {
				messg = CPSHelper.getTrimmedValue(msg.getMessage());
			}
			returnValue = messg;
		}catch (Exception e) {
			LOG.error(e.getMessage(), e);
			String messg = AUTHORIZE_SERVICE_ERROR;
			returnValue = messg;
		}
		// saving the wareHouse details - Ends
		return returnValue;
	}


	private List<WareHouseVO> getWareHouseList(List<WareHouseVO> facilityList,
			String uniquevendorId, String itemId, String vendorType) {
		List<WareHouseVO> wareHouseListTemp = new ArrayList<WareHouseVO>();
		for (WareHouseVO wareHouseVO : facilityList) {
			wareHouseVO.setItemId(itemId);
			wareHouseVO.setVendorNumber(uniquevendorId);
			wareHouseVO.setVendorType(vendorType);
			wareHouseListTemp.add(wareHouseVO);
		}
		return wareHouseListTemp;
	}

	private String setDefaultStoreAuthorization() throws CPSBusinessException {
		String returnValue = EMPTY_STRING;
		String itemId = this.getForm().getItemID();
		String uniquevendorId = this.getForm().getVendorId();
		String listCost = this.getForm().getListCost();
		listCost = (listCost != null || !EMPTY_STRING.equals(listCost)) ? listCost
				: ZERO_STRING;
		String deptNo = this.getForm().getAuthDeptNo();
		String subDeptNbdr = this.getForm().getAuthSubDeptNo();

		List<StoreVO> viewStoreList = null;
		try {
			// Fetch the STORE details from service - starts
			viewStoreList = CommonBridge.getCommonServiceInstance()
					.getViewStoresList(uniquevendorId, deptNo, subDeptNbdr,
							listCost, itemId);
			if (!viewStoreList.isEmpty()) {
				this.setStoreVO(viewStoreList);
			}
			this.getForm().setListCost(listCost);
			// Fetch the STORE details from service - ends
			// saving the STORE details - Starts
			// HB-S21
			returnValue = setStoreDetails(CPSConstant.STRING_EMPTY, false);
			if ("fails".equalsIgnoreCase(returnValue)) {
				returnValue = "Store Authorization Fails";
			}
			// saving the STORE details - ends
		} catch (CPSBusinessException e) {
			List<CPSMessage> list = e.getMessages();
			LOG.error("BusinessException exception.", e);
			for (CPSMessage message : list) {
				if (CPSHelper.isNotEmpty(message.getMessage())) {
					throw new CPSBusinessException(new CPSMessage(
							CPSHelper.getTrimmedValue(message.getMessage()),
							ErrorSeverity.INFO));
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			String messg = AUTHORIZE_SERVICE_ERROR;
			returnValue = messg;
		}
		return returnValue;
	}

	private void setStoreVO(List<StoreVO> viewStoreList) {
		List<BaseJSFVO> costGroups = new ArrayList<BaseJSFVO>();
		this.getForm().clearStoreVOs();
		for (StoreVO storeVO : viewStoreList) {
			String costGroup = storeVO.getCostGroup();
			BaseJSFVO baseJSFVO = new BaseJSFVO(costGroup, costGroup);
			if (!costGroups.contains(baseJSFVO)) {
				costGroups.add(baseJSFVO);
			}
			String storeId = CPSHelper.getTrimmedValue(CPSHelper
					.getStringValue(storeVO.getStoreId()));
			String storeAbbrevation = this.getStoreAbbrevation(storeId);
			storeVO.setStoreAbbreviation(storeAbbrevation);
			this.getForm().addStoreVOs(storeVO);
			this.getForm().setCostGroups(costGroups);
		}
	}

	private String getStoreAbbrevation(String storeId) {
		String abbrevation = EMPTY_STRING;
		BaseJSFVO baseJSFVO = CommonBridge.getCommonServiceInstance()
				.getStoresAsBaseJSFVOs().get(storeId);
		if (null != baseJSFVO) {
			if (CPSHelper.isNotEmpty(baseJSFVO.getName()))
				abbrevation = baseJSFVO.getName();
		}
		return abbrevation;
	}

	public boolean isVendor() {
		return this.getForm().isVendor();
	}

	public int generateCheckDigit(String upc) throws Exception {
		return CPSHelper.calculateCheckDigit(upc);

	}

	// R2 [
	public String validateScaleAttributes(ScaleVO scaleVO)
			throws CPSGeneralException {
		String message = "SUCCESS";
		boolean validNutrientStmtNbr = false;

		if (this.getForm().getProductVO().isOnlyCheckerUPC()) {
			return message;
		}

		if (!this.getForm().getProductVO().isScaleUPC()) {
			return message;
		}

		// Fix 1211.
		List<CodeDescVO> lstCodeDes = new ArrayList<CodeDescVO>();
		if (!CPSHelper.isEmpty(scaleVO.getIngStatementNumber())
				&& !CPSHelper.getTrimmedValue(scaleVO.getIngStatementNumber())
						.equals(CPSConstant.INGREDIENT_APPROVE_9999)) {
			lstCodeDes.add(CommonBridge.getCommonServiceInstance()
					.getIngrStatementById(scaleVO.getIngStatementNumber()));
			if (!this.isValidID(lstCodeDes, scaleVO.getIngStatementNumber())) {
				message = "Invalid Ingredient Statement Number";
				return message;
			}
			if (this.isDeletedID(lstCodeDes, scaleVO.getIngStatementNumber())) {
				message = "Ingredient Statement scheduled to be deleted";
				return message;
			}
		}

		if (!CPSHelper.isEmpty(scaleVO.getNutStatementNumber())
				&& (CPSHelper.isEqual(scaleVO.getNutStatementNumber(),
						CPSConstant.STRING_0) || CPSHelper.isEqual(
						scaleVO.getNutStatementNumber(), "9999999"))) {
			validNutrientStmtNbr = true;
		}
		List<CodeDescVO> lstCodeDesNu = new ArrayList<CodeDescVO>();
		if (!validNutrientStmtNbr
				&& !CPSHelper.isEmpty(scaleVO.getNutStatementNumber())) {
			lstCodeDesNu.add(CommonBridge.getCommonServiceInstance()
					.getNtrntStatementById(scaleVO.getNutStatementNumber()));
			if (!this.isValidID(lstCodeDesNu, scaleVO.getNutStatementNumber())) {
				message = "Invalid Nutrient Statement Number";
				return message;
			}

			if (this.isDeletedID(lstCodeDesNu, scaleVO.getNutStatementNumber())) {
				message = "Nutrient Statement scheduled to be deleted";
				return message;
			}
		}

		if (!validNutrientStmtNbr
				&& CPSHelper.isEmpty(scaleVO.getAssociatedPLUs())
				&& !CPSHelper.isEmpty(scaleVO.getNutStatementNumber())) {
			message = "No PLU found to match the Nutrient Statement";
			return message;
		}

		if (!CPSHelper.isEmpty(scaleVO.getAssociatedPLUs())
				&& !CPSHelper.isEmpty(scaleVO.getNutStatementNumber())) {

			boolean noPLUMatch = true;
			String[] associatedPLUs = scaleVO.getAssociatedPLUs().split(",");
			for (String plu : associatedPLUs) {
				if (CPSHelper.checkEqualValue(this.convertStringLength(scaleVO
						.getNutStatementNumber()), plu)) {
					noPLUMatch = false;
					break;
				}
			}

			if (!validNutrientStmtNbr && noPLUMatch) {
				message = "Nutrient Statement number should match the PLU";
				return message;
			}
		}

		if (!CPSHelper.isEmpty(scaleVO.getServiceCounterTare())) {
			if (!CPSHelper.isValidNumber(scaleVO.getServiceCounterTare())) {
				message = "Service Counter Tare not a Valid Number";
				return message;
			}

			if (CPSHelper.getDoubleValue(scaleVO.getServiceCounterTare()) > 1.5) {
				message = "The entered value is above the maximum limit [9.999]. Please, re-enter";
				return message;
			}
		}

		// HoangVT - valid grade number and net weight [for new scale fields
		// defect]
		if (!CPSHelper.isEmpty(scaleVO.getGradeNbr())) {
			if (!CPSHelper.isValidNumber(scaleVO.getGradeNbr())) {
				message = "Grade number not a Valid Number";
				return message;
			}
		}
		if (!CPSHelper.isEmpty(scaleVO.getNetWt())) {
			if (!CPSHelper.isValidNumber(scaleVO.getNetWt())) {
				message = "Net weight not a Valid Number";
				return message;
			}
		}

		if (!CPSHelper.isEmpty(scaleVO.getPrePackTare())) {
			if (!CPSHelper.isValidNumber(scaleVO.getPrePackTare())) {
				message = "Pre-pack Tare not a Valid Number";
				return message;
			}

			if (CPSHelper.getDoubleValue(scaleVO.getPrePackTare()) > 3.0) {
				message = "Pre-pack Tare cannot be more than 3.0";
				return message;
			}
		}
		return message;
	}

	private boolean isValidID(List<CodeDescVO> cdDesc, String cd) {
		for (CodeDescVO vo : cdDesc) {
			if (vo != null && CPSHelper.checkEqualValue(vo.getCode(), cd)) {
				return true;
			}
		}
		return false;
	}

	private boolean isDeletedID(List<CodeDescVO> cdDesc, String cd) {
		for (CodeDescVO vo : cdDesc) {
			if (vo != null && CPSHelper.checkEqualValue(vo.getCode(), cd)
					&& CPSHelper.checkEqualValue(vo.getCodeDesc(), "D")) {
				return true;
			}
		}
		return false;
	}

	// R2 ]
	public String addSubBrand(String subBrand) throws CPSGeneralException {
		String returnValue = EMPTY_STRING;
		boolean flag = false;
		String subBrandId = BusinessConstants.UNASSIGNED;
		try {
			subBrandId = CommonBridge.getCommonServiceInstance()
					.insertSubBrand(CPSHelper.getTrimmedValue(subBrand));
		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
			return (e.getMessage());
		}

		if (!BusinessConstants.UNASSIGNED.equals(subBrandId)) {

			// refresh the sub brand cache
			try {
				this.refreshSubBrandCache(subBrandId, subBrand);
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				return (e.getMessage());
			}
			flag = true;

			this.getForm().getUpcvo()
					.setSelectedSubBrand(subBrand + " [" + subBrandId + "]");
			// trungnv fix 1338
			this.getForm().getUpcvo().setSelectedSubBrandName(subBrand);
		}

		if (flag) {

			returnValue = "New Sub-brand \"" + subBrand
					+ "\" added successfully";

		} else {
			returnValue = "Sub-brand \"" + subBrand + "\" already exists";
		}

		returnValue = returnValue + ";" + subBrandId;
		return returnValue;
	}

	private void refreshSubBrandCache(String id, String desc) throws Exception {
		CommonBridge.getCPSIndexUtilServiceInstance().refreshSubBrand(false,
				id, desc);
		this.refreshSubBrandAutoCompleteCache();
	}

	private void refreshSubBrandAutoCompleteCache() throws Exception {
		List<BaseJSFVO> subbrands = CommonBridge.getCommonServiceInstance()
				.getSubBrands();
		if ((subbrands != null) && (!subbrands.isEmpty())) {
			Map<String, Map<String, String>> cache = (Map) WebContextFactory
					.get().getSession().getAttribute("JSON_SEARCH_RESULTS_MAP");
			if (cache != null) {
				Map<String, String> uidCache = cache
						.get(ADD_CAND_SUB_BRAND_TYPEAHEAD_ID);
				if (uidCache == null) {
					uidCache = new HashMap<String, String>();
					cache.put(ADD_CAND_SUB_BRAND_TYPEAHEAD_ID, uidCache);
				}
				for (BaseJSFVO baseJSFVO : subbrands) {
					uidCache.put(baseJSFVO.getId(), baseJSFVO.getName());
				}
			}
		}
	}

	public boolean enableActivateButton() {
		return this.getForm().isEnableActivateButton();
	}

	public String saveFactoryDetails(List<String> selectedList)
			throws CPSGeneralException {

		String returnString = EMPTY_STRING;
		try {

			String itemID = this.getForm().getItemID();
			CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();

			if (caseVO.getPsItemId() == null
					|| !itemID.equals(caseVO.getPsItemId().toString())) {
				for (CaseVO cas : this.getForm().getProductVO().getCaseVOs()) {
					if (cas.getPsItemId().toString().equals(itemID)) {
						caseVO = cas;
						break;// found our case
					}
				}
			}

			boolean vendorFound = false;
			VendorVO vendor = this.getForm().getVendorVO();
			String vendNum = vendor.getVendorLocationVal();
			if (vendNum.length() > 6) {
				vendNum = vendNum.substring(2);
			}
			if (CPSHelper.getIntegerValue(vendNum).equals(
					CPSHelper.getIntegerValue(this.getForm().getVendorId()))) {
				vendorFound = true;
			} else {
				if (caseVO.getPsItemId() != null) {
					for (VendorVO vend : caseVO.getVendorVOs()) {
						vendNum = vend.getVendorLocationVal();
						if (vendNum.length() > 6) {
							vendNum = vendNum.substring(2);
						}
						if (CPSHelper.getIntegerValue(vendNum) == CPSHelper
								.getIntegerValue(this.getForm().getVendorId())) {
							vendor = vend;
							vendorFound = true;
							break;// found our vendor
						}
					}
				}
			}

			Set<String> factoryIDs = new HashSet<String>();
			for (String id : selectedList) {
				factoryIDs.add(id);
			}
			vendor.getImportVO().setFactoryIDs(factoryIDs);

			if (vendorFound) {// check if correct vendor then fire update.
				CommonBridge.getAddNewCandidateServiceInstance()
						.saveFactoryDetails(vendor, caseVO.getClassCode());
				returnString = "Data successfully saved";
			}

		} catch (Exception e) {
			LOG.error("Error saving factory details", e);
		}

		return returnString;
	}

	public String checkWareHouseExist(String uniqueVendorId, String uniqueCaseId) {

		String flag = "true";

		if (uniqueCaseId == null || uniqueVendorId == null
				|| CPSHelper.isEmpty(uniqueCaseId)
				|| CPSHelper.isEmpty(uniqueVendorId)) {
			flag = "false";
		} else {
			CaseVO caseVO = this.getForm().getProductVO()
					.getCaseVO(uniqueCaseId);
			VendorVO vendorVO = this.getForm().getVendorVO();
			if (caseVO != null) {
				if (caseVO.getVendorVO(uniqueVendorId) != null) {
					vendorVO = caseVO.getVendorVO(uniqueVendorId);
				}
			}
			if (vendorVO.getNewDataSw() != CPSConstant.CHAR_N) {
				String vendorNumber = CPSHelper.getTrimmedValue(CPSHelper
						.getStringValue(vendorVO.getVendorLocNumber()));
				if (CPSHelper.isNotEmpty(vendorNumber)
						&& vendorNumber.length() > 6) {
					// Removing facility number
					vendorNumber = vendorNumber.substring(2,
							vendorNumber.length());
				}

				if (CPSHelper.getIntegerValue(vendorNumber).intValue() == CPSHelper
						.getIntegerValue(uniqueVendorId).intValue()) {

					String psItemId = CPSHelper.getStringValue(caseVO
							.getPsItemId());
					VendorList vendorList = new VendorList(null, null,
							CPSHelper.getIntegerValue(CPSHelper
									.getTrimmedValue(vendorNumber)));
					try {
						List<WareHouseVO> facilityList = CommonBridge
								.getCommonServiceInstance().getWareHouseList(
										vendorList, caseVO.getClassCode());
						List<WareHouseVO> wareHouseListTemp = getWareHouseList(
								facilityList,
								CPSHelper.getTrimmedValue(vendorNumber),
								psItemId, vendorVO.getVendorLocationTypeCode());
						List<WareHouseVO> baseJSFVOList = CommonBridge
								.getAddNewCandidateServiceInstance()
								.fetchWareHouseDetails(
										CPSHelper
												.checkVendorNumber(vendorNumber),
										vendorVO.getVendorLocationTypeCode(),
										psItemId, wareHouseListTemp);
						if (baseJSFVOList.isEmpty()) {
							flag = "false";
						}
					} catch (Exception e) {
						LOG.error(e.getMessage(), e);
						flag = "false";
					}
				} else {
					flag = "false";
				}
			}
		}
		return flag;
	}

	public String checkWareHouseExistMRT(String uniqueVendorId) {

		String flag = "true";

		if (uniqueVendorId == null || CPSHelper.isEmpty(uniqueVendorId)) {
			flag = "false";
		} else {
			CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();

			VendorVO vendorVO = this.getForm().getVendorVO();
			if (caseVO != null) {
				if (caseVO.getVendorVO(uniqueVendorId) != null) {
					vendorVO = caseVO.getVendorVO(uniqueVendorId);
				}
			}

			String vendorNumber = CPSHelper.getTrimmedValue(CPSHelper
					.getStringValue(vendorVO.getVendorLocNumber()));
			if (CPSHelper.isNotEmpty(vendorNumber) && vendorNumber.length() > 6) {
				// Removing facility number
				vendorNumber = vendorNumber.substring(2, vendorNumber.length());
			}

			if (CPSHelper.getIntegerValue(vendorNumber).intValue() == CPSHelper
					.getIntegerValue(uniqueVendorId).intValue()) {

				String psItemId = CPSHelper
						.getStringValue(caseVO.getPsItemId());
				VendorList vendorList = new VendorList(null, null,
						CPSHelper.getIntegerValue(CPSHelper
								.getTrimmedValue(vendorNumber)));
				try {
					List<WareHouseVO> facilityList = CommonBridge
							.getCommonServiceInstance().getWareHouseList(
									vendorList, caseVO.getClassCode());
					List<WareHouseVO> wareHouseListTemp = getWareHouseList(
							facilityList,
							CPSHelper.getTrimmedValue(vendorNumber), psItemId,
							vendorVO.getVendorLocationTypeCode());
					List<WareHouseVO> baseJSFVOList = CommonBridge
							.getAddNewCandidateServiceInstance()
							.fetchWareHouseDetails(
									CPSHelper.checkVendorNumber(vendorNumber),
									vendorVO.getVendorLocationTypeCode(),
									psItemId, wareHouseListTemp);
					if (baseJSFVOList.isEmpty()) {
						flag = "false";
					}
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
					flag = "false";
				}
			} else {
				flag = "false";
			}
		}
		return flag;
	}

	/**
	 * Contains scale upc.
	 *
	 * @return true, if successful
	 */
	private boolean containsScaleUPC() {
		boolean isPlu = false;
		if (this.getForm().getProductVO() != null) {
			List<UPCVO> upcs = this.getForm().getProductVO().getUpcVO();
			if (null != upcs && !upcs.isEmpty()) {
				for (UPCVO tempUPCVO : upcs) {
					if (tempUPCVO.getNewDataSw() == CPSConstant.CHAR_Y) {
						if (tempUPCVO.getUnitUpc().endsWith("00000")
								&& tempUPCVO.getUnitUpc().startsWith("002")) {
							isPlu = true;
							break;
						}
					}
				}
			} else {
				isPlu = false;
			}
		}
		return isPlu;
	}

	public boolean isDisplayImport(boolean isMRT, String channel,
			String selectedVendor) {
		boolean retVal = false;
		if (isMRT) {
			if (("DSD").equalsIgnoreCase(channel)) {
				retVal = false;
			} else if (("WHS").equalsIgnoreCase(channel)
					|| ("BOTH").equalsIgnoreCase(channel)) {
				retVal = true;
			} else {
				retVal = false;
			}
			MrtVO mrtVO = this.getForm().getMrtvo();
			if (mrtVO != null) {
				CaseVO caseVO = mrtVO.getCaseVO();
				if (caseVO != null) {
					List<VendorVO> vendors = caseVO.getVendorVOs();
					if (CPSHelper.isNotEmpty(vendors)) {
						for (VendorVO vendorVO : vendors) {
							if (vendorVO.getVendorLocationVal().equals(
									selectedVendor)) {
								String vendorChannel = vendorVO.getChannel();
								if (CPSHelper.isNotEmpty(vendorChannel)) {
									if ("D".equalsIgnoreCase(vendorChannel)
											|| "DSD".equalsIgnoreCase(vendorChannel)) {
										retVal = false;
									} else {
										retVal = true;
									}
									break;
								}
							}
						}
					}
				}
			}
		}
		return retVal;
	}

	// 958 enhancements
	public void getVendorLocationListForSubDept(String deptId,
			String subDeptId, String channel) throws CPSGeneralException {
		if (CPSHelper.isNotEmpty(channel)
				&& (CHANNEL_DSD.equalsIgnoreCase(channel) || CHANNEL_BOTH
						.equalsIgnoreCase(channel))) {
			String classField = this.getForm().getProductVO()
					.getClassificationVO().getClassField();
			String commodityVal = this.getForm().getProductVO()
					.getClassificationVO().getCommodity();
			String chnlVal = CPSWebUtil.getChannelValForService(channel);
			if (CPSHelper.isNotEmpty(deptId)) {
				if (deptId.length() < 2) {
					deptId = new StringBuilder(CPSConstant.STRING_0).append(
							deptId).toString();
				}
			}
			if (chnlVal != null && CHANNEL_DSD_CODE.equalsIgnoreCase(chnlVal)) {
				this.getForm().updateVendorList(deptId, subDeptId, classField,
						null, chnlVal);
			} else {
				this.getForm().updateVendorList(deptId, subDeptId, classField,
						commodityVal, chnlVal);
			}
		}
	}

	public String allowPrintFormMRT() {
		String ret = null;
		if (this.getForm().getMrtvo().getCaseVO().getPsItemId() != null) {
			return this.getForm().getMrtvo().getCaseVO().getPsItemId()
					.toString();
		}
		return ret;
	}

	// Fix 511
	public String isExistingUPC(String upc) throws Exception {
		boolean existingUPC = false;
		String data = null;

		// Check if the upc is same as that of the saved upc.
		if (CPSHelper.isNotEmpty(this.getForm().getMrtvo())
				&& CPSHelper.isNotEmpty(this.getForm().getMrtvo().getCaseVO())) {
			CaseVO caseVO = this.getForm().getMrtvo().getCaseVO();
			if (CPSHelper.isNotEmpty(caseVO.getCaseUPC())) {
				long caseUPC = CPSHelper.getLongValue(caseVO.getCaseUPC());
				if (caseUPC == CPSHelper.getLongValue(upc)) {
					return data;
				}
			}
		}

		List<MRTUPCVO> upcList = new ArrayList<MRTUPCVO>();
		if (null != this.getForm().getMrtvo()
				&& null != this.getForm().getMrtvo().getMrtVOs()) {
			upcList = this.getForm().getMrtvo().getMrtVOs();
		}
		if (upcList.size() > 0 && !upcList.isEmpty()) {
			existingUPC = CPSWebUtil.isExistCaseUpc(upcList, upc);
		}

		if (!existingUPC) {
			try {
				Object [] resultWs  = CommonBridge.getAddNewCandidateServiceInstance()
						.checkExistingProductUPC(upc);
				if(resultWs!=null) {
					existingUPC = (boolean) resultWs[0];
				}
			} catch (CPSSystemException e) {
				LOG.error(e.getMessage(), e);
				// returning the error message instead of throwing the exception
				CPSMessage msg = e.getCPSMessage();
				if (CPSHelper.isNotEmpty(msg)) {
					data = msg.getMessage();
				} else {
					data = "Service Error";
				}
				return data;
			}

			// check in PS_PROD_SCN_CODES
			if (!existingUPC) {
				int statusCode = CommonBridge
						.getAddNewCandidateServiceInstance()
						.checkExistingUPCType(upc);
				if (statusCode == 103 || statusCode == 107 || statusCode == 109
						|| statusCode == 105) {
					existingUPC = true;
				}
			}

			// check in PS_ITEM_MASTER and not Delete Status
			if (!existingUPC) {
				existingUPC = CommonBridge.getAddNewCandidateServiceInstance()
						.checkUPCDeleteExistsInItemMaster(upc);
			}
		}

		if (existingUPC) {
			data = "Case UPC exists. Please enter another Case UPC";
		}

		return data;
	}

	public List<BaseJSFVO> getPssDeptForVendor(String deptId, String subDeptId) {
		List<BaseJSFVO> pssList = new ArrayList<BaseJSFVO>();
		try {
			pssList = CommonBridge.getCommonServiceInstance()
					.getDeptNumbersForDeptSubDept(deptId, subDeptId);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return pssList;
	}

	public UPCVO saveUPC(String temp, boolean scnrio, String unitSize,
			String unitMeasureDesc, String unitMeasureCode, String length,
			String width, String height, String size, String subbrand,
			String rowId) {
		ProductVO productVO = this.getForm().getProductVO();
		UPCVO upcvo = productVO.getUpcVO(temp);
		if (upcvo != null) {
			upcvo.setBonus(scnrio);
			upcvo.setUnitSize(unitSize);
			upcvo.setUnitMeasureDesc(unitMeasureDesc);
			upcvo.setUnitMeasureCode(unitMeasureCode);
			upcvo.setLength(length);
			upcvo.setWidth(width);
			upcvo.setHeight(height);
			upcvo.setSize(size);
			if (CPSHelper.isNotEmpty(subbrand)) {
				String subId = subbrand.substring(
						subbrand.lastIndexOf('[') + 1,
						subbrand.lastIndexOf(']'));
				upcvo.setSubBrand(subId);
				upcvo.setSubBrandDesc(subbrand);
			} else {
				upcvo.setSubBrand(EMPTY_STRING);
				upcvo.setSubBrandDesc(EMPTY_STRING);
			}
			upcvo.setRowId(rowId);
			upcvo.setEditFlag(true);
			this.getForm().getProductVO().addUpcVO(upcvo);
			return upcvo;
		}

		return null;
	}

	// Validate MRTDru
	public boolean checkDRU(CaseVO caseVO) {
		// DRU
		boolean dsplyDryPalSw = caseVO.isDsplyDryPalSw();
		String srsAffTypCd = caseVO.getSrsAffTypCd();
		String prodFcngNbr = caseVO.getProdFcngNbr();
		String prodRowDeepNbr = caseVO.getProdRowDeepNbr();
		String prodRowHiNbr = caseVO.getProdRowHiNbr();
		if (dsplyDryPalSw) {
			if (("7").equals(srsAffTypCd) || ("9").equals(srsAffTypCd)) {
				int unitTotal = this.getForm().getMrtvo().getMrtUpcVO()
						.getUnitTotalAttribute();
				int totalProd = Integer.valueOf(prodFcngNbr)
						* Integer.valueOf(prodRowDeepNbr)
						* Integer.valueOf(prodRowHiNbr);
				if (unitTotal != totalProd) {
					caseVO.setMessage("Product of rows Facing, rows Deep and rows High is not equal to total units in this MRT. Please enter the values again.");
					return false;
				}
			}
		}
		return true;
	}

	// Fix PIM 354
	public String warningTaxFoodStamp(String productIds) {
		String warningData = EMPTY_STRING;
		String taxFllagWarning = EMPTY_STRING;
		String foodStampWarning = EMPTY_STRING;
		try {
			Map<Integer, ProductClassificationVO> lstProductClassificationVOs = CommonBridge
					.getAddNewCandidateServiceInstance()
					.getInforProductClassification(productIds);
			ProductClassificationVO productClassificationVO = null;
			Map<String, CommoditySubCommVO> subComm = null;
			CommoditySubCommVO codes = null;
			List<Integer> lstProductIds = new ArrayList<Integer>();
			CommoditySubCommVO codeOnlys = null;
			if (lstProductClassificationVOs != null
					&& !lstProductClassificationVOs.isEmpty()) {
				for (Map.Entry<Integer, ProductClassificationVO> entry : lstProductClassificationVOs
						.entrySet()) {
					Integer productId = entry.getKey();
					productClassificationVO = entry.getValue();

					subComm = CommonBridge.getCommonServiceInstance()
							.getSubCommoditiesForClassCommodity(
									productClassificationVO.getClassField(),
									productClassificationVO.getCommodity());
					codes = subComm.get(productClassificationVO
							.getSubCommodity());
					if (codes != null) {
						if (!codes.getFdStampCd().equals(
								productClassificationVO.getFoodStamp())) {
							foodStampWarning += productClassificationVO
									.getUpcs()
									+ " "
									+ productClassificationVO
											.getProdDescritpion();
							foodStampWarning += " - ";
							foodStampWarning += "Food Stamp flag = "
									+ productClassificationVO.getFoodStamp();
							foodStampWarning += "\n";
							codeOnlys = codes;
							if (!lstProductIds.contains(productId)) {
								lstProductIds.add(productId);
							}
						}
						if (!codes.getCrgTaxCd().equals(
								productClassificationVO.getTaxable())) {
							taxFllagWarning = taxFllagWarning
									+ productClassificationVO.getUpcs()
									+ " "
									+ productClassificationVO
											.getProdDescritpion();
							taxFllagWarning += " - ";
							taxFllagWarning += "Tax flag = "
									+ productClassificationVO.getTaxable();
							taxFllagWarning += "\n";
							codeOnlys = codes;
							if (!lstProductIds.contains(productId)) {
								lstProductIds.add(productId);
							}
						}
					}
				}
				if (CPSHelper.isNotEmpty(taxFllagWarning)
						|| CPSHelper.isNotEmpty(foodStampWarning)) {
					if (lstProductIds != null && lstProductIds.size() == 1) {
						if (!codeOnlys.getFdStampCd().equals(
								lstProductClassificationVOs.get(
										lstProductIds.get(0)).getFoodStamp())) {
							String foodStampValue = "N=No";
							String foodStampDefault = "N=No";
							if (("Y").equals(lstProductClassificationVOs.get(
									lstProductIds.get(0)).getFoodStamp()))
								foodStampValue = "Y=Yes";
							if (("Y").equals(codeOnlys.getFdStampCd()))
								foodStampDefault = "Y=Yes";
							warningData += "Food Stamp Flag (selected as "
									+ foodStampValue
									+ ") is different than the default for the sub-commodity (set at "
									+ foodStampDefault + ").";
						}
						if (!codeOnlys.getCrgTaxCd().equals(
								lstProductClassificationVOs.get(
										lstProductIds.get(0)).getTaxable())) {
							String taxFlagValue = "N=No";
							String taxFlagValueDefault = "N=No";
							warningData = warningData + "\n\n";
							if (("Y").equals(lstProductClassificationVOs.get(
									lstProductIds.get(0)).getTaxable()))
								taxFlagValue = "Y=Yes";
							if (("Y").equals(codeOnlys.getCrgTaxCd()))
								taxFlagValueDefault = "Y=Yes";
							warningData += " Tax Flag (selected as "
									+ taxFlagValue
									+ ") is different than the default for the sub-commodity (set at "
									+ taxFlagValueDefault + ").";
						}
						warningData = warningData + "\n";

					} else {
						warningData = "Following UPCs have Food stamp that is different than the default for the sub-commodity:\n"
								+ foodStampWarning;
						warningData = warningData
								+ "\n Following UPCs have Tax Flag that is different than the default for the sub-commodity:\n"
								+ taxFllagWarning;
					}
					warningData += "\n For assistance with the rules, please contact Procurement Support's Product Team at ext. 87800, Option #1.";
					warningData += "\n\nDo you want to proceed with activation?";
				}
			}
		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
		}
		return warningData;
	}

	// END Fix PIM 354

	// PIM 450
	public List<BaseJSFVO> getSalGrp() throws CPSGeneralException {
		List<BaseJSFVO> lstTemp = new ArrayList<BaseJSFVO>();
		try {
			lstTemp = CommonBridge.getCommonServiceInstance()
					.getAllSalsFromCache();
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return lstTemp;
	}

	public RatingVO getRating(String rateType, String salsRstrCd)
			throws CPSGeneralException {
		RatingVO ratingVO = null;
		try {
			Map<String,RatingVO> ratingMap = CommonBridge.getCommonServiceInstance().getMapAllRatingBySellResFromCache(rateType);
			if(CPSHelper.isNotEmpty(ratingMap)) {
				if(ratingMap.get(salsRstrCd)!=null) {
					ratingVO = ratingMap.get(salsRstrCd);
				}
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return ratingVO;
	}

	public AgeAndTimeRestricVO getAgeAndTimeRestric(String rateType,
			String rating) throws CPSGeneralException {
		AgeAndTimeRestricVO vo = new AgeAndTimeRestricVO();
		try {
			vo = CommonBridge.getCommonServiceInstance().getAgeAndTimeRestrict(
					rateType, rating);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return vo;
	}

	public AgeAndTimeRestricVO getAllParamForRating(String rating)
			throws CPSGeneralException {
		AgeAndTimeRestricVO vo = new AgeAndTimeRestricVO();
		try {
			vo = CommonBridge.getCommonServiceInstance().getAllParamForRating(
					rating);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return vo;
	}

	public void addPseValueForUpc(String[] key, String[] value)
			throws CPSGeneralException {
		for (int i = 0; i < key.length; i++) {
			ProductVO productVO = this.getForm().getProductVO();
			UPCVO upcvo = productVO.getUpcVO(key[i].trim());
			if (upcvo != null) {
				upcvo.setPseGram(value[i]);
				upcvo.setEditFlag(true);
				try {
					this.getForm().getProductVO().addUpcVO(upcvo);
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
				}
			}
		}
	}

	public void changePseGramVlType() throws CPSGeneralException {
		ProductVO productVO = this.getForm().getProductVO();
		List<UPCVO> upcvo = productVO.getUpcVO();
		if (!upcvo.isEmpty()) {
			for (UPCVO upcvo2 : upcvo) {
				upcvo2.setPseGram("0.0000");
				this.getForm().getProductVO().addUpcVO(upcvo2);
			}
		}
	}

	public boolean doCheckVendDCM(String vendorId) {
		return CommonBridge.getCommonServiceInstance().doCheckVendDCM(vendorId);
	}

	public boolean checkPluReuse(Integer prodId) throws Exception {
		boolean flag = false;
		if (CPSHelper.isNotEmpty(prodId)) {
			List<String> lstUPCs = CommonBridge
					.getAddNewCandidateServiceInstance().getPluUpcs(prodId);
			if (lstUPCs != null && !lstUPCs.isEmpty()) {
				for (String upc : lstUPCs) {
					flag = CommonBridge.getAddNewCandidateServiceInstance()
							.checkPluReuse(upc, prodId);
					if (flag)
						break;
				}
			}
		}
		return flag;
	}

	public boolean checkMultilPluReuse(String prodIs, String prodType)
			throws Exception {
		String prodIdsFilter = EMPTY_STRING;
		if (CPSHelper.isNotEmpty(prodType)) {
			StringTokenizer prodTypeToken = new StringTokenizer(prodType, COMMA);
			StringTokenizer prodIsToken = new StringTokenizer(prodIs, COMMA);
			String stringVal = EMPTY_STRING;
			String prodIdVal = EMPTY_STRING;
			while (prodTypeToken.hasMoreTokens()) {
				stringVal = prodTypeToken.nextToken();
				prodIdVal = prodIsToken.nextToken();
				if (("None-MRT").equals(stringVal)) {
					prodIdsFilter = prodIdsFilter + prodIdVal + ",";
				} else if (("MRT").equals(stringVal)) {
					break;
				}
			}
			if (CPSHelper.isNotEmpty(prodIdsFilter)) {
				prodIdsFilter = prodIdsFilter.substring(0,
						prodIdsFilter.lastIndexOf(','));
			}
		} else {
			prodIdsFilter = prodIs;
		}
		boolean flag = false;
		if (CPSHelper.isNotEmpty(prodIdsFilter)) {
			Map<String, String> lstUPCs = CommonBridge
					.getAddNewCandidateServiceInstance().getMultilePluUpcs(
							prodIdsFilter);
			if (lstUPCs != null && !lstUPCs.isEmpty()) {
				String[] upcProdArray;
				for (String upcProd : lstUPCs.values()) {
					upcProdArray = upcProd.split("-");
					flag = CommonBridge.getAddNewCandidateServiceInstance()
							.checkPluReuse(upcProdArray[1],
									Integer.valueOf(upcProdArray[0]));
					if (flag)
						break;
				}
			}
		}
		return flag;
	}

	// To add the UPC(MRT) from the data table
	public boolean addMRTChild(MRTUPCVO mrtupcvo) {
		boolean flag = false;
		if (this.getForm().getMrtvo() != null
				&& this.getForm().getMrtvo().getCaseVO() != null
				&& this.getForm().getMrtvo().getCaseVO().getPsItemId() != null
				&& this.getForm().getMrtvo().getCaseVO().getPsItemId() > 0) {
			Integer psItmId = this.getForm().getMrtvo().getCaseVO()
					.getPsItemId();
			try {
				flag = CommonBridge.getAddNewCandidateServiceInstance()
						.saveMRTElementUPC(mrtupcvo, psItmId);
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
		}
		return flag;

	}

	public Map<String, String> getBricksBySubCommodity(String subCommId)
			throws Exception {
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate == null) {
			addNewCandidate = new AddNewCandidate();
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}

		Map<String, BaseJSFVO> bricks = CommonBridge.getCommonServiceInstance()
				.getBricksBySubCommodity(subCommId);
		Map<String, String> ret = new HashMap<String, String>();

		if (null != bricks) {
			if (bricks.isEmpty()) {
				ret.put("message", "No Brick found.");
			} else {
				addNewCandidate.getBrickMap().putAll(bricks);
			}
		}

		return ret;
	}

	public Map<String, Object> setDataForBrick(String brickId, String brickName) {
		HashMap<String, Object> ret = new HashMap<String, Object>();
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate == null) {
			try {
				addNewCandidate = new AddNewCandidate();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				ret.put("message", e.getMessage());
			}
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}

		if (addNewCandidate.getBrickMap() == null) {
			addNewCandidate.setBrickMap(new HashMap<String, BaseJSFVO>());
		}
		brickName += " [" + brickId + "]";
		BaseJSFVO bvo = new BaseJSFVO(brickId, brickName);
		bvo.setIdInLabel(true);
		addNewCandidate.getBrickMap().put(brickId, bvo);
		ret.put("brick", addNewCandidate.getBrickMap().get(brickId));
		return ret;
	}

	/**
	 * Check eligible.
	 * 
	 * @param commodityId
	 *            the commodity id
	 * @return the map
	 * @throws IOException
	 * @throws CPSWebException
	 */
	public Map<String, Object> checkEligible(String commodityId)
			throws Exception {
		HashMap<String, Object> ret = new HashMap<String, Object>();
		boolean isEligible = false;
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate == null) {
			try {
				addNewCandidate = new AddNewCandidate();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				ret.put("message", e.getMessage());
			}
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}
		Integer psWorkId = null;
		Integer psProdId = null;
		if (addNewCandidate.getProductVO() != null
				&& addNewCandidate.getProductVO().getWorkRequest() != null) {
			psProdId = addNewCandidate.getProductVO().getPsProdId();
			psWorkId = addNewCandidate.getProductVO().getWorkRequest()
					.getWorkIdentifier();
		}
		isEligible = CommonBridge.getCommonServiceInstance().checkElligible(
				null, commodityId, psWorkId, psProdId);
		ret.put("isEligible", isEligible);
		return ret;
	}

	public void checkAddRemoveBrick() throws Exception {
		AddNewCandidate addNewCandidate = (AddNewCandidate) WebContextFactory
				.get().getSession().getAttribute(AddNewCandidate.FORM_NAME);
		HashMap<String, Object> ret = new HashMap<String, Object>();
		if (addNewCandidate == null) {
			try {
				addNewCandidate = new AddNewCandidate();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				ret.put("message", e.getMessage());
			}
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}
		List<UPCVO> lstUpcVOsNew = new ArrayList<UPCVO>();
		String brickId = EMPTY_STRING;
		if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getUpcVO())) {
			for (UPCVO upcvo : addNewCandidate.getProductVO().getUpcVO()) {
				if (CPSHelper.isY(upcvo.getNewDataSw())) {
					lstUpcVOsNew.add(upcvo);
				} else {
					BaseJSFVO base = CommonBridge
							.getAddNewCandidateServiceInstance()
							.checkUpcActiveHasBrick(upcvo.getUnitUpc());
					if (null != base) {
						if (brickId.equals(EMPTY_STRING)) {
							brickId = base.getId();
						}
					}
				}
			}
		}
		// fix QC 1670 if eligible is Yes then continue check display
		// brick, if display switch brick is N
		// then delete all brick's of upcs(New) else insert brick into
		// upcs(New) if upc(Old) has brick
		if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getPsProdId())
				&& CPSHelper.isNotEmpty(brickId)) {
			if (!CommonBridge.getAddNewCandidateServiceInstance()
					.checkAddRemoveBrick(
							lstUpcVOsNew,
							addNewCandidate.getProductVO().getWorkRequest()
									.getWorkIdentifier(),
							addNewCandidate.getProductVO().getPsProdId().toString(),
							addNewCandidate.getProductVO().getClassificationVO()
									.getCommodity(), brickId)) {
				addNewCandidate.getProductVO().getImageAttVO().setNutriInfoVO(null);
				addNewCandidate.getProductVO().getImageAttVO()
						.setNutriInfoVOOrigin(null);
			}
		}
	}

	public Map<String, Object> initElligible() throws Exception {
		Map<String, Object> map = this.checkEligible(this.getForm()
				.getProductVO().getClassificationVO().getCommodity());
		this.getForm().getProductVO().getClassificationVO()
				.setEligible((Boolean) map.get("isEligible"));
		if (this.getForm().getSavedProductVO() != null
				&& this.getForm().getSavedProductVO().getClassificationVO() != null) {
			this.getForm().getSavedProductVO().getClassificationVO()
					.setEligible((Boolean) map.get("isEligible"));
		}
		// fix QC 1670
		if ((Boolean) map.get("isEligible")) {
			this.checkAddRemoveBrick();
		}
		// ----------------
		return map;
	}

	public Map<String, Object> getDataForBrick() {
		HashMap<String, Object> ret = new HashMap<String, Object>();
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate == null) {
			try {
				addNewCandidate = new AddNewCandidate();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				ret.put("message", e.getMessage());
			}
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}
		BaseJSFVO brick = new BaseJSFVO();
		if (addNewCandidate.getBrickMap() != null
				&& CPSHelper.isNotEmpty(addNewCandidate.getProductVO())
				&& CPSHelper.isNotEmpty(addNewCandidate.getProductVO()
						.getClassificationVO())
				&& CPSHelper.isNotEmpty(addNewCandidate.getProductVO()
						.getClassificationVO().getBrick())
				&& addNewCandidate.getBrickMap()
						.containsKey(
								addNewCandidate.getProductVO().getClassificationVO()
										.getBrick())) {
			brick = addNewCandidate.getBrickMap().get(
					addNewCandidate.getProductVO().getClassificationVO().getBrick());
		}
		ret.put("brick", brick);
		return ret;
	}

	/**
	 * Gets the customer hierarchy tree.
	 * 
	 * @param type
	 *            the type
	 * @return the customer hierarchy tree
	 */
	public Map<String, Object> getCustomerHierarchyTree(String type) {
		return CommonBridge.getCommonServiceInstance()
				.getCustomerHierarchyTree(type);
	}

	private boolean isITUPCLst(List<UPCVO> upcs) {
		boolean check = false;
		int count = 0;
		if (CPSHelper.isNotEmpty(upcs)) {
			for (UPCVO upcvo : upcs) {
				if (CPSConstant.STRING_ITUPC.equalsIgnoreCase(upcvo
						.getUpcType())) {
					count++;
				}
			}
			check = count == upcs.size();
		}
		return check;
	}

	public Map<String, Object> checkUpc() {
		HashMap<String, Object> ret = new HashMap<String, Object>();
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate == null) {
			try {
				addNewCandidate = new AddNewCandidate();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
				ret.put("message", e.getMessage());
			}
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}

		if (addNewCandidate.getBrickMap() == null) {
			addNewCandidate.setBrickMap(new HashMap<String, BaseJSFVO>());
		}
		boolean valid = addNewCandidate.getProductVO().getUpcVO() != null
				&& !addNewCandidate.getProductVO().getUpcVO().isEmpty();
		String msg = EMPTY_STRING;
		if (isITUPCLst(addNewCandidate.getProductVO().getUpcVO())) {
			msg = "Please enter a UPC without ITUPC type";
		}
		boolean newDataSw = false;
		for (UPCVO item : addNewCandidate.getProductVO().getUpcVO()) {
			if (CPSConstant.CHAR_Y == item.getNewDataSw()) {
				newDataSw = true;
			}
		}

		ret.put("valid", valid);
		ret.put("message", msg);
		ret.put("newDataSw", newDataSw);
		return ret;
	}

	public int getSizeUPC() {
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		return addNewCandidate.getProductVO().getSizeUpc();

	}

	public NutritionInfoVO getNutritionInfoBySrcSysId(String srcSysId,
			String upc) throws CPSSystemException, CPSGeneralException {
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		NutritionInfoVO nutriVO = CommonBridge
				.getAddNewCandidateServiceInstance().getNutriInfoBySourceId(
						srcSysId,
						upc,
						addNewCandidate.getProductVO().getPsProdId(),
						addNewCandidate.getProductVO().getWorkRequest()
								.getWorkIdentifier());
		if (nutriVO != null
				&& CPSHelper.isNotEmpty(nutriVO.getJsonNutriDataGrid())) {
			nutriVO.setJsonNutriDataGrid(ExtendAndBrickAttrHelper
					.buildDataNutritionDetaiToJson(nutriVO
							.getLstNutriDatagrid()));
		}
		List<BaseVO> lstNutriType = addNewCandidate.getProductVO().getImageAttVO()
				.getLstNutriType();
		List<BaseVO> lstSizeUOM = addNewCandidate.getProductVO().getImageAttVO()
				.getLstQuantityUOM();

		addNewCandidate.getProductVO().getImageAttVO().setNutriInfoVO(nutriVO);

		ImageAttriVOHelper.setNameForNutriId(nutriVO.getLstNutriDatagrid(),
				lstNutriType);
		ImageAttriVOHelper.setDescForUomCd(nutriVO.getLstNutriDatagrid(),
				lstSizeUOM);

		return nutriVO;
	}

	public void revertToNutriInforOrigin() {
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		addNewCandidate.getProductVO()
				.getImageAttVO()
				.setNutriInfoVO(
						addNewCandidate.getProductVO().getImageAttVO()
								.getNutriInfoVOOrigin());
	}

	public List<BaseVO> getLstNutriClaims() throws CPSSystemException,
			CPSGeneralException {
		return CommonBridge.getAddNewCandidateServiceInstance()
				.getLstNutriClaims();
	}

	public List<BaseVO> getLstNutriUOM() throws CPSSystemException,
			CPSGeneralException {
		List<BaseVO> lstRtn = null;
		AddNewCandidate addNewCandidate = (AddNewCandidate) WebContextFactory
				.get().getSession().getAttribute(AddNewCandidate.FORM_NAME);
		if (CPSHelper.isNotEmpty(addNewCandidate.getProductVO().getImageAttVO()
				.getLstQuantityUOM())) {
			lstRtn = addNewCandidate.getProductVO().getImageAttVO().getLstQuantityUOM();
		} else {
			lstRtn = CommonBridge.getAddNewCandidateServiceInstance()
					.getLstNutriUOM();
		}
		return lstRtn;
	}

	public String getImageInforUpload() {
		AddNewCandidate addNewCandidate = null;
		String strReturn = EMPTY_STRING;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate.getProductVO().getImageAttVO() != null
				&& addNewCandidate.getProductVO().getImageAttVO().getImageVODisplay() != null) {
			strReturn = "data:image/"
					+ addNewCandidate.getProductVO().getImageAttVO()
							.getImageVODisplay().getImgFrmatCd()
					+ ";base64,"
					+ addNewCandidate.getProductVO().getImageAttVO()
							.getImageVODisplay().getImgDataString();
		}
		return strReturn;
	}

	public String getShowImageFullSize(String uriTxt, String imgFrmatCd,
			int reslX, int reslY) throws CPSSystemException,
			CPSGeneralException {
		AddNewCandidate addNewCandidate = null;
		String strReturn = EMPTY_STRING;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);

		ProductVO vo = addNewCandidate.getProductVO();
		ImageVO imgVO = CommonBridge.getAddNewCandidateServiceInstance()
				.getImageFullSize(uriTxt, imgFrmatCd, reslX, reslY);
		vo.setImgFullSzVO(imgVO);
		if (addNewCandidate.getProductVO().getImageAttVO() != null
				&& addNewCandidate.getProductVO().getImgFullSzVO() != null) {
			strReturn = "data:image/"
					+ addNewCandidate.getProductVO().getImgFullSzVO().getImgFrmatCd()
					+ ";base64,"
					+ addNewCandidate.getProductVO().getImgFullSzVO()
							.getImgDataString();
		}
		return strReturn;
	}

	public boolean checkValidUpcCopyToAll() {
		boolean isValid = true;
		AddNewCandidate addNewCandidate = null;
		addNewCandidate = (AddNewCandidate) WebContextFactory.get().getSession()
				.getAttribute(AddNewCandidate.FORM_NAME);
		if (addNewCandidate == null) {
			try {
				addNewCandidate = new AddNewCandidate();
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
			WebContextFactory.get().getSession()
					.setAttribute(AddNewCandidate.FORM_NAME, addNewCandidate);
		}
		ProductVO prdVO = addNewCandidate.getProductVO();
		String upcSelected = prdVO.getUpcImageAndAttr();
		for (UPCVO upcVO : prdVO.getLstUpcs()) {
			if (upcSelected.equals(upcVO.getUnitUpc())
					&& CPSHelper.isN(upcVO.getNewDataSw())) {
				isValid = false;
				break;
			}
		}
		return isValid;
	}

	public boolean checkLstUpcIsScale(List<String> lstUpc) {
		boolean flag = false;
		ProductVO productVO = this.getForm().getProductVO();
		for (String temp : lstUpc) {
			UPCVO upcvo = productVO.getUpcVO(temp);
			if (CPSHelper.isY(upcvo.getNewDataSw())) {
				if (temp.startsWith("002") && temp.endsWith("00000")) {
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

	/**
	 * @author hungbang
	 * @param lstUpc
	 * @return
	 */
	public boolean checkScaleAttBasedOnUpc(List<String> lstUpc) {
		boolean flag = false;
		if (CPSHelper.isNotEmpty(lstUpc)) {
			String scaleAtt = EMPTY_STRING;
			try {
				if (checkLstUpcIsScale(lstUpc)) {
					scaleAtt = "I";
				} else {
					this.getForm().getProductVO().setScaleUPC(false);
				}
			} catch (Exception e) {
				LOG.error(e.getMessage(), e);
			}
			if (CPSHelper.isNotEmpty(scaleAtt)) {
				if ("I".equals(scaleAtt.trim())) {
					this.getForm().setScaleAttrib(scaleAtt.trim());
					flag = true;
				}
			} else {
				this.getForm().setScaleAttrib(EMPTY_STRING);
			}
		}
		return flag;
	}

	public List<String> getLstUpcFromForm(String temp) {
		ProductVO productVO = this.getForm().getProductVO();
		List<String> lst = new ArrayList<String>();
		if (CPSHelper.isNotEmpty(productVO.getUpcVO())
				&& CPSHelper.isNotEmpty(temp)) {
			for (UPCVO upcvo : productVO.getUpcVO()) {
				if (!temp.trim().equals(upcvo.getUnitUpc().trim())) {
					lst.add(upcvo.getUnitUpc().trim());
				}
			}
		}
		return lst;
	}

	public String mandatoryCustomerFriendDesc() {
		String color = "red";
		ProductVO productVO = this.getForm().getProductVO();
		if (CPSHelper.isNotEmpty(productVO.getUpcVO())) {
			for (UPCVO upcvo : productVO.getUpcVO()) {
				if (upcvo.getUnitUpc().startsWith("002")
						&& upcvo.getUnitUpc().endsWith("00000")) {
					color = "white";
					break;
				}
			}
		}
		return color;
	}

	public boolean isScaleUPCActive(ProductVO productVO) {
		boolean flag = false;
		if (CPSHelper.isNotEmpty(productVO.getUpcVO())) {
			for (UPCVO upcvo : productVO.getUpcVO()) {
				if (CPSHelper.isN(upcvo.getNewDataSw())) {
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

	public String removedDisableScaleAtt() {
		String flag = "false";
		ProductVO productVO = this.getForm().getProductVO();
		if (!this.getForm().isUpcViewOverRide()) {
			for (UPCVO upcvo : productVO.getUpcVO()) {
				if (upcvo.getUnitUpc().startsWith("002")
						&& upcvo.getUnitUpc().endsWith("00000")
						&& CPSHelper.isY(upcvo.getNewDataSw())) {
					this.getForm().setScaleAttrib("I");
					flag = "true";
					break;
				}
			}
		}
		return flag;
	}

	public String getSpellCheckDes(String cfd) throws CPSBusinessException {
		try {
			return CommonBridge.getSpellCheckServiceInstance()
					.spellCheckDesInput(cfd).trim();
		} catch (Exception e) {
			LOG.error("Error getSpellCheckDes :", e);
			throw new CPSBusinessException(new CPSMessage(e.getMessage(),
					ErrorSeverity.ERROR));
		}
	}

	private String getPssDeptDesc(String pssDeptId,
			List<PdNisCntlTab> pdNisCntlTabList) {
		String result = "-";
		if (CPSHelper.isNotEmpty(pdNisCntlTabList)) {
			for (PdNisCntlTab pdNisCntlTab : pdNisCntlTabList) {
				if (CPSHelper.getTrimmedValue(pssDeptId).equals(
						pdNisCntlTab.getPdCntlValCd().trim())) {
					result += pdNisCntlTab.getPdCntlValDes();
				}
			}
		}
		return result;
	}

	private List<BaseJSFVO> setDefault(List<BaseJSFVO> list, String defaultValue) {
		List<BaseJSFVO> correctedList = new ArrayList<BaseJSFVO>();
		List<PdNisCntlTab> pdNisCntlTabLst = new ArrayList<PdNisCntlTab>();
		try {
			pdNisCntlTabLst = CommonBridge.getCommonServiceInstance()
					.getAllPssDept();
		} catch (Exception e) {
		}
		if (CPSHelper.isNotEmptyOrNotZero(defaultValue)) {
			correctedList.add(0, new BaseJSFVO(defaultValue, defaultValue
					+ getPssDeptDesc(defaultValue, pdNisCntlTabLst)));
		}
		for (BaseJSFVO baseJSFVO : list) {
			if (!defaultValue.equals(baseJSFVO.getId())) {
				correctedList.add(baseJSFVO);
			}
		}
		return correctedList;
	}

	public String checkDSVItem(String itemId, String upc, String prodId)
			throws CPSGeneralException {
		StringBuilder warningDSV = new StringBuilder();
		if (CPSHelper.isNotEmpty(itemId)) {
			String temp = CommonBridge.getCommonServiceInstance().checkDSV(
					itemId);
			if (CPSHelper.isNotEmpty(temp)) {
				warningDSV.append(temp);
			}
		} else if (CPSHelper.isNotEmpty(prodId)) {
			String strItemId = CommonBridge.getCommonServiceInstance()
					.getItemIdBasedOnProdId(prodId);
			if (CPSHelper.isNotEmpty(strItemId)) {
				String temp = CommonBridge.getCommonServiceInstance().checkDSV(
						strItemId);
				if (CPSHelper.isNotEmpty(temp)) {
					warningDSV.append(temp);
				}
			}
		} else if (CPSHelper.isNotEmpty(upc)) {
			String strItemId = CommonBridge.getCommonServiceInstance()
					.getItemIdBasedOnUpc(upc);
			if (CPSHelper.isNotEmpty(strItemId)) {
				String temp = CommonBridge.getCommonServiceInstance().checkDSV(
						strItemId);
				if (CPSHelper.isNotEmpty(temp)) {
					warningDSV.append(temp);
				}
			}
		}
		return warningDSV.toString();
	}

	// Begin: Auto create new Item when morphing. Sprint 21
	// init CaseVO based on DSD parent
	private CaseVO copyCaseVOToCaseVOForMorph(CaseVO caseVO) {
		CaseVO caseVONew = new CaseVO();
		caseVONew.setMasterPack(caseVO.getMasterPack());
		caseVONew.setMasterLength(STRING_1);
		caseVONew.setMasterWidth(STRING_1);
		caseVONew.setMasterHeight(STRING_1);
		caseVONew.setMasterWeight(STRING_1);
		caseVONew.setShipPack(STRING_1);
		caseVONew.setShipLength(STRING_1);
		caseVONew.setShipWidth(STRING_1);
		caseVONew.setShipHeight(STRING_1);
		caseVONew.setShipWeight(STRING_1);
		caseVONew.setChannelVal(CHANNEL_WHS);
		caseVONew.setChannel(CHANNEL_WHS);
		// Calculate cube for WHS Case
		caseVONew.setMasterCube(this.getCube(caseVONew.getMasterHeight(),
				caseVONew.getMasterWidth(), caseVONew.getMasterLength()));
		caseVONew.setShipCube(this.getCube(caseVONew.getShipHeight(),
				caseVONew.getShipWidth(), caseVONew.getShipLength()));
		caseVONew.setItemCategory(STRING_1);
		caseVONew.setCaseDescription(caseVO.getCaseDescription());
		caseVONew.setCatchWeight(caseVO.isCatchWeight());
		caseVONew.setVariableWeight(caseVO.isVariableWeight());
		caseVONew.setNone(caseVO.isNone());
		caseVONew.setUnitFactor(caseVO.getUnitFactor());
		caseVONew.setCaseChkDigit(caseVO.getCaseChkDigit());
		caseVONew.setMaxShelfLifeDays(caseVO.getMaxShelfLifeDays());
		caseVONew.setInboundSpecificationDays(caseVO
				.getInboundSpecificationDays());
		caseVONew.setReactionDays(caseVO.getReactionDays());
		caseVONew.setGuaranteetoStoreDays(caseVO.getGuaranteetoStoreDays());
		caseVONew.setUpcValues(getLinkedUPCUniqueIds(caseVO));
		caseVONew.setPrimaryUpcUniqueId(getPrimaryUPCUniqueIds(caseVO));
		caseVONew.setCaseUPC(getLinkedUPCUniqueIds(caseVO));
		caseVONew.setOneTouch(caseVO.getOneTouch());
		caseVONew.setCodeDate(caseVO.isCodeDate());
		caseVONew.setMaxShip(caseVO.getMaxShip());
		caseVONew.setPurchaseStatus(caseVO.getPurchaseStatus());
		caseVONew.setDsplyDryPalSw(caseVO.isDsplyDryPalSw());
		caseVONew.setSrsAffTypCd(caseVO.getSrsAffTypCd());
		caseVONew.setProdFcngNbr(caseVO.getProdFcngNbr());
		caseVONew.setProdRowDeepNbr(caseVO.getProdRowDeepNbr());
		caseVONew.setProdRowHiNbr(caseVO.getProdRowHiNbr());
		caseVONew.setNbrOfOrintNbr(caseVO.getNbrOfOrintNbr());
		setCaseUPCVO(caseVONew, caseVO);
		return caseVONew;
	}

	private String getLinkedUPCUniqueIds(CaseVO caseVO) {
		List<CaseUPCVO> caseUPCVOs = caseVO.getCaseUPCVOs();
		List<String> upcs = new ArrayList<String>();
		String upcValues = EMPTY_STRING;
		if (!caseUPCVOs.isEmpty()) {
			for (CaseUPCVO caseUPCVO : caseUPCVOs) {
				if (caseUPCVO.isLinked()) {
					upcs.add(caseUPCVO.getUnitUpc());
				}
			}
			upcValues = String.join(",", upcs);
		}
		return upcValues;
	}

	private String getPrimaryUPCUniqueIds(CaseVO caseVO) {
		List<CaseUPCVO> caseUPCVOs = caseVO.getCaseUPCVOs();
		List<String> upcs = new ArrayList<String>();
		String upcValues = EMPTY_STRING;
		if (!caseUPCVOs.isEmpty()) {
			for (CaseUPCVO caseUPCVO : caseUPCVOs) {
				if (caseUPCVO.isPrimary()) {
					upcs.add(caseUPCVO.getUnitUpc());
				}
			}
			upcValues = String.join(",", upcs);
		}
		return upcValues;
	}

	private void setCaseUPCVO(CaseVO caseVONew, CaseVO caseVO) {
		List<CaseUPCVO> caseUPCVOs = caseVO.getCaseUPCVOs();
		for (CaseUPCVO caseUPCVO : caseUPCVOs) {
			CaseUPCVO newcaseUPCVO = new CaseUPCVO();
			newcaseUPCVO.setLinked(caseUPCVO.isLinked());
			newcaseUPCVO.setCheckDigit(caseUPCVO.getCheckDigit());
			newcaseUPCVO.setNewDataSw(caseUPCVO.getNewDataSw());
			newcaseUPCVO.setPrimary(caseUPCVO.isPrimary());
			newcaseUPCVO.setSeqNumber(caseUPCVO.getSeqNumber());
			newcaseUPCVO.setSize(caseUPCVO.getSize());
			newcaseUPCVO.setUnitMeasureCode(caseUPCVO.getUnitMeasureCode());
			newcaseUPCVO.setUnitMeasureDesc(caseUPCVO.getUnitMeasureDesc());
			newcaseUPCVO.setUnitUpc(caseUPCVO.getUnitUpc());
			newcaseUPCVO.setUnitSize(caseUPCVO.getUnitSize());
			newcaseUPCVO.setUpcType(caseUPCVO.getUpcType());
			newcaseUPCVO.setWorkRequest(caseUPCVO.getWorkRequest());
			caseVONew.addCaseUPCVO(newcaseUPCVO);
		}
	}

	// save new item morphed into ps item master
	public VendorVO addVendorVOForMorph(VendorVO vendorVO, CaseVO caseVO)
			throws CPSGeneralException {
		if (CPSHelper.isEmpty(vendorVO.getVendorLocationVal())) {
			throw new CPSBusinessException(new CPSMessage(
					"Select a Vendor to save the vendor", ErrorSeverity.ERROR));
		}
		// for Authorization Purpose - Starts Here
		this.clearAuthorizationValues();
		// for Authorization Purpose - Ends Here
		List<VendorVO> vendorVOs = caseVO.getVendorVOs();
		if (CPSHelper.isNotEmpty(vendorVOs)) {
			for (VendorVO existingVendorVO : vendorVOs) {
				String vendorNo = null;
				if (BusinessConstants.CHANNEL_WHS_CODE.equalsIgnoreCase(existingVendorVO
						.getVendorLocationTypeCode())) {
					if (CPSHelper.getStringValue(existingVendorVO
							.getVendorLocNumber()) != null
							&& CPSHelper.getStringValue(
									existingVendorVO.getVendorLocNumber())
									.length() > 6) {
						vendorNo = CPSHelper.getStringValue(
								existingVendorVO.getVendorLocNumber())
								.substring(2);
					} else {
						vendorNo = CPSHelper
								.getFormatVendorNumber(String
										.valueOf(existingVendorVO
												.getVendorLocNumber()));
					}
				} else {
					vendorNo = CPSHelper.getStringValue(existingVendorVO
							.getVendorLocNumber());
				}

				if (CPSHelper.checkEqualValue(vendorNo,
						vendorVO.getVendorLocationVal())) {
					throw new CPSBusinessException(
							new CPSMessage(
									"Vendor details already Exists, try saving another Vendor ",
									ErrorSeverity.ERROR));
				}
			}
		}
		if (CPSHelper.isEmpty(caseVO.getPsItemId())) {
			throw new CPSBusinessException(new CPSMessage(
					"Please create candidate before save vendor",
					ErrorSeverity.ERROR));
		}
		this.defaultVendorVO(vendorVO);
		if (null != caseVO) {
			vendorVO.setChannelVal(caseVO.getChannelVal());
			vendorVO.setChannel(caseVO.getChannel());
			caseVO.addVendorVO(vendorVO);
		}
		String deptNbr = null;
		String subDeptNbdr = null;

		// 958 enhancements
		if (CPSHelper.isNotEmpty(vendorVO.getDept())
				&& CPSHelper.isNotEmpty(vendorVO.getSubDeptId())) {
			deptNbr = vendorVO.getDept();
			subDeptNbdr = vendorVO.getSubDeptId();
		} else {
			deptNbr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getDeptId();
			subDeptNbdr = this
					.getForm()
					.getClassCommodityVO(
							this.getForm().getProductVO().getClassificationVO()
									.getCommodity()).getSubDeptId();
		}
		String prodType = CPSHelper.getTrimmedValue(this.getForm()
				.getProductVO().getClassificationVO().getProductType());
		String brand = CPSHelper.getTrimmedValue(this.getForm().getProductVO()
				.getClassificationVO().getBrand());
		if ("SPLY".equalsIgnoreCase(prodType)
				&& CPSConstant.STRING_0.equalsIgnoreCase(brand)) {
			if (null == vendorVO.getCostOwner()
					|| (null == vendorVO.getCostOwnerVal() || EMPTY_STRING
							.equals(vendorVO.getCostOwnerVal()))) {
				vendorVO.setCostOwner(BusinessConstants.UNASSIGNED);
				vendorVO.setCostOwnerVal(CPSConstant.STRING_0);
			}
			if (null == vendorVO.getTop2Top()
					|| (null == vendorVO.getTop2TopVal() || EMPTY_STRING
							.equals(vendorVO.getTop2TopVal()))) {
				vendorVO.setTop2Top(BusinessConstants.UNASSIGNED);
				vendorVO.setTop2TopVal(CPSConstant.STRING_0);
			}
		}

		vendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
		vendorVO.setShipPack(caseVO.getShipPack());
		if (null != vendorVO
				&& CPSHelper.isNotEmpty(vendorVO.getVendorLocationVal())) {
			if (getForm().getVendorVO().getVendorLocationForId(
					vendorVO.getVendorLocationVal()) != null) {
				if (null != getForm()
						.getVendorVO()
						.getVendorLocationForId(vendorVO.getVendorLocationVal())
						.getVendorLocationType()) {
					vendorVO.setVendorLocationTypeCode(getForm()
							.getVendorVO()
							.getVendorLocationForId(
									vendorVO.getVendorLocationVal())
							.getVendorLocationType());
					// Add vendLocTypeCode
					if (vendorVO.getVendorLocTypeCode() == null) {
						vendorVO.setVendorLocTypeCode(vendorVO
								.getVendorLocationTypeCode());
					}
				}
			} else {

				throw new CPSBusinessException(
						new CPSMessage(
								"Selected Vendor is invalid. Please try another vendor",
								ErrorSeverity.ERROR));

			}
			if (null != getForm().getVendorVO()
					.getVendorLocationForId(vendorVO.getVendorLocationVal())
					.getVendorId()) {
				vendorVO.setVendorLocNumber(CPSHelper.getIntegerValue(getForm()
						.getVendorVO()
						.getVendorLocationForId(vendorVO.getVendorLocationVal())
						.getVendorId()));
			}

		}
		vendorVO.setEdcWhsVendor(true);
		VendorVO retVendorVO = new VendorVO();
		try {
			retVendorVO = CommonBridge.getAddNewCandidateServiceInstance()
					.insertVendorToCase(caseVO, vendorVO,
							this.getForm().getProductVO());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		retVendorVO.setImportd(vendorVO.getImportd());
		retVendorVO.setChannel(caseVO.getChannel());
		retVendorVO.setChannelVal(CPSConstants.CHANNEL_WHS);
		retVendorVO.setShipPack(caseVO.getShipPack());
		retVendorVO.setMasterPack(caseVO.getMasterPack());
		retVendorVO.setShipPack(caseVO.getShipPack());
		retVendorVO.setUnitCostLabel(vendorVO.getUnitCostLabel());
		retVendorVO.setCostLinkRadio(vendorVO.isCostLinkRadio());
		retVendorVO.setItemCodeRadio(vendorVO.isItemCodeRadio());
		retVendorVO.setVendorLocationVal(vendorVO.getVendorLocationVal());

		if (retVendorVO.getNewDataSw() == CPSConstant.CHAR_Y) {
			retVendorVO.setVendorViewOverride(false);
		}
		caseVO.removeVendorVO(vendorVO.getUniqueId());
		caseVO.setVendorVO(retVendorVO.getUniqueId(), retVendorVO);

		// for Authorization Purpose - Starts Here
		this.setDefaultValuesForAuthorization(caseVO, retVendorVO, deptNbr,
				subDeptNbdr);
		// auto authorized whs 101
		String defaultAuth = setDefaultWHSAuthorizationMorph();
		retVendorVO.setConflict(defaultAuth);
		// for Authorization Purpose - Ends Here
		return retVendorVO;
	}

	@SuppressWarnings("unused")
	private String setDefaultWHSAuthorizationMorph() {
		String returnValue = EMPTY_STRING;
		String itemId = this.getForm().getItemID();
		String uniquevendorId = this.getForm().getVendorId();
		List<WareHouseVO> list = new ArrayList<WareHouseVO>();
		List<WareHouseVO> wareHouseListTemp;
		VendorList vendorList = new VendorList(null, null,
				CPSHelper.getIntegerValue(uniquevendorId));
		String vendorType = getVendorChannelType(uniquevendorId);
		String classCode = this.getForm().getProductVO().getClassCommodityVO().getClassCode();
			
		try {
			// Fetch the warehouse details from service - starts
			List<WareHouseVO> facilityList = CommonBridge
					.getCommonServiceInstance().getWareHouseList(vendorList, classCode);
			if (CPSHelper.isNotEmpty(facilityList)) {
				wareHouseListTemp = getWareHouseList(facilityList,
						CPSHelper.getTrimmedValue(uniquevendorId), itemId,
						vendorType);
				for (WareHouseVO wareHouseVO : wareHouseListTemp) {
					wareHouseVO.setCheck(true);
					wareHouseVO.setVendorWHSNumber(CPSHelper
							.getTrimmedValue(uniquevendorId));
					list.add(wareHouseVO);
				}
				// Fetch the warehouse details from service - Ends
				// saving the wareHouse details - Starts
				int psItemid = CPSHelper.getIntegerValue(itemId);
				for (WareHouseVO house : list) {
					if (STRING_101.equals(CPSHelper.getTrimmedValue(house
							.getFacilityNumber()))) {
						List<WareHouseVO> lstOnly101 = new ArrayList<WareHouseVO>();
						lstOnly101.add(house);
						List<WareHouseVO> savedList = CommonBridge
								.getAddNewCandidateServiceInstance()
								.insertAuthorizeWHS(psItemid, uniquevendorId,
										vendorType, lstOnly101, true, classCode);
					}

				}

				// saving the wareHouse details - Ends
			} else {
				returnValue = EMPTY_STRING;
			}
		} catch (CPSBusinessException e) {
			LOG.error(e.getMessage(), e);
			List<CPSMessage> msgList = e.getMessages();
			String messg = AUTHORIZE_SERVICE_ERROR;
			for (CPSMessage msg : msgList) {
				messg = CPSHelper.getTrimmedValue(msg.getMessage());
			}
			returnValue = messg;
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			String messg = AUTHORIZE_SERVICE_ERROR;
			returnValue = messg;
		}
		return returnValue;
	}

	// Morphed return false, not yet return true
	public boolean checkRelationalMorph(Integer psItemId) {
		return CommonBridge.getAddNewCandidateServiceInstance().checkRltMrp(
				psItemId);
	}

	// Have 706 return true, not yet return false
	public boolean isSevenZeroSix(String psItemId) {
		return CommonBridge.getAddNewCandidateServiceInstance()
				.checkStoreExists706(psItemId);
	}

	public CaseVO beforeMorph(String vendorUniqueId, String caseUniquId,
			boolean unAuthorizedStore706, String selectedVendorId) {
		CaseVO savedCase = new CaseVO();
		CaseVO caseItemCurrent = this.getExistingCaseVO(caseUniquId);
		String vendorUniques[] = vendorUniqueId.split("_");
		List<VendorVO> vendorVos = new ArrayList<VendorVO>();
		if (vendorUniques != null) {
			for (VendorVO vendor : caseItemCurrent.getVendorVOs()) {
				for (String value : vendorUniques) {
					if (CPSHelper.isNotEmpty(value)
							&& vendor.getUniqueId().equalsIgnoreCase(value)) {
						vendorVos.add(vendor);
						break;
					}
				}
			}
		} else {
			vendorVos.add(caseItemCurrent.getVendorVO(vendorUniqueId));
		}

		VendorVO currentVendorAuth706 = null;
		if(caseItemCurrent!=null && caseItemCurrent.getVendorVOs()!=null && caseItemCurrent.getPsItemId()!=null) {
			currentVendorAuth706 = getCurrentVendorAuth706(vendorVos,
				unAuthorizedStore706, caseItemCurrent.getPsItemId(),
				caseItemCurrent.getVendorVOs(), selectedVendorId);
		}
		boolean morphCondition = CPSHelper.andCondition(
				this.getForm() != null,
				this.getForm().getProductVO() != null,
				CPSHelper.getTrimmedValue(
						this.getForm().getProductVO().getClassificationVO()
								.getProductType()).equalsIgnoreCase(
						BusinessConstants.PROD_TYP_SELLABLE), CHANNEL_DSD
						.equals(CPSHelper.getTrimmedValue(caseItemCurrent
								.getChannel())), currentVendorAuth706 != null,
				checkRelationalMorph(caseItemCurrent.getPsItemId()));
		if (morphCondition) {
			List<String> upcLinkedItemCurrent = getUPCLinkedToItem(caseItemCurrent);
			if (!upcLinkedItemCurrent.isEmpty()
					&& upcLinkedItemCurrent.size() == 1
					&& currentVendorAuth706 != null) {
				// Check UPC morphed in any case items available
				boolean flag = isUPCMorphed(upcLinkedItemCurrent.get(0),
						caseItemCurrent, currentVendorAuth706);
				if (!flag) {
					String apNbrCurrent = getApNbrBasedOnVendNo(currentVendorAuth706
							.getVendorLocationVal());
					// Check EDC WHS linked in all Case Items
					Set<CaseVO> whsUpcLinkeds = getExistWHSeDCUpcs(
							caseItemCurrent, currentVendorAuth706,
							unAuthorizedStore706);
					if (CPSHelper.isNotEmpty(whsUpcLinkeds)) {
						// check not equals
						Set<CaseVO> lstWHSUpcTiedToDSDUpc = getLstWHSUpcTiedToDSDUpc(
								upcLinkedItemCurrent.get(0), whsUpcLinkeds);
						if (CPSHelper.isNotEmpty(lstWHSUpcTiedToDSDUpc)) {
							return executeMorph(caseItemCurrent,
									currentVendorAuth706, apNbrCurrent);
						}
					} else {
						return executeMorph(caseItemCurrent,
								currentVendorAuth706, apNbrCurrent);
					}
				}
			}
		}
		savedCase.setMorphWarning(NO_MORPHING);
		return savedCase;
	}

	private boolean isUPCMorphed(String upc, CaseVO caseItemCurrent,
			VendorVO vendorVO) {
		List<CaseVO> caseVOs = this.getForm().getProductVO().getCaseVOs();
		if (!caseVOs.isEmpty()) {
			for (CaseVO caseVO : caseVOs) {
				if (CHANNEL_DSD.equals(CPSHelper.getTrimmedValue(caseVO
						.getChannel()))) {
					boolean flag = CommonBridge
							.getAddNewCandidateServiceInstance().checkRltMrp(
									caseVO.getPsItemId());
					if (!flag) {
						String upcTemp = EMPTY_STRING;
						for (CaseUPCVO caseUPCVO : caseVO.getCaseUPCVOs()) {
							if (caseUPCVO.isLinked()) {
								upcTemp = caseUPCVO.getUnitUpc();
								break;
							}
						}
						if (CPSHelper.getTrimmedValue(upc).equals(
								CPSHelper.getTrimmedValue(upcTemp))) {
							return true;
						}
					}
				} else {
					if (CHANNEL_WHS.equals(CPSHelper.getTrimmedValue(caseVO
							.getChannel()))) {
						try {
							List<VendorVO> lstVendorOfWHS = caseVO
									.getVendorVOs();
							if (!lstVendorOfWHS.isEmpty()) {
								if (lstVendorOfWHS.size() == 1) {
									VendorLocDeptVO vendLocDept = CommonBridge
											.getCommonServiceInstance()
											.getVendorFromCache(
													"W-"
															+ lstVendorOfWHS
																	.get(0)
																	.getVendorLocationVal());
									if (CPSHelper.isNotEmpty(vendLocDept)) {
										if (CPSHelper
												.getTrimmedValue(
														vendorVO.getVendorLocationVal())
												.equals(CPSHelper
														.getTrimmedValue(vendLocDept
																.getApNbr()))) {
											String upcTemp = EMPTY_STRING;
											for (CaseUPCVO caseUPCVO : caseVO
													.getCaseUPCVOs()) {
												if (caseUPCVO.isLinked()) {
													upcTemp = caseUPCVO
															.getUnitUpc();
													break;
												}
											}
											if (CPSHelper
													.getTrimmedValue(upc)
													.equals(CPSHelper
															.getTrimmedValue(upcTemp))) {
												return true;
											}
										}
									}
								} else {
									for (VendorVO vendVO : lstVendorOfWHS) {
										VendorLocDeptVO vendLocDept = CommonBridge
												.getCommonServiceInstance()
												.getVendorFromCache(
														"W-"
																+ vendVO.getVendorLocationVal());
										if (CPSHelper.isNotEmpty(vendLocDept)) {
											if (CPSHelper
													.getTrimmedValue(
															vendorVO.getVendorLocationVal())
													.equals(CPSHelper
															.getTrimmedValue(vendLocDept
																	.getApNbr()))) {
												String upcTemp = EMPTY_STRING;
												for (CaseUPCVO caseUPCVO : caseVO
														.getCaseUPCVOs()) {
													if (caseUPCVO.isLinked()) {
														upcTemp = caseUPCVO
																.getUnitUpc();
														break;
													}
												}
												if (CPSHelper
														.getTrimmedValue(upc)
														.equals(CPSHelper
																.getTrimmedValue(upcTemp))) {
													return true;
												}
											}
										}
									}
								}
							}
						} catch (Exception e) {
							LOG.error(e.getMessage(), e);
						}
					}
				}

			}
		}
		return false;
	}

	private Set<CaseVO> getLstWHSUpcTiedToDSDUpc(String upcLinkedCurrent,
			Set<CaseVO> whsUpcLinkeds) {
		Set<CaseVO> returnCaseVOs = new HashSet<CaseVO>();
		for (CaseVO caseVO : whsUpcLinkeds) {
			List<CaseUPCVO> caseUPCVOs = caseVO.getCaseUPCVOs();
			if (!caseUPCVOs.isEmpty()) {
				for (CaseUPCVO caseUPCVO : caseUPCVOs) {
					if (caseUPCVO.isLinked()) {
						if (!upcLinkedCurrent.equalsIgnoreCase(CPSHelper
								.getTrimmedValue(caseUPCVO.getUnitUpc()))) {
							returnCaseVOs.add(caseVO);
							break;
						}
					}
				}
			}
		}
		return returnCaseVOs;
	}

	private Set<CaseVO> getExistWHSeDCUpcs(CaseVO caseItemCurrent,
			VendorVO currentVendorAuth706, boolean unAuthorizedStore706) {
		List<CaseVO> caseVOs = this.getForm().getProductVO().getCaseVOs();
		Set<CaseVO> returnCaseVOs = new HashSet<CaseVO>();
		if (!caseVOs.isEmpty()) {
			int count = 0;
			for (CaseVO caseVO : caseVOs) {
				if (CHANEL_WHS.equals(CPSHelper.getTrimmedValue(caseVO
						.getChannelVal()))) {
					count++;
					List<CaseUPCVO> caseUPCVOs = caseVO.getCaseUPCVOs();
					if (!caseUPCVOs.isEmpty()) {
						for (CaseUPCVO caseUPCVO : caseUPCVOs) {
							if (caseUPCVO.isLinked()) {
								returnCaseVOs.add(caseVO);
							}
						}
					}
				}
			}
			if (unAuthorizedStore706 && count == 0) {
				returnCaseVOs = null;
			} else {
				if (count == 0
						&& CPSHelper.getBigdecimalValue(
								CPSHelper.getTrimmedValue(currentVendorAuth706
										.getListCost())).compareTo(
								BigDecimal.ZERO) == 0) {
					returnCaseVOs.add(caseItemCurrent);
				}
			}
		}
		return returnCaseVOs;
	}

	private List<String> getUPCLinkedToItem(CaseVO caseVO) {
		List<String> upcLinked = new ArrayList<String>();
		List<String> upcActivateLinked = new ArrayList<String>();
		List<CaseUPCVO> caseUPCVOs = caseVO.getCaseUPCVOs();
		int itemNotModify = 0;
		int itemModify = 0;
		for (CaseUPCVO caseUPCVO : caseUPCVOs) {
			if (caseUPCVO.isLinked()) {
				// Always = N if UPC is activated
				if (caseUPCVO.getNewDataSw() == CPSConstant.CHAR_Y) {
					upcLinked.add(caseUPCVO.getUnitUpc());
					itemModify++;
				} else {
					itemNotModify++;
					upcActivateLinked.add(caseUPCVO.getUnitUpc());
				}
			}
		}
		if (itemNotModify > 0) {
			if (itemNotModify == caseVO.getCaseUPCVOs().size()) {
				upcLinked = upcActivateLinked;
			} else if (itemNotModify >= itemModify && itemModify > 0) {
				upcLinked.addAll(upcActivateLinked);
			}
		}
		return upcLinked;
	}

	public CaseVO executeMorph(CaseVO caseVO, VendorVO vendorVO, String apNbr) {
		String classField = this.getForm().getProductVO().getClassificationVO()
				.getClassField();
		CaseVO eDCSavedCase = new CaseVO();
		VendorVO savedVendorVOeDC = null;
		List<WareHouseVO> bicepVendLst = null;
		String psItemIdParent = CPSHelper.getTrimmedValue(caseVO.getPsItemId());
		String commodityVal = this.getForm().getProductVO()
				.getClassificationVO().getCommodity();
		try {
			if (null != apNbr) {
				bicepVendLst = getBicepVendorLst(apNbr, classField);
			}
		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
		}
		if (CPSHelper.isNotEmpty(bicepVendLst)) {
			WareHouseVO bicepHas101 = checkBicepExistsWhseNbr101(bicepVendLst);

			if (bicepHas101 != null) {
				CaseVO newCaseVO = copyCaseVOToCaseVOForMorph(caseVO);
				try {
					eDCSavedCase = addCaseVO(newCaseVO);
					CommonBridge.getAddNewCandidateServiceInstance()
							.insertRelated(eDCSavedCase.getPsItemId(),
									CPSHelper.getIntegerValue(psItemIdParent),
									MORPH);
				} catch (Exception e) {
					LOG.error(e.getMessage(), e);
				}
				if (eDCSavedCase != null) {
					VendorVO newVendorVO = new VendorVO();
					copyVendorVOToVendorVOForMorph(vendorVO, newVendorVO,
							caseVO.getMasterPack(), bicepHas101);
					String chnlVal = CPSWebUtil
							.getChannelValForService(newCaseVO.getChannelVal());
					try {
						this.getForm().updateVendorList(null, null, classField,
								commodityVal, chnlVal);
						savedVendorVOeDC = addVendorVOForMorph(newVendorVO,
								eDCSavedCase);
					} catch (CPSGeneralException e) {
						LOG.error(e.getMessage(), e);
					}
				}
			} else {
				eDCSavedCase.setMorphWarning(ERROR_101);
			}
		} else {
			eDCSavedCase.setMorphWarning(ERROR_MORPH);
		}
		this.getForm().seteDcVendorVO(savedVendorVOeDC);
		if (CPSHelper.isEmpty(eDCSavedCase.getMorphWarning())) {
			eDCSavedCase.setMorphWarning(MORPH);
		}
		CPSHelper.setChannelForMorph(eDCSavedCase);
		return eDCSavedCase;
	}

	private WareHouseVO checkBicepExistsWhseNbr101(
			List<WareHouseVO> bicepVendLst) {
		for (WareHouseVO baseVO : bicepVendLst) {
			if (STRING_101.equals(CPSHelper.getTrimmedValue(baseVO
					.getVendorNumber()))) {
				return baseVO;
			}
		}
		return null;
	}

	private String getApNbrBasedOnVendNo(String uniquevendorId) {
		return CommonBridge.getAddNewCandidateServiceInstance()
				.getApNbrBasedOnVendNo(uniquevendorId);
	}

	private VendorVO copyVendorVOToVendorVOForMorph(VendorVO from, VendorVO to,
			String mspack, WareHouseVO bicepHas101) {
		to.setCostLink(from.getCostLink());
		to.setCostLinkRadio(from.isCostLinkRadio());
		to.setItemCodeRadio(from.isItemCodeRadio());
		to.setCostOwner(from.getCostOwner());
		to.setCostOwnerVal(from.getCostOwnerVal());
		to.setCountryOfOrigin(from.getCountryOfOrigin());
		to.setCountryOfOriginVal(from.getCountryOfOriginVal());
		to.setDealOffered(from.isDealOffered());
		to.setGuarenteedSale(from.isGuarenteedSale());
		to.setImportd(from.getImportd());
		to.setSeasonality(from.getSeasonality());
		to.setSeasonalityVal(from.getSeasonalityVal());
		to.setSeasonalityYr(from.getSeasonalityYr());
		to.setTop2Top(from.getTop2Top());
		to.setTop2TopVal(from.getTop2TopVal());
		to.setVendorLocationVal(bicepHas101.getVendorWHSNumber());
		to.setVendorLocation(bicepHas101.getWhareHouseName());
		to.setVendorTie(STRING_1);
		to.setVendorTier(STRING_1);
		to.setVpc(from.getVpc());

		/**
		 * Expression calculate List Cost for EDC Vendor:
		 * 
		 * List Cost ( of the newly created Item) = List Cost ( of original
		 * Item) / Master Pack (of Original Item) Unit Cost = List Cost / Ship
		 * Pack
		 */

		BigDecimal mPack = CPSHelper.getBigdecimalValue(mspack);
		BigDecimal dsdListCost = CPSHelper.getBigdecimalValue(from
				.getListCostFormatted());
		BigDecimal eDCListCost = null;
		if (mPack != null && BigDecimal.ZERO.compareTo(mPack) == -1) {
			eDCListCost = dsdListCost.divide(mPack, 4, RoundingMode.HALF_EVEN);
		}
		if (eDCListCost != null) {
			to.setListCost(eDCListCost.toString());
			to.setUnitCost(eDCListCost.toString());
			to.setUnitCostLabel(eDCListCost.toString());
		}
		to.setExpectedWeeklyMvt(STRING_1);
		to.setOrderRestriction(from.getOrderRestriction());
		to.setOrderRestrictionVal(from.getOrderRestrictionVal());
		// Order Unit changes
		to.setOrderUnit(from.getOrderUnit());
		// 958 enhancements
		to.setSubDept(from.getSubDept());
		// 958 PSS
		to.setPssDept(from.getPssDept());
		to.getImportVO()
				.setContainerSize(from.getImportVO().getContainerSize());
		to.getImportVO().setColor(from.getImportVO().getColor());
		to.getImportVO().setMinimumType(from.getImportVO().getMinimumType());
		to.getImportVO().setAgentPerc(from.getImportVO().getAgentPerc());
		to.getImportVO().setPickupPoint(from.getImportVO().getPickupPoint());
		to.getImportVO().setIncoTerms(from.getImportVO().getIncoTerms());
		to.getImportVO().setInstoreDate(from.getImportVO().getInstoreDate());
		to.getImportVO()
				.setWhseFlushDate(from.getImportVO().getWhseFlushDate());
		to.getImportVO().setFreight(from.getImportVO().getFreight());
		to.getImportVO()
				.setProrationDate(from.getImportVO().getProrationDate());
		to.getImportVO().setHts(from.getImportVO().getHts());
		to.getImportVO().setCartonMarketing(
				from.getImportVO().getCartonMarketing());
		to.getImportVO().setMinimumQty(from.getImportVO().getMinimumQty());
		to.getImportVO().setRate(from.getImportVO().getRate());
		to.getImportVO().setDuty(from.getImportVO().getDuty());

		// R2 enhancement
		to.getImportVO().setHts2(from.getImportVO().getHts2());
		to.getImportVO().setHts3(from.getImportVO().getHts3());
		to.getImportVO().setFactoryIDs(from.getImportVO().getFactoryIDs());
		// End R2 enhancement

		// Add season and sellYear
		to.getImportVO().setSeason(from.getImportVO().getSeason());
		to.getImportVO().setSellYear(from.getImportVO().getSellYear());
		// end add sellYear
		// add dutyInfo
		to.getImportVO().setDutyInfo(from.getImportVO().getDutyInfo());
		return to;
	}

	public List<WareHouseVO> getBicepVendorLst(String uniquevendorId,
			String vendClsCd) throws CPSGeneralException {
		return CommonBridge.getAddNewCandidateServiceInstance()
				.getLstBicepVendor(uniquevendorId, vendClsCd);
	}

	public VendorVO addVendorForMorph(CaseVO caseVO) {
		VendorVO edcVendorVO = this.getForm().geteDcVendorVO();
		return edcVendorVO;
	}

	// End : Auto create new Item when morphing. Sprint 21

	private void validateMarginAndPennyProfit(CaseVO caseVo, VendorVO vendorVo) {
		String unitCostReal = CPSConstant.STRING_EMPTY;
		if (caseVo.getChannelVal() != null
				&& caseVo.getChannelVal().equals(CHANNEL_BOTH)) {
			unitCostReal = vendorVo.getUnitCostLabelFormattedBoth();
		} else {
			unitCostReal = vendorVo.getUnitCostLabelFormatted();
		}
		StringBuilder messageWaring = new StringBuilder();
		if ("priceRequired".equals(this.getForm().getProductVO().getRetailVO()
				.getRetailRadio())
				&& (CPSHelper.isEmpty(this.getForm().getProductVO()
						.getRetailVO().getRetailFor()) || CPSHelper
						.getIntegerValue(this.getForm().getProductVO()
								.getRetailVO().getRetailFor()) == 0)) {
			messageWaring
					.append("% Margin and Penny profit are blank. Because Price Required field checked.");
		} else if (CPSHelper.isEmpty(this.getForm().getProductVO()
				.getRetailVO().getRetailFor())
				|| CPSHelper.getIntegerValue(this.getForm().getProductVO()
						.getRetailVO().getRetailFor()) == 0) {
			messageWaring
					.append("% Margin and Penny Profit are blank. Please enter Retail For value greater than 0.");
		} else if (CPSHelper.isEmpty(vendorVo.getListCost())
				&& CPSHelper.isEmpty(unitCostReal)) {
			messageWaring
					.append("% Margin and Penny Profit are blank. Please enter List Cost value.");
		} else if (!CPSHelper.isEmpty(vendorVo.getListCost())
				&& CPSHelper.isEmpty(unitCostReal)) {
			messageWaring
					.append("% Margin and Penny Profit are blank. Please enter Ship Pack / Master Pack value.");
		}
		vendorVo.setMarginMessageWarning(messageWaring.toString());
	}

	public boolean isWHSeDC(String psItemId) {
		List<CaseVO> caseVOs = this.getForm().getProductVO().getCaseVOs();
		for (CaseVO caseVO : caseVOs) {
			if (CPSHelper.isNotEmpty(psItemId)
					&& CPSHelper.getTrimmedValue(psItemId).equals(
							CPSHelper.getTrimmedValue(caseVO.getPsItemId()))) {
				if (CHANNEL_WHSDSD.equals(CPSHelper.getTrimmedValue(caseVO
						.getChannel()))) {
					return true;
				}
			}
		}
		return false;
	}

	// SPRINT 22
	@SuppressWarnings("null")
	public List<BaseJSFVO> getUOMFromSubCommodity(String subCommodity) {
		List<BaseJSFVO> originalUom = null;
		List<BaseJSFVO> results = null;
		List<BaseJSFVO> eliminateUom = null;
		try {
			originalUom = CommonBridge.getCommonServiceInstance().getUOMs();
			CPSHelper.sortList(originalUom);
			originalUom.add(0, new BaseJSFVO("NONE", "--Select--"));
			List<BaseJSFVO> uomDefaults = CommonBridge
					.getCommonServiceInstance().getUOMDefaultBySubCommodity(
							subCommodity);
			if (CPSHelper.isNotEmpty(uomDefaults)
					&& CPSHelper.isNotEmpty(originalUom)) {
				results = new ArrayList<BaseJSFVO>();
				eliminateUom = new ArrayList<BaseJSFVO>();
				results.add(0, new BaseJSFVO("NONE", "--Select--"));
				results.addAll(uomDefaults);
				results.add(new BaseJSFVO(CPSConstant.STRING_EMPTY,
						"---------------------"));
				for (BaseJSFVO uom : originalUom) {
					boolean found = false;
					for (BaseJSFVO uomDefault : results) {
						if (uomDefault.getId().equalsIgnoreCase(uom.getId())
								|| uom.getId().equalsIgnoreCase("NONE")) {
							found = true;
							break;
						}
					}
					if (!found) {
						eliminateUom.add(uom);
					}
				}
				results.addAll(eliminateUom);
			} else {
				results = originalUom;
			}
		} catch (CPSGeneralException e) {
			LOG.error(e.getMessage(), e);
		}
		return results;
	}
	
	public UPCKitVO addUPCKit(String unitUpc,
			String quantity, String upcDigit) throws Exception {
		UPCKitVO upcKit = new UPCKitVO();
		boolean check = true;
		boolean fakePredigitUPC = false;
		unitUpc = (null == unitUpc) ? CPSConstants.EMPTY_STRING : CPSHelper
				.getPadding(unitUpc);
		upcDigit = (null == upcDigit) ? CPSConstants.EMPTY_STRING
				: upcDigit;
		quantity = (null == quantity || CPSConstants.EMPTY_STRING
				.equalsIgnoreCase(quantity)) ? CPSConstant.STRING_0
				: quantity;
		upcKit.setMessage(CPSConstants.EMPTY_STRING);
		if (CPSConstants.EMPTY_STRING.equals(unitUpc)) {
			upcKit.setMessage("Please enter Unit UPC Value");
		} else {
			fakePredigitUPC = CPSHelper.isFakePredigitUPC(unitUpc);
			if (!fakePredigitUPC) {
				List<UPCKitVO> upcKits = this.getForm().getProductVO().getUpcKitVOs();
				check = CPSWebUtil.isExistingUpcKit(upcKits, unitUpc, 0);
				boolean flagWebservice = false;
				if (check) {// && this.isValidCheckDigit(unitUpc, upcDigit)) {
					try {
						upcKit = CommonBridge
								.getAddNewCandidateServiceInstance()
								.getUPCKit(unitUpc);
						flagWebservice = true;
					} catch (CPSBusinessException e) {
						LOG.error(e.getMessage(), e);
					} catch (CPSSystemException ex) {
						LOG.error(ex.getMessage(), ex);
						upcKit.setDescription(EMPTY_STRING);
					}
					if(flagWebservice && upcKit!=null) {
						//Check 2 UPCs have the same product ID
						check = CPSWebUtil.isExistingUpcKit(upcKits, unitUpc, upcKit.getRelatedProdId());
						if(check) {
							boolean isSaved=false;
							UserInfo userInfo = getUserInfo();
							upcKit.setQuantity(Integer.parseInt(quantity));
							upcKit.setUpcKitSaved(true);
							upcKit.setLstUpdtUid(userInfo.getUid());
							//upcKit.setUpcDigit(Integer.parseInt(upcDigit));
							if (this.getForm().getProductVO() != null
									&& this.getForm().getProductVO().getPsProdId() != null
									&& this.getForm().getProductVO().getPsProdId() > 0 && CPSHelper.isEmpty(upcKit.getMessage())) {
								try {
									List<UPCKitVO> upcKitVOs = new ArrayList<UPCKitVO>();
									upcKitVOs.add(upcKit);
									CommonBridge.getAddNewCandidateServiceInstance().insertUPCKitComponent(upcKitVOs, this.getForm().getProductVO().getPsProdId());
									isSaved = true;
								} catch (Exception e) {
									LOG.error(e.getMessage(), e);
								}
							}
							if(CPSHelper.isEmpty(upcKit.getMessage())) {
								//Prevent the application to saving data again while user has any action to save database on UI
								if(isSaved) {
									upcKit.setUpcKitSaved(false);
								}
								this.getForm().getProductVO().addUPCKitVO(upcKit);
								
								// PIM-1527 update list cost
								List<UPCKitVO> upcKitVOList = this.getForm().getProductVO().getUpcKitVOs();
								int psWorkId = this.getForm().getProductVO().getWorkRequest().getWorkIdentifier();
								CommonBridge.getAddNewCandidateServiceInstance().updateListCostKit(upcKitVOList, psWorkId);
							}
						} else {
							upcKit.setMessage("Cannot add associated UPCs to the same kit.");
						}
					} else {
						upcKit = new UPCKitVO();
						upcKit.setMessage("Please enter an existing Product UPC.");
					}
				} else {
					//if (check) {
					//	upcKit.setMessage("InValid Check Digit. Please Re-enter the UPC/Checkdigit Value.");
					//} else {
						upcKit.setMessage("Duplicate UPC. Please enter another UPC.");
					//}
				}
			} else {
				upcKit.setMessage("Parent fake pre-digit UPC cannot be entered. Please enter another UPC.");
			}
		}
		return upcKit;
	}
	
	
	public UPCKitVO deleteUPCKit(String uniqueId) throws Exception {
		Integer psProdId = this.getForm().getProductVO().getPsProdId();
		UPCKitVO upcKitVO = this.getForm().getProductVO().getUPCKitVO(uniqueId);
		//if (upcKitVo.isUpcKitSaved()) {
		if (!CPSHelper.isEmpty(psProdId)) {
			CommonBridge.getAddNewCandidateServiceInstance().deleteUPCKit(psProdId, upcKitVO.getUnitUPC(),upcKitVO.getRelatedProdId());
		}
		//}
		UPCKitVO retUpcKitVO = this.getForm().getProductVO().removeUPCKitVO(uniqueId);

		// PIM-1527 update list cost
		List<UPCKitVO> upcKitVOList = this.getForm().getProductVO().getUpcKitVOs();
		int psWorkId = this.getForm().getProductVO().getWorkRequest().getWorkIdentifier();
		CommonBridge.getAddNewCandidateServiceInstance().updateListCostKit(upcKitVOList, psWorkId);
		return retUpcKitVO;
	}
	
	/**
	 * Update nutrient information approved
	 * Return person who approved and approved date
	 * 
	 * @return ProductVO
	 * @throws CPSGeneralException
	 */
	public ProductVO updateApproveSwitch() {
		UserInfo userInfo = getUserInfo();
		String approvedUserId = userInfo.getUid();
		String approvedUserName = CPSHelper.isEmpty(userInfo.getDisplayName()) ? userInfo.getUid() : userInfo.getDisplayName();
		ProductVO productVO = this.getForm().getProductVO();
		
		try {
			CommonBridge.getAddNewCandidateServiceInstance().updateApproveSwitch(productVO, approvedUserId);
		} catch (CPSGeneralException e) {
			LOG.error("Error in updateApproveSwitch method: " + e);
		}
		productVO.setApprByUserName(approvedUserName);
		return productVO;
	}
	
	/**
	 * Get nutrition facts information.
	 * @return ProductVO
	 * @throws CPSGeneralException
	 */
	public ProductVO getNutritionFactsInformation() throws CPSGeneralException{
		ProductVO productVO = this.getForm().getProductVO();
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
		CommonBridge.getAddNewCandidateServiceInstance().getNutritionFactsInformation(productVO, unitUPCs, psWrkId, mapUnitUPC);	
		return productVO;
	}

	/**
	 * Update quantity of UPC Kit components.
	 * 
	 * @param uniqueId
	 * @param quantity
	 * @return
	 * @throws Exception
	 */
	public UPCKitVO updateUPCKit(String uniqueId, String quantity) throws Exception {
		quantity = (null == quantity || CPSConstants.EMPTY_STRING.equalsIgnoreCase(quantity)) ? CPSConstant.STRING_0
				: quantity;
		int numQuantity = Integer.parseInt(quantity);
		
		Integer psProdId = this.getForm().getProductVO().getPsProdId();
		UPCKitVO upcKitVo = this.getForm().getProductVO().getUPCKitVO(uniqueId);
		upcKitVo.setQuantity(numQuantity);
		
		if (null != psProdId && 0 != psProdId) {
			CommonBridge.getAddNewCandidateServiceInstance().updateUPCKitComponent(upcKitVo);
		}
		
		UPCKitVO retUpcKitVO = this.getForm().getProductVO().updateUPCKitVO(upcKitVo);

		// PIM-1527 update list cost
		List<UPCKitVO> upcKitVOList = this.getForm().getProductVO().getUpcKitVOs();
		int psWorkId = this.getForm().getProductVO().getWorkRequest().getWorkIdentifier();
		CommonBridge.getAddNewCandidateServiceInstance().updateListCostKit(upcKitVOList, psWorkId);
		return retUpcKitVO;
	}
	
	/**
	 * Get the generated UPC for Kit components.
	 * 
	 * @return the generated kitupc
	 * @throws Exception
	 */
	public String generateKITUPC() throws Exception {
		String returnString = CommonBridge.getAddNewCandidateServiceInstance()
				.getGeneratedKITUPC();
		int checkDigit = CPSHelper.calculateCheckDigit(returnString);
		returnString = returnString + "," + checkDigit;
		return returnString;

	}
}