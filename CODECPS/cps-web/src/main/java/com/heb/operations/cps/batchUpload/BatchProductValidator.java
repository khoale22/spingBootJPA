package com.heb.operations.cps.batchUpload;

import com.heb.operations.cps.util.CPSConstants;
import com.heb.operations.cps.vo.BatchVO;

public class BatchProductValidator {
	/**
	 * Validating the entire row
	 * @param batchVO
	 * @return
	 */
	public boolean validateRow(BatchVO batchVO) {
		  boolean returnValue = false;
    		if ((CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getUnitUPCCheckDigit()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getItemDescription()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getItemDescription()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getItemSizeQty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getReceipSW()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getUpcTypeCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getWhareHouseDSDCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getSellUnitQty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getUnitUOMText()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdDesTag1Eng()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdDesTag2Eng()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getFcDpDeptNo()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getFcDpSubDeptCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdOmiComCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdOmiSubComCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getBuyerCd()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdDeptNo()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdItemCatCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getVdStrPrcGrpCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getStoreNo()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdRetailHT()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdRetailLN()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdRetailWD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getVendorNo()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdVendorCodeNo()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdMastPKQty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdListCST()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCoreUX4Qty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCoreUnitCST()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCoreChangeCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCoreLinkCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCoreMatrixSW()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCritItemCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCorePrepdPCT()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdPrfxForQty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdPrfxPriceCST()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCoreTagCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdTagSZCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdNoTagQty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdCrgTaxQty()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdFdStampCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdFamOneCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdFamTwoCD()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getCstOwnID()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdBrandID()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getT2tID()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getProdSubBrandID()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getCntryOfOrginID()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getComments()))
					&& (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
							.getPackaging()))
				) {
    			
				returnValue = true;
			}
			return returnValue;
		}
	/**
	 * validating the mandatory fields
	 * @param batchVO
	 * @return
	 */
    public String mandatoryFieldCheck(BatchVO batchVO){
    	 StringBuffer returnBuffer = new StringBuffer();
    	 returnBuffer.append(CPSConstants.EMPTY_STRING);
    	 if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
 				.getUnitUPCCheckDigit())) {
    	 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_UPC_NO);
    	 }
    	 if(CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getItemDescription())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_ITEM_DES); 
    	 }
    	 if(CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getItemSizeQty())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_ITM_SZ_QTY); 
    	 }
    	 if(CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getReceipSW())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_RECIP_SW); 
    	 }
    	 if(CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getUpcTypeCD())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_UPC_TYP_CD);
    	 }
    	 if(CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getWhareHouseDSDCD())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_WHSE_DSD_CD);
    	 }
    	 if(CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getSellUnitQty())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_SELL_UNIT_QTY); 
    	 }
    	 if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getUnitUOMText())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_UNIT_UOM_TXT);
    	 }
    	 // Dept & Sub Dept field - Not Mandatory
    	 /***
    	 if (//!batchVO.isVendor() &&
    			 CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO.getFcDpDeptNo())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.FC_DP_DEPT_NO); 
    	 }
    	 if (//!batchVO.isVendor() &&
    			 CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO.getFcDpSubDeptCD())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.FC_DP_SUB_DEPT_CD);
    	 }
    	 **/
    	 if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getProdOmiComCD())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_OMI_COM_CD); 
    	 }
    	 if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getProdOmiSubComCD())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_OMI_SUB_COM_CD);
    	 }
    	 if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
					.getBuyerCd())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PC_OMI_BUYER_CD); 
    	 }
    	 if (!batchVO.isVendor() && 
    			 CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO.getProdDeptNo())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_PSS_DEPT_NO);
    	 }
    	 if (!batchVO.isVendor() && 
    			 CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO.getProdItemCatCD())){
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_ITM_CAT_CD); 
    	 }
    	 if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO.getVendorNo())) {
    		 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.VD_VEND_NO);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdVendorCodeNo())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_VEND_PROD_CD_NO);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdMastPKQty())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_MAST_PK_QTY);
		}
		if (CPSConstants.EMPTY_STRING
				.equalsIgnoreCase(batchVO.getProdListCST())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_LIST_CST);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdCoreChangeCD())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_CORE_CHG_CD);
		}
		if (!batchVO.isVendor() &&
				CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO.getProdCritItemCD())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_CRIT_ITEM_CD);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdCoreTagCD())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_CORE_TAG_CD);
		}
		if (CPSConstants.EMPTY_STRING
				.equalsIgnoreCase(batchVO.getProdTagSZCD())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_TAG_SZ_CD);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdNoTagQty())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_NO_TAG_QTY);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdCrgTaxQty())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_CRG_TAX_CD);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getProdFdStampCD())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PD_FD_STAMP_CD);
		}
		if (CPSConstants.EMPTY_STRING.equalsIgnoreCase(batchVO
				.getPackaging())) {
			 returnBuffer.append(CPSConstants.BACK_SLASH).append(CPSConstants.PACKAGING);
		}
		
    	return returnBuffer.toString();
    }
    /**
     * Validating each field in the row (format)
     * @param batchVO
     * @return
     * @throws Exceptions
     */
    public String rowFieldValidator(BatchVO batchVO) throws Exception {
    	BatchFieldValidator batchFieldValidator = new BatchFieldValidator();
    	StringBuffer returnErrorBuffer = new StringBuffer();
    	returnErrorBuffer.append(CPSConstants.EMPTY_STRING);
		String returnUPCValidation = batchFieldValidator.unitUPCValidation(batchVO.getUnitUPCCheckDigit());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnUPCValidation)){
			return returnErrorBuffer.append(returnUPCValidation).toString();
		}
		String returnItemSize = batchFieldValidator.itemSizeQuantityValidation(batchVO.getItemSizeQty());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(returnItemSize)){
			returnErrorBuffer.append(returnItemSize).append(CPSConstants.BACK_SLASH);
		}
		String receipSwitchValidation = batchFieldValidator.receipSwitchValidation(batchVO.getReceipSW());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(receipSwitchValidation)){
			returnErrorBuffer.append(receipSwitchValidation).append(CPSConstants.BACK_SLASH);
		}
		String upcTypeCodeValidation = batchFieldValidator.upcTypeCodeValidation(batchVO.getUpcTypeCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(upcTypeCodeValidation)){
			returnErrorBuffer.append(upcTypeCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String whareHouseCodeValidation= batchFieldValidator.whareHouseCodeValidation(batchVO.getWhareHouseDSDCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(whareHouseCodeValidation)){
			returnErrorBuffer.append(whareHouseCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String sellableCodeValidation = batchFieldValidator.sellableCodeValidation(batchVO.getSellUnitQty());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(sellableCodeValidation)){
			returnErrorBuffer.append(sellableCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String unitUOM = batchFieldValidator.unitUOM(batchVO.getUnitUOMText());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(unitUOM)){
			returnErrorBuffer.append(unitUOM).append(CPSConstants.BACK_SLASH);
		}
		String commodityCodeValidation = batchFieldValidator
				.commodityCodeValidation(batchVO.getProdOmiComCD(), batchVO
						.getBuyerCd());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(commodityCodeValidation)){
			returnErrorBuffer.append(commodityCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String subCommodityCodeValidation = batchFieldValidator.subCommodityCodeValidation(batchVO.getProdOmiSubComCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(subCommodityCodeValidation)){
			returnErrorBuffer.append(subCommodityCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String subBuyerCodeValidation = batchFieldValidator.subBuyerCodeValidation(batchVO.getBuyerCd());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(subBuyerCodeValidation)){
			returnErrorBuffer.append(subBuyerCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String vendorPriceGroupValidation = batchFieldValidator.vendorPriceGroupValidation(batchVO.getVdStrPrcGrpCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(vendorPriceGroupValidation)){
			returnErrorBuffer.append(vendorPriceGroupValidation).append(CPSConstants.BACK_SLASH);
		}
		String storeValidation = batchFieldValidator.storeValidation(batchVO.getStoreNo());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(storeValidation)){
			returnErrorBuffer.append(storeValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodReatilHT = batchFieldValidator.prodReatilHTValidation(batchVO.getProdRetailHT());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodReatilHT)){
			returnErrorBuffer.append(prodReatilHT).append(CPSConstants.BACK_SLASH);
		}
		String prodReatilLN = batchFieldValidator.prodRetailLNValidation(batchVO.getProdRetailLN());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodReatilLN)){
			returnErrorBuffer.append(prodReatilLN).append(CPSConstants.BACK_SLASH);
		}
		String prodReatilWD = batchFieldValidator.prodRetailWDValidation(batchVO.getProdRetailWD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodReatilWD)){
			returnErrorBuffer.append(prodReatilWD).append(CPSConstants.BACK_SLASH);
		}
		String vendorProductCodeValidation = batchFieldValidator.vendorProductCodeValidation(batchVO.getProdVendorCodeNo());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(vendorProductCodeValidation)){
			returnErrorBuffer.append(vendorProductCodeValidation).append(CPSConstants.BACK_SLASH);
		}
		String masterPackQtyValidation = batchFieldValidator.masterPackQtyValidation(batchVO.getProdMastPKQty());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(masterPackQtyValidation)){
			returnErrorBuffer.append(masterPackQtyValidation).append(CPSConstants.BACK_SLASH);
		}
		String listCostValidation = batchFieldValidator.listCostValidation(batchVO.getProdListCST());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(listCostValidation)){
			returnErrorBuffer.append(listCostValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCoreUX4QtyValidation = batchFieldValidator.prodCoreUX4QtyValidation(batchVO.getProdCoreUX4Qty());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreUX4QtyValidation)){
			returnErrorBuffer.append(prodCoreUX4QtyValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCoreUnitCSTValidation = batchFieldValidator.prodCoreUnitCSTValidation(batchVO.getProdCoreUnitCST());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreUnitCSTValidation)){
			returnErrorBuffer.append(prodCoreUnitCSTValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCoreChangeCDValidation = batchFieldValidator.prodCoreChangeCDValidation(batchVO.getProdCoreChangeCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreChangeCDValidation)){
			returnErrorBuffer.append(prodCoreChangeCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCoreLinkCDValidation = batchFieldValidator.prodCoreLinkCDValidation(batchVO.getProdCoreLinkCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreLinkCDValidation)){
			returnErrorBuffer.append(prodCoreLinkCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCoreMatrixSWValidation = batchFieldValidator.prodCoreMatrixSWValidation(batchVO.getProdCoreMatrixSW());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreMatrixSWValidation)){
			returnErrorBuffer.append(prodCoreMatrixSWValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCritItemCDValidation = batchFieldValidator.prodCritItemCDValidation(batchVO.getProdCritItemCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCritItemCDValidation)){
			returnErrorBuffer.append(prodCritItemCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCorePrepdPCTValidation = batchFieldValidator.prodCorePrepdPCTValidation(batchVO.getProdCorePrepdPCT());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCorePrepdPCTValidation)){
			returnErrorBuffer.append(prodCorePrepdPCTValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodPrfxForQtyValidation = batchFieldValidator.prodPrfxForQtyValidation(batchVO.getProdPrfxForQty());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodPrfxForQtyValidation)){
			returnErrorBuffer.append(prodPrfxForQtyValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodPrfxPriceCSTValidation = batchFieldValidator.prodPrfxPriceCSTValidation(batchVO.getProdPrfxPriceCST());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodPrfxPriceCSTValidation)){
			returnErrorBuffer.append(prodPrfxPriceCSTValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCoreTagCDValidation = batchFieldValidator.prodCoreTagCDValidation(batchVO.getProdCoreTagCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCoreTagCDValidation)){
			returnErrorBuffer.append(prodCoreTagCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodTagSZCDValidation = batchFieldValidator.prodTagSZCDValidation(batchVO.getProdTagSZCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodTagSZCDValidation)){
			returnErrorBuffer.append(prodTagSZCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodNoTagQtyValidation = batchFieldValidator.prodNoTagQtyValidation(batchVO.getProdNoTagQty(),batchVO.getProdTagSZCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodNoTagQtyValidation)){
			returnErrorBuffer.append(prodNoTagQtyValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodCrgTaxQtyValidation = batchFieldValidator.prodCrgTaxQtyValidation(batchVO.getProdCrgTaxQty());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodCrgTaxQtyValidation)){
			returnErrorBuffer.append(prodCrgTaxQtyValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodFdStampCDValidation = batchFieldValidator.prodFdStampCDValidation(batchVO.getProdFdStampCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodFdStampCDValidation)){
			returnErrorBuffer.append(prodFdStampCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodFamOneCDValidation = batchFieldValidator.prodFamOneCDValidation(batchVO.getProdFamOneCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodFamOneCDValidation)){
			returnErrorBuffer.append(prodFamOneCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodFamTwoCDValidation = batchFieldValidator.prodFamTwoCDValidation(batchVO.getProdFamTwoCD());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodFamTwoCDValidation)){
			returnErrorBuffer.append(prodFamTwoCDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodBrandIDValidation = batchFieldValidator.prodBrandIDValidation(batchVO.getProdBrandID());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodBrandIDValidation)){
			returnErrorBuffer.append(prodBrandIDValidation).append(CPSConstants.BACK_SLASH);
		}
		String cstOwnIDValidation = batchFieldValidator.cstOwnIDValidation(batchVO.getCstOwnID(),batchVO.getProdBrandID());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(cstOwnIDValidation)){
			returnErrorBuffer.append(cstOwnIDValidation).append(CPSConstants.BACK_SLASH);
		}
		String t2tIDValidation = batchFieldValidator.t2tIDValidation(batchVO.getT2tID(),batchVO.getCstOwnID(),batchVO.getProdBrandID());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(t2tIDValidation)){
			returnErrorBuffer.append(t2tIDValidation).append(CPSConstants.BACK_SLASH);
		}
		String prodSubBrandIDValidation = batchFieldValidator.prodSubBrandIDValidation(batchVO.getProdSubBrandID());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(prodSubBrandIDValidation)){
			returnErrorBuffer.append(prodSubBrandIDValidation).append(CPSConstants.BACK_SLASH);
		}
		String cntryOfOrginIDValidation = batchFieldValidator.cntryOfOrginIDValidation(batchVO.getCntryOfOrginID());
		if(!CPSConstants.EMPTY_STRING.equalsIgnoreCase(cntryOfOrginIDValidation)){
			returnErrorBuffer.append(cntryOfOrginIDValidation).append(CPSConstants.BACK_SLASH);
		}
		return returnErrorBuffer.toString();
    }
	
  
}
