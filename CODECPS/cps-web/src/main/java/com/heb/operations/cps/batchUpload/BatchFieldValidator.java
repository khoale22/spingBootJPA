package com.heb.operations.cps.batchUpload;

import java.util.List;
import java.util.Map;

import com.heb.operations.cps.controller.AddNewCandidateController;
import org.apache.log4j.Logger;

import com.heb.operations.business.framework.vo.BaseJSFVO;
import com.heb.operations.business.framework.vo.ClassCommodityVO;
import com.heb.operations.cps.services.CommonService;
import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.util.CPSHelper;

public class BatchFieldValidator {
    private static final Logger LOG = Logger.getLogger(BatchFieldValidator.class);
    /**
     * Validating whether the UNITUPC is valid,Existing & checkDigit Validation
     * @param unitUPCTemp
     * @return
     * @throws Exception
     */
    public static final String SUCCESS = "Success";
    private CommonService commonService;

    public CommonService getCommonService() {
	return commonService;
    }

    public void setCommonService(CommonService commonService) {
	this.commonService = commonService;
    }

    public String unitUPCValidation(String unitUPCTemp) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	boolean status = false;
	long unitUPCInt;
	int unitUPCTempSize = unitUPCTemp.length();
	String unitUPC = "";
	// Check Whether unitUPC is numeric or not
	try {
	    unitUPCInt = Long.parseLong(unitUPCTemp);
	    if (unitUPCInt < 0) {
		status = true;
		returnBuffer.append("Negative PD_UPC_NO Value ");
		return returnBuffer.toString();
	    }
	} catch (NumberFormatException e) {
	    LOG.error(e.getMessage(), e);
	    status = true;
	    returnBuffer.append("PD_UPC_NO is not a numeric Value");
	    return returnBuffer.toString();
	}
	// Check the size of unitUPC
	if (1 > unitUPCTempSize) {
	    status = true;
	    returnBuffer.append("No Check Digit Value");
	} else if (14 < unitUPCTempSize) {
	    status = true;
	    returnBuffer.append("PD_UPC_NO length is more than 14 digits");
	} else {
	    // CheckDigit Validation
	    unitUPC = unitUPCValue(unitUPCTemp, unitUPCTempSize);
	    String unitUPCCheckDigitTemp = unitUPCCheckDigitValue(unitUPCTemp, unitUPCTempSize);
	    int unitUPCCheckDigitInt = Integer.parseInt(unitUPCCheckDigitTemp);
	    int checkDigit = CPSHelper.calculateCheckDigit(unitUPC);
	    if (unitUPCCheckDigitInt != checkDigit) {
		status = true;
		returnBuffer.append("Check Digit Validation Failed");
	    }
	}
	if (!status) {
	    AddNewCandidateController action = new AddNewCandidateController();// Awesome
								       // piece
								       // of
								       // code..
	    if (!action.checkUPC(unitUPC)) {
		returnBuffer.append("PD_UPC_NO already exists in the database");
	    }
	}
	return returnBuffer.toString();
    }

    public String itemSizeQuantityValidation(String itemSizeQuantity) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int itemSizeQuantityLength = itemSizeQuantity.length();
	if (itemSizeQuantityLength > 6) {
	    returnBuffer.append("PD_ITM_SZ_QTY size is more than 6 characters");
	}
	return returnBuffer.toString();
    }

    // Clarification needed
    public String receipSwitchValidation(String receipSwitch) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int receipSwitchSize = receipSwitch.length();
	if (receipSwitchSize > 1) {
	    returnBuffer.append("PD_RECIP_SW size is more than 1 character");
	} else {
	    if (("9".equalsIgnoreCase(receipSwitch)) || ("0".equalsIgnoreCase(receipSwitch))) {
	    } else if (("1".equalsIgnoreCase(receipSwitch)) || ("6".equalsIgnoreCase(receipSwitch)) || ("7".equalsIgnoreCase(receipSwitch)) || ("F".equalsIgnoreCase(receipSwitch))
		    || ("T".equalsIgnoreCase(receipSwitch))) {
		returnBuffer.append("Cannot upload Non-Sellable Product Type. Please change PD_RECIP_SW value");
	    } else {
		returnBuffer.append("PD_RECIP_SW is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // Clarification needed
    public String upcTypeCodeValidation(String upcTypeCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int upcTypeCodeSize = upcTypeCode.length();
	if (upcTypeCodeSize > 1) {
	    returnBuffer.append("PD_UPC_TYP_CD size is more than 1 character");
	} else {
	    if (("B".equalsIgnoreCase(upcTypeCode)) || ("H".equalsIgnoreCase(upcTypeCode)) || ("C".equalsIgnoreCase(upcTypeCode)) || ("P".equalsIgnoreCase(upcTypeCode))
		    || ("S".equalsIgnoreCase(upcTypeCode)) || ("R".equalsIgnoreCase(upcTypeCode))) {
	    } else {
		returnBuffer.append("PD_UPC_TYP_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    public String whareHouseCodeValidation(String whareHouseCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int whareHouseCodeSize = whareHouseCode.length();
	if (whareHouseCodeSize > 1) {
	    returnBuffer.append("PD_WHSE_DSD_CD size is more than 1 character");
	} else {
	    if (("D".equalsIgnoreCase(whareHouseCode)) || ("W".equalsIgnoreCase(whareHouseCode))) {
	    } else {
		returnBuffer.append("PD_WHSE_DSD_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // UNIT SIZE
    public String sellableCodeValidation(String sellableCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int sellableCodeFloatSize = sellableCode.length();
	float sellableCodeFloat;
	try {
	    sellableCodeFloat = Float.parseFloat(sellableCode);
	    if (sellableCodeFloat < 0) {
		returnBuffer.append("Negative PD_SELL_UNIT_QTY Value ");
	    } else if (sellableCodeFloatSize > 10) {
		returnBuffer.append("PD_SELL_UNIT_QTY size is more than 9 characters ");
	    }
	} catch (NumberFormatException e) {
	    LOG.error(e.getMessage(), e);
	    returnBuffer.append("PD_SELL_UNIT_QTY is not a Float Value");
	}
	return returnBuffer.toString();
    }

    public String unitUOM(String unitUOMCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int unitUOMCodeSize = unitUOMCode.length();
	if (unitUOMCodeSize > 5) {
	    returnBuffer.append("PD_UNIT_UOM_TXT size is more than 5 characters");
	} else {
	    String uomValidation = uomValidation(unitUOMCode);
	    if (!SUCCESS.equalsIgnoreCase(uomValidation)) {
		returnBuffer.append("PD_UNIT_UOM_TXT is not a valid Value");
	    }
	}
	return returnBuffer.toString();
    }

    private String uomValidation(String unitUOMCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	String id = CPSConstants.EMPTY_STRING;
	AddNewCandidateController action = new AddNewCandidateController();
	List<BaseJSFVO> list = action.getUnitOfMeasureListForBatch();
	for (BaseJSFVO baseJSFVO : list) {
	    id = CPSHelper.getTrimmedValue(baseJSFVO.getName());
	    if (id.equalsIgnoreCase(CPSHelper.getTrimmedValue(unitUOMCode))) {
		returnBuffer.append(SUCCESS);
		break;
	    }
	    id = CPSConstants.EMPTY_STRING;
	}
	return returnBuffer.toString();
    }

    public String commodityCodeValidation(String commodityCode, String buyerCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int commodityCodeInt;
	int commodityCodeSize = commodityCode.length();
	boolean status = false;
	if (commodityCodeSize > 5) {
	    status = true;
	    returnBuffer.append("PD_OMI_COM_CD size is more than 5 characters");
	}
	if (!status) {
	    try {
		commodityCodeInt = Integer.parseInt(commodityCode);
		if (commodityCodeInt < 0) {
		    // status = true;
		    returnBuffer.append("Negative PD_OMI_COM_CD Value");
		} else {
		    // DB Checking for class and class description
		    String checkMessage = getClassCode(commodityCode, buyerCode);
		    if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(checkMessage)) {
			returnBuffer.append(checkMessage);
		    }
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_OMI_COM_CD is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    private String getClassCode(String commodityCode, String buyerCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	commodityCode = CPSHelper.getTrimmedValue(commodityCode);
	if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(subBuyerCodeValidation(buyerCode))) {
	    String bdm = CPSHelper.getTrimmedValue(buyerCode);
	    if (bdm.length() < 2) {
		bdm = "0" + bdm;
	    }
	    Map<String, ClassCommodityVO> map = getCommonService().getCommoditiesForBDM(bdm);
	    ClassCommodityVO scale = map.get(commodityCode);
	    if (null == scale) {
		returnBuffer.append("Problem in Fetching CLASS CODE due to invalid combination of PD_OMI_COM_CD and PC_OMI_BUYER_CD");
	    }
	}
	return returnBuffer.toString();
    }

    // DB Validation required
    public String subCommodityCodeValidation(String subCommodityCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int subCommodityCodeInt;
	int subCommodityCodeSize = subCommodityCode.length();
	boolean status = false;
	if (subCommodityCodeSize > 5) {
	    status = true;
	    returnBuffer.append("PD_OMI_SUB_COM_CD size is more than 5 characters");
	}
	if (!status) {
	    try {
		subCommodityCodeInt = Integer.parseInt(subCommodityCode);
		if (subCommodityCodeInt < 0) {

		    returnBuffer.append("Negative PD_OMI_SUB_COM_CD Value");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_OMI_SUB_COM_CD is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // DB Validation required
    public String subBuyerCodeValidation(String buyerCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int buyerCodeInt;
	int buyerCodeSize = buyerCode.length();
	boolean status = false;
	if (buyerCodeSize > 3) {
	    status = true;
	    returnBuffer.append("PC_OMI_BUYER_CD size is more than 3 characters");
	}
	if (!status) {
	    try {
		buyerCodeInt = Integer.parseInt(buyerCode);
		if (buyerCodeInt < 0) {
		    returnBuffer.append("Negative PC_OMI_BUYER_CD Value");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PC_OMI_BUYER_CD is not a numeric Value");
		return returnBuffer.toString();
	    }
	}
	return returnBuffer.toString();
    }

    public String vendorPriceGroupValidation(String priceGroup) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != priceGroup && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(priceGroup)) {
	    int priceGroupSize = priceGroup.length();
	    int priceGroupInt;
	    boolean status = false;
	    if (priceGroupSize > 3) {
		status = true;
		returnBuffer.append("VD_STR_PRC_GRP_CD size is more than 3 characters");
	    }
	    if (!status) {
		try {
		    priceGroupInt = Integer.parseInt(priceGroup);
		    if (priceGroupInt < 0) {
			returnBuffer.append("Negative VD_STR_PRC_GRP_CD Value");
		    }
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("VD_STR_PRC_GRP_CD is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // Final---- Validation required
    public String storeValidation(String storeGroup) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != storeGroup && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(storeGroup)) {
	    int storeGroupLength = storeGroup.length();
	    int storeGroupInt;
	    boolean status = false;
	    if (storeGroupLength > 5) {
		status = true;
		returnBuffer.append("FC_STORE_NO size is more than 5 characters");
	    }
	    if (!status) {
		try {
		    storeGroupInt = Integer.parseInt(storeGroup);
		    if (storeGroupInt < 0) {
			returnBuffer.append("Negative FC_STORE_NO Value");
		    }
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("FC_STORE_NO is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // UPC Height
    public String prodReatilHTValidation(String prodRetailHT) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodRetailHTSize = prodRetailHT.length();
	if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodRetailHT)) {
	    // int prodRetailHTLength = prodRetailHT.length();
	    float prodRetailHTInt;
	    try {
		prodRetailHTInt = Float.parseFloat(prodRetailHT);
		if (prodRetailHTInt < 0) {
		    returnBuffer.append("Negative PD_RETL_HT Value");
		} else if (prodRetailHTSize > 5) {
		    returnBuffer.append("PD_RETL_HT size is more than 5 characters");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_RETL_HT is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // UPC Length
    public String prodRetailLNValidation(String prodRetailLN) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodRetailLNSize = prodRetailLN.length();
	if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodRetailLN)) {
	    // int prodRetailLNLength = prodRetailLN.length();
	    try {
		float prodRetailLNInt = Float.parseFloat(prodRetailLN);
		if (prodRetailLNInt < 0) {
		    returnBuffer.append("Negative PD_RETL_LN Value");
		} else if (prodRetailLNSize > 5) {
		    returnBuffer.append("PD_RETL_LN size is more than 5 characters");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_RETL_LN is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // UPC Width
    public String prodRetailWDValidation(String prodRetailWD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	// int prodRetailWDSize = prodRetailWD.length();
	if (null != prodRetailWD && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodRetailWD)) {
	    int prodRetailWDLength = prodRetailWD.length();
	    float prodRetailWDInt;
	    try {
		prodRetailWDInt = Float.parseFloat(prodRetailWD);
		if (prodRetailWDInt < 0) {
		    returnBuffer.append("Negative PD_RETL_WD Value");
		} else if (prodRetailWDLength > 5) {
		    returnBuffer.append("PD_RETL_WD size is more than 5 characters");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_RETL_WD is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // Vendor No - Database validation needed
    public String vendorNoValidation(String vendorNumber) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int vendorNumberLength = vendorNumber.length();
	int vendorNumberInt;
	boolean status = false;
	if (vendorNumberLength > 9) {
	    status = true;
	    returnBuffer.append("VD_VEND_NO size is more than 9 characters");
	}
	if (!status) {
	    try {
		vendorNumberInt = Integer.parseInt(vendorNumber);
		if (vendorNumberInt < 0) {
		    returnBuffer.append("Negative VD_VEND_NO Value");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("VD_VEND_NO is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // Vendor product code (VPC)
    public String vendorProductCodeValidation(String vendorProductCode) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int vendorProductCodeLength = vendorProductCode.length();
	if (vendorProductCodeLength > 13) {
	    returnBuffer.append("PD_VEND_PROD_CD_NO size is more than 13 characters");
	}
	return returnBuffer.toString();
    }

    // Master Pack Quantity
    public String masterPackQtyValidation(String masterPackQty) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int masterPackQtyLength = masterPackQty.length();
	int masterPackQtyInt;
	boolean status = false;
	if (masterPackQtyLength > 5) {
	    status = true;
	    returnBuffer.append("PD_MAST_PK_QTY size is more than 5 characters");
	}
	if (!status) {
	    try {
		masterPackQtyInt = Integer.parseInt(masterPackQty);
		if (masterPackQtyInt < 0) {
		    returnBuffer.append("Negative PD_MAST_PK_QTY Value");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_MAST_PK_QTY is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // List Cost Validation
    public String listCostValidation(String listCost) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int listCostLength = listCost.length();
	float listCostFloat;
	try {
	    listCostFloat = Float.parseFloat(listCost);
	    if (listCostFloat < 0) {
		returnBuffer.append("Negative PD_LIST_CST Value");
	    } else if (listCostLength > 11) {
		returnBuffer.append("PD_LIST_CST size is more than 11 characters");
	    }
	} catch (NumberFormatException e) {
	    LOG.error(e.getMessage(), e);
	    returnBuffer.append("PD_LIST_CST is not a numeric Value");
	}
	return returnBuffer.toString();
    }

    // PD_CORE_UX4_QTY Length
    public String prodCoreUX4QtyValidation(String prodCoreUX4Qty) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodCoreUX4Qty && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreUX4Qty)) {
	    int prodCoreUX4QtyLength = prodCoreUX4Qty.length();
	    int prodCoreUX4QtyInt;
	    boolean status = false;
	    if (prodCoreUX4QtyLength > 9) {
		status = true;
		returnBuffer.append("PD_CORE_UX4_QTY size is more than 9 characters");
	    }
	    if (!status) {
		try {
		    prodCoreUX4QtyInt = Integer.parseInt(prodCoreUX4Qty);
		    if (prodCoreUX4QtyInt < 0) {
			returnBuffer.append("Negative PD_CORE_UX4_QTY Value");
		    }
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("PD_CORE_UX4_QTY is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // PD_CORE_UNIT_CST Length
    public String prodCoreUnitCSTValidation(String prodCoreUnitCST) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodCoreUnitCSTSize = prodCoreUnitCST.length();
	if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreUnitCST)) {
	    float prodCoreUnitCSTInt;
	    try {
		prodCoreUnitCSTInt = Float.parseFloat(prodCoreUnitCST);
		if (prodCoreUnitCSTInt < 0) {
		    returnBuffer.append("Negative PD_CORE_UNIT_CST Value");
		} else if (prodCoreUnitCSTSize > 10) {
		    returnBuffer.append("PD_CORE_UX4_QTY size is more than 10 characters");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_CORE_UNIT_CST is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_CORE_UNIT_CST Length
    public String prodCoreChangeCDValidation(String prodCoreChangeCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodCoreChangeCDLength = prodCoreChangeCD.length();
	if (prodCoreChangeCDLength > 1) {
	    returnBuffer.append("PD_CORE_CHG_CD size is more than 1 character");
	}
	return returnBuffer.toString();
    }

    // PD_CORE_LINK_CD Length
    public String prodCoreLinkCDValidation(String prodCoreLinkCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodCoreLinkCD && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreLinkCD)) {
	    int prodCoreLinkCDLength = prodCoreLinkCD.length();
	    int prodCoreLinkCDInt;
	    boolean status = false;
	    if (prodCoreLinkCDLength > 7) {
		status = true;
		returnBuffer.append("PD_CORE_LINK_CD size is more than 7 characters");
	    }
	    if (!status) {
		try {
		    prodCoreLinkCDInt = Integer.parseInt(prodCoreLinkCD);
		    if (prodCoreLinkCDInt < 0) {
			returnBuffer.append("Negative PD_CORE_LINK_CD Value");
		    }
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("PD_CORE_LINK_CD is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // PD_CORE_MATRX_SW Length
    public String prodCoreMatrixSWValidation(String prodCoreMatrixSW) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodCoreMatrixSW && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreMatrixSW)) {
	    if (prodCoreMatrixSW.length() > 1) {
		returnBuffer.append("PD_CORE_MATRX_SW size is more than 1 character");
	    } else {
		if ((("X").equalsIgnoreCase(prodCoreMatrixSW)) || (("").equalsIgnoreCase(prodCoreMatrixSW))) {
		} else {
		    returnBuffer.append("PD_CORE_MATRX_SW is not a valid data");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // PD_CRIT_ITEM_CD Length
    public String prodCritItemCDValidation(String prodCritItemCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);

	if (prodCritItemCD == null || CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCritItemCD)) {
	    return CPSConstants.EMPTY_STRING;
	}

	if (prodCritItemCD.length() > 1) {
	    returnBuffer.append("PD_CRIT_ITEM_CD size is more than 1 character");
	} else {
	    if ((("N").equalsIgnoreCase(prodCritItemCD)) || (("S").equalsIgnoreCase(prodCritItemCD)) || (("P").equalsIgnoreCase(prodCritItemCD)) || (("B").equalsIgnoreCase(prodCritItemCD))) {
	    } else {
		returnBuffer.append("PD_CRIT_ITEM_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_CORE_PREPD_PCT Length
    public String prodCorePrepdPCTValidation(String prodCorePrepdPCT) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodCorePrepdPCT && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCorePrepdPCT)) {
	    int prodCorePrepdPCTLength = prodCorePrepdPCT.length();
	    float prodCorePrepdPCTInt;
	    boolean status = false;
	    if (prodCorePrepdPCTLength > 4) {
		status = true;
		returnBuffer.append("PD_CORE_PREPD_PCT size is more than 4 characters");
	    }
	    if (!status) {
		try {
		    prodCorePrepdPCTInt = Float.parseFloat(prodCorePrepdPCT);
		    if (prodCorePrepdPCTInt < 0) {
			returnBuffer.append("Negative PD_CORE_PREPD_PCT Value");
		    }
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("PD_CORE_PREPD_PCT is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // PD_PRFX_XFOR_QTY Length
    public String prodPrfxForQtyValidation(String prodPrfxForQty) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodPrfxForQty && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodPrfxForQty)) {
	    int prodPrfxForQtyLength = prodPrfxForQty.length();
	    int prodPrfxForQtyInt;
	    boolean status = false;
	    if (prodPrfxForQtyLength > 9) {
		status = true;
		returnBuffer.append("PD_PRFX_XFOR_QTY size is more than 9 characters");
	    }
	    if (!status) {
		try {
		    prodPrfxForQtyInt = Integer.parseInt(prodPrfxForQty);
		    if (prodPrfxForQtyInt < 0) {
			returnBuffer.append("Negative PD_PRFX_XFOR_QTY Value");
		    }
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("PD_PRFX_XFOR_QTY is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // PD_PRFX_PRICE_CST Length
    public String prodPrfxPriceCSTValidation(String prodPrfxPriceCST) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodPrfxPriceCSTLength = prodPrfxPriceCST.length();
	if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodPrfxPriceCST)) {

	    float prodPrfxPriceCSTInt;
	    try {
		prodPrfxPriceCSTInt = Float.parseFloat(prodPrfxPriceCST);
		if (prodPrfxPriceCSTInt < 0) {
		    returnBuffer.append("Negative PD_PRFX_PRICE_CST Value");
		} else if (prodPrfxPriceCSTLength > 10) {
		    returnBuffer.append("PD_PRFX_PRICE_CST size is more than 10 character");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_PRFX_PRICE_CST is not a numeric Value");
	    }

	}
	return returnBuffer.toString();
    }

    // PD_CORE_TAG_CD Length
    public String prodCoreTagCDValidation(String prodCoreTagCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (prodCoreTagCD.length() > 1) {
	    returnBuffer.append("PD_CORE_TAG_CD size is more than 1 character");
	} else {
	    if ((("A").equalsIgnoreCase(prodCoreTagCD)) || (("I").equalsIgnoreCase(prodCoreTagCD))) {
	    } else {
		returnBuffer.append("PD_CORE_TAG_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_TAG_SZ_CD Length
    public String prodTagSZCDValidation(String prodTagSZCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (prodTagSZCD.length() > 1) {
	    returnBuffer.append("PD_TAG_SZ_CD size is more than 1 character");
	} else {
	    if ((("0").equalsIgnoreCase(prodTagSZCD)) || (("1").equalsIgnoreCase(prodTagSZCD)) || (("2").equalsIgnoreCase(prodTagSZCD)) || (("5").equalsIgnoreCase(prodTagSZCD))
		    || (("6").equalsIgnoreCase(prodTagSZCD))) {
	    } else {
		returnBuffer.append("PD_TAG_SZ_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_NO_TAG_QTY Length
    public String prodNoTagQtyValidation(String prodNoTagQty, String prodTagSZCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodNoTagQtyLength = prodNoTagQty.length();
	int prodNoTagQtyInt;
	boolean status = false;
	if (prodNoTagQtyLength > 3) {
	    status = true;
	    returnBuffer.append("PD_NO_TAG_QTY size is more than 3 characters");
	}
	if (!status) {
	    try {
		prodNoTagQtyInt = Integer.parseInt(prodNoTagQty);
		if (prodNoTagQtyInt < 0) {
		    returnBuffer.append("Negative PD_NO_TAG_QTY Value");
		} else if (("0").equalsIgnoreCase(prodTagSZCD)) {
		    if (prodNoTagQtyInt != 0) {
			returnBuffer.append("PD_NO_TAG_QTY value should be Zero (Based on PD_TAG_SZ_CD Value)");
		    }
		} else if (prodNoTagQtyInt < 1) {
		    returnBuffer.append("PD_NO_TAG_QTY value should be greater than ONE");
		} else if (prodNoTagQtyInt > 74) {
		    returnBuffer.append("PD_NO_TAG_QTY value should be less than SEVENTY FOUR");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PD_NO_TAG_QTY is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_CRG_TAX_CD Length
    public String prodCrgTaxQtyValidation(String prodCrgTaxQty) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (prodCrgTaxQty.length() > 1) {
	    returnBuffer.append("PD_CRG_TAX_CD size is more than 1 character");
	} else {
	    if ((("Y").equalsIgnoreCase(prodCrgTaxQty)) || (("N").equalsIgnoreCase(prodCrgTaxQty))) {
	    } else {
		returnBuffer.append("PD_CRG_TAX_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_FD_STAMP_CD Length
    public String prodFdStampCDValidation(String prodFdStampCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (prodFdStampCD.length() > 1) {
	    returnBuffer.append("PD_FD_STAMP_CD size is more than 1 character");
	} else {
	    if ((("Y").equalsIgnoreCase(prodFdStampCD)) || (("N").equalsIgnoreCase(prodFdStampCD))) {
	    } else {
		returnBuffer.append("PD_FD_STAMP_CD is not a valid data");
	    }
	}
	return returnBuffer.toString();
    }

    // PD_FAM_ONE_CD Length
    public String prodFamOneCDValidation(String prodFamOneCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodFamOneCD && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodFamOneCD) && !CPSConstants.ZERO_STRING.equalsIgnoreCase(prodFamOneCD)) { // Fix
																			     // 1202
	    int prodFamOneCDLength = prodFamOneCD.length();
	    int prodFamOneCDInt;
	    boolean status = false;
	    if (prodFamOneCDLength > 3) {
		status = true;
		returnBuffer.append("PD_FAM_ONE_CD size is more than 3 characters");
	    }
	    if (!status) {
		try {
		    prodFamOneCDInt = Integer.parseInt(prodFamOneCD);
		    if (prodFamOneCDInt < 0) {
			returnBuffer.append("Negative PD_FAM_ONE_CD Value");
		    } /*
		       * else if(prodFamOneCDInt < 100){ returnBuffer.append(
		       * "PD_FAM_ONE_CD Value should be greater than 100"); }
		       */
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("PD_FAM_ONE_CD is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // PD_FAM_TWO_CD Length
    public String prodFamTwoCDValidation(String prodFamOneCD) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != prodFamOneCD && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodFamOneCD) && !CPSConstants.ZERO_STRING.equalsIgnoreCase(prodFamOneCD)) {
	    int prodFamOneCDLength = prodFamOneCD.length();
	    int prodFamOneCDInt;
	    boolean status = false;
	    if (prodFamOneCDLength > 3) {
		status = true;
		returnBuffer.append("PD_FAM_TWO_CD size is more than 3 characters");
	    }
	    if (!status) {
		try {
		    prodFamOneCDInt = Integer.parseInt(prodFamOneCD);
		    if (prodFamOneCDInt < 0) {
			returnBuffer.append("Negative PD_FAM_TWO_CD Value");
		    } /*
		       * else if(prodFamOneCDInt < 100){ returnBuffer.append(
		       * "PD_FAM_TWO_CD Value should be greater than 100"); }
		       */
		} catch (NumberFormatException e) {
		    LOG.error(e.getMessage(), e);
		    returnBuffer.append("PD_FAM_TWO_CD is not a numeric Value");
		}
	    }
	}
	return returnBuffer.toString();
    }

    // CST_OWN_ID Length
    public String cstOwnIDValidation(String cstOwnID, String prodBrandID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != cstOwnID && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(cstOwnID)) {
	    int cstOwnIDInt;
	    try {
		cstOwnIDInt = Integer.parseInt(cstOwnID);
		if (cstOwnIDInt < 0) {
		    returnBuffer.append("Negative CST_OWN_ID Value");
		} else {
		    String cstOwnValidation = cstOwnValidation(cstOwnID, prodBrandID);
		    if (!SUCCESS.equalsIgnoreCase(cstOwnValidation)) {
			returnBuffer.append("CST_OWN_ID is not a valid Value for the specified PROD_BRND_ID");
		    }
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("CST_OWN_ID is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // To check the specified cost-owner value is valid for the brand-Id
    private String cstOwnValidation(String cstOwnID, String prodBrandID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	String id = CPSConstants.EMPTY_STRING;
	if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodBrandIDValidation(prodBrandID))) {
		AddNewCandidateController action = new AddNewCandidateController();
	    List<BaseJSFVO> list = action.getCostOwnerForBatch(prodBrandID);
	    for (BaseJSFVO baseJSFVO : list) {
		id = CPSHelper.getTrimmedValue(baseJSFVO.getId());
		if (id.equalsIgnoreCase(CPSHelper.getTrimmedValue(cstOwnID))) {
		    returnBuffer.append(SUCCESS);
		    break;
		}
		id = CPSConstants.EMPTY_STRING;
	    }
	}
	return returnBuffer.toString();
    }

    // PROD_BRND_ID Length
    public String prodBrandIDValidation(String prodBrandID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodBrandIDLength = prodBrandID.length();
	if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodBrandID)) {
	    int prodBrandIDInt;
	    try {
		prodBrandIDInt = Integer.parseInt(prodBrandID);
		if (prodBrandIDInt < 0) {
		    returnBuffer.append("Negative PROD_BRND_ID Value");
		} else if (prodBrandIDLength > 10) {
		    returnBuffer.append("PROD_BRND_ID size is more than 10 characters");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PROD_BRND_ID is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // T2T_ID Length
    public String t2tIDValidation(String t2tID, String cstOwnID, String prodBrandID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != t2tID && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(t2tID)) {
	    int t2tIDInt;
	    try {
		t2tIDInt = Integer.parseInt(t2tID);
		if (t2tIDInt < 0) {
		    returnBuffer.append("Negative T2T_ID Value");
		} else {
		    String t2tValidation = t2tValidation(t2tID, cstOwnID, prodBrandID);
		    if (!SUCCESS.equalsIgnoreCase(t2tValidation)) {
			returnBuffer.append("T2T_ID is not a valid Value for the specified CST_OWN_ID");
		    }
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("T2T_ID is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // To check the specified Top-to-Top value is valid for the CostOwner
    private String t2tValidation(String t2tid, String cstOwnID, String prodBrandID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	String id = CPSConstants.EMPTY_STRING;
	if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(cstOwnIDValidation(cstOwnID, prodBrandID))) {
		AddNewCandidateController action = new AddNewCandidateController();
	    List<BaseJSFVO> list = action.getToptoTopForBatch(cstOwnID);
	    for (BaseJSFVO baseJSFVO : list) {
		id = CPSHelper.getTrimmedValue(baseJSFVO.getId());
		if (id.equalsIgnoreCase(CPSHelper.getTrimmedValue(t2tid))) {
		    returnBuffer.append(SUCCESS);
		    break;
		}
		id = CPSConstants.EMPTY_STRING;
	    }
	}
	return returnBuffer.toString();
    }

    // PROD_SUB_BRND_ID Length
    public String prodSubBrandIDValidation(String prodSubBrandID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	int prodSubBrandIDLength = prodSubBrandID.length();
	if (!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodSubBrandID)) {
	    int prodSubBrandIDInt;
	    try {
		prodSubBrandIDInt = Integer.parseInt(prodSubBrandID);
		if (prodSubBrandIDInt < 0) {
		    returnBuffer.append("Negative PROD_SUB_BRND_ID Value");
		} else if (prodSubBrandIDLength > 10) {
		    returnBuffer.append("PROD_SUB_BRND_ID size is more than 3 characters");
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("PROD_SUB_BRND_ID is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    // CNTRY_OF_ORIG_ID Length
    public String cntryOfOrginIDValidation(String cntryOfOrginID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	if (null != cntryOfOrginID && !CPSConstants.EMPTY_STRING.equalsIgnoreCase(cntryOfOrginID)) {
	    int cntryOfOrginIDInt;
	    try {
		cntryOfOrginIDInt = Integer.parseInt(cntryOfOrginID);
		if (cntryOfOrginIDInt < 0) {
		    returnBuffer.append("Negative CNTRY_OF_ORIG_ID Value");
		} else {
		    String countryValidation = countryValidation(cntryOfOrginID);
		    if (!SUCCESS.equalsIgnoreCase(countryValidation)) {
			returnBuffer.append("CNTRY_OF_ORIG_ID is not a valid Value");
		    }
		}
	    } catch (NumberFormatException e) {
		LOG.error(e.getMessage(), e);
		returnBuffer.append("CNTRY_OF_ORIG_ID is not a numeric Value");
	    }
	}
	return returnBuffer.toString();
    }

    private String countryValidation(String cntryOfOrginID) throws Exception {
	StringBuffer returnBuffer = new StringBuffer();
	returnBuffer.append(CPSConstants.EMPTY_STRING);
	String id = CPSConstants.EMPTY_STRING;
		AddNewCandidateController action = new AddNewCandidateController();
	List<BaseJSFVO> list = action.getCountryOfOrigin();
	for (BaseJSFVO baseJSFVO : list) {
	    id = CPSHelper.getTrimmedValue(baseJSFVO.getId());
	    if (id.equalsIgnoreCase(CPSHelper.getTrimmedValue(cntryOfOrginID))) {
		returnBuffer.append(SUCCESS);
		break;
	    }
	    id = CPSConstants.EMPTY_STRING;
	}
	return returnBuffer.toString();
    }

    /**
     * Taking the UnitUPC Value.
     * @param unitUPCCheckDigit
     * @return
     */
    private String unitUPCValue(String unitUPCCheckDigit, int unitUPCCheckDigitSize) {
	return unitUPCCheckDigit.substring(0, unitUPCCheckDigitSize - 1);
    }

    /**
     * Taking the UnitUPCCheckDigit Value.
     * @param unitUPCCheckDigit
     * @param unitUPCCheckDigitSize
     * @return
     */
    private String unitUPCCheckDigitValue(String unitUPCCheckDigit, int unitUPCCheckDigitSize) {
	return unitUPCCheckDigit.substring(unitUPCCheckDigitSize - 1, unitUPCCheckDigitSize);
    }

}
